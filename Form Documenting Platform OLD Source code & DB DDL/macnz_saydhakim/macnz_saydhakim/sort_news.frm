VERSION 5.00
Begin VB.Form ARCHIVE 
   BackColor       =   &H80000003&
   Caption         =   "»—‰«„Ã »‰ﬂ «·„⁄·Ê„« "
   ClientHeight    =   11325
   ClientLeft      =   255
   ClientTop       =   705
   ClientWidth     =   19125
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   18
      Charset         =   178
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form7"
   PaletteMode     =   2  'Custom
   RightToLeft     =   -1  'True
   ScaleHeight     =   11325
   ScaleWidth      =   19125
   WhatsThisHelp   =   -1  'True
   WindowState     =   2  'Maximized
   Begin VB.Frame Frame3 
      BackColor       =   &H00FF0000&
      Height          =   2295
      Left            =   5760
      RightToLeft     =   -1  'True
      TabIndex        =   0
      Top             =   2280
      Visible         =   0   'False
      Width           =   3135
      Begin VB.CommandButton Command20 
         Caption         =   " ‰›»–"
         BeginProperty Font 
            Name            =   "Arabic Transparent"
            Size            =   9.75
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   1800
         RightToLeft     =   -1  'True
         TabIndex        =   3
         Top             =   1560
         Width           =   735
      End
      Begin VB.CommandButton Command21 
         Caption         =   "«·€«¡ «·«„—"
         BeginProperty Font 
            Name            =   "Arabic Transparent"
            Size            =   9.75
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   360
         RightToLeft     =   -1  'True
         TabIndex        =   2
         Top             =   1560
         Width           =   735
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
         Left            =   480
         PasswordChar    =   "*"
         RightToLeft     =   -1  'True
         TabIndex        =   1
         Top             =   720
         Width           =   1575
      End
      Begin VB.Label Label16 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FF0000&
         Caption         =   "ﬂ·„… «·”—"
         BeginProperty Font 
            Name            =   "Arabic Transparent"
            Size            =   9.75
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H0000FFFF&
         Height          =   375
         Left            =   1560
         RightToLeft     =   -1  'True
         TabIndex        =   4
         Top             =   720
         Width           =   1215
      End
   End
   Begin VB.PictureBox config 
      BackColor       =   &H80000005&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   375
      Left            =   0
      ScaleHeight     =   315
      ScaleWidth      =   2115
      TabIndex        =   5
      Top             =   7800
      Visible         =   0   'False
      Width           =   2175
   End
   Begin VB.Menu m 
      Caption         =   "     «· ‹‹‹‹—„Ì‹‹‹‹‹‹‹‹‹“"
      Begin VB.Menu m6 
         Caption         =   "«·„ﬂ‰“ «·„Ê÷Ê⁄Ì"
         Shortcut        =   ^A
      End
      Begin VB.Menu m2 
         Caption         =   "«·„ﬂ‰“ «·‘ﬂ·Ì"
         Shortcut        =   ^B
      End
      Begin VB.Menu m10 
         Caption         =   "«·„ƒ·›Ì‰ ÊœÊ— «·‰‘—"
         Shortcut        =   ^K
      End
      Begin VB.Menu m9 
         Caption         =   "„·› »‰«¡ «·«” —Ã«⁄« "
      End
      Begin VB.Menu m30 
         Caption         =   "«ﬁ›«· «·ÊÀ«∆ﬁ «·„› ÊÕ…"
      End
      Begin VB.Menu m31 
         Caption         =   " „⁄«·Ã… «·„” Œœ„Ì‰"
      End
      Begin VB.Menu M32 
         Caption         =   "„⁄«·Ã… ÕﬁÊ· «·«” —Ã«⁄"
      End
      Begin VB.Menu m33 
         Caption         =   "‰”Œ ﬁ«⁄œ… «·»Ì«‰« "
      End
   End
   Begin VB.Menu m4 
      Caption         =   "          «·„⁄‹‹‹‹«·Ã‹‹‹‹‹‹‹‹‹«     "
      NegotiatePosition=   1  'Left
      Begin VB.Menu M5 
         Caption         =   " «” „«—… «· ÊÀÌﬁ"
         Shortcut        =   ^C
      End
      Begin VB.Menu M8 
         Caption         =   "«·’Õ› Ê«·„Ã·« "
         Shortcut        =   ^D
      End
   End
   Begin VB.Menu f1 
      Caption         =   "                 «·«” —Ã‹‹‹‹‹‹‹«⁄‹‹‹‹‹‹« "
      Begin VB.Menu f2 
         Caption         =   "«·«” —Ã«⁄ «·»Ì‹‹‹«‰Ì ·»‰ﬂ «·„⁄·Ê„« "
         Shortcut        =   ^S
      End
      Begin VB.Menu f3 
         Caption         =   "«” —Ã«⁄ «·„·›«  «·«÷«›Ì…"
         Shortcut        =   ^E
      End
      Begin VB.Menu f5 
         Caption         =   "ÿ·»Ì«  «·›ÌœÌÊ"
      End
      Begin VB.Menu f4 
         Caption         =   "«” ‹—Ã‹«⁄ «·’Õ› Ê«·„Ã·« "
         Shortcut        =   ^F
      End
   End
   Begin VB.Menu j1 
      Caption         =   "           ‘«‘… «·»ÕÀ "
   End
   Begin VB.Menu j5 
      Caption         =   "    ‘«‘… «·ÿ·»«     "
   End
   Begin VB.Menu k1 
      Caption         =   "‘«‘… «·»ÕÀ ›ÌœÌÊ + ’Ê Ì"
   End
End
Attribute VB_Name = "ARCHIVE"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim M_PROG As Integer
Dim RETVAL As Boolean
Dim typ_prog As Integer


Private Sub FORM3_Click()
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form4.WindowState = 2
 Form4.Show
 Screen.MousePointer = vbDefault
End Sub


Private Sub exit_Click()
 
End Sub

Private Sub Command20_Click()
If LTrim(m_user_password.Text) = password1 Then
  RETVAL = True
 End If
 Frame3.Visible = False
   If LTrim(m_user_password.Text) = password1 Then
  RETVAL = True
 End If
 Frame3.Visible = False
     If RETVAL = True Then
    If M_PROG = 1 Then
     
    Screen.MousePointer = vbDefault
    Screen.MousePointer = vbHourglass
    Form5.WindowState = 2
    Form5.Show
    Screen.MousePointer = vbDefault
    ElseIf M_PROG = 2 Then
       Screen.MousePointer = vbDefault
       Screen.MousePointer = vbHourglass
       coding.WindowState = 2
       coding.Show
       Screen.MousePointer = vbDefault
    ElseIf M_PROG = 3 Then
     sql = "execute upd_main_trans1 "
     cn.Execute sql, rdExecDirect
     MsgBox "«‰ ÂÏ «·«ﬁ›«·......."
      ElseIf M_PROG = 4 Then
      Screen.MousePointer = vbDefault
        Screen.MousePointer = vbHourglass
        config_users.WindowState = 2
        config_users.Show
        Screen.MousePointer = vbDefault
         Screen.MousePointer = vbDefault
     ElseIf M_PROG = 5 Then
      Screen.MousePointer = vbDefault
        Screen.MousePointer = vbHourglass
        CAT_OUTFRM.WindowState = 2
        CAT_OUTFRM.Show
        Screen.MousePointer = vbDefault
    End If
    
   End If
  
End Sub

Private Sub Command21_Click()
Frame3.Visible = False
RETVAL = False

End Sub

Private Sub f10_Click()
main_form = 6
f2.Checked = True
 typ_prog = 6
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
  sort_form.WindowState = 2
  sort_form.Show
 Screen.MousePointer = vbDefault
End Sub

Private Sub f2_Click()
main_form = 1
f2.Checked = True
 typ_prog = 1
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
  sort_form.WindowState = 2
  sort_form.Show
 Screen.MousePointer = vbDefault
End Sub

Private Sub f3_Click()
main_form = 2
 typ_prog = 2
 f3.Checked = True
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 sort_form.WindowState = 2
 sort_form.Show
 Screen.MousePointer = vbDefault
 
End Sub

Private Sub f4_Click()
 main_form = 3
 f4.Checked = True
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 sort_form.WindowState = 2
 sort_form.Show
 Screen.MousePointer = vbDefault
End Sub


Private Sub f5_Click()

 f5.Checked = True
 typ_prog = 1
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
   new_vdpreview.Show
 Screen.MousePointer = vbDefault
End Sub

 
Private Sub f6_Click()
main_form = 7
  f6.Checked = True
 typ_prog = 1
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
  sort_form.WindowState = 2
  sort_form.Show
 Screen.MousePointer = vbDefault
End Sub

Private Sub f9_Click()
main_form = 5

 typ_prog = 5
' f3.Checked = True
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
' sort_form.WindowState = 2
 sort_form.Show
 Screen.MousePointer = vbDefault
 
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
 If KeyAscii = 27 Then
   End
 End If
End Sub

Private Sub Form_Load()
typ_prog = 0
   ' If box_company = 1 Then
   'jad_print = 4
   ' ARCHIVE.Picture = "C:\prog_external\ABBAS\macnz_saydhakim\template\sayyyyyyyyy.jpg"
'End If
     
  
End Sub

Private Sub j1_Click()
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
  user_interface.WindowState = 2
  user_interface.Show
 Screen.MousePointer = vbDefault
End Sub

Private Sub j5_Click()
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 f_result.WindowState = 2
 f_result.Show
 Screen.MousePointer = vbDef
End Sub

Private Sub k1_Click()
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
  USER_INTERFACE1.WindowState = 2
  USER_INTERFACE1.Show
 Screen.MousePointer = vbDefault
End Sub

Private Sub m_user_password_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 If LTrim(m_user_password.Text) = password1 Then
  RETVAL = True
 End If
 Frame3.Visible = False
     If RETVAL = True Then
    If M_PROG = 1 Then
     
    Screen.MousePointer = vbDefault
    Screen.MousePointer = vbHourglass
    Form5.WindowState = 2
    Form5.Show
    Screen.MousePointer = vbDefault
    ElseIf M_PROG = 2 Then
       Screen.MousePointer = vbDefault
       Screen.MousePointer = vbHourglass
       coding.WindowState = 2
       coding.Show
       Screen.MousePointer = vbDefault
    ElseIf M_PROG = 3 Then
     sql = "execute upd_main_trans1 "
     cn.Execute sql, rdExecDirect
     MsgBox "«‰ ÂÏ «·«ﬁ›«·......."
      ElseIf M_PROG = 4 Then
      Screen.MousePointer = vbDefault
        Screen.MousePointer = vbHourglass
        
        config_users.WindowState = 2
        config_users.Show
        Screen.MousePointer = vbDefault
     ElseIf M_PROG = 5 Then
      Screen.MousePointer = vbDefault
        Screen.MousePointer = vbHourglass
        CAT_OUTFRM.WindowState = 2
        CAT_OUTFRM.Show
        Screen.MousePointer = vbDefault
    End If
    End If
 ElseIf KeyAscii = 27 Then
   Frame3.Visible = False
   RETVAL = False
   
 End If
End Sub

Private Sub m10_Click()
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form8.WindowState = 2
 Form8.Show
 Screen.MousePointer = vbDef
End Sub

Private Sub m12_Click()
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form11.WindowState = 2
 Form11.Show
 Screen.MousePointer = vbDefault
End Sub

Private Sub M2_Click()
'Dim ok As Variant
 
 'ok = " "
 'ok = InputBox("«œŒ· ﬂ·„… «·„——Ê ......!!")
 'If ok = "891045" Then

 m_user_password.Text = ""
  password1 = "891045"
  RETVAL = False
  Frame3.Visible = True
  m_user_password.SetFocus
  M_PROG = 2


' End If
End Sub

Private Sub m3_Click()


Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
  Form3.WindowState = 2
  Form3.Show
 Screen.MousePointer = vbDefault
 
End Sub

Private Sub m30_Click()
' Dim ok As Variant
 
 'ok = " "
 'ok = InputBox("«œŒ· ﬂ·„… «·„——Ê ......!!")
 'If ok = "891045" Then
 m_user_password.Text = ""
  password1 = "891045"
  RETVAL = False
  Frame3.Visible = True
  m_user_password.SetFocus
  M_PROG = 3
   
  'End If
End Sub

Private Sub m31_Click()
'Dim ok As Variant
 
 'ok = " "
 'ok = InputBox("«œŒ· ﬂ·„… «·„——Ê ......!!", "*")
 'If ok = "261015" Then
 
  m_user_password.Text = ""
  password1 = "261015"
  RETVAL = False
  Frame3.Visible = True
  m_user_password.SetFocus
  M_PROG = 4
 

  'End If
End Sub


Private Sub M32_Click()

  m_user_password.Text = ""
  password1 = "261015"
  RETVAL = False
  Frame3.Visible = True
  m_user_password.SetFocus
  M_PROG = 5
 
End Sub

Private Sub m33_Click()
sql = "BACKUP DATABASE [macnz_manar] TO  DISK = N'd:\backup\backup_macnz_manar'   WITH NOFORMAT, NOINIT,  NAME = N'social-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10"
cn.Execute sql, rdExecDirect
  MsgBox "«‰ ÂÏ «·«ﬁ›«·......."

End Sub

Private Sub M6_Click()
' Dim ok As Variant
 
 'ok = " "
 'ok = InputBox("«œŒ· ﬂ·„… «·„——Ê ......!!")
 'If ok = "891045" Then
  m_user_password.Text = ""
  password1 = "891045"
  RETVAL = False
  Frame3.Visible = True
  m_user_password.SetFocus
  M_PROG = 1
End Sub


Private Sub M5_Click()
 m_form_load = 1
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form6.WindowState = 2
 Form6.Show
 Screen.MousePointer = vbDefault
End Sub

Private Sub m7_Click()
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 picture_f.WindowState = 2
 picture_f.Show
 Screen.MousePointer = vbDefault

End Sub

Private Sub M77_Click()
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 find_charit.WindowState = 2
 find_charit.Show
 Screen.MousePointer = vbDefault
End Sub

Private Sub m8_Click()
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 PERIOD.WindowState = 2
 PERIOD.Show
 Screen.MousePointer = vbDefault

End Sub

Private Sub M88_Click()
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 istara.WindowState = 2
 istara.Show
 Screen.MousePointer = vbDefault

End Sub

Private Sub m9_Click()
 Dim ok As Variant
 
 ok = " "
 ok = InputBox("«œŒ· ﬂ·„… «·„——Ê ......!!")
 If ok = "a5g5" Or ok = "‘5·5" Then
   Screen.MousePointer = vbDefault
  Screen.MousePointer = vbHourglass
   Form4.WindowState = 2
   Form4.Show
   Screen.MousePointer = vbDefault
 End If
End Sub

Private Sub m99_Click()
Screen.MousePointer = vbDefault
   Screen.MousePointer = vbHourglass
  ' rec_charit.WindowState = 2
   rec_charit.Show
   Screen.MousePointer = vbDefault
End Sub
