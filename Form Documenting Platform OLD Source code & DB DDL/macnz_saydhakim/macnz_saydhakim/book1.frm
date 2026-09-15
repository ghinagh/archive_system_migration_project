VERSION 5.00
Begin VB.Form book 
   BackColor       =   &H8000000D&
   Caption         =   "Form8"
   ClientHeight    =   8310
   ClientLeft      =   60
   ClientTop       =   690
   ClientWidth     =   11880
   FillColor       =   &H0000FF00&
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   18
      Charset         =   178
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H8000000D&
   LinkTopic       =   "Form8"
   RightToLeft     =   -1  'True
   ScaleHeight     =   8310
   ScaleWidth      =   11880
   Begin VB.Menu m 
      Caption         =   "                 «· ‹‹‹—„‹‹‹‹‹‹Ì‹‹‹‹‹“"
      Begin VB.Menu m6 
         Caption         =   "«·„ﬂ‰“ «·„Ê÷Ê⁄Ì"
      End
      Begin VB.Menu m2 
         Caption         =   " «·„ﬂ‰“ «·‘ﬂ·Ì"
      End
      Begin VB.Menu m10 
         Caption         =   "«·„ƒ·›Ì‰ ÊœÊ— «·‰‘—"
      End
      Begin VB.Menu m9 
         Caption         =   "„·› »‰«¡ «·«” —Ã«⁄« "
      End
      Begin VB.Menu m3 
         Caption         =   "Œ‹‹—ÊÃ"
      End
   End
   Begin VB.Menu m4 
      Caption         =   "                  «·„⁄‹‹‹‹‹‹‹«·Ã‹‹‹‹‹« "
      Begin VB.Menu m7 
         Caption         =   "«·ﬂ » Ê«·ÊÀ«∆ﬁ"
      End
      Begin VB.Menu m12 
         Caption         =   "«” „«—… «·„” ›Ìœ"
      End
      Begin VB.Menu m13 
         Caption         =   "«” „«—… «·«” ⁄«—…"
      End
   End
   Begin VB.Menu f1 
      Caption         =   "                  «·«” —Ã‹‹‹‹‹‹«⁄‹‹‹‹‹‹« "
      Begin VB.Menu f5 
         Caption         =   "«” —Ã«⁄«  «·ﬂ »"
      End
      Begin VB.Menu f3 
         Caption         =   "«” —Ã«⁄«  «·„·›«  «·«÷«›Ì…"
      End
      Begin VB.Menu f10 
         Caption         =   "«” —Ã«⁄ «·«” ⁄«—…"
      End
   End
End
Attribute VB_Name = "book"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub f10_Click()
main_form = 5
 typ_prog = 2
' f3.Checked = True
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 sort_form.WindowState = 2
 sort_form.Show
 Screen.MousePointer = vbDefault
End Sub

Private Sub f3_Click()
 main_form = 2
 typ_prog = 2
' f3.Checked = True
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 sort_form.WindowState = 2
 sort_form.Show
 Screen.MousePointer = vbDefault

End Sub

Private Sub f5_Click()
 main_form = 4
'f5.Checked = True
 typ_prog = 1
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
  sort_form.WindowState = 2
  sort_form.Show
 Screen.MousePointer = vbDefault

End Sub

Private Sub Form_Load()
typ_prog = 0
End Sub

Private Sub m10_Click()
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form8.WindowState = 2
 Form8.Show
 Screen.MousePointer = vbDefault

End Sub

Private Sub m12_Click()
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 PERSON.WindowState = 2
PERSON.Show
 Screen.MousePointer = vbDefault

End Sub

Private Sub m13_Click()
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 istara.WindowState = 2
 istara.Show
 Screen.MousePointer = vbDefault
End Sub

Private Sub M2_Click()
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form3.WindowState = 2
 Form3.Show
 Screen.MousePointer = vbDefault

End Sub

Private Sub M6_Click()
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form5.WindowState = 2
 Form5.Show
 Screen.MousePointer = vbDefault

End Sub

Private Sub m7_Click()
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 FORM1.WindowState = 2
 FORM1.Show
 Screen.MousePointer = vbDefault

End Sub

Private Sub m9_Click()
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form4.WindowState = 2
 Form4.Show
 Screen.MousePointer = vbDefault

End Sub
