VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form coding 
   BackColor       =   &H0086C8EC&
   Caption         =   "«·„ﬂ‰“ «·‘ﬂ·Ì"
   ClientHeight    =   9645
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   20025
   LinkTopic       =   "Form3"
   Moveable        =   0   'False
   RightToLeft     =   -1  'True
   ScaleHeight     =   9645
   ScaleWidth      =   20025
   Begin MSDataListLib.DataList DataList2 
      Bindings        =   "coding.frx":0000
      Height          =   2790
      Left            =   2400
      TabIndex        =   40
      Top             =   480
      Visible         =   0   'False
      Width           =   6615
      _ExtentX        =   11668
      _ExtentY        =   4921
      _Version        =   393216
      ListField       =   "SUB_NAME"
      BoundColumn     =   "SUB_NO"
      RightToLeft     =   -1  'True
   End
   Begin VB.CommandButton Command9 
      Caption         =   " ﬁœ„"
      Height          =   435
      Left            =   7680
      RightToLeft     =   -1  'True
      TabIndex        =   38
      Top             =   4380
      Visible         =   0   'False
      Width           =   915
   End
   Begin VB.CommandButton Command8 
      Caption         =   " —«Ã⁄"
      Height          =   375
      Left            =   9240
      RightToLeft     =   -1  'True
      TabIndex        =   37
      Top             =   4320
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.CommandButton Command7 
      BackColor       =   &H002972B4&
      Caption         =   "«·„·›«  «·«÷«›Ì… ··«œŒ«·"
      Height          =   495
      Left            =   9840
      Style           =   1  'Graphical
      TabIndex        =   36
      Top             =   7440
      Width           =   1815
   End
   Begin VB.CommandButton Command6 
      BackColor       =   &H002972B4&
      Caption         =   "Œ—ÊÃ"
      Height          =   495
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   35
      Top             =   7440
      Width           =   1695
   End
   Begin VB.TextBox Text6 
      Alignment       =   2  'Center
      BackColor       =   &H002972B4&
      ForeColor       =   &H00000000&
      Height          =   285
      Left            =   15720
      TabIndex        =   34
      Top             =   8520
      Visible         =   0   'False
      Width           =   1335
   End
   Begin MSRDC.MSRDC word 
      Height          =   330
      Left            =   8640
      Top             =   8640
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
      Connect         =   " "
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
      BackColor       =   &H00D8F9FE&
      Height          =   285
      Left            =   120
      TabIndex        =   31
      Top             =   960
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.TextBox deb_dte 
      BackColor       =   &H00D8F9FE&
      Height          =   285
      Left            =   120
      TabIndex        =   30
      Top             =   480
      Visible         =   0   'False
      Width           =   1095
   End
   Begin MSRDC.MSRDC tmp_msdrc 
      Height          =   330
      Left            =   5160
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
      Connect         =   " "
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
      Left            =   7920
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
      Connect         =   " "
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
      BackColor       =   &H00D8F9FE&
      Height          =   285
      Left            =   15000
      TabIndex        =   28
      Top             =   5760
      Visible         =   0   'False
      Width           =   2175
   End
   Begin MSDBCtls.DBList DBList8 
      Bindings        =   "coding.frx":0019
      Height          =   2460
      Left            =   13320
      TabIndex        =   27
      ToolTipText     =   "F8 ··»ÕÀ ›Ì «·»œ«Ì…  , F9 ··»ÕÀ ⁄‰ ﬂ·„… , ENTER ··«Œ Ì«— , ESC ··—ÃÊ⁄"
      Top             =   6120
      Visible         =   0   'False
      Width           =   4575
      _ExtentX        =   8070
      _ExtentY        =   4339
      _Version        =   393216
      BackColor       =   2716340
      ForeColor       =   -2147483640
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSRDC.MSRDC subject 
      Height          =   495
      Left            =   1320
      Top             =   8640
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
      Connect         =   " "
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
      BackColor       =   &H00D8F9FE&
      Height          =   375
      Left            =   8640
      TabIndex        =   26
      Top             =   4440
      Visible         =   0   'False
      Width           =   495
   End
   Begin MSRDC.MSRDC rel_form 
      Height          =   330
      Left            =   6600
      Top             =   8760
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
      Connect         =   " "
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
      Bindings        =   "coding.frx":0030
      Height          =   1950
      Left            =   8880
      TabIndex        =   23
      ToolTipText     =   "ENTER ·«œŒ«· «·„⁄·Ê„«  , ESC ··—ÃÊ⁄ ..."
      Top             =   5040
      Visible         =   0   'False
      Width           =   3495
      _ExtentX        =   6165
      _ExtentY        =   3440
      _Version        =   393216
      BackColor       =   14219774
      ListField       =   "m_sub_desc"
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   11.25
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSDBCtls.DBList DBList6 
      Bindings        =   "coding.frx":0046
      Height          =   1950
      Left            =   5040
      TabIndex        =   22
      ToolTipText     =   "ENTER ·«œŒ«· «·„⁄·Ê„«  , ESC ··—ÃÊ⁄ ..."
      Top             =   5040
      Visible         =   0   'False
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   3440
      _Version        =   393216
      BackColor       =   14219774
      ListField       =   "m_name"
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   11.25
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.CommandButton Command5 
      BackColor       =   &H002972B4&
      Caption         =   "»ÕÀ"
      Height          =   495
      Left            =   1920
      Style           =   1  'Graphical
      TabIndex        =   21
      Top             =   7440
      Width           =   1575
   End
   Begin MSRDC.MSRDC pos 
      Height          =   330
      Left            =   3120
      Top             =   8760
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
      Connect         =   " "
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
      BackColor       =   &H00D8F9FE&
      ForeColor       =   &H00000000&
      Height          =   285
      Left            =   4920
      TabIndex        =   20
      Top             =   3240
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.TextBox Text1 
      Alignment       =   2  'Center
      BackColor       =   &H00D8F9FE&
      ForeColor       =   &H00000000&
      Height          =   285
      Left            =   17760
      TabIndex        =   10
      Top             =   3240
      Width           =   975
   End
   Begin VB.TextBox code 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00D8F9FE&
      Height          =   285
      Left            =   17280
      TabIndex        =   6
      Top             =   4200
      Visible         =   0   'False
      Width           =   1335
   End
   Begin VB.TextBox desc 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00D8F9FE&
      Height          =   285
      Left            =   12240
      MaxLength       =   120
      TabIndex        =   8
      Top             =   4560
      Visible         =   0   'False
      Width           =   6375
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H002972B4&
      Caption         =   "«÷«›… (INSERT)"
      Height          =   495
      Left            =   8280
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   7440
      Width           =   1575
   End
   Begin VB.CommandButton Command2 
      BackColor       =   &H002972B4&
      Caption         =   " ⁄œÌ·     (F2)"
      Height          =   495
      Left            =   6600
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   7440
      Width           =   1695
   End
   Begin VB.CommandButton Command3 
      BackColor       =   &H002972B4&
      Caption         =   " ”ÃÌ·  "
      Height          =   495
      Left            =   5040
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   7440
      Width           =   1575
   End
   Begin VB.CommandButton Command4 
      BackColor       =   &H002972B4&
      Caption         =   "«·€«¡  (DELETE)"
      Height          =   495
      Left            =   3480
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   7440
      Width           =   1575
   End
   Begin MSRDC.MSRDC f_form 
      Height          =   375
      Left            =   6600
      Top             =   8400
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
      Connect         =   " "
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
      Left            =   5640
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
      Connect         =   " "
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
      Left            =   5040
      Top             =   8760
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
      Connect         =   " "
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
      Bindings        =   "coding.frx":005D
      Height          =   2535
      Left            =   360
      TabIndex        =   1
      ToolTipText     =   "ENTER OR DBLCLIK ··œŒÊ· «·Ï «·⁄·«ﬁ«  , ESC  ··—ÃÊ⁄..."
      Top             =   4200
      Visible         =   0   'False
      Width           =   4335
      _ExtentX        =   7646
      _ExtentY        =   4471
      _Version        =   393216
      BackColor       =   14219774
      ListField       =   "pos_nam"
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   9.75
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSRDC.MSRDC name_form 
      Height          =   330
      Left            =   3600
      Top             =   8520
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
      Connect         =   " "
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
   Begin MSRDC.MSRDC pays 
      Height          =   375
      Left            =   120
      Top             =   8640
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
      Connect         =   " "
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
   Begin MSRDC.MSRDC cod3 
      Height          =   375
      Left            =   1560
      Top             =   8160
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
      Connect         =   " "
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
   Begin MSRDC.MSRDC cod2 
      Height          =   615
      Left            =   2880
      Top             =   8040
      Visible         =   0   'False
      Width           =   2175
      _ExtentX        =   3836
      _ExtentY        =   1085
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
      UserName        =   "sa"
      Password        =   ""
      Connect         =   " "
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
      Bindings        =   "coding.frx":0074
      Height          =   2595
      Left            =   13320
      TabIndex        =   9
      ToolTipText     =   "ENTER OR DBLCLICK ··œŒÊ· «·Ï «·œÊ·  ,  ESC ··—ÃÊ⁄"
      Top             =   480
      Width           =   2775
      _ExtentX        =   4895
      _ExtentY        =   4577
      _Version        =   393216
      Enabled         =   0   'False
      BackColor       =   14219774
      ForeColor       =   0
      ListField       =   "sub_desc"
      BoundColumn     =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSDBCtls.DBList DBList1 
      Bindings        =   "coding.frx":0087
      Height          =   2790
      Left            =   17040
      TabIndex        =   11
      ToolTipText     =   "ENTER OR DBLCLICK ··œŒÊ· «·Ï «·„” ÊÏ «·À«‰Ì , "
      Top             =   480
      Width           =   2655
      _ExtentX        =   4683
      _ExtentY        =   4921
      _Version        =   393216
      BackColor       =   14219774
      ForeColor       =   0
      ListField       =   "SUB_DESC"
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox Text3 
      BackColor       =   &H00D8F9FE&
      ForeColor       =   &H00000000&
      Height          =   285
      Left            =   10200
      TabIndex        =   0
      Top             =   3120
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.TextBox Text2 
      BackColor       =   &H00D8F9FE&
      ForeColor       =   &H00000000&
      Height          =   285
      Left            =   14400
      TabIndex        =   7
      Top             =   3120
      Width           =   975
   End
   Begin MSRDC.MSRDC cod1 
      Height          =   375
      Left            =   0
      Top             =   8160
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
      UserName        =   "abbas"
      Password        =   ""
      Connect         =   " "
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
   Begin MSDataListLib.DataList DataList1 
      Bindings        =   "coding.frx":009A
      Height          =   2595
      Left            =   9240
      TabIndex        =   39
      Top             =   480
      Visible         =   0   'False
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   4577
      _Version        =   393216
      ListField       =   "SUB_NAME"
      BoundColumn     =   "SUB_NO"
      RightToLeft     =   -1  'True
   End
   Begin MSAdodcLib.Adodc pays1 
      Height          =   330
      Left            =   9600
      Top             =   9000
      Visible         =   0   'False
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   582
      ConnectMode     =   0
      CursorLocation  =   3
      IsolationLevel  =   -1
      ConnectionTimeout=   15
      CommandTimeout  =   30
      CursorType      =   3
      LockType        =   3
      CommandType     =   1
      CursorOptions   =   0
      CacheSize       =   50
      MaxRecords      =   0
      BOFAction       =   0
      EOFAction       =   0
      ConnectStringType=   3
      Appearance      =   1
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      Orientation     =   0
      Enabled         =   -1
      Connect         =   "DSN=sqlserver"
      OLEDBString     =   ""
      OLEDBFile       =   ""
      DataSourceName  =   "sqlserver"
      OtherAttributes =   ""
      UserName        =   ""
      Password        =   ""
      RecordSource    =   "select * from pay_form"
      Caption         =   "rel_digit"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      _Version        =   393216
   End
   Begin MSAdodcLib.Adodc name_form1 
      Height          =   330
      Left            =   9960
      Top             =   8280
      Visible         =   0   'False
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   582
      ConnectMode     =   0
      CursorLocation  =   3
      IsolationLevel  =   -1
      ConnectionTimeout=   15
      CommandTimeout  =   30
      CursorType      =   3
      LockType        =   3
      CommandType     =   1
      CursorOptions   =   0
      CacheSize       =   50
      MaxRecords      =   0
      BOFAction       =   0
      EOFAction       =   0
      ConnectStringType=   3
      Appearance      =   1
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      Orientation     =   0
      Enabled         =   -1
      Connect         =   "DSN=sqlserver"
      OLEDBString     =   ""
      OLEDBFile       =   ""
      DataSourceName  =   "sqlserver"
      OtherAttributes =   ""
      UserName        =   ""
      Password        =   ""
      RecordSource    =   "select * from pay_form where sub_no = 'kk'"
      Caption         =   "rel_digit"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      _Version        =   393216
   End
   Begin VB.Line Line4 
      BorderColor     =   &H80000007&
      X1              =   9480
      X2              =   8520
      Y1              =   1680
      Y2              =   1680
   End
   Begin VB.Shape Shape2 
      BackColor       =   &H0086C8EC&
      BackStyle       =   1  'Opaque
      BorderColor     =   &H00D8F9FE&
      BorderWidth     =   3
      Height          =   735
      Left            =   120
      Shape           =   4  'Rounded Rectangle
      Top             =   7320
      Width           =   11655
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00DBC1C4&
      BackStyle       =   0  'Transparent
      Caption         =   "«·—„“"
      Height          =   255
      Left            =   18840
      RightToLeft     =   -1  'True
      TabIndex        =   17
      Top             =   4200
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.Shape Shape1 
      Height          =   1095
      Left            =   0
      Top             =   360
      Visible         =   0   'False
      Width           =   2295
   End
   Begin VB.Label Label14 
      BackStyle       =   0  'Transparent
      Caption         =   " «—ÌŒ «·‰Â«Ì…"
      Height          =   375
      Left            =   1320
      TabIndex        =   33
      Top             =   960
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.Label Label13 
      BackStyle       =   0  'Transparent
      Caption         =   " «—ÌŒ «·»œ«Ì…"
      Height          =   375
      Left            =   1320
      TabIndex        =   32
      Top             =   480
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.Label Label12 
      Alignment       =   2  'Center
      BackColor       =   &H00DBC1C4&
      BackStyle       =   0  'Transparent
      Caption         =   "«·»ÕÀ"
      Height          =   255
      Left            =   17160
      TabIndex        =   29
      Top             =   5880
      Visible         =   0   'False
      Width           =   615
      WordWrap        =   -1  'True
   End
   Begin VB.Line Line10 
      Visible         =   0   'False
      X1              =   9000
      X2              =   12120
      Y1              =   4680
      Y2              =   5160
   End
   Begin VB.Line Line8 
      Visible         =   0   'False
      X1              =   7440
      X2              =   8640
      Y1              =   5760
      Y2              =   4680
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H00DBC1C4&
      BackStyle       =   0  'Transparent
      Caption         =   "«·„” ÊÏ «·«Ê·   "
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   17640
      TabIndex        =   19
      Top             =   240
      Width           =   1575
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BackColor       =   &H00DBC1C4&
      BackStyle       =   0  'Transparent
      Caption         =   "«·„” ÊÏ «·À«‰Ì"
      Height          =   255
      Left            =   14160
      TabIndex        =   18
      Top             =   240
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
      X1              =   17040
      X2              =   16080
      Y1              =   1920
      Y2              =   1920
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      BackColor       =   &H8000000C&
      BackStyle       =   0  'Transparent
      Caption         =   "«·‘—Õ"
      Height          =   255
      Left            =   18480
      RightToLeft     =   -1  'True
      TabIndex        =   16
      Top             =   4560
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Line Line3 
      BorderColor     =   &H80000006&
      Visible         =   0   'False
      X1              =   13320
      X2              =   12600
      Y1              =   2280
      Y2              =   2280
   End
   Begin VB.Label Label7 
      Alignment       =   2  'Center
      BackColor       =   &H00DBC1C4&
      BackStyle       =   0  'Transparent
      Caption         =   "«·œÊ·"
      Height          =   255
      Left            =   10440
      TabIndex        =   14
      Top             =   240
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.Label Label8 
      Alignment       =   2  'Center
      BackColor       =   &H00DBC1C4&
      BackStyle       =   0  'Transparent
      Caption         =   "«·«”„«¡"
      Height          =   255
      Left            =   5520
      TabIndex        =   13
      Top             =   240
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
      X1              =   3120
      X2              =   3120
      Y1              =   4320
      Y2              =   3360
   End
   Begin VB.Label Label9 
      Alignment       =   2  'Center
      BackColor       =   &H00DBC1C4&
      BackStyle       =   0  'Transparent
      Caption         =   "«·„‰«’»"
      Height          =   255
      Left            =   3720
      TabIndex        =   12
      Top             =   3360
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.Shape Shape3 
      BackColor       =   &H002972B4&
      BackStyle       =   1  'Opaque
      BorderColor     =   &H00D8F9FE&
      BorderWidth     =   3
      Height          =   1095
      Left            =   12120
      Shape           =   4  'Rounded Rectangle
      Top             =   4080
      Visible         =   0   'False
      Width           =   7695
   End
   Begin VB.Label Label11 
      Alignment       =   2  'Center
      BackColor       =   &H00DBC1C4&
      BackStyle       =   0  'Transparent
      Caption         =   "«·—»ÿ «·„Ê÷Ê⁄Ì"
      Height          =   375
      Left            =   9960
      TabIndex        =   25
      Top             =   4800
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.Label Label10 
      Alignment       =   2  'Center
      BackColor       =   &H00DBC1C4&
      BackStyle       =   0  'Transparent
      Caption         =   "«·—»ÿ «·‘ﬂ«Ì"
      Height          =   375
      Left            =   6360
      TabIndex        =   24
      Top             =   4680
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.Label Label6 
      Alignment       =   2  'Center
      BackColor       =   &H00DBC1C4&
      BackStyle       =   0  'Transparent
      Caption         =   "„⁄«·Ã« "
      Height          =   255
      Left            =   15840
      RightToLeft     =   -1  'True
      TabIndex        =   15
      Top             =   3840
      Visible         =   0   'False
      Width           =   1575
   End
End
Attribute VB_Name = "coding"
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
 Dim sql As String
 find_rep = True
 sw_des = ""
 sw_desc = Trim(sw_desc)
 L = Len(sw_desc)
 m_nb = "0123456789"
 i = 1
 '  cn.Connect = "uid=;pwd=;server=SEQUEL;" _
 '         & "driver={SQL Server};database=archive_manar;" _
 '          & "DSN='';"
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
     sql = "exec insr_word " & "'" & sw_des & "'" & "," & "'" & sw_code & "'" _
             & "," & "'" & m_typ & "'"
           
            cn.Execute sql, rdExecDirect
  End If
 Wend
 word.Refresh
 
End Function


Private Sub Command5_Click()
On Error Resume Next
If typ_serh = 1 Then

 Label3.Visible = True
 Label5.Visible = True
 Label6.Visible = True
 desc.Visible = True
 Shape3.Visible = True
 desc.SetFocus
 typ_serh = 2
ElseIf typ_serh = 2 Then
 If DataList1.Enabled = True Then
  m_desc = desc.Text
  m_len = Len(Trim(m_desc))
  pays1.RecordSource = "execute serh_form " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
  pays1.Refresh
  DataList1.Refresh
ElseIf DataList2.Enabled = True Then
  name_form1.Recordset.Bookmark = DataList2.SelectedItem
  v_typ = name_form1.Recordset![sub_typ]
  v_cod = Mid(name_form1.Recordset![sub_no], 1, 3)
  m_desc = desc.Text
  m_len = Len(Trim(m_desc))
  name_form1.RecordSource = "execute serh1_form " & "'" & v_typ & "'" & "," & "'" & v_cod & "'" & "," & _
  "'" & m_desc & "'" & "," & "'" & m_len & "'"
  name_form1.Refresh
  DataList2.Refresh

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
 Unload Me
End Sub

Private Sub Command7_Click()
tmp_file.Show
End Sub

Private Sub Command8_Click()
  m_rl_no = Val(m_rel.Text)
  If m_rl_no - 1 > 0 Then
    If m_rl_no - 1 < 10 Then
      m_rel.Text = "0" + Trim(Str(m_rl_no - 1))
    Else
      m_rel.Text = Trim(Str(m_rl_no - 1))
    End If
 End If
End Sub

Private Sub Command9_Click()
 m_rl_no = Val(m_rel.Text)

 If m_rl_no < 9 Then
    m_rel.Text = "0" + Trim(Str(m_rl_no + 1))
  Else
    m_rel.Text = Trim(Str(m_rl_no + 1))
  End If
End Sub

Private Sub DBList1_GotFocus()
 ' SendKeys "{up}"
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

Private Sub datalist1_Click()
 pays1.Recordset.Bookmark = DataList1.SelectedItem
 Text3.Text = pays1.Recordset![sub_typ] & pays1.Recordset![sub_no]
End Sub

Private Sub datalist1_KeyDown(KeyCode As Integer, Shift As Integer)
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

Private Sub datalist1_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyInsert Then
 Command1.SetFocus
 SendKeys "{enter}"
 ElseIf KeyCode = vbKeyDelete Then
   Command4.SetFocus
   SendKeys "{enter}"
 End If
End Sub

Private Sub datalist2_Click()
If Not name_form1.Recordset.EOF And Not name_form1.Recordset.BOF Then


 name_form1.Recordset.Bookmark = DataList2.SelectedItem
 Text4.Text = name_form1.Recordset![sub_typ] & name_form1.Recordset![sub_no]
 End If
 
End Sub

Private Sub datalist2_KeyDown(KeyCode As Integer, Shift As Integer)
On Error Resume Next
 desc.Text = ""
If KeyCode = vbKeyF9 Then
 Label3.Visible = True
 Label5.Visible = True
 Label6.Visible = True
 desc.Visible = True
 Shape3.Visible = True
 desc.Text = ""
 desc.SetFocus
  typ_serh = 3
  SendKeys "{up}"
ElseIf KeyCode = vbKeyF8 Then
 Label3.Visible = True
 Label5.Visible = True
 Label6.Visible = True
 desc.Visible = True
 Shape3.Visible = True
 desc.Text = ""
 desc.SetFocus
  typ_serh = 2
  SendKeys "{up}"
ElseIf KeyCode = vbKeyF6 Then
 Label3.Visible = True
 Label5.Visible = True
 Label6.Visible = True
 desc.Visible = True
 Shape3.Visible = True
 desc.Text = ""
 desc.SetFocus
  typ_serh = 4
  SendKeys "{up}"
ElseIf KeyCode = vbKeyF7 Then
 Label3.Visible = True
 Label5.Visible = True
 Label6.Visible = True
 desc.Visible = True
 Shape3.Visible = True
 desc.Text = ""
 desc.SetFocus
  typ_serh = 5
  SendKeys "{up}"

ElseIf KeyCode = vbKeyF2 Then
  Command2.SetFocus
   SendKeys "{enter}"
  ElseIf KeyCode = vbKeyF5 Then
name_form1.Recordset.Bookmark = DataList2.SelectedItem
 m_code = name_form1.Recordset![sub_typ] & name_form1.Recordset![sub_no]
 If name_form1.Recordset![sub_typ] = "01" Then
   m_prsno = m_code
   m_prs_sub_name = name_form1.Recordset![sub_name]
   Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
' machad_f2.WindowState = 2
 person_f.Show
 Screen.MousePointer = vbDefault
ElseIf name_form1.Recordset![sub_typ] = "03" Then
    m_prsno = m_code
   m_prs_sub_name = name_form1.Recordset![sub_name]
   Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
' machad_f2.WindowState = 2
 instit_F.Show
 Screen.MousePointer = vbDefault
 
End If
End If
End Sub

Private Sub datalist2_KeyUp(KeyCode As Integer, Shift As Integer)

If KeyCode = vbKeyInsert Then
 Command1.SetFocus
 SendKeys "{enter}"
 ElseIf KeyCode = vbKeyDelete Then
   Command4.SetFocus
   SendKeys "{enter}"
 End If
End Sub

Private Sub DBList5_DblClick()
        On Error Resume Next
        DBList6.Visible = True
        Line8.Visible = True
        
        m_rel.Visible = True
        Label10.Visible = True
        Label11.Visible = True
        DBList7.Visible = True
        Command8.Visible = True
         Command9.Visible = True
           
'        position.Resultset.Bookmark = DBList5.SelectedItem
'        m_code = position.Resultset![pos_no]
        
        name_form1.Recordset.Bookmark = DataList2.SelectedItem
        m_code = name_form1.Recordset![sub_typ] & name_form1.Recordset![sub_no]
        m_rel = "01"
        DBList5.Enabled = False
        rel_form.sql = "execute rel_form_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        rel_form.Refresh
        SUBJECT.sql = "execute subject_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        SUBJECT.Refresh
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
      frm_mcnz.sql = " select * from pay_form"
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
         
         
        m_rel.Visible = False
        Label10.Visible = False
        Label11.Visible = False
        DBList7.Visible = False
        Command8.Visible = False
         Command9.Visible = False
       

      If DBList5.Visible = True Then
          DBList5.Enabled = True
           DBList5.SetFocus
      Else
          
         Line7.Visible = False
         DBList5.Visible = False
         DataList2.Enabled = True
         DataList2.SetFocus
         Label9.Visible = False
      End If
    Case 13
      frm_mcnz.sql = " select * from pay_form"
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
     frm_mcnz.sql = " select * from macnz"
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
    SUBJECT.Resultset.Bookmark = DBList7.SelectedItem
    If Not IsNull(SUBJECT.Resultset![sub_dte]) Then
      deb_dte.Text = SUBJECT.Resultset![sub_dte]
     Else
     deb_dte.Text = ""
     End If
  If Not IsNull(SUBJECT.Resultset![sub_dte1]) Then
     fin_dte.Text = SUBJECT.Resultset![sub_dte1]
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
         
        Line10.Visible = False
        m_rel.Visible = False
        Label10.Visible = False
        Label11.Visible = False
        DBList7.Visible = False
        Command8.Visible = False
         Command9.Visible = False
       

      If DBList5.Visible = True Then
          DBList5.Enabled = True
           DBList5.SetFocus
      Else
         Line6.Visible = False
         Line7.Visible = False
         DBList5.Visible = False
         DataList2.Enabled = True
         DataList2.SetFocus
         Label9.Visible = False
      End If

    Case 13
     frm_mcnz.sql = " select * from macnz"
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
 Dim sql As String
       If typ_list = 1 Then
        If Not rel_form.Resultset.BOF Then
           rel_form.Resultset.Bookmark = DBList6.SelectedItem
           m_rlf1 = rel_form.Resultset![rlf_form1]
         Else
               name_form1.Recordset.Bookmark = DataList2.SelectedItem
           m_rlf1 = name_form1.Recordset![sub_typ] & name_form1.Recordset![sub_no]
         End If
         
         frm_mcnz.Resultset.Bookmark = DBList8.SelectedItem
         m_rlf2 = frm_mcnz.Resultset![sub_cod]
         sql = "execute insr_rel_form " & "'" & m_rlf1 & "'" & _
        "," & "'" & m_rlf2 & "'" & "," & "'" & m_rel.Text & "'"
        
        Else
        If Not SUBJECT.Resultset.BOF Then
          SUBJECT.Resultset.Bookmark = DBList7.SelectedItem
          m_frm = SUBJECT.Resultset![sub_form]
          Else
             name_form1.Recordset.Bookmark = DataList2.SelectedItem
           m_frm = name_form1.Recordset![sub_typ] & name_form1.Recordset![sub_no]
         End If
          frm_mcnz.Resultset.Bookmark = DBList8.SelectedItem
          m_mcnz = frm_mcnz.Resultset![sub_code]
          sql = "execute insr_subject " & "'" & m_frm & "'" & _
          "," & "'" & m_mcnz & "'" & "," & "'" & m_rel.Text & "'"
        End If
         '    cn.Connect = "uid=;pwd=;server=SEQUEL;" _
         '  & "driver={SQL Server};database=archive_manar;" _
         '  & "DSN='';"
         '   cn.CursorDriver = rdUseOdbc
         '  cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
   
       If typ_list = 1 Then
         DBList8.Visible = False
         rel_form.Refresh
         DBList6.Refresh
         DBList6.SetFocus
         
       Else
           DBList8.Visible = False
           SUBJECT.Refresh
           DBList7.Refresh
           DBList7.SetFocus
       End If
         Text6.Visible = False

End Sub

Private Sub DBList8_KeyDown(KeyCode As Integer, Shift As Integer)
On Error Resume Next
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
On Error Resume Next
 Dim sql As String
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
               name_form1.Recordset.Bookmark = DataList2.SelectedItem
           m_rlf1 = name_form1.Recordset![sub_typ] & name_form1.Recordset![sub_no]
       '  End If

         frm_mcnz.Resultset.Bookmark = DBList8.SelectedItem
         m_rlf2 = frm_mcnz.Resultset![sub_cod]
         sql = "execute insr_rel_form " & "'" & m_rlf1 & "'" & _
        "," & "'" & m_rlf2 & "'" & "," & "'" & m_rel.Text & "'"
        
        Else
       '  If Not subject.Resultset.BOF Then
       '   subject.Resultset.Bookmark = DBList7.SelectedItem
       '   m_frm = subject.Resultset![sub_form]
       '   Else
             name_form1.Recordset.Bookmark = DataList2.SelectedItem
           m_frm = name_form1.Recordset![sub_typ] & name_form1.Recordset![sub_no]
       '  End If
          frm_mcnz.Resultset.Bookmark = DBList8.SelectedItem
          m_mcnz = frm_mcnz.Resultset![sub_code]
          sql = "execute insr_subject " & "'" & m_frm & "'" & _
          "," & "'" & m_mcnz & "'" & "," & "'" & m_rel.Text & "'"
        End If
       '      cn.Connect = "uid=;pwd=;server=SEQUEL;" _
       '    & "driver={SQL Server};database=archive_manar;" _
       '    & "DSN='';"
       '     cn.CursorDriver = rdUseOdbc
       '    cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
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
           SUBJECT.Refresh
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
cod2.sql = "execute proc_v_coding1"
cod2.Refresh

End Sub

Private Sub code_KeyPress(KeyAscii As Integer)
  On Error Resume Next
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
        ElseIf DataList1.Enabled = True Then
           DataList1.SetFocus
        ElseIf DataList2.Enabled = True Then
          DataList2.SetFocus
        ElseIf DBList5.Enabled = True Then
           DBList5.SetFocus
       End If
        SendKeys "{up}"

      Case 13
          If mod_typ = 1 Then
             If DBList1.Enabled = True Or DBList2.Enabled = True Then
                  tmp_msdrc.sql = "exec find_coding" & "'" & code.Text & "'"
                  tmp_msdrc.Refresh
                  If Not tmp_msdrc.Resultset.EOF Or Not tmp_msdrc.Resultset.BOF Then
                     MsgBox "Â–« «·—ﬁ„  «»⁄ ·«” „«—… «Œ—Ï!!!!!"
                     code.SetFocus
                   Else
                     desc.SetFocus
                   End If
            ElseIf DataList1.Enabled = True Then
                pays1.Recordset.Bookmark = DataList1.SelectedItem
                 m_sub_no = code.Text
                 m_sub_typ = pays1.Recordset![sub_typ]
                 tmp_msdrc.sql = "exec find_form " & "'" & m_sub_no & "'" _
                       & "," & "'" & m_sub_typ & "'"
                    
                  tmp_msdrc.Refresh
                  If Not tmp_msdrc.Resultset.EOF Or Not tmp_msdrc.Resultset.BOF Then
                     MsgBox "Â–« «·—ﬁ„  «»⁄ ·«” „«—… «Œ—Ï!!!!!"
                     code.SetFocus
                   Else
                     desc.SetFocus
                   End If
              ElseIf DataList2.Enabled = True Then
                   pays1.Recordset.Bookmark = DataList1.SelectedItem
                   m_sub_typ = Mid(cod1.Resultset![sub_code], 3, 2)
                   m_sub = Mid(pays1.Recordset![sub_no], 1, 3)
'                name_form1.recordset.Bookmark = datalist2.SelectedItem
'                m_sub_typ = name_form1.recordset![sub_typ]
'                m_sub = Mid(name_form1.recordset![sub_no], 1, 3)
                  m_sub_no = m_sub & code.Text
                tmp_msdrc.sql = "exec find_form " & "'" & m_sub_no & "'" _
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
 ElseIf DataList1.Enabled = True Then
   desc.Text = ""
   code.Text = ""
'   f_form.Resultset.AddNew
    code.SetFocus
 ElseIf DataList2.Enabled = True Then
   m_date = Format(Date, "dd/mm/yyyy")
   m_sub = Trim(v_typ) + Mid(pays1.Recordset![sub_no], 1, 3)
   If (m_sub <> "01001" And m_sub <> "04001") Or (box_company <> 1 And box_company <> 4) Then
    ' If m_sub <> "04021" Then
   If Not name_form1.Recordset.EOF And Not name_form1.Recordset.BOF Then
    mod_typ = "1"
    sql = "EXECUTE OP_FORM " & "'" & m_sub & "'" & "," & "'" & Format(m_date, "yyyy/mm/dd") & "'"
    cn.Execute sql, rdExecDirect
    cod3.sql = "execute max_form " & "'" & m_sub & "'"
    cod3.Refresh
     code.Text = cod3.Resultset![max1]
  Else
    m_desc = ""
   code.Text = m_sub + "00001"
 m_sub_no = Mid(code.Text, 3, 8)
  m_sub_typ = Mid(code.Text, 1, 2)
    sql = "exec insr_form " & "'" & m_desc & "'" & "," & "'" & m_sub_no & "'" _
           & "," & "'" & m_sub_typ & "'" _
           & "," & "'" & Format(m_date, "yyyy/mm/dd") & "'"
  
           cn.Execute sql, rdExecDirect
 
  End If
     code.Enabled = False
     desc.Text = ""
    desc.SetFocus
     
   Else
    
    code.Enabled = True
    code.Text = ""
     desc.Text = ""
     code.SetFocus
     
   End If
    
  ElseIf DBList5.Enabled = True Then
   desc.Text = ""
   code.Text = ""
   code.Enabled = False
'   pos.Resultset.AddNew
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
     cod3.sql = "execute find_coding " & "'" & m_code & "'"
     cod3.Refresh
     desc.Text = cod3.Resultset![sub_desc]
     code.Text = cod3.Resultset![sub_code]
ElseIf DBList2.Enabled = True Then
   cod1.Resultset.Bookmark = DBList2.SelectedItem
   m_code = cod1.Resultset![sub_code]
   cod3.sql = "execute find_coding" & "'" & m_code & "'"
   cod3.Refresh
   desc.Text = cod3.Resultset![sub_desc]
   code.Text = cod3.Resultset![sub_code]
ElseIf DataList1.Enabled = True Then
   pays1.Recordset.Bookmark = DataList1.SelectedItem
    m_sub_no = pays1.Recordset![sub_no]
    m_sub_typ = pays1.Recordset![sub_typ]
    cod3.sql = "execute find_form " & "'" & m_sub_no & "'" & "," & "'" & m_sub_typ & "'"
    cod3.Refresh
     desc.Text = cod3.Resultset![sub_name]
     code.Text = cod3.Resultset![sub_typ] & cod3.Resultset![sub_no]
ElseIf DataList2.Enabled = True Then
   name_form1.Recordset.Bookmark = DataList2.SelectedItem
    m_sub_no = name_form1.Recordset![sub_no]
    m_sub_typ = name_form1.Recordset![sub_typ]
    cod3.sql = "execute find_form " & "'" & m_sub_no & "'" & "," & "'" & m_sub_typ & "'"
    cod3.Refresh
    If Not IsNull(cod3.Resultset![sub_name]) Then
    desc.Text = cod3.Resultset![sub_name]
    End If
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
On Error Resume Next
'If m_form_pwd = "ag56" Or m_form_pwd = "AG56" Or m_form_pwd = "‘·56" Then
 Dim m_code As Variant
 Dim m_desc As Variant
' Dim cn As New rdoConnection
 Dim sql As String

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
'  SendKeys "{up}"
  coding_typ = 2
 ElseIf DataList1.Enabled = True Then
     m_date = Date
     pays1.Recordset.Bookmark = DataList1.SelectedItem
     m_sub_no = code.Text
     m_desc = desc.Text
     m_sub_typ = pays1.Recordset![sub_typ]
     sql = "exec insr_form " & "'" & m_desc & "'" & "," & "'" & m_sub_no & "'" _
           & "," & "'" & m_sub_typ & "'" _
           & "," & "'" & Format(m_date, "yyyy/mm/dd") & "'"
           
            cn.Execute sql, rdExecDirect
  
     f_form.Refresh
     pays1.Refresh
     DataList1.Refresh
     m_code = m_sub_typ + m_sub_no
     Call div_word(m_code, m_desc, "2")
      DataList1.SetFocus
      SendKeys "{up}"
 ElseIf DataList2.Enabled = True Then
     m_date = Date
     pays1.Recordset.Bookmark = DataList1.SelectedItem
     m_desc = desc.Text
    m_sub = Trim(v_typ) + Mid(pays1.Recordset![sub_no], 1, 3)
       If (m_sub = "01001" Or m_sub = "04001") And (box_company = 1 Or box_company = 4) Then
   '    If m_sub = "04021" Then
        m_sub_no = Mid(pays1.Recordset![sub_no], 1, 3) + code.Text
        m_sub_typ = Trim(v_typ)

     sql = "exec insr_form " & "'" & m_desc & "'" & "," & "'" & m_sub_no & "'" _
           & "," & "'" & m_sub_typ & "'" _
           & "," & "'" & Format(m_date, "yyyy/mm/dd") & "'"
       
            cn.Execute sql, rdExecDirect
  
  Else
       m_sub_no = Mid(code.Text, 3, 8)
     m_sub_typ = Mid(code.Text, 1, 2)

       sql = "exec upd_form " & "'" & m_desc & "'" & "," & "'" & m_sub_no & "'" _
           & "," & "'" & m_sub_typ & "'"
              cn.Execute sql, rdExecDirect
  End If
     f_form.Refresh
     name_form1.Refresh
     DataList2.Refresh
     m_code = m_sub_typ + m_sub_no
 '    Call div_word(m_code, m_desc, "2")
    DataList2.SetFocus
    SendKeys "{up}"
        SendKeys "{down}"
 ElseIf DBList5.Enabled = True Then
    
     m_date = Date
     m_desc = desc.Text
     m_sub_typ = name_form1.Recordset![sub_typ]
     m_sub = name_form1.Recordset![sub_no]
     m_sub_no = m_sub_typ & m_sub
     sql = "exec insr_pos " & "'" & m_desc & "'" & "," & "'" & m_sub_no & "'" _
            & "," & "'" & Format(m_date, "yyyy/mm/dd") & "'"
     
            cn.Execute sql, rdExecDirect
  
    pos.Refresh
    position.Refresh
    DBList5.Refresh
    code.Enabled = True
    DBList5.SetFocus
    SendKeys "{up}"
      
 
 End If
 mod_typ = "0"
ElseIf mod_typ = "2" Then
  m_desc = desc.Text
  If DBList1.Enabled = True Then
     cod2.Resultset.Bookmark = DBList1.SelectedItem
     m_code = cod2.Resultset![sub_code]
     sql = "exec upd_coding " & "'" & m_desc & "'" & "," & "'" & m_code & "'"
  ElseIf DBList2.Enabled = True Then
     cod1.Resultset.Bookmark = DBList2.SelectedItem
     m_code = cod1.Resultset![sub_code]
     sql = "exec upd_coding " & "'" & m_desc & "'" & "," & "'" & m_code & "'"
  ElseIf DataList1.Enabled = True Then
     pays1.Recordset.Bookmark = DataList1.SelectedItem
     m_sub_no = pays1.Recordset![sub_no]
     m_sub_typ = pays1.Recordset![sub_typ]
     sql = "exec upd_form " & "'" & m_desc & "'" & "," & "'" & m_sub_no & "'" _
           & "," & "'" & m_sub_typ & "'"
    ElseIf DataList2.Enabled = True Then
     name_form1.Recordset.Bookmark = DataList2.SelectedItem
     m_sub_no = name_form1.Recordset![sub_no]
     m_sub_typ = name_form1.Recordset![sub_typ]
     sql = "exec upd_form " & "'" & m_desc & "'" & "," & "'" & m_sub_no & "'" _
           & "," & "'" & m_sub_typ & "'"
           
  ElseIf DBList5.Enabled = True Then
     position.Resultset.Bookmark = DBList5.SelectedItem
     m_sub_no = position.Resultset![pos_no]
     m_desc1 = position.Resultset![pos_nam]
     sql = "exec upd_position" & "'" & m_desc & "'" & "," & "'" & m_sub_no & "'" _
           & "," & "'" & m_desc1 & "'"
     code.Enabled = True
   ElseIf DBList6.Enabled = True And deb_dte.Visible = True And typ_list = 1 Then
     rel_form.Resultset.Bookmark = DBList6.SelectedItem
     m_rlf1 = rel_form.Resultset![rlf_form1]
     m_rlf2 = rel_form.Resultset![rlf_form2]
   
      sql = "execute upd_rfl_dte " & "'" & m_rlf1 & "'" & "," & "'" & m_rlf2 & "'" & "," & "'" & m_rel.Text & "'" _
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
     SUBJECT.Resultset.Bookmark = DBList7.SelectedItem
     m_rlf1 = SUBJECT.Resultset![sub_form]
     m_rlf2 = SUBJECT.Resultset![sub_mcnz]
   
      sql = "execute upd_sub_dte " & "'" & m_rlf1 & "'" & "," & "'" & m_rlf2 & "'" & "," & "'" & m_rel.Text & "'" _
        & "," & "'" & Format(deb_dte.Text, "yyyy/mm/dd") & "'" & _
          "," & "'" & Format(fin_dte.Text, "yyyy/mm/dd") & "'"
 
      SUBJECT.Refresh
      deb_dte.Visible = False
      fin_dte.Visible = False
      Label13.Visible = False
      Label14.Visible = False
      Shape1.Visible = False
      DBList7.SetFocus
          
End If
  
        '   cn.Connect = "uid=;pwd=;server=SEQUEL;" _
        '   & "driver={SQL Server};database=archive_manar;" _
        '   & "DSN='';"
        '    cn.CursorDriver = rdUseOdbc
        '    cn.EstablishConnection rdDriverNoPrompt
           
            cn.Execute sql, rdExecDirect
           
   If DataList1.Enabled = True Or DataList2.Enabled = True Then
       m_code = m_sub_typ + m_sub_no
         m_typ = "2"
       sql = "exec del_word" & "'" & m_code & "'" _
           & "," & "'" & m_typ & "'"
       cn.Execute sql, rdExecDirect
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
ElseIf DataList1.Enabled = True Then
  pays1.Refresh
  DataList1.Refresh
  DataList1.SetFocus
ElseIf DataList2.Enabled = True Then
  name_form1.Refresh
  DataList2.Refresh
  DataList2.SetFocus
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
'End If
End Sub

Private Sub Command4_Click()
On Error Resume Next
'If m_form_pwd = "ag56" Or m_form_pwd = "AG56" Or m_form_pwd = "‘·56" Then
 Dim ok As String
 Dim m_code As Variant
 Dim m_desc As Variant
' Dim cn As New rdoConnection
 Dim sql As String
          
         ok = " "
         ok = InputBox("Â·  —Ìœ «·€«¡ «·„ﬁ«·…(‰/ﬂ)")
If ok = "y" Or ok = "‰" Then
     '      cn.Connect = "uid=;pwd=;server=SEQUEL;" _
     '      & "driver={SQL Server};database=archive_manar;" _
     '      & "DSN='';"
     '       cn.CursorDriver = rdUseOdbc
         '   cn.EstablishConnection rdDriverNoPrompt
    
 If DBList1.Enabled = True Then
   cod2.Resultset.Bookmark = DBList1.SelectedItem
   m_code = cod2.Resultset![sub_code]
               sql = "exec del_coding" & "'" & m_code & "'"
            cn.Execute sql, rdExecDirect
            cod3.Refresh
            cod2.Refresh
            DBList1.Refresh
            DBList1.SetFocus
            SendKeys "{up}"
            
ElseIf DBList2.Enabled = True Then
         cod1.Resultset.Bookmark = DBList2.SelectedItem
         m_code = cod1.Resultset![sub_code]
            sql = "exec del_coding" & "'" & m_code & "'"
            cn.Execute sql, rdExecDirect
            cod3.Refresh
            cod1.Refresh
            DBList2.Refresh
            DBList2.SetFocus
            SendKeys "{up}"
ElseIf DataList1.Enabled = True Then
    pays1.Recordset.Bookmark = DataList1.SelectedItem
    m_sub_no = pays1.Recordset![sub_no]
    m_sub_typ = pays1.Recordset![sub_typ]
    sql = "exec del_form" & "'" & m_sub_no & "'" & "," & "'" & m_sub_typ & "'"
    cn.Execute sql, rdExecDirect
    cod3.Refresh
    pays1.Refresh
    DataList1.Refresh
    DataList1.SetFocus
    SendKeys "{up}"
 ElseIf DataList2.Enabled = True Then
    name_form1.Recordset.Bookmark = DataList2.SelectedItem
    m_sub_no = name_form1.Recordset![sub_no]
    m_sub_typ = name_form1.Recordset![sub_typ]
    sql = "exec del_form" & "'" & m_sub_no & "'" & "," & "'" & m_sub_typ & "'"
    cn.Execute sql, rdExecDirect
    cod3.Refresh
    name_form1.Refresh
    DataList2.Refresh
    DataList2.SetFocus
    SendKeys "{up}"
ElseIf DBList5.Enabled = True Then
    position.Resultset.Bookmark = DBList5.SelectedItem
    m_sub_no = position.Resultset![pos_no]
    m_desc = position.Resultset![pos_nam]
    sql = "exec del_position" & "'" & m_sub_no & "'" & "," & "'" & m_desc & "'"
    cn.Execute sql, rdExecDirect
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
           sql = "execute del_rel_form" & "'" & m_rlf1 & "'" & _
           "," & "'" & m_rlf2 & "'" & "," & "'" & v_rel & "'"
           cn.Execute sql, rdExecDirect
          rel_form.Refresh
          DBList6.Refresh
          DBList6.SetFocus
          SendKeys "{up}"
        End If
      Else
       If Not SUBJECT.Resultset.BOF Then
            SUBJECT.Resultset.Bookmark = DBList7.SelectedItem
          m_frm = SUBJECT.Resultset![sub_form]
          m_mcnz = SUBJECT.Resultset![sub_mcnz]
          v_rel = m_rel.Text
          sql = "execute del_subject" & "'" & m_frm & "'" & _
            "," & "'" & m_mcnz & "'" & "," & "'" & v_rel & "'"
          cn.Execute sql, rdExecDirect
          SUBJECT.Refresh
          DBList7.Refresh
          DBList7.SetFocus
            SendKeys "{up}"
      End If
   End If
End If
End If
'End If
End Sub


Private Sub DBList1_Click()
  cod2.Resultset.Bookmark = DBList1.SelectedItem
  Text1.Text = cod2.Resultset![sub_code]
  
End Sub

Private Sub DBList1_DblClick()
'MsgBox cod2.Resultset.Bookmark
'cod2.Resultset.Bookmark = DBList1.SelectedItem

cod2.Resultset.Bookmark = DBList1.SelectedItem
cod1.sql = "execute coding_proc " & "'" & Mid(cod2.Resultset![sub_code], 1, 2) & "'"
cod1.Refresh
DBList2.Enabled = True
DBList1.Enabled = False
DBList2.SetFocus
'SendKeys "{up}"
End Sub

Private Sub DBList1_KeyPress(KeyAscii As Integer)
 Select Case KeyAscii
      Case 13
        cod2.Resultset.Bookmark = DBList1.SelectedItem
        cod1.sql = "execute coding_proc " & "'" & Mid(cod2.Resultset![sub_code], 1, 2) & "'"
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
      DataList1.Visible = True
       DBList2.Enabled = False
       Line3.Visible = True
       v_typ = Mid(cod1.Resultset![sub_code], 3, 2)
       DataList1.SetFocus
       Label7.Visible = True
       Text3.Visible = True
'       SendKeys "{up}"
    End If
End Sub

Private Sub DBList2_KeyPress(KeyAscii As Integer)
On Error Resume Next
  Select Case KeyAscii
      Case 27
         DBList1.Enabled = True
         DBList1.SetFocus
         DBList2.Enabled = False
      Case 13
        cod1.Resultset.Bookmark = DBList2.SelectedItem
        If Mid(cod1.Resultset![sub_code], 1, 2) = "10" Then
           DataList1.Visible = True
           DBList2.Enabled = False
           Line3.Visible = True
          v_typ = Mid(cod1.Resultset![sub_code], 3, 2)
           DataList1.SetFocus
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

Private Sub datalist1_DblClick()
On Error Resume Next
  pays1.Recordset.Bookmark = DataList1.SelectedItem
  name_form1.RecordSource = "execute nam_form " & "'" & Trim(v_typ) & "'" & "," & "'" & Mid(pays1.Recordset![sub_no], 1, 3) & "'"
  name_form1.Refresh
  DataList2.Visible = True
  DataList2.Refresh
  Line4.Visible = True
   
  DataList1.Enabled = False
  DataList2.SetFocus
  Label8.Visible = True
  Text4.Visible = True
  SendKeys "{up}"
End Sub

Private Sub datalist1_KeyPress(KeyAscii As Integer)
    On Error Resume Next
    Select Case KeyAscii
      Case 27
       DBList2.Enabled = True
       DBList2.SetFocus
       DataList1.Visible = False
       Line3.Visible = False
       Label7.Visible = False
       Text3.Visible = False
       pays1.RecordSource = "select * from pay_form"
       pays1.Refresh
       
     Case 13
       pays1.Recordset.Bookmark = DataList1.SelectedItem
       name_form1.RecordSource = "execute nam_form" & "'" & Trim(v_typ) & "'" & "," & "'" & Mid(pays1.Recordset![sub_no], 1, 3) & "'"
       name_form1.Refresh
       DataList2.Visible = True
       DataList2.Refresh
       Line4.Visible = True
       Line5.Visible = True
       DataList1.Enabled = False
       DataList2.SetFocus
       Label8.Visible = True
       Text4.Visible = True
       SendKeys "{up}"
     Case 109
       Command2.SetFocus
       SendKeys "13"
     Case 146
       Command2.SetFocus
       SendKeys "13"
  
   End Select
End Sub

Private Sub datalist2_DblClick()
  Dim m_code As Variant
  name_form1.Recordset.Bookmark = DataList2.SelectedItem
  DataList2.Enabled = False
  If name_form1.Recordset![sub_typ] = "01" Then
  m_code = name_form1.Recordset![sub_typ] & name_form1.Recordset![sub_no]
  v_sub_no = m_code
  position.sql = " execute proc_pos " & "'" & m_code & "'"
  position.Refresh
  DBList5.Visible = True
  DBList5.Refresh
   
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
        Line10.Visible = True
        m_rel.Visible = True
        Label10.Visible = True
        Label11.Visible = True
        DBList7.Visible = True

  m_code = name_form1.Recordset![sub_typ] & name_form1.Recordset![sub_no]
        m_rel = "01"
        DBList5.Enabled = False
        rel_form.sql = "execute rel_form_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        rel_form.Refresh
        SUBJECT.sql = "execute subject_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        SUBJECT.Refresh
        DBList6.SetFocus
         typ_list = 1
           SendKeys "{up}"
 End If
End Sub

Private Sub datalist2_KeyPress(KeyAscii As Integer)
    On Error Resume Next
    Select Case KeyAscii
      Case 27
        DataList2.Visible = False
        Line4.Visible = False
        
        DataList1.Enabled = True
        DataList1.SetFocus
        Label8.Visible = False
        Text4.Visible = False
      Case 13
      If Not name_form1.Recordset.EOF And Not name_form1.Recordset.BOF Then
         Dim m_code As Variant
         
         name_form1.Recordset.Bookmark = DataList2.SelectedItem
         DataList2.Enabled = False
         If name_form1.Recordset![sub_typ] = "01" Then
           m_code = name_form1.Recordset![sub_typ] & name_form1.Recordset![sub_no]
           v_sub_no = m_code
           position.sql = " execute proc_pos" & "'" & m_code & "'"
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
        Line10.Visible = True
        m_rel.Visible = True
        Label10.Visible = True
        Label11.Visible = True
        DBList7.Visible = True

       ' name_form1.recordset.Bookmark = datalist2.SelectedItem
        m_code = name_form1.Recordset![sub_typ] & name_form1.Recordset![sub_no]
        m_rel = "01"
        DBList5.Enabled = False
        rel_form.sql = "execute rel_form_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        rel_form.Refresh
        SUBJECT.sql = "execute subject_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        SUBJECT.Refresh
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
         Line7.Visible = False
         
         DBList5.Visible = False
         DataList2.Enabled = True
         DataList2.SetFocus
         Label9.Visible = False
      Case 13
        DBList6.Visible = True
        Line8.Visible = True
         
  
        m_rel.Visible = True
        Label10.Visible = True
        Label11.Visible = True
        DBList7.Visible = True
       Command8.Visible = True
         Command9.Visible = True
       

       ' position.Resultset.Bookmark = DBList5.SelectedItem
       ' m_code = position.Resultset![pos_no]
        name_form1.Recordset.Bookmark = DataList2.SelectedItem
        m_code = name_form1.Recordset![sub_typ] & name_form1.Recordset![sub_no]
        m_rel = "01"
        DBList5.Enabled = False
        rel_form.sql = "execute rel_form_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        rel_form.Refresh
        SUBJECT.sql = "execute subject_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        SUBJECT.Refresh
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
On Error Resume Next
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
        ElseIf DataList1.Enabled = True Then
           DataList1.SetFocus
        ElseIf DataList2.Enabled = True Then
          DataList2.SetFocus
        ElseIf DBList5.Enabled = True Then
           DBList5.SetFocus
       End If
        SendKeys "{up}"
      Case 13
      If typ_serh = 2 Then
       If DataList1.Enabled = True Then
          m_desc = desc.Text
          m_len = Len(Trim(m_desc))
          pays1.RecordSource = "execute serh_form " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
          pays1.Refresh
          DataList1.Refresh
          DataList1.SetFocus
          SendKeys "{up}"
        ElseIf DataList2.Enabled = True Then
           pays1.Recordset.Bookmark = DataList1.SelectedItem
           v_typ = Mid(cod1.Resultset![sub_code], 3, 2)
           v_cod = Mid(pays1.Recordset![sub_no], 1, 3)
           m_desc = desc.Text
          m_len = Len(Trim(m_desc))
          name_form1.RecordSource = "execute serh1_form " & "'" & v_typ & "'" & "," & "'" & v_cod & "'" & "," & _
          "'" & m_desc & "'" & "," & "'" & m_len & "'"
          name_form1.Refresh
          DataList2.Refresh
          DataList2.SetFocus
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
     If DataList2.Enabled = True And DataList2.Visible = True Then
       If mod_typ = 1 Then
          pays1.Recordset.Bookmark = DataList1.SelectedItem
          v_typ = Mid(cod1.Resultset![sub_code], 3, 2)
          v_cod = Mid(pays1.Recordset![sub_no], 1, 3)
          m_desc = Trim(desc.Text)
          m_len = Len(Trim(m_desc))
          m_desc = m_desc + Space(60 - m_len)
          m_len = 60
          name_form1.RecordSource = "execute serh1_form " & "'" & v_typ & "'" & "," & "'" & v_cod & "'" & "," & _
          "'" & m_desc & "'" & "," & "'" & m_len & "'"
          name_form1.Refresh
          If Not name_form1.Recordset.EOF And Not name_form1.Recordset.BOF Then
                    MsgBox "Â–« «·«”„ „œŒ· ”«»ﬁ«!"
                    desc.SetFocus
            Else
                    Command3.SetFocus
           End If
           name_form1.RecordSource = "execute nam_form " & "'" & Trim(v_typ) & "'" & "," & "'" & Mid(pays1.Recordset![sub_no], 1, 3) & "'"
           name_form1.Refresh
       Else
             Command3.SetFocus
       End If
       
      Else
         Command3.SetFocus
      End If
   ElseIf typ_serh = 3 Then
         
         pays1.Recordset.Bookmark = DataList1.SelectedItem
          v_typ = Mid(cod1.Resultset![sub_code], 3, 2)
          v_cod = Mid(pays1.Recordset![sub_no], 1, 3)
          m_desc = desc.Text
          m_len = Len(Trim(m_desc))
          v_cod = v_typ + v_cod
          name_form1.RecordSource = "execute serh_wrdform1 " & "'" & m_desc & "'" & "," & "'" & m_len & "'" _
           & "," & "'" & v_cod & "'"
          name_form1.Refresh
          DataList2.Refresh
          DataList2.SetFocus
                typ_serh = 1
        Label3.Visible = False
       Label5.Visible = False
       Label6.Visible = False
        code.Visible = False
        desc.Visible = False
        Shape3.Visible = False
        SendKeys "{up}"
     ElseIf typ_serh = 4 Then
         m_desc = desc.Text
         m_len = Len(Trim(desc))
         name_form1.RecordSource = "execute serh_allform" & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         name_form1.Refresh
         DataList2.Refresh
         DataList2.SetFocus
        SendKeys "{up}"

     
      ElseIf typ_serh = 5 Then
          m_desc = desc
         m_len = Len(Trim(m_desc))
         name_form1.RecordSource = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         name_form1.Refresh
          DataList2.Refresh
          DataList2.SetFocus
          
       SendKeys "{up}"

      End If
   End Select
   
End Sub


Private Sub m_rel_Change()
On Error Resume Next
'        position.Resultset.Bookmark = DBList5.SelectedItem
'        m_code = position.Resultset![pos_no]
        name_form1.Recordset.Bookmark = DataList2.SelectedItem
        m_code = name_form1.Recordset![sub_typ] & name_form1.Recordset![sub_no]
        rel_form.sql = "execute rel_form_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        rel_form.Refresh
        SUBJECT.sql = "execute subject_proc " & "'" & m_code & "'" & "," & "'" & m_rel.Text & "'"
        SUBJECT.Refresh
        
End Sub

Private Sub m_rel_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  DBList6.SetFocus
End If
  
End Sub

Private Sub Text5_KeyPress(KeyAscii As Integer)
 On Error Resume Next
 Select Case KeyAscii
   Case 13
   If m_serh = 1 Then
     If typ_list = 1 Then
         m_desc = Text5.Text
         m_len = Len(Trim(Text5))
         frm_mcnz.sql = "execute serh_allform" & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         frm_mcnz.Refresh
        DBList8.Refresh
        DBList8.SetFocus
       SendKeys "{up}"

     ElseIf typ_list = 2 Then
       m_desc = Text5.Text
       m_len = Len(Trim(m_desc))
        frm_mcnz.sql = "execute serh_macnz" & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        frm_mcnz.Refresh
        DBList8.Refresh
        DBList8.SetFocus
        SendKeys "{up}"

     End If
  ElseIf m_serh = 2 Then
   If typ_list = 1 Then
         m_desc = Text5.Text
         m_len = Len(Trim(Text5))
         frm_mcnz.sql = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         frm_mcnz.Refresh
          DBList8.Refresh
          DBList8.SetFocus
          
       SendKeys "{up}"

     ElseIf typ_list = 2 Then
       m_desc = Text5.Text
       m_len = Len(Trim(m_desc))
        frm_mcnz.sql = "execute serh_wrdmacnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
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

