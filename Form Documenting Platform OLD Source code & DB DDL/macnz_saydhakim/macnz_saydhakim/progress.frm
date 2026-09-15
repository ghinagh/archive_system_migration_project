VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form progress 
   BackColor       =   &H0086C8EC&
   ClientHeight    =   1065
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   4830
   LinkTopic       =   "Form6"
   ScaleHeight     =   1065
   ScaleWidth      =   4830
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command8 
      BackColor       =   &H002972B4&
      Caption         =   "cancel all"
      Height          =   375
      Left            =   1800
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   720
      Width           =   1455
   End
   Begin VB.TextBox m_tit 
      Alignment       =   2  'Center
      BackColor       =   &H0086C8EC&
      Height          =   285
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   4815
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H002972B4&
      Caption         =   "Cancel"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3480
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   720
      Width           =   1215
   End
   Begin MSComctlLib.ProgressBar ProgressBar1 
      Height          =   375
      Left            =   0
      TabIndex        =   1
      Top             =   240
      Width           =   4815
      _ExtentX        =   8493
      _ExtentY        =   661
      _Version        =   393216
      Appearance      =   1
   End
End
Attribute VB_Name = "progress"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
 
Private Sub Command1_Click()
new_vdpreview.VideoEdit1.Stop
 Unload Me
End Sub
 
Private Sub Command8_Click()
new_vdpreview.VideoEdit1.Stop
lg_stop = False
 Unload Me
End Sub
