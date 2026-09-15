VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Begin VB.Form Form2 
   Caption         =   "Form2"
   ClientHeight    =   4785
   ClientLeft      =   2400
   ClientTop       =   570
   ClientWidth     =   6570
   LinkTopic       =   "Form2"
   ScaleHeight     =   4785
   ScaleWidth      =   6570
   Begin MSDBCtls.DBList DBList1 
      Bindings        =   "m2.frx":0000
      DataSource      =   "ANALIS"
      Height          =   1230
      Left            =   3120
      TabIndex        =   5
      Top             =   1320
      Width           =   2895
      _ExtentX        =   5106
      _ExtentY        =   2170
      _Version        =   393216
      ListField       =   "SUB_DESC"
   End
   Begin VB.TextBox Text2 
      DataField       =   "MN_ACT_TTL"
      DataSource      =   "MAIN"
      Height          =   285
      Left            =   240
      TabIndex        =   2
      Text            =   "Text2"
      Top             =   840
      Width           =   4575
   End
   Begin VB.TextBox Text1 
      DataField       =   "MN_APP_NO"
      DataSource      =   "MAIN"
      Height          =   285
      Left            =   3720
      TabIndex        =   1
      Top             =   480
      Width           =   1095
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      Caption         =   "«·⁄‰Ê«‰ «·›⁄«Ì "
      Height          =   255
      Left            =   4920
      TabIndex        =   4
      Top             =   840
      Width           =   1095
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      Caption         =   "«·—ﬁ„ "
      Height          =   255
      Left            =   5040
      TabIndex        =   3
      Top             =   480
      Width           =   855
   End
   Begin VB.Shape Shape1 
      Height          =   855
      Left            =   120
      Top             =   360
      Width           =   6015
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "»—‰«„Ã „⁄«·Ã… «· Õ·Ì·"
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
      TabIndex        =   0
      Top             =   0
      Width           =   3015
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub DBList1_Click()
Dim M_COD As String
M_COD = Text1.Text
MsgBox " " & M_COD
ANALIS.SQL = "execute ass " & Text1.Text

ANALIS.Refresh
'DBList1.Refresh

End Sub
