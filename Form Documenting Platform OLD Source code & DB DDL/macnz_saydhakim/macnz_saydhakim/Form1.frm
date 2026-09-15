VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form Form1 
   BackColor       =   &H00FFC0FF&
   Caption         =   """"
   ClientHeight    =   8310
   ClientLeft      =   60
   ClientTop       =   540
   ClientWidth     =   11880
   LinkTopic       =   "Form1"
   Moveable        =   0   'False
   RightToLeft     =   -1  'True
   ScaleHeight     =   8310
   ScaleWidth      =   11880
   WindowState     =   2  'Maximized
   Begin VB.CommandButton Command11 
      Caption         =   "Œ—ÊÃ"
      Height          =   615
      Left            =   120
      RightToLeft     =   -1  'True
      TabIndex        =   37
      Top             =   6960
      Width           =   855
   End
   Begin VB.CommandButton Command10 
      BackColor       =   &H80000007&
      Caption         =   "»Õ‹‹À"
      Height          =   615
      Left            =   120
      TabIndex        =   36
      Top             =   2280
      Width           =   855
   End
   Begin VB.CommandButton Command7 
      Caption         =   "«·€‹‹«¡"
      Height          =   615
      Left            =   120
      TabIndex        =   35
      Top             =   3000
      Width           =   855
   End
   Begin VB.CommandButton Command6 
      Caption         =   "·«Õ‹‹ﬁ"
      Height          =   615
      Left            =   120
      TabIndex        =   34
      Top             =   4440
      Width           =   855
   End
   Begin VB.CommandButton Command5 
      Caption         =   "”«»ﬁ"
      Height          =   615
      Left            =   120
      TabIndex        =   33
      Top             =   3720
      Width           =   855
   End
   Begin VB.CommandButton Command4 
      BackColor       =   &H008080FF&
      Caption         =   " ”ÃÌ·"
      Height          =   615
      Left            =   120
      MaskColor       =   &H000080FF&
      TabIndex        =   32
      Top             =   1560
      Width           =   855
   End
   Begin VB.CommandButton Command8 
      Caption         =   "«·»ÕÀ »«·⁄‰Ê«‰"
      Height          =   615
      Left            =   120
      RightToLeft     =   -1  'True
      TabIndex        =   31
      Top             =   5160
      Width           =   855
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H8000000C&
      Caption         =   "”Ã· ÃœÌœ"
      Height          =   615
      Left            =   120
      TabIndex        =   30
      Top             =   840
      Width           =   855
   End
   Begin VB.CommandButton Command9 
      Caption         =   "«·’›Õ… «· «·Ì…"
      Height          =   735
      Left            =   120
      RightToLeft     =   -1  'True
      TabIndex        =   29
      Top             =   6000
      Width           =   855
   End
   Begin MSRDC.MSRDC auther1 
      Height          =   330
      Left            =   120
      Top             =   7800
      Visible         =   0   'False
      Width           =   2055
      _ExtentX        =   3625
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
      RecordSource    =   "select *from auther order by auther.aut_nam"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server = sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "AUTHER1"
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
   Begin MSDBCtls.DBList DBList3 
      Bindings        =   "Form1.frx":0000
      Height          =   2985
      Left            =   1080
      TabIndex        =   28
      Top             =   3720
      Visible         =   0   'False
      Width           =   4095
      _ExtentX        =   7223
      _ExtentY        =   5265
      _Version        =   393216
      BackColor       =   -2147483626
      ListField       =   "mn_act_ttl"
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox text1 
      BackColor       =   &H80000004&
      Height          =   285
      Left            =   9120
      RightToLeft     =   -1  'True
      TabIndex        =   27
      Top             =   840
      Width           =   1215
   End
   Begin VB.TextBox searcher 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   8280
      TabIndex        =   26
      Top             =   3600
      Visible         =   0   'False
      Width           =   1695
   End
   Begin VB.TextBox Text9 
      Alignment       =   1  'Right Justify
      BackColor       =   &H80000004&
      Height          =   285
      Left            =   2880
      TabIndex        =   13
      Top             =   7680
      Width           =   1215
   End
   Begin MSDBCtls.DBCombo DBCombo4 
      Bindings        =   "Form1.frx":000F
      Height          =   315
      Left            =   8040
      TabIndex        =   12
      Top             =   7800
      Width           =   2775
      _ExtentX        =   4895
      _ExtentY        =   556
      _Version        =   393216
      BackColor       =   -2147483644
      ListField       =   "AUT_NAM"
      BoundColumn     =   "AUT_NO"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSDBCtls.DBCombo DBCombo3 
      Bindings        =   "Form1.frx":0021
      Height          =   315
      Left            =   1560
      TabIndex        =   11
      Top             =   7320
      Width           =   2535
      _ExtentX        =   4471
      _ExtentY        =   556
      _Version        =   393216
      BackColor       =   -2147483644
      ListField       =   "SUB_NAME"
      BoundColumn     =   "SUB_NO"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox Text8 
      Alignment       =   2  'Center
      BackColor       =   &H80000004&
      Height          =   285
      Left            =   10200
      TabIndex        =   10
      Top             =   7320
      Width           =   615
   End
   Begin VB.TextBox Text7 
      Alignment       =   1  'Right Justify
      BackColor       =   &H80000004&
      Height          =   285
      Left            =   6240
      MaxLength       =   40
      RightToLeft     =   -1  'True
      TabIndex        =   9
      Top             =   6240
      Width           =   4215
   End
   Begin VB.TextBox Text6 
      Alignment       =   1  'Right Justify
      BackColor       =   &H80000004&
      Height          =   285
      Left            =   5520
      MaxLength       =   50
      RightToLeft     =   -1  'True
      TabIndex        =   8
      Top             =   5520
      Width           =   5055
   End
   Begin VB.TextBox Text5 
      Alignment       =   1  'Right Justify
      BackColor       =   &H80000004&
      Height          =   285
      Left            =   4320
      MaxLength       =   75
      RightToLeft     =   -1  'True
      TabIndex        =   7
      Top             =   5160
      Width           =   6255
   End
   Begin VB.TextBox Text4 
      Alignment       =   1  'Right Justify
      BackColor       =   &H80000004&
      Height          =   285
      Left            =   5520
      MaxLength       =   50
      RightToLeft     =   -1  'True
      TabIndex        =   6
      Top             =   4560
      Width           =   5055
   End
   Begin VB.TextBox Text3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H80000004&
      Height          =   285
      Left            =   4320
      MaxLength       =   75
      RightToLeft     =   -1  'True
      TabIndex        =   5
      Top             =   4200
      Width           =   6255
   End
   Begin VB.TextBox Text2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H80000004&
      Height          =   285
      Left            =   8880
      RightToLeft     =   -1  'True
      TabIndex        =   2
      Top             =   1200
      Width           =   1455
   End
   Begin MSRDC.MSRDC coding5 
      Height          =   375
      Left            =   4800
      Top             =   8520
      Visible         =   0   'False
      Width           =   1815
      _ExtentX        =   3201
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
      RecordSource    =   "select *from view_coding5"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "coding5"
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
   Begin MSDBCtls.DBList DBList2 
      Bindings        =   "Form1.frx":0031
      DataField       =   "RES_APP_TY"
      DataSource      =   "res1"
      Height          =   2010
      Left            =   6840
      TabIndex        =   0
      Top             =   1560
      Visible         =   0   'False
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   3545
      _Version        =   393216
      BackColor       =   -2147483644
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      RightToLeft     =   -1  'True
   End
   Begin MSRDC.MSRDC book1 
      Height          =   330
      Left            =   2520
      Top             =   8280
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
      RecordSource    =   "select * from book"
      UserName        =   "ABBAS"
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "book1"
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
   Begin MSRDC.MSRDC res1 
      Height          =   330
      Left            =   0
      Top             =   8280
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
      RecordSource    =   "select * from res"
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
   Begin MSRDC.MSRDC main 
      Height          =   330
      Left            =   1080
      Top             =   8280
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
      RecordSource    =   ""
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "main"
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
      Bindings        =   "Form1.frx":0043
      DataField       =   "RES_RES_NO"
      DataSource      =   "res1"
      Height          =   2010
      Left            =   8880
      TabIndex        =   14
      Top             =   1560
      Visible         =   0   'False
      Width           =   2655
      _ExtentX        =   4683
      _ExtentY        =   3545
      _Version        =   393216
      BackColor       =   -2147483644
      ListField       =   "AUT_NAM"
      BoundColumn     =   "AUT_NO"
      RightToLeft     =   -1  'True
   End
   Begin MSRDC.MSRDC AUTHER 
      Height          =   330
      Left            =   6360
      Top             =   8280
      Visible         =   0   'False
      Width           =   1560
      _ExtentX        =   2752
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
      RecordSource    =   "SELECT * FROM AUTHER ORDER BY AUTHER.AUT_NAM "
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
   Begin MSRDC.MSRDC res 
      Height          =   375
      Left            =   240
      Top             =   8160
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
      RecordSource    =   "select  * from auther order by auther.aut_nam"
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
      Left            =   4560
      Top             =   8280
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
   Begin MSRDC.MSRDC FORM1 
      Height          =   495
      Left            =   1800
      Top             =   8160
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
      RecordSource    =   "select * from pays_form  ORDER BY sub_name"
      UserName        =   "abbas"
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server = sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "FORM1"
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
   Begin MSRDC.MSRDC v_coding3 
      Height          =   375
      Left            =   3360
      Top             =   8280
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
      Caption         =   "v_coding3"
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
      Bindings        =   "Form1.frx":0054
      Height          =   315
      Left            =   1560
      TabIndex        =   1
      Top             =   840
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   556
      _Version        =   393216
      BackColor       =   -2147483648
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSDBCtls.DBCombo DBCombo1 
      Bindings        =   "Form1.frx":0077
      Height          =   315
      Left            =   1560
      TabIndex        =   3
      Top             =   1320
      Width           =   2295
      _ExtentX        =   4048
      _ExtentY        =   556
      _Version        =   393216
      BackColor       =   -2147483644
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSRDC.MSRDC MSRDC2 
      Height          =   375
      Left            =   5400
      Top             =   8280
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
      RecordSource    =   "select * from view_coding3"
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
   Begin MSRDC.MSRDC main1 
      Height          =   330
      Left            =   4200
      Top             =   8400
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
      Caption         =   "main1"
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
      Bindings        =   "Form1.frx":0093
      Height          =   1575
      Left            =   1560
      OleObjectBlob   =   "Form1.frx":00A1
      TabIndex        =   4
      Top             =   1920
      Width           =   10335
   End
   Begin VB.Shape Shape6 
      Height          =   7095
      Left            =   0
      Top             =   600
      Width           =   1095
   End
   Begin VB.Label Label11 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0FF&
      Caption         =   " «—ÌŒ «·‰‘— "
      Height          =   255
      Left            =   4320
      TabIndex        =   25
      Top             =   7680
      Width           =   855
   End
   Begin VB.Label Label10 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0FF&
      Caption         =   "œ«— «·‰‘—"
      Height          =   255
      Left            =   10800
      TabIndex        =   24
      Top             =   7800
      Width           =   855
   End
   Begin VB.Label Label9 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0FF&
      Caption         =   "„ﬂ«‰ «·‰‘—"
      Height          =   255
      Left            =   4080
      TabIndex        =   23
      Top             =   7320
      Width           =   975
   End
   Begin VB.Label Label8 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0FF&
      Caption         =   "«·ÿ»⁄… "
      Height          =   255
      Left            =   10800
      TabIndex        =   22
      Top             =   7320
      Width           =   855
   End
   Begin VB.Shape Shape1 
      BackColor       =   &H80000002&
      Height          =   975
      Left            =   1200
      Top             =   7200
      Width           =   10575
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0FF&
      Caption         =   "«·⁄‰Ê«‰ «·«÷«›Ì"
      Height          =   495
      Left            =   10440
      TabIndex        =   21
      Top             =   6120
      Width           =   855
   End
   Begin VB.Shape Shape4 
      Height          =   3135
      Left            =   1200
      Top             =   3840
      Width           =   10575
   End
   Begin VB.Label Label7 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0FF&
      Caption         =   "«·„ÊÀﬁ"
      Height          =   255
      Left            =   3600
      TabIndex        =   20
      Top             =   840
      Width           =   1215
   End
   Begin VB.Label Label6 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0FF&
      Caption         =   "„œŒ· «·»Ì«‰« "
      Height          =   255
      Left            =   3720
      TabIndex        =   19
      Top             =   1320
      Width           =   1215
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0FF&
      Caption         =   "«·⁄‰Ê«‰ «·„Ê«“Ì"
      Height          =   615
      Left            =   10560
      TabIndex        =   18
      Top             =   5160
      Width           =   855
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0FF&
      Caption         =   "«·⁄‰Ê«‰ «·›⁄·Ì "
      Height          =   615
      Left            =   10560
      TabIndex        =   17
      Top             =   4200
      Width           =   855
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0FF&
      Caption         =   " «—ÌŒ «·«œŒ«· "
      Height          =   255
      Left            =   10320
      TabIndex        =   16
      Top             =   1200
      Width           =   1335
   End
   Begin VB.Shape Shape2 
      BackColor       =   &H80000004&
      Height          =   1095
      Left            =   1440
      Top             =   600
      Width           =   10335
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0FF&
      Caption         =   "«·—ﬁ„ :"
      Height          =   255
      Left            =   10320
      TabIndex        =   15
      Top             =   840
      Width           =   1215
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim typ_serh As Variant
Dim mod_typ As Variant
Dim typ_prog As Variant


Private Sub book_close_Click()
 Unload FORM1

End Sub

Private Sub book_del_Click()


End Sub


Private Sub book_next_Click()
End Sub

Private Sub book_nextpage_Click()
End Sub

Private Sub book_previous_Click()


End Sub

Private Sub book_save_Click()
End Sub

 
 
Private Sub book_serch_Click()
End Sub

Private Sub book_serch1_Click()
End Sub


Private Sub Command1_Click()
 mod_typ = 1
Text1.Text = ""
Text2.Text = Date
DBCombo1.Text = ""
DBCombo2.Text = ""
DBCombo3.Text = ""
DBCombo4.Text = ""
Text3.Text = ""
Text4.Text = ""
Text5.Text = ""
Text6.Text = ""
Text7.Text = ""
Text8.Text = ""
Text9.Text = ""
Text1.SetFocus
m_text = "qqqq"
 res.SQL = "execute res_proc " & m_text
 res.Refresh


End Sub

Private Sub Command10_Click()
Dim cn As New rdoConnection
Dim SQL As String
Dim M_MN_APP_NO As String
Const None As String = ""
M_MN_APP_NO = ""
M_MN_APP_NO = InputBox("«œŒ· —ﬁ„ «·«” „«—… : ")
M_MN_APP_NO = M_MN_APP_NO
book1.SQL = "exec SERCH_BOOK " & "'" & M_MN_APP_NO & "'"
book1.Refresh
typ_serh = 2
If Not book1.Resultset.EOF Or Not book1.Resultset.BOF Then
 Text1.Text = M_MN_APP_NO
 If Not IsNull(book1.Resultset![bk_edtn]) Then
    Text8.Text = book1.Resultset![bk_edtn]
   Else
    Text8.Text = 0
   End If
   If Not IsNull(book1.Resultset![bk_pub_dte]) Then
     Text9.Text = book1.Resultset![bk_pub_dte]
   Else
     Text9.Text = ""
    End If
      If Not IsNull(book1.Resultset![bk_adt_ttl]) Then
     Text7.Text = book1.Resultset![bk_adt_ttl]
   Else
     Text7.Text = ""
    End If
    DBCombo4.BoundText = book1.Resultset![bk_pblshr]
    DBCombo3.BoundText = book1.Resultset![bk_pub_loc]
'*****************
main.SQL = "execute serch_main " & Text1.Text
main.Refresh
If Not main.Resultset.EOF Or Not main.Resultset.BOF Then
 
 
  If Not IsNull(main.Resultset![MN_ENT_DTE]) Then
    Text2.Text = main.Resultset![MN_ENT_DTE]
   Else
     Text2.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_ACT_TTL]) Then
      Text3.Text = main.Resultset![MN_ACT_TTL]
   Else
      Text3.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_ACT]) Then
     Text4.Text = main.Resultset![MN_ACT]
   Else
     Text4.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_Add_ttl]) Then
      Text5.Text = main.Resultset![MN_Add_ttl]
   Else
     Text5.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_Add]) Then
     Text6.Text = main.Resultset![MN_Add]
    Else
      Text6.Text = ""
     End If
     DBCombo2.BoundText = "01" + main.Resultset![MN_APP_DOC]
     DBCombo1.BoundText = "02" + main.Resultset![MN_DATA_EN]
    res.SQL = "execute res_proc " & Text1.Text
    res.Refresh
    
Else
 Text3.Text = ""
 Text4.Text = ""
 Text5.Text = ""
 Text6.Text = ""
  DBCombo1.Text = ""
  DBCombo2.Text = ""
End If
 
Else
 MsgBox "·« ÌÊÃœ «” „«—… ·Â–« «·—ﬁ„ !!!!"
End If


End Sub

Private Sub Command11_Click()
Unload FORM1
End Sub

Private Sub Command2_Click()
    Dim cn As New rdoConnection
    Dim SQL As String
  If mod_typ = 1 Then
   m_bk_ser = 0
   SQL = "execute insr_book " & "'" & Text1.Text & "'" & "," & "'" & Text8.Text & "'" & "," _
   & "'" & DBCombo4.BoundText & "'" & "," & "'" & DBCombo3.BoundText & "'" & "," _
    & "'" & Format(Text9.Text, "yyyy/mm/dd") & "'" & "," & "'" & Text7.Text & "'" _
    & "," & "'" & m_bk_ser & "'"
        
       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute SQL, rdExecDirect
 
 SQL = "execute insr_main " & "'" & Text1.Text & "'" & "," & "'" & Text4.Text & "'" & "," _
      & "'" & Text3.Text & "'" & "," & "'" & Text6.Text & "'" & "," _
      & "'" & Text5.Text & "'" & "," & "'" & Mid(DBCombo1.BoundText, 3, 2) & "'" & "," _
       & "'" & Mid(DBCombo2.BoundText, 3, 2) & "'" & "," & "'" & Format(Text2.Text, "yyyy/mm/dd") & "'"
  cn.Execute SQL, rdExecDirect
      mod_typ = 2
      main1.Refresh
  
Else
 m_bk_ser = 0
 'm_date = Text2.Text
            SQL = "execute upd_main " & "'" & Text1.Text & "'" & "," & "'" & Text4.Text & "'" & "," _
      & "'" & Text3.Text & "'" & "," & "'" & Text6.Text & "'" & "," _
       & "'" & Text5.Text & "'" & "," & "'" & Mid(DBCombo1.BoundText, 3, 2) & "'" & "," _
       & "'" & Mid(DBCombo2.BoundText, 3, 2) & "'" & "," & "'" & Format(Text2.Text, "mm/dd/yy") & "'"
       
       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute SQL, rdExecDirect
   ' MsgBox DBCombo5.BoundText
 SQL = "execute upd_BOOK " & "'" & Text1.Text & "'" & "," & "'" & Text8.Text & "'" & "," _
        & "'" & DBCombo4.BoundText & "'" & "," & "'" & DBCombo3.BoundText & "'" & "," _
         & "'" & Format(Text9.Text, "yyyy/mm/dd") & "'" & "," & "'" & Text7.Text & "'"
        '     & "," & "'" & m_bk_ser & "'"
         
        cn.Execute SQL, rdExecDirect
End If
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form7.WindowState = 2
 Form7.Show
 Screen.MousePointer = vbDefault
 Form7.Refresh
  frame1.Visible = False
 Command2.Visible = False
 Command3.Visible = False
 
 
End Sub

Private Sub Command3_Click()
Text9.SetFocus
frame1.Visible = False
 Command2.Visible = False
 Command3.Visible = False
 
End Sub

Private Sub Command4_Click()
 Dim cn As New rdoConnection
 Dim SQL As String
 Dim m_bk_ser As Variant
 
 'Dim m_date As Date
'SRDC1.Resultset.
If mod_typ = 1 Then
 m_bk_ser = 0
   SQL = "execute insr_book " & "'" & Text1.Text & "'" & "," & "'" & Text8.Text & "'" & "," _
   & "'" & DBCombo4.BoundText & "'" & "," & "'" & DBCombo3.BoundText & "'" & "," _
    & "'" & Format(Text9.Text, "yyyy/mm/dd") & "'" & "," & "'" & Text7.Text & "'" _
    & "," & "'" & m_bk_ser & "'"
 
       
       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute SQL, rdExecDirect
 
 SQL = "execute insr_main " & "'" & Text1.Text & "'" & "," & "'" & Text4.Text & "'" & "," _
      & "'" & Text3.Text & "'" & "," & "'" & Text6.Text & "'" & "," _
      & "'" & Text5.Text & "'" & "," & "'" & Mid(DBCombo1.BoundText, 3, 2) & "'" & "," _
       & "'" & Mid(DBCombo2.BoundText, 3, 2) & "'" & "," & "'" & Format(Text2.Text, "yyyy/mm/dd") & "'"
  cn.Execute SQL, rdExecDirect
      mod_typ = 2
      main1.Refresh
  
Else
 'm_date = Text2.Text
            SQL = "execute upd_main " & "'" & Text1.Text & "'" & "," & "'" & Text4.Text & "'" & "," _
      & "'" & Text3.Text & "'" & "," & "'" & Text6.Text & "'" & "," _
       & "'" & Text5.Text & "'" & "," & "'" & Mid(DBCombo1.BoundText, 3, 2) & "'" & "," _
       & "'" & Mid(DBCombo2.BoundText, 3, 2) & "'" & "," & "'" & Format(Text2.Text, "yyyy/mm/dd") & "'"
       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute SQL, rdExecDirect
   ' MsgBox DBCombo5.BoundText
 SQL = "execute upd_BOOK " & "'" & Text1.Text & "'" & "," & "'" & Text8.Text & "'" & "," _
        & "'" & DBCombo4.BoundText & "'" & "," & "'" & DBCombo3.BoundText & "'" & "," _
         & "'" & Format(Text9.Text, "yyyy/mm/dd") & "'" & "," & "'" & Text7.Text & "'"
        cn.Execute SQL, rdExecDirect
End If

End Sub

Private Sub Command5_Click()
If typ_serh = 2 Then
 book1.SQL = "select *from book"
 book1.Refresh
 typ_serh = 1
End If
If Not book1.Resultset.BOF Then
book1.Resultset.MovePrevious
End If
If Not book1.Resultset.BOF Then
  Text1.Text = book1.Resultset![bk_app_no]
If Not IsNull(book1.Resultset![bk_edtn]) Then
    Text8.Text = book1.Resultset![bk_edtn]
   Else
    Text8.Text = 0
   End If
   If Not IsNull(book1.Resultset![bk_pub_dte]) Then
     Text9.Text = book1.Resultset![bk_pub_dte]
   Else
     Text9.Text = ""
    End If
      If Not IsNull(book1.Resultset![bk_adt_ttl]) Then
     Text7.Text = book1.Resultset![bk_adt_ttl]
   Else
     Text7.Text = ""
    End If
    DBCombo4.BoundText = book1.Resultset![bk_pblshr]
    DBCombo3.BoundText = book1.Resultset![bk_pub_loc]
'*****************
main.SQL = "execute serch_main " & Text1.Text
main.Refresh
If Not main.Resultset.EOF Or Not main.Resultset.BOF Then
  If Not IsNull(main.Resultset![MN_ENT_DTE]) Then
    Text2.Text = main.Resultset![MN_ENT_DTE]
   Else
     Text2.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_ACT_TTL]) Then
      Text3.Text = main.Resultset![MN_ACT_TTL]
   Else
      Text3.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_ACT]) Then
     Text4.Text = main.Resultset![MN_ACT]
   Else
     Text4.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_Add_ttl]) Then
      Text5.Text = main.Resultset![MN_Add_ttl]
   Else
     Text5.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_Add]) Then
     Text6.Text = main.Resultset![MN_Add]
    Else
      Text6.Text = ""
     End If
     DBCombo2.BoundText = "01" + main.Resultset![MN_APP_DOC]
     DBCombo1.BoundText = "02" + main.Resultset![MN_DATA_EN]
    res.SQL = "execute res_proc " & Text1.Text
    res.Refresh
 Else
 Text3.Text = ""
 Text4.Text = ""
 Text5.Text = ""
 Text6.Text = ""
  DBCombo1.Text = ""
  DBCombo2.Text = ""
End If
Else
 MsgBox "·« ÌÊÃœ «” „«—… ”«»ﬁ…"
End If

End Sub

Private Sub Command6_Click()
If typ_serh = 2 Then
 book1.SQL = "select *from book"
 book1.Refresh
 typ_serh = 1
End If
If Not book1.Resultset.EOF Then
   book1.Resultset.MoveNext
End If
If Not book1.Resultset.EOF Then
Text1.Text = book1.Resultset![bk_app_no]
If Not IsNull(book1.Resultset![bk_edtn]) Then
    Text8.Text = book1.Resultset![bk_edtn]
   Else
    Text8.Text = 0
   End If
   If Not IsNull(book1.Resultset![bk_pub_dte]) Then
     Text9.Text = book1.Resultset![bk_pub_dte]
   Else
     Text9.Text = "  /  /  "
    End If
      If Not IsNull(book1.Resultset![bk_adt_ttl]) Then
     Text7.Text = book1.Resultset![bk_adt_ttl]
   Else
     Text7.Text = ""
    End If
     If Not IsNull(book1.Resultset![bk_pblshr]) Then
       DBCombo4.BoundText = book1.Resultset![bk_pblshr]
     Else
       DBCombo4.BoundText = 0
      End If
   If Not IsNull(book1.Resultset![bk_pub_loc]) Then
    DBCombo3.BoundText = book1.Resultset![bk_pub_loc]
   Else
    DBCombo3.BoundText = ""
  End If
'*****************
main.SQL = "execute serch_main " & Text1.Text
main.Refresh
If Not main.Resultset.EOF Or Not main.Resultset.BOF Then
  If Not IsNull(main.Resultset![MN_ENT_DTE]) Then
    Text2.Text = main.Resultset![MN_ENT_DTE]
   Else
     Text2.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_ACT_TTL]) Then
      Text3.Text = main.Resultset![MN_ACT_TTL]
   Else
      Text3.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_ACT]) Then
     Text4.Text = main.Resultset![MN_ACT]
   Else
     Text4.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_Add_ttl]) Then
      Text5.Text = main.Resultset![MN_Add_ttl]
   Else
     Text5.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_Add]) Then
     Text6.Text = main.Resultset![MN_Add]
    Else
      Text6.Text = ""
     End If
     DBCombo2.BoundText = "01" + main.Resultset![MN_APP_DOC]
     DBCombo1.BoundText = "02" + main.Resultset![MN_DATA_EN]
    res.SQL = "execute res_proc " & Text1.Text
    res.Refresh
 Else
 Text3.Text = ""
 Text4.Text = ""
 Text5.Text = ""
 Text6.Text = ""
  DBCombo1.Text = ""
  DBCombo2.Text = ""
End If
Else
 MsgBox "·«ÌÊÃœ «” „«—… ·«Õﬁ… !!!"
End If


End Sub

Private Sub Command7_Click()
Dim cn As New rdoConnection
Dim SQL As String
Dim ok As String
Const None As String = ""
 ok = " "
 ok = InputBox("Â·  —Ìœ «·€«¡ «·ﬂ «»(‰/ﬂ)")
 If ok = "y" Or ok = "‰" Then
    cn.Connect = "uid=;pwd=;server=SEQUEL;" _
    & "driver={SQL Server};database=macnz;" _
    & "DSN='';"
    
cn.CursorDriver = rdUseOdbc
cn.EstablishConnection rdDriverNoPrompt
SQL = "exec del_book " & Text1.Text
cn.Execute SQL, rdExecDirect
SQL = "exec del_main " & Text1.Text
cn.Execute SQL, rdExecDirect
SQL = "exec del_res " & Text1.Text
cn.Execute SQL, rdExecDirect

SQL = "exec del_analis2 " & Text1.Text
cn.Execute SQL, rdExecDirect
SQL = "exec del_geo2 " & Text1.Text
cn.Execute SQL, rdExecDirect
SQL = "exec del_nar2 " & Text1.Text
cn.Execute SQL, rdExecDirect
SQL = "exec del_rel2 " & Text1.Text
cn.Execute SQL, rdExecDirect
SQL = "exec del_fad2 " & Text1.Text
cn.Execute SQL, rdExecDirect
 
 
book1.Refresh
main1.Refresh
res1.Refresh

  If Not book1.Resultset.EOF Then
    book1.Resultset.MoveNext
   ElseIf Not book1.Resultset.BOF Then
     book1.Resultset.MovePrevious
   End If
End If

End Sub

Private Sub Command8_Click()
Dim cn As New rdoConnection
Dim SQL As String
Dim m_desc As String
Const None As String = ""
m_desc = ""
m_typ_ist = "ﬂ"
m_typ_ist1 = "Ê"
m_desc = InputBox("«œŒ· «·⁄‰Ê«‰ «·›⁄·Ì : ")
If Not IsNull(m_desc) And Not Trim(m_desc) = "" Then
  m_len = Len(m_desc)
  main.SQL = "exec SERH_main " & "'" & m_desc & "'" & "," & "'" & m_len & "'" & _
                           "," & "'" & m_typ_ist & "'" & "," & "'" & m_typ_ist1 & "'"
                          
  main.Refresh
  typ_serh = 2
If Not book1.Resultset.EOF Or Not book1.Resultset.BOF Then
     dblist3.Visible = True
     dblist3.SetFocus
     SendKeys "{up}"
Else
 MsgBox "·« ÌÊÃœ «” „«—… ·Â–« «·—ﬁ„ !!!!"
End If
End If

End Sub

Private Sub Command9_Click()
Dim is_save As String
Dim m_bk_ser As Variant

 If mod_typ = 2 Then
   is_save = "'"
   is_save = InputBox("Â·  —Ìœ  ”ÃÌ· «·„⁄·Ê„«  ‰/ﬂ)")
  Else
   is_save = "y"
  End If
 If is_save = "y" Or is_save = "‰" Then
    Dim cn As New rdoConnection
    Dim SQL As String
  If mod_typ = 1 Then
   m_bk_ser = 0
   SQL = "execute insr_book " & "'" & Text1.Text & "'" & "," & "'" & Text8.Text & "'" & "," _
   & "'" & DBCombo4.BoundText & "'" & "," & "'" & DBCombo3.BoundText & "'" & "," _
    & "'" & Format(Text9.Text, "yyyy/mm/dd") & "'" & "," & "'" & Text7.Text & "'" _
    & "," & "'" & m_bk_ser & "'"
        
       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute SQL, rdExecDirect
 
 SQL = "execute insr_main " & "'" & Text1.Text & "'" & "," & "'" & Text4.Text & "'" & "," _
      & "'" & Text3.Text & "'" & "," & "'" & Text6.Text & "'" & "," _
      & "'" & Text5.Text & "'" & "," & "'" & Mid(DBCombo1.BoundText, 3, 2) & "'" & "," _
       & "'" & Mid(DBCombo2.BoundText, 3, 2) & "'" & "," & "'" & Format(Text2.Text, "yyyy/mm/dd") & "'"
  cn.Execute SQL, rdExecDirect
      mod_typ = 2
      main1.Refresh
  
Else
 m_bk_ser = 0
 'm_date = Text2.Text
            SQL = "execute upd_main " & "'" & Text1.Text & "'" & "," & "'" & Text4.Text & "'" & "," _
      & "'" & Text3.Text & "'" & "," & "'" & Text6.Text & "'" & "," _
       & "'" & Text5.Text & "'" & "," & "'" & Mid(DBCombo1.BoundText, 3, 2) & "'" & "," _
       & "'" & Mid(DBCombo2.BoundText, 3, 2) & "'" & "," & "'" & Format(Text2.Text, "mm/dd/yy") & "'"
       
       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute SQL, rdExecDirect
   ' MsgBox DBCombo5.BoundText
 SQL = "execute upd_BOOK " & "'" & Text1.Text & "'" & "," & "'" & Text8.Text & "'" & "," _
        & "'" & DBCombo4.BoundText & "'" & "," & "'" & DBCombo3.BoundText & "'" & "," _
         & "'" & Format(Text9.Text, "yyyy/mm/dd") & "'" & "," & "'" & Text7.Text & "'"
        '     & "," & "'" & m_bk_ser & "'"
         
        cn.Execute SQL, rdExecDirect
End If
End If
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form7.WindowState = 2
 Form7.Show
 Screen.MousePointer = vbDefault
 Form7.Refresh
 


End Sub

Private Sub DBCombo1_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 Then
   DBGrid1.SetFocus
 End If
End Sub

Private Sub DBCombo2_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 Then
   Text2.SetFocus
 End If
End Sub

Private Sub DBGrid1_KeyPress(KeyAscii As Integer)
' MsgBox KeyAscii
 Dim cn As New rdoConnection
 Dim SQL As String
 If KeyAscii = 32 Then
   If DBGrid1.Col = 1 Then
       DBList2.Visible = True
       DBList2.SetFocus
    Else
      DBList1.Visible = True
      DBList1.SetFocus
    End If
    
ElseIf KeyAscii = 27 Then
    Text3.SetFocus
 End If
End Sub

Private Sub DBGrid1_KeyUp(KeyCode As Integer, Shift As Integer)
 Dim cn As New rdoConnection
 Dim SQL As String
 
 If KeyCode = vbKeyDelete Then
      m_auther = DBGrid1.Columns(2)
     SQL = "execute del_res1 " & "'" & Text1.Text & "'" & "," & "'" & m_auther & "'"
           cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute SQL, rdExecDirect
      
    'DBList1.Visible = False
    'res1.Refresh
    res1.Refresh
    res.Refresh
    DBGrid1.Refresh
'    DBGrid1.SetFocus
ElseIf KeyCode = vbKeyInsert Then
   m_res_typ = "01"
   m_res_no = 0
  
  SQL = "execute insr_res " & "'" & Text1.Text & "'" & "," & "'" & m_res_typ & "'" & "," _
      & "'" & m_res_no & "'"
         
       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
              cn.Execute SQL, rdExecDirect
    res.Refresh
    DBGrid1.Refresh

End If
End Sub

Private Sub DBList1_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF10 Then
      Label1.Visible = True
      searcher.Visible = True
      searcher.SetFocus
      SendKeys "{up}"
    End If
End Sub

Private Sub DBList1_KeyPress(KeyAscii As Integer)
 Dim cn As New rdoConnection
 Dim SQL As String

  If KeyAscii = 13 Then
   If Not auther.Resultset.BOF Or Not auther.Resultset.EOF Then
      m_auther = DBList1.BoundText
      M_aut1 = DBGrid1.Columns(2)
      m_res_typ = DBGrid1.Columns(6)
     SQL = "execute upd_res " & "'" & Text1.Text & "'" & "," & "'" & m_auther & "'" _
       & "," & "'" & M_aut1 & "'" & "," & "'" & m_res_typ & "'"
       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute SQL, rdExecDirect
      
      DBList1.Visible = False
       res.Refresh
       DBGrid1.Refresh
       DBGrid1.SetFocus
     Else
       MsgBox "«‰ »‹Â «··«∆Õ… ›«—€…......."
     End If
    ElseIf KeyAscii = 27 Then
      DBList1.Visible = False
      DBGrid1.SetFocus
        
  End If

End Sub

Private Sub DBList2_KeyPress(KeyAscii As Integer)
 Dim cn As New rdoConnection
 Dim SQL As String
  If KeyAscii = 13 Then
    m_typ_auther = Mid(DBList2.BoundText, 3, 2)
    M_aut1 = DBGrid1.Columns(2)
  '  MsgBox m_typ_auther & m_typ_aut1
     SQL = "execute upd_res1 " & "'" & Text1.Text & "'" & "," & "'" & m_typ_auther & "'" _
       & "," & "'" & M_aut1 & "'"
       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute SQL, rdExecDirect
      
    DBList2.Visible = False
    'res1.Refresh
    res.Refresh
    DBGrid1.Refresh
    DBGrid1.SetFocus
    ElseIf KeyAscii = 27 Then
      DBList2.Visible = False
      DBGrid1.SetFocus
  End If
End Sub

Private Sub DBList3_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
   main.Resultset.Bookmark = dblist3.SelectedItem
   Text1.Text = main.Resultset![mn_app_no]
   book1.SQL = "exec SERCH_BOOK " & "'" & Text1.Text & "'"
   book1.Refresh
 
 If Not IsNull(book1.Resultset![bk_edtn]) Then
    Text8.Text = book1.Resultset![bk_edtn]
   Else
    Text8.Text = 0
   End If
   If Not IsNull(book1.Resultset![bk_pub_dte]) Then
     Text9.Text = book1.Resultset![bk_pub_dte]
   Else
     Text9.Text = ""
    End If
      If Not IsNull(book1.Resultset![bk_adt_ttl]) Then
     Text7.Text = book1.Resultset![bk_adt_ttl]
   Else
     Text7.Text = ""
    End If
    DBCombo4.BoundText = book1.Resultset![bk_pblshr]
    DBCombo3.BoundText = book1.Resultset![bk_pub_loc]
'*****************
main.SQL = "execute serch_main " & Text1.Text
main.Refresh
If Not main.Resultset.EOF Or Not main.Resultset.BOF Then
 
 
  If Not IsNull(main.Resultset![MN_ENT_DTE]) Then
    Text2.Text = main.Resultset![MN_ENT_DTE]
   Else
     Text2.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_ACT_TTL]) Then
      Text3.Text = main.Resultset![MN_ACT_TTL]
   Else
      Text3.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_ACT]) Then
     Text4.Text = main.Resultset![MN_ACT]
   Else
     Text4.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_Add_ttl]) Then
      Text5.Text = main.Resultset![MN_Add_ttl]
   Else
     Text5.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_Add]) Then
     Text6.Text = main.Resultset![MN_Add]
    Else
      Text6.Text = ""
     End If
     DBCombo2.BoundText = "01" + main.Resultset![MN_APP_DOC]
     DBCombo1.BoundText = "02" + main.Resultset![MN_DATA_EN]
    res.SQL = "execute res_proc " & Text1.Text
    res.Refresh
   dblist3.Visible = False
Else
 Text3.Text = ""
 Text4.Text = ""
 Text5.Text = ""
 Text6.Text = ""
  DBCombo1.Text = ""
  DBCombo2.Text = ""
End If
 

ElseIf KeyAscii = 27 Then
   dblist3.Visible = False
End If
End Sub

Private Sub Form_Load()
 mod_typ = 2
 typ_serh = 1
 typ_prog = "book"
If Not book1.Resultset.EOF Or Not book1.Resultset.BOF Then
  Text1.Text = book1.Resultset![bk_app_no]
  If Not IsNull(book1.Resultset![bk_edtn]) Then
    Text8.Text = book1.Resultset![bk_edtn]
   Else
    Text8.Text = 0
   End If
   If Not IsNull(book1.Resultset![bk_pub_dte]) Then
     Text9.Text = book1.Resultset![bk_pub_dte]
   Else
     Text9.Text = ""
    End If
     If Not IsNull(book1.Resultset![bk_adt_ttl]) Then
     Text7.Text = book1.Resultset![bk_adt_ttl]
   Else
     Text7.Text = ""
    End If
    DBCombo4.BoundText = book1.Resultset![bk_pblshr]
    DBCombo3.BoundText = book1.Resultset![bk_pub_loc]
'*****************
main.SQL = "execute main_BOOK " & Text1.Text
main.Refresh
If Not main.Resultset.EOF Or Not main.Resultset.BOF Then
  If Not IsNull(main.Resultset![MN_ENT_DTE]) Then
    Text2.Text = main.Resultset![MN_ENT_DTE]
   Else
     Text2.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_ACT_TTL]) Then
      Text3.Text = main.Resultset![MN_ACT_TTL]
   Else
      Text3.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_ACT]) Then
     Text4.Text = main.Resultset![MN_ACT]
   Else
     Text4.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_Add_ttl]) Then
      Text5.Text = main.Resultset![MN_Add_ttl]
   Else
     Text5.Text = ""
   End If
   If Not IsNull(main.Resultset![MN_Add]) Then
     Text6.Text = main.Resultset![MN_Add]
    Else
      Text6.Text = ""
     End If
     DBCombo2.BoundText = "01" + main.Resultset![MN_APP_DOC]
     DBCombo1.BoundText = "02" + main.Resultset![MN_DATA_EN]
    res.SQL = "execute res_proc " & Text1.Text
    res.Refresh
    
Else
 Text3.Text = ""
 Text4.Text = ""
 Text5.Text = ""
 Text6.Text = ""
  DBCombo1.Text = ""
  DBCombo2.Text = ""
End If
End If
End Sub

Private Sub searcher_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 Then
       searcher.Visible = False
       Label1.Visible = False
       m_desc = searcher.Text
       m_len = Len(Trim(m_desc))
       auther.SQL = "execute serh_auther " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
       auther.Refresh
       DBList1.Refresh
       DBList1.SetFocus
       SendKeys "{up}"
    ElseIf kayascii = 27 Then
       searcher.Visible = False
         Label1.Visible = False
       DBList1.SetFocus
       SendKeys "{up}"
    End If

End Sub

Private Sub Text1_Change()
 If Not IsNull(Text1.Text) And Not Text1.Text = "" And Not IsEmpty(Text1.Text) Then
   res.SQL = "execute res_proc " & Text1.Text
   res.Refresh
  End If

End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
   If mod_typ = 1 Then
       Text1.Text = Text1.Text
       book1.SQL = "exec SERCH_BOOK " & "'" & Text1.Text & "'"
       book1.Refresh
       Text1.Refresh
       typ_serh = 2
      If Not book1.Resultset.EOF Or Not book1.Resultset.BOF Then
        MsgBox "Â–« «·—ﬁ„  «»⁄ ·«” „«—… «Œ—Ï!!!!!"
      Else
       DBCombo2.SetFocus
        SendKeys "^{f4}"
      End If
    Else
      DBCombo2.SetFocus
        SendKeys "^{f4}"
    End If
  End If

  
End Sub

Private Sub Text10_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 DBCombo2.SetFocus
 End If
End Sub

Private Sub Text2_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  DBCombo1.SetFocus
    SendKeys "^{f4}"
End If
End Sub

Private Sub Text3_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Text4.SetFocus
End If
End Sub
Private Sub Text4_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Text5.SetFocus
End If
End Sub
Private Sub Text5_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Text6.SetFocus
End If
End Sub
Private Sub Text6_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Text7.SetFocus
End If
End Sub
Private Sub Text7_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Text8.SetFocus
End If
End Sub

Private Sub Text8_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  DBCombo3.SetFocus
  SendKeys "^{f4}"
End If
End Sub

 Private Sub DBCOMBO3_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
   
  DBCombo4.SetFocus
  SendKeys "^{f4}"
End If
End Sub
Private Sub DBCOMBO4_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Text9.SetFocus
End If
End Sub




Private Sub Text9_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 Dim cn As New rdoConnection
    Dim SQL As String
 If mod_typ = 1 Then
   m_bk_ser = 0
   SQL = "execute insr_book " & "'" & Text1.Text & "'" & "," & "'" & Text8.Text & "'" & "," _
   & "'" & DBCombo4.BoundText & "'" & "," & "'" & DBCombo3.BoundText & "'" & "," _
    & "'" & Format(Text9.Text, "yyyy/mm/dd") & "'" & "," & "'" & Text7.Text & "'" _
    & "," & "'" & m_bk_ser & "'"
 
       
       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute SQL, rdExecDirect
 
  SQL = "execute insr_main " & "'" & Text1.Text & "'" & "," & "'" & Text4.Text & "'" & "," _
      & "'" & Text3.Text & "'" & "," & "'" & Text6.Text & "'" & "," _
      & "'" & Text5.Text & "'" & "," & "'" & Mid(DBCombo1.BoundText, 3, 2) & "'" & "," _
       & "'" & Mid(DBCombo2.BoundText, 3, 2) & "'" & "," & "'" & Format(Text2.Text, "yyyy/mm/dd") & "'"
      cn.Execute SQL, rdExecDirect
      mod_typ = 2
      main1.Refresh
       Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form7.WindowState = 2
 Form7.Show
 Screen.MousePointer = vbDefault
 Form7.Refresh
 
 End If
 End If
End Sub
