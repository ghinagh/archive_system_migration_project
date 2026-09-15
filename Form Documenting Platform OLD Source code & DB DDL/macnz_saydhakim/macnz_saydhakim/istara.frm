VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form istara 
   BackColor       =   &H00C0E0FF&
   Caption         =   " «–‰ «·«” ⁄«—…"
   ClientHeight    =   8595
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11880
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form9"
   RightToLeft     =   -1  'True
   ScaleHeight     =   8595
   ScaleWidth      =   11880
   Begin MSDBCtls.DBList DBList1 
      Bindings        =   "istara.frx":0000
      Height          =   2460
      Left            =   4440
      TabIndex        =   53
      Top             =   2760
      Visible         =   0   'False
      Width           =   4215
      _ExtentX        =   7435
      _ExtentY        =   4339
      _Version        =   393216
      BackColor       =   8438015
      ForeColor       =   -2147483634
      ListField       =   "SUB_NAME"
      BoundColumn     =   "sub_cod"
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
   Begin VB.TextBox m_txt_extcote 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "Arabic Transparent"
         Size            =   9.75
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   4560
      RightToLeft     =   -1  'True
      TabIndex        =   52
      Top             =   1560
      Width           =   4215
   End
   Begin VB.CommandButton Command7 
      Appearance      =   0  'Flat
      BackColor       =   &H000080FF&
      Caption         =   "«·ÿ»«⁄…"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   8760
      MaskColor       =   &H00FF0000&
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   48
      Top             =   1920
      UseMaskColor    =   -1  'True
      Width           =   1215
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H0080C0FF&
      Caption         =   "«·€«¡ «–‰ «” ⁄«—…"
      Height          =   1575
      Left            =   1920
      RightToLeft     =   -1  'True
      TabIndex        =   12
      Top             =   2520
      Visible         =   0   'False
      Width           =   3615
      Begin VB.TextBox M_YESNO 
         Alignment       =   1  'Right Justify
         Height          =   405
         Left            =   240
         RightToLeft     =   -1  'True
         TabIndex        =   21
         Top             =   240
         Width           =   375
      End
      Begin VB.CommandButton Command2 
         BackColor       =   &H000080FF&
         Caption         =   " ‰›Ì–"
         Height          =   495
         Left            =   1920
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   14
         Top             =   960
         Width           =   1575
      End
      Begin VB.CommandButton Command3 
         BackColor       =   &H000080FF&
         Caption         =   "«·€«¡ «·«„—"
         Height          =   495
         Left            =   120
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   13
         Top             =   960
         Width           =   1575
      End
      Begin VB.Label Label15 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Â·  —Ìœ «·€«¡  «·«–‰ (‰ / ﬂ) "
         Height          =   255
         Left            =   720
         RightToLeft     =   -1  'True
         TabIndex        =   15
         Top             =   360
         Width           =   2655
      End
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H0080C0FF&
      Caption         =   "«·»ÕÀ ⁄‰ «” „«—… „⁄Ì‰…"
      Height          =   1575
      Left            =   5040
      RightToLeft     =   -1  'True
      TabIndex        =   16
      Top             =   2520
      Visible         =   0   'False
      Width           =   3495
      Begin VB.CommandButton Command13 
         BackColor       =   &H000080FF&
         Caption         =   "«·€«¡ «·«„—"
         Height          =   495
         Left            =   240
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   20
         Top             =   840
         Width           =   855
      End
      Begin VB.CommandButton Command12 
         BackColor       =   &H000080FF&
         Caption         =   " ‰›Ì–"
         Height          =   495
         Left            =   240
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   19
         Top             =   240
         Width           =   855
      End
      Begin VB.TextBox m_ist_no 
         Alignment       =   1  'Right Justify
         Height          =   375
         Left            =   1920
         RightToLeft     =   -1  'True
         TabIndex        =   18
         Top             =   840
         Width           =   1215
      End
      Begin VB.Label Label8 
         Alignment       =   1  'Right Justify
         BackColor       =   &H008080FF&
         BackStyle       =   0  'Transparent
         Caption         =   "—ﬁ„ «·«” „«—…"
         Height          =   375
         Left            =   2160
         RightToLeft     =   -1  'True
         TabIndex        =   17
         Top             =   360
         Width           =   975
      End
   End
   Begin VB.Frame Frame5 
      BackColor       =   &H0080C0FF&
      Caption         =   "⁄‰Ê«‰ «·‘—Ìÿ"
      Height          =   1095
      Left            =   1560
      RightToLeft     =   -1  'True
      TabIndex        =   43
      Top             =   240
      Visible         =   0   'False
      Width           =   8055
      Begin VB.TextBox m_vtitle 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         Height          =   285
         Left            =   1320
         MaxLength       =   70
         RightToLeft     =   -1  'True
         TabIndex        =   47
         Top             =   480
         Width           =   6495
      End
      Begin VB.CommandButton Command6 
         BackColor       =   &H000080FF&
         Caption         =   "«·€«¡ «·«„—"
         Height          =   375
         Left            =   120
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   45
         Top             =   120
         Width           =   975
      End
      Begin VB.CommandButton Command5 
         BackColor       =   &H000080FF&
         Caption         =   " ‰›Ì–"
         Height          =   375
         Left            =   120
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   44
         Top             =   600
         Width           =   975
      End
      Begin VB.Label Label16 
         Alignment       =   1  'Right Justify
         BackColor       =   &H000080FF&
         BackStyle       =   0  'Transparent
         Caption         =   "⁄‰Ê«‰ «·‘—Ìÿ "
         Height          =   255
         Left            =   6840
         RightToLeft     =   -1  'True
         TabIndex        =   46
         Top             =   240
         Visible         =   0   'False
         Width           =   975
      End
   End
   Begin MSMask.MaskEdBox m_opr_dte 
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
      Left            =   9960
      TabIndex        =   42
      Top             =   1080
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   661
      _Version        =   393216
      MaxLength       =   8
      Format          =   "dd/mm/yy"
      Mask            =   "##/##/##"
      PromptChar      =   "_"
   End
   Begin VB.Frame Frame3 
      BackColor       =   &H00C0E0FF&
      BorderStyle     =   0  'None
      Caption         =   "‘«‘… «·«Ê«„—"
      Height          =   735
      Left            =   840
      RightToLeft     =   -1  'True
      TabIndex        =   24
      Top             =   1800
      Width           =   7935
      Begin VB.CommandButton Command18 
         Appearance      =   0  'Flat
         BackColor       =   &H000080FF&
         Caption         =   "«–‰ ÃœÌœ"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   6360
         MaskColor       =   &H00FF0000&
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   29
         Top             =   120
         UseMaskColor    =   -1  'True
         Width           =   1575
      End
      Begin VB.CommandButton Command17 
         Appearance      =   0  'Flat
         BackColor       =   &H000080FF&
         Caption         =   " ”ÃÌ·(F4)"
         Height          =   495
         Left            =   4800
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   28
         Top             =   120
         Width           =   1575
      End
      Begin VB.CommandButton Command16 
         BackColor       =   &H000080FF&
         Caption         =   "«·»ÕÀ(F10)"
         Height          =   495
         Left            =   3360
         MaskColor       =   &H008080FF&
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   27
         Top             =   120
         Width           =   1455
      End
      Begin VB.CommandButton Command15 
         BackColor       =   &H000080FF&
         Caption         =   "«·€«˙¡"
         Height          =   495
         Left            =   1920
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   26
         Top             =   120
         Width           =   1455
      End
      Begin VB.CommandButton Command9 
         BackColor       =   &H000080FF&
         Caption         =   "Œ‹‹—ÊÃ"
         Height          =   495
         Left            =   0
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   25
         Top             =   120
         Width           =   1935
      End
   End
   Begin MSDBCtls.DBCombo m_opr_prsto 
      Bindings        =   "istara.frx":0018
      Height          =   315
      Left            =   840
      TabIndex        =   23
      Top             =   1080
      Width           =   2775
      _ExtentX        =   4895
      _ExtentY        =   556
      _Version        =   393216
      BackColor       =   16777215
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSDBCtls.DBCombo m_opr_cotto 
      Bindings        =   "istara.frx":002F
      Height          =   315
      Left            =   840
      TabIndex        =   22
      Top             =   480
      Width           =   2775
      _ExtentX        =   4895
      _ExtentY        =   556
      _Version        =   393216
      BackColor       =   16777215
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSDBCtls.DBCombo m_opr_prsfrm 
      Bindings        =   "istara.frx":0046
      Height          =   315
      Left            =   5880
      TabIndex        =   11
      Top             =   1080
      Width           =   2895
      _ExtentX        =   5106
      _ExtentY        =   556
      _Version        =   393216
      BackColor       =   16777215
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox m_opr_time 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
      Height          =   285
      Left            =   10080
      RightToLeft     =   -1  'True
      TabIndex        =   8
      Top             =   1800
      Width           =   1455
   End
   Begin MSDBCtls.DBCombo m_opr_cotfrm 
      Bindings        =   "istara.frx":005D
      Height          =   315
      Left            =   5880
      TabIndex        =   4
      Top             =   480
      Width           =   2895
      _ExtentX        =   5106
      _ExtentY        =   556
      _Version        =   393216
      BackColor       =   16777215
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox m_opr_no 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
      Enabled         =   0   'False
      Height          =   285
      Left            =   9960
      RightToLeft     =   -1  'True
      TabIndex        =   1
      Top             =   480
      Width           =   1455
   End
   Begin MSRDC.MSRDC opr_chrt 
      Height          =   330
      Left            =   2520
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
      RecordSource    =   "select * from opr_chrt"
      UserName        =   "sa"
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "opr_chrt"
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
   Begin MSRDC.MSRDC jad_opr_chrt 
      Height          =   330
      Left            =   4800
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
      RecordSource    =   ""
      UserName        =   "sa"
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "jad_opr_chrt"
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
   Begin MSRDC.MSRDC coding07 
      Height          =   330
      Left            =   6840
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
      RecordSource    =   "select * from view_coding7"
      UserName        =   "sa"
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "coding07"
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
   Begin MSRDC.MSRDC coding08 
      Height          =   330
      Left            =   8880
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
      RecordSource    =   "select * from view_coding31"
      UserName        =   "sa"
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "coding08"
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
   Begin MSRDC.MSRDC tmp_mch 
      Height          =   330
      Left            =   240
      Top             =   8280
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
      RecordSource    =   ""
      UserName        =   "sa"
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "tmp_mch"
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
   Begin VB.Frame Frame4 
      BackColor       =   &H0080C0FF&
      Caption         =   "—„“ «·‘—Ìÿ"
      Height          =   2775
      Left            =   3960
      RightToLeft     =   -1  'True
      TabIndex        =   30
      Top             =   4080
      Visible         =   0   'False
      Width           =   6255
      Begin VB.TextBox m_cha_time 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         Height          =   285
         Left            =   4320
         MaxLength       =   50
         RightToLeft     =   -1  'True
         TabIndex        =   49
         Top             =   2160
         Width           =   1575
      End
      Begin VB.TextBox M_OPR_NO1 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   405
         Left            =   4320
         RightToLeft     =   -1  'True
         TabIndex        =   32
         Top             =   240
         Width           =   1575
      End
      Begin MSMask.MaskEdBox m_opr_dte1 
         Height          =   375
         Left            =   240
         TabIndex        =   41
         Top             =   360
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   661
         _Version        =   393216
         BackColor       =   16777215
         MaxLength       =   8
         Format          =   "dd/mm/yy"
         Mask            =   "##/##/##"
         PromptChar      =   "_"
      End
      Begin VB.CommandButton Command4 
         BackColor       =   &H000080FF&
         Caption         =   "«·€«¡ «·«„—"
         Height          =   615
         Left            =   240
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   40
         Top             =   2040
         Width           =   1095
      End
      Begin VB.CommandButton Command1 
         BackColor       =   &H000080FF&
         Caption         =   " ”ÃÌ·"
         Height          =   615
         Left            =   1560
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   39
         Top             =   2040
         Width           =   1095
      End
      Begin VB.TextBox m_opr_title 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         Height          =   285
         Left            =   240
         MaxLength       =   70
         RightToLeft     =   -1  'True
         TabIndex        =   38
         Top             =   960
         Width           =   5655
      End
      Begin VB.TextBox m_opr_rmk 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         Height          =   285
         Left            =   240
         MaxLength       =   50
         RightToLeft     =   -1  'True
         TabIndex        =   36
         Top             =   1560
         Width           =   5655
      End
      Begin VB.TextBox M_OPR_SUB 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         Height          =   405
         Left            =   3720
         RightToLeft     =   -1  'True
         TabIndex        =   33
         Top             =   240
         Width           =   495
      End
      Begin VB.Label Label13 
         Alignment       =   1  'Right Justify
         BackColor       =   &H0080C0FF&
         BackStyle       =   0  'Transparent
         Caption         =   "«·„œ…"
         Height          =   255
         Left            =   5040
         RightToLeft     =   -1  'True
         TabIndex        =   50
         Top             =   1920
         Width           =   855
      End
      Begin VB.Label Label12 
         Alignment       =   1  'Right Justify
         BackColor       =   &H0080C0FF&
         BackStyle       =   0  'Transparent
         Caption         =   "⁄‰Ê«‰ «·‘—Ìÿ "
         Height          =   255
         Left            =   4920
         RightToLeft     =   -1  'True
         TabIndex        =   37
         Top             =   720
         Width           =   975
      End
      Begin VB.Label Label11 
         Alignment       =   1  'Right Justify
         BackColor       =   &H0080C0FF&
         BackStyle       =   0  'Transparent
         Caption         =   "„·«ÕŸ« "
         Height          =   255
         Left            =   5040
         RightToLeft     =   -1  'True
         TabIndex        =   35
         Top             =   1320
         Width           =   855
      End
      Begin VB.Label Label10 
         Alignment       =   1  'Right Justify
         BackColor       =   &H0080C0FF&
         BackStyle       =   0  'Transparent
         Caption         =   " «—ÌŒ «·«—Ã«⁄ "
         Height          =   255
         Left            =   360
         RightToLeft     =   -1  'True
         TabIndex        =   34
         Top             =   120
         Width           =   1095
      End
      Begin VB.Label Label9 
         Alignment       =   1  'Right Justify
         BackColor       =   &H0080C0FF&
         BackStyle       =   0  'Transparent
         Caption         =   "—„“ «·‘—Ìÿ "
         Height          =   255
         Left            =   4560
         RightToLeft     =   -1  'True
         TabIndex        =   31
         Top             =   0
         Visible         =   0   'False
         Width           =   855
      End
   End
   Begin MSDBGrid.DBGrid DBGrid1 
      Bindings        =   "istara.frx":0074
      Height          =   5535
      Left            =   360
      OleObjectBlob   =   "istara.frx":008F
      TabIndex        =   5
      Top             =   2640
      Width           =   11415
   End
   Begin MSRDC.MSRDC view_form 
      Height          =   330
      Left            =   0
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
      RecordSource    =   "select * from pay_form"
      UserName        =   "sa"
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
   Begin VB.Shape Shape1 
      BackColor       =   &H00C0E0FF&
      BorderColor     =   &H0080C0FF&
      BorderWidth     =   3
      Height          =   2415
      Left            =   360
      Shape           =   4  'Rounded Rectangle
      Top             =   120
      Width           =   11415
   End
   Begin VB.Label Label14 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      BackStyle       =   0  'Transparent
      Caption         =   "«·ÃÂ… «·Œ«—ÃÌ…"
      Height          =   255
      Left            =   7080
      RightToLeft     =   -1  'True
      TabIndex        =   51
      Top             =   1320
      Width           =   1575
   End
   Begin VB.Label Label7 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      BackStyle       =   0  'Transparent
      Caption         =   "«·‘Œ’ «·„”·„ "
      Height          =   255
      Left            =   7560
      RightToLeft     =   -1  'True
      TabIndex        =   10
      Top             =   840
      Width           =   1215
   End
   Begin VB.Label Label6 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      BackStyle       =   0  'Transparent
      Caption         =   "«·‘Œ’ «·„” ·„ "
      Height          =   255
      Left            =   2400
      RightToLeft     =   -1  'True
      TabIndex        =   9
      Top             =   840
      Width           =   1215
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      BackStyle       =   0  'Transparent
      Caption         =   "«·ÃÂ… «·„” ·„…  "
      Height          =   255
      Left            =   2400
      RightToLeft     =   -1  'True
      TabIndex        =   7
      Top             =   240
      Width           =   1215
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      BackStyle       =   0  'Transparent
      Caption         =   "«·Êﬁ "
      Height          =   255
      Left            =   10800
      RightToLeft     =   -1  'True
      TabIndex        =   6
      Top             =   1560
      Width           =   735
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      BackStyle       =   0  'Transparent
      Caption         =   "«·ÃÂ… «·„”·„… "
      Height          =   255
      Left            =   7560
      RightToLeft     =   -1  'True
      TabIndex        =   3
      Top             =   240
      Width           =   1215
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      BackStyle       =   0  'Transparent
      Caption         =   " «—ÌŒ «·«–‰ "
      Height          =   255
      Left            =   10560
      RightToLeft     =   -1  'True
      TabIndex        =   2
      Top             =   840
      Width           =   855
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0E0FF&
      BackStyle       =   0  'Transparent
      Caption         =   "—ﬁ„ «·«–‰ "
      Height          =   255
      Left            =   10200
      RightToLeft     =   -1  'True
      TabIndex        =   0
      Top             =   240
      Width           =   1215
   End
End
Attribute VB_Name = "istara"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
 Dim M_OPR_MOD As Integer
 Dim M_OPR_SER As Integer
 Dim m_typ_mod As Integer
 Dim m_ser As Integer
 Dim m_cha_title As String
 Dim M_charit_no As String
 Dim m_rmrk As String
 Dim m_opr_extcote As String
 Dim m_dte1 As Variant
 Dim m_form_disp As Integer
 Dim m_typ_serh As Integer

 
 
 
  
 
 Function display_fld()
   If Not IsNull(opr_chrt.Resultset![opr_no]) Then
      m_opr_no.Text = opr_chrt.Resultset![opr_no]
   Else
     m_opr_no.Text = ""
   End If
   If Not IsNull(opr_chrt.Resultset![opr_dte]) Then
      m_opr_dte.Text = Format(opr_chrt.Resultset![opr_dte], "dd/mm/yy")
   Else
     m_opr_dte.Text = "__/__/__"
   End If
   If Not IsNull(opr_chrt.Resultset![opr_time]) Then
      m_opr_time.Text = opr_chrt.Resultset![opr_time]
   Else
     m_opr_time.Text = ""
   End If
   If Not IsNull(opr_chrt.Resultset![opr_cotfrm]) Then
      m_opr_cotfrm.BoundText = "07" + opr_chrt.Resultset![opr_cotfrm]
   Else
     m_opr_cotfrm.BoundText = ""
   End If
   If Not IsNull(opr_chrt.Resultset![opr_prsfrm]) Then
      m_opr_prsfrm.BoundText = "08" + opr_chrt.Resultset![opr_prsfrm]
   Else
     m_opr_prsfrm.BoundText = ""
   End If
   If Not IsNull(opr_chrt.Resultset![opr_cotto]) Then
      m_opr_cotto.BoundText = "07" + opr_chrt.Resultset![opr_cotto]
   Else
     m_opr_cotto.BoundText = ""
   End If
   If Not IsNull(opr_chrt.Resultset![opr_prsto]) Then
      m_opr_prsto.BoundText = "08" + opr_chrt.Resultset![opr_prsto]
   Else
     m_opr_prsto.BoundText = ""
   End If
        m_form_disp = 2
     If Not IsNull(opr_chrt.Resultset![opr_extcote]) Then
          m_opr_extcote = opr_chrt.Resultset![opr_extcote]
           tmp_mch.sql = "EXEC SERH_SUB_NAME " & "'" & m_opr_extcote & "'"
           tmp_mch.Refresh
           
             If Not tmp_mch.Resultset.EOF And Not tmp_mch.Resultset.BOF Then
                If Not IsNull(tmp_mch.Resultset![sub_name]) Then
                   m_txt_extcote.Text = tmp_mch.Resultset![sub_name]
                 Else
                   m_opr_extcote = ""
                   m_opr_extcote = Space(10)
                 End If
               Else
                  m_opr_extcote = ""
                  m_opr_extcote = Space(10)
             End If
       Else
                  m_opr_extcote = ""
                  m_opr_extcote = Space(10)
    End If

   
 End Function
 
 
Private Sub Command1_Click()
 Dim sql As String
 ' Dim cn As New rdoConnection
   Dim m_ddt As Variant
  
        
If m_opr_dte1.Text = "__/__/__" Then
      m_ddte = ""
 Else
     m_ddte = m_opr_dte1.Text
 End If
 If m_opr_dte.Text = "__/__/__" Then
    m_dte = ""
  Else
    m_dte = m_opr_dte.Text
 End If
If M_OPR_MOD = 1 Then
  m_opr_trans = 0
  sql = "execute  INSR2_opr_chrt " & "'" & m_opr_no.Text & "'" & "," & "'" & M_OPR_SER & "'" & "," & "'" & Format(m_dte, "yyyy/mm/dd") & "'" _
                                    & "," & "'" & m_opr_time.Text & "'" _
                                     & "," & "'" & Mid(m_opr_cotfrm.BoundText, 3, 3) & "'" & "," & "'" & Mid(m_opr_prsfrm.BoundText, 3, 3) & "'" _
                                      & "," & "'" & Mid(m_opr_cotto.BoundText, 3, 3) & "'" & "," & "'" & Mid(m_opr_prsto.BoundText, 3, 3) & "'" _
                                      & "," & "'" & M_OPR_NO1.Text & "'" & "," & "'" & M_OPR_SUB.Text & "'" & "," & "'" & Format(m_ddte, "yyyy/mm/dd") & "'" _
                                       & "," & "'" & m_opr_rmk.Text & "'" & "," & "'" & m_opr_title.Text & "'" & "," & "'" & m_opr_trans & "'" _
                                       & "," & "'" & m_opr_extcote & "'"

           cn.Execute sql, rdExecDirect

ElseIf M_OPR_MOD = 2 Then
  
  sql = "execute  upd1_opr_chrt " & "'" & m_opr_no.Text & "'" & "," & "'" & m_ser & "'" & _
                                             "," & "'" & M_OPR_NO1.Text & "'" & "," & "'" & M_OPR_SUB.Text & "'" & "," & "'" & Format(m_ddte, "yyyy/mm/dd") & "'" _
                                            & "," & "'" & m_opr_rmk.Text & "'" & "," & "'" & m_opr_title.Text & "'"
                                      
           cn.Execute sql, rdExecDirect
End If
   sql = "execute upd_charit_time " & "'" & M_OPR_NO1.Text & "'" & "," & "'" & M_OPR_SUB.Text & "'" _
           & "," & "'" & m_cha_time.Text & "'"
           cn.Execute sql, rdExecDirec

  If m_cha_title = m_opr_title.Text Then
   Else
   sql = "execute upd_charit_title" & "'" & M_OPR_NO1.Text & "'" & "," & "'" & M_OPR_SUB.Text & "'" _
           & "," & "'" & m_opr_title.Text & "'"
           cn.Execute sql, rdExecDirec
  End If
    m_status = Mid(m_opr_cotto.BoundText, 3, 3)
    sql = "execute upd_cha_status" & "'" & M_OPR_NO1.Text & "'" & "," _
           & "'" & Mid(m_opr_cotfrm.BoundText, 3, 3) & "'" & "," & "'" & Mid(m_opr_cotto.BoundText, 3, 3) & "'" _
            & "," & "'" & Mid(m_opr_prsfrm.BoundText, 3, 3) & "'" & "," & "'" & Mid(m_opr_prsto.BoundText, 3, 3) & "'" _
            & "," & "'" & m_opr_no.Text & "'"
         cn.Execute sql, rdExecDirec
 If Not Trim(M_charit_no) = "" And Not M_charit_no = M_OPR_NO1.Text Then
      tmp_mch.sql = "execute retard_charit" & "'" & M_charit_no & "'"
      tmp_mch.Refresh
      If Not tmp_mch.Resultset.EOF Then
       tmp_mch.Resultset.MoveLast
        m_cotfrm = tmp_mch.Resultset![opr_cotfrm]
        m_cotto = tmp_mch.Resultset![opr_cotto]
        m_prsfrm = tmp_mch.Resultset![opr_prsfrm]
        m_prsto = tmp_mch.Resultset![opr_prsto]
      Else
         m_cotto = Mid(m_opr_cotfrm.BoundText, 3, 3)
         m_prsfrm = Space(3)
         m_prsto = Space(3)
         m_cotfrm = Space(3)
      End If
            sql = "execute upd_cha_status" & "'" & M_charit_no & "'" & "," _
            & "'" & m_cotfrm & "'" & "," & "'" & m_cotto & "'" _
            & "," & "'" & m_prsfrm & "'" & "," & "'" & m_prsto & "'" _
             & "," & "'" & m_opr_no.Text & "'"
           cn.Execute sql, rdExecDirec
           
 End If

  Frame4.Visible = False
  jad_opr_chrt.Refresh
  DBGrid1.Refresh
  DBGrid1.SetFocus
   
End Sub

Private Sub Command10_Click()
Frame2.Visible = True
m_ist_no.SetFocus


End Sub

Private Sub Command12_Click()
 'Dim cn As New rdoConnection
Dim sql As String
Dim m_mn_app_no As String
Const None As String = ""
opr_chrt.sql = "exec serh_OPR_CHRT" & "'" & m_ist_no.Text & "'"
opr_chrt.Refresh
typ_serh = 2
If Not opr_chrt.Resultset.EOF Or Not opr_chrt.Resultset.BOF Then
  Call display_fld
    jad_opr_chrt.sql = "execute proc_opr_chrt " & "'" & m_ist_no.Text & "'"
     jad_opr_chrt.Refresh
     DBGrid1.Refresh
     DBGrid1.SetFocus
      If Not jad_opr_chrt.Resultset.EOF And Not jad_opr_chrt.Resultset.BOF Then
         jad_opr_chrt.Resultset.MoveFirst
          If Not jad_opr_chrt.Resultset.EOF And Not jad_opr_chrt.Resultset.BOF Then
           M_OPR_SER = jad_opr_chrt.Resultset![opr_ser]
           End If
     End If
 Else
  MsgBox "·« ÌÊÃœ «” „«—… ·Â–« «·—ﬁ„ !!!!"

 End If
 
Frame2.Visible = False
DBGrid1.Refresh

End Sub

Private Sub Command13_Click()
Frame2.Visible = False

End Sub

Private Sub Command15_Click()

   Frame1.Visible = True
   M_YESNO.SetFocus
'End If
End Sub

Private Sub Command16_Click()
If m_gen_password = a_password Then
 
 Frame2.Visible = True
 m_ist_no.SetFocus
 End If
 
End Sub

Private Sub Command17_Click()
If m_gen_password = a_password Then
 

  Dim sql As String
'  Dim cn As New rdoConnection
 If m_opr_dte.Text = "__/__/__" Then
    m_dte = ""
  Else
    m_dte = m_opr_dte.Text
 End If
  sql = "execute  upd_opr_chrt1 " & "'" & m_opr_no.Text & "'" & "," & "'" & Format(m_dte, "yyyy/mm/dd") & "'" _
                                    & "," & "'" & m_opr_time.Text & "'" _
                                     & "," & "'" & Mid(m_opr_cotfrm.BoundText, 3, 3) & "'" & "," & "'" & Mid(m_opr_prsfrm.BoundText, 3, 3) & "'" _
                                     & "," & "'" & Mid(m_opr_cotto.BoundText, 3, 3) & "'" & "," & "'" & Mid(m_opr_prsto.BoundText, 3, 3) & "'" _
                                     & "," & "'" & m_opr_extcote & "'"
                                     
           cn.Execute sql, rdExecDirect
  jad_opr_chrt.sql = "execute proc_opr_chrt" & "'" & m_opr_no.Text & "'"
  jad_opr_chrt.Refresh
  jad_opr_chrt.Resultset.MoveFirst
If Not jad_opr_chrt.Resultset.EOF Then
 
 While Not jad_opr_chrt.Resultset.EOF
    m_no = jad_opr_chrt.Resultset![opr_no1]
    If Not IsNull(jad_opr_chrt.Resultset![opr_no1]) Then
        
          m_cotfrm = Mid(m_opr_cotfrm.BoundText, 3, 3)
          m_cotto = Mid(m_opr_cotto.BoundText, 3, 3)
          m_prsfrm = Mid(m_opr_prsfrm.BoundText, 3, 3)
          m_prsto = Mid(m_opr_prsto.BoundText, 3, 3)
          sql = "execute upd_cha_status" & "'" & m_no & "'" & "," _
           & "'" & m_cotfrm & "'" & "," & "'" & m_cotto & "'" _
           & "," & "'" & m_prsfrm & "'" & "," & "'" & m_prsto & "'" _
            & "," & "'" & m_opr_no.Text & "'"

           cn.Execute sql, rdExecDirec
         End If
          jad_opr_chrt.Resultset.MoveNext
Wend
End If
DBGrid1.Refresh
DBGrid1.SetFocus
End If
End Sub
Private Sub Command18_Click()
  
m_typ_mod = 1
opr_chrt.sql = "execute op_chrt"
opr_chrt.Refresh

If Not opr_chrt.Resultset.EOF Then
    v_prs_no = "0000000"
    m_no = 0
    opr_chrt.Resultset.MoveLast
    m_no1 = opr_chrt.Resultset![opr_no]
    m_no = Val(m_no1)
    m_no = m_no + 1
    
    v_prs_no = Mid(v_prs_no, 1, 7 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
   m_opr_no.Text = v_prs_no
    
Else
  m_opr_no.Text = "0000001"
 End If
 M_OPR_SER = 1
 m_trans = 0
 SQL1 = "execute insr_opr_chrt " & "'" & m_opr_no.Text & "'" & "," & "'" & M_OPR_SER & "'" & "," _
                                             & "'" & m_trans & "'"
                cn.Execute SQL1, rdExecDirect
  m_opr_dte.Text = Format(Date, "dd/mm/yy")
  m_opr_time.Text = time
  m_opr_cotfrm.BoundText = ""
  m_opr_prsfrm.BoundText = ""
   m_opr_cotto.BoundText = ""
   m_opr_prsto.BoundText = ""
   jad_opr_chrt.sql = " execute proc_opr_chrt" & "'" & m_opr_no.Text & "'"
     jad_opr_chrt.Refresh
  m_opr_dte.SetFocus
  
           
End Sub

Private Sub Command2_Click()
'Dim cn As New rdoConnection
Dim sql As String

 If Trim(M_YESNO.Text) = "y" Or Trim(M_YESNO.Text) = "‰" Then
    m_ser = DBGrid1.Columns(2)
  '  cn.Connect = "uid=;pwd=;server=SEQUEL;" _
  '  & "driver={SQL Server};database=ARCHIVE_MANAR;" _
  '  & "DSN='';"
    m_no = DBGrid1.Columns(3)
  ' cn.CursorDriver = rdUseOdbc
  '  cn.EstablishConnection rdDriverNoPrompt
    sql = "exec del_OPR_CHRT" & "'" & m_opr_no.Text & "'" & "," & "'" & m_ser & "'"
      cn.Execute sql, rdExecDirect
      Frame1.Visible = False
      jad_opr_chrt.Refresh
      DBGrid1.SetFocus
      tmp_mch.sql = "execute retard_charit" & "'" & m_no & "'"
      tmp_mch.Refresh
      If Not tmp_mch.Resultset.EOF Then
       tmp_mch.Resultset.MoveLast
        m_cotfrm = tmp_mch.Resultset![opr_cotfrm]
        m_cotto = tmp_mch.Resultset![opr_cotto]
        m_prsfrm = tmp_mch.Resultset![opr_prsfrm]
        m_prsto = tmp_mch.Resultset![opr_prsto]
        v_opr_no = tmp_mch.Resultset![opr_no]
      Else
         m_cotto = Mid(m_opr_cotfrm.BoundText, 3, 3)
         m_prsfrm = Space(3)
         m_prsto = Space(3)
         m_cotfrm = Space(3)
         v_opr_no = Space(7)
      End If
            sql = "execute upd_cha_status" & "'" & m_no & "'" & "," _
            & "'" & m_cotfrm & "'" & "," & "'" & m_cotto & "'" _
            & "," & "'" & m_prsfrm & "'" & "," & "'" & m_prsto & "'" _
              & "," & "'" & v_opr_no & "'"
           cn.Execute sql, rdExecDirec
End If
End Sub

Private Sub Command3_Click()
Frame1.Visible = False
 

End Sub



Private Sub Command5_Click()
 If Not IsNull(m_vtitle.Text) And Not m_vtitle.Text = "" Then
  sql = "Execute upd_opr_title" & "'" & m_opr_no.Text & "'" & "," & "'" & m_vtitle.Text & "'"
   
   cn.Execute sql, rdExecDirect
                                    
  jad_opr_chrt.sql = "execute proc_opr_chrt" & "'" & m_opr_no.Text & "'"
  jad_opr_chrt.Refresh
  jad_opr_chrt.Resultset.MoveFirst
If Not jad_opr_chrt.Resultset.EOF Then
 
 While Not jad_opr_chrt.Resultset.EOF
    m_no = jad_opr_chrt.Resultset![opr_no1]
    If Not IsNull(jad_opr_chrt.Resultset![opr_no1]) Then
         m_sub = jad_opr_chrt.Resultset![opr_sub]
          sql = "execute upd_charit_title" & "'" & m_no & "'" & "," & "'" & m_sub & "'" & "," _
           & "'" & m_vtitle.Text & "'"

           cn.Execute sql, rdExecDirec
         End If
          jad_opr_chrt.Resultset.MoveNext
Wend
End If
End If
  Frame5.Visible = False
  DBGrid1.Refresh
  DBGrid1.SetFocus
  SendKeys "{Tab}"

End Sub

 

Private Sub Command7_Click()
On Error Resume Next
 
 CRIT = "create proc isn_istara as "
 CRIT = CRIT & "SELECT distinct  dbo.OPR_CHRT.opr_time , dbo.OPR_CHRT.opr_dte , dbo.opr_chrt.opr_dte1 ,dbo.opr_chrt.opr_rmk, dbo.opr_chrt.opr_title, dbo.opr_chrt.opr_no , dbo.CODING.SUB_DESC AS C_FRM , CODING_1.SUB_DESC AS C_TO , " _
                      & " CODING_2.SUB_DESC AS P_FRM, CODING_3.SUB_DESC AS P_TO ," & _
                      " dbo.OPR_CHRT.OPR_NO1 , dbo.CHARIT.CHA_TYP AS Expr2, dbo.ARRAYS.AR_DESC AS cha_typ_desc , " & _
                       " dbo.charit.cha_stock as cha_stock, dbo.charit.cha_frm , dbo.charit.cha_to , dbo.charit.cha_prsto , dbo.charit.cha_prsfrm , dbo.charit.cha_time" & _
  " FROM  dbo.charit left JOIN " & _
                      " dbo.opr_chrt ON    dbo.opr_chrt.opr_no1 = dbo.charit.cha_no left JOIN " & _
                      " dbo.CODING ON '07' + dbo.CHARIT.cha_frm = CODING.SUB_CODE left JOIN " & _
                      " dbo.CODING CODING_1 ON '07' + dbo.CHARIT.cha_to = CODING_1.SUB_CODE left JOIN " & _
                      " dbo.CODING CODING_2 ON '08' + dbo.CHARIT.CHA_PRSFRM = CODING_2.SUB_CODE left JOIN " & _
                     "  dbo.CODING CODING_3 ON '08' + dbo.CHARIT.CHA_PRSTO = CODING_3.SUB_CODE left join " & _
                      " dbo.ARRAYS ON dbo.CHARIT.CHA_TYP = dbo.ARRAYS.AR_CODE and dbo.arrays.ar_typ = '01'  where "

    CRIT = CRIT & " opr_no = " & "'" & m_opr_no.Text & "'"
     sql = "drop proc isn_istara"
      cn.Execute sql, rdExecDirect
'   MsgBox "delete proc "
       cn.Execute CRIT, rdExecDirect
         m_jad_print = 14

  Screen.MousePointer = vbDefault
  Screen.MousePointer = vbHourglass
  Form7.WindowState = 2
  Form7.Show
  Screen.MousePointer = vbDefault
End Sub

Private Sub Command8_Click()

End Sub

Private Sub Command4_Click()
 Frame4.Visible = False
 DBGrid1.SetFocus
 

End Sub

Private Sub Command6_Click()
 Frame5.Visible = False
 DBGrid1.SetFocus
  SendKeys "{Tab}"

End Sub

Private Sub Command9_Click()
Unload istara
End Sub

Private Sub DBGrid1_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF9 Then
 Frame5.Visible = True
 m_vtitle.SetFocus
 
End If
End Sub

Private Sub DBGrid1_KeyPress(KeyAscii As Integer)
If KeyAscii = 32 Then
    Frame4.Visible = True
    m_ser = DBGrid1.Columns(2)
    M_OPR_NO1.Text = DBGrid1.Columns(3)
    M_charit_no = M_OPR_NO1.Text
    M_OPR_SUB.Text = DBGrid1.Columns(4)
    If DBGrid1.Columns(11) = "" Then
    Else
        m_opr_dte1.Text = Format(DBGrid1.Columns(11), "dd/mm/yy")
    End If
    m_opr_rmk.Text = DBGrid1.Columns(12)
    m_opr_title.Text = DBGrid1.Columns(13)
    m_cha_time.Text = DBGrid1.Columns(6)
    M_OPR_SUB.Text = "00"
    M_OPR_NO1.SetFocus
    M_OPR_MOD = 2
End If
End Sub

Private Sub DBGrid1_KeyUp(KeyCode As Integer, Shift As Integer)
'Dim cn As New rdoConnection
Dim sql As String
If KeyCode = vbKeyInsert Then
  Frame4.Visible = True
  M_OPR_NO1.Text = ""
  
   M_OPR_MOD = 1
   M_OPR_SER = M_OPR_SER + 1
   M_OPR_SUB.Text = "00"
   m_opr_title.Text = ""
   m_opr_rmk.Text = m_rmrk
   m_opr_dte1.Text = Format(m_dte1, "dd/mm/yy")
   M_OPR_NO1.SetFocus
ElseIf KeyCode = vbKeyDelete Then
  Command15.SetFocus
   SendKeys "{enter}"
End If
End Sub

Private Sub DBList3_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF10 Then
   searcher.Visible = True
   searcher.SetFocus
   
End If
End Sub

Private Sub DBList3_KeyPress(KeyAscii As Integer)
'Dim cn As New rdoConnection
 Dim sql As String

If KeyAscii = 13 Then

  If Not main.Resultset.BOF And Not main.Resultset.EOF Then
           main.Resultset.Bookmark = DBList3.SelectedItem
        m_nobook = main.Resultset![mn_app_no]
         m_ser_book = DBGrid1.Columns(1)
      
     sql = "execute upd_istara1 " & "'" & m_iar_no.Text & "'" & "," & "'" & m_nobook & "'" & "," _
        & "'" & m_ser_book & "'"

     '  cn.Connect = "uid=;pwd=;server=SEQUEL;" _
     '      & "driver={SQL Server};database=macnz;" _
     '      & "DSN='';"
     '       cn.CursorDriver = rdUseOdbc
     '      cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
       DBGrid1.Refresh
         JAD_IARA.Refresh
         
   End If
 DBList3.Visible = False
 DBGrid1.SetFocus
ElseIf KeyAscii = 27 Then
 DBList3.Visible = False
 DBGrid1.SetFocus
End If

End Sub

Private Sub DBList1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
      view_form.Resultset.Bookmark = DBList1.SelectedItem
           m_form_disp = 2
       m_txt_extcote.Text = view_form.Resultset![sub_name]
      m_opr_extcote = view_form.Resultset![sub_typ] + view_form.Resultset![sub_no]
     m_opr_cotfrm.SetFocus
     SendKeys "{up}"

       DBList1.Visible = False
ElseIf KeyAscii = 27 Then
  DBList1.Visible = False
   m_txt_extcote.SetFocus
ElseIf KeyAscii = 32 Then
    m_opr_extcote = Space(10)
     m_txt_extcote.Text = ""
     m_opr_cotfrm.SetFocus
      SendKeys "{UP}"
  End If
  DBList1.Visible = False
End Sub

Private Sub DBList1_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF10 Then
  m_typ_serh = 1
   m_txt_extcote.Text = ""
  m_txt_extcote.SetFocus
ElseIf KeyCode = vbKeyF9 Then
  m_typ_serh = 2
   m_txt_extcote.Text = ""
  m_txt_extcote.SetFocus
  End If
 
  
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF4 Then
  Command17.SetFocus
  SendKeys "{enter}"
ElseIf KeyCode = vbKeyF10 Then
Command16.SetFocus
  SendKeys "{enter}"
End If
End Sub

Private Sub Form_Load()
opr_chrt.Connect = m_connect
opr_chrt.DataSourceName = M_SQL_NAM
m_form_disp = 1
m_dte1 = "__/__/__"
m_rmrk = ""
m_typ_opr = 2
m_typ_serh = 1

End Sub

 
Private Sub M_iar_cause_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_iar_dte1.SetFocus
 End If
End Sub

Private Sub m_iar_dte_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_iar_prs.SetFocus
 SendKeys "{f4}"
End If
End Sub

Private Sub m_iar_dte1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_iar_dte2.SetFocus
 End If

End Sub

Private Sub m_iar_dte2_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_iar_rmrk.SetFocus
 End If

End Sub

Private Sub m_iar_no_Change()
'Dim cn As New rdoConnection
Dim sql As String
JAD_IARA.sql = "exec SERH_istara " & "'" & m_iar_no.Text & "'"
JAD_IARA.Refresh
DBGrid1.Refresh


End Sub

Private Sub m_iar_prs_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  M_iar_cause.SetFocus
  SendKeys "{f4}"
End If
End Sub

Private Sub m_iar_rmrk_KeyPress(KeyAscii As Integer)

 Dim sql As String
 Dim m_iar_book As String

If KeyAscii = 13 Then
  If m_typ_opr = 1 Then
    m_iar_book = Space(7)
    sql = "execute insr_istara " & "'" & m_iar_no.Text & "'" & "," & "'" & m_iar_prs.BoundText & "'" & "," _
    & "'" & Format(m_iar_dte.Text, "yyyy/mm/dd") & "'" & "," & "'" & Format(m_iar_dte1.Text, "yyyy/mm/dd") & "'" & "," _
    & "'" & Format(m_iar_dte2.Text, "yyyy/mm/dd") & "'" & "," & "'" & Mid(M_iar_cause.BoundText, 3, 2) & "'" & "," _
     & "'" & m_iar_rmrk.Text & "'" & "," & "'" & m_iar_book & "'" & "," & "'" & m_iar_ser & "'"
         
     '  cn.Connect = "uid=;pwd=;server=SEQUEL;" _
     '      & "driver={SQL Server};database=macnz;" _
     '      & "DSN='';"
     '       cn.CursorDriver = rdUseOdbc
     '      cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
     m_typ_opr = 2
 End If
 iara.Refresh
 JAD_IARA.Refresh
 
 DBGrid1.SetFocus
 SendKeys "{up}"
 End If

End Sub

Private Sub m_cha_time_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 Command1.SetFocus
End If

End Sub

Private Sub m_ist_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
     v_prs_no = "0000000"
      m_no = m_ist_no.Text
      v_prs_no = Mid(v_prs_no, 1, 7 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
     m_ist_no.Text = v_prs_no
Command12.SetFocus
ElseIf KeyAscii = 27 Then
 Frame2.Visible = False
 Command16.SetFocus
 
End If

End Sub

Private Sub m_opr_cotfrm_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 Then
  m_opr_prsfrm.SetFocus
  SendKeys "{f4}"
  
 End If
End Sub

Private Sub M_OPR_COTTO_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_opr_prsto.SetFocus
  SendKeys "{f4}"
  
 End If

End Sub

Private Sub m_opr_dte_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 If IsDate(m_opr_dte.Text) Then
   m_opr_time.SetFocus
 Else
  m_opr_dte.SetFocus
 End If
End If
End Sub

Private Sub m_OPR_DTE1_Change()
If KeyAscii = 13 Then
 If IsDate(m_opr_dte1.Text) Or m_opr_dte1.Text = "__/__/__" Then
  m_dte1 = m_opr_dte1.Text
  m_opr_title.SetFocus
 Else
  m_opr_dte1.SetFocus
 End If
End If

End Sub

Private Sub M_OPR_DTE1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_dte1 = m_opr_dte1.Text
 m_opr_title.SetFocus
End If

End Sub

Private Sub M_OPR_NO1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  If Not M_OPR_NO1.Text = "" Then
     v_prs_no = "000000"
      m_no = M_OPR_NO1.Text
     v_prs_no = Mid(v_prs_no, 1, 6 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
     M_OPR_NO1.Text = v_prs_no
 M_OPR_SUB.SetFocus
Else
  M_OPR_NO1.SetFocus
End If
ElseIf KeyAscii = 27 Then
 Frame4.Visible = False
 DBGrid1.SetFocus
 
End If
End Sub

Private Sub M_OPR_PRSFRM_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_opr_cotto.SetFocus
  SendKeys "{f4}"
  
 End If

End Sub

Private Sub m_opr_prsto_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Dim sql As String
 ' Dim cn As New rdoConnection
 
  sql = "execute  upd_opr_chrt1 " & "'" & m_opr_no.Text & "'" & "," & "'" & Format(m_opr_dte.Text, "yyyy/mm/dd") & "'" _
                                    & "," & "'" & m_opr_time.Text & "'" _
                                     & "," & "'" & Mid(m_opr_cotfrm.BoundText, 3, 3) & "'" & "," & "'" & Mid(m_opr_prsfrm.BoundText, 3, 3) & "'" _
                                     & "," & "'" & Mid(m_opr_cotto.BoundText, 3, 3) & "'" & "," & "'" & Mid(m_opr_prsto.BoundText, 3, 3) & "'" _
                                     & "," & "'" & m_opr_extcote & "'"
                                     
       '     cn.Connect = "uid=;pwd=;server=SEQUEL;" _
       '    & "driver={SQL Server};database=archive_manar;" _
       '    & "DSN='';"
       '     cn.CursorDriver = rdUseOdbc
       '    cn.EstablishConnection rdDriverNoPrompt
           cn.Execute sql, rdExecDirect
 
     DBGrid1.SetFocus
     jad_opr_chrt.sql = " execute proc_opr_chrt" & "'" & m_opr_no.Text & "'"
     jad_opr_chrt.Refresh
     DBGrid1.Refresh
     DBGrid1.SetFocus
     If m_typ_mod = 2 Then
       If Not jad_opr_chrt.Resultset.EOF Then
          jad_opr_chrt.Resultset.MoveFirst
          M_OPR_SER = jad_opr_chrt.Resultset![opr_ser] + 1
      End If
     End If
 End If

End Sub

Private Sub m_opr_rmk_Change()
 m_len = Len(Trim(m_opr_rmk.Text))
 If m_opr_rmk.MaxLength <= m_len + 1 Then
  m_rmrk = m_opr_rmk.Text
  Command1.SetFocus
 End If
End Sub

Private Sub m_opr_rmk_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_cha_time.SetFocus
End If


End Sub

Private Sub M_OPR_SUB_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Dim cn As New rdoConnection
  Dim sql As String
  Const None As String = ""
   tmp_mch.sql = "execute serh_charit1" & "'" & M_OPR_NO1.Text & "'"
                                     ' "," & "'" & M_OPR_NO1.Text & "'"
  
'    charit.SQL = "execute serh1_charit " & "'" & m_ist_no.text & "'" & "," & "'" & m_ist_no1.text & "'"
     tmp_mch.Refresh
     If Not tmp_mch.Resultset.EOF Or Not tmp_mch.Resultset.BOF Then
      If Not IsNull(tmp_mch.Resultset![cha_title]) Then
        m_opr_title.Text = tmp_mch.Resultset![cha_title]
         m_cha_time.Text = tmp_mch.Resultset![cha_time]
        Else
          m_opr_title.Text = ""
       End If
        m_opr_dte1.SetFocus
        m_cha_title = m_opr_title.Text
    Else
       MsgBox "Â–« «·‘—Ìÿ €Ì— „ÊÃÊœ ›Ì «·”Ã·«  «·«‘—ÿ…..."
       M_OPR_NO1.SetFocus
     
    End If
    
 
End If

End Sub

Private Sub m_opr_time_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_txt_extcote.SetFocus
  
End If
End Sub

Private Sub m_opr_title_Change()
 m_len = Len(Trim(m_opr_title.Text))
 If m_opr_title.MaxLength <= m_len + 1 Then
    m_opr_rmk.SetFocus
 End If
End Sub

Private Sub m_opr_title_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_opr_rmk.SetFocus
End If

End Sub

Private Sub m_vser1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_vser2.SetFocus
ElseIf KeyAscii = 27 Then
  Command6.SetFocus
  SendKeys "{enter}"
End If
End Sub

Private Sub m_vser2_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_vtitle.SetFocus
 ElseIf KeyAscii = 27 Then
  Command6.SetFocus
  SendKeys "{enter}"
 
End If
End Sub

Private Sub m_txt_nprg_Change()

End Sub

Private Sub m_txt_extcote_Change()
If m_form_disp = 1 Then
  
  If Not Trim(m_txt_extcote.Text) = "" Then
      DBList1.Visible = True
      
      
       If m_typ_serh = 1 Then
         m_desc = Trim(m_txt_extcote.Text)
         m_len = Len(Trim(m_txt_extcote.Text))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If
      ElseIf m_typ_serh = 2 Then
           m_desc = m_txt_extcote.Text
            m_len = Len(Trim(m_txt_extcote.Text))
           view_form.sql = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
            view_form.Refresh
             If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
              MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
             End If
        End If

      ' m_file_no.SetFocus
   End If

Else
 m_form_disp = 1
End If

End Sub

Private Sub m_txt_extcote_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not m_txt_extcote.Text = "" Then
  DBList1.SetFocus
  SendKeys "{up}"
End If
 End Sub

Private Sub m_vtitle_Change()
 m_len = Len(Trim(m_vtitle.Text))
 If m_vtitle.MaxLength <= m_len + 1 Then
    Command5.SetFocus

 End If
End Sub

Private Sub m_vtitle_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Command6.SetFocus
  
 ElseIf KeyAscii = 27 Then
  Command6.SetFocus
  SendKeys "{enter}"

End If
End Sub

Private Sub M_YESNO_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
Command3.SetFocus
ElseIf KeyAscii = 27 Then
 Frame1.Visible = False
 Command7.SetFocus
 
 
End If
End Sub

Private Sub searcher_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then
If Not IsNull(searcher.Text) And Not Trim(searcher.Text) = "" Then
   m_typ_ist = "ﬂ"
  m_typ_ist1 = "Ê"
  m_len = Len(searcher.Text)
  main.sql = "exec SERH_main " & "'" & searcher.Text & "'" & "," & "'" & m_len & "'" & _
                           "," & "'" & m_typ_ist & "'" & "," & "'" & m_typ_ist1 & "'"
                          
  main.Refresh
  
 End If
 searcher.Visible = False
 DBList3.Visible = True
 DBList3.SetFocus
 SendKeys "{up}"
ElseIf KeyAscii = 27 Then
 
 searcher.Visible = False
 DBList3.Visible = True
 DBList3.SetFocus
 SendKeys "{up}"
End If
End Sub

Private Sub MaskEdBox1_Change()

End Sub
