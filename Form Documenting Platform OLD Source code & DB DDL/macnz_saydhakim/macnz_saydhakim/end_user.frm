VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form end_user 
   Caption         =   "Form6"
   ClientHeight    =   8490
   ClientLeft      =   60
   ClientTop       =   210
   ClientWidth     =   11880
   LinkTopic       =   "Form6"
   ScaleHeight     =   8490
   ScaleWidth      =   11880
   Begin MSDBGrid.DBGrid DBGrid1 
      Height          =   4455
      Left            =   600
      OleObjectBlob   =   "end_user.frx":0000
      TabIndex        =   21
      Top             =   3360
      Width           =   10815
   End
   Begin MSDBCtls.DBCombo DBCombo1 
      Bindings        =   "end_user.frx":09D3
      Height          =   315
      Left            =   8160
      TabIndex        =   20
      Top             =   2760
      Width           =   3615
      _ExtentX        =   6376
      _ExtentY        =   556
      _Version        =   393216
      BackColor       =   12632256
      ListField       =   "out_cond"
      Text            =   "DBCombo1"
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox x_getcond 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0C0C0&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   3840
      TabIndex        =   14
      Top             =   2760
      Visible         =   0   'False
      Width           =   2775
   End
   Begin VB.CommandButton x_add 
      Caption         =   "«÷«›…"
      Height          =   375
      Left            =   5400
      TabIndex        =   13
      Top             =   2040
      Width           =   975
   End
   Begin VB.CommandButton x_del 
      Caption         =   "«·€«¡"
      Height          =   375
      Left            =   6480
      TabIndex        =   12
      Top             =   2040
      Width           =   855
   End
   Begin VB.CommandButton x_left 
      Caption         =   "("
      Height          =   375
      Left            =   7440
      TabIndex        =   11
      Top             =   2040
      Width           =   855
   End
   Begin VB.CommandButton x_right 
      Caption         =   ")"
      Height          =   375
      Left            =   8520
      TabIndex        =   10
      Top             =   2040
      Width           =   735
   End
   Begin VB.CommandButton x_and 
      Caption         =   "Ê"
      Height          =   375
      Left            =   9600
      TabIndex        =   9
      Top             =   2040
      Width           =   735
   End
   Begin VB.TextBox x_criteria 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00808000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   1215
      Left            =   4920
      MultiLine       =   -1  'True
      RightToLeft     =   -1  'True
      TabIndex        =   8
      Top             =   720
      Width           =   6855
   End
   Begin VB.CommandButton x_or 
      BackColor       =   &H00808000&
      Caption         =   "«Ê"
      Height          =   375
      Left            =   10560
      TabIndex        =   7
      Top             =   2040
      Width           =   855
   End
   Begin VB.CommandButton cmd_result 
      Caption         =   "‰ «∆‹‹‹Ã «·»Õ‹À"
      Height          =   375
      Left            =   2160
      TabIndex        =   6
      Top             =   2640
      Width           =   1575
   End
   Begin VB.CommandButton Command1 
      Caption         =   "«€·«ﬁ"
      Height          =   375
      Left            =   480
      TabIndex        =   5
      Top             =   2640
      Width           =   1575
   End
   Begin VB.TextBox x_cond1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0C0C0&
      Height          =   285
      Left            =   4080
      RightToLeft     =   -1  'True
      TabIndex        =   4
      Top             =   2760
      Visible         =   0   'False
      Width           =   2535
   End
   Begin VB.ComboBox cb_serh 
      Height          =   315
      ItemData        =   "end_user.frx":09E8
      Left            =   6600
      List            =   "end_user.frx":09F2
      TabIndex        =   3
      Top             =   2760
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.ComboBox c_operation 
      BackColor       =   &H80000016&
      Height          =   315
      ItemData        =   "end_user.frx":0A11
      Left            =   6600
      List            =   "end_user.frx":0A21
      TabIndex        =   2
      Top             =   2760
      Width           =   1575
   End
   Begin VB.TextBox searcher 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0C0C0&
      Height          =   285
      Left            =   600
      TabIndex        =   0
      Top             =   360
      Visible         =   0   'False
      Width           =   4215
   End
   Begin MSRDC.MSRDC BNKOUT2 
      Height          =   330
      Left            =   2400
      Top             =   8160
      Visible         =   0   'False
      Width           =   3000
      _ExtentX        =   5292
      _ExtentY        =   582
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
      RecordSource    =   "SELECT * FROM VIEW_BNKOUT1"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "BNKOUT2"
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
   Begin MSDBCtls.DBList c_getcond 
      Bindings        =   "end_user.frx":0A32
      DataSource      =   "data2"
      Height          =   1815
      Left            =   600
      TabIndex        =   1
      Top             =   600
      Width           =   4215
      _ExtentX        =   7435
      _ExtentY        =   3201
      _Version        =   393216
      BackColor       =   12632256
      RightToLeft     =   -1  'True
   End
   Begin MSRDC.MSRDC result 
      Height          =   330
      Left            =   2520
      Top             =   8400
      Visible         =   0   'False
      Width           =   1935
      _ExtentX        =   3413
      _ExtentY        =   582
      _Version        =   393216
      Options         =   0
      CursorDriver    =   1
      BOFAction       =   0
      EOFAction       =   0
      RecordsetType   =   1
      LockType        =   3
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
      RecordSource    =   ""
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "result"
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
   Begin MSRDC.MSRDC bnkout1 
      Height          =   330
      Left            =   6120
      Top             =   8400
      Visible         =   0   'False
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   582
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
      RecordSource    =   ""
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "bnkout1"
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
   Begin MSRDC.MSRDC data2 
      Height          =   330
      Left            =   4200
      Top             =   8400
      Visible         =   0   'False
      Width           =   1695
      _ExtentX        =   2990
      _ExtentY        =   582
      _Version        =   393216
      Options         =   0
      CursorDriver    =   1
      BOFAction       =   0
      EOFAction       =   0
      RecordsetType   =   1
      LockType        =   3
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
      RecordSource    =   ""
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "data2"
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
   Begin MSRDC.MSRDC bnkout 
      Height          =   330
      Left            =   840
      Top             =   8280
      Visible         =   0   'False
      Width           =   1695
      _ExtentX        =   2990
      _ExtentY        =   582
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
      RecordSource    =   "select * from bnkout where out_if = 1 oder by out_indx3"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "bnkout"
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
   Begin VB.Shape Shape4 
      Height          =   4935
      Left            =   360
      Shape           =   4  'Rounded Rectangle
      Top             =   3120
      Width           =   11295
   End
   Begin VB.Shape Shape5 
      Height          =   1935
      Left            =   480
      Shape           =   4  'Rounded Rectangle
      Top             =   600
      Width           =   11535
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H00404000&
      Caption         =   "«·«”∆‹‹‹·… «·„ —«ﬂ„‹‹‹‹‹‹…"
      ForeColor       =   &H8000000E&
      Height          =   255
      Left            =   7200
      TabIndex        =   19
      Top             =   480
      Width           =   1935
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H00808000&
      Caption         =   "„œŒ· «·»ÕÀ"
      Height          =   255
      Left            =   10680
      TabIndex        =   18
      Top             =   2520
      Width           =   1095
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BackColor       =   &H00808000&
      Caption         =   "«Œ Ì«— «·«ÃÊ»…"
      Height          =   255
      Left            =   5520
      TabIndex        =   17
      Top             =   2520
      Width           =   1095
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      BackColor       =   &H00808000&
      Caption         =   "«·«œÊ« "
      Height          =   255
      Left            =   6960
      TabIndex        =   16
      Top             =   2520
      Width           =   855
   End
   Begin VB.Shape Shape7 
      Height          =   8415
      Left            =   240
      Shape           =   4  'Rounded Rectangle
      Top             =   0
      Width           =   12015
   End
   Begin VB.Label Label7 
      Alignment       =   2  'Center
      BackColor       =   &H00404000&
      Caption         =   "»—‰«„Ã «·»ÕÀ «·Ê«÷Õ"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000018&
      Height          =   375
      Left            =   4560
      TabIndex        =   15
      Top             =   0
      Width           =   3375
   End
End
Attribute VB_Name = "end_user"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
 Public M_SCR_NAME As String, M_CRITERIA As String, M_PRINT As Variant, crit_new As String
' Public D_CONDITIONS As resultset, MYDB As Database, M_KCONDITION As String, M_FCONDITION As String, M_ICONDITION As String, m_selectuse As Variant, M_ARGCOUNT As Integer, M_CRIT_OR As String
 'Public MFILETOPRINT As resultset, selectkey As Variant
 Dim dyn_arr()
 Public count1 As Variant
 Public count_rel As Variant
 Public count_slct1 As Variant
 Dim arr_table(20) As Variant
 Dim arr_table1(20) As Variant
 Dim arr_tbl(20) As Variant
 Dim arr_tbl1(20) As Variant
 Dim arr_fld_rel(20) As Variant
 'Public m_crit1 As Variant
 Public m_list_len As Variant
 Public m_nb_fldout As Integer
 Dim arr_rel1(20) As Variant
 Dim arr_rel2(20) As Variant
 Dim arr_relition(20) As Variant
 Dim arr_reltbl(20) As Variant
 Dim arr_ind1(20) As Integer
 Dim arr_ind2(20) As Integer
 Public count2, v_get, v_view As Variant
 Public tm_criteria As String
 Public v_bookmark1, v_bookmark2, nb_ad, nb_or, nb_and As Variant
 Public count3 As Variant
 Dim m_key_serh As Integer
 
 



Private Sub c_listfields_Click(Area As Integer)
     
   Dim posit, posit1, L, l1 As Integer
   Dim str1, str2, d_type, d_query, d_view, d_view1, d_get, d_get1, d_get2, d_cond, d_table As Variant
   Dim CRIT, crit1, crit11, crit2, crit3 As String
   Dim mydate As Variant
   x_getcond = " "
        
    bnkout.Resultset.Bookmark = c_listfields.SelectedItem
    

    v_bookmark1 = bnkout.Resultset![out_num]
 If bnkout.Resultset![out_nature] = "1" Or bnkout.Resultset![out_nature] = "8" Then
 '  x_getcond.Text = ""
   x_getcond.Visible = True
   c_getcond.Visible = False
   x_cond1.Visible = False
   [cb_serh].Visible = False
 
 
 ElseIf bnkout.Resultset![out_nature] = "3" Then
  ' mydate = Date
  x_getcond = Date
  'Format(mydate, "  /  /  ")
  
  x_getcond.Visible = True
  c_getcond.Visible = False
  x_cond1.Visible = False
  [cb_serh].Visible = False
 ElseIf bnkout.Resultset![out_nature] = "2" Or bnkout.Resultset![out_nature] = "9" Then
  x_getcond.Visible = False
   c_getcond.Visible = True
   x_cond1.Visible = False
   c_operation.Visible = True
  [cb_serh].Visible = False

    d_type = bnkout.Resultset![out_nature]
    d_query = bnkout.Resultset![out_slct1]
    d_view = bnkout.Resultset![out_namcod]
    d_get = bnkout.Resultset![out_cod]
    d_cond = bnkout.Resultset![out_cond1]
   d_table = bnkout.Resultset![out_slct1]
   
   crit1 = " SELECT DISTINCTROW " & d_view
   crit11 = "," & d_get
   crit2 = " FROM " & d_query
   crit3 = " WHERE " & d_cond
   crit4 = " order by " & d_view
   
   If Trim$(d_cond) <> "1 = 1" Then
   CRIT = crit1 & crit11 & crit2 & crit3 & crit4
   Else
   CRIT = crit1 & crit11 & crit2 & crit4
   End If
  
  data2.SQL = CRIT
  data2.Refresh

    posit = InStr(1, d_view, "[")
    L = Len(d_view)
    d_view1 = Mid$(d_view, posit + 1, L - (posit + 1))
  
  posit1 = InStr(1, d_get, "field1")
 
  If posit1 <> 0 Then
  d_get1 = Mid(d_get, posit1, 6)
 
  Else
  
   posit = InStr(1, d_get, "[")
   L = Len(d_get)
   d_get1 = Mid$(d_get, posit + 1, L - (posit + 1))
   End If
   
   v_get = d_get1
   v_view = d_view1
   c_getcond.ListField = v_view
   c_getcond.BoundColumn = v_get
  
' ElseIf bnkout.resultset![out_nature] = "6" Then
'   MsgBox "we enter "
'  ElseIf bnkout.resultset![out_nature] = "6" Then
'     [x_getcond].Visible = False
'     [c_getcond].Visible = False
'     [x_cond1].Visible = True
'     [cb_serh].Visible = True
  
ElseIf bnkout.Resultset![out_nature] = "6" Then
   [cb_serh].Visible = True
    c_operation = "= "
    
      
End If




txt_display.Visible = False


End Sub

Private Sub c_listfields_LostFocus()
txt_display.Visible = False
End Sub

Private Sub c_listfields_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
  bnkout.Resultset.Bookmark = c_listfields.SelectedItem
  txt_display.Visible = True
  txt_display.text = IIf(IsNull(bnkout.Resultset![out_display]), "hh", bnkout.Resultset![out_display])

End Sub

Private Sub c_listfields_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
  bnkout.Resultset.Bookmark = c_listfields.SelectedItem
  txt_display.Visible = True
  txt_display.text = IIf(IsNull(bnkout.Resultset![out_display]), "hh", bnkout.Resultset![out_display])

End Sub

Private Sub c_listfields_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
  
  bnkout.Resultset.Bookmark = c_listfields.SelectedItem
  txt_display.Visible = True
  txt_display.text = IIf(IsNull(bnkout.Resultset![out_display]), "hh", bnkout.Resultset![out_display])

End Sub



Private Sub c_getcond_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF8 Then
   bnkout.Resultset.Bookmark = DBList3.SelectedItem
 If RTrim(bnkout.Resultset![out_slct1]) = "form" Or RTrim(bnkout.Resultset![out_slct1]) = "macnz" _
   Or RTrim(bnkout.Resultset![out_slct1]) = "main" Or RTrim(bnkout.Resultset![out_slct1]) = "auther" Or RTrim(bnkout.Resultset![out_slct1]) = "period" Then
     x_getcond.Visible = False
     x_cond1.Visible = False
     searcher.Visible = True
     m_key_serh = 1
     searcher.SetFocus
   End If
 ElseIf KeyCode = vbKeyF9 Then
 If RTrim(bnkout.Resultset![out_slct1]) = "form" Or RTrim(bnkout.Resultset![out_slct1]) = "macnz" _
   Or RTrim(bnkout.Resultset![out_slct1]) = "main" Or RTrim(bnkout.Resultset![out_slct1]) = "auther" Then
     x_getcond.Visible = False
     x_cond1.Visible = False
     searcher.Visible = True
     m_key_serh = 2
     searcher.SetFocus
   End If

 End If
End Sub

Private Sub c_getcond_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Call add_question
End If
End Sub

Private Sub cb_serh_Click()
'MsgBox [cb_serh].ListIndex
'   Dim cn As New rdoConnection
   Dim SQL As String
   Dim qd As rdoQuery
   Dim sql_query As String


If [cb_serh].ListIndex = 0 Then

     [x_getcond].Visible = False
     [c_getcond].Visible = False
     [x_cond1].Visible = True
     [cb_serh].Visible = True

Else
  x_getcond.Visible = False
   c_getcond.Visible = True
   x_cond1.Visible = False
   [cb_serh].Visible = True
    d_type = bnkout.Resultset![out_nature]
    d_query = bnkout.Resultset![out_slct1]
    d_view = bnkout.Resultset![out_namcod]
    d_get = bnkout.Resultset![out_cod]
    d_cond = bnkout.Resultset![out_cond1]
    d_table = bnkout.Resultset![out_slct1]
    'MsgBox "d_view=" & d_view
   ' MsgBox "d_get=" & d_get
  '  MsgBox "d_cond=" & d_cond
 '   MsgBox "d_query=" & d_query
   
   crit1 = " SELECT " & d_view
   crit11 = "," & d_get
   crit2 = " FROM " & d_query
   crit3 = " WHERE " & d_cond
   crit4 = " order by " & d_view
   
   If Trim$(d_cond) <> "1 = 1" Then
      'MsgBox "we enter"
   CRIT = crit1 & crit11 & crit2 & crit3 & crit4
   Else
   CRIT = crit1 & crit11 & crit2 & crit4
   End If
               
'             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'            cn.EstablishConnection rdDriverNoPrompt
            'cn.Execute SQL, rdExecDirect
            
   Set qd = cn.CreateQuery("view_abb", CRIT)
   data2.SQL = qd.SQL
   data2.Refresh

'  MsgBox "crit = " & crit

'If Not IsEmpty(d_view) And Not IsNull(d_view) And Not d_view = "" Then
    posit = InStr(1, d_view, "[")
    L = Len(d_view)
    d_view1 = Mid$(d_view, posit + 1, L - (posit + 1))
  
  posit1 = InStr(1, d_get, "field1")
  
  If posit1 <> 0 Then
  d_get1 = Mid(d_get, posit1, 6)
  
  Else
  
   posit = InStr(1, d_get, "[")
   L = Len(d_get)
   d_get1 = Mid$(d_get, posit + 1, L - (posit + 1))
   End If
   
   v_get = d_get1
   v_view = d_view1
'MsgBox "v_view = " & v_view
'MsgBox "v_get =" & v_get
   c_getcond.ListField = v_view
   c_getcond.BoundColumn = v_get
'  End If
  

End If

End Sub

Private Sub cmd_result_Click()
If nb_ad > 0 Then
' Screen.MousePointer = vbHourglass
 
' frm_result.WindowState = 2
' frm_result.Show
' Screen.MousePointer = vbDefault

Screen.MousePointer = vbHourglass
On Error Resume Next

'Dim MYTAB As Resultset
Dim tab1 As TableDef
Dim q1 As QueryDef
Dim CRIT As Variant
Dim MyRecordSource As String
Dim datax As Integer, datay As Integer, LabelX As Integer, LabelY As Integer
Dim MyForm As String, MyFormCreate As Form, MyLabel As Control, MYCONTROL As Control, cnt_nam As Control, disp_form As Form
Dim tab_list As TableDef
Dim f_field As Field
Dim lg2 As Variant
Dim m_out_len, m_out_num, m_out_slct1, m_out_rel, m_out_field, m_out_select, m_out_slct, m_out_nature As Variant
Dim m_out_fld, m_out_len1, m_out_indx1, m_out_cod, m_out_choice, m_out_vcod, m_out_desc, m_out_namcod, m_out_name As Variant
Dim m_slct_fld, m_out_typ, m_list_len, m_nb_fldout As Variant
Dim fin_innerjoin, db_acolad, tm_innerjoin As String
Dim lg1, i, j, k As Integer
'Dim cn As New rdoConnection
Dim SQL As String
Dim qd As rdoQuery
Dim sql_query As String
 

' Set mydb = DBEngine.Workspaces(0).OpenDatabase("c:\program files\gnr_prg\gnr_11.mdb")
' Set MYTAB = mydb.OpenResultSet("bnkout")

'   mydb.QueryDefs.Delete ("result")
'
'   MYTAB.MoveFirst
'   MYTAB.Index = "out_chioce"
'   MYTAB.Seek "=", 1
    count_slct1 = 0
    fin_innerjoin = ")"
     db_acolad = ""
    lg2 = 1
'  If Not MYTAB.NoMatch Then
     bnkout1.Resultset.MoveFirst
    While Not bnkout1.Resultset.EOF
      If bnkout1.Resultset![out_chioce] = 1 Then
      m_out_rel = bnkout1.Resultset![out_rel]
      m_out_select = bnkout1.Resultset![out_select]
      m_out_nature = bnkout1.Resultset![out_nature]
      m_out_slct1 = bnkout1.Resultset![out_slct1]
      m_out_cod = bnkout1.Resultset![out_cod]
      m_out_namcod = bnkout1.Resultset![out_namcod]
      m_out_desc = bnkout1.Resultset![OUT_desc]
      m_out_fld = bnkout1.Resultset![out_scond1]
      m_out_fld1 = bnkout1.Resultset![out_indx1]
      m_out_scond = bnkout1.Resultset![out_scond]
      
      
        lg1 = 1
        lg2 = 1
        lg3 = 1
        If count1 > 0 Then
            i = 1
              While i < count1 + 1 And lg1 = 1
                  If arr_table(i) = m_out_select Then
                     lg1 = 0
                  End If
                  i = i + 1
                 If lg1 <> 0 Then
                    For L = 1 To count_slct1
                     If arr_reltbl(L) = m_out_select Then
                        lg1 = 0
                      End If
                    Next
              End If
              Wend
        End If
    
      If lg1 = 1 Then
             count1 = count1 + 1
             arr_table1(count1) = m_out_select
             arr_table(count1) = m_out_select
             arr_fld_rel(count1) = m_out_rel
      End If
         If m_out_nature = 2 Then
            For L = 1 To count_slct1
               If arr_reltbl(L) = m_out_slct1 Then
                   lg2 = 0
                   lg3 = 0
              End If
             Next
            For L = 1 To count1
               If arr_table(L) = m_out_slct1 Then
                   lg2 = 0
              End If
             Next
             For L = 1 To count_rel
                If arr_reltbl(L) = m_out_slct1 Then
                  lg2 = 0
                 End If
             Next L
     If lg2 = 1 Then
         count_slct1 = count_slct1 + 1
         arr_reltbl(count_slct1) = m_out_slct1
         db_acolad = db_acolad & "("
         fin_innerjoin = fin_innerjoin & " inner join " & m_out_slct1 & " on " & m_out_fld & ")"
      End If
      If lg3 = 0 Then
          count_slct1 = count_slct1 + 1
         arr_reltbl(count_slct1) = m_out_slct1
         db_acolad = db_acolad & "("
         m_reltbl = m_out_slct1 & "_" & Trim(Str(count_slct1))
         m_tmp_join = m_out_slct1 & " as " & m_out_slct1 & "_" & Trim(Str(count_slct1)) & _
                 " on " & m_out_scond & " = " & m_reltbl & ".[" & m_out_fld1 & "]" & ")"
         fin_innerjoin = fin_innerjoin & " inner join " & m_tmp_join
         bnkout1.Resultset.Edit
         bnkout1.Resultset![out_indx12] = count_slct1
         bnkout1.Resultset.Update
         
         
         
         
      '     count1 = count1 + 1
      '     arr_table1(count1) = m_out_slct1
      '     arr_table(count1) = m_out_slct1
      '     arr_fld_rel(count1) = bnkout.Resultset![out_rel]
      '      If lg1 = 0 Then
      '          arr_table1(count1) = arr_table(count1) & " as " & arr_table(count1) & "_" & Trim(Str(count1))
      '          arr_table(count1) = arr_table(count1) & "_" & Trim(Str(count1))
      '        End If

      End If
      
      End If
      End If
       bnkout1.Resultset.MoveNext
       
    Wend
    
  If count_rel > 0 Then
    For L = 1 To count_rel
      db_acolad = db_acolad & "("
      fin_innerjoin = fin_innerjoin & " inner join " & arr_relition(L) & ")"
      
    Next
End If
  fin_innerjoin = Mid$(fin_innerjoin, 1, Len(fin_innerjoin) - 1)


'*****************************
'***************************************************************************************************
 j = 1
 k = 1
 If count1 > 1 Then
      tm_innerjoin = tm_innerjoin & arr_table1(1) & " inner join " & arr_table1(2) & " on " & "(" & arr_table(1) & ".[" & arr_fld_rel(1) & "]" & " = " & arr_table(2) & ".[" & arr_fld_rel(2) & "]" & ")" & ")"
       
       If arr_ind1(j) = 1 Then
         j = j + 1
         End If
          If arr_ind1(j) = 2 And arr_ind1(j) <> 0 Then
            If j > 1 Then
             tm_innerjoin = Mid$(tm_innerjoin, 1, Len(tm_innerjoin) - 1)
               tm_innerjoin = tm_innerjoin & " and " & " (" & arr_tbl(1) & ".[" & arr_rel1(1) & "]" & " = " & arr_tbl(2) & ".[" & arr_rel1(2) & "]" & ")" & ")"
            End If
              j = j + 1
           End If
           If arr_ind2(k) = 1 Then
             k = k + 1
            End If
          If arr_ind2(k) = 2 And arr_ind2(k) <> 0 Then
             If k > 1 Then
              tm_innerjoin = Mid$(tm_innerjoin, 1, Len(tm_innerjoin) - 1)
              tm_innerjoin = tm_innerjoin & " and " & " (" & arr_tbl(1) & ".[" & arr_rel2(1) & "]" & " = " & arr_tbl(2) & ".[" & arr_rel2(2) & "]" & ")" & ")"
              End If
              k = k + 1
           End If

   For i = 2 To count1 - 1

   ' If Trim(arr_table1(i + 1)) = "res" Then
   '   tm_innerjoin = "(" & tm_innerjoin & " left join " & arr_table1(i + 1) & " on " & "(" & arr_table(i) & ".[" & arr_fld_rel(i) & "]" & " = " & arr_table(i + 1) & ".[" & arr_fld_rel(i + 1) & "]" & ")" & ")"
   ' Else
     tm_innerjoin = "(" & tm_innerjoin & " inner join " & arr_table1(i + 1) & " on " & "(" & arr_table(i) & ".[" & arr_fld_rel(i) & "]" & " = " & arr_table(i + 1) & ".[" & arr_fld_rel(i + 1) & "]" & ")" & ")"
   ' End If
      If count2 > 1 And arr_ind1(j) = i + 1 And arr_ind1(j) <> 0 Then
        If j > 1 Then
          tm_innerjoin = Mid$(tm_innerjoin, 1, Len(tm_innerjoin) - 1)
           tm_innerjoin = tm_innerjoin & " and " & " (" & arr_tbl(j - 1) & ".[" & arr_rel1(j - 1) & "]" & " = " & arr_tbl(j) & ".[" & arr_rel1(j) & "]" & ")" & ")"
        End If
         j = j + 1
      End If
      If count3 > 1 And arr_ind2(k) = i + 1 And arr_ind2(k) <> 0 Then
        If k > 1 Then
            tm_innerjoin = Mid$(tm_innerjoin, 1, Len(tm_innerjoin) - 1)
            tm_innerjoin = tm_innerjoin & " and " & " (" & arr_tbl1(k - 1) & ".[" & arr_rel2(k - 1) & "]" & " = " & arr_tbl1(k) & ".[" & arr_rel2(k) & "]" & ")" & ")"
         End If
         k = k + 1
      End If
   Next
     tm_innerjoin = Mid$(tm_innerjoin, 1, Len(tm_innerjoin) - 1)
    tm_innerjoin = db_acolad & tm_innerjoin & fin_innerjoin
       
Else
  tm_innerjoin = arr_table(1)
  tm_innerjoin = tm_innerjoin & Mid(fin_innerjoin, 2, Len(fin_innerjoin) - 1)
  tm_innerjoin = Mid(db_acolad, 2, Len(db_acolad) - 1) & tm_innerjoin

 End If

'************************************************************************************


 '  MYTAB.Index = "out_chioce"
 '  MYTAB.Seek "=", 1
   m_slct_fld = ""
   m_list_len = ""
   m_nb_fldout = 0
  LG = 1
 '  If Not MYTAB.NoMatch Then
     bnkout1.Resultset.MoveFirst
       While Not bnkout1.Resultset.EOF
         If bnkout1.Resultset![out_chioce] = 1 Then
            LG = 2
             m_nb_fldout = m_nb_fldout + 1
             m_out_fld = bnkout1.Resultset![out_scond]
             m_out_slct = bnkout1.Resultset![out_select]
             m_out_len = bnkout1.Resultset![out_len]
             m_out_nature = bnkout1.Resultset![out_nature]
             m_out_slct1 = bnkout1.Resultset![out_slct1]
             m_out_cod = bnkout1.Resultset![out_cod]
             m_out_namcod = bnkout1.Resultset![out_namcod]
             m_out_desc = bnkout1.Resultset![OUT_desc]
             m_out_name = bnkout1.Resultset![OUT_name]
             m_out_indx12 = bnkout1.Resultset![out_indx12]
            m_out_namcod1 = bnkout1.Resultset![out_namcod1]

             m_list_len = m_list_len & Str(m_out_len) & "cm;"
             If m_out_nature = 2 Then
                If m_out_indx12 = 0 Then
                    m_slct_fld = m_slct_fld & m_out_namcod & " as " & "[" & m_out_name & "]" & ", "
                 Else
                   m_slct_fld = m_slct_fld & m_out_slct1 & "_" & Trim(Str(m_out_indx12)) & ".[" & m_out_namcod1 & "]" & " as " & "[" & m_out_name & "]" & ", "
                   bnkout1.Resultset.Edit
                   bnkout1.Resultset![out_indx12] = 0
                    bnkout1.Resultset.Update
                                     
                 End If
             Else
                m_slct_fld = m_slct_fld & m_out_fld & " as " & "[" & m_out_name & "]" & ", "
             End If
        End If
          bnkout1.Resultset.MoveNext
          
       Wend
       If LG = 2 Then
         m_slct_fld = Mid$(m_slct_fld, 1, (Len(m_slct_fld) - 2))
         m_slct_fld = "select distinct " & m_slct_fld
       End If

     
m_crit1 = m_slct_fld & " from " & tm_innerjoin & " where " & tm_criteria

'''''''''
 ' MYTAB.Index = "out_chio1"
 '  MYTAB.Seek "=", 1
   m_indx_fld = ""
   LG = 1
 '  If Not MYTAB.NoMatch Then
 bnkout1.Resultset.MoveFirst
 
       While Not bnkout1.Resultset.EOF
         If bnkout1.Resultset![out_chio1] = 1 Then
             LG = 2
             m_out_nature = bnkout1.Resultset![out_nature]
             m_out_namcod = bnkout1.Resultset![out_namcod]
             m_out_fld = bnkout1.Resultset![out_scond]
             If m_out_nature = 2 Then
                 m_indx_fld = m_indx_fld & m_out_namcod & ", "
             Else
                m_indx_fld = m_indx_fld & m_out_fld & ", "
             End If
          End If
              bnkout1.Resultset.MoveNext
       Wend
       If LG = 2 Then
          m_indx_fld = Mid$(m_indx_fld, 1, (Len(m_indx_fld) - 2))
          m_indx_fld = "order by " & m_indx_fld
        End If
        
        
        
        'MsgBox "indx = " & m_indx_fld
   'End If
'Me![m_crit1] = m_slct_fld & tm_innerjoin & " where " & tm_criteria

CRIT = m_crit1
CRIT = m_crit1 & m_indx_fld & ";"

''''''''''



MsgBox "crit = " & CRIT


If main_form = 1 Then
'             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'            cn.EstablishConnection rdDriverNoPrompt
        SQL = "drop proc tmp_result"
            cn.Execute SQL, rdExecDirect
'   MsgBox "delete proc "
        CRIT = "create proc tmp_result as " & CRIT
               cn.Execute CRIT, rdExecDirect
            
      Set qd = cn.CreateQueryDef("view_abb1", "{call tmp_result()}")
    ' result.SQL = qd.SQL
    ' result.Refresh


'Set q1 = mydb.CreateQueryDef("result", crit)



'*****************************************


'DoCmd.DeleteObject A_FORM, "form1"



ElseIf main_form = 2 Then
'             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'            cn.EstablishConnection rdDriverNoPrompt
        SQL = "drop proc tmp_result1"
            cn.Execute SQL, rdExecDirect
'   MsgBox "delete proc "
        CRIT = "create proc tmp_result1 as " & CRIT
               cn.Execute CRIT, rdExecDirect
            
      Set qd = cn.CreateQueryDef("view_abb1", "{call tmp_result1()}")
'     result.SQL = qd.SQL
'    result.Refresh

'Set q1 = mydb.CreateQueryDef("result", crit)



'*****************************************


'DoCmd.DeleteObject A_FORM, "form1"



' Screen.MousePointer = vbDefault
'
       
' Screen.MousePointer = vbHourglass
'
' Form8.WindowState = 2
' Form8.Show
' Screen.MousePointer = vbDefault
'
ElseIf main_form = 3 Then
'             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'            cn.EstablishConnection rdDriverNoPrompt
        SQL = "drop proc tmp_result2"
            cn.Execute SQL, rdExecDirect
'   MsgBox "delete proc "
        CRIT = "create proc tmp_result2 as " & CRIT
               cn.Execute CRIT, rdExecDirect
            
      Set qd = cn.CreateQueryDef("view_abb1", "{call tmp_result2()}")

ElseIf main_form = 4 Then

'             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'            cn.EstablishConnection rdDriverNoPrompt
        SQL = "drop proc tmp_result3"
            cn.Execute SQL, rdExecDirect
        CRIT = "create proc tmp_result3 as " & CRIT
               cn.Execute CRIT, rdExecDirect
            
      Set qd = cn.CreateQueryDef("view_abb1", "{call tmp_result()}")
ElseIf main_form = 5 Then

'             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'            cn.EstablishConnection rdDriverNoPrompt
        SQL = "drop proc tmp_result4"
            cn.Execute SQL, rdExecDirect
        CRIT = "create proc tmp_result4 as " & CRIT
               cn.Execute CRIT, rdExecDirect
            
      Set qd = cn.CreateQueryDef("view_abb1", "{call tmp_result()}")
ElseIf main_form = 6 Then

'             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'            cn.EstablishConnection rdDriverNoPrompt
        SQL = "drop proc tmp_result5"
            cn.Execute SQL, rdExecDirect
        CRIT = "create proc tmp_result5 as " & CRIT
               cn.Execute CRIT, rdExecDirect
            
      Set qd = cn.CreateQueryDef("view_abb1", "{call tmp_result()}")

End If
 Screen.MousePointer = vbDefault

       
 Screen.MousePointer = vbHourglass
 
 view_res2.WindowState = 2
 view_res2.Show
 
 Screen.MousePointer = vbDefault

Else
MsgBox "·« ÌÊÃœ ÃÊ«» ·«‰Â ·„  ÿ·» ”Ê«· "
End If

End Sub

Private Sub Command1_Click()
Unload sort_form
End Sub

Private Sub Command2_Click()
 'result = crst_rep1.PrintReport
' MsgBox result%
End Sub

 

Private Sub Command8_Click()
   
   Dim posit, posit1, L, l1 As Integer
   Dim str1, str2, d_type, d_query, d_view, d_view1, d_get, d_get1, d_get2, d_cond, d_table As Variant
   Dim CRIT, crit1, crit11, crit2, crit3 As String
     
    
    bnkout.Resultset.Bookmark = c_listfields.SelectedItem
    
    
    v_bookmark1 = bnkout.Resultset![out_num]
    
 If bnkout.Resultset![out_nature] = "1" Then
   
   x_getcond.Visible = True
   c_getcond.Visible = False
  
 
 
 ElseIf bnkout.Resultset![out_nature] = "3" Then
     
  x_getcond.Visible = True
  c_getcond.Visible = False

 
 ElseIf bnkout.Resultset![out_nature] = "2" Then
   
   x_getcond.Visible = False
   c_getcond.Visible = True
  
    d_type = bnkout.Resultset![out_nature]
    d_query = bnkout.Resultset![out_slct1]
    d_view = bnkout.Resultset![out_namcod]
    d_get = bnkout.Resultset![out_cod]
    d_cond = bnkout.Resultset![out_cond1]
    d_table = bnkout.Resultset![out_slct1]
    

   crit1 = " SELECT DISTINCTROW " & d_view
   crit11 = "," & d_get
   crit2 = " FROM " & d_query
   crit3 = " WHERE " & d_cond
   If Trim$(d_cond) <> "1 = 1" Then
   CRIT = crit1 & crit11 & crit2 & crit3
   Else
    CRIT = crit1 & crit11 & crit2
   End If
  
     
'   MsgBox "crit = " & crit
  data2.SQL = CRIT
  data2.Refresh

 
  
    posit = InStr(1, d_view, "[")
    L = Len(d_view)
    d_view1 = Mid$(d_view, posit + 1, L - (posit + 1))
  
  posit1 = InStr(1, d_get, "field1")
  
  If posit1 <> 0 Then
  d_get1 = Mid(d_get, posit1, 6)
  
  Else
  
   posit = InStr(1, d_get, "[")
   L = Len(d_get)
   d_get1 = Mid$(d_get, posit + 1, L - (posit + 1))
   End If
   v_get = d_get1
   v_view = d_view1
   
   c_getcond.ListField = v_view
   c_getcond.BoundColumn = v_get

      
End If

End Sub
Private Sub DBList2_Click()
  BNKOUT2.Resultset.Bookmark = DBList2.SelectedItem
   BNKOUT2.Resultset.Edit
  If BNKOUT2.Resultset![out_chioce] = 1 Then
    BNKOUT2.Resultset![out_chioce] = 2
    BNKOUT2.Resultset![OUT_desc] = Mid(BNKOUT2.Resultset![OUT_desc], 3, Len(BNKOUT2.Resultset![OUT_desc]) - 2)
  Else
     BNKOUT2.Resultset![out_chioce] = 1
     BNKOUT2.Resultset![OUT_desc] = "# " + BNKOUT2.Resultset![OUT_desc]
     
  End If
  BNKOUT2.Resultset.Update
  BNKOUT2.Refresh
  bnkout.Refresh
  BNKOUT2.Refresh
  bnkout1.Refresh
End Sub

Private Sub dblist3_click()
   Dim posit, posit1, L, l1 As Integer
   Dim str1, str2, d_type, d_query, d_view, d_view1, d_get, d_get1, d_get2, d_cond, d_table As Variant
   Dim CRIT, crit1, crit11, crit2, crit3 As String
   Dim mydate As Variant
'   Dim cn As New rdoConnection
   Dim SQL As String
   Dim qd As rdoQuery
   Dim sql_query As String
 
   searcher.text = ""
   x_getcond = " "
'     txt_display.Visible = True
    bnkout.Resultset.Bookmark = DBList3.SelectedItem
    

    v_bookmark1 = bnkout.Resultset![out_num]
 If bnkout.Resultset![out_nature] = "1" Or bnkout.Resultset![out_nature] = "8" Or bnkout.Resultset![out_nature] = "0" Then
 '  x_getcond.Text = ""
   x_getcond.Visible = True
  ' c_getcond.Visible = False
   x_cond1.Visible = False
   [cb_serh].Visible = False
   searcher.Visible = False
   x_getcond.SetFocus
   
 
 
 ElseIf bnkout.Resultset![out_nature] = "3" Then
  ' mydate = Date
  x_getcond = Date
  'Format(mydate, "  /  /  ")
    
  x_getcond.Visible = True
  'c_getcond.Visible = False
  searcher.Visible = False
  x_cond1.Visible = False
  [cb_serh].Visible = False
  x_getcond.SetFocus
 ElseIf bnkout.Resultset![out_nature] = "2" Or bnkout.Resultset![out_nature] = "9" _
    Or bnkout.Resultset![out_nature] = "6" Then
    searcher.Visible = True
'  x_getcond.Visible = False
   c_getcond.Visible = True
   x_cond1.Visible = True
   c_operation.Visible = True
  [cb_serh].Visible = False

    d_type = bnkout.Resultset![out_nature]
    d_query = bnkout.Resultset![out_slct1]
    d_view = bnkout.Resultset![out_namcod]
    d_get = bnkout.Resultset![out_cod]
    d_cond = bnkout.Resultset![out_cond1]
   d_table = bnkout.Resultset![out_slct1]
   
   crit1 = " SELECT " & d_view
   crit11 = "," & d_get
   crit2 = " FROM " & d_query
   crit3 = " WHERE " & d_cond
   crit4 = " order by " & d_view
   
   If Trim$(d_cond) <> "1 = 1" Then
   CRIT = crit1 & crit11 & crit2 & crit3 & crit4
   Else
   CRIT = crit1 & crit11 & crit2 & crit4
   End If
  
  
             
'             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'            cn.EstablishConnection rdDriverNoPrompt
            'cn.Execute SQL, rdExecDirect
            
   Set qd = cn.CreateQuery("view_abb", CRIT)
   data2.SQL = qd.SQL
   
   data2.Refresh
    
  
  

    posit = InStr(1, d_view, "[")
    L = Len(d_view)
    d_view1 = Mid$(d_view, posit + 1, L - (posit + 1))
  
  posit1 = InStr(1, d_get, "field1")
 
  If posit1 <> 0 Then
  d_get1 = Mid(d_get, posit1, 6)
 
  Else
  
   posit = InStr(1, d_get, "[")
   d_get = Trim(d_get)
   L = Len(d_get)
   d_get1 = Mid$(d_get, posit + 1, L - (posit + 1))
   End If
   
   v_get = d_get1
   v_view = d_view1
   c_getcond.ListField = v_view
   c_getcond.BoundColumn = v_get
   c_getcond.SetFocus
   SendKeys "{up}"
' ElseIf bnkout.resultset![out_nature] = "6" Then
'   MsgBox "we enter "
'  ElseIf bnkout.resultset![out_nature] = "6" Then
'     [x_getcond].Visible = False
'     [c_getcond].Visible = False
'     [x_cond1].Visible = True
'     [cb_serh].Visible = True
  
'ElseIf bnkout.Resultset![out_nature] = "6" Then
'   [cb_serh].Visible = False
'    c_operation = "= "
'    c_operation.Visible = False
    
    
    
      
End If




'txt_display.Visible = False



End Sub

Public Function add_question()
   On Error Resume Next
 Dim m_getcond, m_getcond1 As Variant
 Dim i, lg1 As Integer
 m_getcond = ""
 If nb_and + nb_or = nb_ad Then
 'x_string = strin("right(x_criteria , 1) , ('/',')','(')")
 
 'If x_string And Me![x_criteria] <> "" Then
 '  MsgBox "ÌÃ» «œŒ«· «·„⁄«œ·…"
 '  Exit Sub
 'End If
 nb_ad = nb_ad + 1
bnkout.Resultset.Bookmark = v_bookmark1
 
 If bnkout.Resultset![out_nature] = "1" Or bnkout.Resultset![out_nature] = "8" Or bnkout.Resultset![out_nature] = "0" Then
   m_getcond = Trim(x_getcond)
   m_getcond1 = Trim(x_getcond)
    
 ElseIf bnkout.Resultset![out_nature] = "3" Then
   m_getcond = x_getcond
   m_getcond1 = x_getcond
 
 ElseIf bnkout.Resultset![out_nature] = "2" Or bnkout.Resultset![out_nature] = "6" Or bnkout.Resultset![out_nature] = "9" Then
'MsgBox c_getcond.BoundColumn

   m_getcond1 = c_getcond.BoundText
   m_getcond = c_getcond
     
End If
 
 If IsNull(c_operation) Or IsNull(m_getcond) Or m_getcond = "" Then
   MsgBox "INVALID CONDITION"
 Else
     lg1 = 1
    If count1 > 0 Then
       i = 1
       While i < count1 + 1 And lg1 = 1
           If arr_table(i) = bnkout.Resultset![out_select] Then
                lg1 = 0
            End If

            i = i + 1
        Wend
     End If
        If lg1 = 1 Or bnkout.Resultset![out_RCRN] = "2" Then
        
           count1 = count1 + 1
           arr_table1(count1) = bnkout.Resultset![out_select]
           arr_table(count1) = bnkout.Resultset![out_select]
           arr_fld_rel(count1) = bnkout.Resultset![out_rel]
            If lg1 = 0 Then
                arr_table1(count1) = arr_table(count1) & " as " & arr_table(count1) & "_" & Trim(Str(count1))
                arr_table(count1) = arr_table(count1) & "_" & Trim(Str(count1))
              End If

           If Not IsEmpty(bnkout.Resultset![out_REL1]) And Not IsNull(bnkout.Resultset![out_REL1]) And Not bnkout.Resultset![out_REL1] = "" Then
              count2 = count2 + 1
              arr_rel1(count2) = bnkout.Resultset![out_REL1]
              arr_ind1(count2) = count1
              arr_tbl(count2) = bnkout.Resultset![out_select]
              If lg1 = 0 Then
                  arr_tbl(count2) = arr_table(count1)
              End If
              
           End If
           If Not IsEmpty(bnkout.Resultset![out_REL2]) And Not IsNull(bnkout.Resultset![out_REL2]) And Not bnkout.Resultset![out_REL2] = "" Then
              count3 = count3 + 1
              arr_rel2(count3) = bnkout.Resultset![out_REL2]
              arr_ind2(count3) = count1
              arr_tbl1(count3) = bnkout.Resultset![out_select]
              If lg1 = 0 Then
                  arr_tbl1(count3) = arr_table(count1)
              End If
              
        End If
       End If

 End If
       If bnkout.Resultset![out_nature] = "8" Or bnkout.Resultset![out_nature] = "9" Then
           lg4 = 1
            If count_rel > 0 Then
              i = 1
             While i < count_rel + 1 And lg4 = 1
                If arr_reltbl(i) = bnkout.Resultset![out_mcond1] Then
                  lg4 = 0
                 End If
                 i = i + 1
             Wend
           End If
          If lg4 = 1 Then
            count_rel = count_rel + 1
            arr_relition(count_rel) = bnkout.Resultset![out_scond1]
            arr_reltbl(count_rel) = bnkout.Resultset![out_mcond1]
          End If
    End If

 ' *********************************************************
   Select Case bnkout.Resultset![out_TYP]
   Case "C"
      If bnkout.Resultset![out_nature] = "0" Then
       tm_criteria = tm_criteria & " (" & bnkout.Resultset![out_scond] & " LIKE " & "'" & "%" & m_getcond1 & "%" & "'"
         x_criteria = x_criteria & " (" & bnkout.Resultset![out_cond] & " LIKE " & "'" & "%" & m_getcond1 & "%" & "'"
      Else
       x_criteria = x_criteria & "[" & bnkout.Resultset![out_cond] & "]" & c_operation & "'" & m_getcond & "'"
      If bnkout.Resultset![out_RCRN] = "1" Or lg1 = 1 Then
         If Not IsEmpty(Trim(bnkout.Resultset![out_mcond])) And Not IsNull(bnkout.Resultset![out_mcond]) And Not Trim(bnkout.Resultset![out_mcond]) = "" Then
             nw_getcond1 = Mid(m_getcond1, bnkout.Resultset![out_mcond1], bnkout.Resultset![out_mcond])
             tm_criteria = tm_criteria & " (" & bnkout.Resultset![out_scond] & c_operation & "'" & nw_getcond1 & "'"
           Else
            tm_criteria = tm_criteria & " (" & bnkout.Resultset![out_scond] & c_operation & "'" & m_getcond1 & "'"
          End If
      Else
        If Not IsEmpty(Trim(bnkout.Resultset![out_mcond])) And Not IsNull(bnkout.Resultset![out_mcond]) And Not Trim(bnkout.Resultset![out_mcond]) = "" Then
             nw_getcond1 = Mid(m_getcond1, bnkout.Resultset![out_mcond1], bnkout.Resultset![out_mcond])
             tm_criteria = tm_criteria & " (" & "substring(" & arr_table(count1) & "." & bnkout.Resultset![OUT_field] & _
             "," & bnkout.Resultset![out_mcond1] & "," & bnkout.Resultset![out_mcond] & ")" & c_operation & "'" & nw_getcond1 & "'"
           Else
                  tm_criteria = tm_criteria & " (" & arr_table(count1) & "." & bnkout.Resultset![OUT_field] & c_operation & "'" & m_getcond1 & "'"
          End If
'      tm_criteria = tm_criteria & arr_table(count1) & "." & bnkout.resultset![out_field] & Me![c_operation] & "'" & m_getcond1 & "'"
'      MsgBox tm_criteria
       End If
     End If

   Case "N"
     x_criteria = x_criteria & "[" & bnkout.Resultset![out_cond] & "]" & c_operation & m_getcond
     'tm_criteria = tm_criteria & Me![c_listfields].column(11) & ".[" & Me![c_listfields].column(4) & "]" & Me![C_OPERATION] & m_getcond1
     If bnkout.Resultset![out_RCRN] = "1" Or lg1 = 1 Then
         tm_criteria = tm_criteria & " (" & bnkout.Resultset![out_scond] & c_operation & m_getcond1
     Else
         tm_criteria = tm_criteria & " (" & arr_table(count1) & "." & bnkout.Resultset![OUT_field] & c_operation & m_getcond1
     End If


   Case "D"
       x_criteria = x_criteria & "[" & bnkout.Resultset![out_cond] & "]" & c_operation & "#" & Format(m_getcond, "dd/mm/yyyy") & "#"
       If bnkout.Resultset![out_RCRN] = "1" Or lg1 = 1 Then
          tm_criteria = tm_criteria & " (" & bnkout.Resultset![out_scond] & c_operation & "convert(datetime," & "'" & Format(m_getcond1, "yyyy-mm-dd") & "'" & "," & "102)"
       Else
           tm_criteria = tm_criteria & " (" & arr_table(count1) & "." & bnkout.Resultset![OUT_field] & Me![c_operation] & "convert(datetime," & "'" & Format(m_getcond1, "yyyy-mm-dd") & "'" & "," & "102)"
        End If
   
   End Select
    If Not IsEmpty(bnkout.Resultset![out_REL3]) And Not IsNull(bnkout.Resultset![out_REL3]) And Not bnkout.Resultset![out_REL3] = "" Then
        tm_criteria = tm_criteria & " and " & arr_table(count1) & "." & bnkout.Resultset![out_REL3]
     
    End If
    If Not IsEmpty(bnkout.Resultset![out_T2]) And Not IsNull(bnkout.Resultset![out_T2]) And Not Trim(bnkout.Resultset![out_T2]) = "" Then
          tm_criteria = tm_criteria & " and " & arr_table(count1) & "." & bnkout.Resultset![out_T2]
    End If
 
 x_getcond = ""
 c_getcond = ""
 tm_criteria = tm_criteria & " )"
' *********************************************************

Else
 MsgBox "·«Ì„ﬂ‰ «÷«›… ”ƒ«· «Œ— «·« »⁄œ «÷«›… /Ê/ ,/«Ê/"
End If
  
End Function

Private Sub DBCombo1_Click(Area As Integer)
   Dim posit, posit1, L, l1 As Integer
   Dim str1, str2, d_type, d_query, d_view, d_view1, d_get, d_get1, d_get2, d_cond, d_table As Variant
   Dim CRIT, crit1, crit11, crit2, crit3 As String
   Dim mydate As Variant
'   Dim cn As New rdoConnection
   Dim SQL As String
   Dim qd As rdoQuery
   Dim sql_query As String
 
   searcher.text = ""
   x_getcond = " "
'     txt_display.Visible = True
    bnkout.Resultset.Bookmark = DBCombo1.SelectedItem
    
    

    v_bookmark1 = bnkout.Resultset![out_num]
 If bnkout.Resultset![out_nature] = "1" Or bnkout.Resultset![out_nature] = "8" Or bnkout.Resultset![out_nature] = "0" Then
 '  x_getcond.Text = ""
   x_getcond.Visible = True
  ' c_getcond.Visible = False
   x_cond1.Visible = False
   [cb_serh].Visible = False
   searcher.Visible = False
   x_getcond.SetFocus
   
 
 
 ElseIf bnkout.Resultset![out_nature] = "3" Then
  ' mydate = Date
  x_getcond = Date
  'Format(mydate, "  /  /  ")
    
  x_getcond.Visible = True
  'c_getcond.Visible = False
  searcher.Visible = False
  x_cond1.Visible = False
  [cb_serh].Visible = False
  x_getcond.SetFocus
 ElseIf bnkout.Resultset![out_nature] = "2" Or bnkout.Resultset![out_nature] = "9" _
    Or bnkout.Resultset![out_nature] = "6" Then
    searcher.Visible = True
'  x_getcond.Visible = False
   c_getcond.Visible = True
   x_cond1.Visible = True
   c_operation.Visible = True
  [cb_serh].Visible = False

    d_type = bnkout.Resultset![out_nature]
    d_query = bnkout.Resultset![out_slct1]
    d_view = bnkout.Resultset![out_namcod]
    d_get = bnkout.Resultset![out_cod]
    d_cond = bnkout.Resultset![out_cond1]
   d_table = bnkout.Resultset![out_slct1]
   
   crit1 = " SELECT " & d_view
   crit11 = "," & d_get
   crit2 = " FROM " & d_query
   crit3 = " WHERE " & d_cond
   crit4 = " order by " & d_view
   
   If Trim$(d_cond) <> "1 = 1" Then
   CRIT = crit1 & crit11 & crit2 & crit3 & crit4
   Else
   CRIT = crit1 & crit11 & crit2 & crit4
   End If
  
  
             
'             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'            cn.EstablishConnection rdDriverNoPrompt
            'cn.Execute SQL, rdExecDirect
            
   Set qd = cn.CreateQuery("view_abb", CRIT)
   data2.SQL = qd.SQL
   
   data2.Refresh
    
  
  

    posit = InStr(1, d_view, "[")
    L = Len(d_view)
    d_view1 = Mid$(d_view, posit + 1, L - (posit + 1))
  
  posit1 = InStr(1, d_get, "field1")
 
  If posit1 <> 0 Then
  d_get1 = Mid(d_get, posit1, 6)
 
  Else
  
   posit = InStr(1, d_get, "[")
   d_get = Trim(d_get)
   L = Len(d_get)
   d_get1 = Mid$(d_get, posit + 1, L - (posit + 1))
   End If
   
   v_get = d_get1
   v_view = d_view1
   c_getcond.ListField = v_view
   c_getcond.BoundColumn = v_get
   c_getcond.SetFocus
   SendKeys "{up}"
    
    
      
End If




'txt_display.Visible = False





End Sub

Private Sub Form_Load()
'Dim cn As New rdoConnection
   Dim SQL As String
   Dim qd As rdoQuery
   Dim var_ist As Variant
   
bnkout.Connect = m_connect
BNKOUT2.Connect = m_connect
data2.Connect = m_connect
result.Connect = m_connect
   
 bnkout.DataSourceName = M_SQL_NAM
 BNKOUT2.DataSourceName = M_SQL_NAM
 result.DataSourceName = M_SQL_NAM
 data2.DataSourceName = M_SQL_NAM
   
 x_criteria = ""
  x_getcond = ""
  cb_serh = ""
  c_listfields = ""
  c_operation = "="
 ' c_getcond.Visible = False
  x_getcond.Visible = True
  x_getcond = ""
   cb_serh.Visible = False
'crst_rep1.Action = 2
'[main_frm].crst_rep1.Destination = 1
'[main_frm].crst_rep1.Destination = 0
   
   
   
  'Me![x_getcond].Format = ""
  'Me![x_getcond].InputMask = ""
  count1 = 0
  count2 = 0
  count3 = 0
  count_slct1 = 0
   nb_ad = 0
   nb_or = 0
   nb_and = 0
  L = 0
  For L = 1 To 20
   arr_ind1(L) = 0
   arr_ind2(L) = 0
  Next
  
  M_CRITERIA = ""
  tm_criteria = ""
  m_selectuse = False
  'sql = ""
 
  m_if1 = 1
  m_if2 = 2
'If ARCHIVE.f2.Checked = True Then
If main_form = 1 Then
   bnkout.SQL = "select * from bnkout where (out_if = 1 or out_if = 3 or out_if = 4) order by out_indx3"
   BNKOUT2.SQL = "select * from bnkout where (out_chioce = 1 or out_chioce = 2) order by out_indx"
   CRIT = "select bnkout.* from bnkout where out_chioce = " & "'" & m_if1 & "'"
   bnkout1.SQL = CRIT
   
'ElseIf ARCHIVE.f3.Checked = True Then
ElseIf main_form = 2 Then
 var_ist = "02"
  CRIT = "select pout.* from pout"
  CRIT = CRIT & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_if = " & "'" & m_if1 & "'" & " or out_if = " & "'" & m_if2 & "'" & " )"
  
  bnkout.SQL = CRIT
  crit1 = "select pout.* from pout"
  crit1 = crit1 & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_chioce = " & "'" & m_if1 & "'" & " or out_chioce = " & "'" & m_if2 & "'" & " )"
  BNKOUT2.SQL = crit1
  crit2 = "select pout.* from pout"
  crit2 = crit2 & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_chioce = " & "'" & m_if1 & "'" & " )"
  bnkout1.SQL = crit2
'ElseIf ARCHIVE.f4.Checked = True Then
ElseIf main_form = 3 Then
  var_ist = "01"
  CRIT = "select pout.* from pout"
  CRIT = CRIT & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_if = " & "'" & m_if1 & "'" & " or out_if = " & "'" & m_if2 & "'" & " )"
  
  bnkout.SQL = CRIT
  crit1 = "select pout.* from pout"
  crit1 = crit1 & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_chioce = " & "'" & m_if1 & "'" & " or out_chioce = " & "'" & m_if2 & "'" & " )"
  BNKOUT2.SQL = crit1
  crit2 = "select pout.* from pout"
  crit2 = crit2 & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_chioce = " & "'" & m_if1 & "'" & " )"
  bnkout1.SQL = crit2
'ElseIf ARCHIVE.f5.Checked = True Then
ElseIf main_form = 4 Then
   bnkout.SQL = "select * from bnkout where (out_if = 3 or out_if = 4) order by out_indx3"
   BNKOUT2.SQL = "select * from bnkout where (out_chioce = 1 or out_chioce = 2) order by out_indx"
   CRIT = "select bnkout.* from bnkout where out_chioce = " & "'" & m_if1 & "'"
   bnkout1.SQL = CRIT
ElseIf main_form = 5 Then
  var_ist = "03"
  CRIT = "select pout.* from pout"
  CRIT = CRIT & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_if = " & "'" & m_if1 & "'" & " or out_if = " & "'" & m_if2 & "'" & " )"
  
  bnkout.SQL = CRIT
  crit1 = "select pout.* from pout"
  crit1 = crit1 & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_chioce = " & "'" & m_if1 & "'" & " or out_chioce = " & "'" & m_if2 & "'" & " )"
  BNKOUT2.SQL = crit1
  crit2 = "select pout.* from pout"
  crit2 = crit2 & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_chioce = " & "'" & m_if1 & "'" & " )"
  bnkout1.SQL = crit2
ElseIf main_form = 6 Then
  var_ist = "04"
  CRIT = "select pout.* from pout"
  CRIT = CRIT & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_if = " & "'" & m_if1 & "'" & " or out_if = " & "'" & m_if2 & "'" & " )"
  
  bnkout.SQL = CRIT
  crit1 = "select pout.* from pout"
  crit1 = crit1 & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_chioce = " & "'" & m_if1 & "'" & " or out_chioce = " & "'" & m_if2 & "'" & " )"
  BNKOUT2.SQL = crit1
  crit2 = "select pout.* from pout"
  crit2 = crit2 & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_chioce = " & "'" & m_if1 & "'" & " )"
  bnkout1.SQL = crit2


End If
bnkout.Refresh
BNKOUT2.Refresh
bnkout1.Refresh

End Sub

Private Sub MSIPrint1_GotFocus()

End Sub

Private Sub Form_Unload(Cancel As Integer)
 'Archive.f3.Checked = False
 'Archive.f2.Checked = False
 'Archive.f4.Checked = False
 'Archive.f5.Checked = False
 
End Sub


Private Sub searcher_KeyPress(KeyAscii As Integer)
 Select Case KeyAscii
   Case 13
    bnkout.Resultset.Bookmark = DBList3.SelectedItem
    
If m_key_serh = 1 Then
 If RTrim(bnkout.Resultset![out_slct1]) = "form" Then
         m_desc = searcher.text
         m_len = Len(Trim(searcher))
         data2.SQL = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        data2.Refresh
        c_getcond.BoundColumn = "sub_cod"
  ElseIf RTrim(bnkout.Resultset![out_slct1]) = "macnz" Then
       m_desc = searcher.text
       m_len = Len(Trim(m_desc))
        data2.SQL = "execute serh_macnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        c_getcond.BoundColumn = "sub_code"
        data2.Refresh

    ElseIf RTrim(bnkout.Resultset![out_slct1]) = "auther" Then
         m_desc = searcher.text
         m_len = Len(Trim(m_desc))
         data2.SQL = "execute serh_auther " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         
         data2.Refresh
         c_getcond.BoundColumn = "no_auther"
         
  ElseIf RTrim(bnkout.Resultset![out_slct1]) = "period" Then
       m_desc = searcher.text
       m_len = Len(Trim(m_desc))
        data2.SQL = "execute serh_period " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        c_getcond.BoundColumn = "per_per_no"
        data2.Refresh
        
ElseIf RTrim(bnkout.Resultset![out_slct1]) = "main" Then
      m_desc = searcher.text
      m_len = Len(Trim(m_desc))
      m_typ_ist = "ﬂ"
      m_typ_ist1 = "Ê"
   If Not IsNull(m_desc) And Not Trim(m_desc) = "" Then
       data2.SQL = "exec SERH_main " & "'" & m_desc & "'" & "," & "'" & m_len & "'" & _
                           "," & "'" & m_typ_ist & "'" & "," & "'" & m_typ_ist1 & "'"
                          
      data2.Refresh
      c_getcond.BoundColumn = "mn_app_no"
      
    End If
End If
ElseIf m_key_serh = 2 Then
If RTrim(bnkout.Resultset![out_slct1]) = "form" Then
         m_desc = searcher.text
         m_len = Len(Trim(searcher))
        data2.SQL = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        data2.Refresh
        c_getcond.BoundColumn = "sub_cod"
  ElseIf RTrim(bnkout.Resultset![out_slct1]) = "macnz" Then
       m_desc = searcher.text
       m_len = Len(Trim(m_desc))
        data2.SQL = "execute serh_wrdmacnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        c_getcond.BoundColumn = "sub_code"
        data2.Refresh

    ElseIf RTrim(bnkout.Resultset![out_slct1]) = "auther" Then
         m_desc = searcher.text
         m_len = Len(Trim(m_desc))
          data2.SQL = "execute serh_auther2 " & "'" & m_desc & "'"
         data2.Refresh
         c_getcond.BoundColumn = "aut_no"
         
ElseIf RTrim(bnkout.Resultset![out_slct1]) = "main" Then
      m_desc = searcher.text
      m_len = Len(Trim(m_desc))
   If Not IsNull(m_desc) And Not Trim(m_desc) = "" Then
       data2.SQL = "exec SERH_wrd_main " & "'" & m_desc & "'"
      data2.Refresh
      c_getcond.BoundColumn = "mn_app_no"
      
    End If
End If
End If
    c_getcond.Refresh
      c_getcond.SetFocus
  
  End Select
   
  

End Sub

Private Sub x_add_Click()
  Call add_question
End Sub

Private Sub x_and_Click()
 On Error Resume Next
 If nb_and + nb_or < nb_ad Then
  If Right(Me![x_criteria], 1) <> "/" And Me![x_criteria] <> "" Then
    Me![x_criteria] = Me![x_criteria] & " " & " /Ê/ "
    tm_criteria = tm_criteria & " AND "
    nb_and = nb_and + 1
  End If
  Else
   If nb_and + nb_or = 0 Then
    MsgBox "·«Ì„ﬂ‰ «÷«›… /Ê/ ﬁ»· «Œ Ì«— «·”ƒ«·"
   Else
     MsgBox "·« Ì„ﬂ‰ «÷«›… /Ê/ ·«‰Â« „ÊÃÊœ…"
     End If
  End If

End Sub

Private Sub x_cond1_dblClick()

On Error Resume Next
Dim mydb As Database
'Dim q3, q1 As QueryDef
'Dim mytab As resultset
'Dim data7 As Variant
Dim crit12, crit11, crit1 As String
Dim L As Variant

'  mydb.QueryDefs.Delete ("q_word2")
L = 0
Set mydb = DBEngine.Workspaces(0).OpenDatabase("c:\program files\gnr_prg\gnr_11.mdb")
'MsgBox bnkout.resultset![out_slct1]

 If bnkout.Resultset![out_slct1] = "macnz" Or bnkout.Resultset![out_slct1] = "MACNZ" Then
 
 crit11 = "SELECT MACNZ.SUB_DESC, MACNZ.SUB_CODE, WORD.SUB_DESC6 FROM MACNZ INNER JOIN WORD ON MACNZ.SUB_CODE = WORD.SUB_CODE6"
 crit12 = " WHERE (((WORD.SUB_DESC6)=" & "'" & x_cond1 & "'" & "));"
 crit1 = crit11 & crit12
 L = 1
Else
  L = 2
crit11 = "SELECT FORM.SUB_NAME, FORM.[SUB_TYP],FORM.[SUB_NO], WORD.SUB_DESC6,word.sub_code6 FROM FORM INNER JOIN WORD ON FORM.SUB_TYP & FORM.SUB_NO = WORD.SUB_CODE6"
crit12 = " WHERE (((WORD.SUB_DESC6)=" & "'" & x_cond1 & "'" & "));"
crit1 = crit11 & crit12

End If

' MsgBox "crit1 = " & crit1
'Set q3 = mydb.CreateQueryDef("q_word2", crit1)

[c_getcond].Visible = True
 

 
 data2.SQL = crit1
 data2.Refresh
  
 If L = 1 Then
    c_getcond.ListField = "sub_DESC"
   c_getcond.BoundColumn = "sub_code"
 Else
    c_getcond.ListField = "sub_NAME"
      c_getcond.BoundColumn = "SUB_CODE6"
  
 End If
   
[c_getcond].SetFocus
[x_cond1].Visible = False
SendKeys "^{f4}"


End Sub

Private Sub x_del_Click()
    Dim L As Integer
  x_criteria = ""
  x_getcond = ""
  cb_serh = ""
  c_listfields = ""
  c_operation = "="
  searcher = ""
  'c_getcond.Visible = False
  x_getcond.Visible = True
  x_getcond = ""
   cb_serh.Visible = False
  c_getcond.ListField = ""
  
  
  
  
   
  'Me![x_getcond].Format = ""
  'Me![x_getcond].InputMask = ""
  count1 = 0
  count2 = 0
  count3 = 0
  count_rel = 0
  count_slct1 = 0
   nb_ad = 0
   nb_or = 0
   nb_and = 0
  L = 0
  For L = 1 To 20
   arr_ind1(L) = 0
   arr_ind2(L) = 0
  Next
  
  M_CRITERIA = ""
  tm_criteria = ""
  m_selectuse = False
  'sql = ""

End Sub

Private Sub x_getcond_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
  Call add_question
 End If
End Sub

Private Sub x_left_Click()
   [x_criteria] = [x_criteria] & "  " & ")"
 [x_criteria].Refresh
 tm_criteria = tm_criteria & " " & ") "

End Sub

Private Sub x_or_Click()
If nb_and + nb_or < nb_ad Then
    If Right(Me![x_criteria], 1) <> "/" And Me![x_criteria] <> "" Then
   Me![x_criteria] = Me![x_criteria] & " " & " /√Ê/ "
   tm_criteria = tm_criteria & " OR "
   nb_or = nb_or + 1
 End If
 Else
 If nb_and + nb_or = 0 Then
    MsgBox "·«Ì„ﬂ‰ «÷«›… /«Ê/ ﬁ»· «Œ Ì«— «·”ƒ«·"
   Else
  MsgBox "·«Ì„ﬂ‰ «÷«›… /«Ê/ ·«‰Â« „ÊÃÊœ…"
  End If
  End If
  

End Sub

Private Sub x_right_Click()
 [x_criteria] = [x_criteria] & "  " & "("
 [x_criteria].Refresh
 tm_criteria = tm_criteria & " " & "( "

End Sub


