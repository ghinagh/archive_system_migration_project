VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form picture_f 
   BackColor       =   &H00C0E0FF&
   Caption         =   "                                                        »—‰«„Ã  ÊÀÌﬁ «·’Ê— «·› Ê€—«›Ì…"
   ClientHeight    =   8490
   ClientLeft      =   60
   ClientTop       =   210
   ClientWidth     =   11880
   LinkTopic       =   "Form9"
   RightToLeft     =   -1  'True
   ScaleHeight     =   8490
   ScaleWidth      =   11880
   Begin VB.ComboBox m_pic_brind 
      Height          =   315
      ItemData        =   "picture_f.frx":0000
      Left            =   4320
      List            =   "picture_f.frx":0010
      RightToLeft     =   -1  'True
      TabIndex        =   77
      Top             =   3600
      Width           =   1575
   End
   Begin VB.ComboBox M_PIC_TYP1 
      Height          =   315
      ItemData        =   "picture_f.frx":0032
      Left            =   6600
      List            =   "picture_f.frx":004B
      RightToLeft     =   -1  'True
      TabIndex        =   75
      Top             =   6600
      Width           =   1095
   End
   Begin VB.CommandButton Command16 
      Caption         =   "› Õ «·’Ê—…"
      Height          =   735
      Left            =   240
      RightToLeft     =   -1  'True
      TabIndex        =   72
      Top             =   1800
      Width           =   615
   End
   Begin VB.TextBox m_pic_lbn 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   10080
      RightToLeft     =   -1  'True
      TabIndex        =   71
      Top             =   3600
      Width           =   615
   End
   Begin VB.TextBox m_pic_page 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   8640
      RightToLeft     =   -1  'True
      TabIndex        =   70
      Top             =   3600
      Width           =   615
   End
   Begin VB.TextBox m_pic_line 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   7080
      RightToLeft     =   -1  'True
      TabIndex        =   69
      Top             =   3600
      Width           =   615
   End
   Begin VB.TextBox m_pic_copy 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   1920
      RightToLeft     =   -1  'True
      TabIndex        =   65
      Top             =   5280
      Width           =   615
   End
   Begin VB.CommandButton Command9 
      Caption         =   "«· Õ·Ì·"
      Height          =   615
      Left            =   240
      RightToLeft     =   -1  'True
      TabIndex        =   63
      Top             =   7800
      Width           =   735
   End
   Begin VB.Frame Frame5 
      BackColor       =   &H00C0FFFF&
      Height          =   2295
      Left            =   1080
      RightToLeft     =   -1  'True
      TabIndex        =   58
      Top             =   240
      Visible         =   0   'False
      Width           =   3375
      Begin VB.CommandButton Command14 
         Caption         =   "«·€«¡ «·«„—"
         BeginProperty Font 
            Name            =   "Arabic Transparent"
            Size            =   9.75
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   555
         Left            =   240
         RightToLeft     =   -1  'True
         TabIndex        =   61
         Top             =   1440
         Width           =   855
      End
      Begin VB.CommandButton Command13 
         Caption         =   "»œÊ‰  ”ÃÌ·"
         BeginProperty Font 
            Name            =   "Arabic Transparent"
            Size            =   9.75
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   555
         Left            =   1320
         RightToLeft     =   -1  'True
         TabIndex        =   60
         Top             =   1440
         Width           =   855
      End
      Begin VB.CommandButton Command15 
         Caption         =   "„⁄  ”ÃÌ·"
         BeginProperty Font 
            Name            =   "Arabic Transparent"
            Size            =   9.75
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   555
         Left            =   2400
         RightToLeft     =   -1  'True
         TabIndex        =   59
         Top             =   1440
         Width           =   855
      End
      Begin VB.Label Label40 
         Alignment       =   2  'Center
         BackColor       =   &H00C0FFFF&
         Caption         =   "Â·  —Ìœ «·«‰ ﬁ«· «·Ï «·’›Õ… «·À«‰Ì… ø"
         BeginProperty Font 
            Name            =   "Arabic Transparent"
            Size            =   9.75
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   0
         RightToLeft     =   -1  'True
         TabIndex        =   62
         Top             =   240
         Width           =   3135
      End
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H00C0FFC0&
      Height          =   2415
      Left            =   7680
      RightToLeft     =   -1  'True
      TabIndex        =   53
      Top             =   0
      Visible         =   0   'False
      Width           =   3375
      Begin VB.TextBox M_YESNO 
         Alignment       =   1  'Right Justify
         Height          =   405
         Left            =   360
         RightToLeft     =   -1  'True
         TabIndex        =   56
         Top             =   600
         Width           =   375
      End
      Begin VB.CommandButton Command2 
         Caption         =   " ‰›Ì–"
         Height          =   495
         Left            =   2160
         RightToLeft     =   -1  'True
         TabIndex        =   55
         Top             =   1560
         Width           =   735
      End
      Begin VB.CommandButton Command3 
         Caption         =   "«·€«¡ «·«„—"
         Height          =   495
         Left            =   360
         RightToLeft     =   -1  'True
         TabIndex        =   54
         Top             =   1560
         Width           =   735
      End
      Begin VB.Label Label25 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C0FFC0&
         Caption         =   "Â·  —Ìœ «·€«¡  Â–Â «·«” „«—…  (‰ / ﬂ) "
         Height          =   255
         Left            =   720
         RightToLeft     =   -1  'True
         TabIndex        =   57
         Top             =   720
         Width           =   2655
      End
   End
   Begin VB.Frame Frame4 
      BackColor       =   &H00C0FFFF&
      Height          =   2415
      Left            =   4440
      RightToLeft     =   -1  'True
      TabIndex        =   48
      Top             =   120
      Visible         =   0   'False
      Width           =   3135
      Begin VB.CommandButton Command1 
         Caption         =   "«·€«¡ «·«„—"
         BeginProperty Font 
            Name            =   "Arabic Transparent"
            Size            =   9.75
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   360
         RightToLeft     =   -1  'True
         TabIndex        =   51
         Top             =   1560
         Width           =   735
      End
      Begin VB.CommandButton Command12 
         Caption         =   " ‰›»–"
         BeginProperty Font 
            Name            =   "Arabic Transparent"
            Size            =   9.75
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   1800
         RightToLeft     =   -1  'True
         TabIndex        =   50
         Top             =   1560
         Width           =   735
      End
      Begin VB.TextBox m_ist_no 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Arabic Transparent"
            Size            =   9.75
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   840
         RightToLeft     =   -1  'True
         TabIndex        =   49
         Top             =   720
         Width           =   1095
      End
      Begin VB.Label Label38 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C0FFFF&
         Caption         =   "—ﬁ„ «·«” „«—…"
         BeginProperty Font 
            Name            =   "Arabic Transparent"
            Size            =   9.75
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   1800
         RightToLeft     =   -1  'True
         TabIndex        =   52
         Top             =   720
         Width           =   1215
      End
   End
   Begin VB.CommandButton Command11 
      Caption         =   "«÷«›…"
      Height          =   615
      Left            =   240
      RightToLeft     =   -1  'True
      TabIndex        =   47
      Top             =   2640
      Width           =   615
   End
   Begin VB.CommandButton Command10 
      BackColor       =   &H80000007&
      Caption         =   "»Õ‹‹À"
      Height          =   615
      Left            =   240
      TabIndex        =   46
      Top             =   4200
      Width           =   615
   End
   Begin VB.CommandButton Command7 
      Caption         =   "«·€‹‹«¡"
      Height          =   615
      Left            =   240
      TabIndex        =   45
      Top             =   4920
      Width           =   615
   End
   Begin VB.CommandButton Command6 
      Caption         =   "·«Õ‹‹ﬁ"
      Height          =   615
      Left            =   240
      TabIndex        =   44
      Top             =   6360
      Width           =   615
   End
   Begin VB.CommandButton Command5 
      Caption         =   "”«»ﬁ"
      Height          =   615
      Left            =   240
      TabIndex        =   43
      Top             =   5640
      Width           =   615
   End
   Begin VB.CommandButton Command4 
      BackColor       =   &H008080FF&
      Caption         =   " ”ÃÌ·"
      Height          =   615
      Left            =   240
      MaskColor       =   &H000080FF&
      TabIndex        =   42
      Top             =   3480
      Width           =   615
   End
   Begin VB.CommandButton Command8 
      Caption         =   "Œ—ÊÃ"
      Height          =   615
      Left            =   240
      RightToLeft     =   -1  'True
      TabIndex        =   41
      Top             =   7080
      Width           =   615
   End
   Begin VB.TextBox Text4 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   0
      TabIndex        =   39
      Top             =   7320
      Visible         =   0   'False
      Width           =   2175
   End
   Begin VB.TextBox m_pic_rmrk 
      Alignment       =   1  'Right Justify
      Height          =   315
      Left            =   3000
      RightToLeft     =   -1  'True
      TabIndex        =   37
      Top             =   7440
      Width           =   7815
   End
   Begin VB.ComboBox m_pic_sub 
      Height          =   315
      ItemData        =   "picture_f.frx":0071
      Left            =   1440
      List            =   "picture_f.frx":0084
      RightToLeft     =   -1  'True
      TabIndex        =   35
      Top             =   6600
      Width           =   1575
   End
   Begin VB.ComboBox M_pic_qualty 
      Height          =   315
      ItemData        =   "picture_f.frx":00B8
      Left            =   4320
      List            =   "picture_f.frx":00CB
      RightToLeft     =   -1  'True
      TabIndex        =   33
      Top             =   6600
      Width           =   1575
   End
   Begin VB.TextBox m_pic_large 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   8640
      RightToLeft     =   -1  'True
      TabIndex        =   31
      Top             =   6480
      Width           =   615
   End
   Begin VB.TextBox m_pic_len 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   9960
      RightToLeft     =   -1  'True
      TabIndex        =   29
      Top             =   6480
      Width           =   615
   End
   Begin VB.ComboBox m_pic_form 
      Height          =   315
      ItemData        =   "picture_f.frx":00EA
      Left            =   1440
      List            =   "picture_f.frx":00FA
      RightToLeft     =   -1  'True
      TabIndex        =   27
      Top             =   5880
      Width           =   1575
   End
   Begin VB.ComboBox m_pic_typ 
      Height          =   315
      ItemData        =   "picture_f.frx":011C
      Left            =   4320
      List            =   "picture_f.frx":0129
      RightToLeft     =   -1  'True
      TabIndex        =   26
      Top             =   5880
      Width           =   1575
   End
   Begin VB.TextBox m_txt_pic_geo 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   7320
      RightToLeft     =   -1  'True
      TabIndex        =   23
      Top             =   5880
      Width           =   3375
   End
   Begin VB.TextBox m_txt_pic_cot 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   1680
      RightToLeft     =   -1  'True
      TabIndex        =   21
      Top             =   4560
      Width           =   3855
   End
   Begin VB.TextBox m_pic_tit 
      Alignment       =   1  'Right Justify
      Height          =   315
      Left            =   3600
      RightToLeft     =   -1  'True
      TabIndex        =   19
      Top             =   5280
      Width           =   7335
   End
   Begin MSDBCtls.DBCombo m_pic_ent 
      Bindings        =   "picture_f.frx":0146
      Height          =   315
      Left            =   4440
      TabIndex        =   11
      Top             =   3000
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox m_pic_pos_no 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   7560
      RightToLeft     =   -1  'True
      TabIndex        =   9
      Top             =   3120
      Width           =   975
   End
   Begin VB.TextBox m_pic_ng_no 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   9720
      RightToLeft     =   -1  'True
      TabIndex        =   7
      Top             =   3120
      Width           =   975
   End
   Begin MSMask.MaskEdBox m_pic_doc_dte 
      Height          =   375
      Left            =   1680
      TabIndex        =   5
      Top             =   2400
      Width           =   1215
      _ExtentX        =   2143
      _ExtentY        =   661
      _Version        =   393216
      MaxLength       =   8
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   9.75
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   "dd/mm/yy"
      Mask            =   "##/##/##"
      PromptChar      =   "_"
   End
   Begin MSDBCtls.DBCombo M_pic_doc 
      Bindings        =   "picture_f.frx":015E
      Height          =   315
      Left            =   4560
      TabIndex        =   3
      Top             =   2400
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox M_pic_no 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   9480
      RightToLeft     =   -1  'True
      TabIndex        =   1
      Top             =   2400
      Width           =   1095
   End
   Begin MSMask.MaskEdBox m_pic_ent_dte 
      Height          =   375
      Left            =   1680
      TabIndex        =   13
      Top             =   3000
      Width           =   1215
      _ExtentX        =   2143
      _ExtentY        =   661
      _Version        =   393216
      MaxLength       =   8
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   9.75
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   "dd/mm/yy"
      Mask            =   "##/##/##"
      PromptChar      =   "_"
   End
   Begin MSDBCtls.DBCombo m_pic_prs 
      Bindings        =   "picture_f.frx":0176
      Height          =   315
      Left            =   8880
      TabIndex        =   15
      Top             =   4560
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSMask.MaskEdBox m_pic_dte 
      Height          =   375
      Left            =   6360
      TabIndex        =   17
      Top             =   4560
      Width           =   1215
      _ExtentX        =   2143
      _ExtentY        =   661
      _Version        =   393216
      MaxLength       =   8
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   9.75
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   "dd/mm/yy"
      Mask            =   "##/##/##"
      PromptChar      =   "_"
   End
   Begin MSRDC.MSRDC v_coding3 
      Height          =   375
      Left            =   120
      Top             =   8040
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
   Begin MSRDC.MSRDC v_coding2 
      Height          =   375
      Left            =   2880
      Top             =   8040
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
      Caption         =   "v_coding2"
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
   Begin MSRDC.MSRDC v_coding18 
      Height          =   375
      Left            =   5520
      Top             =   8040
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
      RecordSource    =   "SELECT * FROM VIEW_CODING18"
      UserName        =   "ABBAS"
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "v_coding18"
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
      Bindings        =   "picture_f.frx":018F
      Height          =   2205
      Left            =   480
      TabIndex        =   38
      Top             =   240
      Visible         =   0   'False
      Width           =   4215
      _ExtentX        =   7435
      _ExtentY        =   3889
      _Version        =   393216
      BackColor       =   16777152
      ListField       =   "SUB_NAME"
      RightToLeft     =   -1  'True
   End
   Begin MSRDC.MSRDC v_form1 
      Height          =   375
      Left            =   120
      Top             =   7680
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
      UserName        =   "abbas"
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server = sequel;driver = {sql server};database=macnz;"
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
   Begin MSRDC.MSRDC picture_t 
      Height          =   375
      Left            =   7680
      Top             =   8040
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
      RecordSource    =   "select * from picture order by pic_no"
      UserName        =   "abbas"
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "picture_t"
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
   Begin MSRDC.MSRDC v_form2 
      Height          =   375
      Left            =   1800
      Top             =   8040
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
      UserName        =   "abbas"
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server = sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "v_form2"
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
      BackColor       =   &H00C0E0FF&
      Caption         =   "‰Ê⁄ «·Ê⁄«¡ «·ﬁœÌ„ :"
      Height          =   255
      Left            =   5760
      RightToLeft     =   -1  'True
      TabIndex        =   76
      Top             =   3600
      Width           =   1095
   End
   Begin VB.Label Label27 
      Alignment       =   1  'Right Justify
      Caption         =   "Label27"
      Height          =   15
      Left            =   8160
      RightToLeft     =   -1  'True
      TabIndex        =   74
      Top             =   6840
      Width           =   135
   End
   Begin VB.Label Label26 
      Alignment       =   2  'Center
      BackColor       =   &H00C0E0FF&
      Caption         =   "‰Ê⁄ «·’Ê—… :"
      Height          =   495
      Left            =   7680
      RightToLeft     =   -1  'True
      TabIndex        =   73
      Top             =   6600
      Width           =   855
   End
   Begin VB.Label Label24 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "«·”ÿ— :"
      Height          =   255
      Left            =   7440
      RightToLeft     =   -1  'True
      TabIndex        =   68
      Top             =   3600
      Width           =   855
   End
   Begin VB.Label Label23 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "«·’›Õ… :"
      Height          =   255
      Left            =   9120
      RightToLeft     =   -1  'True
      TabIndex        =   67
      Top             =   3600
      Width           =   855
   End
   Begin VB.Label Label22 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "—ﬁ„ «·«·»Ê‰ :"
      Height          =   255
      Left            =   10800
      RightToLeft     =   -1  'True
      TabIndex        =   66
      Top             =   3600
      Width           =   855
   End
   Begin VB.Label Label20 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "⁄œœ «·‰”Œ"
      Height          =   375
      Left            =   2520
      RightToLeft     =   -1  'True
      TabIndex        =   64
      Top             =   5280
      Width           =   975
   End
   Begin VB.Shape Shape6 
      BorderWidth     =   2
      Height          =   6735
      Left            =   120
      Top             =   1680
      Width           =   975
   End
   Begin VB.Label Label21 
      Caption         =   "«·»ÕÀ"
      Height          =   255
      Left            =   2280
      RightToLeft     =   -1  'True
      TabIndex        =   40
      Top             =   7320
      Visible         =   0   'False
      Width           =   615
   End
   Begin VB.Shape Shape3 
      BorderWidth     =   3
      Height          =   6255
      Left            =   1080
      Top             =   1680
      Width           =   10815
   End
   Begin VB.Label Label19 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "«·„·«Õ‹‹Ÿ‹‹«    :"
      Height          =   255
      Left            =   10680
      RightToLeft     =   -1  'True
      TabIndex        =   36
      Top             =   7440
      Width           =   1095
   End
   Begin VB.Label Label18 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "«·„÷„‹‹Ê‰   :"
      Height          =   375
      Left            =   3000
      RightToLeft     =   -1  'True
      TabIndex        =   34
      Top             =   6600
      Width           =   855
   End
   Begin VB.Label Label17 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "«·Ã‹‹Êœ…   :"
      Height          =   255
      Left            =   5640
      RightToLeft     =   -1  'True
      TabIndex        =   32
      Top             =   6600
      Width           =   855
   End
   Begin VB.Label Label16 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "«·⁄—÷ :"
      Height          =   255
      Left            =   9120
      RightToLeft     =   -1  'True
      TabIndex        =   30
      Top             =   6480
      Width           =   735
   End
   Begin VB.Label Label15 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "«·ﬁÌ«” : «·ÿÊ· :"
      Height          =   255
      Left            =   10560
      RightToLeft     =   -1  'True
      TabIndex        =   28
      Top             =   6480
      Width           =   1095
   End
   Begin VB.Label Label14 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "«·‘ﬂ· «·’Ê—…"
      Height          =   375
      Left            =   2880
      RightToLeft     =   -1  'True
      TabIndex        =   25
      Top             =   5880
      Width           =   1095
   End
   Begin VB.Label Label13 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "‰Ê⁄ «· ’ÊÌ—"
      Height          =   255
      Left            =   5880
      RightToLeft     =   -1  'True
      TabIndex        =   24
      Top             =   5880
      Width           =   975
   End
   Begin VB.Label Label12 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "„ﬂ«‰ «·’Ê—… :"
      Height          =   255
      Left            =   10680
      RightToLeft     =   -1  'True
      TabIndex        =   22
      Top             =   5880
      Width           =   975
   End
   Begin VB.Label Label11 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "«·„’‹‹œ— :"
      Height          =   255
      Left            =   5400
      RightToLeft     =   -1  'True
      TabIndex        =   20
      Top             =   4560
      Width           =   855
   End
   Begin VB.Label Label10 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "«·⁄‰Ê«‰ :"
      Height          =   255
      Left            =   10680
      RightToLeft     =   -1  'True
      TabIndex        =   18
      Top             =   5280
      Width           =   855
   End
   Begin VB.Label Label9 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   " «—ÌŒ «· ’ÊÌ—  :"
      Height          =   255
      Left            =   7560
      RightToLeft     =   -1  'True
      TabIndex        =   16
      Top             =   4560
      Width           =   1095
   End
   Begin VB.Label Label8 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "«·„’Ê— :"
      Height          =   255
      Left            =   10800
      RightToLeft     =   -1  'True
      TabIndex        =   14
      Top             =   4560
      Width           =   735
   End
   Begin VB.Shape Shape2 
      BorderWidth     =   2
      Height          =   2895
      Left            =   1320
      Top             =   4200
      Width           =   10455
   End
   Begin VB.Label Label7 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   " «—ÌŒ «·«œŒ«·  :"
      Height          =   255
      Left            =   3120
      RightToLeft     =   -1  'True
      TabIndex        =   12
      Top             =   3000
      Width           =   1095
   End
   Begin VB.Label Label6 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "„œŒ· «·»Ì«‰« "
      Height          =   255
      Left            =   6240
      RightToLeft     =   -1  'True
      TabIndex        =   10
      Top             =   3000
      Width           =   975
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "—ﬁ„ «·«ÌÃ«»Ì :"
      Height          =   255
      Left            =   8520
      RightToLeft     =   -1  'True
      TabIndex        =   8
      Top             =   3120
      Width           =   1095
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "—ﬁ„ «·”·»Ì :"
      Height          =   255
      Left            =   10680
      RightToLeft     =   -1  'True
      TabIndex        =   6
      Top             =   3120
      Width           =   855
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   " «—ÌŒ «· ÊÀÌﬁ  :"
      Height          =   255
      Left            =   3240
      RightToLeft     =   -1  'True
      TabIndex        =   4
      Top             =   2400
      Width           =   1095
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "«·„ÊÀﬁ   :"
      Height          =   255
      Left            =   6360
      RightToLeft     =   -1  'True
      TabIndex        =   2
      Top             =   2400
      Width           =   735
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      Caption         =   "—ﬁ„ «·’Ê—… :"
      Height          =   255
      Left            =   10680
      RightToLeft     =   -1  'True
      TabIndex        =   0
      Top             =   2400
      Width           =   855
   End
   Begin VB.Shape Shape1 
      BorderWidth     =   2
      Height          =   1695
      Left            =   1320
      Top             =   2280
      Width           =   10455
   End
End
Attribute VB_Name = "picture_f"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim m_tabindex As Integer
Dim m_pic_geo As String
Dim m_pic_cot As String
Dim m_typ_serh As Integer
Dim m_typ_opr As Integer

Function display_fld()
If Not IsNull(picture_t.Resultset![pic_no]) Then
   M_pic_no.Text = picture_t.Resultset![pic_no]
Else
   M_pic_no.Text = ""
 End If
If Not IsNull(picture_t.Resultset![pic_ng_no]) Then
   m_pic_ng_no.Text = picture_t.Resultset![pic_ng_no]
Else
   m_pic_ng_no.Text = ""
 End If
 If Not IsNull(picture_t.Resultset![pic_pos_no]) Then
   m_pic_pos_no.Text = picture_t.Resultset![pic_pos_no]
Else
   m_pic_pos_no.Text = ""
 End If
 If Not IsNull(picture_t.Resultset![pic_doc_dte]) Then
   m_pic_doc_dte.Text = Format(picture_t.Resultset![pic_doc_dte], "dd/mm/yy")
Else
   m_pic_doc_dte.Text = "__/__/__"
 End If
If Not IsNull(picture_t.Resultset![pic_ent_dte]) Then
   m_pic_ent_dte.Text = Format(picture_t.Resultset![pic_ent_dte], "dd/mm/yy")
Else
   m_pic_ent_dte.Text = "__/__/__"
 End If
  If Not IsNull(picture_t.Resultset![pic_doc]) Then
     M_pic_doc.BoundText = "01" + picture_t.Resultset![pic_doc]
   Else
     M_pic_doc.BoundText = "   "
   End If
If Not IsNull(picture_t.Resultset![pic_ent]) Then
     m_pic_ent.BoundText = "02" + picture_t.Resultset![pic_ent]
   Else
     m_pic_ent.BoundText = "  "
   End If
If Not IsNull(picture_t.Resultset![pic_tit]) Then
   m_pic_tit.Text = picture_t.Resultset![pic_tit]
Else
   m_pic_tit.Text = ""
 End If
 If Not IsNull(picture_t.Resultset![pic_prs]) Then
     m_pic_prs.BoundText = "18" + picture_t.Resultset![pic_prs]
   Else
     m_pic_prs.BoundText = "   "
   End If
   
    If Not IsNull(picture_t.Resultset![pic_typ]) Then
     m_pic_typ.ListIndex = picture_t.Resultset![pic_typ]
   Else
     m_pic_typ.ListIndex = 0
   End If
   If Not IsNull(picture_t.Resultset![pic_TYP1]) Then
     M_PIC_TYP1.ListIndex = picture_t.Resultset![pic_TYP1]
   Else
     M_PIC_TYP1.ListIndex = 0
   End If

   If Not IsNull(picture_t.Resultset![pic_qualty]) Then
     M_pic_qualty.ListIndex = picture_t.Resultset![pic_qualty]
   Else
     M_pic_qualty.ListIndex = 0
   End If
   If Not IsNull(picture_t.Resultset![pic_form]) Then
     m_pic_form.ListIndex = picture_t.Resultset![pic_form]
   Else
     m_pic_form.ListIndex = 0
   End If
   If Not IsNull(picture_t.Resultset![pic_sub]) Then
     m_pic_sub.ListIndex = picture_t.Resultset![pic_sub]
   Else
     m_pic_sub.ListIndex = 0
   End If
     If Not IsNull(picture_t.Resultset![pic_brind]) Then
     m_pic_brind.ListIndex = picture_t.Resultset![pic_brind]
   Else
     m_pic_brind.ListIndex = 0
   End If

If Not IsNull(picture_t.Resultset![pic_len]) Then
   m_pic_len.Text = picture_t.Resultset![pic_len]
Else
   m_pic_len.Text = ""
 End If
 If Not IsNull(picture_t.Resultset![pic_large]) Then
   m_pic_large.Text = picture_t.Resultset![pic_large]
Else
   m_pic_large.Text = ""
 End If
If Not IsNull(picture_t.Resultset![pic_rmrk]) Then
   m_pic_rmrk.Text = picture_t.Resultset![pic_rmrk]
Else
   m_pic_rmrk.Text = ""
 End If

If Not IsNull(picture_t.Resultset![pic_copy]) Then
   m_pic_copy.Text = picture_t.Resultset![pic_copy]
Else
   m_pic_rmrk.Text = 0
 End If
If Not IsNull(picture_t.Resultset![pic_lbn]) Then
   m_pic_lbn.Text = picture_t.Resultset![pic_lbn]
Else
   m_pic_lbn.Text = ""
 End If
 If Not IsNull(picture_t.Resultset![pic_page]) Then
   m_pic_page.Text = picture_t.Resultset![pic_page]
Else
   m_pic_page.Text = ""
 End If
 If Not IsNull(picture_t.Resultset![pic_line]) Then
   m_pic_line.Text = picture_t.Resultset![pic_line]
Else
   m_pic_line.Text = ""
 End If
If Not IsNull(picture_t.Resultset![pic_dte]) Then
   m_pic_dte.Text = Format(picture_t.Resultset![pic_dte], "dd/mm/yy")
Else
   m_pic_dte.Text = "__/__/__"
 End If
 If Not IsNull(picture_t.Resultset![pic_cot]) Then
           m_pic_cot = picture_t.Resultset![pic_cot]
           v_form2.SQL = "EXEC SERH_SUB_NAME " & "'" & m_pic_cot & "'"
           v_form2.Refresh
           
             If Not v_form2.Resultset.EOF And Not v_form2.Resultset.BOF Then
               m_txt_pic_cot.Text = v_form2.Resultset![sub_name]
               Else
                 m_txt_pic_cot.Text = ""
             End If
       Else
        m_txt_pic_cot.Text = ""
    End If
     If Not IsNull(picture_t.Resultset![pic_geo]) Then
           m_pic_geo = picture_t.Resultset![pic_geo]
           v_form2.SQL = "EXEC SERH_SUB_NAME " & "'" & m_pic_geo & "'"
           v_form2.Refresh
           
             If Not v_form2.Resultset.EOF And Not v_form2.Resultset.BOF Then
               m_txt_pic_geo.Text = v_form2.Resultset![sub_name]
               Else
                 m_txt_pic_geo.Text = ""
             End If
       Else
        m_txt_pic_geo.Text = ""
    End If

End Function



Private Sub Command1_Click()
Frame4.Visible = False
Command10.SetFocus

End Sub

Private Sub Command10_Click()

Frame4.Visible = True
m_ist_no.Text = ""
m_ist_no.SetFocus

End Sub

Private Sub Command11_Click()
Dim SQL As String

If Not picture_t.Resultset.EOF Then
   v_prs_no = "000000"
   v_prs_no1 = "000000"
   m_no = 0
    picture_t.SQL = "select picture.* from picture order by pic_no"
    picture_t.Refresh
    picture_t.Resultset.MoveLast
    m_no = Val(Mid(picture_t.Resultset![pic_no], 2, 6))
    m_no1 = Val(Mid(picture_t.Resultset![pic_pos_no], 2, 6))
    m_no = m_no + 1
    m_no1 = m_no1 + 1
    v_prs_no = Mid(v_prs_no, 1, 6 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
    v_prs_no1 = Mid(v_prs_no1, 1, 6 - Len(Trim(Str(m_no1)))) + Trim(Str(m_no1))
    M_pic_no.Text = v_prs_no
    m_pic_pos_no.Text = v_prs_no1
    
Else
  M_pic_no.Text = "000001"
  m_pic_pos_no.Text = "000001"
End If
M_pic_no.Text = "’" + M_pic_no.Text
SQL = "execute insr_pic " & "'" & M_pic_no.Text & "'" & "," & "'" & m_pic_pos_no.Text & "'"
cn.Execute SQL, rdExecDirect
 picture_t.Refresh

m_typ_opr = 1
 M_pic_doc.Text = ""
 m_pic_ent.Text = ""
 m_pic_tit.Text = ""
 m_pic_ng_no.Text = ""
 m_pic_typ.ListIndex = 0
 M_pic_qualty.ListIndex = 0
 m_pic_form.ListIndex = 0
 m_pic_sub.ListIndex = 0
 m_pic_brind.ListIndex = 0
 m_pic_line.Text = ""
 m_pic_page.Text = ""
 m_txt_pic_geo.Text = ""
 m_txt_pic_cot.Text = ""
 m_pic_dte.Text = "__/__/__"
 m_pic_ent_dte.Text = Format(Date, "dd/mm/yy")
 m_pic_doc_dte.Text = "__/__/__"
 m_pic_len.Text = ""
 m_pic_large.Text = ""
 m_pic_rmrk.Text = ""
 m_pic_prs.BoundText = ""
 M_pic_doc.SetFocus
 m_pic_lbn.Text = ""
 M_PIC_TYP1.ListIndex = 0
 m_pic_copy.Text = ""
 SendKeys "{f4}"
 
End Sub

Private Sub Command12_Click()
'Dim cn As New rdoConnection
Dim SQL As String
Const None As String = ""
picture_t.SQL = "exec SERCH_picture " & "'" & m_ist_no.Text & "'"
picture_t.Refresh
typ_serh = 2
If Not picture_t.Resultset.EOF Or Not picture_t.Resultset.BOF Then
  Call display_fld
   Frame4.Visible = False
  Else
  MsgBox "·« ÌÊÃœ «” „«—… ·Â–« «·—ﬁ„ !!!!"
  m_ist_no.Text = ""
  m_ist_no.SetFocus

End If
m_typ_opr = 2

End Sub

Private Sub Command13_Click()
 Frame5.Visible = False
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form2.WindowState = 2
 Form2.Show
 Screen.MousePointer = vbDefault

End Sub

Private Sub Command14_Click()
 Frame5.Visible = False
 Command9.SetFocus
 
End Sub

Private Sub Command15_Click()
  Dim SQL As String
'  Dim cn As New rdoConnection
  Dim m_ddte, m_dte, m_edte As Variant
 
'If m_typ_opr = 1 Then
' If m_pic_doc_dte.Text = "__/__/__" Then
'      m_ddte = ""
'    Else
'     m_ddte = m_pic_doc_dte.Text
' End If
' If m_pic_dte = "__/__/__" Then
'    m_dte = ""
'  Else
'    m_dte = m_pic_dte.Text
' End If
'If m_pic_ent_dte = "__/__/__" Then
'    m_edte = ""
'  Else
'    m_edte = m_pic_ent_dte.Text
' End If
'
' SQL = "execute  insr_picture " & "'" & M_pic_no.Text & "'" & "," & "'" & m_pic_ng_no.Text & "'" _
'                                    & "," & "'" & m_pic_pos_no.Text & "'" & "," & "'" & Mid(M_pic_doc.BoundText, 3, 2) & "'" _
'                                    & "," & "'" & Mid(m_pic_ent.BoundText, 3, 2) & "'" _
'                                    & "," & "'" & Format(m_ddte, "yyyy/mm/dd") & "'" _
'                                    & "," & "'" & Format(m_edte, "yyyy/mm/dd") & "'" & "," & "'" & Mid(m_pic_prs.BoundText, 3, 2) & "'" _
'                                    & "," & "'" & m_pic_cot & "'" & "," & "'" & m_pic_tit.Text & "'" _
'                                    & "," & "'" & m_pic_geo & "'" & "," & "'" & m_pic_typ.ListIndex & "'" & "," & "'" & M_pic_qualty.ListIndex & "'" _
'                                    & "," & "'" & m_pic_form.ListIndex & "'" & "," & "'" & m_pic_sub.ListIndex & "'" _
'                                    & "," & "'" & m_pic_len.Text & "'" & "," & "'" & m_pic_large.Text & "'" _
'                                    & "," & "'" & Format(m_dte, "yyyy/mm/dd") & "'" & "," & "'" & m_pic_rmrk.Text & "'" _
'                                   & "," & "'" & m_pic_copy.Text & "'" & "," & "'" & m_pic_lbn.Text & "'" _
'                                   & "," & "'" & m_pic_page.Text & "'" & "," & "'" & m_pic_line.Text & "'" _
'                                    & "," & "'" & M_PIC_TYP1.ListIndex & "'" _
'                                    & "," & "'" & m_pic_brind.ListIndex & "'"
'
'
''              cn.Connect = "uid=;pwd=;server=SEQUEL;" _
''           & "driver={SQL Server};database=macnz;" _
''           & "DSN='';"
''            cn.CursorDriver = rdUseOdbc
''           cn.EstablishConnection rdDriverNoPrompt
'           cn.Execute SQL, rdExecDirect
'           picture_t.Refresh
'
'ElseIf m_typ_opr = 2 Then

 If m_pic_doc_dte.Text = "__/__/__" Then
      m_ddte = ""
    Else
     m_ddte = m_pic_doc_dte.Text
 End If
 If m_pic_dte = "__/__/__" Then
    m_dte = ""
  Else
    m_dte = m_pic_dte.Text
 End If
If m_pic_ent_dte = "__/__/__" Then
    m_edte = ""
  Else
    m_edte = m_pic_ent_dte.Text
 End If

 SQL = "execute  upd_picture " & "'" & M_pic_no.Text & "'" & "," & "'" & m_pic_ng_no.Text & "'" _
                                    & "," & "'" & m_pic_pos_no.Text & "'" & "," & "'" & Mid(M_pic_doc.BoundText, 3, 2) & "'" _
                                    & "," & "'" & Mid(m_pic_ent.BoundText, 3, 2) & "'" _
                                    & "," & "'" & Format(m_ddte, "yyyy/mm/dd") & "'" _
                                    & "," & "'" & Format(m_edte, "yyyy/mm/dd") & "'" & "," & "'" & Mid(m_pic_prs.BoundText, 3, 2) & "'" _
                                    & "," & "'" & m_pic_cot & "'" & "," & "'" & m_pic_tit.Text & "'" _
                                    & "," & "'" & m_pic_geo & "'" & "," & "'" & m_pic_typ.ListIndex & "'" & "," & "'" & M_pic_qualty.ListIndex & "'" _
                                    & "," & "'" & m_pic_form.ListIndex & "'" & "," & "'" & m_pic_sub.ListIndex & "'" _
                                    & "," & "'" & m_pic_len.Text & "'" & "," & "'" & m_pic_large.Text & "'" _
                                    & "," & "'" & Format(m_dte, "yyyy/mm/dd") & "'" & "," & "'" & m_pic_rmrk.Text & "'" _
                                   & "," & "'" & m_pic_copy.Text & "'" & "," & "'" & m_pic_lbn.Text & "'" _
                                   & "," & "'" & m_pic_page.Text & "'" & "," & "'" & m_pic_line.Text & "'" _
                                     & "," & "'" & M_PIC_TYP1.ListIndex & "'" _
                                    & "," & "'" & m_pic_brind.ListIndex & "'"
                                             
'              cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'           cn.EstablishConnection rdDriverNoPrompt
           cn.Execute SQL, rdExecDirect
 picture_t.Refresh

'End If
   
   
   Frame5.Visible = False
   
  Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form2.WindowState = 2
 Form2.Show
 Screen.MousePointer = vbDefault

End Sub

Private Sub Command16_Click()
  V_REC = m_pic_pos_no.Text
  M_CD = "\\Server\C\PICTURES\"
  M_NAM = "c:\acdsee32\acdsee32.exe " & M_CD
  M_NAM1 = Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\" & V_REC & "." & Trim(M_PIC_TYP1.Text)
  M_NAM = M_NAM & M_NAM1
  x = Shell(M_NAM, 1)
  
End Sub

Private Sub Command2_Click()
'Dim cn As New rdoConnection
Dim SQL As String
Const None As String = ""
 Frame1.Visible = False
Command7.SetFocus

If M_YESNO = "‰" Or M_YESNO = "Y" Or M_YESNO = "y" Then
    SQL = "exec del_picture " & "'" & M_pic_no.Text & "'"
    cn.Execute SQL, rdExecDirect
  
  M_pic_no.Text = ""
  m_pic_pos_no.Text = ""
 M_pic_doc.Text = ""
 m_pic_ent.Text = ""
 m_pic_tit.Text = ""
 m_pic_ng_no.Text = ""
 m_pic_typ.ListIndex = 0
 M_pic_qualty.ListIndex = 0
 m_pic_form.ListIndex = 0
 m_pic_sub.ListIndex = 0
 m_pic_brind.ListIndex = 0
 m_pic_line.Text = ""
 m_pic_page.Text = ""
 m_txt_pic_geo.Text = ""
 m_txt_pic_cot.Text = ""
 m_pic_dte.Text = "__/__/__"
 m_pic_ent_dte.Text = Format(Date, "dd/mm/yy")
 m_pic_doc_dte.Text = "__/__/__"
 m_pic_len.Text = ""
 m_pic_large.Text = ""
 m_pic_rmrk.Text = ""
 m_pic_prs.BoundText = ""
 M_pic_doc.SetFocus
 m_pic_lbn.Text = ""
 M_PIC_TYP1.ListIndex = 0
 m_pic_copy.Text = ""

End If
End Sub

Private Sub Command4_Click()
  Dim SQL As String
'  Dim cn As New rdoConnection
  Dim m_ddte, m_dte, m_edte As Variant
 
' If m_typ_opr = 1 Then
 
' If m_pic_doc_dte.Text = "__/__/__" Then
'      m_ddte = ""
'    Else
'     m_ddte = m_pic_doc_dte.Text
' End If
' If m_pic_dte = "__/__/__" Then
'    m_dte = ""
'  Else
'    m_dte = m_pic_dte.Text
' End If
'If m_pic_ent_dte = "__/__/__" Then
'    m_edte = ""
'  Else
'    m_edte = m_pic_ent_dte.Text
' End If
'
' SQL = "execute  insr_picture " & "'" & M_pic_no.Text & "'" & "," & "'" & m_pic_ng_no.Text & "'" _
'                                    & "," & "'" & m_pic_pos_no.Text & "'" & "," & "'" & Mid(M_pic_doc.BoundText, 3, 2) & "'" _
'                                    & "," & "'" & Mid(m_pic_ent.BoundText, 3, 2) & "'" _
'                                    & "," & "'" & Format(m_ddte, "yyyy/mm/dd") & "'" _
'                                    & "," & "'" & Format(m_edte, "yyyy/mm/dd") & "'" & "," & "'" & Mid(m_pic_prs.BoundText, 3, 2) & "'" _
''                                    & "," & "'" & m_pic_cot & "'" & "," & "'" & m_pic_tit.Text & "'" _
 '                                   & "," & "'" & m_pic_geo & "'" & "," & "'" & m_pic_typ.ListIndex & "'" & "," & "'" & M_pic_qualty.ListIndex & "'" _
 '                                   & "," & "'" & m_pic_form.ListIndex & "'" & "," & "'" & m_pic_sub.ListIndex & "'" _
 '                                   & "," & "'" & m_pic_len.Text & "'" & "," & "'" & m_pic_large.Text & "'" _
 '                                   & "," & "'" & Format(m_dte, "yyyy/mm/dd") & "'" & "," & "'" & m_pic_rmrk.Text & "'" _
 '                                   & "," & "'" & m_pic_copy.Text & "'" & "," & "'" & m_pic_lbn.Text & "'" _
 '                                   & "," & "'" & m_pic_page.Text & "'" & "," & "'" & m_pic_line.Text & "'" _
 '                                   & "," & "'" & M_PIC_TYP1.ListIndex & "'" _
 '                                   & "," & "'" & m_pic_brind.ListIndex & "'"
'
'
           '   cn.Connect = "uid=;pwd=;server=SEQUEL;" _
          ' & "driver={SQL Server};database=macnz;" _
         '  & "DSN='';"
        '    cn.CursorDriver = rdUseOdbc
        '   cn.EstablishConnection rdDriverNoPrompt
'           cn.Execute SQL, rdExecDirect
'           picture_t.Refresh
'ElseIf m_typ_opr = 2 Then

 If m_pic_doc_dte.Text = "__/__/__" Then
      m_ddte = ""
    Else
     m_ddte = m_pic_doc_dte.Text
 End If
 If m_pic_dte = "__/__/__" Then
    m_dte = ""
  Else
    m_dte = m_pic_dte.Text
 End If
If m_pic_ent_dte = "__/__/__" Then
    m_edte = ""
  Else
    m_edte = m_pic_ent_dte.Text
 End If

 SQL = "execute  upd_picture " & "'" & M_pic_no.Text & "'" & "," & "'" & m_pic_ng_no.Text & "'" _
                                    & "," & "'" & m_pic_pos_no.Text & "'" & "," & "'" & Mid(M_pic_doc.BoundText, 3, 2) & "'" _
                                    & "," & "'" & Mid(m_pic_ent.BoundText, 3, 2) & "'" _
                                    & "," & "'" & Format(m_ddte, "yyyy/mm/dd") & "'" _
                                    & "," & "'" & Format(m_edte, "yyyy/mm/dd") & "'" & "," & "'" & Mid(m_pic_prs.BoundText, 3, 2) & "'" _
                                    & "," & "'" & m_pic_cot & "'" & "," & "'" & m_pic_tit.Text & "'" _
                                    & "," & "'" & m_pic_geo & "'" & "," & "'" & m_pic_typ.ListIndex & "'" & "," & "'" & M_pic_qualty.ListIndex & "'" _
                                    & "," & "'" & m_pic_form.ListIndex & "'" & "," & "'" & m_pic_sub.ListIndex & "'" _
                                    & "," & "'" & m_pic_len.Text & "'" & "," & "'" & m_pic_large.Text & "'" _
                                    & "," & "'" & Format(m_dte, "yyyy/mm/dd") & "'" & "," & "'" & m_pic_rmrk.Text & "'" _
                                    & "," & "'" & m_pic_copy.Text & "'" & "," & "'" & m_pic_lbn.Text & "'" _
                                    & "," & "'" & m_pic_page.Text & "'" & "," & "'" & m_pic_line.Text & "'" _
                                    & "," & "'" & M_PIC_TYP1.ListIndex & "'" _
                                    & "," & "'" & m_pic_brind.ListIndex & "'"
  
                                             
           cn.Execute SQL, rdExecDirect
           picture_t.Refresh

'End If
End Sub

Private Sub Command5_Click()
 m_no = 1
 m_no = Val(Mid(picture_t.Resultset![pic_no], 2, 6))
 v_prs_no = "000000"
 While m_no >= 1
    m_no = m_no - 1
    v_prs_no = Mid(v_prs_no, 1, 6 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
    M_pic_no.Text = v_prs_no
    If Not picture_t.Resultset.BOF Then
      Call display_fld
      m_no = 0
    End If
  Wend
    
   ' MsgBox "·« ÌÊÃœ «” „«—… ”«»ﬁ… ................"
 
 

End Sub

Private Sub Command6_Click()
If typ_serh = 2 Then
 picture_t.SQL = "select *from picture"
 picture_t.Refresh
 typ_serh = 1
End If
If Not picture_t.Resultset.EOF Then
picture_t.Resultset.MoveNext
End If
If Not picture_t.Resultset.EOF Then
  Call display_fld
Else
 MsgBox "·« ÌÊÃœ «” „«—… ·«Õﬁ… ...........ø"
 End If
End Sub

Private Sub Command7_Click()
  Frame1.Visible = True
  M_YESNO.SetFocus
End Sub

Private Sub Command8_Click()
Unload picture_f
End Sub

Private Sub Command9_Click()
Frame5.Visible = True
Command15.SetFocus


End Sub

Private Sub DBList1_KeyDown(KeyCode As Integer, Shift As Integer)
  
  If KeyCode = vbKeyF8 Then
      m_typ_serh = 1
     Text4.Visible = True
      Label21.Visible = True
      Text4.SetFocus
      Text4.Text = ""
       SendKeys "{up}"
       
ElseIf KeyCode = vbKeyF9 Then
      m_typ_serh = 2
     Text4.Visible = True
      Label21.Visible = True
      Text4.SetFocus
      Text4.Text = ""
      SendKeys "{up}"
'ElseIf KeyCode = vbKeyDown Or KeyCode = vbKeyPageDown Or KeyCode = vbKeyEnd Then
'   m_bookmark = 2
  End If
 

End Sub

Private Sub DBList1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then

  v_form1.Resultset.Bookmark = DBList1.SelectedItem
  m_no = v_form1.Resultset![sub_typ] + v_form1.Resultset![sub_no]
  m_desc = v_form1.Resultset![sub_name]
    DBList1.Visible = False
    
    
    Select Case m_tabindex
      Case 21
        m_txt_pic_cot.Text = m_desc
        m_pic_cot = m_no
        m_pic_tit.SetFocus
      Case 23
       m_txt_pic_geo.Text = m_desc
        m_pic_geo = m_no
        m_pic_typ.SetFocus
        SendKeys "{f4}"
      End Select
  ElseIf KeyAscii = 27 Then
     DBList1.Visible = False
    
    
    Select Case m_tabindex
      Case 21
       m_txt_pic_cot.SetFocus
      Case 23
        m_txt_pic_geo.SetFocus
      End Select
  End If
End Sub

Private Sub Form_Load()
m_typ_opr = 2
If m_form_load = 2 Then
   picture_t.SQL = "exec SERCH_picture " & "'" & m_bk_no & "'"
   picture_t.Refresh
   Call display_fld
End If
End Sub

Private Sub m_ist_no_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 Then
   If Not m_ist_no = "" Then
    v_prs_no = "000000"
     m_no = m_ist_no.Text
     v_prs_no = Mid(v_prs_no, 1, 6 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
     m_ist_no.Text = "’" + v_prs_no
     Command12.SetFocus
   End If
  End If
End Sub

Private Sub m_pic_brind_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_pic_prs.SetFocus
 SendKeys "{f4}"
End If
End Sub

Private Sub m_pic_copy_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_txt_pic_geo.SetFocus
End If

End Sub

Private Sub m_pic_doc_dte_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_pic_ng_no.SetFocus
End If

End Sub

Private Sub M_pic_doc_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_pic_doc_dte.SetFocus
 
End If
End Sub

Private Sub m_pic_dte_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_txt_pic_cot.SetFocus
End If
End Sub

Private Sub m_pic_ent_dte_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_pic_lbn.SetFocus
End If
End Sub

Private Sub m_pic_ent_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_pic_ent_dte.SetFocus
 
End If
End Sub

Private Sub m_pic_form_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_pic_len.SetFocus
End If
End Sub

Private Sub m_pic_large_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_PIC_TYP1.SetFocus
  SendKeys "{f4}"
End If
End Sub

Private Sub m_pic_lbn_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_pic_page.SetFocus
End If
End Sub

Private Sub m_pic_len_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_pic_large.SetFocus
End If
End Sub

Private Sub m_pic_line_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_pic_brind.SetFocus
 SendKeys "{f4}"
End If
End Sub

Private Sub m_pic_ng_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_pic_pos_no.SetFocus
End If
End Sub

Private Sub m_pic_page_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_pic_line.SetFocus
End If
End Sub

Private Sub m_pic_pos_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 picture_t.SQL = "exec SERCH_picture1 " & "'" & m_pic_pos_no.Text & "'"
 picture_t.Refresh
 If Not picture_t.Resultset.EOF Or Not picture_t.Resultset.BOF Then
   MsgBox "Â–« «·—ﬁ„ „ÊÃÊœ ”«»ﬁ«....."
   m_pic_pos_no.Text = ""
   m_pic_pos_no.SetFocus
 Else
    m_pic_ent.SetFocus
   SendKeys "{f4}"
 End If
End If
End Sub

Private Sub m_pic_prs_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_pic_dte.SetFocus
End If
End Sub

Private Sub M_pic_qualty_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_pic_sub.SetFocus
 SendKeys "{f4}"
End If
End Sub

Private Sub m_pic_rmrk_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Frame5.Visible = True
  Command15.SetFocus
 End If
  
  
End Sub

Private Sub m_pic_sub_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_pic_rmrk.SetFocus
End If
End Sub

Private Sub m_pic_tit_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_pic_copy.SetFocus
End If
End Sub

Private Sub m_pic_typ_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_pic_form.SetFocus
 SendKeys "{f4}"
End If

End Sub

Private Sub M_PIC_TYP1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_pic_qualty.SetFocus
 SendKeys "{f4}"
End If
End Sub

Private Sub m_txt_pic_cot_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  If m_txt_pic_cot.Text = "" Then
   m_tabindex = m_txt_pic_cot.TabIndex
    
   DBList1.Visible = True
   DBList1.SetFocus
    SendKeys "{up}"
    
  Else
    m_pic_tit.SetFocus
  End If
ElseIf KeyAscii = 27 Then
  m_pic_tit.SetFocus
End If
End Sub

Private Sub m_txt_pic_geo_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  If m_txt_pic_geo.Text = "" Then
  m_tabindex = m_txt_pic_geo.TabIndex
   DBList1.Visible = True
   DBList1.SetFocus
    SendKeys "{up}"
  Else
    m_pic_typ.SetFocus
    SendKeys "{f4}"
  End If
ElseIf KeyAscii = 27 Then
  m_pic_typ.SetFocus
    SendKeys "{f4}"
End If

End Sub

Private Sub SSTab1_DblClick()

End Sub

Private Sub M_YESNO_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 Command2.SetFocus
 
End If
End Sub

Private Sub Text4_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
    If m_typ_serh = 1 Then
         m_desc = Text4.Text
         m_len = Len(Trim(Text4))
         v_form1.SQL = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         v_form1.Refresh
         DBList1.Refresh
         DBList1.SetFocus
         m_bookmark = 1
         SendKeys "{UP}"
       ' DBList12.SelectedItem = DBList12.VisibleItems(1)
        
         If v_form1.Resultset.EOF Or v_form1.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If
         
        
        Text4.Visible = False
      Label21.Visible = False
 ElseIf m_typ_serh = 2 Then
    m_bookmark = 1
         m_desc = Text4.Text
         m_len = Len(Trim(Text4))
         v_form1.SQL = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         v_form1.Refresh
        DBList1.Refresh
        DBList1.SetFocus
         SendKeys "{UP}"
         If v_form1.Resultset.EOF Or v_form1.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If

        Text4.Visible = False
        Label21.Visible = False

    End If
 ElseIf KeyAscii = 27 Then
      DBList1.Visible = False
      Text4.Visible = False
      Label16.Visible = False
   
  End If
 
End Sub
