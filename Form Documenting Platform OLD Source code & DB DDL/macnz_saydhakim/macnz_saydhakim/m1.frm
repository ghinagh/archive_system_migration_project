VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   6675
   ClientLeft      =   120
   ClientTop       =   345
   ClientWidth     =   9480
   LinkTopic       =   "Form1"
   ScaleHeight     =   6675
   ScaleWidth      =   9480
   Begin MSDBCtls.DBList DBList1 
      Bindings        =   "m1.frx":0000
      Height          =   840
      Left            =   3000
      TabIndex        =   32
      Top             =   4560
      Visible         =   0   'False
      Width           =   2175
      _ExtentX        =   3836
      _ExtentY        =   1482
      _Version        =   393216
      ListField       =   "AUT_NAM"
      BoundColumn     =   "AUT_NO"
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Command4"
      Height          =   615
      Left            =   120
      TabIndex        =   31
      Top             =   4080
      Width           =   735
   End
   Begin MSDBGrid.DBGrid DBGrid1 
      Bindings        =   "m1.frx":0015
      Height          =   735
      Left            =   1440
      OleObjectBlob   =   "m1.frx":0027
      TabIndex        =   30
      Top             =   5280
      Width           =   7815
   End
   Begin MSDBCtls.DBCombo DBCombo5 
      Bindings        =   "m1.frx":0A12
      DataSource      =   "article"
      Height          =   315
      Left            =   6240
      TabIndex        =   29
      Top             =   4560
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
   End
   Begin VB.TextBox Text9 
      Alignment       =   1  'Right Justify
      DataField       =   "ART_FLM_NO"
      DataSource      =   "article"
      Height          =   285
      Left            =   1320
      TabIndex        =   26
      Top             =   4560
      Width           =   1335
   End
   Begin MSDBCtls.DBCombo DBCombo4 
      Bindings        =   "m1.frx":0A2B
      DataSource      =   "article"
      Height          =   315
      Left            =   5520
      TabIndex        =   24
      Top             =   1920
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "PER_PER_NA"
      BoundColumn     =   "PER_PER_NO"
      Text            =   ""
   End
   Begin VB.TextBox Text8 
      Alignment       =   1  'Right Justify
      DataField       =   "ART_DTE1"
      DataSource      =   "article"
      Height          =   285
      Left            =   1320
      TabIndex        =   22
      Top             =   1920
      Width           =   1575
   End
   Begin VB.TextBox Text7 
      Alignment       =   1  'Right Justify
      DataField       =   "ART_DTE"
      DataSource      =   "article"
      Height          =   285
      Left            =   1320
      TabIndex        =   20
      Top             =   1560
      Width           =   1575
   End
   Begin MSDBCtls.DBCombo DBCombo3 
      Bindings        =   "m1.frx":0A40
      Height          =   315
      Left            =   5520
      TabIndex        =   19
      Top             =   1560
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "PER_PER_NA"
      BoundColumn     =   "PER_PER_NO"
      Text            =   ""
   End
   Begin VB.CommandButton Command3 
      Caption         =   " ⁄œÌ·"
      Height          =   495
      Left            =   0
      TabIndex        =   17
      Top             =   1560
      Width           =   975
   End
   Begin MSDBCtls.DBCombo DBCombo2 
      Bindings        =   "m1.frx":0A55
      DataSource      =   "MSRDC1"
      Height          =   315
      Left            =   1200
      TabIndex        =   16
      Top             =   840
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
   End
   Begin VB.CommandButton Command2 
      Caption         =   "”Ã· ÃœÌœ"
      Height          =   495
      Left            =   0
      TabIndex        =   13
      Top             =   3240
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   " ”ÃÌ·"
      Height          =   495
      Left            =   0
      TabIndex        =   12
      Top             =   2280
      Width           =   975
   End
   Begin VB.TextBox Text6 
      Alignment       =   1  'Right Justify
      DataField       =   "MN_ADD"
      DataSource      =   "MSRDC1"
      Height          =   285
      Left            =   3960
      TabIndex        =   10
      Top             =   3720
      Width           =   4335
   End
   Begin VB.TextBox Text5 
      Alignment       =   1  'Right Justify
      DataField       =   "MN_ADD_TTL"
      DataSource      =   "MSRDC1"
      Height          =   285
      Left            =   3240
      TabIndex        =   9
      Top             =   3360
      Width           =   5055
   End
   Begin VB.TextBox Text4 
      Alignment       =   1  'Right Justify
      DataField       =   "MN_ACT"
      DataSource      =   "MSRDC1"
      Height          =   285
      Left            =   4080
      TabIndex        =   8
      Top             =   2880
      Width           =   4215
   End
   Begin VB.TextBox Text3 
      Alignment       =   1  'Right Justify
      DataField       =   "MN_ACT_TTL"
      DataSource      =   "MSRDC1"
      Height          =   285
      Left            =   3240
      TabIndex        =   6
      Top             =   2520
      Width           =   5055
   End
   Begin MSDBCtls.DBCombo DBCombo1 
      Bindings        =   "m1.frx":0A6A
      DataSource      =   "MSRDC1"
      Height          =   315
      Left            =   6000
      TabIndex        =   5
      Top             =   840
      Width           =   1575
      _ExtentX        =   2778
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
   End
   Begin VB.TextBox Text2 
      Alignment       =   1  'Right Justify
      DataField       =   "MN_ENT_DTE"
      DataSource      =   "MSRDC1"
      Height          =   285
      Left            =   1200
      TabIndex        =   3
      Top             =   480
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      DataField       =   "MN_APP_NO"
      DataSource      =   "MSRDC1"
      Height          =   285
      Left            =   6600
      TabIndex        =   0
      Top             =   480
      Width           =   975
   End
   Begin VB.Shape Shape5 
      Height          =   615
      Left            =   1200
      Top             =   4440
      Width           =   8175
   End
   Begin VB.Label Label13 
      Alignment       =   1  'Right Justify
      Caption         =   "‰Ê⁄ «·„ﬁ«·…"
      Height          =   255
      Left            =   8040
      TabIndex        =   28
      Top             =   4560
      Width           =   1215
   End
   Begin VB.Label Label12 
      Caption         =   "—ﬁ„ «·„Ìﬂ—Ê›Ì·„"
      Height          =   375
      Left            =   2880
      TabIndex        =   27
      Top             =   4560
      Width           =   1215
   End
   Begin VB.Shape Shape4 
      Height          =   1815
      Left            =   1200
      Top             =   2400
      Width           =   8175
   End
   Begin VB.Label Label11 
      Alignment       =   1  'Right Justify
      Caption         =   "„’œ— «· —Ã„…"
      Height          =   255
      Left            =   7680
      TabIndex        =   25
      Top             =   1920
      Width           =   1095
   End
   Begin VB.Label Label10 
      Caption         =   " «—ÌŒ «· —Ã„…"
      Height          =   255
      Left            =   3000
      TabIndex        =   23
      Top             =   1920
      Width           =   1095
   End
   Begin VB.Label Label9 
      Alignment       =   1  'Right Justify
      Caption         =   " «—ÌŒ «·„ﬁ«·…"
      Height          =   255
      Left            =   2880
      TabIndex        =   21
      Top             =   1560
      Width           =   1095
   End
   Begin VB.Label Label8 
      Alignment       =   1  'Right Justify
      Caption         =   "„’œ— «·„ﬁ«·…:"
      Height          =   255
      Left            =   7680
      TabIndex        =   18
      Top             =   1560
      Width           =   1095
   End
   Begin VB.Shape Shape3 
      Height          =   855
      Left            =   1200
      Top             =   1440
      Width           =   7695
   End
   Begin VB.Label Label7 
      Alignment       =   1  'Right Justify
      Caption         =   "«·„ÊÀﬁ"
      Height          =   255
      Left            =   3240
      TabIndex        =   15
      Top             =   840
      Width           =   1215
   End
   Begin VB.Label Label6 
      Alignment       =   1  'Right Justify
      Caption         =   "„œŒ· «·»Ì«‰« "
      Height          =   255
      Left            =   7320
      TabIndex        =   14
      Top             =   840
      Width           =   1335
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      Caption         =   "«·⁄‰Ê«‰ «·À«‰ÊÌ"
      Height          =   615
      Left            =   8520
      TabIndex        =   11
      Top             =   3480
      Width           =   615
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      Caption         =   "«·⁄‰Ê«‰ «·›⁄·Ì "
      Height          =   615
      Left            =   8520
      TabIndex        =   7
      Top             =   2640
      Width           =   735
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      Caption         =   " «—ÌŒ «·«œŒ«· "
      Height          =   255
      Left            =   2520
      TabIndex        =   4
      Top             =   480
      Width           =   1335
   End
   Begin VB.Shape Shape2 
      Height          =   855
      Left            =   1080
      Top             =   360
      Width           =   7695
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      Caption         =   "«·—ﬁ„ :"
      Height          =   255
      Left            =   8160
      TabIndex        =   2
      Top             =   480
      Width           =   615
   End
   Begin VB.Shape Shape1 
      Height          =   375
      Left            =   2160
      Top             =   0
      Width           =   3495
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "«” „«—… «·„ﬁ«·«  «·’Õ›Ì…  "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   2640
      TabIndex        =   1
      Top             =   0
      Width           =   2775
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command1_Click()
MSRDC1.Resultset.Update
End Sub

Private Sub Command2_Click()
MSRDC1.Resultset.AddNew

End Sub

Private Sub Command3_Click()
MSRDC1.Resultset.Edit
article.Resultset.Edit
End Sub

Private Sub DBCombo1_Change()
 Dim m_code As String
 
 MSRDC2.Resultset.Bookmark = DBCombo1.SelectedItem
 m_code = MSRDC2.Resultset![sub_code]
 MSRDC1.Resultset![mn_DATA_EN] = m_code
' MSRDC1.Resultset.Update

End Sub

Private Sub DBCombo2_CHANGE()

 Dim m_code As String
 MSRDC3.Resultset.Bookmark = DBCombo2.SelectedItem
  m_code = MSRDC3.Resultset![sub_code]
 MSRDC1.Resultset![mn_APP_DOC] = m_code

End Sub

Private Sub DBCombo3_Change()
 period.Resultset.Bookmark = DBCombo3.SelectedItem
 article.Resultset![art_per_no] = period.Resultset![per_per_no]

End Sub

Private Sub DBCombo4_Change()
period.Resultset.Bookmark = DBCombo4.SelectedItem
 article.Resultset![art_per1] = period.Resultset![per_per_no]
End Sub

Private Sub DBCombo5_Change()
coding_typ.Resultset.Bookmark = DBCombo5.SelectedItem
article.Resultset![art_typ] = coding_typ.Resultset![sub_code]

End Sub


Private Sub DBGrid1_KeyPress(KeyAscii As Integer)
 DBList1.Visible
 
End Sub

Private Sub Text1_Change()
 
res.SQL = "execute res_proc " & Text1.Text
res.Refresh
DBGrid1.Refresh
DBCombo2.Refresh


End Sub
