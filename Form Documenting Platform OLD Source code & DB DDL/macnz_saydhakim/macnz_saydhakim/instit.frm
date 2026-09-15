VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form instit_F 
   BackColor       =   &H00FFC0C0&
   Caption         =   "                                                                   «” „«—… „ƒ””…"
   ClientHeight    =   8835
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11880
   RightToLeft     =   -1  'True
   ScaleHeight     =   8835
   ScaleWidth      =   11880
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame3 
      Caption         =   "Frame3"
      Height          =   1455
      Left            =   6480
      RightToLeft     =   -1  'True
      TabIndex        =   16
      Top             =   120
      Visible         =   0   'False
      Width           =   2535
      Begin VB.CommandButton Command10 
         Caption         =   "«÷«›…"
         Height          =   495
         Left            =   1440
         RightToLeft     =   -1  'True
         TabIndex        =   18
         Top             =   720
         Width           =   735
      End
      Begin VB.CommandButton Command13 
         Caption         =   "«·€«¡ «·«„—"
         Height          =   495
         Left            =   360
         RightToLeft     =   -1  'True
         TabIndex        =   17
         Top             =   720
         Width           =   735
      End
      Begin VB.Label Label23 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C0C0C0&
         Caption         =   "               ÃœÌœ  "
         Height          =   375
         Left            =   720
         RightToLeft     =   -1  'True
         TabIndex        =   19
         Top             =   240
         Width           =   1335
      End
   End
   Begin MSDBCtls.DBList DBList1 
      Bindings        =   "instit.frx":0000
      Height          =   3375
      Left            =   1320
      TabIndex        =   31
      Top             =   1920
      Visible         =   0   'False
      Width           =   3975
      _ExtentX        =   7011
      _ExtentY        =   5953
      _Version        =   393216
      BackColor       =   16761024
      ListField       =   "SUB_NAME"
      BoundColumn     =   "sub_cod"
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox m_inst_website 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   1440
      RightToLeft     =   -1  'True
      TabIndex        =   38
      Top             =   4680
      Width           =   9255
   End
   Begin VB.TextBox m_inst_nolicense 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   7440
      RightToLeft     =   -1  'True
      TabIndex        =   34
      Top             =   6000
      Width           =   3255
   End
   Begin VB.TextBox m_sub_name 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   1320
      RightToLeft     =   -1  'True
      TabIndex        =   33
      Top             =   360
      Width           =   6495
   End
   Begin VB.TextBox m_vlg 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   1320
      RightToLeft     =   -1  'True
      TabIndex        =   29
      Top             =   1440
      Width           =   3975
   End
   Begin VB.TextBox M_INST_NO 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   8880
      RightToLeft     =   -1  'True
      TabIndex        =   23
      Top             =   360
      Width           =   1935
   End
   Begin VB.TextBox m_inst_name 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   1320
      RightToLeft     =   -1  'True
      TabIndex        =   22
      Top             =   960
      Width           =   9255
   End
   Begin MSRDC.MSRDC qualty 
      Height          =   330
      Left            =   4080
      Top             =   8160
      Visible         =   0   'False
      Width           =   2175
      _ExtentX        =   3836
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
      RecordSource    =   "select *from coding where (substring(sub_code,1,2) = '42')"
      UserName        =   ""
      Password        =   ""
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "qualty"
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
   Begin VB.CommandButton Command4 
      BackColor       =   &H008080FF&
      Caption         =   " ”ÃÌ·"
      Height          =   615
      Left            =   240
      MaskColor       =   &H000080FF&
      TabIndex        =   12
      Top             =   960
      Width           =   735
   End
   Begin VB.CommandButton Command7 
      Caption         =   "«·€‹‹«¡"
      Height          =   615
      Left            =   240
      TabIndex        =   11
      Top             =   1680
      Width           =   735
   End
   Begin VB.CommandButton Command11 
      Caption         =   "Œ—ÊÃ"
      Height          =   615
      Left            =   240
      RightToLeft     =   -1  'True
      TabIndex        =   10
      Top             =   2520
      Width           =   735
   End
   Begin VB.TextBox M_INST_EMAIL 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   5280
      RightToLeft     =   -1  'True
      TabIndex        =   8
      Top             =   3600
      Width           =   5415
   End
   Begin VB.TextBox M_inst_adrs 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   1320
      RightToLeft     =   -1  'True
      TabIndex        =   5
      Top             =   2640
      Width           =   9375
   End
   Begin VB.TextBox M_INST_TEL 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   5520
      RightToLeft     =   -1  'True
      TabIndex        =   3
      Top             =   3120
      Width           =   5175
   End
   Begin MSDBCtls.DBCombo M_inst_typ 
      Bindings        =   "instit.frx":0018
      Height          =   315
      Left            =   7440
      TabIndex        =   1
      Top             =   2040
      Width           =   3255
      _ExtentX        =   5741
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSRDC.MSRDC INSTIT 
      Height          =   330
      Left            =   8760
      Top             =   8160
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
      RecordSource    =   " "
      UserName        =   ""
      Password        =   ""
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "INSTIT"
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
   Begin MSRDC.MSRDC v_form1 
      Height          =   375
      Left            =   -360
      Top             =   8160
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
      RecordSource    =   " "
      UserName        =   ""
      Password        =   ""
      Connect         =   ""
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
      Left            =   0
      Top             =   8520
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
      RecordSource    =   " "
      UserName        =   ""
      Password        =   ""
      Connect         =   ""
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
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   -6240
      RightToLeft     =   -1  'True
      TabIndex        =   14
      Top             =   -1560
      Width           =   6375
   End
   Begin MSRDC.MSRDC TYPE 
      Height          =   330
      Left            =   6480
      Top             =   8160
      Visible         =   0   'False
      Width           =   2175
      _ExtentX        =   3836
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
      RecordSource    =   "select *from coding where (substring(sub_code,1,2) = '41')"
      UserName        =   ""
      Password        =   ""
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "TYPE"
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
   Begin MSRDC.MSRDC SUBJECT 
      Height          =   330
      Left            =   3240
      Top             =   7680
      Visible         =   0   'False
      Width           =   2175
      _ExtentX        =   3836
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
      RecordSource    =   "select *from coding where (substring(sub_code,1,2) = '40')"
      UserName        =   ""
      Password        =   ""
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "SUBJECT"
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
   Begin VB.TextBox m_inst_social_media 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   1440
      RightToLeft     =   -1  'True
      TabIndex        =   20
      Top             =   4200
      Width           =   9255
   End
   Begin MSMask.MaskEdBox m_inst_dte 
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "dd/MM/yy"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1033
         SubFormatType   =   3
      EndProperty
      Height          =   375
      Left            =   1440
      TabIndex        =   21
      Top             =   3600
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   661
      _Version        =   393216
      Appearance      =   0
      MaxLength       =   10
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   11.25
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   "dd/mm/yyyy"
      Mask            =   "##/##/####"
      PromptChar      =   "_"
   End
   Begin MSDBCtls.DBCombo M_inst_quality 
      Bindings        =   "instit.frx":002B
      Height          =   315
      Left            =   1320
      TabIndex        =   25
      Top             =   2040
      Width           =   3855
      _ExtentX        =   6800
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSDBCtls.DBCombo m_inst_subject 
      Bindings        =   "instit.frx":0040
      Height          =   315
      Left            =   7440
      TabIndex        =   27
      Top             =   1440
      Width           =   3255
      _ExtentX        =   5741
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSDBCtls.DBCombo m_inst_license 
      Bindings        =   "instit.frx":0056
      Height          =   315
      Left            =   7440
      TabIndex        =   36
      Top             =   5520
      Width           =   3255
      _ExtentX        =   5741
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSRDC.MSRDC LICENSE 
      Height          =   330
      Left            =   240
      Top             =   7440
      Visible         =   0   'False
      Width           =   2175
      _ExtentX        =   3836
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
      RecordSource    =   "select *from coding where (substring(sub_code,1,2) = '43')"
      UserName        =   ""
      Password        =   ""
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "LICENSE"
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
   Begin VB.Label Label13 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«·„Êﬁ⁄ «·«·ﬂ —Ê‰Ì"
      Height          =   375
      Left            =   10680
      RightToLeft     =   -1  'True
      TabIndex        =   39
      Top             =   4680
      Width           =   1095
   End
   Begin VB.Label Label10 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "‰Ê⁄ «·—Œ’…"
      Height          =   375
      Left            =   11040
      RightToLeft     =   -1  'True
      TabIndex        =   37
      Top             =   5520
      Width           =   495
   End
   Begin VB.Label Label7 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "—ﬁ„ «·—Œ’… :"
      Height          =   375
      Left            =   10560
      RightToLeft     =   -1  'True
      TabIndex        =   35
      Top             =   6000
      Width           =   975
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«”„ «·„ƒ””… :"
      Height          =   375
      Left            =   7680
      RightToLeft     =   -1  'True
      TabIndex        =   32
      Top             =   360
      Width           =   1095
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "„—ﬂ“ «ﬁ«„… «·„ƒ””…"
      Height          =   375
      Left            =   5280
      RightToLeft     =   -1  'True
      TabIndex        =   30
      Top             =   1440
      Width           =   1575
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   " ’‰Ì› «·„ƒ””…"
      Height          =   375
      Left            =   10680
      RightToLeft     =   -1  'True
      TabIndex        =   28
      Top             =   1560
      Width           =   1095
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "‰Ê⁄Â« :"
      Height          =   375
      Left            =   10680
      RightToLeft     =   -1  'True
      TabIndex        =   26
      Top             =   2040
      Width           =   495
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "—ﬁ„ «·„ƒ””… :"
      Height          =   255
      Left            =   10800
      RightToLeft     =   -1  'True
      TabIndex        =   24
      Top             =   360
      Width           =   975
   End
   Begin VB.Label Label21 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "Ê”«∆· «· Ê«’· «·«Ã „«⁄Ì"
      Height          =   375
      Left            =   10680
      RightToLeft     =   -1  'True
      TabIndex        =   15
      Top             =   4200
      Width           =   1095
   End
   Begin VB.Label Label20 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   " «—ÌŒ «· ”ÃÌ·"
      Height          =   495
      Left            =   3480
      RightToLeft     =   -1  'True
      TabIndex        =   13
      Top             =   3720
      Width           =   975
   End
   Begin VB.Shape Shape6 
      BorderWidth     =   2
      Height          =   2535
      Left            =   120
      Top             =   720
      Width           =   975
   End
   Begin VB.Label Label14 
      Alignment       =   1  'Right Justify
      Caption         =   "Label14"
      Height          =   135
      Left            =   4080
      RightToLeft     =   -1  'True
      TabIndex        =   9
      Top             =   6840
      Width           =   15
   End
   Begin VB.Label Label12 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   " E-MAIL :"
      Height          =   375
      Left            =   10920
      RightToLeft     =   -1  'True
      TabIndex        =   7
      Top             =   3600
      Width           =   735
   End
   Begin VB.Label Label11 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«”„ «·„ƒ””… »«··€… «·«Ã‰»Ì… :"
      Height          =   375
      Left            =   10680
      RightToLeft     =   -1  'True
      TabIndex        =   6
      Top             =   960
      Width           =   1095
   End
   Begin VB.Label Label9 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "⁄‰Ê«‰Â« :"
      Height          =   375
      Left            =   10680
      RightToLeft     =   -1  'True
      TabIndex        =   4
      Top             =   2640
      Width           =   975
   End
   Begin VB.Label Label8 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "—ﬁ„ Â« › «·„ƒ””…:"
      Height          =   375
      Left            =   10800
      RightToLeft     =   -1  'True
      TabIndex        =   2
      Top             =   3120
      Width           =   975
   End
   Begin VB.Label Label6 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "ÿ»Ì⁄… ‰‘«ÿÂ« «·«”«”Ì"
      Height          =   375
      Left            =   5160
      RightToLeft     =   -1  'True
      TabIndex        =   0
      Top             =   2040
      Width           =   1695
   End
   Begin VB.Shape Shape1 
      BorderWidth     =   2
      Height          =   6855
      Left            =   1200
      Shape           =   4  'Rounded Rectangle
      Top             =   -120
      Width           =   10695
   End
End
Attribute VB_Name = "instit_F"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim m_tabindex As Integer
Dim m_typ_opr, m_form_disp As Integer
Dim typ_serh As Integer





Function display_fld()
If Not IsNull(INSTIT.Resultset![inst_no]) Then
  M_INST_NO.Text = INSTIT.Resultset![inst_no]
 End If
If Not IsNull(INSTIT.Resultset![inst_name]) Then
  m_inst_name.Text = INSTIT.Resultset![inst_name]
 End If
  
If Not IsNull(INSTIT.Resultset![inst_dte]) Then
  m_inst_dte.Text = INSTIT.Resultset![inst_dte]
  Else
  m_inst_dte = "__/__/____"
 End If
 
 If Not IsNull(INSTIT.Resultset![inst_quality]) Then
      If INSTIT.Resultset![inst_quality] = "" Then
          M_inst_QUALTiY.BoundText = Space(3)
      Else
        M_inst_quality.BoundText = "42" + INSTIT.Resultset![inst_quality]
      End If
      End If
   
 If Not IsNull(INSTIT.Resultset![inst_SUBJECT]) Then
      If INSTIT.Resultset![inst_SUBJECT] = "" Then
          m_inst_subject.BoundText = Space(3)
      Else
        m_inst_subject.BoundText = "40" + INSTIT.Resultset![inst_SUBJECT]
      End If
      End If
   
 If Not IsNull(INSTIT.Resultset![inst_email]) Then
  M_INST_EMAIL.Text = INSTIT.Resultset![inst_email]
 End If
   If Not IsNull(INSTIT.Resultset![inst_adrs]) Then
  M_inst_adrs.Text = INSTIT.Resultset![inst_adrs]
 End If
If Not IsNull(INSTIT.Resultset![inst_tel]) Then
  M_INST_TEL.Text = INSTIT.Resultset![inst_tel]
 End If
If Not IsNull(INSTIT.Resultset![inst_email]) Then
  M_INST_EMAIL.Text = INSTIT.Resultset![inst_email]
 End If
 
 
 If Not IsNull(INSTIT.Resultset![inst_social_media]) Then
  m_inst_social_media.Text = INSTIT.Resultset![inst_social_media]
 End If
 If Not IsNull(INSTIT.Resultset![inst_typ]) Then
      If INSTIT.Resultset![inst_typ] = "" Then
          M_inst_typ.BoundText = Space(3)
      Else
        M_inst_typ.BoundText = "41" + INSTIT.Resultset![inst_typ]
      End If
      End If
      
  If Not IsNull(INSTIT.Resultset![inst_name]) Then
  m_inst_name.Text = INSTIT.Resultset![inst_name]
  Else
   m_inst_name.Text = ""
 End If
 If Not IsNull(INSTIT.Resultset![inst_website]) Then
  m_inst_website.Text = INSTIT.Resultset![inst_website]
  Else
  m_inst_website.Text = ""
 End If
 If Not IsNull(INSTIT.Resultset![inst_nolicense]) Then
  m_inst_nolicense.Text = INSTIT.Resultset![inst_nolicense]
  Else
  m_inst_nolicense.Text = ""
 End If
 
 If Not IsNull(INSTIT.Resultset![inst_license]) Then
      If INSTIT.Resultset![inst_license] = "" Then
          m_inst_license.BoundText = Space(3)
      Else
        m_inst_license.BoundText = "43" + INSTIT.Resultset![inst_license]
      End If
      End If
      
      
      
  m_form_disp = 2
 If Not IsNull(INSTIT.Resultset![inst_vlg]) Then
          m_inst_vlg = INSTIT.Resultset![inst_vlg]
           v_form1.sql = "EXEC SERH_SUB_NAME " & "'" & m_inst_vlg & "'"
           v_form1.Refresh
           
             If Not v_form1.Resultset.EOF And Not v_form1.Resultset.BOF Then
               m_vlg.Text = v_form1.Resultset![sub_name]
               Else
                 m_vlg.Text = ""
             End If
       Else
        m_vlg.Text = ""
    End If
End Function
Private Sub Command1_Click()
m_inst_website.Text = ""
m_inst_license.Text = ""
m_inst_nolicense.Text = ""
 m_inst_subject.Text = ""
m_inst_name.Text = ""
m_inst_dte.Text = ""
m_vlg.Text = ""
M_INST_TEL.Text = ""
M_INST_EMAIL.Text = ""
M_inst_adrs.Text = ""
M_INST_TEL.Text = ""
M_inst_QUALTY.Text = ""
m_inst_dte.Text = ""
m_typ_opr = 1
End Sub


Private Sub Command10_Click()
sql = "execute insr_instit " & "'" & M_INST_NO.Text & "'"
                cn.Execute sql, rdExecDirect

Frame3.Visible = False

 
End Sub

Private Sub Command11_Click()
Unload instit_F
End Sub

Private Sub Command12_Click()
Frame2.Visible = False
Command8.SetFocus
m_inst_name.SetFocus

End Sub

Private Sub Command13_Click()
 Frame3.Visible = False
End Sub

Private Sub Command14_Click()
 Frame3.Visible = False
 Command10.SetFocus
End Sub

Private Sub Command15_Click()
 Dim sql As String
Dim m_mn_app_no As String
Const None As String = ""
m_mn_app_no = m_ist_no.Text
INSTIT.sql = "exec SERH_instit " & "'" & m_mn_app_no & "'"
INSTIT.Refresh
typ_serh = 2
If Not INSTIT.Resultset.EOF Or Not INSTIT.Resultset.BOF Then
  Call display_fld
 Else
  MsgBox "·« ÌÊÃœ «” „«—… ·Â–« «·—ﬁ„ !!!!"

 End If
 Frame3.Visible = False
 Command10.SetFocus
End Sub

Private Sub Command2_Click()

'Dim cn As New rdoConnection
 Dim sql As String
 Dim m_bk_ser As Variant
   sql = "execute insr_instit " & "'" & M_INST_NO.Text & "'" & "," & "'" & m_inst_name.Text & "'" & "," _
   & "'" & Format(m_inst_dte.Text, "yyyy/mm/dd") & "'" & "," & "'" & m_inst_vlg & "'" & "," _
    & "'" & m_inst_icht & "'" & "," & "'" & M_inst_QUALTY.BoundText & "'" & "," _
     & "'" & m_inst_noinst & "'" & "," & "'" & M_inst_INST_TEL.Text & "'" & "," _
     & "'" & M_inst_INST_BOX.Text & "'" & "," & "'" & m_inst_nodirect & "'" & "," _
     & "'" & M_inst_INST_EMAIL.Text & "'" & "," & "'" & M_inst_ADRS1.Text & "'" & "," _
     & "'" & M_inst_adrs.Text & "'" & "," & "'" & M_INST_TEL.Text & "'" & "," _
      & "'" & M_inst_BOX.Text & "'" & "," & "'" & M_INST_EMAIL.Text & "'" & "," _
      & "'" & Format(m_inst_dte1.Text, "yyyy/mm/dd") & "'" & "," _
      & "'" & Format(m_inst_dte2.Text, "yyyy/mm/dd") & "'"
       
'       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
     m_typ_opr = 2
     Frame1.Visible = False
     INSTIT.Refresh
  Command1.SetFocus
  
End Sub

Private Sub Command3_Click()
Frame1.Visible = False
M_INST_EMAIL.SetFocus
End Sub

Private Sub Command4_Click()
'Dim cn As New rdoConnection
 Dim sql As String
  Dim m_dte  As Variant
 If m_inst_dte = "__/__/____" Then
    m_dte = ""
  Else
    m_dte = m_inst_dte.Text
 End If
 
  
   sql = "execute upd_instit " & "'" & M_INST_NO.Text & "'" & "," _
      & "'" & Format(m_dte, "yyyy/mm/dd") & "'" & "," _
      & "'" & Mid(M_inst_quality.BoundText, 3, 3) & "'" & "," _
      & "'" & Mid(m_inst_subject.BoundText, 3, 3) & "'" & "," _
      & "'" & Mid(M_inst_typ.BoundText, 3, 3) & "'" & "," _
      & "'" & M_inst_adrs.Text & "'" & "," & "'" & M_INST_TEL.Text & "'" & "," _
      & "'" & M_INST_EMAIL.Text & "'" & "," _
      & "'" & m_inst_social_media.Text & "'" & "," _
      & "'" & m_inst_name.Text & "'" & "," _
      & "'" & m_inst_vlg & "'" & "," _
      & "'" & m_inst_website.Text & "'" & "," _
      & "'" & Mid(m_inst_license.BoundText, 3, 3) & "'" & "," _
      & "'" & m_inst_nolicense.Text & "'"
      
         cn.Execute sql, rdExecDirect

  
   
End Sub

Private Sub Command5_Click()
If typ_serh = 2 Then
 INSTIT.sql = "select *from instit"
 INSTIT.Refresh
 typ_serh = 1
End If
If Not INSTIT.Resultset.BOF Then
  INSTIT.Resultset.MovePrevious
If Not INSTIT.Resultset.BOF Then
   Call display_fld
Else
 MsgBox "·«ÌÊÃœ «” „«—… ”«»ﬁ… .....!!!"
End If
End If

End Sub

Private Sub Command6_Click()
If typ_serh = 2 Then
 INSTIT.sql = "select *from instit"
 INSTIT.Refresh
 typ_serh = 1
End If
If Not INSTIT.Resultset.EOF Then
   INSTIT.Resultset.MoveNext
End If
If Not INSTIT.Resultset.EOF Then
   Call display_fld
Else
MsgBox "·« ÌÊÃœ «” „«—… ·«Õﬁ…....."
End If

End Sub

Private Sub Command7_Click()
'Dim cn As New rdoConnection
Dim sql As String
Dim ok As String
Const None As String = ""
 ok = " "
 ok = InputBox("Â·  —Ìœ «·€«¡ Â–Â «·«” „«—… ø(‰/ﬂ)")
' If ok = "y" Then
 If ok = "y" Or ok = "‰" Then
 sql = "exec del_instit" & "'" & M_INST_NO.Text & "'"
 cn.Execute sql, rdExecDirect
  INSTIT.Refresh
M_INST_NO.Text = ""
m_inst_name.Text = ""
m_inst_dte.Text = ""
m_vlg.Text = ""
m_inst_inst.Text = ""
M_inst_INST_TEL.Text = ""
M_inst_INST_BOX.Text = ""
M_inst_INST_EMAIL.Text = ""
M_inst_ADRS1.Text = ""
M_inst_adrs.Text = ""
M_INST_TEL.Text = ""
M_inst_BOX.Text = ""
M_INST_EMAIL.Text = ""
m_inst_inst_direct.Text = ""
M_inst_QUALTY.Text = ""
m_inst_dte1.Text = ""
m_inst_mzhb.Text = ""
m_inst_poltic.Text = ""
m_typ_opr = 1
  
End If

End Sub

Private Sub Command8_Click()
'Dim cn As New rdoConnection
 m_ist_name.Text = ""
 Frame2.Visible = True
 m_ist_name.SetFocus
 
 
End Sub

Private Sub Command9_Click()
Dim sql As String
Dim m_desc As String
Const None As String = ""
m_desc = m_ist_name.Text
If Not IsNull(m_desc) And Not Trim(m_desc) = "" Then
  m_len = Len(m_desc)
 INSTIT.sql = "exec SERH_instit1 " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
  INSTIT.Refresh
  typ_serh = 2
  Frame2.Visible = False
  
If Not INSTIT.Resultset.EOF Or Not INSTIT.Resultset.BOF Then
     DBList2.Visible = True
     DBList2.SetFocus
     SendKeys "{up}"
Else
  MsgBox "·« ÌÊÃœ «” „«—… ·Â–« «·—ﬁ„ !!!!"
End If
End If
End Sub

Private Sub DBList1_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF10 Then
   serch.Visible = True
   serch.Text = ""
   Label18.Visible = True
   serch.SetFocus
   SendKeys "{up}"
End If
End Sub

Private Sub DBList1_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then
  
      view_form.Resultset.Bookmark = DBList1.SelectedItem
      m_vlg.Text = view_form.Resultset![sub_name]
      m_inst_vlg = view_form.Resultset![sub_typ] + view_form.Resultset![sub_no]
    
 DBList1.Visible = False
   

ElseIf KeyAscii = 27 Then
  DBList1.Visible = False
     M_inst_typ.SetFocus
   
  
  
End If
End Sub

Private Sub DBList2_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 DBList2.Visible = False
 Call display_fld
  m_inst_name.SetFocus
  DBList2.Visible = False
ElseIf KeyAscii = 27 Then
 DBList2.Visible = False
End If
End Sub

Private Sub Form_Load()
typ_serh = 1
m_typ_opr = 2
m_form_disp = 1
m_inst_vlg = Space(10)
 
 m_mn_app_no = M_PRSNO
M_INST_NO.Text = M_PRSNO
m_sub_name = M_PRS_SUB_NAME
INSTIT.sql = "exec SERH_instit " & "'" & m_mn_app_no & "'"
INSTIT.Refresh
typ_serh = 2
If Not INSTIT.Resultset.EOF Or Not INSTIT.Resultset.BOF Then
  Call display_fld
 Else
  Frame3.Visible = True
'  Command10.SetFocus
  
 End If
End Sub

Private Sub m_inst_license_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_inst_nolicense.SetFocus
End If
End Sub

Private Sub m_inst_nolicense_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 Command4.SetFocus
End If
End Sub

Private Sub M_inst_quality_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_inst_adrs.SetFocus
End If

End Sub

Private Sub m_inst_social_media_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_inst_website.SetFocus
End If
End Sub

Private Sub M_inst_BOX_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_inst_dte1.SetFocus
End If

End Sub

 

Private Sub m_inst_subject_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
m_vlg.SetFocus

 
End If
End Sub

Private Sub M_inst_typ_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
M_inst_quality.SetFocus
  SendKeys "{f4}"
 
End If
End Sub

Private Sub m_inst_website_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
m_inst_license.SetFocus
  SendKeys "{f4}"
  End If
End Sub

 

 
Private Sub M_inst_ADRS_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_INST_TEL.SetFocus
End If
End Sub

Private Sub M_inst_ADRS1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
m_inst_inst_direct.SetFocus
 
End If
End Sub

 

 

Private Sub M_inst_DTE_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_inst_social_media.SetFocus
End If

End Sub

 

Private Sub M_inst_EMAIL_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_inst_dte.SetFocus
End If
End Sub

Private Sub M_inst_INST_BOX_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_inst_INST_EMAIL.SetFocus
End If

End Sub
 
Private Sub m_inst_name_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then

  m_inst_subject.SetFocus
  SendKeys "{f4}"
End If

End Sub

Private Sub m_inst_poltic_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
M_inst_QUALTY.SetFocus
  SendKeys "{f4}"
End If
End Sub

Private Sub M_inst_QUALTY_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
m_inst_inst.SetFocus
  
End If
End Sub

Private Sub M_inst_TEL_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_INST_EMAIL.SetFocus
End If
End Sub

Private Sub m_typ_icht_Click()
 If m_typ_icht = True Then
    m_inst_icht = 1
  End If
End Sub

Private Sub m_typ_icht_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_inst_name.SetFocus
 
  If m_typ_icht = True Then
    m_inst_icht = 1
  End If
  
End If
End Sub

Private Sub m_typ_icht1_Click()
 If m_typ_icht1 = True Then
    m_inst_icht = 2
  End If
End Sub

Private Sub m_typ_icht1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_inst_name.SetFocus
  If m_typ_icht1 = True Then
    m_inst_icht = 2
  End If
 
End If

End Sub

Private Sub m_vlg_Change()
If m_form_disp = 1 Then
 If DBList1.Visible = False Then
    DBList1.Visible = True
    DBList1.Left = 6720
      DBList1.Top = 2280
  End If
  m_tabindex = 44
  If Not Trim(m_vlg.Text) = "" Then
   '    If m_typ_serh = 1 Then
         m_desc = m_vlg.Text
         
         m_len = Len(Trim(m_vlg.Text))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
         
         
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If
     
   End If
   Else
   m_form_disp = 1
   End If
End Sub

Private Sub m_vlg_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 40 And Not m_vlg.Text = "" Then
   DBList1.SetFocus
   SendKeys "{UP}"
End If
End Sub

Private Sub M_VLG_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_inst_dte.SetFocus
End If

End Sub

Private Sub M_YESNO_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 Command2.SetFocus
End If
End Sub

Private Sub serch_KeyPress(KeyAscii As Integer)
     If KeyAscii = 13 Then
         m_desc = serch.Text
         m_len = Len(Trim(serch.Text))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
         DBList1.Refresh
         DBList1.SetFocus
         SendKeys "{UP}"
         serch.Visible = False
         Label18.Visible = False

         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If
        ElseIf KeyAscii = 27 Then
             serch.Visible = False
             Label18.Visible = False
             DBList1.SetFocus
             SendKeys "{up}"
             
          End If
End Sub

