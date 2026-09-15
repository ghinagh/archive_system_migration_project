VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form Form1 
   BackColor       =   &H00808080&
   Caption         =   "Form1"
   ClientHeight    =   6675
   ClientLeft      =   120
   ClientTop       =   345
   ClientWidth     =   9480
   LinkTopic       =   "Form1"
   ScaleHeight     =   6675
   ScaleWidth      =   9480
   Begin MSRDC.MSRDC MSRDC5 
      Height          =   375
      Left            =   3240
      Top             =   6120
      Visible         =   0   'False
      Width           =   1335
      _ExtentX        =   2355
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
      RecordSource    =   "select * from main"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "MSRDC5"
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
   Begin VB.CommandButton Command7 
      BackColor       =   &H80000007&
      Caption         =   "»Õ‹‹À"
      Height          =   615
      Left            =   120
      TabIndex        =   35
      Top             =   600
      Width           =   855
   End
   Begin MSRDC.MSRDC art 
      Height          =   330
      Left            =   -240
      Top             =   5760
      Visible         =   0   'False
      Width           =   1695
      _ExtentX        =   2990
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
      RecordSource    =   "select * from article"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "art"
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
   Begin VB.CommandButton Command6 
      Caption         =   "«·€‹‹«¡"
      Height          =   615
      Left            =   120
      TabIndex        =   34
      Top             =   1320
      Width           =   855
   End
   Begin VB.CommandButton Command4 
      Caption         =   "·«Õ‹‹ﬁ"
      Height          =   615
      Left            =   120
      TabIndex        =   33
      Top             =   4920
      Width           =   855
   End
   Begin VB.CommandButton Command5 
      Caption         =   "”«»ﬁ"
      Height          =   615
      Left            =   120
      TabIndex        =   32
      Top             =   4200
      Width           =   855
   End
   Begin MSRDC.MSRDC res1 
      Height          =   330
      Left            =   0
      Top             =   5760
      Visible         =   0   'False
      Width           =   1695
      _ExtentX        =   2990
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
      RecordSource    =   "select * from view_res1"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "res1"
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
   Begin MSRDC.MSRDC article1 
      Height          =   330
      Left            =   -360
      Top             =   5520
      Visible         =   0   'False
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
      RecordSource    =   "select * from view_article"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "article1"
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
      Bindings        =   "macnz.frx":0000
      DataField       =   "RES_RES_NO"
      DataSource      =   "res1"
      Height          =   1230
      Left            =   3600
      TabIndex        =   31
      Top             =   4080
      Visible         =   0   'False
      Width           =   2295
      _ExtentX        =   4048
      _ExtentY        =   2170
      _Version        =   393216
      BackColor       =   12632256
      ListField       =   "AUT_NAM"
      BoundColumn     =   "AUT_NO"
   End
   Begin MSRDC.MSRDC AUTHER 
      Height          =   330
      Left            =   600
      Top             =   5880
      Visible         =   0   'False
      Width           =   1200
      _ExtentX        =   2117
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
      RecordSource    =   "SELECT * FROM AUTHER"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
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
   Begin MSDBGrid.DBGrid DBGrid1 
      Bindings        =   "macnz.frx":0011
      Height          =   975
      Left            =   1440
      OleObjectBlob   =   "macnz.frx":001F
      TabIndex        =   30
      Top             =   5280
      Width           =   7935
   End
   Begin MSRDC.MSRDC res 
      Height          =   375
      Left            =   0
      Top             =   6000
      Visible         =   0   'False
      Width           =   2175
      _ExtentX        =   3836
      _ExtentY        =   661
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
      RecordSource    =   ""
      UserName        =   "abbas"
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "res"
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
   Begin MSRDC.MSRDC coding_typ 
      Height          =   375
      Left            =   120
      Top             =   6120
      Visible         =   0   'False
      Width           =   2295
      _ExtentX        =   4048
      _ExtentY        =   661
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
      RecordSource    =   "select * from VIEW_coding4"
      UserName        =   "abbas"
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "coding_typ"
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
   Begin MSDBCtls.DBCombo DBCombo5 
      Bindings        =   "macnz.frx":0A0E
      DataField       =   "ART_SUB_TY"
      DataSource      =   "article1"
      Height          =   315
      Left            =   6240
      TabIndex        =   29
      Top             =   4560
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   556
      _Version        =   393216
      BackColor       =   12632256
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
   End
   Begin VB.TextBox Text9 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0C0C0&
      DataField       =   "ART_FLM_NO"
      DataSource      =   "article"
      Height          =   285
      Left            =   1800
      TabIndex        =   26
      Top             =   4560
      Width           =   1335
   End
   Begin MSDBCtls.DBCombo DBCombo4 
      Bindings        =   "macnz.frx":0A23
      DataField       =   "ART_PER1"
      DataSource      =   "article1"
      Height          =   315
      Left            =   6000
      TabIndex        =   24
      Top             =   1920
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   556
      _Version        =   393216
      BackColor       =   12632256
      ListField       =   "PER_PER_NA"
      BoundColumn     =   "PER_PER_NO"
      Text            =   ""
   End
   Begin VB.TextBox Text8 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0C0C0&
      DataField       =   "ART_DTE1"
      DataSource      =   "article"
      Height          =   285
      Left            =   1920
      TabIndex        =   22
      Top             =   1920
      Width           =   1575
   End
   Begin VB.TextBox Text7 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0C0C0&
      DataField       =   "ART_DTE"
      DataSource      =   "article"
      Height          =   285
      Left            =   1920
      TabIndex        =   20
      Top             =   1560
      Width           =   1575
   End
   Begin MSRDC.MSRDC article 
      Height          =   375
      Left            =   240
      Top             =   6360
      Visible         =   0   'False
      Width           =   2295
      _ExtentX        =   4048
      _ExtentY        =   661
      _Version        =   393216
      Options         =   0
      CursorDriver    =   1
      BOFAction       =   0
      EOFAction       =   0
      RecordsetType   =   3
      LockType        =   4
      QueryType       =   0
      Prompt          =   2
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
      UserName        =   "abbas"
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "article"
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
   Begin MSRDC.MSRDC period 
      Height          =   495
      Left            =   240
      Top             =   6000
      Visible         =   0   'False
      Width           =   2775
      _ExtentX        =   4895
      _ExtentY        =   873
      _Version        =   393216
      Options         =   0
      CursorDriver    =   1
      BOFAction       =   0
      EOFAction       =   0
      RecordsetType   =   3
      LockType        =   4
      QueryType       =   0
      Prompt          =   2
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
      RecordSource    =   "select * from period"
      UserName        =   "abbas"
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server = sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "period"
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
   Begin MSDBCtls.DBCombo DBCombo3 
      Bindings        =   "macnz.frx":0A34
      DataField       =   "ART_PER_NO"
      DataSource      =   "article1"
      Height          =   315
      Left            =   6000
      TabIndex        =   19
      Top             =   1560
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   556
      _Version        =   393216
      BackColor       =   12632256
      ListField       =   "PER_PER_NA"
      BoundColumn     =   "PER_PER_NO"
      Text            =   ""
   End
   Begin VB.CommandButton Command3 
      Caption         =   " ⁄œÌ·"
      Height          =   615
      Left            =   120
      TabIndex        =   17
      Top             =   2040
      Width           =   855
   End
   Begin MSRDC.MSRDC MSRDC3 
      Height          =   375
      Left            =   5640
      Top             =   6360
      Visible         =   0   'False
      Width           =   2535
      _ExtentX        =   4471
      _ExtentY        =   661
      _Version        =   393216
      Options         =   0
      CursorDriver    =   1
      BOFAction       =   0
      EOFAction       =   0
      RecordsetType   =   3
      LockType        =   4
      QueryType       =   0
      Prompt          =   2
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
      RecordSource    =   "SELECT * FROM VIEW_CODING2"
      UserName        =   "ABBAS"
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "MSRDC3"
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
   Begin MSDBCtls.DBCombo DBCombo2 
      Bindings        =   "macnz.frx":0A45
      DataField       =   "MN_APP_DOC"
      DataSource      =   "MSRDC1"
      Height          =   315
      Left            =   1920
      TabIndex        =   16
      Top             =   840
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   556
      _Version        =   393216
      BackColor       =   12632256
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
   End
   Begin VB.CommandButton Command2 
      BackColor       =   &H8000000C&
      Caption         =   "”Ã· ÃœÌœ"
      Height          =   615
      Left            =   120
      TabIndex        =   13
      Top             =   3480
      Width           =   855
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H008080FF&
      Caption         =   " ”ÃÌ·"
      Height          =   615
      Left            =   120
      MaskColor       =   &H000080FF&
      TabIndex        =   12
      Top             =   2760
      Width           =   855
   End
   Begin VB.TextBox Text6 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0C0C0&
      DataField       =   "MN_ADD"
      DataSource      =   "MSRDC1"
      Height          =   285
      Left            =   3360
      TabIndex        =   10
      Top             =   3840
      Width           =   5055
   End
   Begin VB.TextBox Text5 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0C0C0&
      DataField       =   "MN_ADD_TTL"
      DataSource      =   "MSRDC1"
      Height          =   285
      Left            =   3360
      TabIndex        =   9
      Top             =   3480
      Width           =   5055
   End
   Begin VB.TextBox Text4 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0C0C0&
      DataField       =   "MN_ACT"
      DataSource      =   "MSRDC1"
      Height          =   285
      Left            =   3360
      TabIndex        =   8
      Top             =   3000
      Width           =   5055
   End
   Begin VB.TextBox Text3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0C0C0&
      DataField       =   "MN_ACT_TTL"
      DataSource      =   "MSRDC1"
      Height          =   285
      Left            =   3360
      TabIndex        =   6
      Top             =   2640
      Width           =   5055
   End
   Begin MSDBCtls.DBCombo DBCombo1 
      Bindings        =   "macnz.frx":0A65
      DataField       =   "MN_DATA_EN"
      DataSource      =   "MSRDC1"
      Height          =   315
      Left            =   6600
      TabIndex        =   5
      Top             =   840
      Width           =   1575
      _ExtentX        =   2778
      _ExtentY        =   556
      _Version        =   393216
      BackColor       =   12632256
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
   End
   Begin MSRDC.MSRDC MSRDC2 
      Height          =   375
      Left            =   1920
      Top             =   6480
      Visible         =   0   'False
      Width           =   3495
      _ExtentX        =   6165
      _ExtentY        =   661
      _Version        =   393216
      Options         =   0
      CursorDriver    =   1
      BOFAction       =   0
      EOFAction       =   0
      RecordsetType   =   3
      LockType        =   4
      QueryType       =   0
      Prompt          =   2
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
      RecordSource    =   "select * from coding where ( sub_typ = '02')"
      UserName        =   "abbas"
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "MSRDC2"
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
   Begin MSRDC.MSRDC MSRDC1 
      Height          =   330
      Left            =   1680
      Top             =   6240
      Visible         =   0   'False
      Width           =   7170
      _ExtentX        =   12647
      _ExtentY        =   582
      _Version        =   393216
      Options         =   0
      CursorDriver    =   1
      BOFAction       =   0
      EOFAction       =   0
      RecordsetType   =   3
      LockType        =   4
      QueryType       =   0
      Prompt          =   2
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
      RecordSource    =   "select * from main"
      UserName        =   "abbas"
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "MSRDC1"
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
   Begin VB.TextBox Text2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0C0C0&
      DataField       =   "MN_ENT_DTE"
      DataSource      =   "MSRDC1"
      Height          =   285
      Left            =   1920
      TabIndex        =   3
      Top             =   480
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0C0C0&
      DataField       =   "MN_APP_NO"
      DataSource      =   "MSRDC1"
      Height          =   285
      Left            =   7200
      TabIndex        =   0
      Top             =   480
      Width           =   975
   End
   Begin MSRDC.MSRDC MSRDC4 
      Height          =   330
      Left            =   840
      Top             =   6240
      Visible         =   0   'False
      Width           =   7170
      _ExtentX        =   12647
      _ExtentY        =   582
      _Version        =   393216
      Options         =   0
      CursorDriver    =   1
      BOFAction       =   0
      EOFAction       =   0
      RecordsetType   =   3
      LockType        =   4
      QueryType       =   0
      Prompt          =   2
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
      RecordSource    =   "select * from main"
      UserName        =   "abbas"
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "MSRDC1"
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
   Begin VB.Shape Shape7 
      BorderColor     =   &H80000007&
      Height          =   4815
      Left            =   1200
      Top             =   360
      Width           =   8175
   End
   Begin VB.Shape Shape6 
      Height          =   5175
      Left            =   0
      Top             =   480
      Width           =   1095
   End
   Begin VB.Shape Shape5 
      Height          =   615
      Left            =   1680
      Top             =   4440
      Width           =   7695
   End
   Begin VB.Label Label13 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "‰Ê⁄ «·„ﬁ«·…"
      Height          =   255
      Left            =   8040
      TabIndex        =   28
      Top             =   4560
      Width           =   1215
   End
   Begin VB.Label Label12 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "—ﬁ„ «·„Ìﬂ—Ê›Ì·„"
      Height          =   255
      Left            =   3120
      TabIndex        =   27
      Top             =   4560
      Width           =   1215
   End
   Begin VB.Shape Shape4 
      Height          =   1815
      Left            =   1680
      Top             =   2520
      Width           =   7695
   End
   Begin VB.Label Label11 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "„’œ— «· —Ã„…"
      Height          =   255
      Left            =   8040
      TabIndex        =   25
      Top             =   1920
      Width           =   1215
   End
   Begin VB.Label Label10 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   " «—ÌŒ «· —Ã„…"
      Height          =   255
      Left            =   3480
      RightToLeft     =   -1  'True
      TabIndex        =   23
      Top             =   1920
      Width           =   1455
   End
   Begin VB.Label Label9 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   " «—ÌŒ «·„ﬁ«·…"
      Height          =   255
      Left            =   3480
      TabIndex        =   21
      Top             =   1560
      Width           =   1455
   End
   Begin VB.Label Label8 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "„’œ— «·„ﬁ«·…:"
      Height          =   255
      Left            =   8040
      TabIndex        =   18
      Top             =   1560
      Width           =   1215
   End
   Begin VB.Shape Shape3 
      Height          =   855
      Left            =   1680
      Top             =   1440
      Width           =   7695
   End
   Begin VB.Label Label7 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "«·„ÊÀﬁ"
      Height          =   255
      Left            =   3960
      TabIndex        =   15
      Top             =   840
      Width           =   1215
   End
   Begin VB.Label Label6 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "„œŒ· «·»Ì«‰« "
      Height          =   255
      Left            =   7920
      TabIndex        =   14
      Top             =   840
      Width           =   1335
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "«·⁄‰Ê«‰ «·À«‰ÊÌ"
      Height          =   615
      Left            =   8400
      TabIndex        =   11
      Top             =   3480
      Width           =   855
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "«·⁄‰Ê«‰ «·›⁄·Ì "
      Height          =   615
      Left            =   8400
      TabIndex        =   7
      Top             =   2640
      Width           =   855
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   " «—ÌŒ «·«œŒ«· "
      Height          =   255
      Left            =   3120
      TabIndex        =   4
      Top             =   480
      Width           =   1455
   End
   Begin VB.Shape Shape2 
      Height          =   855
      Left            =   1680
      Top             =   360
      Width           =   7695
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "«·—ﬁ„ :"
      Height          =   255
      Left            =   8160
      TabIndex        =   2
      Top             =   480
      Width           =   1215
   End
   Begin VB.Shape Shape1 
      Height          =   375
      Left            =   3360
      Top             =   0
      Width           =   2775
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C0C0&
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
      Left            =   3360
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
Dim RECNO_MAIN As Integer
Dim typ_serh As Integer



Private Sub Command1_Click()
 Dim cn As New rdoConnection
 Dim SQL As String

If typ_serh = 1 Then

   MSRDC1.Resultset.Update
  article1.Resultset.Update
  res1.Resultset.Update
ElseIf typ_serh = 2 Then
  MSRDC1.Resultset.Update
  
'            SQL = "execute upd_main " & "'" & Text4.Text & "'" & "," & "'" & Text1.Text & "'"
'             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
     '       cn.EstablishConnection rdDriverNoPrompt
'            cn.Execute SQL, rdExecDirect
'        MSRDC1.SQL = "select * from main"
'         MSRDC1.Refresh
'      MSRDC1.SQL = "exec SERCH_main " & "'" & M_MN_APP_NO & "'"
''      MSRDC1.Refresh

End If

End Sub

Private Sub Command2_Click()
MSRDC1.Resultset.AddNew

End Sub

Private Sub Command3_Click()
 MSRDC1.Resultset.Edit
 article1.Resultset.Edit
 res1.Resultset.Edit
End Sub

Private Sub Command4_Click()
If Not MSRDC1.Resultset.EOF Then
If typ_serh = 1 Then
 MSRDC1.Resultset.MoveNext
ElseIf typ_serh = 2 Then
 MSRDC1.SQL = "SELECT * FROM MAIN"
 MSRDC1.Refresh
 MSRDC1.Resultset.Bookmark = RECNO_MAIN
 MSRDC1.Resultset.MoveNext
 typ_serh = 1
 End If
 Else
  MsgBox "·« Ì„ﬂ‰ «· ﬁœ„ «·Ï «·«„«„ "
 End If
 
End Sub

Private Sub Command5_Click()
If Not (MSRDC1.Resultset.Bookmark = 1) Then
  If typ_serh = 1 Then
    MSRDC1.Resultset.MovePrevious
  ElseIf typ_serh = 2 Then
    MSRDC1.SQL = "SELECT * FROM MAIN"
    MSRDC1.Refresh
    MSRDC1.Resultset.Bookmark = RECNO_MAIN
    MSRDC1.Resultset.MovePrevious
    typ_serh = 1
  End If
 Else
  MsgBox "·« Ì„ﬂ‰ «·—ÃÊ⁄ «·Ï «·Ê—«¡ "
 End If
 
End Sub

Private Sub Command6_Click()
Dim cn As New rdoConnection
Dim SQL As String
Dim ok As String
Const None As String = ""
 ok = " "
 ok = InputBox("Â·  —Ìœ «·€«¡ «·„ﬁ«·…(‰/ﬂ)")
 If ok = "y" Then
    cn.Connect = "uid=;pwd=;server=SEQUEL;" _
    & "driver={SQL Server};database=macnz;" _
    & "DSN='';"
    
cn.CursorDriver = rdUseOdbc
cn.EstablishConnection rdDriverNoPrompt
SQL = "exec del_main " & Text1.Text
cn.Execute SQL, rdExecDirect
SQL = "exec del_article " & Text1.Text
cn.Execute SQL, rdExecDirect
SQL = "exec del_article " & Text1.Text
cn.Execute SQL, rdExecDirect

MSRDC1.Refresh
art.Refresh
res1.Refresh

  If Not MSRDC1.Resultset.EOF Then
      MSRDC1.Resultset.MoveNext
   Else
     MSRDC1.Resultset.MovePrevious
   End If
End If
End Sub

Private Sub Command7_Click()
Dim cn As New rdoConnection
Dim SQL As String
Dim M_MN_APP_NO As String
Const None As String = ""
M_MN_APP_NO = "       "
M_MN_APP_NO = InputBox("«œŒ· —ﬁ„ «·«” „«—… : ")
MSRDC1.SQL = "exec SERCH_main " & "'" & M_MN_APP_NO & "'"
MSRDC1.Refresh
typ_serh = 2
End Sub

'Private Sub DBCombo1_Change()
' Dim m_code As String
 
' MSRDC2.Resultset.Bookmark = DBCombo1.SelectedItem
' m_code = MSRDC2.Resultset![sub_code]
' MSRDC1.Resultset![mn_DATA_EN] = m_code
'' MSRDC1.Resultset.Update

'End Sub

Private Sub DBCombo2_CHANGE()

' Dim m_code As String
' MSRDC3.Resultset.Bookmark = DBCombo2.SelectedItem
'  m_code = MSRDC3.Resultset![sub_code]
' MSRDC1.Resultset![mn_APP_DOC] = m_code

End Sub

Private Sub DBCombo3_Change()
 'period.Resultset.Bookmark = DBCombo3.SelectedItem
 'article.Resultset![art_per_no] = period.Resultset![per_per_no]

End Sub

Private Sub DBCombo4_Change()
'period.Resultset.Bookmark = DBCombo4.SelectedItem
' article.Resultset![art_per1] = period.Resultset![per_per_no]
End Sub

Private Sub DBCombo5_Change()
'coding_typ.Resultset.Bookmark = DBCombo5.SelectedItem
'article.Resultset![art_typ] = coding_typ.Resultset![sub_code]

End Sub




Private Sub DBGrid1_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 Then
    DBList1.Visible = True
    DBList1.SetFocus
    
 End If
End Sub

Private Sub DBList1_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
    DBList1.Visible = False
    res1.Refresh
    res.Refresh
    DBGrid1.Refresh
    DBGrid1.SetFocus
  End If
  
End Sub


Private Sub Form_Load()
 RECNO_MAIN = MSRDC1.Resultset.Bookmark
 typ_serh = 1
 
End Sub

Private Sub Text1_Change()
 
res.SQL = "execute res_proc " & Text1.Text
article.SQL = "execute ARTICLE_MAIN " & Text1.Text
article.Refresh
res.Refresh
DBGrid1.Refresh
DBCombo2.Refresh
Text7.Refresh
Text8.Refresh
article1.Resultset.Bookmark = MSRDC1.Resultset.Bookmark
res1.Resultset.Bookmark = MSRDC1.Resultset.Bookmark
' MsgBox article.Resultset.Bookmark
'MsgBox article1.Resultset.Bookmark
 
'article1.Resultset.Bookmark = article.Resultset.Bookmark
'article1.Refresh
'DBCombo3.
End Sub
