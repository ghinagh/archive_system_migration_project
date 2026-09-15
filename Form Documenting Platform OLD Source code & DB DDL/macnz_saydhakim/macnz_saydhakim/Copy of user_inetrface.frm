VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form user_interface 
   BackColor       =   &H00FFFFC0&
   Caption         =   "user_interface"
   ClientHeight    =   8490
   ClientLeft      =   -255
   ClientTop       =   450
   ClientWidth     =   11880
   LinkTopic       =   "Form1"
   ScaleHeight     =   8490
   ScaleWidth      =   11880
   Begin VB.CommandButton Command4 
      Caption         =   " ›—Ì€ «·”ƒ«·"
      Height          =   495
      Left            =   240
      TabIndex        =   25
      Top             =   480
      Width           =   1095
   End
   Begin VB.TextBox m_desc_no 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   1680
      TabIndex        =   23
      Top             =   360
      Width           =   2775
   End
   Begin MSDBCtls.DBList DBList1 
      Bindings        =   "user_inetrface.frx":0000
      Height          =   1230
      Left            =   4680
      TabIndex        =   21
      Top             =   1200
      Visible         =   0   'False
      Width           =   2775
      _ExtentX        =   4895
      _ExtentY        =   2170
      _Version        =   393216
      ListField       =   "sub_name"
      BoundColumn     =   "sub_cod"
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox m_file_no 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   4680
      TabIndex        =   20
      Top             =   840
      Width           =   2775
   End
   Begin VB.TextBox m_word 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   8760
      TabIndex        =   18
      Top             =   960
      Width           =   1455
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H8000000C&
      Height          =   3135
      Left            =   360
      RightToLeft     =   -1  'True
      TabIndex        =   8
      Top             =   4080
      Visible         =   0   'False
      Width           =   5535
      Begin VB.CommandButton Command11 
         Caption         =   "‰”Œ «·ÃœÊ·"
         Height          =   495
         Left            =   2880
         TabIndex        =   15
         Top             =   2520
         Width           =   1095
      End
      Begin VB.CommandButton Command10 
         Caption         =   "«·€«¡ «·«„—"
         Height          =   495
         Left            =   1800
         TabIndex        =   14
         Top             =   2520
         Width           =   975
      End
      Begin VB.CommandButton Command9 
         Caption         =   "‰”Œ «·«Œ Ì«—"
         Height          =   495
         Left            =   4200
         TabIndex        =   13
         Top             =   2520
         Width           =   1095
      End
      Begin VB.DriveListBox Drive1 
         Height          =   315
         Left            =   720
         TabIndex        =   12
         Top             =   1680
         Width           =   270
      End
      Begin VB.FileListBox fillist 
         Height          =   1845
         Left            =   120
         TabIndex        =   11
         Top             =   480
         Width           =   2895
      End
      Begin VB.DirListBox Dirlist 
         Height          =   1440
         Left            =   3120
         TabIndex        =   10
         Top             =   960
         Width           =   2175
      End
      Begin VB.DriveListBox drvlist 
         Height          =   315
         Left            =   3120
         TabIndex        =   9
         Top             =   480
         Width           =   2175
      End
      Begin VB.Label Label19 
         Alignment       =   2  'Center
         BackColor       =   &H8000000C&
         Caption         =   "          —»ÿ «·„·› «·’Ê Ì   "
         BeginProperty Font 
            Name            =   "Arabic Transparent"
            Size            =   14.25
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   1560
         TabIndex        =   16
         Top             =   0
         Width           =   3495
      End
   End
   Begin VB.CommandButton Command3 
      Caption         =   "⁄œœ «·„ﬁ«·« "
      Height          =   495
      Left            =   240
      TabIndex        =   7
      Top             =   1080
      Width           =   1095
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Œ‹‹—ÊÃ"
      Height          =   495
      Left            =   240
      TabIndex        =   2
      Top             =   2280
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Caption         =   "«·‰ ÌÃ…"
      Height          =   495
      Left            =   240
      TabIndex        =   1
      Top             =   1680
      Width           =   1095
   End
   Begin MSDBGrid.DBGrid DBGrid1 
      Bindings        =   "user_inetrface.frx":0018
      Height          =   4695
      Left            =   240
      OleObjectBlob   =   "user_inetrface.frx":002D
      TabIndex        =   0
      Top             =   3240
      Width           =   11175
   End
   Begin MSRDC.MSRDC result 
      Height          =   330
      Left            =   1320
      Top             =   8040
      Visible         =   0   'False
      Width           =   1935
      _ExtentX        =   3413
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
      QueryTimeout    =   120
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
      RecordSource    =   "select * from view_interface"
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
   Begin MSMask.MaskEdBox M_art_dte1 
      Height          =   375
      Left            =   6120
      TabIndex        =   3
      Top             =   360
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   661
      _Version        =   393216
      MaxLength       =   8
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
      Mask            =   "##/##/##"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox M_art_dte 
      Height          =   375
      Left            =   8760
      TabIndex        =   4
      Top             =   360
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   661
      _Version        =   393216
      MaxLength       =   8
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
      Mask            =   "##/##/##"
      PromptChar      =   "_"
   End
   Begin MSRDC.MSRDC view_form 
      Height          =   330
      Left            =   3480
      Top             =   8040
      Visible         =   0   'False
      Width           =   1935
      _ExtentX        =   3413
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
      Caption         =   "VIEW_FORM"
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
   Begin MSDBCtls.DBList DBList2 
      Bindings        =   "user_inetrface.frx":1428
      Height          =   1230
      Left            =   1680
      TabIndex        =   24
      Top             =   720
      Visible         =   0   'False
      Width           =   2775
      _ExtentX        =   4895
      _ExtentY        =   2170
      _Version        =   393216
      ListField       =   "sub_desc"
      BoundColumn     =   "sub_code"
      RightToLeft     =   -1  'True
   End
   Begin MSRDC.MSRDC macnz 
      Height          =   330
      Left            =   0
      Top             =   8280
      Visible         =   0   'False
      Width           =   1935
      _ExtentX        =   3413
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
      Caption         =   "macnz"
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
   Begin MSDBCtls.DBCombo m_art_sub_ty 
      Bindings        =   "user_inetrface.frx":143C
      Height          =   360
      Left            =   8160
      TabIndex        =   27
      Top             =   1440
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   635
      _Version        =   393216
      BackColor       =   16777215
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSRDC.MSRDC coding_typ 
      Height          =   375
      Left            =   4080
      Top             =   8400
      Visible         =   0   'False
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
      Prompt          =   2
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
      RecordSource    =   "select * from VIEW_coding"
      UserName        =   "abbas"
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "coding_typ"
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
   Begin MSDBCtls.DBCombo m_art_per_no 
      Bindings        =   "user_inetrface.frx":1455
      Height          =   360
      Left            =   8160
      TabIndex        =   28
      Top             =   1920
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   635
      _Version        =   393216
      BackColor       =   16777215
      ListField       =   "PER_PER_NA"
      BoundColumn     =   "PER_PER_NO"
      Text            =   ""
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSRDC.MSRDC period 
      Height          =   375
      Left            =   4800
      Top             =   8160
      Visible         =   0   'False
      Width           =   1695
      _ExtentX        =   2990
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
      UserName        =   "abbas"
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server = sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "period"
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
   Begin MSRDC.MSRDC AUTHER 
      Height          =   450
      Left            =   6960
      Top             =   8160
      Visible         =   0   'False
      Width           =   1560
      _ExtentX        =   2752
      _ExtentY        =   794
      _Version        =   393216
      Options         =   0
      CursorDriver    =   1
      BOFAction       =   0
      EOFAction       =   0
      RecordsetType   =   3
      LockType        =   4
      QueryType       =   0
      Prompt          =   2
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
      RecordSource    =   "SELECT * FROM AUTHER order by aut_nam"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "auther"
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
   Begin MSDBCtls.DBCombo m_res_no 
      Bindings        =   "user_inetrface.frx":146A
      Height          =   360
      Left            =   8160
      TabIndex        =   31
      Top             =   2400
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   635
      _Version        =   393216
      BackColor       =   16777215
      ListField       =   "aut_nam"
      BoundColumn     =   "aut_no"
      Text            =   ""
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label Label8 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "«·„ƒ·›"
      Height          =   255
      Left            =   10200
      RightToLeft     =   -1  'True
      TabIndex        =   30
      Top             =   2400
      Width           =   1455
   End
   Begin VB.Label Label7 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "ÃÂ… «·’œÊ—"
      Height          =   255
      Left            =   10200
      RightToLeft     =   -1  'True
      TabIndex        =   29
      Top             =   1920
      Width           =   1455
   End
   Begin VB.Label Label6 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "‰Ê⁄ «·„ﬁ«·…"
      Height          =   255
      Left            =   10200
      RightToLeft     =   -1  'True
      TabIndex        =   26
      Top             =   1440
      Width           =   1455
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "«·„Ê÷Ê⁄ :"
      Height          =   375
      Left            =   4440
      RightToLeft     =   -1  'True
      TabIndex        =   22
      Top             =   360
      Width           =   1335
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "«·„·› «·«÷«›Ì"
      Height          =   255
      Left            =   7440
      RightToLeft     =   -1  'True
      TabIndex        =   19
      Top             =   960
      Width           =   1215
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "ﬂ·„… „‰ «·⁄‰«ÊÌ‰"
      Height          =   255
      Left            =   10200
      RightToLeft     =   -1  'True
      TabIndex        =   17
      Top             =   960
      Width           =   1455
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "„‰  «—ÌŒ :"
      Height          =   375
      Left            =   10200
      RightToLeft     =   -1  'True
      TabIndex        =   6
      Top             =   360
      Width           =   1455
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "«·Ï  «—ÌŒ :"
      Height          =   375
      Left            =   7440
      TabIndex        =   5
      Top             =   360
      Width           =   1215
   End
   Begin VB.Shape Shape1 
      Height          =   5175
      Left            =   120
      Top             =   2880
      Width           =   11535
   End
End
Attribute VB_Name = "user_interface"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim CRIT As String
Dim first_qst As Integer
Dim crit1 As String
Dim m_typ_serh As Integer




Private Sub Command1_Click()
On Error Resume Next
'Dim cn As New rdoConnection

Dim SQL As String
Dim qd As rdoQuery
Dim sql_query As String
If first_qst > 0 Then
  crit2 = CRIT & crit1
   MsgBox crit2
       SQL = "drop proc interface_result"
       cn.Execute SQL, rdExecDirect
       cn.Execute crit2, rdExecDirect
       result.SQL = "execute interface_result"
        result.Refresh
       DBGrid1.Refresh
      DBGrid1.SetFocus
 Else
      MsgBox "ÌÃ» ÿ—Õ «·”ƒ«· «Ê·«....."
End If
End Sub

Private Sub Command10_Click()
Frame2.Visible = False
DBGrid1.SetFocus

End Sub

Private Sub Command11_Click()
 m_path = Dirlist.Path
If main_form = 1 Then
 result.Resultset.MoveFirst
 While Not result.Resultset.EOF
       V_REC = result.Resultset![art_flm_no]
       m_source = m_cnf_path_pic & Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\" & V_REC & ".tif"
        m_target = m_path & "\" & V_REC & ".tif"
        myfile = Dir(m_source)
     If myfile <> "" Then
       FileCopy m_source, m_target
      End If
      result.Resultset.MoveNext
   Wend
 ElseIf main_form = 7 Then
  result.Resultset.MoveFirst
 While Not result.Resultset.EOF
         V_REC = result.Resultset![pic_pos_no]
         m_source = "\\Server\C\PICTURES\" & Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\" & V_REC & "." & "tif"
         m_target = m_path & "\" & V_REC & ".tif"
        myfile = Dir(m_source)
     If myfile <> "" Then
       FileCopy m_source, m_target
      End If
      result.Resultset.MoveNext
   Wend

 End If
  result.Refresh
   MsgBox "·ﬁœ «‰ ÂÏ ‰”Œ «·„ﬁ«·« ...."


End Sub

Private Sub Command2_Click()
Unload user_interface
End Sub

Private Sub Command3_Click()
Dim nb_rec As Variant

If result.Resultset.EOF Then
  MsgBox "·«ÌÊÃœ „ﬁ«·«  ·Â–« «·”ƒ«·"
Else
  result.Resultset.MoveLast
  nb_rec = result.Resultset.RowCount
  MsgBox "⁄œœ «·„ﬁ«·«  = " & nb_rec
End If

End Sub

Private Sub Command4_Click()
crit1 = ""
 CRIT = "create proc interface_result as "

 CRIT = CRIT & "SELECT DISTINCT " & _
                       "dbo.AUTHER.AUT_NAM AS res_res_no, dbo.MAIN.MN_APP_NO AS mn_app_no, dbo.MAIN.MN_ACT_TTL AS mn_act_ttl, " & _
                       "dbo.MAIN.MN_ADD_TTL AS mn_add_ttl, dbo.CODING.SUB_DESC AS art_sub_ty, dbo.ARTICLE.ART_DTE AS art_dte, " & _
                       "dbo.PERIOD.PER_PER_NA AS art_per_no, dbo.ARTICLE.ART_FLM_NO AS art_flm_no " & _
"FROM         dbo.MAIN INNER JOIN " & _
                      "dbo.RES ON dbo.MAIN.MN_APP_NO = dbo.RES.RES_APP_NO INNER JOIN " & _
                      "dbo.ARTICLE ON dbo.RES.RES_APP_NO = dbo.ARTICLE.ART_APP_NO INNER JOIN " & _
                      "dbo.AUTHER ON dbo.RES.RES_RES_NO = dbo.AUTHER.AUT_NO INNER JOIN " & _
                      "dbo.CODING ON '03' + dbo.ARTICLE.ART_SUB_TY = dbo.CODING.SUB_CODE INNER JOIN " & _
                     "dbo.PERIOD ON dbo.ARTICLE.ART_PER_NO = dbo.PERIOD.PER_PER_NO "

End Sub

Private Sub Command9_Click()
Dim m_path As Variant

 m_path = Dirlist.Path
  If main_form = 1 Then
     result.Resultset.MoveFirst
     While Not result.Resultset.EOF
      If result.Resultset![art_choice] = 1 Then
         V_REC = result.Resultset![art_flm_no]
         m_source = m_cnf_path_pic & Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\" & V_REC & ".tif"
         m_target = m_path & "\" & V_REC & ".tif"
         myfile = Dir(m_source)
         If myfile <> "" Then
            FileCopy m_source, m_target
            m_typ = 0
            SQL = "execute upd_art_choice " & "'" & V_REC & "'" & "," & "'" & m_typ & "'"
               cn.Execute SQL, rdExecDirect
         Else
           MsgBox V_REC & " Â–Â «·„ﬁ«·… €Ì— „ÊÃÊœ… ›Ì «·«—‘Ì›"
         End If
       End If
     result.Resultset.MoveNext
 Wend
  result.Refresh
   MsgBox "·ﬁœ «‰ ÂÏ ‰”Œ «·„ﬁ«·« ...."
 ElseIf main_form = 7 Then
      result.Resultset.MoveFirst
     While Not result.Resultset.EOF
      If result.Resultset![pic_choice] = 1 Then
         V_REC = result.Resultset![pic_pos_no]
         m_source = "\\Server\C\PICTURES\" & Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\" & V_REC & "." & "tif"
         m_target = m_path & "\" & V_REC & ".tif"
         myfile = Dir(m_source)
         If myfile <> "" Then
            FileCopy m_source, m_target
            m_typ = 0
            SQL = "execute upd_pic_choice " & "'" & V_REC & "'" & "," & "'" & m_typ & "'"
               cn.Execute SQL, rdExecDirect
         Else
           MsgBox V_REC & " Â–Â «·’Ê—… €Ì— „ÊÃÊœ… ›Ì «·«—‘Ì›"
         End If
       End If
     result.Resultset.MoveNext
 Wend
  result.Refresh
   MsgBox "·ﬁœ «‰ ÂÏ ‰”Œ «·„ﬁ«·« ...."

 End If
Frame2.Visible = False
DBGrid1.SetFocus


End Sub

Private Sub DBGrid1_DblClick()
    Dim V_REC As Variant
    Dim M_NAM, M_NAM1, M_CD As String
    lkey = KeyAscii
    V_REC = result.Resultset![art_flm_no]
       
      ' M_CD = "\\Server\c\scan\"
       M_NAM = "c:\acdsee32\acdsee32.exe " & m_cnf_path_pic
       M_NAM1 = Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\" & V_REC & ".tif"
       M_NAM = M_NAM & M_NAM1
       x = Shell(M_NAM, 1)

End Sub

Private Sub DBGrid1_KeyDown(KeyCode As Integer, Shift As Integer)
  Dim SQL As String
  
If KeyCode = vbKeyF8 Then
  If main_form = 1 Then
     result.Resultset.MoveFirst
     While Not result.Resultset.EOF
      If result.Resultset![art_choice] = 1 Then
         V_REC = result.Resultset![art_flm_no]
         m_source = m_cnf_path_pic & Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\" & V_REC & ".tif"
         m_target = "c:\data_scan\" & V_REC & ".tif"
         myfile = Dir(m_source)
         If myfile <> "" Then
            FileCopy m_source, m_target
            m_typ = 0
            SQL = "execute upd_art_choice " & "'" & V_REC & "'" & "," & "'" & m_typ & "'"
               cn.Execute SQL, rdExecDirect
         Else
           MsgBox V_REC & " Â–Â «·„ﬁ«·… €Ì— „ÊÃÊœ… ›Ì «·«—‘Ì›"
         End If
       End If
     result.Resultset.MoveNext
 Wend
  result.Refresh
   MsgBox "·ﬁœ «‰ ÂÏ ‰”Œ «·„ﬁ«·« ...."
 End If
 ElseIf KeyCode = vbKeyF9 Then
   If main_form = 1 Then
      m_row = DBGrid1.Row
     If result.Resultset![art_choice] = 0 Or IsNull(result.Resultset![art_choice]) Then
        V_REC = result.Resultset![art_flm_no]
        m_typ = 1
     Else
        m_typ = 0
        V_REC = result.Resultset![art_flm_no]
     End If
     SQL = "execute upd_art_choice " & "'" & V_REC & "'" & "," & "'" & m_typ & "'"
     cn.Execute SQL, rdExecDirect
     result.Refresh
     DBGrid1.Row = m_row
  ElseIf main_form = 7 Then
    m_row = DBGrid1.Row
     If result.Resultset![art_choice] = 0 Or IsNull(result.Resultset![art_choice]) Then
        V_REC = result.Resultset![pic_pos_no]
        m_typ = 1
     Else
        m_typ = 0
        V_REC = result.Resultset![pic_pos_no]
     End If
      SQL = "execute upd_pic_choice " & "'" & V_REC & "'" & "," & "'" & m_typ & "'"
      cn.Execute SQL, rdExecDirect
      result.Refresh
      DBGrid1.Row = m_row
  End If
ElseIf KeyCode = vbKeyF5 Then
 If main_form = 1 Then
 result.Resultset.MoveFirst
 While Not result.Resultset.EOF
       V_REC = result.Resultset![art_flm_no]
       m_source = m_cnf_path_pic & Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\" & V_REC & ".tif"
        m_target = "c:\data_scan\" & V_REC & ".tif"
        myfile = Dir(m_source)
     If myfile <> "" Then
       FileCopy m_source, m_target
      End If
      result.Resultset.MoveNext
   Wend
  result.Refresh
   MsgBox "·ﬁœ «‰ ÂÏ ‰”Œ «·„ﬁ«·« ...."
  End If
 ElseIf KeyCode = vbKeyF2 Then
  If main_form = 7 Then
       m_bk_no = result.Resultset![pic_no]
       m_form_load = 2
       Screen.MousePointer = vbDefault
       Screen.MousePointer = vbHourglass
       picture_f.WindowState = 2
       picture_f.Show
       Screen.MousePointer = vbDefault

  Else
    m_bk_no = result.Resultset![mn_app_no]
    If Mid(m_bk_no, 1, 1) = "ﬁ" Then
       m_form_load = 2
       Screen.MousePointer = vbDefault
       Screen.MousePointer = vbHourglass
       Form6.WindowState = 2
       Form6.Show
       Screen.MousePointer = vbDefault
    End If
  End If
 ElseIf KeyCode = vbKeyF3 Then
   Frame2.Visible = True
 End If

End Sub

Private Sub DBList1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_fad_no = view_form.Resultset![sub_cod]
      crit1 = crit1 & "fad_fad_no =  " & "'" & m_fad_no & "'"
      CRIT = CRIT & " inner join dbo.file_add ON dbo.ARTICLE.ART_app_no = dbo.file_add.fad_app_no "
      m_file_no.Text = view_form.Resultset![sub_name]
      DBList1.Visible = False
     Command1.SetFocus
End If
End Sub

Private Sub DBList2_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       macnz.Resultset.Bookmark = DBList2.SelectedItem
       m_an_no = macnz.Resultset![sub_code]
      crit1 = crit1 & "an_desc_no =  " & "'" & m_an_no & "'"
      CRIT = CRIT & " inner join dbo.analis ON dbo.ARTICLE.ART_app_no = dbo.analis.an_app_no "
      m_desc_no.Text = macnz.Resultset![sub_desc]
      DBList2.Visible = False
      Command1.SetFocus
End If
End Sub

Private Sub drvlist_Change()
   On Error GoTo DriveHandler
   ' If new drive was selected, the Dir1 box
   ' updates its display.
   Dirlist.Path = drvlist.Drive
   Exit Sub
' If there is an error, reset drvList.Drive with the
' drive from dirList.Path.
DriveHandler:
   drvlist.Drive = Dirlist.Path
   Exit Sub
End Sub

Private Sub drvlist_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
 Frame2.Visible = False
 DBGrid1.SetFocus
 
End If
End Sub

Private Sub fillist_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
   Frame2.Visible = False
   DBGrid1.SetFocus
End If
End Sub


Private Sub Form_Load()
m_typ_serh = 1
'M_art_dte.Text = Format(Date, "dd/mm/yy")
first_qst = 0
crit1 = ""
 CRIT = "create proc interface_result as "

 CRIT = CRIT & "SELECT DISTINCT " & _
                       "dbo.AUTHER.AUT_NAM AS res_res_no, dbo.MAIN.MN_APP_NO AS mn_app_no, dbo.MAIN.MN_ACT_TTL AS mn_act_ttl, " & _
                       "dbo.MAIN.MN_ADD_TTL AS mn_add_ttl, dbo.CODING.SUB_DESC AS art_sub_ty, dbo.ARTICLE.ART_DTE AS art_dte, " & _
                       "dbo.PERIOD.PER_PER_NA AS art_per_no, dbo.ARTICLE.ART_FLM_NO AS art_flm_no " & _
"FROM         dbo.MAIN INNER JOIN " & _
                      "dbo.RES ON dbo.MAIN.MN_APP_NO = dbo.RES.RES_APP_NO INNER JOIN " & _
                      "dbo.ARTICLE ON dbo.RES.RES_APP_NO = dbo.ARTICLE.ART_APP_NO INNER JOIN " & _
                      "dbo.AUTHER ON dbo.RES.RES_RES_NO = dbo.AUTHER.AUT_NO INNER JOIN " & _
                      "dbo.CODING ON '03' + dbo.ARTICLE.ART_SUB_TY = dbo.CODING.SUB_CODE INNER JOIN " & _
                     "dbo.PERIOD ON dbo.ARTICLE.ART_PER_NO = dbo.PERIOD.PER_PER_NO "

 

End Sub

Private Sub M_OPR_DTE1_Change()

End Sub

Private Sub M_OPR_DTE1_KeyPress(KeyAscii As Integer)

End Sub

Private Sub m_art_dte_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then
 If Not M_art_dte.Text = "__/__/__" Then
  If IsDate(M_art_dte.Text) Then
     If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     
     m_dte1 = Format(M_art_dte.Text, "YYYY/MM/DD")
     crit1 = crit1 & "  art_DTE >= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102)"
   Else
    M_art_dte.SetFocus
   End If
 End If
  M_art_dte1.SetFocus
  
End If


End Sub

Private Sub M_OPR_DTE2_Change()

End Sub

Private Sub M_OPR_DTE2_KeyPress(KeyAscii As Integer)

End Sub

Private Sub m_art_dte1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  If IsDate(M_art_dte1.Text) Then
    If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
    
   m_dte = M_art_dte1.Text
  crit1 = crit1 & "   art_dte <= " & "convert(datetime," & "'" & Format(m_dte, "yyyy-mm-dd") & "'" & "," & "102)"
  Command1.SetFocus
Else
  M_art_dte1.SetFocus
End If
  
End If

End Sub

Private Sub m_art_per_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " art_per_no = " & m_art_per_no.BoundText
      Command1.SetFocus
End If
End Sub

Private Sub m_art_sub_ty_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " art_sub_ty = " & "'" & Mid(m_art_sub_ty.BoundText, 3, 2) & "'"
      Command1.SetFocus
End If

End Sub

Private Sub m_desc_no_Change()
  If DBList2.Visible = False Then
    DBList2.Visible = True
  End If
    If m_typ_serh = 1 Then
       m_desc = m_desc_no.Text
       m_len = Len(Trim(m_desc))
        macnz.SQL = "execute serh_macnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        macnz.Refresh
        DBList2.Refresh
       ' SendKeys "{UP}"
          If macnz.Resultset.EOF Or macnz.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If

 ElseIf m_typ_serh = 2 Then
       m_desc = m_desc_no.Text
       m_len = Len(Trim(m_desc))
        macnz.SQL = "execute serh_wrdmacnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        macnz.Refresh
       ' SendKeys "{UP}"
         If macnz.Resultset.EOF Or macnz.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If

  End If
  
End Sub



Private Sub m_desc_no_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 40 Then
   DBList2.SetFocus
   SendKeys "{UP}"
End If

End Sub

Private Sub m_file_no_Change()
  If DBList1.Visible = False Then
    DBList1.Visible = True
  End If
  If Not Trim(m_file_no.Text) = "" Then
       If m_typ_serh = 1 Then
         m_desc = m_file_no.Text
         
         m_len = Len(Trim(m_file_no.Text))
         view_form.SQL = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
         
        ' DBList1.SetFocus
'         SendKeys "{UP}"
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If
      ElseIf m_typ_serh = 2 Then
            m_desc = m_file_no.Text
            m_len = Len(Trim(m_file_no.Text))
            view_form.SQL = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
            view_form.Refresh
    '        DBList1.Refresh
    '        DBList1.SetFocus
    '        m_file_no.Visible = False
          '  Label18.Visible = False
    '        SendKeys "{UP}"
             If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
                MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
             End If
        End If

      ' m_file_no.SetFocus
   End If

End Sub

Private Sub m_res_res_no_Click(Area As Integer)

End Sub

Private Sub m_file_no_GotFocus()
SendKeys "{f4}"
End Sub

Private Sub m_file_no_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 40 Then
   DBList1.SetFocus
   SendKeys "{UP}"
End If
End Sub

Private Sub m_res_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " res_res_no = " & m_res_no.BoundText
      Command1.SetFocus
End If
End Sub

Private Sub m_word_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & "mn_act_ttl + mn_act + mn_add_ttl + mn_add like " & "'" & "%" & m_word.Text & "%" & "'"
      Command1.SetFocus
      
End If

End Sub
