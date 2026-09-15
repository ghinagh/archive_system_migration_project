VERSION 5.00
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Begin VB.Form users 
   BackColor       =   &H0086C8EC&
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "»ÿ«ﬁ… «·œŒÊ·"
   ClientHeight    =   1545
   ClientLeft      =   4485
   ClientTop       =   3060
   ClientWidth     =   4035
   FillStyle       =   7  'Diagonal Cross
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "users.frx":0000
   RightToLeft     =   -1  'True
   ScaleHeight     =   1545
   ScaleWidth      =   4035
   StartUpPosition =   2  'CenterScreen
   Begin MSRDC.MSRDC f_users 
      Height          =   375
      Left            =   600
      Top             =   2640
      Visible         =   0   'False
      Width           =   2655
      _ExtentX        =   4683
      _ExtentY        =   661
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
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "f_users"
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
   Begin VB.TextBox m_user_password 
      Alignment       =   1  'Right Justify
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "***"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   12289
         SubFormatType   =   0
      EndProperty
      ForeColor       =   &H80000007&
      Height          =   375
      IMEMode         =   3  'DISABLE
      Left            =   120
      PasswordChar    =   "*"
      RightToLeft     =   -1  'True
      TabIndex        =   3
      Top             =   840
      Width           =   1575
   End
   Begin VB.TextBox m_user_no 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   120
      MaxLength       =   4
      RightToLeft     =   -1  'True
      TabIndex        =   1
      Top             =   120
      Width           =   1575
   End
   Begin VB.Image Image1 
      Height          =   1080
      Left            =   2880
      Picture         =   "users.frx":129D2
      Top             =   120
      Width           =   1080
   End
   Begin VB.Label Label2 
      BackColor       =   &H00C0E0FF&
      BackStyle       =   0  'Transparent
      Caption         =   "ﬂ·„… «·”—:"
      BeginProperty Font 
         Name            =   "Arabic Transparent"
         Size            =   12
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   372
      Left            =   1800
      RightToLeft     =   -1  'True
      TabIndex        =   2
      Top             =   840
      Width           =   1092
   End
   Begin VB.Label Label1 
      BackColor       =   &H00C0E0FF&
      BackStyle       =   0  'Transparent
      Caption         =   "«·„” Œœ„ :"
      BeginProperty Font 
         Name            =   "Arabic Transparent"
         Size            =   12
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1800
      RightToLeft     =   -1  'True
      TabIndex        =   0
      Top             =   120
      Width           =   1335
   End
End
Attribute VB_Name = "users"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim m_nb As Integer

Private Sub Command1_Click()
 

  End Sub


Private Sub Form_Load()
f_users.UserName = M_SQL_USER
f_users.Password = M_SQL_PASSWORD
f_users.DataSourceName = M_SQL_NAM
f_users.Refresh
m_nb = 0


End Sub

Private Sub m_user_no_Change()
  m_len = Len(Trim(m_user_no.Text))
 If m_user_no.MaxLength <= m_len + 1 Then
   f_users.sql = "exec SERCH_users " & "'" & m_user_no.Text & "'"
   f_users.Refresh
   typ_serh = 2
 If Not f_users.Resultset.EOF Or Not f_users.Resultset.BOF Then
   box_user_no = m_user_no.Text
   box_user_name = f_users.Resultset![user_name]
   box_user_password = f_users.Resultset![user_password]
   box_user_start = f_users.Resultset![user_start]
   box_user_pwd = f_users.Resultset![user_pwd]
   box_user_ent = f_users.Resultset![user_ent]
   box_user_doc = f_users.Resultset![user_doc]
box_user_cmpvd = Trim(f_users.Resultset![user_cmpvd])
m_cnf_path_pic = Trim(f_users.Resultset![user_cnf_path])
video_path = Trim(f_users.Resultset![user_video_path])
video_path1 = Trim(f_users.Resultset![user_video_path1])
' m_cnf_path_pic = "c:\"
box_company = f_users.Resultset![user_company]
   m_user_password.SetFocus
   m_nb = 0
Else
  MsgBox "Â–« «·—ﬁ„ €Ì— „ÊÃÊœ !!!!"
  m_nb = m_nb + 1
  m_user_no.Text = ""
 If m_nb = 5 Then
  Unload users
 End If
 End If
 End If
End Sub

Private Sub m_user_no_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then
  f_users.sql = "exec SERCH_users " & "'" & m_user_no.Text & "'"
  f_users.Refresh
  typ_serh = 2
 If Not f_users.Resultset.EOF Or Not f_users.Resultset.BOF Then
   box_user_no = m_user_no.Text
   box_user_name = f_users.Resultset![user_name]
   box_user_password = f_users.Resultset![user_password]
   m_user_password.SetFocus
   m_nb = 0
Else
 MsgBox "Â–« «·—ﬁ„ €Ì— „ÊÃÊœ !!!!"
 m_nb = m_nb + 1
 m_user_no.Text = ""
 If m_nb = 5 Then
  Unload users
 End If
 
End If
ElseIf KeyAscii = 27 Then
 Unload users
End If
End Sub


Private Sub m_user_password_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  If Not m_user_no.Text = "" Then
  If Not f_users.Resultset.EOF Or Not f_users.Resultset.BOF Then
  If Trim(box_user_password) = Trim(m_user_password.Text) Then
  ' cn.Connect = "uid=;pwd=;server=server\sql2012;"
 'cn.Connect = "uid=;pwd=;server=WIN-9HE7S5KMGV8\ARCHIVE;" _
  '       & "driver={SQL Server};database=macnz_manar;" _
   '   & "DSN='';"
   '  cn.CursorDriver = rdUseOdbc
   ' cn.EstablishConnection rdDriverNoPrompt
    '172.18.1.9\data17
         ' cn.Connect = "uid=;pwd=;server=dbserver01;"
 cn.Connect = "uid=;pwd=;server=.;" _
     & "driver={SQL Server};database=macnz_manar;" _
      & "DSN='';"
     cn.CursorDriver = rdUseOdbc
     cn.EstablishConnection rdDriverNoPrompt
  ' m_cnf_path_pic = "d:\NASRALA1\"
  typ_prog = 0
      box_serch = 1
   Unload users
  ARCHIVE.Show
   'USER_INTERFACE1.Show
   
    m_sad_act = 1
  ' start.Show
  Else
    MsgBox "ﬂ·„… «·„—Ê— €Ì— ’ÕÌÕ… !!!!"
    m_user_password.Text = ""
    m_user_password.SetFocus
    m_nb = m_nb + 1
    If m_nb = 4 Then
     Unload users
    End If
    
 
  
 End If
 Else
   MsgBox "Â–« «·—ﬁ„ €Ì— „ÊÃÊœ !!!!"
   m_user_no.SetFocus
   
 End If
 Else
    m_user_no.SetFocus
  End If
ElseIf KeyAscii = 27 Then
 Unload users
End If
End Sub
