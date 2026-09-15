VERSION 5.00
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form find_charit 
   BackColor       =   &H0086C8EC&
   Caption         =   "«·»ÕÀ ⁄‰ ‘—Ìÿ"
   ClientHeight    =   8595
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11880
   FontTransparent =   0   'False
   ForeColor       =   &H8000000F&
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form6"
   RightToLeft     =   -1  'True
   ScaleHeight     =   8595
   ScaleWidth      =   11880
   Begin MSDBGrid.DBGrid DBGrid1 
      Bindings        =   "find_charit.frx":0000
      Height          =   6615
      Left            =   120
      OleObjectBlob   =   "find_charit.frx":0017
      TabIndex        =   0
      Top             =   1200
      Width           =   11535
   End
   Begin VB.TextBox m_opr_stock 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00D8F9FE&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   405
      Left            =   3600
      RightToLeft     =   -1  'True
      TabIndex        =   7
      Top             =   360
      Width           =   2775
   End
   Begin VB.PictureBox StatusBar2 
      Align           =   2  'Align Bottom
      Height          =   255
      Left            =   0
      ScaleHeight     =   195
      ScaleWidth      =   11820
      TabIndex        =   5
      Top             =   8310
      Width           =   11880
   End
   Begin VB.PictureBox StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   30
      Left            =   0
      ScaleHeight     =   30
      ScaleWidth      =   11880
      TabIndex        =   4
      Top             =   8565
      Width           =   11880
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H002972B4&
      Caption         =   "«€·«ﬁ"
      Height          =   735
      Left            =   720
      MaskColor       =   &H80000006&
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   240
      Width           =   1575
   End
   Begin VB.TextBox m_cha_no 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00D8F9FE&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   405
      Left            =   7800
      MaxLength       =   6
      RightToLeft     =   -1  'True
      TabIndex        =   2
      Top             =   360
      Width           =   2775
   End
   Begin MSRDC.MSRDC opr_chrt 
      Height          =   330
      Left            =   120
      Top             =   8040
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
      RecordSource    =   "   "
      UserName        =   "sa"
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "opr_chrt"
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
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00F3C7B6&
      BackStyle       =   0  'Transparent
      Caption         =   "—ﬁ„ «·«—‘Ì› "
      Height          =   255
      Left            =   6480
      RightToLeft     =   -1  'True
      TabIndex        =   6
      Top             =   480
      Width           =   975
   End
   Begin VB.Label Label1 
      BackColor       =   &H00F3C7B6&
      BackStyle       =   0  'Transparent
      Caption         =   "—„“ «·‘—Ìÿ  "
      Height          =   255
      Left            =   10800
      RightToLeft     =   -1  'True
      TabIndex        =   1
      Top             =   480
      Width           =   975
   End
End
Attribute VB_Name = "find_charit"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim m_serh As Integer

Private Sub Command1_Click()
Unload find_charit
End Sub

Private Sub DBGrid1_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
If m_serh = 1 Then
   m_cha_no.Text = ""
   m_cha_no.SetFocus
 Else
   m_opr_stock = ""
   m_opr_stock.SetFocus
 End If
 
End If

End Sub

Private Sub Form_Activate()
m_cha_no.SetFocus

End Sub

Private Sub m_cha_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_serh = 1
   Dim sql As String
      
      v_prs_no = "000000"
      m_no = m_cha_no.Text
     v_prs_no = Mid(v_prs_no, 1, 6 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
     m_cha_no.Text = v_prs_no
   '********************
 

opr_chrt.sql = "exec find_charit" & "'" & m_cha_no.Text & "'"
opr_chrt.Refresh
DBGrid1.Refresh
   If Not opr_chrt.Resultset.EOF Or Not opr_chrt.Resultset.BOF Then
     opr_chrt.Resultset.MoveLast
     DBGrid1.SetFocus
   Else
    m_cha_no.SetFocus
    
   End If
     
End If
End Sub

Private Sub m_opr_stock_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
m_serh = 2
  opr_chrt.sql = "exec find_charit1" & "'" & m_opr_stock.Text & "'"
  opr_chrt.Refresh
  DBGrid1.Refresh
   If Not opr_chrt.Resultset.EOF Or Not opr_chrt.Resultset.BOF Then
     opr_chrt.Resultset.MoveLast
     DBGrid1.SetFocus
   Else
     m_opr_stock.SetFocus
   End If
End If
End Sub
