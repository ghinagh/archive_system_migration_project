VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{CDE57A40-8B86-11D0-B3C6-00A0C90AEA82}#1.0#0"; "MSDATGRD.OCX"
Begin VB.Form tmp_file 
   BackColor       =   &H0086C8EC&
   Caption         =   "„·›«  «÷«›Ì… ··«œŒ«·"
   ClientHeight    =   5835
   ClientLeft      =   60
   ClientTop       =   4935
   ClientWidth     =   12045
   LinkTopic       =   "Form6"
   RightToLeft     =   -1  'True
   ScaleHeight     =   5835
   ScaleWidth      =   12045
   Begin VB.CommandButton Command6 
      BackColor       =   &H002972B4&
      Caption         =   "⁄œœ «·⁄„·Ì« "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   2040
      MaskColor       =   &H00FFFFC0&
      Style           =   1  'Graphical
      TabIndex        =   15
      Top             =   1200
      Width           =   1695
   End
   Begin VB.TextBox m_word 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00D8F9FE&
      Height          =   285
      Left            =   7080
      RightToLeft     =   -1  'True
      TabIndex        =   13
      Top             =   1320
      Width           =   3135
   End
   Begin VB.OptionButton Option2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H0086C8EC&
      Caption         =   "€Ì—„‰Ã“"
      Height          =   375
      Left            =   7320
      RightToLeft     =   -1  'True
      TabIndex        =   12
      Top             =   840
      Width           =   975
   End
   Begin VB.OptionButton Option1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H0086C8EC&
      Caption         =   "„‰Ã“"
      Height          =   375
      Left            =   8520
      RightToLeft     =   -1  'True
      TabIndex        =   11
      Top             =   840
      Width           =   855
   End
   Begin VB.TextBox m_user_no 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00D8F9FE&
      Height          =   285
      Left            =   7920
      RightToLeft     =   -1  'True
      TabIndex        =   10
      ToolTipText     =   "ﬂ·„… „⁄Ì‰… „‰ ⁄‰Ê«‰ «·„‘Âœ «Ê «·„” Œ·’"
      Top             =   360
      Width           =   735
   End
   Begin VB.CommandButton Command5 
      BackColor       =   &H002972B4&
      Caption         =   "Œ—ÊÃ"
      Height          =   495
      Left            =   240
      MaskColor       =   &H80000001&
      Picture         =   "tmp_file.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   8
      Top             =   1200
      Width           =   1695
   End
   Begin VB.CommandButton Command4 
      BackColor       =   &H002972B4&
      Caption         =   "»ÕÀ ÃœÌœ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   240
      MaskColor       =   &H00FFFFC0&
      Style           =   1  'Graphical
      TabIndex        =   7
      Top             =   600
      Width           =   1695
   End
   Begin VB.CommandButton Command2 
      BackColor       =   &H002972B4&
      Caption         =   "Œ‹‹—ÊÃ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   -5280
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   0
      Width           =   1455
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H002972B4&
      Caption         =   "«·‰ ÌÃ…"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   0
      Width           =   1695
   End
   Begin MSDataGridLib.DataGrid DataGrid1 
      Bindings        =   "tmp_file.frx":014A
      Height          =   3375
      Left            =   0
      TabIndex        =   0
      Top             =   2040
      Width           =   11895
      _ExtentX        =   20981
      _ExtentY        =   5953
      _Version        =   393216
      AllowUpdate     =   -1  'True
      BackColor       =   8833260
      HeadLines       =   1
      RowHeight       =   15
      FormatLocked    =   -1  'True
      AllowAddNew     =   -1  'True
      AllowDelete     =   -1  'True
      RightToLeft     =   -1  'True
      BeginProperty HeadFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ColumnCount     =   8
      BeginProperty Column00 
         DataField       =   "tmp_fad_no"
         Caption         =   "—ﬁ„ «·„·›"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column01 
         DataField       =   "tmp_final"
         Caption         =   "„‰Ã“"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column02 
         DataField       =   "tmp_file_name"
         Caption         =   "«”„ «·„·›"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column03 
         DataField       =   "tmp_rmrk"
         Caption         =   "«·‘—Õ"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column04 
         DataField       =   "tmp_mk"
         Caption         =   "„ﬂ«‰ «·„·›"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column05 
         DataField       =   "tmp_date"
         Caption         =   "«· «—ÌŒ"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column06 
         DataField       =   "tmp_user_no"
         Caption         =   "«·„ÊÀﬁ"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column07 
         DataField       =   "tmp_ser"
         Caption         =   "«·„ ”·”·"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      SplitCount      =   1
      BeginProperty Split0 
         BeginProperty Column00 
            ColumnWidth     =   915.024
         EndProperty
         BeginProperty Column01 
            ColumnWidth     =   1005.165
         EndProperty
         BeginProperty Column02 
            ColumnWidth     =   3495.118
         EndProperty
         BeginProperty Column03 
            ColumnWidth     =   3000.189
         EndProperty
         BeginProperty Column04 
            ColumnWidth     =   1739.906
         EndProperty
         BeginProperty Column05 
            ColumnWidth     =   1739.906
         EndProperty
         BeginProperty Column06 
            ColumnWidth     =   929.764
         EndProperty
         BeginProperty Column07 
            ColumnWidth     =   915.024
         EndProperty
      EndProperty
   End
   Begin MSAdodcLib.Adodc f_tmp 
      Height          =   330
      Left            =   600
      Top             =   5520
      Width           =   3615
      _ExtentX        =   6376
      _ExtentY        =   582
      ConnectMode     =   0
      CursorLocation  =   3
      IsolationLevel  =   -1
      ConnectionTimeout=   15
      CommandTimeout  =   30
      CursorType      =   3
      LockType        =   3
      CommandType     =   8
      CursorOptions   =   0
      CacheSize       =   50
      MaxRecords      =   0
      BOFAction       =   0
      EOFAction       =   0
      ConnectStringType=   3
      Appearance      =   1
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      Orientation     =   0
      Enabled         =   -1
      Connect         =   "DSN=sqlserver"
      OLEDBString     =   ""
      OLEDBFile       =   ""
      DataSourceName  =   "sqlserver"
      OtherAttributes =   ""
      UserName        =   "sa"
      Password        =   ""
      RecordSource    =   "select * from tmp_fileadd order by tmp_ser desc"
      Caption         =   "f_tmp"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      _Version        =   393216
   End
   Begin MSMask.MaskEdBox M_tmp_date1 
      Height          =   375
      Left            =   9600
      TabIndex        =   1
      Top             =   720
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   661
      _Version        =   393216
      BackColor       =   14219774
      MaxLength       =   10
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   "dd/mm/yy"
      Mask            =   "##/##/####"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox M_tmp_date 
      Height          =   375
      Left            =   9600
      TabIndex        =   2
      Top             =   240
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   661
      _Version        =   393216
      BackColor       =   14219774
      MaxLength       =   10
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   "dd/mm/yy"
      Mask            =   "##/##/####"
      PromptChar      =   "_"
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      BackStyle       =   0  'Transparent
      Caption         =   "ﬂ·„… „⁄Ì‰…"
      Height          =   255
      Left            =   10200
      RightToLeft     =   -1  'True
      TabIndex        =   14
      Top             =   1320
      Width           =   735
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      BackStyle       =   0  'Transparent
      Caption         =   "—ﬁ„ «·„⁄œ"
      Height          =   255
      Left            =   8640
      RightToLeft     =   -1  'True
      TabIndex        =   9
      Top             =   360
      Width           =   735
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      BackStyle       =   0  'Transparent
      Caption         =   "„‰  «—ÌŒ "
      Height          =   255
      Left            =   10800
      RightToLeft     =   -1  'True
      TabIndex        =   4
      Top             =   240
      Width           =   1095
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      BackStyle       =   0  'Transparent
      Caption         =   "«·Ï  «—ÌŒ "
      Height          =   255
      Left            =   10800
      TabIndex        =   3
      Top             =   720
      Width           =   1215
   End
End
Attribute VB_Name = "tmp_file"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim m_ser_tmp As Integer
Dim CRIT, crit1 As String
Dim first_qst, qst1, qst2, qst3, qst4, qst5, qst6   As Integer


Private Sub Check1_Click()
End Sub

Private Sub Command1_Click()
 On Error Resume Next
 If qst3 = 0 And Not M_tmp_date.Text = "__/__/____" Then
  qst3 = 1
 If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     
     m_dte1 = Format(M_tmp_date.Text, "YYYY/MM/DD")
     crit1 = crit1 & " ( tmp_DaTE >= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102) or tmp_date is null)"
     M_tmp_date.Enabled = False
End If
If qst2 = 0 And Not M_tmp_date1.Text = "__/__/____" Then
  qst2 = 1
 If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     
     m_dte1 = Format(M_tmp_date1.Text, "YYYY/MM/DD")
     crit1 = crit1 & " ( tmp_DaTE <= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102) or tmp_date is null) "
     M_tmp_date1.Enabled = False
End If
If qst1 = 0 And Not m_user_no.Text = "" Then
  qst1 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & "tmp_user_no" & " = " & "'" & m_user_no.Text & "'"
      m_user_no.Enabled = False
      Command1.SetFocus
      
End If
If qst6 = 0 And Not m_word.Text = "" Then
  qst6 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & "tmp_file_name + tmp_rmrk" & " like " & "'" & "%" & m_word.Text & "%" & "'"
      m_word.Enabled = False
      Command1.SetFocus
      
End If


If first_qst > 0 Then
  crit2 = CRIT & crit1 & " order by tmp_ser desc "
       MsgBox crit2
       sql = "drop proc tmp_result"
       cn.Execute sql, rdExecDirect
       cn.Execute crit2, rdExecDirect
       Screen.MousePointer = vbHourglass
       f_tmp.RecordSource = "execute tmp_result"
       f_tmp.Refresh
       DataGrid1.Refresh
       
      Screen.MousePointer = vbDefault
 Else
      MsgBox "ÌÃ» ÿ—Õ «·”ƒ«· «Ê·«....."
End If

End Sub

Private Sub Command3_Click()

End Sub

Private Sub Command4_Click()
 M_tmp_date1.Enabled = True
  M_tmp_date.Enabled = True
  M_tmp_date.Text = "__/__/____"
  M_tmp_date1.Text = Format(Date, "dd/mm/yyyy")
  
 m_user_no.Enabled = True
 m_user_no.Text = ""
 m_word.Text = ""
 m_word.Enabled = True
 
 
Option1.value = False
Option2.value = False

qst1 = 0
qst2 = 0
qst3 = 0
qst4 = 0
qst5 = 0
qst6 = 0

m_typ_serh = 1


'M_art_dte.Text = Format(Date, "dd/mm/yy")
first_qst = 0
crit1 = ""
 CRIT = "create proc tmp_result as "

 CRIT = CRIT & "SELECT DISTINCT " & _
         " dbo.tmp_fileadd.tmp_fAD_no,dbo.tmp_fileadd.tmp_ser,dbo.tmp_fileadd.tmp_file_name,dbo.tmp_fileadd.tmp_rmrk,dbo.tmp_fileadd.tmp_mk,dbo.tmp_fileadd.tmp_user_no,dbo.tmp_fileadd.tmp_date,dbo.tmp_fileadd.tmp_final " & _
 " FROM         dbo.tmp_fileadd "
 If qst2 = 0 And Not M_tmp_date1.Text = "__/__/____" Then
  qst2 = 1
 If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     
     m_dte1 = Format(M_tmp_date1.Text, "YYYY/MM/DD")
     crit1 = crit1 & " ( tmp_DaTE <= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102) or tmp_date is null)"
     M_tmp_date1.Enabled = False
End If
If first_qst > 0 Then
  crit2 = CRIT & crit1 & " order by tmp_ser DESC"
  ''& " order by art_dte"
       sql = "drop proc tmp_result"
       cn.Execute sql, rdExecDirect
       cn.Execute crit2, rdExecDirect
       Screen.MousePointer = vbHourglass
       f_tmp.RecordSource = "execute tmp_result"
       f_tmp.Refresh
       DataGrid1.Refresh
       
      Screen.MousePointer = vbDefault
 Else
      MsgBox "ÌÃ» ÿ—Õ «·”ƒ«· «Ê·«....."
End If
End Sub

Private Sub Command5_Click()
Unload tmp_file

End Sub

Private Sub Command6_Click()
Dim nb_rec As Variant

If f_tmp.Recordset.EOF Then
  MsgBox "·«ÌÊÃœ „ﬁ«·«  ·Â–« «·”ƒ«·"
Else
  f_tmp.Recordset.MoveFirst
  f_tmp.Recordset.MoveNext
  nb_rec = 1
  While Not f_tmp.Recordset.EOF
       nb_rec = nb_rec + 1
      f_tmp.Recordset.MoveNext
   Wend
     f_tmp.Recordset.MoveFirst
  MsgBox "⁄œœ «·„ﬁ«·«  = " & nb_rec
End If
End Sub

Private Sub DataGrid1_AfterColEdit(ByVal ColIndex As Integer)
m_row = f_tmp.Recordset.Bookmark - 1
f_tmp.Recordset.Requery
f_tmp.Recordset.Move (m_row)

End Sub

Private Sub datagrid1_DblClick()
'V_MCH_STOCK = Val(f_tmp.Recordset![mch_STOCK])
 m_bk_no = DataGrid1.Columns(0)
 m_form_load = 2
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
Form6.WindowState = 2
 Form6.Show
 Screen.MousePointer = vbDefault
End Sub

Private Sub DataGrid1_KeyUp(KeyCode As Integer, Shift As Integer)
 Dim sql As String
If KeyCode = vbKeyInsert Then
   m_date = Format(Date, "dd/mm/yyyy")
   m_no = Form2.Text1.Text
   m_no = Form2.Text1.Text
   sql = "execute op_tmp " & "'" & m_no & "'" & "," & "'" & box_user_no & "'" & "," & "'" & Format(m_date, "yyyy/mm/dd") & "'"
   cn.Execute sql, rdExecDirect
   f_tmp.Refresh
ElseIf KeyCode = vbKeyDelete Then
   If Not f_tmp.Recordset.EOF And Not f_tmp.Recordset.BOF Then
   
   m_no = DataGrid1.Columns(0)
   m_ser = DataGrid1.Columns(1)
'   sql = "execute del_tmp " & "'" & m_no & "'" & "," & "'" & m_ser & "'"
'   cn.Execute sql, rdExecDirect
'   If m_ser = m_ser_tmp Then
  '   m_ser_tmp = m_ser_tmp - 1
  '  End If
   f_tmp.Refresh
   End If
ElseIf KeyCode = vbKeyF12 Then
 m_bk_no = DataGrid1.Columns(0)
 m_form1_load = 2
 'V_MCH_STOCK = Val(result.Recordset![mch_STOCK])
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form6.WindowState = 2
 Form6.Show
 Screen.MousePointer = vbDefault
End If
End Sub

Private Sub Form_Load()
'DataGrid1.SetFocus
On Error Resume Next
' If Not f_tmp.Recordset.EOF Or Not f_tmp.Recordset.EOF Then
' f_tmp.Recordset.MoveFirst

  ' m_ser_tmp = f_tmp.Recordset![tmp_ser]
' Else
 '  m_ser_tmp = 0
' End If
  
'M_tmp_date.Text = Format(Date, "dd/mm/yy")
M_tmp_date1.Text = Format(Date, "dd/mm/yyyy")

m_disp = 1
qst1 = 0
qst2 = 0
qst3 = 0
qst4 = 0
wst6 = 0
m_typ_serh = 1


'M_art_dte.Text = Format(Date, "dd/mm/yy")
first_qst = 0
crit1 = ""
 CRIT = "create proc tmp_result as "

 CRIT = CRIT & "SELECT DISTINCT " & _
         " dbo.tmp_fileadd.tmp_fAD_no,dbo.tmp_fileadd.tmp_ser,dbo.tmp_fileadd.tmp_file_name,dbo.tmp_fileadd.tmp_rmrk,dbo.tmp_fileadd.tmp_mk,dbo.tmp_fileadd.tmp_user_no,dbo.tmp_fileadd.tmp_date,dbo.tmp_fileadd.tmp_final " & _
 " FROM         dbo.tmp_fileadd "
 If qst2 = 0 And Not M_tmp_date1.Text = "__/__/____" Then
  qst2 = 1
 If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     
     m_dte1 = Format(M_tmp_date1.Text, "yyyy/MM/dd")
     crit1 = crit1 & " ( tmp_DaTE <= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102) or tmp_date is null)"
     M_tmp_date1.Enabled = False
End If
If first_qst > 0 Then
  crit2 = CRIT & crit1 & " order by tmp_ser desc"
  ''& " order by art_dte"
      ' MsgBox crit2
       sql = "drop proc tmp_result"
       cn.Execute sql, rdExecDirect
       cn.Execute crit2, rdExecDirect
       Screen.MousePointer = vbHourglass
       f_tmp.RecordSource = "execute tmp_result"
       f_tmp.Refresh
       DataGrid1.Refresh
       
      Screen.MousePointer = vbDefault
 Else
      MsgBox "ÌÃ» ÿ—Õ «·”ƒ«· «Ê·«....."
End If
End Sub

Private Sub m_OPR_DTE1_Change()

End Sub

Private Sub M_OPR_DTE2_Change()

End Sub

Private Sub M_tmp_date_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 If Not M_tmp_date.Text = "__/__/____" Then
  If IsDate(M_tmp_date.Text) Then
     If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     
     m_dte1 = Format(M_tmp_date.Text, "YYYY/MM/DD")
     crit1 = crit1 & " ( tmp_date >= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102) or tmp_date is null)"
     qst3 = 1
       M_tmp_date.Enabled = False
      Command1.SetFocus
 
   Else
    M_tmp_date1.SetFocus
   End If
  End If
End If

End Sub

Private Sub m_word_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_word.Text = "" Then
  qst6 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & "tmp_file_name + tmp_rmrk" & " like " & "'" & "%" & m_word.Text & "%" & "'"
      m_word.Enabled = False
      Command1.SetFocus
      
End If


End Sub

Private Sub M_tmp_date1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 If Not M_tmp_date1.Text = "__/__/__" Then
  If IsDate(M_tmp_date1.Text) Then
     If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     
     m_dte1 = Format(M_art_dte.Text, "YYYY/MM/DD")
     crit1 = crit1 & "  (tmp_date1 <= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102) or tmp_date is null)"
     qst3 = 1
       M_tmp_date1.Enabled = False
      Command1.SetFocus
 
   Else
    M_tmp_date1.SetFocus
   End If
  End If
End If

End Sub

Private Sub m_user_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_user_no.Text = "" Then
  qst1 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & "tmp_user_no" & " = " & "'" & m_user_no.Text & "'"
      m_user_no.Enabled = False
      Command1.SetFocus
      
End If
End Sub

 

Private Sub Option1_Click()
If Option1.value = True Then
       qst4 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       crit1 = crit1 & "tmp_final = 1"
      Command1.SetFocus
End If
End Sub

Private Sub Option2_Click()
 If Option2.value = True Then
       qst5 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       crit1 = crit1 & " (tmp_final = 0 or tmp_final is null)"
      Command1.SetFocus
End If
End Sub

Private Sub Text1_Change()

End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)
End Sub
