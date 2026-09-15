VERSION 5.00
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Object = "{00025600-0000-0000-C000-000000000046}#5.1#0"; "CRYSTL32.OCX"
Begin VB.Form frm_res2 
   Caption         =   "Form1"
   ClientHeight    =   8490
   ClientLeft      =   60
   ClientTop       =   540
   ClientWidth     =   11880
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   9.75
      Charset         =   178
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   Moveable        =   0   'False
   ScaleHeight     =   8490
   ScaleWidth      =   11880
   Begin VB.Frame Frame2 
      BackColor       =   &H8000000C&
      Height          =   3135
      Left            =   1560
      RightToLeft     =   -1  'True
      TabIndex        =   8
      Top             =   4920
      Visible         =   0   'False
      Width           =   5535
      Begin VB.CommandButton Command11 
         Caption         =   "‰”Œ «·ÃœÊ·"
         Height          =   495
         Left            =   2880
         TabIndex        =   16
         Top             =   2520
         Width           =   1095
      End
      Begin VB.CommandButton Command10 
         Caption         =   "«·€«¡ «·«„—"
         Height          =   495
         Left            =   1800
         TabIndex        =   15
         Top             =   2520
         Width           =   975
      End
      Begin VB.CommandButton Command9 
         Caption         =   "‰”Œ «·«Œ Ì«—"
         Height          =   495
         Left            =   4200
         TabIndex        =   14
         Top             =   2520
         Width           =   1095
      End
      Begin VB.DriveListBox Drive1 
         Height          =   360
         Left            =   720
         TabIndex        =   13
         Top             =   1680
         Width           =   270
      End
      Begin VB.FileListBox fillist 
         Height          =   2010
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
         Height          =   360
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
         Left            =   1080
         TabIndex        =   12
         Top             =   0
         Width           =   3495
      End
      Begin VB.Shape Shape4 
         Height          =   3015
         Left            =   120
         Top             =   120
         Width           =   5415
      End
   End
   Begin VB.CommandButton Command8 
      Caption         =   "ÿ»«⁄… «·„·›"
      Height          =   615
      Left            =   240
      TabIndex        =   7
      Top             =   1200
      Width           =   735
   End
   Begin VB.CommandButton Command7 
      Caption         =   "ÿ»«⁄… «·„·›«  «·«÷«›Ì…"
      Height          =   975
      Left            =   240
      TabIndex        =   6
      Top             =   4560
      Width           =   735
   End
   Begin Crystal.CrystalReport CrystalReport5 
      Left            =   120
      Top             =   7200
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      ReportFileName  =   "C:\macnz\rpt_add1.rpt"
      PrintFileLinesPerPage=   60
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Œ‹‹—ÊÃ"
      Height          =   855
      Left            =   240
      TabIndex        =   5
      Top             =   5760
      Width           =   735
   End
   Begin Crystal.CrystalReport CrystalReport4 
      Left            =   120
      Top             =   7680
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      ReportFileName  =   "C:\macnz\book.rpt"
      Destination     =   1
      PrintFileLinesPerPage=   60
   End
   Begin VB.CommandButton Command4 
      Caption         =   "ÿ»«⁄… »œÊ‰ „ƒ·›"
      Height          =   735
      Left            =   240
      TabIndex        =   4
      Top             =   3600
      Width           =   735
   End
   Begin Crystal.CrystalReport CrystalReport3 
      Left            =   600
      Top             =   7680
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      ReportFileName  =   "C:\macnz\rpt_res1.rpt"
      Destination     =   1
      PrintFileLinesPerPage=   60
   End
   Begin VB.CommandButton Command3 
      Caption         =   "ÿ»«⁄…"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   240
      TabIndex        =   2
      Top             =   2760
      Width           =   735
   End
   Begin Crystal.CrystalReport CrystalReport2 
      Left            =   -4200
      Top             =   3240
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      ReportFileName  =   "C:\macnz\tmp_result.rpt"
      Destination     =   1
      PrintFileLinesPerPage=   60
   End
   Begin VB.CommandButton Command2 
      Caption         =   "⁄—÷ «·ÿ»«⁄…"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   240
      TabIndex        =   1
      Top             =   1920
      Width           =   735
   End
   Begin Crystal.CrystalReport CrystalReport1 
      Left            =   -3720
      Top             =   2040
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      ReportFileName  =   "C:\macnz\tmp_result.rpt"
      UserName        =   "abbas"
      PrintFileUseRptNumberFmt=   -1  'True
      PrintFileUseRptDateFmt=   -1  'True
      PrintFileLinesPerPage=   60
   End
   Begin VB.CommandButton Command1 
      Caption         =   "⁄œœ «·„ﬁ«·« "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Index           =   0
      Left            =   240
      RightToLeft     =   -1  'True
      TabIndex        =   0
      Top             =   360
      Width           =   735
   End
   Begin MSRDC.MSRDC result 
      Height          =   330
      Left            =   0
      Top             =   6480
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
      RecordSource    =   "select * from period"
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
   Begin MSDBGrid.DBGrid DBGrid2 
      Align           =   4  'Align Right
      Bindings        =   "frm_res2.frx":0000
      Height          =   8490
      Left            =   1125
      OleObjectBlob   =   "frm_res2.frx":0015
      TabIndex        =   3
      Top             =   0
      Width           =   10755
   End
   Begin MSRDC.MSRDC bnkout1 
      Height          =   330
      Left            =   1680
      Top             =   6000
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
   Begin VB.Shape Shape1 
      BackColor       =   &H00C0C0C0&
      Height          =   6735
      Left            =   120
      Top             =   120
      Width           =   975
   End
End
Attribute VB_Name = "frm_res2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command10_Click()
 Frame2.Visible = False
 DBGrid2.SetFocus


End Sub

Private Sub Command11_Click()
 m_path = Dirlist.Path
If main_form = 1 Then
 result.Resultset.MoveFirst
 While Not result.Resultset.EOF
       V_REC = result.Resultset![art_flm_no]
       m_source = m_cnf_path_pic & Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\" & V_REC & ".tif"
        m_target = m_path & V_REC & ".tif"
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
DBGrid2.SetFocus



End Sub

'Dim cn As New rdoConnection
Private Sub Dirlist_Change()
fillist.Path = Dirlist.Path
End Sub

Private Sub Dirlist_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
 Frame2.Visible = False
 DBGrid2.SetFocus
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
 DBGrid2.SetFocus
 
End If

End Sub

 
  
  

Private Sub Command1_Click(Index As Integer)
Dim nb_rec As Variant

If result.Resultset.EOF Then
  MsgBox "·«ÌÊÃœ „ﬁ«·«  ·Â–« «·”ƒ«·"
Else
  result.Resultset.MoveLast
  nb_rec = result.Resultset.RowCount
  MsgBox "⁄œœ «·„ﬁ«·«  = " & nb_rec
End If
End Sub

Private Sub Command2_Click()
CrystalReport1.DiscardSavedData = True
CrystalReport1.Action = 1

End Sub

Private Sub Command3_Click()
CrystalReport2.DiscardSavedData = True
CrystalReport2.Action = 1
 End Sub

Private Sub Command4_Click()
CrystalReport3.DiscardSavedData = True
CrystalReport3.Action = 1

End Sub

Private Sub Command5_Click()
'CrystalReport4.DiscardSavedData = True
'CrystalReport4.Action = 1
End Sub

Private Sub Command6_Click()
Unload frm_res2

End Sub

Private Sub Command7_Click()
CrystalReport5.DiscardSavedData = True
CrystalReport5.Action = 1
End Sub

Private Sub Command8_Click()
jad_print = 1
 Screen.MousePointer = vbDefault
  Screen.MousePointer = vbHourglass
  form_report.WindowState = 2
  form_report.Show
  Screen.MousePointer = vbDefault

End Sub

Private Sub DBGrid2_dblClick()

    Dim V_REC As Variant
    Dim M_NAM, M_NAM1, M_CD As String
    lkey = KeyAscii
         
If main_form = 7 Then
   V_REC = DBGrid2.Columns(1)
    M_CD = "\\Server\C\PICTURES\"
    M_NAM = "c:\acdsee32\acdsee32.exe " & M_CD
    M_NAM1 = Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\" & V_REC & "." & "tif"
    M_NAM = M_NAM & M_NAM1
Else
       V_REC = DBGrid2.Columns(6)
       
      ' M_CD = "\\Server\c\scan\"
       M_NAM = "c:\acdsee32\acdsee32.exe " & m_cnf_path_pic
       M_NAM1 = Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\" & V_REC & ".tif"
       M_NAM = M_NAM & M_NAM1
 End If
       x = Shell(M_NAM, 1)
End Sub

Private Sub DBGrid2_KeyDown(KeyCode As Integer, Shift As Integer)
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
      m_row = DBGrid2.Row
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
     DBGrid2.Row = m_row
  ElseIf main_form = 7 Then
    m_row = DBGrid2.Row
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
      DBGrid2.Row = m_row
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

 
Private Sub fillist_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
   Frame2.Visible = False
   DBGrid2.SetFocus
End If
End Sub

Private Sub Form_Load()
  
  m_if1 = 1
  m_if2 = 2
'If ARCHIVE.f2.Checked = True Or ARCHIVE.f5.Checked = True Then
If main_form = 1 Or main_form = 4 Then
   CRIT = "select bnkout.* from bnkout where out_chioce = " & "'" & m_if1 & "'"
   bnkout1.SQL = CRIT
'ElseIf ARCHIVE.f3.Checked = True Then
 ElseIf main_form = 2 Then
var_ist = "02"
  crit2 = "select pout.* from pout"
  crit2 = crit2 & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_chioce = " & "'" & m_if1 & "'" & " )"
  bnkout1.SQL = crit2
'ElseIf ARCHIVE.f4.Checked = True Then
ElseIf main_form = 3 Then
  var_ist = "01"
  crit2 = "select pout.* from pout"
  crit2 = crit2 & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_chioce = " & "'" & m_if1 & "'" & " )"
  bnkout1.SQL = crit2
  ElseIf main_form = 5 Then
  var_ist = "03"
  crit2 = "select pout.* from pout"
  crit2 = crit2 & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_chioce = " & "'" & m_if1 & "'" & " )"
  bnkout1.SQL = crit2
 ElseIf main_form = 7 Then
   CRIT = "select bnkout.* from bnkout where out_chioce = " & "'" & m_if1 & "'" & "order by out_indx"
   bnkout1.SQL = CRIT
 End If
bnkout1.Refresh

'If ARCHIVE.f2.Checked = True Then
If main_form = 1 Then
    result.SQL = "execute tmp_result"
   result.Refresh
   bnkout1.Resultset.MoveFirst
     i = 0
    While Not bnkout1.Resultset.EOF
      If bnkout1.Resultset![out_chioce] = 1 Then
         DBGrid2.Columns(i).DataField = bnkout1.Resultset![OUT_name]
         DBGrid2.Columns(i).Caption = Trim(bnkout1.Resultset![OUT_desc])
         DBGrid2.Columns(i).Width = bnkout1.Resultset![OUT_len1]
       i = i + 1
       End If
       bnkout1.Resultset.MoveNext
    Wend
'ElseIf ARCHIVE.f5.Checked = True Then
ElseIf main_form = 4 Then
    result.SQL = "execute tmp_result3"
   result.Refresh
   bnkout1.Resultset.MoveFirst
     i = 0
    While Not bnkout1.Resultset.EOF
      If bnkout1.Resultset![out_chioce] = 1 Then
         DBGrid2.Columns(i).DataField = bnkout1.Resultset![OUT_name]
         DBGrid2.Columns(i).Caption = Trim(bnkout1.Resultset![OUT_desc])
         DBGrid2.Columns(i).Width = bnkout1.Resultset![OUT_len1]
       i = i + 1
       End If
       bnkout1.Resultset.MoveNext
    Wend
 
' ElseIf ARCHIVE.f3.Checked = True Then
 ElseIf main_form = 2 Then
   result.SQL = "execute tmp_result1"
   result.Refresh
      bnkout1.Resultset.MoveFirst
     i = 0
    While Not bnkout1.Resultset.EOF
      If bnkout1.Resultset![out_chioce] = 1 And bnkout1.Resultset![out_ist] = var_ist Then
         DBGrid2.Columns(i).DataField = bnkout1.Resultset![OUT_name]
         DBGrid2.Columns(i).Caption = bnkout1.Resultset![OUT_desc]
         DBGrid2.Columns(i).Width = bnkout1.Resultset![OUT_len1]
       i = i + 1
       End If
       bnkout1.Resultset.MoveNext
    Wend

'ElseIf ARCHIVE.f4.Checked = True Then
ElseIf main_form = 3 Then
   result.SQL = "execute tmp_result2"
   result.Refresh
         bnkout1.Resultset.MoveFirst
     i = 0
    While Not bnkout1.Resultset.EOF
      If bnkout1.Resultset![out_chioce] = 1 And bnkout1.Resultset![out_ist] = var_ist Then
         DBGrid2.Columns(i).DataField = bnkout1.Resultset![OUT_name]
         DBGrid2.Columns(i).Caption = Trim(bnkout1.Resultset![OUT_desc])
         DBGrid2.Columns(i).Width = bnkout1.Resultset![OUT_len1]
       i = i + 1
       End If
       bnkout1.Resultset.MoveNext
    Wend
ElseIf main_form = 5 Then
   result.SQL = "execute tmp_result4"
   result.Refresh
         bnkout1.Resultset.MoveFirst
     i = 0
    While Not bnkout1.Resultset.EOF
      If bnkout1.Resultset![out_chioce] = 1 And bnkout1.Resultset![out_ist] = var_ist Then
         DBGrid2.Columns(i).DataField = bnkout1.Resultset![OUT_name]
         DBGrid2.Columns(i).Caption = Trim(bnkout1.Resultset![OUT_desc])
         DBGrid2.Columns(i).Width = bnkout1.Resultset![OUT_len1]
       i = i + 1
       End If
       bnkout1.Resultset.MoveNext
    Wend

ElseIf main_form = 7 Then
    result.SQL = "execute tmp_result7"
   result.Refresh
   bnkout1.Resultset.MoveFirst
     i = 0
    While Not bnkout1.Resultset.EOF
      If bnkout1.Resultset![out_chioce] = 1 Then
         DBGrid2.Columns(i).DataField = bnkout1.Resultset![OUT_name]
         DBGrid2.Columns(i).Caption = Trim(bnkout1.Resultset![OUT_desc])
         DBGrid2.Columns(i).Width = bnkout1.Resultset![OUT_len1]
       i = i + 1
       End If
       bnkout1.Resultset.MoveNext
    Wend
 

End If
   For k = i To 26
     DBGrid2.Columns(k).Visible = False
   Next
  DBGrid2.Refresh
     
End Sub

Private Sub M_NAM_CD_Change()
'Dim mydb As Database
'Dim MYTAB As Recordset

'Set mydb = DBEngine.Workspaces(0).OpenDatabase("c:\program files\gnr_prg\gnr_11.mdb")
'Set MYTAB = mydb.OpenRecordset("NAM_CD")
'If Not IsEmpty(M_NAM_CD) And Not IsNull(M_NAM_CD) And Not M_NAM_CD = "" Then
'    MYTAB.Edit
'    MYTAB("NAME_CD") = M_NAM_CD
'    MYTAB.Update
'End If
'
End Sub

Private Sub Form1_Click()

End Sub

