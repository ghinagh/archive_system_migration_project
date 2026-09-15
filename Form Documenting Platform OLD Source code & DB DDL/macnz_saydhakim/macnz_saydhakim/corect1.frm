VERSION 5.00
Begin VB.Form corect1 
   Caption         =   "Form1"
   ClientHeight    =   6675
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11460
   LinkTopic       =   "Form1"
   ScaleHeight     =   6675
   ScaleWidth      =   11460
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text1 
      Height          =   615
      Left            =   6720
      TabIndex        =   8
      Text            =   "Text1"
      Top             =   2520
      Width           =   3015
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   975
      Left            =   6840
      TabIndex        =   7
      Top             =   960
      Width           =   2895
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H8000000C&
      Height          =   3135
      Left            =   0
      RightToLeft     =   -1  'True
      TabIndex        =   0
      Top             =   0
      Width           =   5535
      Begin VB.DriveListBox drvlist 
         Height          =   315
         Left            =   3120
         TabIndex        =   5
         Top             =   480
         Width           =   2175
      End
      Begin VB.DirListBox Dirlist 
         Height          =   1440
         Left            =   3120
         TabIndex        =   4
         Top             =   960
         Width           =   2175
      End
      Begin VB.FileListBox fillist 
         Height          =   1845
         Left            =   120
         TabIndex        =   3
         Top             =   480
         Width           =   2895
      End
      Begin VB.CommandButton Command19 
         Caption         =   "‰”Œ «·„·› «·Ï «·«—‘Ì›"
         Height          =   375
         Left            =   3240
         TabIndex        =   2
         Top             =   2520
         Width           =   1815
      End
      Begin VB.CommandButton Command18 
         Caption         =   "«·€«¡ «·«„—"
         Height          =   375
         Left            =   600
         TabIndex        =   1
         Top             =   2520
         Width           =   1695
      End
      Begin VB.Label Label22 
         Alignment       =   2  'Center
         BackColor       =   &H8000000C&
         Caption         =   "—»ÿ «·„·›«  «·„ÿ·Ê»… »«·«” „«—…"
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
         Left            =   1200
         TabIndex        =   6
         Top             =   480
         Width           =   3495
      End
   End
End
Attribute VB_Name = "corect1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
Dim i As Integer
For k = 0 To fillist.ListCount - 1
  
 
 m_no = Mid(Trim(fillist.List(k)), 1, 6)
 m_typ = Mid(Trim(fillist.List(k)), 8, 3)
 
     sql = "execute upd_digit_high " & "'" & m_no & "'" & "," & "'" & m_typ & "'"
                cn.Execute sql, rdExecDirect
                i = i + 1
                Text1.Text = i
                Text1.Refresh
                
 
 
 
Next k
MsgBox "...........fin"

End Sub

Private Sub Dirlist_Change()
fillist.Path = Dirlist.Path
End Sub

Private Sub drvlist_Change()
Dirlist.Path = drvlist.Drive
End Sub

Private Sub Form_Load()
 cn.Connect = "uid=;pwd=;server=WIN-QTIKVCQC636;" _
      & "driver={SQL Server};database=macnz_manar;" _
      & "DSN='';"
      cn.CursorDriver = rdUseOdbc
     cn.EstablishConnection rdDriverNoPrompt
       
End Sub
