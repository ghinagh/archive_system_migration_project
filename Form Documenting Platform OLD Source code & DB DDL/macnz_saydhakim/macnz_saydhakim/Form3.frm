VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Begin VB.Form Form3 
   BackColor       =   &H00808080&
   Caption         =   "."
   ClientHeight    =   8490
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11880
   LinkTopic       =   "Form3"
   Moveable        =   0   'False
   ScaleHeight     =   8490
   ScaleWidth      =   11880
   Begin VB.CommandButton Command6 
      Caption         =   "Œ—ÊÃ"
      Height          =   495
      Left            =   3840
      TabIndex        =   38
      Top             =   7080
      Width           =   735
   End
   Begin VB.TextBox Text6 
      Alignment       =   2  'Center
      BackColor       =   &H00FF0000&
      ForeColor       =   &H0000FFFF&
      Height          =   285
      Left            =   6960
      TabIndex        =   37
      Top             =   4080
      Visible         =   0   'False
      Width           =   1335
   End
   Begin MSRDC.MSRDC word 
      Height          =   330
      Left            =   2160
      Top             =   8040
      Visible         =   0   'False
      Width           =   2655
      _ExtentX        =   4683
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
      RecordSource    =   "select * from word"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "word"
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
   Begin VB.TextBox fin_dte 
      Height          =   285
      Left            =   120
      TabIndex        =   34
      Top             =   600
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.TextBox deb_dte 
      Height          =   285
      Left            =   120
      TabIndex        =   33
      Top             =   120
      Visible         =   0   'False
      Width           =   1095
   End
   Begin MSRDC.MSRDC tmp_msdrc 
      Height          =   330
      Left            =   1440
      Top             =   8160
      Visible         =   0   'False
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   582
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
      RecordSource    =   ""
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   ""
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
   Begin MSRDC.MSRDC frm_mcnz 
      Height          =   330
      Left            =   4680
      Top             =   8280
      Visible         =   0   'False
      Width           =   2535
      _ExtentX        =   4471
      _ExtentY        =   582
      _Version        =   393216
      Options         =   0
      CursorDriver    =   1
      BOFAction       =   0
      EOFAction       =   0
      RecordsetType   =   3
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
      RecordSource    =   ""
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "frm_mcnz"
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
   Begin VB.TextBox Text5 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
      Height          =   285
      Left            =   9360
      TabIndex        =   31
      Top             =   4680
      Visible         =   0   'False
      Width           =   2175
   End
   Begin MSDBCtls.DBList DBList8 
      Bindings        =   "Form3.frx":0000
      Height          =   2595
      Left            =   5760
      TabIndex        =   30
      ToolTipText     =   "F8 ··»ÕÀ ›Ì «·»œ«Ì…  , F9 ··»ÕÀ ⁄‰ ﬂ·„… , ENTER ··«Œ Ì«— , ESC ··—ÃÊ⁄"
      Top             =   1560
      Visible         =   0   'False
      Width           =   3495
      _ExtentX        =   6165
      _ExtentY        =   4577
      _Version        =   393216
      BackColor       =   8421376
      ForeColor       =   65535
      RightToLeft     =   -1  'True
   End
   Begin MSRDC.MSRDC subject 
      Height          =   495
      Left            =   240
      Top             =   8040
      Visible         =   0   'False
      Width           =   2175
      _ExtentX        =   3836
      _ExtentY        =   873
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
      Caption         =   "subject"
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
   Begin VB.TextBox m_rel 
      BackColor       =   &H00C0C0C0&
      Height          =   375
      Left            =   5400
      TabIndex        =   29
      Top             =   4200
      Visible         =   0   'False
      Width           =   495
   End
   Begin MSRDC.MSRDC rel_form 
      Height          =   330
      Left            =   5040
      Top             =   8160
      Visible         =   0   'False
      Width           =   2295
      _ExtentX        =   4048
      _ExtentY        =   582
      _Version        =   393216
      Options         =   0
      CursorDriver    =   1
      BOFAction       =   0
      EOFAction       =   0
      RecordsetType   =   3
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
      RecordSource    =   ""
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "rel_form"
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
   Begin MSDBCtls.DBList DBList7 
      Bindings        =   "Form3.frx":0017
      Height          =   1815
      Left            =   6600
      TabIndex        =   26
      ToolTipText     =   "ENTER ·«œŒ«· «·„⁄·Ê„«  , ESC ··—ÃÊ⁄ ..."
      Top             =   4920
      Visible         =   0   'False
      Width           =   2775
      _ExtentX        =   4895
      _ExtentY        =   3201
      _Version        =   393216
      BackColor       =   12632256
      ListField       =   "m_sub_desc"
      RightToLeft     =   -1  'True
   End
   Begin MSDBCtls.DBList DBList6 
      Bindings        =   "Form3.frx":002D
      Height          =   1815
      Left            =   3720
      TabIndex        =   25
      ToolTipText     =   "ENTER ·«œŒ«· «·„⁄·Ê„«  , ESC ··—ÃÊ⁄ ..."
      Top             =   5040
      Visible         =   0   'False
      Width           =   2655
      _ExtentX        =   4683
      _ExtentY        =   3201
      _Version        =   393216
      BackColor       =   12632256
      ListField       =   "m_name"
      RightToLeft     =   -1  'True
   End
   Begin VB.CommandButton Command5 
      Caption         =   "»ÕÀ"
      Height          =   495
      Left            =   4680
      TabIndex        =   24
      Top             =   7080
      Width           =   975
   End
   Begin MSRDC.MSRDC pos 
      Height          =   330
      Left            =   120
      Top             =   8160
      Visible         =   0   'False
      Width           =   1455
      _ExtentX        =   2566
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
      RecordSource    =   "select * from position"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "pos"
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
   Begin VB.TextBox Text4 
      BackColor       =   &H00FF0000&
      ForeColor       =   &H0000FFFF&
      Height          =   375
      Left            =   840
      TabIndex        =   23
      Top             =   4800
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.TextBox Text1 
      Alignment       =   2  'Center
      BackColor       =   &H00FF0000&
      ForeColor       =   &H0000FFFF&
      Height          =   375
      Left            =   10080
      TabIndex        =   12
      Top             =   3240
      Width           =   975
   End
   Begin VB.TextBox Text2 
      BackColor       =   &H00FF0000&
      ForeColor       =   &H0000FFFF&
      Height          =   405
      Left            =   7320
      TabIndex        =   9
      Top             =   3000
      Width           =   975
   End
   Begin VB.TextBox code 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   6360
      TabIndex        =   8
      Top             =   4560
      Visible         =   0   'False
      Width           =   1335
   End
   Begin VB.TextBox desc 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   3720
      MaxLength       =   80
      TabIndex        =   10
      Top             =   4920
      Visible         =   0   'False
      Width           =   3975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "«÷«›… (INSERT)"
      Height          =   495
      Left            =   9000
      TabIndex        =   7
      Top             =   7080
      Width           =   855
   End
   Begin VB.CommandButton Command2 
      Caption         =   " ⁄œÌ·     (F2)"
      Height          =   495
      Left            =   7920
      TabIndex        =   6
      Top             =   7080
      Width           =   975
   End
   Begin VB.CommandButton Command3 
      Caption         =   " ”ÃÌ·  "
      Height          =   495
      Left            =   6840
      TabIndex        =   5
      Top             =   7080
      Width           =   975
   End
   Begin VB.CommandButton Command4 
      Caption         =   "«·€«¡  (DELETE)"
      Height          =   495
      Left            =   5760
      TabIndex        =   4
      Top             =   7080
      Width           =   975
   End
   Begin VB.TextBox Text3 
      BackColor       =   &H00FF0000&
      ForeColor       =   &H0000FFFF&
      Height          =   375
      Left            =   4800
      TabIndex        =   0
      Top             =   2400
      Visible         =   0   'False
      Width           =   1215
   End
   Begin MSRDC.MSRDC f_form 
      Height          =   375
      Left            =   4200
      Top             =   8160
      Visible         =   0   'False
      Width           =   1560
      _ExtentX        =   2752
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
      RecordSource    =   "select * from form"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "form"
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
   Begin MSRDC.MSRDC coding 
      Height          =   330
      Left            =   2280
      Top             =   8280
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
      RecordSource    =   "select * from coding"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "coding"
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
   Begin MSRDC.MSRDC position 
      Height          =   375
      Left            =   4680
      Top             =   8160
      Visible         =   0   'False
      Width           =   1935
      _ExtentX        =   3413
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
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "position"
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
   Begin MSDBCtls.DBList DBList5 
      Bindings        =   "Form3.frx":0044
      Height          =   2010
      Left            =   120
      TabIndex        =   1
      ToolTipText     =   "ENTER OR DBLCLIK ··œŒÊ· «·Ï «·⁄·«ﬁ«  , ESC  ··—ÃÊ⁄..."
      Top             =   5760
      Visible         =   0   'False
      Width           =   3255
      _ExtentX        =   5741
      _ExtentY        =   3545
      _Version        =   393216
      BackColor       =   12632256
      ListField       =   "pos_nam"
      RightToLeft     =   -1  'True
   End
   Begin MSRDC.MSRDC name_form 
      Height          =   330
      Left            =   1800
      Top             =   7920
      Visible         =   0   'False
      Width           =   2535
      _ExtentX        =   4471
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
      Caption         =   "name_form"
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
   Begin MSDBCtls.DBList DBList4 
      Bindings        =   "Form3.frx":005B
      Height          =   2985
      Left            =   0
      TabIndex        =   2
      ToolTipText     =   "F8 ··»ÕÀ ›Ì «·»œ«Ì…  , F9 ··»ÕÀ ⁄‰ ﬂ·„… , ENTER  OR DBLCLICK  ··«Œ Ì«— , ESC ··—ÃÊ⁄ , ENETR ··œŒÊ· «·Ï «·„‰«’».."
      Top             =   1800
      Visible         =   0   'False
      Width           =   4095
      _ExtentX        =   7223
      _ExtentY        =   5265
      _Version        =   393216
      BackColor       =   12632256
      ListField       =   "sub_name"
      RightToLeft     =   -1  'True
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
   Begin MSRDC.MSRDC pays 
      Height          =   375
      Left            =   240
      Top             =   8280
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
      RecordSource    =   "select * from pay_form"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "pays"
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
      Bindings        =   "Form3.frx":0073
      Height          =   2010
      Left            =   4200
      TabIndex        =   3
      ToolTipText     =   "F8 ··»ÕÀ ›Ì «·»œ«Ì…  , ENTER  OR DBLCLICK ··œŒÊ· «·Ï «·«”„«¡ , ESC ··—ÃÊ⁄"
      Top             =   360
      Visible         =   0   'False
      Width           =   2175
      _ExtentX        =   3836
      _ExtentY        =   3545
      _Version        =   393216
      BackColor       =   12632256
      ListField       =   "SUB_NAME"
      RightToLeft     =   -1  'True
   End
   Begin MSRDC.MSRDC cod3 
      Height          =   375
      Left            =   120
      Top             =   7920
      Visible         =   0   'False
      Width           =   2055
      _ExtentX        =   3625
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
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "cod3"
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
   Begin MSRDC.MSRDC cod1 
      Height          =   330
      Left            =   3240
      Top             =   8280
      Visible         =   0   'False
      Width           =   2655
      _ExtentX        =   4683
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
      Caption         =   "cod1"
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
   Begin MSRDC.MSRDC cod2 
      Height          =   375
      Left            =   0
      Top             =   8280
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
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "cod2"
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
      Bindings        =   "Form3.frx":0086
      Height          =   2205
      Left            =   6600
      TabIndex        =   11
      ToolTipText     =   "ENTER OR DBLCLICK ··œŒÊ· «·Ï «·œÊ·  ,  ESC ··—ÃÊ⁄"
      Top             =   840
      Width           =   2295
      _ExtentX        =   4048
      _ExtentY        =   3889
      _Version        =   393216
      Enabled         =   0   'False
      BackColor       =   12632256
      ForeColor       =   0
      ListField       =   "sub_desc"
      BoundColumn     =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSDBCtls.DBList DBList1 
      Bindings        =   "Form3.frx":0099
      Height          =   2790
      Left            =   9240
      TabIndex        =   13
      ToolTipText     =   "ENTER OR DBLCLICK ··œŒÊ· «·Ï «·„” ÊÏ «·À«‰Ì , "
      Top             =   480
      Width           =   2415
      _ExtentX        =   4260
      _ExtentY        =   4921
      _Version        =   393216
      BackColor       =   12632256
      ForeColor       =   0
      ListField       =   "SUB_DESC"
      RightToLeft     =   -1  'True
   End
   Begin VB.Shape Shape1 
      Height          =   1095
      Left            =   0
      Top             =   0
      Visible         =   0   'False
      Width           =   2295
   End
   Begin VB.Label Label14 
      Caption         =   " «—ÌŒ «·‰Â«Ì…"
      Height          =   375
      Left            =   1200
      TabIndex        =   36
      Top             =   600
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.Label Label13 
      Caption         =   " «—ÌŒ «·»œ«Ì…"
      Height          =   375
      Left            =   1200
      TabIndex        =   35
      Top             =   120
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.Label Label12 
      Alignment       =   2  'Center
      BackColor       =   &H8000000C&
      Caption         =   "«·»ÕÀ"
      Height          =   255
      Left            =   10920
      TabIndex        =   32
      Top             =   4440
      Visible         =   0   'False
      Width           =   615
      WordWrap        =   -1  'True
   End
   Begin VB.Label Label11 
      Alignment       =   2  'Center
      BackColor       =   &H8000000C&
      Caption         =   "«·—»ÿ «·„Ê÷Ê⁄Ì"
      Height          =   375
      Left            =   6720
      TabIndex        =   28
      Top             =   4560
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.Label Label10 
      Alignment       =   2  'Center
      BackColor       =   &H8000000C&
      Caption         =   "«·—»ÿ «·‘ﬂ«Ì"
      Height          =   375
      Left            =   3960
      TabIndex        =   27
      Top             =   4560
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.Line Line10 
      Visible         =   0   'False
      X1              =   5520
      X2              =   7200
      Y1              =   4440
      Y2              =   4920
   End
   Begin VB.Line Line9 
      Visible         =   0   'False
      X1              =   5520
      X2              =   5520
      Y1              =   4560
      Y2              =   5160
   End
   Begin VB.Line Line8 
      Visible         =   0   'False
      X1              =   3360
      X2              =   5520
      Y1              =   6360
      Y2              =   4440
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H8000000C&
      Caption         =   "«·„” ÊÏ «·«Ê·   "
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   9720
      TabIndex        =   22
      Top             =   240
      Width           =   1575
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H8000000C&
      Caption         =   "»—‰«„Ã «·‘ﬂ·Ì« "
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   6480
      TabIndex        =   21
      Top             =   0
      Width           =   1935
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BackColor       =   &H8000000C&
      Caption         =   "«·„” ÊÏ «·À«‰Ì"
      Height          =   255
      Left            =   6960
      TabIndex        =   20
      Top             =   600
      Width           =   1215
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000007&
      X1              =   8760
      X2              =   8760
      Y1              =   960
      Y2              =   600
   End
   Begin VB.Line Line2 
      BorderColor     =   &H80000007&
      X1              =   9240
      X2              =   8760
      Y1              =   600
      Y2              =   600
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H8000000C&
      Caption         =   "«·—„“"
      Height          =   255
      Left            =   7560
      RightToLeft     =   -1  'True
      TabIndex        =   19
      Top             =   4560
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      BackColor       =   &H8000000C&
      Caption         =   "«·‘—Õ"
      Height          =   255
      Left            =   7560
      RightToLeft     =   -1  'True
      TabIndex        =   18
      Top             =   4920
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Shape Shape3 
      Height          =   1095
      Left            =   3600
      Top             =   4320
      Visible         =   0   'False
      Width           =   5295
   End
   Begin VB.Label Label6 
      Alignment       =   2  'Center
      BackColor       =   &H8000000C&
      Caption         =   "„⁄«·Ã« "
      Height          =   255
      Left            =   5760
      RightToLeft     =   -1  'True
      TabIndex        =   17
      Top             =   4200
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.Shape Shape4 
      BackColor       =   &H000000FF&
      Height          =   735
      Left            =   3720
      Top             =   6960
      Width           =   6255
   End
   Begin VB.Line Line3 
      BorderColor     =   &H80000006&
      Visible         =   0   'False
      X1              =   6600
      X2              =   6240
      Y1              =   2040
      Y2              =   1320
   End
   Begin VB.Line Line4 
      Visible         =   0   'False
      X1              =   4560
      X2              =   3120
      Y1              =   960
      Y2              =   960
   End
   Begin VB.Line Line5 
      Visible         =   0   'False
      X1              =   3120
      X2              =   3120
      Y1              =   960
      Y2              =   1800
   End
   Begin VB.Label Label7 
      Alignment       =   2  'Center
      BackColor       =   &H8000000C&
      Caption         =   "«·œÊ·"
      Height          =   255
      Left            =   4920
      TabIndex        =   16
      Top             =   120
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.Label Label8 
      Alignment       =   2  'Center
      BackColor       =   &H8000000C&
      Caption         =   "«·«”„«¡"
      Height          =   255
      Left            =   1200
      TabIndex        =   15
      Top             =   1560
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.Line Line6 
      Visible         =   0   'False
      X1              =   2400
      X2              =   3000
      Y1              =   3120
      Y2              =   3120
   End
   Begin VB.Line Line7 
      Visible         =   0   'False
      X1              =   1680
      X2              =   1680
      Y1              =   5760
      Y2              =   4800
   End
   Begin VB.Label Label9 
      Alignment       =   2  'Center
      BackColor       =   &H8000000C&
      Caption         =   "«·„‰«’»"
      Height          =   255
      Left            =   1200
      TabIndex        =   14
      Top             =   5520
      Visible         =   0   'False
      Width           =   735
   End
End
Attribute VB_Name = "Form3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim mod_typ As Variant
Dim v_typ As Variant
Dim v_sub_no As Variant
Dim typ_serh As Integer
Dim typ_list As Integer
Dim coding_typ As Integer
Dim m_serh As Integer
Public Function div_word(sw_code As Variant, sw_desc As Variant, m_typ As Variant)
 Dim b, fin_rep   As Boolean
 Dim i, l1 As Integer
 Dim sw_des As String
' Dim cn As New rdoConnection
 Dim SQL As String
 find_rep = True
 sw_des = ""
 sw_desc = Trim(sw_desc)
 L = Len(sw_desc)
 m_nb = "0123456789"
 i = 1
'   cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'          & "driver={SQL Server};database=macnz;" _
''           & "DSN='';"
 '           cn.CursorDriver = rdUseOdbc
 '           cn.EstablishConnection rdDriverNoPrompt

 While i < L
     sw_des = ""
     While Mid(sw_desc, i, 1) <> " " And i < L + 1
       sw_des = sw_des + Mid(sw_desc, i, 1)
       i = i + 1
     Wend
    l1 = Len(sw_des)
    While Mid(sw_desc, i, 1) = " " And i < L + 1
     i = i + 1
    Wend
    b = True
   If l1 > 1 Then
        While b
           If Mid(sw_des, 1, 2) = "«·" Then
              sw_des = Mid(sw_des, 3, Len(sw_des) - 2)
           ElseIf Mid(sw_des, 1, 2) = "··" Then
              sw_des = Mid(sw_des, 3, Len(sw_des) - 2)
           ElseIf Mid(sw_des, 1, 2) = "Ê«·" Then
              sw_des = Mid(sw_des, 4, Len(sw_des) - 3)
           ElseIf Mid(sw_des, 1, 1) = "√" Then
            sw_des = "«" + Mid(sw_des, 2, Len(sw_des) - 1)
           Else
            b = False
           End If
       Wend
    End If
    nb = InStr(1, m_nb, Mid(sw_des, 1, 1))
  If Len(sw_des) > 2 And nb = 0 Then
     SQL = "exec insr_word " & "'" & sw_des & "'" & "," & "'" & sw_code & "'" _
             & "," & "'" & m_typ & "'"
           
            cn.Execute SQL, rdExecDirect
  End If
 Wend
 word.Refresh
 
End Function


Private Sub Command5_Click()
If typ_serh = 1 Then

 Label3.Visible = True
 Label5.Visible = True
 Label6.Visible = True
 desc.Visible = True
 Shape3.Visible = True
 desc.SetFocus
 typ_serh = 2
ElseIf typ_serh = 2 Then
 If DBList3.Enabled = True Then
  m_desc = desc.Text
  m_len = Len(Trim(m_desc))
  pays.SQL = "execute serh_form " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
  pays.Refresh
  DBList3.Refresh
ElseIf DBList4.Enabled = True Then
  name_form.Resultset.Bookmark = DBList4.SelectedItem
  v_typ = name_form.Resultset![sub_typ]
  v_cod = Mid(name_form.Resultset![sub_no], 1, 3)
  m_desc = desc.Text
  m_len = Len(Trim(m_desc))
  name_form.SQL = "execute serh1_form " & "'" & v_typ & "'" & "," & "'" & v_cod & "'" & "," & _
  "'" & m_desc & "'" & "," & "'" & m_len & "'"
  name_form.Refresh
  DBList4.Refresh

End If
       typ_serh = 1
        Label3.Visible = False
       Label5.Visible = False
       Label6.Visible = False
        code.Visible = False
        desc.Visible = False
        Shape3.Visible = False

End If
End Sub

Private Sub Command6_Click()
 Unload Form3
End Sub

Private Sub DBList1_GotFocus()
  SendKeys "{up}"
End Sub

Private Sub DBList1_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyF2 Then
   Command2.SetFocus
    SendKeys "{enter}"
 
 End If
End Sub

Private Sub DBList1_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyInsert Then
 Command1.SetFocus
 SendKeys "{enter}"
 ElseIf KeyCode = vbKeyDelete Then
   Command4.SetFocus
   SendKeys "{enter}"
 End If
End Sub

Private Sub DBList2_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyF2 Then
  Command2.SetFocus
   SendKeys "{enter}"
 
  
 End If
End Sub

Private Sub DBList2_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyInsert Then
 Command1.SetFocus
 SendKeys "{enter}"
 ElseIf KeyCode = vbKeyDelete Then
   Command4.SetFocus
   SendKeys "{enter}"
 End If

End Sub

Private Sub DBList3_Click()
   If Not pays.Resultset.EOF And Not pays.Resultset.BOF Then
      pays.Resultset.Bookmark = DBList3.SelectedItem
      Text3.Text = pays.Resultset![sub_typ] & pays.Resultset![sub_no]
  End If
End Sub

Private Sub DBList3_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF8 Then
 Label3.Visible = True
 Label5.Visible = True
 Label6.Visible = True
 desc.Visible = True
 Shape3.Visible = True
 desc.SetFocus
 desc.Text = ""
  typ_serh = 2
  SendKeys "{up}"
ElseIf KeyCode = vbKeyF2 Then
  Command2.SetFocus
   SendKeys "{enter}"
End If
End Sub

Private Sub DBList3_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyInsert Then
 Command1.SetFocus
 SendKeys "{enter}"
 ElseIf KeyCode = vbKeyDelete Then
   Command4.SetFocus
   SendKeys "{enter}"
 End If
End Sub

Private Sub DBList4_Click()
 If Not name_form.Resultset.EOF And Not name_form.Resultset.BOF Then
  name_form.Resultset.Bookmark = DBList4.SelectedItem
  Text4.Text = name_form.Resultset![sub_typ] & name_form.Resultset![sub_no]
 End If
 
End Sub

Private Sub DBList4_KeyDown(KeyCode As Integer, Shift As Integer)
 desc.Text = ""
If KeyCode = vbKeyF9 Then
 Label3.Visible = True
 Label5.Visible = True
 Label6.Visible = True
 desc.Visible = True
 Shape3.Visible = True
 desc.SetFocus
  typ_serh = 3
  SendKeys "{up}"
ElseIf KeyCode = vbKeyF8 Then
 Label3.Visible = True
 Label5.Visible = True
 Label6.Visible = True
 desc.Visible = True
 Shape3.Visible = True
 desc.SetFocus
  typ_serh = 2
  SendKeys "{up}"
ElseIf KeyCode = vbKeyF2 Then
  Command2.SetFocus
   SendKeys "{enter}"
  
End If

End Sub

Private Sub DBList4_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyInsert Then
 Command1.SetFocus
 SendKeys "{enter}"
 ElseIf KeyCode = vbKeyDelete Then
   Command4.SetFocus
   SendKeys "{enter}"
 End If
End Sub

Private Sub DBList5_DblClick()
        DBList6.Visible = True
        Line8.Visible = True
        Line9.Visible = True
        Line10.Visible = True
        m_rel.Visible = True
        Label10.Visible = True
        Label11.Visible = True
        DBList7.Visible = True
           
'        position.Resultset.Bookmark = DBList5.SelectedItem
'        m_code = position.Resultset![pos_no]
        
        name_form.Resultset.Bookmark = DBList4.SelectedItem
        m_code = name_form.Resultset![sub_typ] & name_form.Resultset![sub_no]
        m_rel = "01"
        DBList5.Enabled = False
        rel_form.SQL = "execute rel_form_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        rel_form.Refresh
        subject.SQL = "execute subject_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        subject.Refresh
        DBList6.SetFocus
         typ_list = 1
         SendKeys "{up}"
End Sub

Private Sub DBList5_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF2 Then
  Command2.SetFocus
   SendKeys "{enter}"
  
 End If
End Sub

Private Sub DBList5_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyInsert Then
 Command1.SetFocus
 SendKeys "{enter}"
 ElseIf KeyCode = vbKeyDelete Then
   Command4.SetFocus
   SendKeys "{enter}"
 End If
End Sub

Private Sub DBList6_Click()
  typ_list = 1
End Sub

Private Sub DBList6_DblClick()
      frm_mcnz.SQL = " select * from pay_form"
      frm_mcnz.Refresh
      DBList8.Visible = True
      DBList8.ListField = "sub_name"
      DBList8.Refresh
      DBList8.SetFocus
      Text6.Visible = True
      typ_list = 1
     SendKeys "{up}"
End Sub

Private Sub DBList6_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyF2 Then
   mod_typ = 2
    rel_form.Resultset.Bookmark = DBList6.SelectedItem
    If Not IsNull(rel_form.Resultset![rlf_dte]) Then
     deb_dte.Text = rel_form.Resultset![rlf_dte]
     Else
      deb_dte.Text = ""
     End If
  If Not IsNull(rel_form.Resultset![rlf_dte1]) Then
     fin_dte.Text = rel_form.Resultset![rlf_dte1]
  Else
      fin_dte.Text = ""
  End If
   Label13.Visible = True
   Label14.Visible = True
   deb_dte.Visible = True
   fin_dte.Visible = True
   Shape1.Visible = True
   deb_dte.SetFocus
   
 End If
End Sub

Private Sub DBList6_KeyPress(KeyAscii As Integer)
  Select Case KeyAscii
    Case 27
        DBList6.Visible = False
        Line8.Visible = False
        Line9.Visible = False
        Line10.Visible = False
        m_rel.Visible = False
        Label10.Visible = False
        Label11.Visible = False
        DBList7.Visible = False
      If DBList5.Visible = True Then
          DBList5.Enabled = True
           DBList5.SetFocus
      Else
         Line6.Visible = False
         Line7.Visible = False
         DBList5.Visible = False
         DBList4.Enabled = True
         DBList4.SetFocus
         Label9.Visible = False
      End If
    Case 13
      frm_mcnz.SQL = " select * from pay_form"
      frm_mcnz.Refresh
      DBList8.Visible = True
      DBList8.ListField = "sub_name"
      DBList8.Refresh
      DBList8.SetFocus
      typ_list = 1
      Text6.Visible = True
      SendKeys "{up}"
      
  End Select
End Sub

Private Sub DBList6_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDelete Then
   Command4.SetFocus
   SendKeys "{enter}"
 End If
End Sub

Private Sub DBList7_Click()
   typ_list = 2
End Sub

Private Sub DBList7_DblClick()
     frm_mcnz.SQL = " select * from macnz"
      frm_mcnz.Refresh
      DBList8.Visible = True
      DBList8.ListField = "sub_desc"
      DBList8.Refresh
      DBList8.SetFocus
      Text4.Visible = True
      typ_list = 2

End Sub

Private Sub DBList7_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF2 Then
   typ_list = 2
   mod_typ = 2
    subject.Resultset.Bookmark = DBList7.SelectedItem
    If Not IsNull(subject.Resultset![sub_dte]) Then
      deb_dte.Text = subject.Resultset![sub_dte]
     Else
     deb_dte.Text = ""
     End If
  If Not IsNull(subject.Resultset![sub_dte1]) Then
     fin_dte.Text = subject.Resultset![sub_dte1]
  Else
      fin_dte.Text = ""
  End If
   Label13.Visible = True
   Label14.Visible = True
   deb_dte.Visible = True
   fin_dte.Visible = True
   Shape1.Visible = True
   deb_dte.SetFocus
   
 End If

End Sub

Private Sub DBList7_KeyPress(KeyAscii As Integer)
  Select Case KeyAscii
    Case 27
        DBList6.Visible = False
        Line8.Visible = False
        Line9.Visible = False
        Line10.Visible = False
        m_rel.Visible = False
        Label10.Visible = False
        Label11.Visible = False
        DBList7.Visible = False
      If DBList5.Visible = True Then
          DBList5.Enabled = True
           DBList5.SetFocus
      Else
         Line6.Visible = False
         Line7.Visible = False
         DBList5.Visible = False
         DBList4.Enabled = True
         DBList4.SetFocus
         Label9.Visible = False
      End If

    Case 13
     frm_mcnz.SQL = " select * from macnz"
      frm_mcnz.Refresh
      DBList8.Visible = True
      DBList8.ListField = "sub_desc"
      DBList8.Refresh
      DBList8.SetFocus
      typ_list = 2
       Text6.Visible = True
     SendKeys "{up}"
  End Select
End Sub

Private Sub DBList7_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDelete Then
   Command4.SetFocus
   SendKeys "{enter}"
 End If
End Sub

Private Sub DBList8_Click()
 If typ_list = 1 Then
   frm_mcnz.Resultset.Bookmark = DBList8.SelectedItem
  Text6.Text = frm_mcnz.Resultset![sub_typ] + frm_mcnz.Resultset![sub_no]
 Else
    frm_mcnz.Resultset.Bookmark = DBList8.SelectedItem
   Text6.Text = frm_mcnz.Resultset![sub_code]
 End If
End Sub

Private Sub DBList8_DblClick()
'Dim cn As New rdoConnection
 Dim SQL As String
       If typ_list = 1 Then
        If Not rel_form.Resultset.BOF Then
           rel_form.Resultset.Bookmark = DBList6.SelectedItem
           m_rlf1 = rel_form.Resultset![rlf_form1]
         Else
               name_form.Resultset.Bookmark = DBList4.SelectedItem
           m_rlf1 = name_form.Resultset![sub_typ] & name_form.Resultset![sub_no]
         End If
         
         frm_mcnz.Resultset.Bookmark = DBList8.SelectedItem
         m_rlf2 = frm_mcnz.Resultset![sub_cod]
         SQL = "execute insr_rel_form " & "'" & m_rlf1 & "'" & _
        "," & "'" & m_rlf2 & "'" & "," & "'" & m_rel.Text & "'"
        
        Else
        If Not subject.Resultset.BOF Then
          subject.Resultset.Bookmark = DBList7.SelectedItem
          m_frm = subject.Resultset![sub_form]
          Else
             name_form.Resultset.Bookmark = DBList4.SelectedItem
           m_frm = name_form.Resultset![sub_typ] & name_form.Resultset![sub_no]
         End If
          frm_mcnz.Resultset.Bookmark = DBList8.SelectedItem
          m_mcnz = frm_mcnz.Resultset![sub_code]
          SQL = "execute insr_subject " & "'" & m_frm & "'" & _
          "," & "'" & m_mcnz & "'" & "," & "'" & m_rel.Text & "'"
        End If
         '    cn.Connect = "uid=;pwd=;server=SEQUEL;" _
         '  & "driver={SQL Server};database=macnz;" _
         '  & "DSN='';"
         ''   cn.CursorDriver = rdUseOdbc
          ' cn.EstablishConnection rdDriverNoPrompt
                cn.Execute SQL, rdExecDirect
   
       If typ_list = 1 Then
         DBList8.Visible = False
         rel_form.Refresh
         DBList6.Refresh
         DBList6.SetFocus
         
       Else
           DBList8.Visible = False
           subject.Refresh
           DBList7.Refresh
           DBList7.SetFocus
       End If
         Text6.Visible = False

End Sub

Private Sub DBList8_KeyDown(KeyCode As Integer, Shift As Integer)
  
 If KeyCode = vbKeyF8 Then
    m_serh = 1
    Text5.Text = ""
    Text5.Visible = True
    Label12.Visible = True
    Text5.SetFocus
    SendKeys "{up}"
  ElseIf KeyCode = vbKeyF9 Then
    m_serh = 2
    Text5.Text = ""
    Text5.Visible = True
    Label12.Visible = True
    Text5.SetFocus
    SendKeys "{up}"
  End If
End Sub

Private Sub DBList8_KeyPress(KeyAscii As Integer)
' Dim cn As New rdoConnection
 Dim SQL As String
Select Case KeyAscii
    Case 27
     DBList8.Visible = False
     Text6.Visible = False
    Case 13
        If Not frm_mcnz.Resultset.EOF Or Not frm_mcnz.Resultset.BOF Then

       If typ_list = 1 Then
       ' If Not rel_form.Resultset.BOF Then
       '    rel_form.Resultset.Bookmark = DBList6.SelectedItem
       '    m_rlf1 = rel_form.Resultset![rlf_form1]
       '  Else
               name_form.Resultset.Bookmark = DBList4.SelectedItem
           m_rlf1 = name_form.Resultset![sub_typ] & name_form.Resultset![sub_no]
       '  End If

         frm_mcnz.Resultset.Bookmark = DBList8.SelectedItem
         m_rlf2 = frm_mcnz.Resultset![sub_cod]
         SQL = "execute insr_rel_form " & "'" & m_rlf1 & "'" & _
        "," & "'" & m_rlf2 & "'" & "," & "'" & m_rel.Text & "'"
        
        Else
       '  If Not subject.Resultset.BOF Then
       '   subject.Resultset.Bookmark = DBList7.SelectedItem
       '   m_frm = subject.Resultset![sub_form]
       '   Else
             name_form.Resultset.Bookmark = DBList4.SelectedItem
           m_frm = name_form.Resultset![sub_typ] & name_form.Resultset![sub_no]
       '  End If
          frm_mcnz.Resultset.Bookmark = DBList8.SelectedItem
          m_mcnz = frm_mcnz.Resultset![sub_code]
          SQL = "execute insr_subject " & "'" & m_frm & "'" & _
          "," & "'" & m_mcnz & "'" & "," & "'" & m_rel.Text & "'"
        End If
         '    cn.Connect = "uid=;pwd=;server=SEQUEL;" _
         '  & "driver={SQL Server};database=macnz;" _
         '  & "DSN='';"
         '   cn.CursorDriver = rdUseOdbc
         '  cn.EstablishConnection rdDriverNoPrompt
                cn.Execute SQL, rdExecDirect
        Text6.Visible = False
        
   Else
       MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
   End If
End Select
       If typ_list = 1 Then
         DBList8.Visible = False
         rel_form.Refresh
         DBList6.Refresh
         DBList6.SetFocus
         SendKeys "{up}"
       Else
           DBList8.Visible = False
           subject.Refresh
           DBList7.Refresh
           DBList7.SetFocus
           SendKeys "{up}"
       End If

End Sub

Private Sub deb_dte_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  fin_dte.SetFocus
ElseIf KeyAscii = 27 Then
      deb_dte.Visible = False
      fin_dte.Visible = False
      Label13.Visible = False
      Label14.Visible = False
      Shape1.Visible = False
     If typ_list = 1 Then
       DBList6.SetFocus
     Else
       DBList7.SetFocus
    End If
End If
End Sub

 
Private Sub fin_dte_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 Then
    Command3.SetFocus
    
 ElseIf KeyAscii = 27 Then
      deb_dte.Visible = False
      fin_dte.Visible = False
      Label13.Visible = False
      Label14.Visible = False
      Shape1.Visible = False
      If typ_list = 1 Then
        DBList6.SetFocus
      Else
       DBList7.SetFocus
      End If
    End If
End Sub

Private Sub Form_Load()
coding_typ = 2
typ_serh = 1
mod_typ = "0"
cod2.SQL = "execute proc_v_coding1"
cod2.Refresh

End Sub

Private Sub code_KeyPress(KeyAscii As Integer)
  Select Case KeyAscii
      Case 27
       Label3.Visible = False
       Label5.Visible = False
       Label6.Visible = False
        code.Visible = False
        desc.Visible = False
        Shape3.Visible = False
        If DBList1.Enabled = True Then
           DBList1.SetFocus
        ElseIf DBList2.Enabled = True Then
             DBList2.SetFocus
        ElseIf DBList3.Enabled = True Then
           DBList3.SetFocus
        ElseIf DBList4.Enabled = True Then
          DBList4.SetFocus
        ElseIf DBList5.Enabled = True Then
           DBList5.SetFocus
       End If
        SendKeys "{up}"

      Case 13
          If mod_typ = 1 Then
             If DBList1.Enabled = True Or DBList2.Enabled = True Then
                  tmp_msdrc.SQL = "exec find_coding " & "'" & code.Text & "'"
                  tmp_msdrc.Refresh
                  If Not tmp_msdrc.Resultset.EOF Or Not tmp_msdrc.Resultset.BOF Then
                     MsgBox "Â–« «·—ﬁ„  «»⁄ ·«” „«—… «Œ—Ï!!!!!"
                     code.SetFocus
                   Else
                     desc.SetFocus
                   End If
            ElseIf DBList3.Enabled = True Then
                pays.Resultset.Bookmark = DBList3.SelectedItem
                 m_sub_no = code.Text
                 m_sub_typ = pays.Resultset![sub_typ]
                 tmp_msdrc.SQL = "exec find_form " & "'" & m_sub_no & "'" _
                       & "," & "'" & m_sub_typ & "'"
                    
                  tmp_msdrc.Refresh
                  If Not tmp_msdrc.Resultset.EOF Or Not tmp_msdrc.Resultset.BOF Then
                     MsgBox "Â–« «·—ﬁ„  «»⁄ ·«” „«—… «Œ—Ï!!!!!"
                     code.SetFocus
                   Else
                     desc.SetFocus
                   End If
              ElseIf DBList4.Enabled = True Then
                   pays.Resultset.Bookmark = DBList3.SelectedItem
                   m_sub_typ = Mid(cod1.Resultset![sub_code], 3, 2)
                   m_sub = Mid(pays.Resultset![sub_no], 1, 3)
'                name_form.Resultset.Bookmark = DBList4.SelectedItem
'                m_sub_typ = name_form.Resultset![sub_typ]
'                m_sub = Mid(name_form.Resultset![sub_no], 1, 3)
                  m_sub_no = m_sub & code.Text
                tmp_msdrc.SQL = "exec find_form " & "'" & m_sub_no & "'" _
                       & "," & "'" & m_sub_typ & "'"
                    
                  tmp_msdrc.Refresh
                  If Not tmp_msdrc.Resultset.EOF Or Not tmp_msdrc.Resultset.BOF Then
                     MsgBox "Â–« «·—ﬁ„  «»⁄ ·«” „«—… «Œ—Ï!!!!!"
                     code.SetFocus
                   Else
                     desc.SetFocus
                   End If
            End If
          End If
   End Select
End Sub

Private Sub Command1_Click()
 mod_typ = "1"
 Label3.Visible = True
 Label5.Visible = True
 Label6.Visible = True
 code.Visible = True
 desc.Visible = True
 Shape3.Visible = True
 If DBList1.Enabled = True Then
'   coding.Resultset![sub_leve] = "1"
  If coding_typ <> 1 Then
   coding_typ = 1
   coding.Resultset.AddNew
   End If
   desc.Text = ""
   code.Text = ""
   code.SetFocus
 ElseIf DBList2.Enabled = True Then
'   coding.Resultset![sub_leve] = "2"
  If coding_typ <> 1 Then
   coding_typ = 1
   coding.Resultset.AddNew
   End If
   desc.Text = ""
   code.Text = ""
   code.SetFocus
 ElseIf DBList3.Enabled = True Then
   desc.Text = ""
   code.Text = ""
'   f_form.Resultset.AddNew
    code.SetFocus
 ElseIf DBList4.Enabled = True Then
   desc.Text = ""
   code.Text = ""
 '  f_form.Resultset.AddNew
 code.SetFocus
  ElseIf DBList5.Enabled = True Then
   desc.Text = ""
   code.Text = ""
   code.Enabled = False
   pos.Resultset.AddNew
   desc.SetFocus
   
 End If
  

End Sub

Private Sub Command2_Click()
 mod_typ = "2"
 Dim m_typ, m_sub_typ, m_sub_no As Variant
 Dim m_code As Variant
 Dim m_desc As Variant
 
 
   If DBList1.Enabled = True Then
     cod2.Resultset.Bookmark = DBList1.SelectedItem
     m_code = cod2.Resultset![sub_code]
     cod3.SQL = "execute find_coding " & "'" & m_code & "'"
     cod3.Refresh
     desc.Text = cod3.Resultset![sub_desc]
     code.Text = cod3.Resultset![sub_code]
ElseIf DBList2.Enabled = True Then
   cod1.Resultset.Bookmark = DBList2.SelectedItem
   m_code = cod1.Resultset![sub_code]
   cod3.SQL = "execute find_coding " & "'" & m_code & "'"
   cod3.Refresh
   desc.Text = cod3.Resultset![sub_desc]
   code.Text = cod3.Resultset![sub_code]
ElseIf DBList3.Enabled = True Then
   pays.Resultset.Bookmark = DBList3.SelectedItem
    m_sub_no = pays.Resultset![sub_no]
    m_sub_typ = pays.Resultset![sub_typ]
    cod3.SQL = "execute find_form " & "'" & m_sub_no & "'" & "," & "'" & m_sub_typ & "'"
    cod3.Refresh
     desc.Text = cod3.Resultset![sub_name]
     code.Text = cod3.Resultset![sub_typ] & cod3.Resultset![sub_no]
ElseIf DBList4.Enabled = True Then
   name_form.Resultset.Bookmark = DBList4.SelectedItem
    m_sub_no = name_form.Resultset![sub_no]
    m_sub_typ = name_form.Resultset![sub_typ]
    cod3.SQL = "execute find_form " & "'" & m_sub_no & "'" & "," & "'" & m_sub_typ & "'"
    cod3.Refresh
    desc.Text = cod3.Resultset![sub_name]
    code.Text = cod3.Resultset![sub_typ] & cod3.Resultset![sub_no]
ElseIf DBList5.Enabled = True Then
    position.Resultset.Bookmark = DBList5.SelectedItem
    desc.Text = position.Resultset![pos_nam]
    code.Text = position.Resultset![pos_no]
'    code.Enabled = False
End If
 
  
 Label3.Visible = True
 Label5.Visible = True
 Label6.Visible = True
 code.Visible = True
 desc.Visible = True
 Shape3.Visible = True
 desc.SetFocus
 SendKeys "{end}"
End Sub

Private Sub Command3_Click()
 Dim m_code As Variant
 Dim m_desc As Variant
' Dim cn As New rdoConnection
 Dim SQL As String

If mod_typ = "1" Then
 Label3.Visible = False
 Label5.Visible = False
 Label6.Visible = False
 code.Visible = False
 desc.Visible = False
 Shape3.Visible = False
  If DBList1.Enabled = True Then
'    coding.Resultset![sub_typ] = Mid(Trim(code.Text), 1, 2)
    coding.Resultset![sub_code] = code.Text
    coding.Resultset![sub_desc] = desc.Text
    coding.Resultset![sub_leve] = "1"
    
    coding.Resultset.Update
    coding.Refresh
    cod2.Refresh
    DBList1.Refresh
    DBList1.SetFocus
    SendKeys "{up}"
    coding_typ = 2
 ElseIf DBList2.Enabled = True Then
'  coding.Resultset![sub_typ] = Mid(Trim(code.Text), 1, 2)
  coding.Resultset![sub_code] = code.Text
  coding.Resultset![sub_desc] = desc.Text
  coding.Resultset![sub_leve] = "2"
  coding.Resultset.Update
  coding.Refresh
  cod1.Refresh
  DBList2.Refresh
  DBList2.SetFocus
  SendKeys "{up}"
  coding_typ = 2
 ElseIf DBList3.Enabled = True Then
     m_date = Date
     pays.Resultset.Bookmark = DBList3.SelectedItem
     m_sub_no = code.Text
     m_desc = desc.Text
     m_sub_typ = pays.Resultset![sub_typ]
     SQL = "exec insr_form " & "'" & m_desc & "'" & "," & "'" & m_sub_no & "'" _
           & "," & "'" & m_sub_typ & "'" _
           & "," & "'" & Format(m_date, "yyyy/mm/dd") & "'"
           
'                 cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'          & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'            cn.EstablishConnection rdDriverNoPrompt
            cn.Execute SQL, rdExecDirect
  
     f_form.Refresh
     pays.Refresh
     DBList3.Refresh
     m_code = m_sub_typ + m_sub_no
     Call div_word(m_code, m_desc, "2")
      DBList3.SetFocus
      SendKeys "{up}"
 ElseIf DBList4.Enabled = True Then
     m_date = Date
     pays.Resultset.Bookmark = DBList3.SelectedItem
     m_desc = desc.Text
     m_sub_typ = Mid(cod1.Resultset![sub_code], 3, 2)
     m_sub = Mid(pays.Resultset![sub_no], 1, 3)
     m_sub_no = m_sub & code.Text
     SQL = "exec insr_form " & "'" & m_desc & "'" & "," & "'" & m_sub_no & "'" _
           & "," & "'" & m_sub_typ & "'" _
           & "," & "'" & Format(m_date, "yyyy/mm/dd") & "'"
       
      ' cn.Connect = "uid=;pwd=;server=SEQUEL;" _
      '    & "driver={SQL Server};database=macnz;" _
      '     & "DSN='';"
      '      cn.CursorDriver = rdUseOdbc
      '      cn.EstablishConnection rdDriverNoPrompt
            cn.Execute SQL, rdExecDirect
  

     f_form.Refresh
     name_form.Refresh
     DBList4.Refresh
     m_code = m_sub_typ + m_sub_no
     Call div_word(m_code, m_desc, "2")
    DBList4.SetFocus
    SendKeys "{up}"
 ElseIf DBList5.Enabled = True Then
    ' pos.Resultset![pos_nam] = desc.Text
    ' pos.Resultset![pos_no] = v_sub_no
    '' pos.Resultset.Update
     m_date = Date
     m_desc = desc.Text
     m_sub_typ = name_form.Resultset![sub_typ]
     m_sub = name_form.Resultset![sub_no]
     m_sub_no = m_sub_typ & m_sub
     SQL = "exec insr_pos " & "'" & m_desc & "'" & "," & "'" & m_sub_no & "'" _
            & "," & "'" & Format(m_date, "yyyy/mm/dd") & "'"
             ' cn.Connect = "uid=;pwd=;server=SEQUEL;" _
       '   & "driver={SQL Server};database=macnz;" _
       '    & "DSN='';"
       '     cn.CursorDriver = rdUseOdbc
       '     cn.EstablishConnection rdDriverNoPrompt
            cn.Execute SQL, rdExecDirect
  
    pos.Refresh
    position.Refresh
    DBList5.Refresh
    code.Enabled = True
    DBList5.SetFocus
    SendKeys "{up}"
     '   cn.Connect = "uid=;pwd=;server=SEQUEL;"
 
 End If
 mod_typ = "0"
ElseIf mod_typ = "2" Then
  m_desc = desc.Text
  If DBList1.Enabled = True Then
     cod2.Resultset.Bookmark = DBList1.SelectedItem
     m_code = cod2.Resultset![sub_code]
     SQL = "exec upd_coding " & "'" & m_desc & "'" & "," & "'" & m_code & "'"
  ElseIf DBList2.Enabled = True Then
     cod1.Resultset.Bookmark = DBList2.SelectedItem
     m_code = cod1.Resultset![sub_code]
     SQL = "exec upd_coding " & "'" & m_desc & "'" & "," & "'" & m_code & "'"
  ElseIf DBList3.Enabled = True Then
     pays.Resultset.Bookmark = DBList3.SelectedItem
     m_sub_no = pays.Resultset![sub_no]
     m_sub_typ = pays.Resultset![sub_typ]
     SQL = "exec upd_form " & "'" & m_desc & "'" & "," & "'" & m_sub_no & "'" _
           & "," & "'" & m_sub_typ & "'"
  ElseIf DBList4.Enabled = True Then
     name_form.Resultset.Bookmark = DBList4.SelectedItem
     m_sub_no = name_form.Resultset![sub_no]
     m_sub_typ = name_form.Resultset![sub_typ]
     SQL = "exec upd_form " & "'" & m_desc & "'" & "," & "'" & m_sub_no & "'" _
           & "," & "'" & m_sub_typ & "'"
           
  ElseIf DBList5.Enabled = True Then
     position.Resultset.Bookmark = DBList5.SelectedItem
     m_sub_no = position.Resultset![pos_no]
     m_desc1 = position.Resultset![pos_nam]
     SQL = "exec upd_position" & "'" & m_desc & "'" & "," & "'" & m_sub_no & "'" _
           & "," & "'" & m_desc1 & "'"
     code.Enabled = True
   ElseIf DBList6.Enabled = True And deb_dte.Visible = True And typ_list = 1 Then
     rel_form.Resultset.Bookmark = DBList6.SelectedItem
     m_rlf1 = rel_form.Resultset![rlf_form1]
     m_rlf2 = rel_form.Resultset![rlf_form2]
   
      SQL = "execute upd_rfl_dte " & "'" & m_rlf1 & "'" & "," & "'" & m_rlf2 & "'" & "," & "'" & m_rel.Text & "'" _
        & "," & "'" & Format(deb_dte.Text, "yyyy/mm/dd") & "'" & _
          "," & "'" & Format(fin_dte.Text, "yyyy/mm/dd") & "'"
 
      rel_form.Refresh
      deb_dte.Visible = False
      fin_dte.Visible = False
      Label13.Visible = False
      Label14.Visible = False
      Shape1.Visible = False
      DBList6.SetFocus
  ElseIf DBList7.Enabled = True And deb_dte.Visible = True And typ_list = 2 Then
     subject.Resultset.Bookmark = DBList7.SelectedItem
     m_rlf1 = subject.Resultset![sub_form]
     m_rlf2 = subject.Resultset![sub_mcnz]
   
      SQL = "execute upd_sub_dte " & "'" & m_rlf1 & "'" & "," & "'" & m_rlf2 & "'" & "," & "'" & m_rel.Text & "'" _
        & "," & "'" & Format(deb_dte.Text, "yyyy/mm/dd") & "'" & _
          "," & "'" & Format(fin_dte.Text, "yyyy/mm/dd") & "'"
 
      subject.Refresh
      deb_dte.Visible = False
      fin_dte.Visible = False
      Label13.Visible = False
      Label14.Visible = False
      Shape1.Visible = False
      DBList7.SetFocus
          
End If
  
          ' cn.Connect = "uid=;pwd=;server=SEQUEL;" _
          ' & "driver={SQL Server};database=macnz;" _
          ' & "DSN='';"
          ''  cn.CursorDriver = rdUseOdbc
           ' cn.EstablishConnection rdDriverNoPrompt
           
            cn.Execute SQL, rdExecDirect
           
   If DBList3.Enabled = True Or DBList4.Enabled = True Then
       m_code = m_sub_typ + m_sub_no
         m_typ = "2"
       SQL = "exec del_word" & "'" & m_code & "'" _
           & "," & "'" & m_typ & "'"
       cn.Execute SQL, rdExecDirect
       Call div_word(m_code, m_desc, "2")
    End If
   
   
   
 If DBList1.Enabled = True Then
   cod2.Refresh
   DBList1.Refresh
   DBList1.SetFocus
ElseIf DBList2.Enabled = True Then
   cod1.Refresh
   DBList2.Refresh
   DBList2.SetFocus
ElseIf DBList3.Enabled = True Then
  pays.Refresh
  DBList3.Refresh
  DBList3.SetFocus
ElseIf DBList4.Enabled = True Then
  name_form.Refresh
  DBList4.Refresh
  DBList4.SetFocus
 ElseIf DBList5.Enabled = True Then
  position.Refresh
  DBList5.Refresh
  DBList5.SetFocus
 
End If
mod_typ = "0"
 Label3.Visible = False
 Label5.Visible = False
 Label6.Visible = False
 code.Visible = False
 desc.Visible = False
 Shape3.Visible = False
End If
End Sub

Private Sub Command4_Click()
 Dim ok As String
 Dim m_code As Variant
 Dim m_desc As Variant
' Dim cn As New rdoConnection
 Dim SQL As String
          
         ok = " "
         ok = InputBox("Â·  —Ìœ «·€«¡ «·„ﬁ«·…(‰/ﬂ)")
If ok = "y" Or ok = "‰" Then
        '   cn.Connect = "uid=;pwd=;server=SEQUEL;" _
        '   & "driver={SQL Server};database=macnz;" _
        '   & "DSN='';"
        '    cn.CursorDriver = rdUseOdbc
        '    cn.EstablishConnection rdDriverNoPrompt
    
 If DBList1.Enabled = True Then
   cod2.Resultset.Bookmark = DBList1.SelectedItem
   m_code = cod2.Resultset![sub_code]
               SQL = "exec del_coding " & "'" & m_code & "'"
            cn.Execute SQL, rdExecDirect
            cod3.Refresh
            cod2.Refresh
            DBList1.Refresh
            DBList1.SetFocus
            SendKeys "{up}"
            
ElseIf DBList2.Enabled = True Then
         cod1.Resultset.Bookmark = DBList2.SelectedItem
         m_code = cod1.Resultset![sub_code]
            SQL = "exec del_coding " & "'" & m_code & "'"
            cn.Execute SQL, rdExecDirect
            cod3.Refresh
            cod1.Refresh
            DBList2.Refresh
            DBList2.SetFocus
            SendKeys "{up}"
ElseIf DBList3.Enabled = True Then
    pays.Resultset.Bookmark = DBList3.SelectedItem
    m_sub_no = pays.Resultset![sub_no]
    m_sub_typ = pays.Resultset![sub_typ]
    SQL = "exec del_form " & "'" & m_sub_no & "'" & "," & "'" & m_sub_typ & "'"
    cn.Execute SQL, rdExecDirect
    cod3.Refresh
    pays.Refresh
    DBList3.Refresh
    DBList3.SetFocus
    SendKeys "{up}"
 ElseIf DBList4.Enabled = True Then
    name_form.Resultset.Bookmark = DBList4.SelectedItem
    m_sub_no = name_form.Resultset![sub_no]
    m_sub_typ = name_form.Resultset![sub_typ]
    SQL = "exec del_form " & "'" & m_sub_no & "'" & "," & "'" & m_sub_typ & "'"
    cn.Execute SQL, rdExecDirect
    cod3.Refresh
    name_form.Refresh
    DBList4.Refresh
    DBList4.SetFocus
    SendKeys "{up}"
ElseIf DBList5.Enabled = True Then
    position.Resultset.Bookmark = DBList5.SelectedItem
    m_sub_no = position.Resultset![pos_no]
    m_desc = position.Resultset![pos_nam]
    SQL = "exec del_position " & "'" & m_sub_no & "'" & "," & "'" & m_desc & "'"
    cn.Execute SQL, rdExecDirect
    position.Refresh
    DBList5.Refresh
    DBList5.SetFocus
    SendKeys "{up}"
ElseIf DBList6.Enabled = True Or DBList7.Enabled = True Then
    If typ_list = 1 Then
       If Not rel_form.Resultset.BOF Then
           rel_form.Resultset.Bookmark = DBList6.SelectedItem
           m_rlf1 = rel_form.Resultset![rlf_form1]
           m_rlf2 = rel_form.Resultset![rlf_form2]
           v_rel = m_rel.Text
           SQL = "execute del_rel_form " & "'" & m_rlf1 & "'" & _
           "," & "'" & m_rlf2 & "'" & "," & "'" & v_rel & "'"
           cn.Execute SQL, rdExecDirect
          rel_form.Refresh
          DBList6.Refresh
          DBList6.SetFocus
          SendKeys "{up}"
        End If
      Else
       If Not subject.Resultset.BOF Then
            subject.Resultset.Bookmark = DBList7.SelectedItem
          m_frm = subject.Resultset![sub_form]
          m_mcnz = subject.Resultset![sub_mcnz]
          v_rel = m_rel.Text
          SQL = "execute del_subject " & "'" & m_frm & "'" & _
            "," & "'" & m_mcnz & "'" & "," & "'" & v_rel & "'"
          cn.Execute SQL, rdExecDirect
          subject.Refresh
          DBList7.Refresh
          DBList7.SetFocus
            SendKeys "{up}"
      End If
   End If
End If
End If
End Sub


Private Sub DBList1_Click()
  cod2.Resultset.Bookmark = DBList1.SelectedItem
  Text1.Text = cod2.Resultset![sub_code]
  
End Sub

Private Sub DBList1_DblClick()
'MsgBox cod2.Resultset.Bookmark
'cod2.Resultset.Bookmark = DBList1.SelectedItem

cod2.Resultset.Bookmark = DBList1.SelectedItem
cod1.SQL = "execute coding_proc " & "'" & Mid(cod2.Resultset![sub_code], 1, 2) & "'"
cod1.Refresh
DBList2.Enabled = True
DBList1.Enabled = False
DBList2.SetFocus
SendKeys "{up}"
End Sub

Private Sub DBList1_KeyPress(KeyAscii As Integer)
 Select Case KeyAscii
      Case 13
        cod2.Resultset.Bookmark = DBList1.SelectedItem
        cod1.SQL = "execute coding_proc " & "'" & Mid(cod2.Resultset![sub_code], 1, 2) & "'"
        cod1.Refresh
        DBList2.Enabled = True
        DBList1.Enabled = False
        DBList2.SetFocus
         SendKeys "{up}"
       
  
     End Select
End Sub

Private Sub DBList2_Click()
  cod1.Resultset.Bookmark = DBList2.SelectedItem
  Text2.Text = cod1.Resultset![sub_code]
  
 
End Sub

Private Sub DBList2_DblClick()
    cod1.Resultset.Bookmark = DBList2.SelectedItem
    If Mid(cod1.Resultset![sub_code], 1, 2) = "10" Then
      DBList3.Visible = True
       DBList2.Enabled = False
       Line3.Visible = True
       v_typ = Mid(cod1.Resultset![sub_code], 3, 2)
       DBList3.SetFocus
       Label7.Visible = True
       Text3.Visible = True
       SendKeys "{up}"
    End If
End Sub

Private Sub DBList2_KeyPress(KeyAscii As Integer)
  Select Case KeyAscii
      Case 27
         DBList1.Enabled = True
         DBList1.SetFocus
         DBList2.Enabled = False
      Case 13
        cod1.Resultset.Bookmark = DBList2.SelectedItem
        If Mid(cod1.Resultset![sub_code], 1, 2) = "10" Then
           DBList3.Visible = True
           DBList2.Enabled = False
           Line3.Visible = True
           v_typ = Mid(cod1.Resultset![sub_code], 3, 2)
           DBList3.SetFocus
           Label7.Visible = True
           Text3.Visible = True
           SendKeys "{up}"
        End If
      Case 109
      
     Case 146
       Command2.SetFocus
       SendKeys "{enter}"
 
      End Select
End Sub

Private Sub DBList3_DblClick()
If Not pays.Resultset.EOF And Not pays.Resultset.BOF Then
  pays.Resultset.Bookmark = DBList3.SelectedItem
  name_form.SQL = "execute nam_form " & "'" & Trim(v_typ) & "'" & "," & "'" & Mid(pays.Resultset![sub_no], 1, 3) & "'"
  name_form.Refresh
  DBList4.Visible = True
  DBList4.Refresh
  Line4.Visible = True
  Line5.Visible = True
  DBList3.Enabled = False
  DBList4.SetFocus
  Label8.Visible = True
  Text4.Visible = True
  SendKeys "{up}"
End If
End Sub

Private Sub DBList3_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
      Case 27
       DBList2.Enabled = True
       DBList2.SetFocus
       DBList3.Visible = False
       Line3.Visible = False
       Label7.Visible = False
       Text3.Visible = False
       pays.SQL = "select * from pay_form"
       pays.Refresh
       
     Case 13
     If Not pays.Resultset.EOF And Not pays.Resultset.BOF Then
       pays.Resultset.Bookmark = DBList3.SelectedItem
       name_form.SQL = "execute nam_form " & "'" & Trim(v_typ) & "'" & "," & "'" & Mid(pays.Resultset![sub_no], 1, 3) & "'"
       name_form.Refresh
       DBList4.Visible = True
       DBList4.Refresh
       Line4.Visible = True
       Line5.Visible = True
       DBList3.Enabled = False
       DBList4.SetFocus
       Label8.Visible = True
       Text4.Visible = True
       SendKeys "{up}"
     End If
     Case 109
       Command2.SetFocus
       SendKeys "13"
     Case 146
       Command2.SetFocus
       SendKeys "13"
  
   End Select
End Sub

Private Sub DBList4_DblClick()
 If Not name_form.Resultset.EOF And Not name_form.Resultset.BOF Then
  Dim m_code As Variant
  name_form.Resultset.Bookmark = DBList4.SelectedItem
  DBList4.Enabled = False
  If name_form.Resultset![sub_typ] = "01" Then
  m_code = name_form.Resultset![sub_typ] & name_form.Resultset![sub_no]
  v_sub_no = m_code
  position.SQL = " execute proc_pos " & "'" & m_code & "'"
  position.Refresh
  DBList5.Visible = True
  DBList5.Refresh
  Line6.Visible = True
  Line7.Visible = True
   If DBList5.Enabled = False Then
      DBList5.Enabled = True
   End If
  DBList5.SetFocus
  Label9.Visible = True
  SendKeys "{up}"
 Else
         DBList6.Visible = True
        Line8.Visible = True
        Line9.Visible = True
        Line10.Visible = True
        m_rel.Visible = True
        Label10.Visible = True
        Label11.Visible = True
        DBList7.Visible = True

  m_code = name_form.Resultset![sub_typ] & name_form.Resultset![sub_no]
        m_rel = "01"
        DBList5.Enabled = False
        rel_form.SQL = "execute rel_form_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        rel_form.Refresh
        subject.SQL = "execute subject_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        subject.Refresh
        DBList6.SetFocus
         typ_list = 1
           SendKeys "{up}"
 End If
End If
End Sub

Private Sub DBList4_KeyPress(KeyAscii As Integer)
    Select Case KeyAscii
      Case 27
        DBList4.Visible = False
        Line4.Visible = False
        Line5.Visible = False
        DBList3.Enabled = True
        DBList3.SetFocus
        Label8.Visible = False
        Text4.Visible = False
      Case 13
      If Not name_form.Resultset.EOF And Not name_form.Resultset.BOF Then
         Dim m_code As Variant
         name_form.Resultset.Bookmark = DBList4.SelectedItem
         DBList4.Enabled = False
         If name_form.Resultset![sub_typ] = "01" Then
           m_code = name_form.Resultset![sub_typ] & name_form.Resultset![sub_no]
           v_sub_no = m_code
           position.SQL = " execute proc_pos " & "'" & m_code & "'"
           position.Refresh
           DBList5.Visible = True
           DBList5.Refresh
           Line6.Visible = True
           Line7.Visible = True
           If DBList5.Enabled = False Then
              DBList5.Enabled = True
           End If
           DBList5.SetFocus
           Label9.Visible = True
           SendKeys "{up}"
        Else
                DBList6.Visible = True
        Line8.Visible = True
        Line9.Visible = True
        Line10.Visible = True
        m_rel.Visible = True
        Label10.Visible = True
        Label11.Visible = True
        DBList7.Visible = True

       ' name_form.Resultset.Bookmark = DBList4.SelectedItem
        m_code = name_form.Resultset![sub_typ] & name_form.Resultset![sub_no]
        m_rel = "01"
        DBList5.Enabled = False
        rel_form.SQL = "execute rel_form_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        rel_form.Refresh
        subject.SQL = "execute subject_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        subject.Refresh
        DBList6.SetFocus
         typ_list = 1
           SendKeys "{up}"
        End If
       End If
     Case 109
       Command2.SetFocus
       SendKeys "{enter}"
     Case 146
       Command2.SetFocus
       SendKeys "{enter}"
     End Select
        
End Sub

Private Sub DBList5_KeyPress(KeyAscii As Integer)
 Select Case KeyAscii
      Case 27
         Line6.Visible = False
         Line7.Visible = False
         DBList5.Visible = False
         DBList4.Enabled = True
         DBList4.SetFocus
         Label9.Visible = False
      Case 13
        DBList6.Visible = True
        Line8.Visible = True
        Line9.Visible = True
        Line10.Visible = True
        m_rel.Visible = True
        Label10.Visible = True
        Label11.Visible = True
        DBList7.Visible = True
       ' position.Resultset.Bookmark = DBList5.SelectedItem
       ' m_code = position.Resultset![pos_no]
        name_form.Resultset.Bookmark = DBList4.SelectedItem
        m_code = name_form.Resultset![sub_typ] & name_form.Resultset![sub_no]
        m_rel = "01"
        DBList5.Enabled = False
        rel_form.SQL = "execute rel_form_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        rel_form.Refresh
        subject.SQL = "execute subject_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        subject.Refresh
        DBList6.SetFocus
        typ_list = 1
        SendKeys "{up}"
     Case 109
       Command2.SetFocus
       SendKeys "{enter}"
     Case 146
       Command2.SetFocus
       SendKeys "{enter}"
 
      End Select
End Sub

Private Sub desc_KeyPress(KeyAscii As Integer)

  Select Case KeyAscii
      Case 27
         Label3.Visible = False
         Label5.Visible = False
         Label6.Visible = False
         code.Visible = False
         desc.Visible = False
         Shape3.Visible = False
        If DBList1.Enabled = True Then
           DBList1.SetFocus
        ElseIf DBList2.Enabled = True Then
             DBList2.SetFocus
        ElseIf DBList3.Enabled = True Then
           DBList3.SetFocus
        ElseIf DBList4.Enabled = True Then
          DBList4.SetFocus
        ElseIf DBList5.Enabled = True Then
           DBList5.SetFocus
       End If
        SendKeys "{up}"
      Case 13
      If typ_serh = 2 Then
       If DBList3.Enabled = True Then
          m_desc = desc.Text
          m_len = Len(Trim(m_desc))
          pays.SQL = "execute serh_form " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
          pays.Refresh
          DBList3.Refresh
          DBList3.SetFocus
          SendKeys "{up}"
        ElseIf DBList4.Enabled = True Then
         pays.Resultset.Bookmark = DBList3.SelectedItem
          v_typ = Mid(cod1.Resultset![sub_code], 3, 2)
          v_cod = Mid(pays.Resultset![sub_no], 1, 3)
          m_desc = desc.Text
          m_len = Len(Trim(m_desc))
          name_form.SQL = "execute serh1_form " & "'" & v_typ & "'" & "," & "'" & v_cod & "'" & "," & _
          "'" & m_desc & "'" & "," & "'" & m_len & "'"
          name_form.Refresh
          DBList4.Refresh
          DBList4.SetFocus
          SendKeys "{up}"
     End If
           typ_serh = 1
        Label3.Visible = False
       Label5.Visible = False
       Label6.Visible = False
        code.Visible = False
        desc.Visible = False
        Shape3.Visible = False

   ElseIf typ_serh = 1 Then
     If DBList4.Enabled = True And DBList4.Visible = True Then
       If mod_typ = 1 Then
          pays.Resultset.Bookmark = DBList3.SelectedItem
          v_typ = Mid(cod1.Resultset![sub_code], 3, 2)
          v_cod = Mid(pays.Resultset![sub_no], 1, 3)
          m_desc = Trim(desc.Text)
          m_len = Len(Trim(m_desc))
          m_desc = m_desc + Space(60 - m_len)
          m_len = 60
          name_form.SQL = "execute serh1_form " & "'" & v_typ & "'" & "," & "'" & v_cod & "'" & "," & _
          "'" & m_desc & "'" & "," & "'" & m_len & "'"
          name_form.Refresh
          If Not name_form.Resultset.EOF And Not name_form.Resultset.BOF Then
                    MsgBox "Â–« «·«”„ „œŒ· ”«»ﬁ«!"
                    desc.SetFocus
            Else
                    Command3.SetFocus
           End If
           name_form.SQL = "execute nam_form " & "'" & Trim(v_typ) & "'" & "," & "'" & Mid(pays.Resultset![sub_no], 1, 3) & "'"
           name_form.Refresh
       Else
             Command3.SetFocus
       End If
       
      Else
         Command3.SetFocus
      End If
   ElseIf typ_serh = 3 Then
         
         pays.Resultset.Bookmark = DBList3.SelectedItem
          v_typ = Mid(cod1.Resultset![sub_code], 3, 2)
          v_cod = Mid(pays.Resultset![sub_no], 1, 3)
          m_desc = desc.Text
          m_len = Len(Trim(m_desc))
          v_cod = v_typ + v_cod
          name_form.SQL = "execute serh_wrdform1 " & "'" & m_desc & "'" & "," & "'" & m_len & "'" _
           & "," & "'" & v_cod & "'"
          name_form.Refresh
          DBList4.Refresh
          DBList4.SetFocus
                typ_serh = 1
        Label3.Visible = False
       Label5.Visible = False
       Label6.Visible = False
        code.Visible = False
        desc.Visible = False
        Shape3.Visible = False
        SendKeys "{up}"
      End If
   End Select
   
End Sub


Private Sub m_rel_Change()
'        position.Resultset.Bookmark = DBList5.SelectedItem
'        m_code = position.Resultset![pos_no]
        name_form.Resultset.Bookmark = DBList4.SelectedItem
        m_code = name_form.Resultset![sub_typ] & name_form.Resultset![sub_no]
        rel_form.SQL = "execute rel_form_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        rel_form.Refresh
        subject.SQL = "execute subject_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        subject.Refresh
        
End Sub

Private Sub m_rel_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  DBList6.SetFocus
End If
  
End Sub

Private Sub Text5_KeyPress(KeyAscii As Integer)
 Select Case KeyAscii
   Case 13
   If m_serh = 1 Then
     If typ_list = 1 Then
         m_desc = Text5.Text
         m_len = Len(Trim(Text5))
         frm_mcnz.SQL = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         frm_mcnz.Refresh
        DBList8.Refresh
        DBList8.SetFocus
       SendKeys "{up}"

     ElseIf typ_list = 2 Then
       m_desc = Text5.Text
       m_len = Len(Trim(m_desc))
        frm_mcnz.SQL = "execute serh_macnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        frm_mcnz.Refresh
        DBList8.Refresh
        DBList8.SetFocus
        SendKeys "{up}"

     End If
  ElseIf m_serh = 2 Then
   If typ_list = 1 Then
         m_desc = Text5.Text
         m_len = Len(Trim(Text5))
         frm_mcnz.SQL = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         frm_mcnz.Refresh
          DBList8.Refresh
          DBList8.SetFocus
          
       SendKeys "{up}"

     ElseIf typ_list = 2 Then
       m_desc = Text5.Text
       m_len = Len(Trim(m_desc))
        frm_mcnz.SQL = "execute serh_wrdmacnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        frm_mcnz.Refresh
        DBList8.Refresh
        DBList8.SetFocus
        SendKeys "{up}"

     End If
    
    End If
       Text5.Visible = False
      Label12.Visible = False
      
  End Select
  
  

End Sub

