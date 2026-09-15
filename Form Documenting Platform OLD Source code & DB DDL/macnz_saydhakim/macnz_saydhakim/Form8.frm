VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Begin VB.Form Form8 
   Caption         =   "Form8"
   ClientHeight    =   8490
   ClientLeft      =   1290
   ClientTop       =   -480
   ClientWidth     =   11880
   LinkTopic       =   "Form8"
   Moveable        =   0   'False
   ScaleHeight     =   8490
   ScaleWidth      =   11880
   Begin VB.CommandButton Command7 
      Caption         =   "»ÕÀ ﬂ·„…"
      Height          =   495
      Left            =   2640
      TabIndex        =   15
      Top             =   6960
      Width           =   1095
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Œ‹‹—ÊÃ"
      Height          =   495
      Left            =   1440
      TabIndex        =   14
      Top             =   6960
      Width           =   975
   End
   Begin VB.CommandButton Command5 
      Caption         =   "»ÕÀ (F10)"
      Height          =   495
      Left            =   3960
      TabIndex        =   7
      Top             =   6960
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "«÷«›…"
      Height          =   495
      Left            =   8280
      TabIndex        =   6
      Top             =   6960
      Width           =   855
   End
   Begin VB.CommandButton Command2 
      Caption         =   " ⁄œÌ·"
      Height          =   495
      Left            =   7200
      TabIndex        =   5
      Top             =   6960
      Width           =   975
   End
   Begin VB.CommandButton Command3 
      Caption         =   " ”ÃÌ·"
      Height          =   495
      Left            =   6120
      TabIndex        =   4
      Top             =   6960
      Width           =   975
   End
   Begin VB.CommandButton Command4 
      Caption         =   "«·€«¡"
      Height          =   495
      Left            =   5040
      TabIndex        =   3
      Top             =   6960
      Width           =   975
   End
   Begin VB.TextBox Text1 
      BackColor       =   &H80000003&
      Enabled         =   0   'False
      Height          =   375
      Left            =   6000
      TabIndex        =   2
      Top             =   4440
      Width           =   1335
   End
   Begin VB.TextBox code 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   6600
      TabIndex        =   1
      Top             =   5640
      Visible         =   0   'False
      Width           =   1335
   End
   Begin VB.TextBox desc 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   4680
      TabIndex        =   0
      Top             =   6000
      Visible         =   0   'False
      Width           =   3255
   End
   Begin MSRDC.MSRDC auther 
      Height          =   330
      Left            =   120
      Top             =   6480
      Visible         =   0   'False
      Width           =   2175
      _ExtentX        =   3836
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
      RecordSource    =   "select * from auther order by aut_no"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
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
   Begin MSDBCtls.DBList DBList1 
      Bindings        =   "Form8.frx":0000
      Height          =   3570
      Left            =   4800
      TabIndex        =   8
      Top             =   840
      Width           =   4455
      _ExtentX        =   7858
      _ExtentY        =   6297
      _Version        =   393216
      BackColor       =   12632256
      ListField       =   "AUT_NAM"
      BoundColumn     =   "AUT_NAM"
      RightToLeft     =   -1  'True
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H8000000C&
      Caption         =   "„·›  —„Ì“  „”ƒÊ·Ì «·»Ì«‰«  ··ÊÀ«∆ﬁ"
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
      Left            =   3960
      TabIndex        =   13
      Top             =   0
      Width           =   3615
   End
   Begin VB.Shape Shape4 
      BackColor       =   &H000000FF&
      Height          =   735
      Left            =   1320
      Top             =   6840
      Width           =   7935
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      BackColor       =   &H8000000C&
      Caption         =   "‘«‘… «·«Ê«„—"
      Height          =   255
      Left            =   5760
      TabIndex        =   12
      Top             =   6600
      Width           =   1695
   End
   Begin VB.Shape Shape3 
      Height          =   1095
      Left            =   4560
      Top             =   5400
      Visible         =   0   'False
      Width           =   4575
   End
   Begin VB.Label Label6 
      Alignment       =   2  'Center
      BackColor       =   &H8000000C&
      Caption         =   "„⁄«·Ã« "
      Height          =   255
      Left            =   6000
      RightToLeft     =   -1  'True
      TabIndex        =   11
      Top             =   5280
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.Label Label7 
      Alignment       =   2  'Center
      BackColor       =   &H8000000D&
      Caption         =   "«·—ﬁ„"
      Height          =   375
      Left            =   7920
      TabIndex        =   10
      Top             =   5640
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.Label Label8 
      Alignment       =   2  'Center
      BackColor       =   &H8000000D&
      Caption         =   "«”„ «·„ƒ·› «Ê œ«— «·‰‘—"
      Height          =   375
      Left            =   7920
      TabIndex        =   9
      Top             =   6000
      Visible         =   0   'False
      Width           =   975
   End
End
Attribute VB_Name = "Form8"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim mod_typ As Variant
Dim typ_serh As Variant


Private Sub Label4_Click()

End Sub


Private Sub code_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then

      Label6.Visible = False
      Label7.Visible = False
      Label8.Visible = False
      Shape3.Visible = False
      code.Visible = False
      desc.Visible = False
      DBList1.SetFocus
       SendKeys "{up}"
End If

End Sub

Private Sub Command1_Click()
 mod_typ = "1"
 desc.Text = ""
  code.Visible = True
  desc.Visible = True
  Label6.Visible = True
  Shape3.Visible = True
  Label7.Visible = True
  Label8.Visible = True
  AUTHER.Resultset.MoveLast
' auther.Resultset.MovePrevious
 code.Text = AUTHER.Resultset![aut_no] + 1
  desc.SetFocus
  
  
  
  

End Sub

Private Sub Command2_Click()
  mod_typ = "2"
   AUTHER.Resultset.Bookmark = DBList1.SelectedItem
   code.Text = AUTHER.Resultset![aut_no]
   desc.Text = AUTHER.Resultset![aut_nam]
  
  code.Visible = True
  desc.Visible = True
  Label6.Visible = True
  Shape3.Visible = True
  Label7.Visible = True
  Label8.Visible = True
  code.Enabled = False
  desc.SetFocus


End Sub

Private Sub Command3_Click()
 Dim m_code As Variant
 Dim m_desc As Variant
' Dim cn As New rdoConnection
 Dim sql As String
  
  If mod_typ = "1" Then
      sql = "execute insr_auther " & "'" & desc.Text & "'" & "," & "'" & code.Text & "'"
          
   '         cn.Connect = "uid=;pwd=;server=SEQUEL;" _
   '        & "driver={SQL Server};database=macnz;" _
   '        & "DSN='';"
   '         cn.CursorDriver = rdUseOdbc
   '         cn.EstablishConnection rdDriverNoPrompt
            cn.Execute sql, rdExecDirect
              AUTHER.sql = "select * from auther order by aut_no"
            AUTHER.Refresh
            DBList1.Refresh
       
ElseIf mod_typ = "2" Then
 sql = "execute upd_auther " & "'" & desc.Text & "'" & "," & "'" & code.Text & "'"
          
            ' cn.Connect = "uid=;pwd=;server=SEQUEL;" _
        '   & "driver={SQL Server};database=macnz;" _
        '   & "DSN='';"
        '    cn.CursorDriver = rdUseOdbc
        '    cn.EstablishConnection rdDriverNoPrompt
            cn.Execute sql, rdExecDirect
            AUTHER.Refresh
            DBList1.Refresh
       
End If
      Label6.Visible = False
      Label7.Visible = False
      Label8.Visible = False
      Shape3.Visible = False
      code.Visible = False
      desc.Visible = False
DBList1.SetFocus

End Sub

Private Sub Command4_Click()
 Dim ok As String
 Dim m_code As Variant
 Dim m_desc As Variant
' Dim cn As New rdoConnection
 Dim sql As String
          
         ok = " "
         ok = InputBox("Â·  —Ìœ «·€«¡ «·„ﬁ«·…(‰/ﬂ)")
If ok = "y" Or ok = "‰" Then
        AUTHER.Resultset.Bookmark = DBList1.SelectedItem
         m_code = AUTHER.Resultset![aut_no]
            sql = "execute del_auther " & "'" & m_code & "'"
         '    cn.Connect = "uid=;pwd=;server=SEQUEL;" _
         '  & "driver={SQL Server};database=macnz;" _
         '  & "DSN='';"
         '   cn.CursorDriver = rdUseOdbc
         '   cn.EstablishConnection rdDriverNoPrompt
            cn.Execute sql, rdExecDirect
   
     AUTHER.Refresh
     DBList1.Refresh
     DBList1.SetFocus
     SendKeys "{up}"
End If
End Sub

Private Sub Command5_Click()
 Dim m_len As Integer
'If typ_serh = 1 Then
  mod_typ = "3"
 Label6.Visible = True
 Label7.Visible = True
 Label8.Visible = True
 desc.Visible = True
 Shape3.Visible = True
 desc.SetFocus
 typ_serh = 2
 desc.Text = ""
'ElseIf typ_serh = 2 Then
 ' m_desc = desc.Text
 ' m_len = Len(Trim(m_desc))
 '' AUTHER.sql = "execute serh_auther1 " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
 ' AUTHER.Refresh
 ' DBList1.Refresh
  'typ_serh = 3
 ' mod_typ = "3"
  ''      Label6.Visible = False
 '      Label7.Visible = False
 '      Label8.Visible = False
'        code.Visible = False
  '      desc.Visible = False
  '      Shape3.Visible = False
   '      DBList1.SetFocus
 ' '   SendKeys "{up}"
    
'
End Sub

Private Sub Command6_Click()
Unload Form8
End Sub

Private Sub Command7_Click()
Dim m_len As Integer
 
 Label6.Visible = True
 Label7.Visible = True
 Label8.Visible = True
 desc.Visible = True
 Shape3.Visible = True
 typ_serh = 3
  mod_typ = "3"

 desc.SetFocus
  
  
End Sub

Private Sub DBList1_Click()

AUTHER.Resultset.Bookmark = DBList1.SelectedItem
If Not IsNull(AUTHER.Resultset![aut_no]) Then
 Text1.Text = AUTHER.Resultset![aut_no]
End If

End Sub



Private Sub DBList1_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
  If Trim(AUTHER.sql) = "select * from auther order by aut_no" Then
   Else
     AUTHER.sql = "select * from auther order by aut_no"
     AUTHER.Refresh
     DBList1.Refresh
   End If
End If
End Sub

Private Sub DBList1_KeyUp(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyF10 Then
  Dim m_len As Integer
If typ_serh = 1 Then

 Label6.Visible = True
 Label7.Visible = True
 Label8.Visible = True
 desc.Visible = True
 Shape3.Visible = True
 desc.SetFocus
 typ_serh = 2
ElseIf typ_serh = 2 Then
  m_desc = desc.Text
  m_len = Len(Trim(m_desc))
  AUTHER.sql = "execute serh_auther1 " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
  AUTHER.Refresh
  DBList1.Refresh
   typ_serh = 1
       Label6.Visible = False
       Label7.Visible = False
       Label8.Visible = False
'        code.Visible = False
        desc.Visible = False
        Shape3.Visible = False
         DBList1.SetFocus
     SendKeys "{up}"
    
End If
End If
 
End Sub

Private Sub desc_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then

      Label6.Visible = False
      Label7.Visible = False
      Label8.Visible = False
      Shape3.Visible = False
      code.Visible = False
      desc.Visible = False
      DBList1.SetFocus
      SendKeys "{up}"
ElseIf KeyAscii = 13 Then
If mod_typ = "3" Then
 If typ_serh = 2 Then
   m_desc = desc.Text
   m_len = Len(Trim(m_desc))
  AUTHER.sql = "execute serh_auther1 " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
  AUTHER.Refresh
  DBList1.Refresh
   typ_serh = 1
        Label6.Visible = False
       Label7.Visible = False
       Label8.Visible = False
'        code.Visible = False
        desc.Visible = False
        Shape3.Visible = False
      DBList1.SetFocus
     SendKeys "{up}"
  ElseIf typ_serh = 3 Then
  
   m_desc = desc.Text
   m_len = Len(Trim(m_desc))
  AUTHER.sql = "execute serh_auther2 " & "'" & m_desc & "'"
  AUTHER.Refresh
  DBList1.Refresh
   typ_serh = 1
        Label6.Visible = False
       Label7.Visible = False
       Label8.Visible = False
'        code.Visible = False
        desc.Visible = False
        Shape3.Visible = False
      DBList1.SetFocus
     SendKeys "{up}"
  
  
 End If
Else
   m_desc = Trim(desc.Text)
   m_len = Len(Trim(m_desc))
   m_desc = m_desc + Space(30 - m_len)
  AUTHER.sql = "execute serh_auther1 " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
  AUTHER.Refresh
  If Not AUTHER.Resultset.EOF And Not AUTHER.Resultset.BOF Then
      MsgBox "Â–« «·«”„ „ÊÃÊœ ”«»ﬁ«...!!!"
      AUTHER.sql = "select * from auther"
      AUTHER.Refresh
         Command3.SetFocus
    
   Else
      AUTHER.sql = "select * from auther"
      AUTHER.Refresh
      Command3.SetFocus
   End If
   
End If
End If


End Sub

Private Sub Form_Load()
 typ_serh = 1
End Sub
