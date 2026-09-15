VERSION 5.00
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Object = "{00025600-0000-0000-C000-000000000046}#4.6#0"; "CRYSTL32.OCX"
Begin VB.Form Form8 
   Caption         =   "Form8"
   ClientHeight    =   6795
   ClientLeft      =   870
   ClientTop       =   1545
   ClientWidth     =   9480
   LinkTopic       =   "Form8"
   ScaleHeight     =   6795
   ScaleWidth      =   9480
   Begin VB.CommandButton Command1 
      Caption         =   "⁄œœ «·„ﬁ«·« "
      Height          =   735
      Index           =   0
      Left            =   0
      RightToLeft     =   -1  'True
      TabIndex        =   2
      Top             =   1080
      Width           =   735
   End
   Begin VB.CommandButton Command2 
      Caption         =   "⁄—÷ «·ÿ»«⁄…"
      Height          =   735
      Left            =   0
      TabIndex        =   1
      Top             =   2040
      Width           =   735
   End
   Begin VB.CommandButton Command3 
      Caption         =   "ÿ»«⁄…"
      Height          =   615
      Left            =   0
      TabIndex        =   0
      Top             =   3000
      Width           =   735
   End
   Begin Crystal.CrystalReport CrystalReport2 
      Left            =   0
      Top             =   3240
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "C:\macnz\tmp_result.rpt"
      Destination     =   1
   End
   Begin Crystal.CrystalReport CrystalReport1 
      Left            =   0
      Top             =   2040
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "C:\macnz\tmp_result.rpt"
      UserName        =   "abbas"
      PrintFileUseRptNumberFmt=   -1  'True
      PrintFileUseRptDateFmt=   -1  'True
   End
   Begin MSDBGrid.DBGrid DBGrid3 
      Align           =   4  'Align Right
      Bindings        =   "frm_res3.frx":0000
      Height          =   6795
      Left            =   4905
      OleObjectBlob   =   "frm_res3.frx":0011
      TabIndex        =   3
      Top             =   0
      Width           =   4575
   End
   Begin MSRDC.MSRDC result 
      Height          =   330
      Left            =   4200
      Top             =   0
      Width           =   1935
      _ExtentX        =   3413
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
      RecordSource    =   "select *from VIEW_RL"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "result"
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
   Begin MSDBGrid.DBGrid DBGrid2 
      Align           =   4  'Align Right
      Bindings        =   "frm_res3.frx":1260
      Height          =   6795
      Left            =   -3870
      OleObjectBlob   =   "frm_res3.frx":1273
      TabIndex        =   4
      Top             =   0
      Visible         =   0   'False
      Width           =   8775
   End
   Begin VB.Shape Shape1 
      BackColor       =   &H00C0C0C0&
      Height          =   3135
      Left            =   4320
      Top             =   840
      Width           =   975
   End
End
Attribute VB_Name = "Form8"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
result.SQL = "execute tmp_result1"
result.Refresh
DBGrid3.Refresh
End Sub
