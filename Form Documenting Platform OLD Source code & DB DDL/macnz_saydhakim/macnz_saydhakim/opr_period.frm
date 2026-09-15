VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form Form10 
   Caption         =   "Form10"
   ClientHeight    =   8595
   ClientLeft      =   300
   ClientTop       =   345
   ClientWidth     =   11880
   LinkTopic       =   "Form10"
   ScaleHeight     =   8595
   ScaleWidth      =   11880
   Begin MSRDC.MSRDC perd 
      Height          =   375
      Left            =   2760
      Top             =   7560
      Width           =   2295
      _ExtentX        =   4048
      _ExtentY        =   661
      _Version        =   393216
      Options         =   0
      CursorDriver    =   1
      BOFAction       =   0
      EOFAction       =   0
      RecordsetType   =   3
      LockType        =   4
      QueryType       =   0
      Prompt          =   3
      Appearance      =   1
      QueryTimeout    =   30
      RowsetSize      =   100
      LoginTimeout    =   15
      KeysetSize      =   0
      MaxRows         =   0
      ErrorThreshold  =   -1
      BatchSize       =   15
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      Enabled         =   -1  'True
      ReadOnly        =   0   'False
      Appearance      =   -1  'True
      DataSourceName  =   "sqlserver"
      RecordSource    =   "select * from period"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "perd"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.TextBox m_date 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   9120
      TabIndex        =   4
      Top             =   840
      Width           =   1215
   End
   Begin VB.TextBox SERH 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   2400
      RightToLeft     =   -1  'True
      TabIndex        =   3
      Top             =   6840
      Visible         =   0   'False
      Width           =   2535
   End
   Begin MSRDC.MSRDC period 
      Height          =   375
      Left            =   240
      Top             =   7560
      Visible         =   0   'False
      Width           =   2175
      _ExtentX        =   3836
      _ExtentY        =   661
      _Version        =   393216
      Options         =   0
      CursorDriver    =   1
      BOFAction       =   0
      EOFAction       =   0
      RecordsetType   =   3
      LockType        =   4
      QueryType       =   0
      Prompt          =   3
      Appearance      =   1
      QueryTimeout    =   30
      RowsetSize      =   100
      LoginTimeout    =   15
      KeysetSize      =   0
      MaxRows         =   0
      ErrorThreshold  =   -1
      BatchSize       =   15
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      Enabled         =   -1  'True
      ReadOnly        =   0   'False
      Appearance      =   -1  'True
      DataSourceName  =   "sqlserver"
      RecordSource    =   "select * from period order by per_per_na"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "period"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSDBCtls.DBList DBList1 
      Bindings        =   "opr_period.frx":0000
      Height          =   2595
      Left            =   2160
      TabIndex        =   2
      Top             =   1920
      Visible         =   0   'False
      Width           =   3135
      _ExtentX        =   5530
      _ExtentY        =   4577
      _Version        =   393216
      BackColor       =   16744576
      ForeColor       =   16777088
      ListField       =   "PER_PER_NA"
   End
   Begin VB.CommandButton add 
      Caption         =   "ÇÖÜÜÜÇÝÜÉ"
      Height          =   495
      Left            =   9960
      TabIndex        =   1
      Top             =   7440
      Width           =   1215
   End
   Begin MSDBGrid.DBGrid DBGrid1 
      Height          =   5175
      Left            =   360
      OleObjectBlob   =   "opr_period.frx":0011
      TabIndex        =   0
      Top             =   1560
      Width           =   10815
   End
   Begin MSRDC.MSRDC perd1 
      Align           =   2  'Align Bottom
      Height          =   375
      Left            =   0
      Top             =   8220
      Width           =   11880
      _ExtentX        =   20955
      _ExtentY        =   661
      _Version        =   393216
      Options         =   0
      CursorDriver    =   1
      BOFAction       =   0
      EOFAction       =   0
      RecordsetType   =   3
      LockType        =   4
      QueryType       =   0
      Prompt          =   3
      Appearance      =   1
      QueryTimeout    =   30
      RowsetSize      =   100
      LoginTimeout    =   15
      KeysetSize      =   0
      MaxRows         =   0
      ErrorThreshold  =   -1
      BatchSize       =   15
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      Enabled         =   -1  'True
      ReadOnly        =   0   'False
      Appearance      =   -1  'True
      DataSourceName  =   "sqlserver"
      RecordSource    =   "select * from view_trans"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "                                                           ÇÖÛØ Úáì Óåã Çáíãä æÇáíÓÑ áÊäÞá Ýí ÓÌáÇÊ ÇáãáÝ"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      Caption         =   "ãä ÊÇÑíÎ"
      Height          =   255
      Left            =   10080
      TabIndex        =   5
      Top             =   840
      Width           =   975
   End
End
Attribute VB_Name = "Form10"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim m_trs_no As Integer

Private Sub add_Click()
Dim cn As New rdoConnection
 Dim SQL As String
 Dim m_bk_ser As Variant
 
 'Dim m_date As Date
'SRDC1.Resultset.
period.Resultset.MoveLast
m_trs_no = period.Resultset![TRS_OPNO] + 1
m_dte1 = Date
M_PER_NO = 0
M_YEAR = Year(Date)
m_nb = 1
m_typ = 1
   SQL = "execute insr_trans " & "'" & m_trs_no & "'" & "," & "'" & M_PER_NO & "'" & "," _
   & "'" & M_YEAR & "'" & "," & "'" & m_nb & "'" & "," & "'" & m_typ & "'" & "," _
    & "'" & Format(m_dte1, "yyyy/mm/dd") & "'"
 
       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute SQL, rdExecDirect
 
 period.Refresh
 period.Resultset.MoveLast
 DBGrid1.SetFocus
 
End Sub

 
Private Sub DBGrid1_KeyPress(KeyAscii As Integer)


If KeyAscii = 32 And DBGrid1.Col = 1 Then
  DBList1.Visible = True
  DBList1.SetFocus
  SendKeys "{UP}"
End If
End Sub

Private Sub DBList1_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
  DBList1.Visible = False
  DBGrid1.SetFocus
ElseIf KeyAscii = 13 Then
Dim cn As New rdoConnection
 Dim SQL As String
 Dim qd As rdoQuery
 Dim CRIT As String
 
  period.Resultset.Bookmark = DBList1.SelectedItem
  M_PER_NO = period.Resultset![per_per_no]
  
   SQL = "execute upd_trans1 " & "'" & DBGrid1.Columns(0) & "'" & "," & "'" & M_PER_NO & "'"
 
       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute SQL, rdExecDirect
            
  '          M_DTE = Format(m_date.Text, "yyyy/mm/dd")
   '  crit = "select  trans.trs_opno" & " ," & " period.per_per_na     from trans innerjoin period on (trans.trs_no = period.per_per_no)  where  trans.TRS_DTE1 > " & "'" & M_DTE & "'"
  'CRIT = "select   trans.trs_opno , period.per_per_na  as expr2  from trans inner join period on trans.trs_no = period.per_per_no    where  trans.TRS_DTE1 > " & "'" & M_DTE & "'"
  '  Set qd = cn.CreateQuery("view_abb1", CRIT)
'    Set rs = qd.OpenResultSet()
    '  perd1.SQL = qd.SQL
      ' perd1.Refresh
      
      DBGrid1.Refresh
      DBGrid1.SetFocus
  
End If
 
End Sub

Private Sub DBList1_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF10 Then
   SERH.Visible = True
  SERH.SetFocus
End If
End Sub

Private Sub Text1_Change()

End Sub

Private Sub Form_Load()

  Dim mydate As Variant
   Dim cn As New rdoConnection
   Dim SQL As String
   Dim qd As rdoQuery
   Dim sql_query As String
   Dim rs As rdoResultset
   
             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
            cn.EstablishConnection rdDriverNoPrompt
             ' cn.Execute crit, rdExecDirect
            M_DTE = Format(m_date.Text, "yyyy/mm/dd")
   
   CRIT = " select * from view_trans  where trans.TRS_DTE1 > " & "'" & M_DTE & "'"
  '  Set qd = cn.CreateQuery("view_abb1", CRIT)
  ' Set rs = qd.OpenResultSet()
  ''
  '  Set DBGrid1.DataSource = rs
  '    DBGrid1.Refresh
  '    DBGrid1.SetFocus

End Sub

Private Sub m_date_KeyPress(KeyAscii As Integer)
''On Error Resume Next
If KeyAscii = 13 Then

  Dim mydate As Variant
   Dim cn As New rdoConnection
   Dim SQL As String
   Dim qd As rdoQuery
   Dim sql_query As String
   ' Dim rs As New rdoResultset
    
             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
            cn.EstablishConnection rdDriverNoPrompt
             ' cn.Execute crit, rdExecDirect
            M_DTE = Format(m_date.Text, "yyyy/mm/dd")
   '  crit = "select  trans.trs_opno" & " ," & " period.per_per_na     from trans innerjoin period on (trans.trs_no = period.per_per_no)  where  trans.TRS_DTE1 > " & "'" & M_DTE & "'"
  'CRIT = "select   trans.trs_opno , period.per_per_na  as expr2  from period inner join trans on trans.trs_no = period.per_per_no    where  trans.TRS_DTE1 > " & "'" & M_DTE & "'"
   CRIT = " select * from view_trans  where trans.TRS_DTE1 > " & "'" & M_DTE & "'"
    Set qd = cn.CreateQuery("view_abb1", CRIT)
   Set rs = qd.OpenResultSet()
    Set DBGrid1.DataSource = rs
      DBGrid1.Refresh
      DBGrid1.SetFocus
      
   End If
End Sub

