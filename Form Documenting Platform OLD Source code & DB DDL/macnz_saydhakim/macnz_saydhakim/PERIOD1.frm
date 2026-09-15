VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Begin VB.Form PERIOD 
   BackColor       =   &H00FFC0C0&
   Caption         =   "                                                                        «” „«—… «·œÊ—Ì…    "
   ClientHeight    =   9645
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   19785
   Icon            =   "PERIOD1.frx":0000
   LinkTopic       =   "PERIOD"
   RightToLeft     =   -1  'True
   ScaleHeight     =   9645
   ScaleWidth      =   19785
   Begin VB.Frame Frame2 
      BackColor       =   &H00FF0000&
      Caption         =   "«·»ÕÀ ⁄‰ «” „«—… „⁄Ì‰…"
      ForeColor       =   &H0000FFFF&
      Height          =   2175
      Left            =   7560
      RightToLeft     =   -1  'True
      TabIndex        =   52
      Top             =   4080
      Visible         =   0   'False
      Width           =   3495
      Begin VB.TextBox m_ist_no 
         Alignment       =   1  'Right Justify
         Height          =   375
         Left            =   960
         RightToLeft     =   -1  'True
         TabIndex        =   55
         Top             =   720
         Width           =   1215
      End
      Begin VB.CommandButton Command12 
         Caption         =   " ‰›Ì–"
         Height          =   495
         Left            =   2400
         RightToLeft     =   -1  'True
         TabIndex        =   54
         Top             =   1560
         Width           =   855
      End
      Begin VB.CommandButton Command13 
         Caption         =   "«·€«¡ «·«„—"
         Height          =   495
         Left            =   480
         RightToLeft     =   -1  'True
         TabIndex        =   53
         Top             =   1560
         Width           =   855
      End
      Begin VB.Label Label24 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FF0000&
         Caption         =   "—ﬁ„ «·«” „«—…"
         ForeColor       =   &H0000FFFF&
         Height          =   375
         Left            =   2280
         RightToLeft     =   -1  'True
         TabIndex        =   56
         Top             =   720
         Width           =   975
      End
   End
   Begin VB.TextBox m_txt_pub 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   960
      RightToLeft     =   -1  'True
      TabIndex        =   71
      Top             =   4320
      Width           =   4215
   End
   Begin MSDBCtls.DBList DBList2 
      Bindings        =   "PERIOD1.frx":27A2
      Height          =   2790
      Left            =   6960
      TabIndex        =   66
      Top             =   960
      Visible         =   0   'False
      Width           =   4215
      _ExtentX        =   7435
      _ExtentY        =   4921
      _Version        =   393216
      BackColor       =   16744576
      ForeColor       =   65535
      ListField       =   "per_per_na"
      RightToLeft     =   -1  'True
   End
   Begin MSDBCtls.DBList DBList1 
      Bindings        =   "PERIOD1.frx":27B9
      Height          =   2790
      Left            =   1080
      TabIndex        =   47
      Top             =   4680
      Visible         =   0   'False
      Width           =   4215
      _ExtentX        =   7435
      _ExtentY        =   4921
      _Version        =   393216
      BackColor       =   16744576
      ForeColor       =   65535
      ListField       =   "SUB_NAME"
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox m_per_website 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   1200
      RightToLeft     =   -1  'True
      TabIndex        =   69
      Top             =   2040
      Width           =   3975
   End
   Begin VB.TextBox m_per_email 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   14160
      RightToLeft     =   -1  'True
      TabIndex        =   67
      Top             =   2040
      Width           =   4095
   End
   Begin VB.TextBox Text4 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   1680
      RightToLeft     =   -1  'True
      TabIndex        =   65
      Top             =   4800
      Visible         =   0   'False
      Width           =   2175
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Œ—ÊÃ"
      Height          =   615
      Left            =   120
      TabIndex        =   63
      Top             =   6120
      Width           =   735
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H00FF8080&
      Height          =   2415
      Left            =   7440
      RightToLeft     =   -1  'True
      TabIndex        =   58
      Top             =   5760
      Visible         =   0   'False
      Width           =   3375
      Begin VB.CommandButton Command3 
         Caption         =   "«·€«¡ «·«„—"
         Height          =   495
         Left            =   360
         RightToLeft     =   -1  'True
         TabIndex        =   61
         Top             =   1560
         Width           =   735
      End
      Begin VB.CommandButton Command2 
         Caption         =   " ‰›Ì–"
         Height          =   495
         Left            =   2160
         RightToLeft     =   -1  'True
         TabIndex        =   60
         Top             =   1560
         Width           =   735
      End
      Begin VB.TextBox M_YESNO 
         Alignment       =   1  'Right Justify
         Height          =   405
         Left            =   360
         RightToLeft     =   -1  'True
         TabIndex        =   59
         Top             =   600
         Width           =   375
      End
      Begin VB.Label Label25 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C0FFC0&
         Caption         =   "Â·  —Ìœ «·€«¡  Â–Â «·«” „«—…  (‰ / ﬂ) "
         Height          =   255
         Left            =   600
         RightToLeft     =   -1  'True
         TabIndex        =   62
         Top             =   720
         Width           =   2655
      End
   End
   Begin MSDBCtls.DBCombo M_PER_PBLSHR 
      Bindings        =   "PERIOD1.frx":27D1
      Height          =   315
      Left            =   14160
      TabIndex        =   57
      Top             =   5280
      Width           =   4095
      _ExtentX        =   7223
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "AUT_NAM"
      BoundColumn     =   "AUT_NO"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSRDC.MSRDC CODING12 
      Height          =   330
      Left            =   9360
      Top             =   8760
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
      RecordSource    =   "SELECT *FROM VIEW_CODING12"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "CODING12"
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
   Begin MSRDC.MSRDC CODING13 
      Height          =   330
      Left            =   8280
      Top             =   8880
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
      RecordSource    =   "SELECT * FROM VIEW_CODING13"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "CODING1"
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
   Begin VB.TextBox M_PER_TEL 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   1200
      RightToLeft     =   -1  'True
      TabIndex        =   51
      Top             =   840
      Width           =   2415
   End
   Begin VB.TextBox M_PER_ADRS 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   12960
      RightToLeft     =   -1  'True
      TabIndex        =   49
      Top             =   840
      Width           =   5415
   End
   Begin MSRDC.MSRDC period_t 
      Height          =   330
      Left            =   4560
      Top             =   8760
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
      RecordSource    =   "select * FROM PERIOD order by per_per_no"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "period_t"
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
   Begin VB.CommandButton Command8 
      Caption         =   "«·»ÕÀ »«·⁄‰Ê«‰"
      Height          =   615
      Left            =   120
      RightToLeft     =   -1  'True
      TabIndex        =   46
      Top             =   5400
      Width           =   735
   End
   Begin VB.CommandButton Command4 
      BackColor       =   &H008080FF&
      Caption         =   " ”ÃÌ·"
      Height          =   615
      Left            =   120
      MaskColor       =   &H000080FF&
      TabIndex        =   45
      Top             =   1800
      Width           =   735
   End
   Begin VB.CommandButton Command5 
      Caption         =   "”«»ﬁ"
      Height          =   615
      Left            =   120
      TabIndex        =   44
      Top             =   3960
      Width           =   735
   End
   Begin VB.CommandButton Command6 
      Caption         =   "·«Õ‹‹ﬁ"
      Height          =   615
      Left            =   120
      TabIndex        =   43
      Top             =   4680
      Width           =   735
   End
   Begin VB.CommandButton Command7 
      Caption         =   "«·€‹‹«¡"
      Height          =   615
      Left            =   120
      TabIndex        =   42
      Top             =   3240
      Width           =   735
   End
   Begin VB.CommandButton Command10 
      BackColor       =   &H80000007&
      Caption         =   "»Õ‹‹À"
      Height          =   615
      Left            =   120
      TabIndex        =   41
      Top             =   2520
      Width           =   735
   End
   Begin VB.CommandButton Command11 
      Caption         =   "«÷«›…"
      Height          =   615
      Left            =   120
      RightToLeft     =   -1  'True
      TabIndex        =   40
      Top             =   960
      Width           =   735
   End
   Begin VB.ComboBox M_PER_UTILES 
      Height          =   315
      ItemData        =   "PERIOD1.frx":27E7
      Left            =   2040
      List            =   "PERIOD1.frx":27F4
      RightToLeft     =   -1  'True
      TabIndex        =   39
      Top             =   7920
      Width           =   1215
   End
   Begin VB.TextBox m_per_p 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   16680
      RightToLeft     =   -1  'True
      TabIndex        =   37
      Top             =   7920
      Width           =   1695
   End
   Begin VB.TextBox m_per_amnt 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   2160
      RightToLeft     =   -1  'True
      TabIndex        =   35
      Top             =   7320
      Width           =   1215
   End
   Begin VB.TextBox m_per_dte 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   16680
      RightToLeft     =   -1  'True
      TabIndex        =   33
      Top             =   7320
      Width           =   1695
   End
   Begin VB.TextBox m_per_fax 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   1320
      RightToLeft     =   -1  'True
      TabIndex        =   31
      Top             =   6480
      Width           =   3255
   End
   Begin VB.TextBox m_per_rdmd 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   17040
      RightToLeft     =   -1  'True
      TabIndex        =   29
      Top             =   6480
      Width           =   1335
   End
   Begin VB.ComboBox m_per_lang 
      Height          =   315
      ItemData        =   "PERIOD1.frx":2805
      Left            =   1920
      List            =   "PERIOD1.frx":2818
      RightToLeft     =   -1  'True
      TabIndex        =   27
      Top             =   5880
      Width           =   1575
   End
   Begin VB.TextBox m_per_prix 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   4080
      RightToLeft     =   -1  'True
      TabIndex        =   25
      Top             =   5880
      Width           =   975
   End
   Begin MSDBCtls.DBCombo m_per_typ1 
      Bindings        =   "PERIOD1.frx":282A
      Height          =   315
      Left            =   15840
      TabIndex        =   23
      Top             =   5880
      Width           =   2535
      _ExtentX        =   4471
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSDBCtls.DBCombo m_per_freq 
      Bindings        =   "PERIOD1.frx":2841
      Height          =   315
      Left            =   1200
      TabIndex        =   21
      Top             =   5400
      Width           =   3015
      _ExtentX        =   5318
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox m_txt_presid 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   14880
      RightToLeft     =   -1  'True
      TabIndex        =   17
      Top             =   4320
      Width           =   3735
   End
   Begin VB.TextBox m_txt_tah1 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   1200
      RightToLeft     =   -1  'True
      TabIndex        =   15
      Top             =   3480
      Width           =   4215
   End
   Begin VB.TextBox m_txt_tahrir 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   14880
      RightToLeft     =   -1  'True
      TabIndex        =   13
      Top             =   3480
      Width           =   3735
   End
   Begin VB.TextBox m_txt_moass 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   1200
      RightToLeft     =   -1  'True
      TabIndex        =   11
      Top             =   2760
      Width           =   4215
   End
   Begin VB.TextBox m_txt_direct 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   14880
      RightToLeft     =   -1  'True
      TabIndex        =   9
      TabStop         =   0   'False
      Top             =   2760
      Width           =   3735
   End
   Begin MSDBCtls.DBCombo M_PER_GEO1 
      Bindings        =   "PERIOD1.frx":2858
      Height          =   315
      Left            =   1200
      TabIndex        =   7
      Top             =   1440
      Width           =   3495
      _ExtentX        =   6165
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_NAME"
      BoundColumn     =   "SUB_NO"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSDBCtls.DBCombo M_PER_GEO 
      Bindings        =   "PERIOD1.frx":286C
      Height          =   315
      Left            =   14160
      TabIndex        =   5
      Top             =   1440
      Width           =   3615
      _ExtentX        =   6376
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_NAME"
      BoundColumn     =   "SUB_NO"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox m_per_name 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   1920
      RightToLeft     =   -1  'True
      TabIndex        =   3
      Top             =   240
      Width           =   5655
   End
   Begin VB.TextBox M_PER_NO 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   375
      Left            =   17760
      RightToLeft     =   -1  'True
      TabIndex        =   1
      Top             =   240
      Width           =   735
   End
   Begin MSRDC.MSRDC v_form1 
      Height          =   375
      Left            =   5520
      Top             =   8760
      Visible         =   0   'False
      Width           =   2775
      _ExtentX        =   4895
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
      RecordSource    =   "select * from pays_form  ORDER BY sub_name"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "v_form1"
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
   Begin MSRDC.MSRDC view_form 
      Height          =   330
      Left            =   1680
      Top             =   8760
      Visible         =   0   'False
      Width           =   3015
      _ExtentX        =   5318
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
      RecordSource    =   "select * from pay_form"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "view_from"
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
      Left            =   7080
      Top             =   8760
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
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
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
   Begin MSRDC.MSRDC auther1 
      Height          =   330
      Left            =   -120
      Top             =   8760
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
      Connect         =   " "
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
   Begin VB.Label Label28 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "website"
      Height          =   255
      Left            =   5160
      RightToLeft     =   -1  'True
      TabIndex        =   70
      Top             =   2040
      Width           =   975
   End
   Begin VB.Label Label27 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "email :"
      Height          =   255
      Left            =   18240
      RightToLeft     =   -1  'True
      TabIndex        =   68
      Top             =   2040
      Width           =   975
   End
   Begin VB.Label Label26 
      Alignment       =   1  'Right Justify
      Caption         =   "«·»ÕÀ : "
      Height          =   255
      Left            =   3960
      RightToLeft     =   -1  'True
      TabIndex        =   64
      Top             =   4800
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.Label Label23 
      Alignment       =   1  'Right Justify
      BackColor       =   &H008080FF&
      Caption         =   "«· ·›Ê‰"
      Height          =   375
      Left            =   3600
      RightToLeft     =   -1  'True
      TabIndex        =   50
      Top             =   840
      Width           =   975
   End
   Begin VB.Label Label22 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«·⁄‰Ê«‰"
      Height          =   255
      Left            =   18360
      RightToLeft     =   -1  'True
      TabIndex        =   48
      Top             =   840
      Width           =   975
   End
   Begin VB.Shape Shape6 
      BorderWidth     =   2
      Height          =   6255
      Left            =   0
      Top             =   840
      Width           =   975
   End
   Begin VB.Label Label21 
      Alignment       =   1  'Right Justify
      BackColor       =   &H008080FF&
      Caption         =   "„⁄ „œ… ›Ì «·„—ﬂ“"
      Height          =   255
      Left            =   3240
      RightToLeft     =   -1  'True
      TabIndex        =   38
      Top             =   7920
      Width           =   1575
   End
   Begin VB.Label Label20 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "ﬁÌ„… «·«” —«ﬂ ··„ƒ””« "
      Height          =   495
      Left            =   18480
      RightToLeft     =   -1  'True
      TabIndex        =   36
      Top             =   7800
      Width           =   975
   End
   Begin VB.Label Label19 
      Alignment       =   1  'Right Justify
      BackColor       =   &H008080FF&
      Caption         =   "ﬁÌ„… «·«‘ —«ﬂ ··«›—«œ"
      Height          =   375
      Left            =   3360
      RightToLeft     =   -1  'True
      TabIndex        =   34
      Top             =   7320
      Width           =   1095
   End
   Begin VB.Label Label18 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   " «—ÌŒ «· √”Ì”"
      Height          =   375
      Left            =   18360
      RightToLeft     =   -1  'True
      TabIndex        =   32
      Top             =   7320
      Width           =   1095
   End
   Begin VB.Shape Shape4 
      BorderWidth     =   2
      Height          =   1335
      Left            =   960
      Top             =   7200
      Width           =   18615
   End
   Begin VB.Label Label17 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«·›«ﬂ” :"
      Height          =   375
      Left            =   4800
      RightToLeft     =   -1  'True
      TabIndex        =   30
      Top             =   6480
      Width           =   735
   End
   Begin VB.Label Label16 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«·—œ„œ"
      Height          =   375
      Left            =   18360
      RightToLeft     =   -1  'True
      TabIndex        =   28
      Top             =   6480
      Width           =   975
   End
   Begin VB.Label Label15 
      Alignment       =   1  'Right Justify
      BackColor       =   &H008080FF&
      Caption         =   "«··€… :"
      Height          =   375
      Left            =   3480
      RightToLeft     =   -1  'True
      TabIndex        =   26
      Top             =   5880
      Width           =   495
   End
   Begin VB.Label Label14 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«·”⁄— :"
      Height          =   255
      Left            =   4560
      RightToLeft     =   -1  'True
      TabIndex        =   24
      Top             =   5880
      Width           =   975
   End
   Begin VB.Label Label13 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "ﬂÌ›Ì… «·«ﬁ ‰«¡"
      Height          =   255
      Left            =   18360
      RightToLeft     =   -1  'True
      TabIndex        =   22
      Top             =   5880
      Width           =   1215
   End
   Begin VB.Label Label12 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "Ê Ì—… «·’œÊ—"
      Height          =   255
      Left            =   3840
      RightToLeft     =   -1  'True
      TabIndex        =   20
      Top             =   5400
      Width           =   1575
   End
   Begin VB.Label Label11 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "œ«— «·‰‘—"
      Height          =   255
      Left            =   18240
      RightToLeft     =   -1  'True
      TabIndex        =   19
      Top             =   5280
      Width           =   1215
   End
   Begin VB.Shape Shape3 
      BackColor       =   &H008080FF&
      BorderWidth     =   2
      Height          =   2055
      Left            =   1080
      Top             =   5160
      Width           =   18495
   End
   Begin VB.Label Label10 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«·ÃÂ… «· Ì  ’œ— ⁄‰Â« «·œÊ—Ì…"
      Height          =   375
      Left            =   5280
      RightToLeft     =   -1  'True
      TabIndex        =   18
      Top             =   4320
      Width           =   1455
   End
   Begin VB.Label Label9 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "—∆Ì” „Ã·” «·«œ«—…:"
      Height          =   495
      Left            =   18600
      RightToLeft     =   -1  'True
      TabIndex        =   16
      Top             =   4320
      Width           =   855
   End
   Begin VB.Label Label8 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "„œÌ— «· Õ—Ì—:"
      Height          =   255
      Left            =   5400
      RightToLeft     =   -1  'True
      TabIndex        =   14
      Top             =   3480
      Width           =   975
   End
   Begin VB.Label Label7 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "—∆Ì” «· Õ—Ì— :"
      Height          =   255
      Left            =   18600
      RightToLeft     =   -1  'True
      TabIndex        =   12
      Top             =   3480
      Width           =   855
   End
   Begin VB.Label Label6 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«·„œÌ— «·„”ƒÊ· :"
      Height          =   495
      Left            =   5400
      RightToLeft     =   -1  'True
      TabIndex        =   10
      Top             =   2760
      Width           =   975
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«·„œÌ— «·⁄«„ :"
      Height          =   255
      Left            =   18600
      RightToLeft     =   -1  'True
      TabIndex        =   8
      Top             =   2760
      Width           =   855
   End
   Begin VB.Shape Shape2 
      BorderWidth     =   2
      Height          =   2655
      Left            =   960
      Top             =   2520
      Width           =   18615
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "„ﬂ«‰ «·’œÊ— - 2 : "
      Height          =   255
      Left            =   4440
      RightToLeft     =   -1  'True
      TabIndex        =   6
      Top             =   1440
      Width           =   1455
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "„ﬂ«‰ «·’œÊ— - 1:"
      BeginProperty Font 
         Name            =   "Traditional Arabic"
         Size            =   12
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   17760
      RightToLeft     =   -1  'True
      TabIndex        =   4
      Top             =   1440
      Width           =   1455
   End
   Begin VB.Shape Shape1 
      BorderWidth     =   2
      Height          =   2415
      Left            =   1080
      Top             =   120
      Width           =   18495
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«”„ «·œÊ—Ì… :"
      Height          =   375
      Left            =   7560
      RightToLeft     =   -1  'True
      TabIndex        =   2
      Top             =   240
      Width           =   975
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "—ﬁ„ «·œÊ—Ì… :"
      Height          =   255
      Left            =   18480
      RightToLeft     =   -1  'True
      TabIndex        =   0
      Top             =   240
      Width           =   975
   End
End
Attribute VB_Name = "PERIOD"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim m_tabindex As Integer
Dim mod_typ As Integer
Dim typ_serh  As Integer
Dim M_PER_DIRECT As String
Dim M_PER_TAHRIR As String
Dim M_PER_TAH1 As String
Dim M_PER_MOASS As String
Dim M_PER_pub As String
Dim m_typ_serh As Integer
Dim M_PER_PRESID As String
Dim m_disp As Integer





Function disp_fld()
 If Not period_t.Resultset.EOF Or Not period_t.Resultset.BOF Then
     If Not IsNull(period_t.Resultset![per_per_no]) Then
       M_PER_NO.Text = period_t.Resultset![per_per_no]
      Else
       M_PER_NO.Text = ""
      End If
      If Not IsNull(period_t.Resultset![per_per_na]) Then
          m_per_name.Text = period_t.Resultset![per_per_na]
      Else
        m_per_name.Text = ""
      End If
      If Not IsNull(period_t.Resultset![per_ADRS]) Then
          M_PER_ADRS.Text = period_t.Resultset![per_ADRS]
      Else
        M_PER_ADRS.Text = ""
      End If
     If Not IsNull(period_t.Resultset![per_TEL]) Then
        M_PER_TEL.Text = period_t.Resultset![per_TEL]
      Else
        M_PER_TEL.Text = ""
      End If

If Not IsNull(period_t.Resultset![per_email]) Then
          m_per_email.Text = period_t.Resultset![per_email]
      Else
        m_per_email.Text = ""
      End If
      If Not IsNull(period_t.Resultset![per_website]) Then
          m_per_website.Text = period_t.Resultset![per_website]
      Else
        m_per_website.Text = ""
      End If
    If Not IsNull(period_t.Resultset![per_geo]) Then
          M_PER_GEO.BoundText = period_t.Resultset![per_geo]
      Else
         M_PER_GEO.BoundText = ""
      End If
      If Not IsNull(period_t.Resultset![per_geo1]) Then
          M_PER_GEO1.BoundText = period_t.Resultset![per_geo1]
      Else
         M_PER_GEO1.BoundText = ""
      End If
        If Not IsNull(period_t.Resultset![per_prix]) Then
          m_per_prix.Text = period_t.Resultset![per_prix]
      Else
        m_per_prix.Text = ""
      End If
         If Not IsNull(period_t.Resultset![per_fax]) Then
          m_per_fax.Text = period_t.Resultset![per_fax]
      Else
        m_per_fax.Text = ""
      End If
       If Not IsNull(period_t.Resultset![per_rdmd]) Then
          m_per_rdmd.Text = period_t.Resultset![per_rdmd]
      Else
          m_per_rdmd.Text = ""
          
      End If
      If Not IsNull(period_t.Resultset![per_typ1]) Then
          m_per_typ1.BoundText = "13" + period_t.Resultset![per_typ1]
      Else
         m_per_typ1.BoundText = ""
      End If
     ' If Not IsNull(period_t.Resultset![pER_PUB_LO]) Then
     '     M_PER_pub.BoundText = period_t.Resultset![pER_PUB_LO]
     ' Else
     '    M_PER_pub.BoundText = ""
     ' End If
        If Not IsNull(period_t.Resultset![per_freq]) Then
          m_per_freq.BoundText = period_t.Resultset![per_freq]
      Else
          m_per_freq.BoundText = ""
      End If
      If Not IsNull(period_t.Resultset![per_LANG]) Then
          m_per_lang.Text = period_t.Resultset![per_LANG]
      Else
          m_per_lang.Text = ""
          
      End If
       If Not IsNull(period_t.Resultset![per_AMNT]) Then
          m_per_amnt.Text = period_t.Resultset![per_AMNT]
      Else
          m_per_amnt.Text = ""
          
      End If
        If Not IsNull(period_t.Resultset![per_PRIX1]) Then
          m_per_p.Text = period_t.Resultset![per_PRIX1]
      Else
          m_per_p.Text = ""
          
      End If
        If Not IsNull(period_t.Resultset![per_DTE]) Then
          m_per_dte.Text = period_t.Resultset![per_DTE]
      Else
          m_per_dte.Text = ""
          
      End If
        If Not IsNull(period_t.Resultset![per_LANG]) Then
          m_per_lang.Text = period_t.Resultset![per_LANG]
      Else
          m_per_lang.Text = ""
          
      End If
      
      If Not IsNull(period_t.Resultset![per_UTILS]) Then
          M_PER_UTILES.ListIndex = period_t.Resultset![per_UTILS]
      Else
          M_PER_UTILES.ListIndex = 0
          
      End If
     m_disp = 2
     If Not IsNull(period_t.Resultset![pER_DIRCT]) Then
           M_PER_DIRECT = period_t.Resultset![pER_DIRCT]
           v_form1.sql = "EXEC SERH_SUB_NAME " & "'" & M_PER_DIRECT & "'"
           v_form1.Refresh
           
             If Not v_form1.Resultset.EOF And Not v_form1.Resultset.BOF Then
               m_txt_direct.Text = v_form1.Resultset![sub_name]
               Else
                 m_txt_direct.Text = ""
             End If
       Else
        m_txt_direct.Text = ""
    End If
    m_disp = 2
              
     If Not IsNull(period_t.Resultset![pER_TAHRIR]) Then
           M_PER_TAHRIR = period_t.Resultset![pER_TAHRIR]
           v_form1.sql = "EXEC SERH_SUB_NAME " & "'" & M_PER_TAHRIR & "'"
           v_form1.Refresh
           
             If Not v_form1.Resultset.EOF And Not v_form1.Resultset.BOF Then
               m_txt_tahrir.Text = v_form1.Resultset![sub_name]
               Else
                 m_txt_tahrir.Text = ""
             End If
       Else
        m_txt_tahrir.Text = ""
    End If
    m_disp = 2
        If Not IsNull(period_t.Resultset![pER_TAH1]) Then
           M_PER_TAH1 = period_t.Resultset![pER_TAH1]
           v_form1.sql = "EXEC SERH_SUB_NAME " & "'" & M_PER_TAH1 & "'"
           v_form1.Refresh
           
             If Not v_form1.Resultset.EOF And Not v_form1.Resultset.BOF Then
               m_txt_tah1.Text = v_form1.Resultset![sub_name]
               Else
                 m_txt_tah1.Text = ""
             End If
       Else
        m_txt_tah1.Text = ""
    End If
    m_disp = 2
     If Not IsNull(period_t.Resultset![pER_PRESD]) Then
           M_PER_PRESID = period_t.Resultset![pER_PRESD]
           v_form1.sql = "EXEC SERH_SUB_NAME " & "'" & M_PER_PRESID & "'"
           v_form1.Refresh
           
             If Not v_form1.Resultset.EOF And Not v_form1.Resultset.BOF Then
               m_txt_presid.Text = v_form1.Resultset![sub_name]
               Else
                 m_txt_presid.Text = ""
             End If
       Else
        m_txt_presid.Text = ""
    End If
    m_disp = 2
     If Not IsNull(period_t.Resultset![pER_MOASS]) Then
           M_PER_MOASS = period_t.Resultset![pER_MOASS]
           v_form1.sql = "EXEC SERH_SUB_NAME " & "'" & M_PER_MOASS & "'"
           v_form1.Refresh
           
             If Not v_form1.Resultset.EOF And Not v_form1.Resultset.BOF Then
               m_txt_moass.Text = v_form1.Resultset![sub_name]
               Else
                 m_txt_moass.Text = ""
             End If
       Else
        m_txt_moass.Text = ""
    End If
     m_disp = 2
              
     If Not IsNull(period_t.Resultset![pER_pub]) Then
           M_PER_pub = period_t.Resultset![pER_pub]
           v_form1.sql = "EXEC SERH_SUB_NAME " & "'" & M_PER_pub & "'"
           v_form1.Refresh
           
             If Not v_form1.Resultset.EOF And Not v_form1.Resultset.BOF Then
               m_txt_pub.Text = v_form1.Resultset![sub_name]
               Else
                 m_txt_pub.Text = ""
             End If
       Else
        m_txt_pub.Text = ""
    End If
     If Not IsNull(period_t.Resultset![PER_PBLSHR]) Then
         M_PER_PBLSHR.BoundText = period_t.Resultset![PER_PBLSHR]
       Else
        M_PER_PBLSHR.Text = ""
    End If
 End If
End Function

Private Sub Command1_Click()
Unload PERIOD
End Sub

Private Sub Command10_Click()
Frame2.Visible = True
m_ist_no.Text = ""
m_ist_no.SetFocus


End Sub

Private Sub Command11_Click()
 period_t.sql = "select * from period order by per_per_no"
 period_t.Refresh
 
  period_t.Resultset.MoveLast
 If Not period_t.Resultset.EOF Then
   m_no = period_t.Resultset![per_per_no]
   m_no = m_no + 1
  Else
    m_no = 1
 End If
 
 M_PER_NO.Text = m_no
 m_per_name.SetFocus
 
   M_PER_ADRS.Text = ""
       M_PER_TEL.Text = ""
        m_per_name.Text = ""
         M_PER_GEO.BoundText = ""
         M_PER_GEO1.BoundText = ""
        m_per_prix.Text = ""
        m_per_fax.Text = ""
          m_per_rdmd.Text = ""
         m_per_typ1.BoundText = ""
          m_per_freq.BoundText = ""
          m_per_lang.Text = ""
          m_per_amnt.Text = ""
          m_per_p.Text = ""
          m_per_dte.Text = ""
          m_per_lang.Text = ""
                 m_txt_direct.Text = ""
                 m_txt_tahrir.Text = ""
                 m_txt_tah1.Text = ""
                 m_txt_presid.Text = ""
                 m_txt_moass.Text = ""
                 M_PER_PBLSHR.Text = ""

mod_typ = 1
End Sub

Private Sub Command12_Click()
'Dim cn As New rdoConnection
Dim sql As String
Const None As String = ""
 Frame2.Visible = False
Command10.SetFocus

period_t.sql = "exec SERCH_period " & "'" & m_ist_no.Text & "'"
period_t.Refresh
typ_serh = 2
If Not period_t.Resultset.EOF Or Not period_t.Resultset.BOF Then
 Call disp_fld
 Else
 MsgBox " Â–««·—ﬁ„ €Ì— „ÊÃÊœ ......û"
End If

End Sub

Private Sub Command13_Click()
 Frame2.Visible = False
Command10.SetFocus

End Sub

Private Sub Command2_Click()
'Dim cn As New rdoConnection
Dim sql As String
Const None As String = ""
 Frame1.Visible = False
Command7.SetFocus

If M_YESNO = "‰" Or M_YESNO = "Y" Or M_YESNO = "y" Then
'   cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'    & "driver={SQL Server};database=macnz;" _
'    & "DSN='';"
'
'    cn.CursorDriver = rdUseOdbc
'   cn.EstablishConnection rdDriverNoPrompt
    sql = "exec del_period " & M_PER_NO.Text
    cn.Execute sql, rdExecDirect
End If

End Sub

Private Sub Command3_Click()
Frame1.Visible = False
Command7.SetFocus


End Sub

Private Sub Command4_Click()
' Dim cn As New rdoConnection
 Dim sql As String
 'Dim m_date As Date

 'm_date = Text2.Text
      ' cn.Connect = "uid=;pwd=;server=SEQUEL;" _
      '     & "driver={SQL Server};database=macnz;" _
      '     & "DSN='';"
      '      cn.CursorDriver = rdUseOdbc
      '     cn.EstablishConnection rdDriverNoPrompt
      m_per_loc = 0
If mod_typ = 1 Then
   sql = "execute INSR_period " & "'" & M_PER_NO.Text & "'" & "," & "'" & m_per_name.Text & "'" & "," _
        & "'" & m_per_loc & "'" & "," & "'" & m_per_lang.Text & "'" & "," _
        & "'" & m_per_rdmd.Text & "'" & "," & "'" & m_typ & "'" & "," & "'" & M_PER_GEO.BoundText & "'" & "," _
        & "'" & M_PER_GEO1.BoundText & "'" & "," & "'" & Mid(m_per_typ1.BoundText, 3, 2) & "'" & "," _
        & "'" & m_per_freq.BoundText & "'" & "," & "'" & M_PER_ADRS.Text & "'" & "," _
        & "'" & M_PER_TEL.Text & "'" & "," & "'" & m_per_prix.Text & "'" & "," _
        & "'" & M_PER_PBLSHR.BoundText & "'" & "," & "'" & M_PER_TAHRIR & "'" & "," _
        & "'" & M_PER_MOASS & "'" & "," & "'" & M_PER_TAH1 & "'" & "," _
        & "'" & M_PER_DIRECT & "'" & "," & "'" & M_PER_PRESID & "'" & "," _
        & "'" & M_PER_UTILES.ListIndex & "'" & "," & "'" & m_per_fax.Text & "'" & "," _
        & "'" & Format(m_per_dte.Text, "DD/MM/YY") & "'" & "," & "'" & m_per_amnt.Text & "'" & "," _
        & "'" & m_per_p.Text & "'" & "," & "'" & m_per_email.Text & "'" & "," & "'" & m_per_website.Text & "'" & "," _
        & "'" & M_PER_pub & "'"
        
    cn.Execute sql, rdExecDirect
         mod_typ = 2
ElseIf mod_typ = 2 Then
 m_typ = 0
 m_per_loc = 0
 sql = "execute UPD_period " & "'" & M_PER_NO.Text & "'" & "," & "'" & m_per_name.Text & "'" & "," _
        & "'" & m_per_loc & "'" & "," & "'" & m_per_lang.Text & "'" & "," _
        & "'" & m_per_rdmd.Text & "'" & "," & "'" & m_typ & "'" & "," & "'" & M_PER_GEO.BoundText & "'" & "," _
        & "'" & M_PER_GEO1.BoundText & "'" & "," & "'" & Mid(m_per_typ1.BoundText, 3, 2) & "'" & "," _
        & "'" & m_per_freq.BoundText & "'" & "," & "'" & M_PER_ADRS.Text & "'" & "," _
        & "'" & M_PER_TEL.Text & "'" & "," & "'" & m_per_prix.Text & "'" & "," _
        & "'" & M_PER_PBLSHR.BoundText & "'" & "," & "'" & M_PER_TAHRIR & "'" & "," _
        & "'" & M_PER_MOASS & "'" & "," & "'" & M_PER_TAH1 & "'" & "," _
        & "'" & M_PER_DIRECT & "'" & "," & "'" & M_PER_PRESID & "'" & "," _
        & "'" & M_PER_UTILES.ListIndex & "'" & "," & "'" & m_per_fax.Text & "'" & "," _
        & "'" & Format(m_per_dte.Text, "DD/MM/YY") & "'" & "," & "'" & m_per_amnt.Text & "'" & "," _
 & "'" & m_per_p.Text & "'" & "," & "'" & m_per_email.Text & "'" & "," & "'" & m_per_website.Text & "'" & "," _
 & "'" & M_PER_pub & "'"
    cn.Execute sql, rdExecDirect
         
End If
If Form6.Visible = True Then
   Form6.period1.Refresh
End If


End Sub


Private Sub Command5_Click()
m_no = M_PER_NO.Text
m_no = m_no - 1
If m_no > 1 Then
period_t.sql = "exec SERCH_period " & "'" & m_no & "'"
period_t.Refresh
typ_serh = 2
If Not period_t.Resultset.EOF Or Not period_t.Resultset.BOF Then
 Call disp_fld
 Else
 MsgBox " Â–««·—ﬁ„ €Ì— „ÊÃÊœ ......û"
End If
End If
End Sub

Private Sub Command6_Click()
m_no = M_PER_NO.Text
m_no = m_no + 1
period_t.sql = "exec SERCH_period " & "'" & m_no & "'"
period_t.Refresh
typ_serh = 2
If Not period_t.Resultset.EOF Or Not period_t.Resultset.BOF Then
 Call disp_fld
 Else
 MsgBox " Â–««·—ﬁ„ €Ì— „ÊÃÊœ ......û"
End If
End Sub

Private Sub Command7_Click()
Frame1.Visible = True
M_YESNO.SetFocus
End Sub

Private Sub Command8_Click()
  m_typ_serh = 3
     Text4.Visible = True
      Label26.Visible = True
      Text4.SetFocus
      Text4.Text = ""
End Sub

Private Sub DBList1_KeyDown(KeyCode As Integer, Shift As Integer)
  If KeyCode = vbKeyF8 Then
      m_typ_serh = 1
     Text4.Visible = True
      Label26.Visible = True
      Text4.SetFocus
      Text4.Text = ""
  '     SendKeys "{up}"
           m_bookmark = 1
ElseIf KeyCode = vbKeyF9 Then
      m_typ_serh = 2
     Text4.Visible = True
      Label26.Visible = True
      Text4.SetFocus
      Text4.Text = ""
  '       SendKeys "{up}"
ElseIf KeyCode = vbKeyDown Or KeyCode = vbKeyPageDown Or KeyCode = vbKeyEnd Then
   m_bookmark = 2
  End If

End Sub

Private Sub DBList1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  view_form.Resultset.Bookmark = DBList1.SelectedItem
  m_no = view_form.Resultset![sub_typ] + view_form.Resultset![sub_no]
  m_desc = view_form.Resultset![sub_name]
    DBList1.Visible = False
    
    m_disp = 2
    Select Case m_tabindex
      Case 9
        m_txt_direct.Text = m_desc
       M_PER_DIRECT = m_no
         m_txt_tahrir.SetFocus
         
    Case 13
        m_txt_tahrir.Text = m_desc
         M_PER_TAHRIR = m_no
          m_txt_presid.SetFocus
     Case 17
        m_txt_presid.Text = m_desc
        M_PER_PRESID = m_no
         m_txt_moass.SetFocus
        
     Case 11
        m_txt_moass.Text = m_desc
         M_PER_MOASS = m_no
         m_txt_tah1.SetFocus
     Case 15
      m_txt_tah1.Text = m_desc
        M_PER_TAH1 = m_no
         m_txt_pub.SetFocus
        Case 71
      m_txt_pub.Text = m_desc
          M_PER_pub = m_no
         M_PER_PBLSHR.SetFocus
    End Select
  
 
 
  
ElseIf KeyAscii = 27 Then
 
     
    DBList1.Visible = False
'm_disp = 2
    
   Select Case m_tabindex
      Case 9
        m_txt_direct.SetFocus
        m_txt_direct.Text = ""
    Case 13
        m_txt_tahrir.SetFocus
        m_txt_tahrir.Text = ""
     Case 17
        m_txt_presid.Text = ""
        m_txt_presid.SetFocus
        
     Case 11
        m_txt_moass.SetFocus
        m_txt_moass.Text = ""
        
     Case 15
      m_txt_tah1.SetFocus
      m_txt_tah1.Text = ""
     Case 71
      m_txt_pub.SetFocus
      m_txt_pub.Text = ""
    End Select
     

End If


End Sub

Private Sub DBList2_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
   period_t.Resultset.Bookmark = DBList2.SelectedItem
    m_no = period_t.Resultset![per_per_no]
   period_t.sql = "exec SERCH_period " & "'" & m_no & "'"
   period_t.Refresh
   typ_serh = 2
   If Not period_t.Resultset.EOF Or Not period_t.Resultset.BOF Then
     Call disp_fld
    Else
     MsgBox " Â–««·—ﬁ„ €Ì— „ÊÃÊœ ......û"
    End If
     DBList2.Visible = False
      Text4.Visible = False
      Label26.Visible = False
     
ElseIf KeyAscii = 27 Then
      DBList2.Visible = False
      Text4.Visible = False
      Label26.Visible = False
      
      
      
      
    
End If
End Sub

Private Sub Form_Load()
mod_typ = 2
typ_serh = 1
m_disp = 1
End Sub

Private Sub m_ist_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Command12.SetFocus
  
ElseIf KeyAscii = 27 Then
 Frame2.Visible = False
Command10.SetFocus
End If


End Sub

Private Sub M_PER_ADRS_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_PER_TEL.SetFocus
End If
End Sub

Private Sub m_per_amnt_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_per_p.SetFocus
End If

End Sub

Private Sub m_per_dte_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_per_amnt.SetFocus
End If

End Sub

Private Sub m_per_email_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_per_website.SetFocus
End If
End Sub

Private Sub m_per_fax_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_per_dte.SetFocus
End If

End Sub

Private Sub m_per_freq_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_per_typ1.SetFocus
 SendKeys "{f4}"
End If
End Sub

Private Sub M_PER_GEO_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_PER_GEO1.SetFocus
 SendKeys "{f4}"
End If
End Sub

Private Sub M_PER_GEO1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_per_email.SetFocus
End If
End Sub

Private Sub m_per_lang_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_per_rdmd.SetFocus
End If
End Sub

Private Sub M_PER_NAME_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_PER_ADRS.SetFocus
 
End If
End Sub


Private Sub M_PER_NO_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_per_name.SetFocus
End If
End Sub

Private Sub m_per_p_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_PER_UTILES.SetFocus
 SendKeys "{F4}"
End If

End Sub

Private Sub m_per_prix_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_per_lang.SetFocus
 SendKeys "{f4}"
End If
End Sub

Private Sub m_per_pub_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_per_freq.SetFocus
 SendKeys "{f4}"
End If
End Sub

Private Sub m_per_rdmd_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_per_fax.SetFocus
End If

End Sub

Private Sub M_PER_TEL_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_PER_GEO.SetFocus
 SendKeys "{f4}"
End If
End Sub

Private Sub m_per_typ1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_per_prix.SetFocus
 
End If
End Sub

Private Sub m_per_website_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_txt_direct.SetFocus
 End If
End Sub

Private Sub m_txt_direct_Change()
On Error Resume Next

If Not Trim(m_txt_direct.Text) = "" Then
If m_disp = 1 Then
m_tabindex = 9
  If DBList1.Visible = False Then
   
   DBList1.Visible = True
   DBList1.Left = 6480
   DBList1.Top = 3240
   
   
  End If
  
         m_desc = m_txt_direct.Text
         m_len = Len(Trim(m_txt_direct))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        view_form.Refresh
   Else
    m_disp = 1
    
   End If
End If
End Sub

Private Sub m_txt_direct_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not m_txt_direct.Text = "" Then
  DBList1.SetFocus
   SendKeys "{UP}"
End If

End Sub

Private Sub m_txt_direct_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_tabindex = 9
  DBList1.Visible = True
   DBList1.SetFocus
  SendKeys "{up}"
End If
End Sub


Private Sub m_txt_moass_Change()
On Error Resume Next
If m_disp = 1 Then
If Not Trim(m_txt_moass.Text) = "" Then
  If DBList1.Visible = False Then
   DBList1.Visible = True
    DBList1.Left = 1200
   DBList1.Top = 3120
  
  End If
    m_tabindex = 11
         m_desc = m_txt_moass.Text
         m_len = Len(Trim(m_txt_moass))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        view_form.Refresh
End If
Else
 m_disp = 1
End If
End Sub

Private Sub m_txt_moass_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not m_txt_moass.Text = "" Then
  DBList1.SetFocus
   SendKeys "{UP}"
End If
End Sub

Private Sub m_txt_moass_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_tabindex = 11
  DBList1.Visible = True
  DBList1.SetFocus
  SendKeys "{up}"
End If
End Sub

Private Sub m_txt_pblshr_Change()
If KeyAscii = 13 Then
  m_tabindex = 19
  DBList1.Visible = True
   DBList1.SetFocus
  SendKeys "{up}"
End If
End Sub

Private Sub m_txt_presid_Change()
On Error Resume Next
If m_disp = 1 Then

If Not Trim(m_txt_presid.Text) = "" Then
  If DBList1.Visible = False Then
   DBList1.Visible = True
   DBList1.Left = 6480
   DBList1.Top = 4680
  End If
    m_tabindex = 17
         m_desc = m_txt_presid.Text
         m_len = Len(Trim(m_txt_presid))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        view_form.Refresh
End If
Else
 m_disp = 1
 End If
End Sub

Private Sub m_txt_presid_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not m_txt_presid.Text = "" Then
  DBList1.SetFocus
   SendKeys "{UP}"
End If
End Sub

Private Sub m_txt_presid_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_tabindex = 15
  DBList1.Visible = True
   DBList1.SetFocus
  SendKeys "{up}"
End If
End Sub

Private Sub m_txt_pub_Change()
On Error Resume Next
If m_disp = 1 Then
If Not Trim(m_txt_pub.Text) = "" Then
  If DBList1.Visible = False Then
   DBList1.Visible = True
    DBList1.Left = 1080
   DBList1.Top = 4680
  
  End If
   m_tabindex = 71
         m_desc = m_txt_pub.Text
         m_len = Len(Trim(m_txt_pub))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        view_form.Refresh
End If
Else
 m_disp = 1
End If
End Sub

Private Sub m_txt_pub_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not m_txt_pub.Text = "" Then
  DBList1.SetFocus
   SendKeys "{UP}"
End If
End Sub

Private Sub m_txt_tah1_Change()
On Error Resume Next
If m_disp = 1 Then
If Not Trim(m_txt_tah1.Text) = "" Then
  If DBList1.Visible = False Then
   DBList1.Visible = True
    DBList1.Left = 1200
   DBList1.Top = 3840
  
  End If
   m_tabindex = 15
         m_desc = m_txt_tah1.Text
         m_len = Len(Trim(m_txt_tah1))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        view_form.Refresh
End If
Else
 m_disp = 1
End If
End Sub

Private Sub m_txt_tah1_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not m_txt_tah1.Text = "" Then
  DBList1.SetFocus
   SendKeys "{UP}"
End If
End Sub

Private Sub m_txt_tah1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_tabindex = 15
  DBList1.Visible = True
   DBList1.SetFocus
  SendKeys "{up}"
End If
End Sub

Private Sub m_txt_tahrir_Change()
On Error Resume Next
If m_disp = 1 Then

If Not Trim(m_txt_tahrir.Text) = "" Then
  If DBList1.Visible = False Then
   DBList1.Visible = True
    DBList1.Left = 6360
   DBList1.Top = 3840
  
  End If
    m_tabindex = 13
         m_desc = m_txt_tahrir.Text
         m_len = Len(Trim(m_txt_tahrir))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        view_form.Refresh
End If
Else
 m_disp = 1
End If

End Sub

Private Sub m_txt_tahrir_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not m_txt_tahrir.Text = "" Then
  DBList1.SetFocus
   SendKeys "{UP}"
End If

End Sub

Private Sub m_txt_tahrir_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_tabindex = 13
  DBList1.Visible = True
   DBList1.SetFocus
  SendKeys "{up}"
End If
End Sub

Private Sub M_YESNO_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 Command2.SetFocus
 
ElseIf KEYSCII = 27 Then
Frame1.Visible = False
Command7.SetFocus

End If

End Sub

Private Sub Text4_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
    If m_typ_serh = 1 Then
         m_desc = Text4.Text
         m_len = Len(Trim(Text4))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
         DBList1.Refresh
         DBList1.SetFocus
         SendKeys "{up}"
         m_bookmark = 1
       '  SendKeys "{UP}"
       ' DBList12.SelectedItem = DBList12.VisibleItems(1)
        
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If
         
        
       Text4.Visible = False
      Label26.Visible = False
 ElseIf m_typ_serh = 2 Then
    m_bookmark = 1
         m_desc = Text4.Text
         m_len = Len(Trim(Text4))
         view_form.sql = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
        DBList1.Refresh
        DBList1.SetFocus
       '  SendKeys "{UP}"
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If

       Text4.Visible = False
      Label26.Visible = False
  ElseIf m_typ_serh = 3 Then
       
      m_bookmark = 1
         m_desc = Text4.Text
         m_len = Len(Trim(Text4))
         period_t.sql = "execute serh_period1 " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         period_t.Refresh
         DBList2.Visible = True
        DBList2.Refresh
        DBList2.SetFocus
        SendKeys "{up}"
       '  SendKeys
    End If
 ElseIf KeyAscii = 27 Then
       DBList1.SetFocus
      Text4.Visible = False
      Label26.Visible = False
   
  End If

End Sub
