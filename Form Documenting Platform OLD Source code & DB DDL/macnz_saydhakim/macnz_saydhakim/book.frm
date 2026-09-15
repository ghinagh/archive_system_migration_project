VERSION 5.00
Begin VB.Form ARCHIVE 
   BackColor       =   &H80000003&
   Caption         =   "»—‰«„Ã »‰ﬂ «·„⁄·Ê„« "
   ClientHeight    =   8310
   ClientLeft      =   255
   ClientTop       =   825
   ClientWidth     =   11880
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   18
      Charset         =   178
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form7"
   Moveable        =   0   'False
   RightToLeft     =   -1  'True
   ScaleHeight     =   8310
   ScaleWidth      =   11880
   WhatsThisHelp   =   -1  'True
   WindowState     =   2  'Maximized
   Begin VB.Menu m 
      Caption         =   "     «· ‹‹‹‹—„Ì‹‹‹‹‹‹‹‹‹“"
      Begin VB.Menu M6 
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
      Begin VB.Menu m3 
         Caption         =   "Œ—ÊÃ"
         Shortcut        =   ^Q
      End
   End
   Begin VB.Menu m4 
      Caption         =   "          «·„⁄‹‹‹‹«·Ã‹‹‹‹‹‹‹‹‹«     "
      NegotiatePosition=   1  'Left
      Begin VB.Menu M5 
         Caption         =   "«·„ﬁ«·« "
         Shortcut        =   ^C
      End
      Begin VB.Menu m7 
         Caption         =   "«·ﬂ » Ê«·Êﬁ«∆ﬁ"
         Shortcut        =   ^O
      End
      Begin VB.Menu m8 
         Caption         =   "«·‹‹‹œÊ—Ì‹‹‹‹« "
         Shortcut        =   ^D
      End
      Begin VB.Menu m12 
         Caption         =   "Õ—ﬂ… Ê’Ê· «·œÊ—Ì« "
         Shortcut        =   ^I
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
      Begin VB.Menu f4 
         Caption         =   "«” ‹—Ã‹«⁄ «·‹œÊ—Ì‹«  "
         Shortcut        =   ^F
      End
      Begin VB.Menu f5 
         Caption         =   "«” —Ã«⁄«  «·ﬂ ‹‹»"
         Shortcut        =   ^V
      End
   End
End
Attribute VB_Name = "ARCHIVE"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


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

Private Sub f2_Click()
f2.Checked = True
 typ_prog = 1
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
  sort_form.WindowState = 2
  sort_form.Show
 Screen.MousePointer = vbDefault
End Sub

Private Sub f3_Click()
 typ_prog = 2
 f3.Checked = True
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 sort_form.WindowState = 2
 sort_form.Show
 Screen.MousePointer = vbDefault
 
End Sub

Private Sub f4_Click()
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
  sort_form.WindowState = 2
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
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form3.WindowState = 2
 Form3.Show
 Screen.MousePointer = vbDefault
End Sub

Private Sub m3_Click()
Unload ARCHIVE
End Sub

Private Sub M6_Click()
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form5.WindowState = 2
 Form5.Show
 Screen.MousePointer = vbDefault
End Sub


Private Sub M5_Click()
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form6.WindowState = 2
 Form6.Show
 Screen.MousePointer = vbDefault
End Sub

Private Sub m7_Click()
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form1.WindowState = 2
 Form1.Show
 Screen.MousePointer = vbDefault

End Sub

Private Sub m8_Click()
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form9.WindowState = 2
 Form9.Show
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
