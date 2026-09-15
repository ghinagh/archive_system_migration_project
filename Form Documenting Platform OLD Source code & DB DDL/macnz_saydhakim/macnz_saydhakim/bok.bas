Attribute VB_Name = "bok"
Global main_form As Integer
Global jad_print As Integer
Global box_company As Integer
Global m_form_load As Integer
Global m_bk_no, box_user_cmpvd, box_user_ent, box_user_doc, m_prsno, m_prs_sub_name As String
Global cn As New rdoConnection
Global m_cnf_path_pic As String
Global password1 As String
Global is_text  As Boolean
'Global Const m_connect = "odbc;dsname =;uid=;pwd=;server=server;driver = {sql server};database=macnz_manar;" '
'Global Const m_connect = "odbc;dsname =;uid=;pwd=;server=dbserver01;driver = {sql server};database=macnz_manar;"
'Global Const m_connect = "odbc;dsname =;uid=;pwd=;server=sqlserver;driver = {sql server};database=new_macnz;"
'Global Const m_connect = "odbc;dsname =;uid=;pwd=;server=WIN-9HE7S5KMGV8\ARCHIVE;driver = {sql server};database=macnz_manar;"
'Global Const m_connect = "odbc;dsname =;uid=;pwd=;server=WIN-QTIKVCQC636;driver = {sql server};database=macnz_manar;"
 'Global Const m_connect = "odbc;dsname =;uid=;pwd=;server=sqlserver;driver = {sql server};database=new_macnz;"
'Global Const m_connect = "odbc;dsname =;uid=;pwd=;server=.;driver = {sql server};database=macnz_manar;"
'Global Const m_connect = "odbc;dsname =;uid=;pwd=;server=archivesvr;driver = {sql server};database=macnz_manar;"

Global Const m_connect = "odbc;dsname =;uid=;pwd=;server=.;driver = {sql server};database=macnz_manar;"
Global Const M_SQL_NAM = "sqlserver"
Global box_user_no, box_user_name, box_user_password, m_mch_stock, p_crit As String

Global box_user_start, box_user_pwd, box_serch, box_mn_trans As Integer
Global m_config_path As String
Global STREAMSTART(10) As Double
Global LEN_MCH(10) As Double
Global ar_path(10) As String
Global v_mch_no, v_mch_tit  As String
Global v_mch_typ, v_mch_digtyp, v_mch_ext, v_mch_typ_high, v_mch_ext_high As String
Global lg_stop As Boolean



Global IND, v_mch_o, v_mch_m, v_mch_s, v_mch_o1, v_mch_m1, v_mch_s1, nb_page As Integer
Global V_MCH_STOCK   As String
Global m_time, m_time1, m_tm1, m_tm, deb_tm As Integer

Global video_path, video_path1 As String
'Public Function OpenDoc(ByVal DocFile As String) As Long
'   OpenDoc = ShellExecuteinfo(0&, vbNullString, DocFile, vbNullString, vbNullString, vbNormalFocus)
'End Function

 Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hWnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Public Function OpenDoc(ByVal DocFile As String) As Long
   OpenDoc = ShellExecute(0&, vbNullString, DocFile, vbNullString, vbNullString, vbNormalFocus)
End Function

 Function m_STCOK_path(m_stock As String)
    Dim M_NAM As String
    On Error Resume Next
     
   
  If Val(m_stock) > 4920 Then
   m_STCOK_path = video_path

  M_NAM = video_path + Trim(m_stock) + "." + v_mch_typ
  Else
  m_STCOK_path = video_path1
   M_NAM = video_path1 + Trim(m_stock) + "." + v_mch_typ
  End If
  ' V_MCH_STOCK = Val(Trim(m_stock))
   If Dir(M_NAM) = "" Then
     
  End If

   
  End Function

Function filter_desc(v_desc As String)


If Not v_desc = "" Then
   m_desc = LTrim(v_desc)
   m_len = Len(LTrim(v_desc))
  ' m_desc = v_desc
  ' m_len = Len(v_desc)
   
    i = 1
    m_desc1 = ""
   While i < m_len + 1
      m_char = Mid(m_desc, i, 1)
     If m_char = "'" Or m_char = Chr(34) Or m_char = Chr(39) Or m_char = Chr(10) Or m_char = Chr(13) Or m_char = "/" Or m_char = "?" Or m_char = "<" Or m_char = ">" Or m_char = "*" Or m_char = "\" Or m_char = "|" Or m_char = "¿" Or m_char = ":" Then
        m_desc1 = m_desc1 + " "
    Else
        m_desc1 = m_desc1 + Mid(m_desc, i, 1)
     End If
     i = i + 1
   Wend
   filter_desc = m_desc1
End If
 End Function
 Function is_trans(m_trans As Integer)
    On Error Resume Next
     
   If m_trans = 1 Then
     MsgBox " áÇÊÓÊØíÚ ÇáÊÚÏá Çæ ÇáÇáÛÇÁ ....áÇä ÇáæËíÞÉ ãÞÝáÉ. "
     is_trans = flase
    Else
     is_trans = True
    End If
  End Function

 Function m_STCOK_path5(m_stock As String)
    Dim M_NAM As String
    On Error Resume Next
     
   
'm_STCOK_path = "\\172.16.2.33\for Archive\Sayedavi\sayyed_lowres\"


'm_STCOK_path = "c:\avi\"
 If Val(m_stock) > 4920 Then
   m_STCOK_path5 = video_path

  M_NAM = video_path + Trim(m_stock) + "." + v_mch_typ
  Else
  m_STCOK_path5 = video_path1
   M_NAM = video_path1 + Trim(m_stock) + "." + v_mch_typ
  End If
  ' V_MCH_STOCK = Val(Trim(m_stock))
   If Dir(M_NAM) = "" Then
     
  End If

   
  End Function

Public Function HighlightWords(rtb As RichTextBox, _
                                  v_desc As String, _
                                  lColor As Long) _
                                  As Integer

        Dim lFoundPos As Long           'Position of first character
                                        'of match
        Dim lFindLength As Long         'Length of string to find
        Dim lOriginalSelStart As Long
        Dim lOriginalSelLength As Long
        Dim iMatchCount As Integer      'Number of matches

        'Save the insertion points current location and length
        lOriginalSelStart = rtb.SelStart
        lOriginalSelLength = rtb.SelLength

     If Not v_desc = "" Then
   m_desc = LTrim(v_desc)
   m_len = Len(LTrim(v_desc))
  ' m_desc = v_desc
  ' m_len = Len(v_desc)
    lg = True
    i = 1

   While i < m_len + 1
         m_desc1 = ""
         lg = True
    While lg And i < m_len + 1
      m_char = Mid(m_desc, i, 1)
      ' Or m_char = chr(10)  Or m_char = chr(13) Or m_char = "/" Or m_char = "\"
     If m_char = " " Then
          lg = False
        Else
        m_desc1 = m_desc1 + m_char
     End If
      i = i + 1
     Wend
        sFindString = m_desc1
        
        
        'Cache the length of the string to find
        lFindLength = Len(sFindString)

        'Attempt to find the first match
        lFoundPos = rtb.Find(sFindString, 0, , rtfNoHighlight)
        While lFoundPos > 0
          iMatchCount = iMatchCount + 1

          rtb.SelStart = lFoundPos
          'The SelLength property is set to 0 as
          'soon as you change SelStart
          rtb.SelLength = lFindLength
          rtb.SelColor = lColor
          'Attempt to find the next match
          lFoundPos = rtb.Find(sFindString, _
            lFoundPos + lFindLength, , rtfNoHighlight)
        Wend

        'Restore the insertion point to its original
        'location and length
        rtb.SelStart = lOriginalSelStart
        rtb.SelLength = lOriginalSelLength
        
   Wend
    End If

        'Return the number of matches
        HighlightWords = iMatchCount

      End Function



Function filter_desc1(v_desc As String)


If Not v_desc = "" Then
   m_desc = LTrim(v_desc)
   m_len = Len(LTrim(v_desc))
  ' m_desc = v_desc
  ' m_len = Len(v_desc)
   
    i = 1
    m_desc1 = ""
   While i < m_len + 1
      m_char = Mid(m_desc, i, 1)
     If m_char = "'" Then
        m_desc1 = m_desc1 + " "
    Else
        m_desc1 = m_desc1 + Mid(m_desc, i, 1)
     End If
     i = i + 1
   Wend
   filter_desc1 = m_desc1
End If
 End Function

