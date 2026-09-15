package com.startupstack.app.modules.reports.service;

import com.startupstack.app.modules.authors.entity.AuthorEntity;
import com.startupstack.app.modules.authors.repository.AuthorRepository;
import com.startupstack.app.modules.books.entity.BookEntity;
import com.startupstack.app.modules.books.repository.BookRepository;
import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.descriptors.entity.ResEntity;
import com.startupstack.app.modules.descriptors.repository.ResRepository;
import com.startupstack.app.modules.reports.dto.ColumnMeta;
import com.startupstack.app.modules.reports.dto.TemplateExecutionResponse;
import com.startupstack.app.modules.reports.entity.ReportTemplateEntity;
import com.startupstack.app.modules.reports.repository.ReportTemplateRepository;
import com.startupstack.app.shared.exception.ReportGenerationException;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRMapCollectionDataSource;
import net.sf.jasperreports.engine.design.JRDesignBand;
import net.sf.jasperreports.engine.design.JRDesignExpression;
import net.sf.jasperreports.engine.design.JRDesignField;
import net.sf.jasperreports.engine.design.JRDesignLine;
import net.sf.jasperreports.engine.design.JRDesignSection;
import net.sf.jasperreports.engine.design.JRDesignStaticText;
import net.sf.jasperreports.engine.design.JRDesignTextField;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.pdf.JRPdfExporter;
import net.sf.jasperreports.engine.type.HorizontalTextAlignEnum;
import net.sf.jasperreports.engine.type.ModeEnum;
import net.sf.jasperreports.engine.type.VerticalTextAlignEnum;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * Generates PDF reports for the 15 legacy Crystal Reports equivalents.
 *
 * Supported reportType values:
 *   "book-catalogue"   – BOOK + main + AUTHER (publisher), landscape A4
 *   "resource-result"  – RES + AUTHER + main, portrait A4
 *   "general-1" … "general-13" – driven by bnkout template row(s) for OUT_NUM N
 */
@Service
public class ReportGeneratorService {

    // A4 portrait
    private static final int PAGE_W_P  = 595;
    private static final int PAGE_H_P  = 842;
    // A4 landscape
    private static final int PAGE_W_L  = 842;
    private static final int PAGE_H_L  = 595;

    private static final int MARGIN     = 25;
    private static final int CONTENT_W_P = PAGE_W_P - MARGIN * 2;   // 545
    private static final int CONTENT_W_L = PAGE_W_L - MARGIN * 2;   // 792

    private static final int TITLE_H  = 40;
    private static final int HEADER_H = 22;
    private static final int ROW_H    = 18;

    private static final Color TITLE_BG  = new Color(0x1a, 0x5f, 0x91);
    private static final Color HEADER_BG = new Color(0xd0, 0xe8, 0xf5);
    private static final Color HEADER_FG = new Color(0x1a, 0x3a, 0x55);
    private static final Color RULE_CLR  = new Color(0x9e, 0xb8, 0xd4);

    private static final DateTimeFormatter DATE_FMT = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    private final BookRepository           bookRepository;
    private final CatalogueRepository      catalogueRepository;
    private final AuthorRepository         authorRepository;
    private final ResRepository            resRepository;
    private final ReportTemplateRepository reportTemplateRepository;
    private final TemplateExecutionService templateExecutionService;

    public ReportGeneratorService(BookRepository bookRepository,
                                  CatalogueRepository catalogueRepository,
                                  AuthorRepository authorRepository,
                                  ResRepository resRepository,
                                  ReportTemplateRepository reportTemplateRepository,
                                  TemplateExecutionService templateExecutionService) {
        this.bookRepository           = bookRepository;
        this.catalogueRepository      = catalogueRepository;
        this.authorRepository         = authorRepository;
        this.resRepository            = resRepository;
        this.reportTemplateRepository = reportTemplateRepository;
        this.templateExecutionService = templateExecutionService;
    }

    /**
     * Entry point. reportType must be one of: "book-catalogue", "resource-result",
     * "general-1" … "general-13".  params is passed through for optional filters.
     *
     * @return PDF bytes ready to be sent as application/pdf response
     */
    @Transactional(readOnly = true)
    public byte[] generateReport(String reportType, Map<String, Object> params) {
        try {
            return switch (reportType) {
                case "book-catalogue"  -> bookCatalogue(params);
                case "resource-result" -> resourceResult(params);
                case "dynamic"         -> dynamicReport(params);
                default -> {
                    if (reportType.startsWith("general-")) {
                        int num = Integer.parseInt(reportType.substring(8));
                        if (num < 1 || num > 13) {
                            throw new ResourceNotFoundException(
                                    "General report number must be 1–13, got: " + num);
                        }
                        yield general(num, params);
                    }
                    throw new ResourceNotFoundException("Unknown report type: " + reportType);
                }
            };
        } catch (ResourceNotFoundException e) {
            throw e;
        } catch (Exception e) {
            throw new ReportGenerationException(
                    "Failed to generate report '" + reportType + "'", e);
        }
    }

    // =========================================================================
    // book-catalogue  (landscape A4)
    //   BOOK ──(BK_APP_NO = MN_APP_NO)──> main
    //   BOOK ──(BK_PBLSHR = AUT_NO)─────> AUTHER  (publisher is an author entity)
    // =========================================================================
    private byte[] bookCatalogue(Map<String, Object> params) throws JRException {
        // JOIN FETCH avoids N+1 on catalogue (OneToOne LAZY)
        List<BookEntity> books = bookRepository.findAllWithCatalogue();

        // Batch-load all referenced publisher authors in one query
        Set<Double> publisherIds = books.stream()
                .map(BookEntity::getPublisher)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());
        Map<Double, String> authorByNo = authorRepository.findAllById(publisherIds).stream()
                .collect(Collectors.toMap(
                        AuthorEntity::getAutNo,
                        a -> Objects.requireNonNullElse(a.getAutName(), "")));

        List<Map<String, Object>> rows = new ArrayList<>(books.size());
        for (BookEntity b : books) {
            CatalogueEntity cat = b.getCatalogue();
            Map<String, Object> row = new LinkedHashMap<>();
            row.put("appNo",           safe(b.getAppNo()));
            row.put("titleAr",         cat != null ? safe(cat.getActiveTitleAr()) : "");
            row.put("publisherName",   b.getPublisher() != null
                                            ? authorByNo.getOrDefault(b.getPublisher(), "") : "");
            row.put("publishLocation", safe(b.getPublishLocation()));
            row.put("edition",         fmt(b.getEdition()));
            row.put("pageCount",       fmt(b.getPageCount()));
            row.put("yearPublished",   fmt(b.getYearPublished()));
            row.put("status",          safe(b.getStatus()));
            rows.add(row);
        }

        // Column widths must sum to CONTENT_W_L = 792
        String[] headers = { "App No", "Title",   "Publisher",     "Location",         "Ed.",    "Pages",     "Year",          "Status" };
        String[] fields  = { "appNo",  "titleAr", "publisherName", "publishLocation",  "edition","pageCount", "yearPublished", "status" };
        int[]    widths  = {  65,       220,        130,             105,                58,       58,          68,              88 };
        // 65+220+130+105+58+58+68+88 = 792

        return buildPdf("Book Catalogue", true, headers, fields, widths, rows);
    }

    // =========================================================================
    // resource-result  (portrait A4)
    //   RES ──(RES_APP_NO = MN_APP_NO)──> main
    //   RES ──(RES_RES_NO = AUT_NO)─────> AUTHER
    // =========================================================================
    private byte[] resourceResult(Map<String, Object> params) throws JRException {
        // LEFT JOIN FETCH avoids N+1 on author (ManyToOne LAZY)
        List<ResEntity> resources = resRepository.findAllWithAuthor();

        // Batch-load catalogue titles for all referenced documents
        Set<String> appNos = resources.stream()
                .map(ResEntity::getAppNo)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());
        Map<String, String> titleByAppNo = catalogueRepository.findAllById(appNos).stream()
                .collect(Collectors.toMap(
                        CatalogueEntity::getAppNo,
                        c -> Objects.requireNonNullElse(c.getActiveTitleAr(), "")));

        List<Map<String, Object>> rows = new ArrayList<>(resources.size());
        for (ResEntity res : resources) {
            Map<String, Object> row = new LinkedHashMap<>();
            row.put("appNo",        safe(res.getAppNo()));
            row.put("title",        titleByAppNo.getOrDefault(res.getAppNo(), ""));
            AuthorEntity author = res.getAuthor();
            row.put("authorName",   author != null ? safe(author.getAutName()) : "");
            row.put("resourceType", safe(res.getResourceType()));
            rows.add(row);
        }

        // Column widths must sum to CONTENT_W_P = 545
        String[] headers = { "App No", "Title",  "Author",     "Type"          };
        String[] fields  = { "appNo",  "title",  "authorName", "resourceType"  };
        int[]    widths  = {  65,       280,       155,          45              };
        // 65+280+155+45 = 545

        return buildPdf("Resource Result", false, headers, fields, widths, rows);
    }

    // =========================================================================
    // dynamic  (portrait or landscape depending on column count)
    //   Delegates to TemplateExecutionService to run the bnkout template SQL,
    //   then renders the result set as a columnar PDF using buildPdf().
    // =========================================================================
    private byte[] dynamicReport(Map<String, Object> params) throws JRException {
        Object rawNum = params.get("templateNum");
        if (rawNum == null) {
            throw new ResourceNotFoundException("templateNum parameter required for dynamic report");
        }
        int templateNum = (int) Double.parseDouble(rawNum.toString());

        Map<String, String> filters = new HashMap<>();
        params.forEach((k, v) -> {
            if (!"templateNum".equals(k) && v != null) filters.put(k, v.toString());
        });

        TemplateExecutionResponse result = templateExecutionService.execute(templateNum, filters);
        List<ColumnMeta> columnMetas = result.columns();
        int numCols = Math.max(columnMetas.size(), 1);

        boolean landscape = numCols > 5;
        int contentW  = landscape ? CONTENT_W_L : CONTENT_W_P;
        int baseW     = contentW / numCols;
        int remainder = contentW - baseW * numCols;

        String[] headers = new String[numCols];
        String[] fields  = new String[numCols];
        int[]    widths  = new int[numCols];

        for (int i = 0; i < numCols; i++) {
            ColumnMeta col = columnMetas.get(i);
            headers[i] = col.label();
            fields[i]  = col.fieldName();
            widths[i]  = baseW + (i == numCols - 1 ? remainder : 0);
        }

        List<Map<String, Object>> rows = new ArrayList<>(result.rows().size());
        result.rows().forEach(r -> rows.add(new LinkedHashMap<>(r)));

        return buildPdf(result.title(), landscape, headers, fields, widths, rows);
    }

    // =========================================================================
    // general-N  (portrait A4)
    //   Reads the bnkout rows for OUT_NUM = N to obtain the report title and
    //   optional MN_TYP filter from OUT_MCOND, then queries main (catalogue).
    //
    //   Crystal Reports mapped per legacy file:
    //     general-1  → crystal_report1.rpt
    //     general-2  → crystal_report2.rpt
    //     general-4  → crystal_report4.rpt
    //     general-5  → crystal_report5.rpt
    //     general-7  → crystal_report7.rpt
    //     general-13 → crystal_report13.rpt
    //     general-3/6/8-12 → additional bnkout-defined outputs
    // =========================================================================
    private byte[] general(int reportNum, Map<String, Object> params) throws JRException {
        List<ReportTemplateEntity> templates =
                reportTemplateRepository.findByOutputNumOrderByIdAsc((double) reportNum);
        if (templates.isEmpty()) {
            throw new ResourceNotFoundException(
                    "No bnkout template found for report number: " + reportNum);
        }

        ReportTemplateEntity first = templates.get(0);
        String reportTitle = first.getDescription() != null && !first.getDescription().isBlank()
                ? first.getDescription().trim()
                : "General Report " + reportNum;

        // Attempt to derive a MN_TYP equality filter from the stored OUT_MCOND fragment.
        // Example stored values: "MN_TYP = 'B'", "MN_TYP='A'", "MN_TYP ='P'"
        String typeFilter = extractTypeFilter(first.getMainCondition());

        List<CatalogueEntity> catalogues = catalogueRepository.findAll();
        if (typeFilter != null) {
            final String ft = typeFilter;
            catalogues = catalogues.stream()
                    .filter(c -> ft.equalsIgnoreCase(c.getType()))
                    .collect(Collectors.toList());
        }

        List<Map<String, Object>> rows = new ArrayList<>(catalogues.size());
        for (CatalogueEntity c : catalogues) {
            Map<String, Object> row = new LinkedHashMap<>();
            row.put("appNo",     safe(c.getAppNo()));
            row.put("title",     safe(c.getActiveTitleAr()));
            row.put("type",      safe(c.getType()));
            row.put("entryDate", c.getEntryDate() != null ? c.getEntryDate().format(DATE_FMT) : "");
            row.put("result",    safe(c.getResult()));
            rows.add(row);
        }

        // Column widths must sum to CONTENT_W_P = 545
        String[] headers = { "App No", "Title", "Type", "Entry Date", "Result"  };
        String[] fields  = { "appNo",  "title", "type", "entryDate",  "result"  };
        int[]    widths  = {  60,       230,      50,     90,           115       };
        // 60+230+50+90+115 = 545

        return buildPdf(reportTitle, false, headers, fields, widths, rows);
    }

    // =========================================================================
    // Core PDF builder
    // =========================================================================

    /**
     * Builds a columnar PDF using JasperReports' programmatic design API —
     * no .jrxml template files are needed.
     *
     * @param title     Report heading text
     * @param landscape true = A4 landscape, false = A4 portrait
     * @param headers   Column header labels (same length as fields/widths)
     * @param fields    Row-map keys matching entries in each row Map
     * @param widths    Column widths in points; must sum to the available content width
     * @param rows      Data rows as List&lt;Map&lt;String, Object&gt;&gt;
     * @return raw PDF bytes
     */
    private byte[] buildPdf(String title, boolean landscape,
                             String[] headers, String[] fields, int[] widths,
                             List<Map<String, Object>> rows) throws JRException {

        int pageW    = landscape ? PAGE_W_L : PAGE_W_P;
        int pageH    = landscape ? PAGE_H_L : PAGE_H_P;
        int contentW = landscape ? CONTENT_W_L : CONTENT_W_P;

        JasperDesign d = new JasperDesign();
        d.setName(title);
        d.setPageWidth(pageW);
        d.setPageHeight(pageH);
        d.setLeftMargin(MARGIN);
        d.setRightMargin(MARGIN);
        d.setTopMargin(MARGIN);
        d.setBottomMargin(MARGIN);
        d.setColumnWidth(contentW);
        d.setColumnCount(1);
        d.setColumnSpacing(0);

        // Declare a String field for every column
        for (String f : fields) {
            JRDesignField jrf = new JRDesignField();
            jrf.setName(f);
            jrf.setValueClass(String.class);
            d.addField(jrf);
        }

        // --- Title band (appears once on the first page) ---
        JRDesignBand titleBand = new JRDesignBand();
        titleBand.setHeight(TITLE_H);
        titleBand.addElement(opaqueText(title, 0, 0, contentW, TITLE_H,
                TITLE_BG, Color.WHITE, true, 14f, HorizontalTextAlignEnum.CENTER));
        d.setTitle(titleBand);

        // --- Column header band (repeated on every page) ---
        JRDesignBand headerBand = new JRDesignBand();
        headerBand.setHeight(HEADER_H + 1);
        int x = 0;
        for (int i = 0; i < headers.length; i++) {
            headerBand.addElement(opaqueText(headers[i], x, 0, widths[i], HEADER_H,
                    HEADER_BG, HEADER_FG, true, 9f, HorizontalTextAlignEnum.CENTER));
            x += widths[i];
        }
        // Thin rule beneath header row
        JRDesignLine rule = new JRDesignLine();
        rule.setX(0);
        rule.setY(HEADER_H);
        rule.setWidth(contentW);
        rule.setHeight(1);
        rule.getLinePen().setLineWidth(1.0f);
        rule.getLinePen().setLineColor(RULE_CLR);
        headerBand.addElement(rule);
        d.setColumnHeader(headerBand);

        // --- Detail band (one row per data item) ---
        JRDesignBand detailBand = new JRDesignBand();
        detailBand.setHeight(ROW_H);
        x = 0;
        for (int i = 0; i < fields.length; i++) {
            detailBand.addElement(dataCell(fields[i], x, widths[i]));
            x += widths[i];
        }
        ((JRDesignSection) d.getDetailSection()).addBand(detailBand);

        // --- Page footer: right-aligned page number ---
        JRDesignBand footer = new JRDesignBand();
        footer.setHeight(18);
        JRDesignTextField pageNum = new JRDesignTextField();
        pageNum.setX(contentW - 60);
        pageNum.setY(1);
        pageNum.setWidth(60);
        pageNum.setHeight(15);
        pageNum.setFontSize(8f);
        pageNum.setForecolor(Color.GRAY);
        pageNum.setHorizontalTextAlign(HorizontalTextAlignEnum.RIGHT);
        JRDesignExpression pnExpr = new JRDesignExpression();
        pnExpr.setText("\"Page \" + $V{PAGE_NUMBER}");
        pageNum.setExpression(pnExpr);
        footer.addElement(pageNum);
        d.setPageFooter(footer);

        // Compile, fill, export
        JasperReport compiled = JasperCompileManager.compileReport(d);
        @SuppressWarnings("unchecked")
        java.util.Collection<Map<String, ?>> dataRows = (java.util.Collection<Map<String, ?>>) (java.util.Collection<?>) rows;
        JasperPrint  print    = JasperFillManager.fillReport(
                compiled, new HashMap<>(), new JRMapCollectionDataSource(dataRows));

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        JRPdfExporter exporter = new JRPdfExporter();
        exporter.setExporterInput(new SimpleExporterInput(print));
        exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(baos));
        exporter.exportReport();
        return baos.toByteArray();
    }

    // =========================================================================
    // Element factories
    // =========================================================================

    /** Static text element with solid background (ModeEnum.OPAQUE). */
    private JRDesignStaticText opaqueText(String text, int x, int y, int w, int h,
                                           Color bg, Color fg, boolean bold, float fontSize,
                                           HorizontalTextAlignEnum hAlign) {
        JRDesignStaticText st = new JRDesignStaticText();
        st.setX(x);
        st.setY(y);
        st.setWidth(w);
        st.setHeight(h);
        st.setText(text);
        st.setMode(ModeEnum.OPAQUE);
        st.setBackcolor(bg);
        st.setForecolor(fg);
        st.setBold(bold);
        st.setFontSize(fontSize);
        st.setHorizontalTextAlign(hAlign);
        st.setVerticalTextAlign(VerticalTextAlignEnum.MIDDLE);
        return st;
    }

    /** Dynamic text field bound to a named field in the data source. */
    private JRDesignTextField dataCell(String fieldName, int x, int width) {
        JRDesignTextField tf = new JRDesignTextField();
        tf.setX(x);
        tf.setY(0);
        tf.setWidth(width);
        tf.setHeight(ROW_H);
        tf.setBlankWhenNull(true);
        tf.setFontSize(9f);
        tf.setVerticalTextAlign(VerticalTextAlignEnum.MIDDLE);
        JRDesignExpression expr = new JRDesignExpression();
        expr.setText("$F{" + fieldName + "}");
        tf.setExpression(expr);
        return tf;
    }

    // =========================================================================
    // Utility helpers
    // =========================================================================

    private static String safe(String val) {
        return val != null ? val.trim() : "";
    }

    private static String fmt(Double val) {
        return val != null ? String.valueOf(val.longValue()) : "";
    }

    /**
     * Parses a simple MN_TYP equality predicate that the legacy VB code stored
     * in bnkout.OUT_MCOND, e.g. "MN_TYP = 'B'" or "MN_TYP='A'".
     * Returns the single-character type value, or null if the pattern is absent.
     */
    private static String extractTypeFilter(String cond) {
        if (cond == null || cond.isBlank()) return null;
        String norm = cond.toUpperCase(Locale.ROOT).replaceAll("\\s+", "");
        int idx = norm.indexOf("MN_TYP=");
        if (idx < 0) return null;
        String after = norm.substring(idx + 7).replaceAll("['\"]", "");
        return after.isEmpty() ? null : String.valueOf(after.charAt(0));
    }
}
