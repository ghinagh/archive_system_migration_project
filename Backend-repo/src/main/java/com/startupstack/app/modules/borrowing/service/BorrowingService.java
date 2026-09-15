package com.startupstack.app.modules.borrowing.service;

import com.startupstack.app.modules.borrowing.dto.BorrowingBookRequest;
import com.startupstack.app.modules.borrowing.dto.BorrowingBookResponse;
import com.startupstack.app.modules.borrowing.dto.BorrowingOtherRequest;
import com.startupstack.app.modules.borrowing.dto.BorrowingOtherResponse;
import com.startupstack.app.modules.borrowing.dto.BorrowingRequest;
import com.startupstack.app.modules.borrowing.dto.BorrowingResponse;
import com.startupstack.app.modules.borrowing.dto.ReturnRequest;
import com.startupstack.app.modules.borrowing.entity.BorrowingBookEntity;
import com.startupstack.app.modules.borrowing.entity.BorrowingEntity;
import com.startupstack.app.modules.borrowing.entity.BorrowingId;
import com.startupstack.app.modules.borrowing.entity.BorrowingOtherEntity;
import com.startupstack.app.modules.borrowing.mapper.BorrowingBookMapper;
import com.startupstack.app.modules.borrowing.mapper.BorrowingMapper;
import com.startupstack.app.modules.borrowing.mapper.BorrowingOtherMapper;
import com.startupstack.app.modules.borrowing.repository.BorrowingBookRepository;
import com.startupstack.app.modules.borrowing.repository.BorrowingOtherRepository;
import com.startupstack.app.modules.borrowing.repository.BorrowingRepository;
import com.startupstack.app.modules.borrowing.specification.BorrowingSpecification;
import com.startupstack.app.modules.catalogue.entity.CatalogueEntity;
import com.startupstack.app.modules.catalogue.repository.CatalogueRepository;
import com.startupstack.app.modules.persons.entity.PersonEntity;
import com.startupstack.app.modules.persons.repository.PersonRepository;
import com.startupstack.app.shared.exception.ResourceNotFoundException;
import com.startupstack.app.shared.util.SecurityUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class BorrowingService {

    private final BorrowingRepository borrowingRepository;
    private final PersonRepository personRepository;
    private final CatalogueRepository catalogueRepository;
    private final BorrowingMapper borrowingMapper;
    private final BorrowingBookRepository bookRepository;
    private final BorrowingOtherRepository otherRepository;
    private final BorrowingBookMapper bookMapper;
    private final BorrowingOtherMapper otherMapper;

    public BorrowingService(BorrowingRepository borrowingRepository,
                            PersonRepository personRepository,
                            CatalogueRepository catalogueRepository,
                            BorrowingMapper borrowingMapper,
                            BorrowingBookRepository bookRepository,
                            BorrowingOtherRepository otherRepository,
                            BorrowingBookMapper bookMapper,
                            BorrowingOtherMapper otherMapper) {
        this.borrowingRepository = borrowingRepository;
        this.personRepository = personRepository;
        this.catalogueRepository = catalogueRepository;
        this.borrowingMapper = borrowingMapper;
        this.bookRepository = bookRepository;
        this.otherRepository = otherRepository;
        this.bookMapper = bookMapper;
        this.otherMapper = otherMapper;
    }

    @Transactional(readOnly = true)
    public Page<BorrowingResponse> findAll(String personNo, Double borrowingType,
                                           LocalDateTime dateFrom, LocalDateTime dateTo,
                                           Pageable pageable) {
        boolean isAdmin = SecurityUtils.isAdmin();
        String userEnt = isAdmin ? null : SecurityUtils.getCurrentUserEnt();
        // Wilaya-based filtering is not applied here: ISTARA has no direct wilaya
        // column and the multi-hop join (ISTARA → PERSON1 → posts → sites) needed
        // to reach sit_wly_no is too costly and not guaranteed to be intact for
        // every record.  Geographic scoping is approximated by the entity filter
        // (iar_ent / belongsToUserEntity) which groups records by organisational
        // unit.  See BorrowingSpecification.hasWilaya() for the full rationale.
        Specification<BorrowingEntity> spec = BorrowingSpecification.belongsToUserEntity(userEnt)
                .and(BorrowingSpecification.hasPerson(personNo))
                .and(BorrowingSpecification.hasBorrowingType(borrowingType))
                .and(BorrowingSpecification.borrowDateFrom(dateFrom))
                .and(BorrowingSpecification.borrowDateTo(dateTo));
        return borrowingRepository.findAll(spec, pageable).map(borrowingMapper::toResponse);
    }

    @Transactional(readOnly = true)
    public BorrowingResponse findById(String iarNo, Double serial, Double borrowingType) {
        BorrowingId id = buildId(iarNo, serial, borrowingType);
        BorrowingEntity entity = borrowingRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Borrowing not found: " + iarNo));
        return borrowingMapper.toResponse(entity);
    }

    @Transactional
    public BorrowingResponse create(BorrowingRequest request) {
        BorrowingEntity entity = borrowingMapper.toEntity(request);

        if (request.getPersonNo() != null) {
            PersonEntity person = personRepository.findById(request.getPersonNo())
                    .orElseThrow(() -> new ResourceNotFoundException("Person not found: " + request.getPersonNo()));
            entity.setPerson(person);
        }

        if (request.getBookNo() != null) {
            CatalogueEntity catalogue = catalogueRepository.findById(request.getBookNo())
                    .orElseThrow(() -> new ResourceNotFoundException("Catalogue record not found: " + request.getBookNo()));
            entity.setCatalogue(catalogue);
        }

        return borrowingMapper.toResponse(borrowingRepository.save(entity));
    }

    @Transactional
    public BorrowingResponse update(String iarNo, Double serial, Double borrowingType,
                                    BorrowingRequest request) {
        BorrowingId id = buildId(iarNo, serial, borrowingType);
        BorrowingEntity entity = borrowingRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Borrowing not found: " + iarNo));

        borrowingMapper.updateEntity(request, entity);

        if (request.getPersonNo() != null) {
            PersonEntity person = personRepository.findById(request.getPersonNo())
                    .orElseThrow(() -> new ResourceNotFoundException("Person not found: " + request.getPersonNo()));
            entity.setPerson(person);
        }

        if (request.getBookNo() != null) {
            CatalogueEntity catalogue = catalogueRepository.findById(request.getBookNo())
                    .orElseThrow(() -> new ResourceNotFoundException("Catalogue record not found: " + request.getBookNo()));
            entity.setCatalogue(catalogue);
        }

        return borrowingMapper.toResponse(borrowingRepository.save(entity));
    }

    @Transactional
    public BorrowingResponse returnBorrowing(String iarNo, Double serial, Double borrowingType,
                                             ReturnRequest request) {
        BorrowingId id = buildId(iarNo, serial, borrowingType);
        BorrowingEntity entity = borrowingRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Borrowing not found: " + iarNo));
        entity.setReturnDate(request.getReturnDate());
        return borrowingMapper.toResponse(borrowingRepository.save(entity));
    }

    @Transactional
    public void delete(String iarNo, Double serial, Double borrowingType) {
        BorrowingId id = buildId(iarNo, serial, borrowingType);
        if (!borrowingRepository.existsById(id)) {
            throw new ResourceNotFoundException("Borrowing not found: " + iarNo);
        }
        borrowingRepository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public List<BorrowingBookResponse> findBooksByBorrowingNo(String iarNo) {
        requireBorrowingExists(iarNo);
        return bookRepository.findByBorrowingNo(iarNo).stream()
                .map(bookMapper::toResponse)
                .toList();
    }

    @Transactional
    public BorrowingBookResponse addBook(String iarNo, BorrowingBookRequest request) {
        requireBorrowingExists(iarNo);
        BorrowingBookEntity entity = bookMapper.toEntity(request);
        entity.setBorrowingNo(iarNo);
        entity.setSerial(bookRepository.findMaxSerialByBorrowingNo(iarNo) + 1);
        return bookMapper.toResponse(bookRepository.save(entity));
    }

    @Transactional
    public void removeBook(String iarNo, Double iabSer) {
        if (!bookRepository.existsByBorrowingNoAndSerial(iarNo, iabSer)) {
            throw new ResourceNotFoundException("Book entry not found for borrowing " + iarNo + ", serial " + iabSer);
        }
        bookRepository.deleteByBorrowingNoAndSerial(iarNo, iabSer);
    }

    @Transactional(readOnly = true)
    public List<BorrowingOtherResponse> findOthersByBorrowingNo(String iarNo) {
        requireBorrowingExists(iarNo);
        return otherRepository.findByBorrowingNo(iarNo).stream()
                .map(otherMapper::toResponse)
                .toList();
    }

    @Transactional
    public BorrowingOtherResponse addOther(String iarNo, BorrowingOtherRequest request) {
        requireBorrowingExists(iarNo);
        BorrowingOtherEntity entity = otherMapper.toEntity(request);
        entity.setBorrowingNo(iarNo);
        entity.setSerial(otherRepository.findMaxSerialByBorrowingNo(iarNo) + 1);
        return otherMapper.toResponse(otherRepository.save(entity));
    }

    @Transactional
    public void removeOther(String iarNo, Double iaoSer) {
        if (!otherRepository.existsByBorrowingNoAndSerial(iarNo, iaoSer)) {
            throw new ResourceNotFoundException("Other item not found for borrowing " + iarNo + ", serial " + iaoSer);
        }
        otherRepository.deleteByBorrowingNoAndSerial(iarNo, iaoSer);
    }

    private void requireBorrowingExists(String iarNo) {
        if (!borrowingRepository.existsByIarNo(iarNo)) {
            throw new ResourceNotFoundException("Borrowing not found: " + iarNo);
        }
    }

    private BorrowingId buildId(String iarNo, Double serial, Double borrowingType) {
        BorrowingId id = new BorrowingId();
        id.setIarNo(iarNo);
        id.setSerial(serial);
        id.setBorrowingType(borrowingType);
        return id;
    }
}
