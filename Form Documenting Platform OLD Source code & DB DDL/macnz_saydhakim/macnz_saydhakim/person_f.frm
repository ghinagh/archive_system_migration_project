VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form person_f 
   BackColor       =   &H00FFC0C0&
   Caption         =   "                                                                         «” „«—… «·‘Œ’Ì…"
   ClientHeight    =   9195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11880
   RightToLeft     =   -1  'True
   ScaleHeight     =   9195
   ScaleWidth      =   11880
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame3 
      Caption         =   "Frame3"
      Height          =   1455
      Left            =   3840
      RightToLeft     =   -1  'True
      TabIndex        =   49
      Top             =   3480
      Visible         =   0   'False
      Width           =   2535
      Begin VB.CommandButton Command10 
         Caption         =   "«÷«›…"
         Height          =   495
         Left            =   1440
         RightToLeft     =   -1  'True
         TabIndex        =   51
         Top             =   720
         Width           =   735
      End
      Begin VB.CommandButton Command13 
         Caption         =   "«·€«¡ «·«„—"
         Height          =   495
         Left            =   360
         RightToLeft     =   -1  'True
         TabIndex        =   50
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
         TabIndex        =   52
         Top             =   240
         Width           =   1335
      End
   End
   Begin VB.TextBox m_sub_name 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   3240
      RightToLeft     =   -1  'True
      TabIndex        =   48
      Top             =   600
      Width           =   5175
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H00C0C0FF&
      Height          =   2415
      Left            =   7680
      RightToLeft     =   -1  'True
      TabIndex        =   37
      Top             =   9120
      Visible         =   0   'False
      Width           =   3615
      Begin VB.CommandButton Command12 
         Caption         =   "«·€«¡ «·«„—"
         Height          =   495
         Left            =   360
         RightToLeft     =   -1  'True
         TabIndex        =   41
         Top             =   1560
         Width           =   735
      End
      Begin VB.CommandButton Command9 
         Caption         =   " ‰›Ì–"
         Height          =   495
         Left            =   2520
         RightToLeft     =   -1  'True
         TabIndex        =   40
         Top             =   1560
         Width           =   735
      End
      Begin VB.TextBox m_ist_name 
         Alignment       =   1  'Right Justify
         Height          =   375
         Left            =   240
         RightToLeft     =   -1  'True
         TabIndex        =   38
         Top             =   720
         Width           =   2295
      End
      Begin VB.Label Label22 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C0C0FF&
         Caption         =   "«”„ «·„” ›Ìœ"
         Height          =   375
         Left            =   2280
         RightToLeft     =   -1  'True
         TabIndex        =   39
         Top             =   720
         Width           =   1215
      End
   End
   Begin MSRDC.MSRDC qualty 
      Height          =   330
      Left            =   480
      Top             =   9000
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
      RecordSource    =   "select *from coding where (substring(sub_code,1,2) = '16')"
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
   Begin VB.TextBox m_vlg 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   6840
      RightToLeft     =   -1  'True
      TabIndex        =   35
      Top             =   1440
      Width           =   3855
   End
   Begin MSDBCtls.DBList DBList1 
      Bindings        =   "person_f.frx":0000
      Height          =   3375
      Left            =   6840
      TabIndex        =   32
      Top             =   3840
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
   Begin VB.TextBox m_prs_inst 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   6720
      RightToLeft     =   -1  'True
      TabIndex        =   31
      Top             =   3480
      Width           =   4095
   End
   Begin VB.TextBox m_prs_inst_direct 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   1440
      RightToLeft     =   -1  'True
      TabIndex        =   30
      Top             =   4680
      Width           =   3615
   End
   Begin VB.CommandButton Command4 
      BackColor       =   &H008080FF&
      Caption         =   " ”ÃÌ·"
      Height          =   615
      Left            =   240
      MaskColor       =   &H000080FF&
      TabIndex        =   29
      Top             =   960
      Width           =   735
   End
   Begin VB.CommandButton Command7 
      Caption         =   "«·€‹‹«¡"
      Height          =   615
      Left            =   240
      TabIndex        =   28
      Top             =   1680
      Width           =   735
   End
   Begin VB.CommandButton Command11 
      Caption         =   "Œ—ÊÃ"
      Height          =   615
      Left            =   240
      RightToLeft     =   -1  'True
      TabIndex        =   27
      Top             =   2520
      Width           =   735
   End
   Begin VB.TextBox M_PRS_EMAIL 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   1440
      RightToLeft     =   -1  'True
      TabIndex        =   26
      Top             =   7680
      Width           =   3975
   End
   Begin VB.TextBox M_PRS_BOX 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   1320
      RightToLeft     =   -1  'True
      TabIndex        =   24
      Top             =   7080
      Width           =   4695
   End
   Begin VB.TextBox M_PRS_TEL 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   6840
      RightToLeft     =   -1  'True
      TabIndex        =   22
      Top             =   7200
      Width           =   3735
   End
   Begin VB.TextBox M_PRS_ADRS 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   1320
      RightToLeft     =   -1  'True
      TabIndex        =   19
      Top             =   6600
      Width           =   9255
   End
   Begin VB.TextBox M_PRS_INST_EMAIL 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   6000
      RightToLeft     =   -1  'True
      TabIndex        =   17
      Top             =   5280
      Width           =   4815
   End
   Begin VB.TextBox M_PRS_INST_BOX 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   6000
      RightToLeft     =   -1  'True
      TabIndex        =   15
      Top             =   4680
      Width           =   4815
   End
   Begin VB.TextBox M_PRS_ADRS1 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   1440
      RightToLeft     =   -1  'True
      TabIndex        =   12
      Top             =   4200
      Width           =   9375
   End
   Begin VB.TextBox M_PRS_INST_TEL 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   1560
      RightToLeft     =   -1  'True
      TabIndex        =   10
      Top             =   3000
      Width           =   3495
   End
   Begin MSDBCtls.DBCombo M_PRS_QUALTY 
      Bindings        =   "person_f.frx":0018
      Height          =   315
      Left            =   6960
      TabIndex        =   7
      Top             =   3000
      Width           =   3855
      _ExtentX        =   6800
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox m_prs_name 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   5520
      RightToLeft     =   -1  'True
      TabIndex        =   3
      Top             =   1080
      Width           =   5175
   End
   Begin VB.TextBox m_prs_no 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   8760
      RightToLeft     =   -1  'True
      TabIndex        =   1
      Top             =   600
      Width           =   1935
   End
   Begin MSRDC.MSRDC PERSON 
      Height          =   330
      Left            =   4800
      Top             =   9120
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
      RecordSource    =   "select * FROM PERSON order by prs_no"
      UserName        =   ""
      Password        =   ""
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "PERSON"
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
      Left            =   3720
      Top             =   8640
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
      Left            =   1320
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
   Begin VB.TextBox serch 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   -1200
      RightToLeft     =   -1  'True
      TabIndex        =   33
      Top             =   8760
      Visible         =   0   'False
      Width           =   1695
   End
   Begin MSDBCtls.DBCombo m_prs_mzhb 
      Bindings        =   "person_f.frx":002D
      Height          =   315
      Left            =   1800
      TabIndex        =   43
      Top             =   1560
      Width           =   2295
      _ExtentX        =   4048
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSDBCtls.DBCombo m_prs_poltic 
      Bindings        =   "person_f.frx":0040
      Height          =   315
      Left            =   1800
      TabIndex        =   45
      Top             =   2040
      Width           =   2295
      _ExtentX        =   4048
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   -6240
      RightToLeft     =   -1  'True
      TabIndex        =   46
      Top             =   -1560
      Width           =   6375
   End
   Begin MSRDC.MSRDC mzhb 
      Height          =   330
      Left            =   0
      Top             =   8520
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
      RecordSource    =   "select *from coding where (substring(sub_code,1,2) = '17')"
      UserName        =   ""
      Password        =   ""
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "mzhb"
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
   Begin MSRDC.MSRDC poltic 
      Height          =   330
      Left            =   0
      Top             =   8040
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
      RecordSource    =   "select *from coding where (substring(sub_code,1,2) = '18')"
      UserName        =   ""
      Password        =   ""
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "poltic"
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
   Begin VB.TextBox m_prs_social_media 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   1320
      RightToLeft     =   -1  'True
      TabIndex        =   53
      Top             =   8280
      Width           =   9255
   End
   Begin MSMask.MaskEdBox m_prs_dte 
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
      Left            =   2040
      TabIndex        =   54
      Top             =   1080
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
   Begin MSMask.MaskEdBox m_prs_dte1 
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
      Left            =   8400
      TabIndex        =   55
      Top             =   7800
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
   Begin MSDBCtls.DBCombo m_prs_sex 
      Bindings        =   "person_f.frx":0055
      Height          =   315
      Left            =   8280
      TabIndex        =   57
      Top             =   2040
      Width           =   2295
      _ExtentX        =   4048
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSDBCtls.DBCombo m_prs_oldjob 
      Bindings        =   "person_f.frx":0067
      Height          =   315
      Left            =   1200
      TabIndex        =   58
      Top             =   5280
      Width           =   3855
      _ExtentX        =   6800
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSRDC.MSRDC sex 
      Height          =   330
      Left            =   -240
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
      RecordSource    =   "select *from coding where (substring(sub_code,1,2) = '40')"
      UserName        =   ""
      Password        =   ""
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "poltic"
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
   Begin VB.Label Label25 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«·„Â‰… ”«»ﬁ« :"
      Height          =   375
      Left            =   5400
      RightToLeft     =   -1  'True
      TabIndex        =   59
      Top             =   5280
      Width           =   495
   End
   Begin VB.Label Label19 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«·Ã‰”  :"
      Height          =   255
      Left            =   10440
      RightToLeft     =   -1  'True
      TabIndex        =   56
      Top             =   2040
      Width           =   1095
   End
   Begin VB.Label Label21 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "Ê”«∆· «· Ê«’· «·«Ã „«⁄Ì"
      Height          =   375
      Left            =   10800
      RightToLeft     =   -1  'True
      TabIndex        =   47
      Top             =   8160
      Width           =   735
   End
   Begin VB.Label Label24 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«·Ê÷⁄ «·⁄«∆·Ì  :"
      Height          =   255
      Left            =   4320
      RightToLeft     =   -1  'True
      TabIndex        =   44
      Top             =   2040
      Width           =   1095
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«·„” ÊÏ «· ⁄·Ì„Ì:"
      Height          =   255
      Left            =   3960
      RightToLeft     =   -1  'True
      TabIndex        =   42
      Top             =   1560
      Width           =   1575
   End
   Begin VB.Label Label20 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   " «—ÌŒ »œ«Ì… «·⁄„· „⁄ «·„ƒ””…"
      Height          =   495
      Left            =   10560
      RightToLeft     =   -1  'True
      TabIndex        =   36
      Top             =   7800
      Width           =   975
   End
   Begin VB.Label Label18 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«·»ÕÀ"
      Height          =   375
      Left            =   -120
      RightToLeft     =   -1  'True
      TabIndex        =   34
      Top             =   8280
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.Shape Shape6 
      BorderWidth     =   2
      Height          =   2535
      Left            =   120
      Top             =   720
      Width           =   975
   End
   Begin VB.Shape Shape3 
      BorderWidth     =   2
      Height          =   2295
      Left            =   1080
      Shape           =   4  'Rounded Rectangle
      Top             =   6480
      Width           =   10695
   End
   Begin VB.Label Label17 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "E-MAIL :"
      Height          =   375
      Left            =   5280
      RightToLeft     =   -1  'True
      TabIndex        =   25
      Top             =   7680
      Width           =   735
   End
   Begin VB.Label Label16 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«·⁄‰Ê«‰ «·”«»ﬁ :"
      Height          =   375
      Left            =   6000
      RightToLeft     =   -1  'True
      TabIndex        =   23
      Top             =   7080
      Width           =   615
   End
   Begin VB.Label Label15 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«·Â« ›:"
      Height          =   375
      Left            =   10560
      RightToLeft     =   -1  'True
      TabIndex        =   21
      Top             =   7200
      Width           =   615
   End
   Begin VB.Label Label14 
      Alignment       =   1  'Right Justify
      Caption         =   "Label14"
      Height          =   135
      Left            =   4080
      RightToLeft     =   -1  'True
      TabIndex        =   20
      Top             =   6840
      Width           =   15
   End
   Begin VB.Label Label13 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "⁄‰Ê«‰ «·«ﬁ«„…··‘Œ’Ì…"
      Height          =   375
      Left            =   10440
      RightToLeft     =   -1  'True
      TabIndex        =   18
      Top             =   6600
      Width           =   1215
   End
   Begin VB.Shape Shape2 
      BorderWidth     =   2
      Height          =   3375
      Left            =   1080
      Shape           =   4  'Rounded Rectangle
      Top             =   2760
      Width           =   10815
   End
   Begin VB.Label Label12 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   " E-MAIL :"
      Height          =   375
      Left            =   10920
      RightToLeft     =   -1  'True
      TabIndex        =   16
      Top             =   5280
      Width           =   735
   End
   Begin VB.Label Label11 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "’ .» . :"
      Height          =   375
      Left            =   10560
      RightToLeft     =   -1  'True
      TabIndex        =   14
      Top             =   4680
      Width           =   1095
   End
   Begin VB.Label Label10 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«”„ «·„œÌ—:"
      Height          =   255
      Left            =   5160
      RightToLeft     =   -1  'True
      TabIndex        =   13
      Top             =   4800
      Width           =   735
   End
   Begin VB.Label Label9 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "⁄‰Ê«‰Â« :"
      Height          =   375
      Left            =   10680
      RightToLeft     =   -1  'True
      TabIndex        =   11
      Top             =   4200
      Width           =   975
   End
   Begin VB.Label Label8 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "—ﬁ„ Â« › «·„ƒ””…:"
      Height          =   375
      Left            =   4920
      RightToLeft     =   -1  'True
      TabIndex        =   9
      Top             =   3000
      Width           =   1575
   End
   Begin VB.Label Label7 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«·„ƒ””… «· Ì Ì Ê«Ãœ ›ÌÂ«:"
      Height          =   495
      Left            =   10800
      RightToLeft     =   -1  'True
      TabIndex        =   8
      Top             =   3360
      Width           =   975
   End
   Begin VB.Label Label6 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«·„Â‰… :"
      Height          =   375
      Left            =   11160
      RightToLeft     =   -1  'True
      TabIndex        =   6
      Top             =   3000
      Width           =   495
   End
   Begin VB.Shape Shape1 
      BorderWidth     =   2
      Height          =   2175
      Left            =   1080
      Shape           =   4  'Rounded Rectangle
      Top             =   240
      Width           =   10695
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   " «—ÌŒ «·Ê·«œ…:"
      Height          =   255
      Left            =   3600
      RightToLeft     =   -1  'True
      TabIndex        =   5
      Top             =   1080
      Width           =   1455
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "„ﬂ«‰ «·Ê·«œ… :"
      Height          =   375
      Left            =   10680
      RightToLeft     =   -1  'True
      TabIndex        =   4
      Top             =   1560
      Width           =   975
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "«”„ «·À·«ÀÌ ··„” ›Ìœ"
      Height          =   495
      Left            =   10560
      RightToLeft     =   -1  'True
      TabIndex        =   2
      Top             =   1080
      Width           =   1095
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   "—ﬁ„ «·‘Œ’Ì… :"
      Height          =   255
      Left            =   10680
      RightToLeft     =   -1  'True
      TabIndex        =   0
      Top             =   600
      Width           =   975
   End
End
Attribute VB_Name = "person_f"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim m_tabindex As Integer
Dim m_typ_opr, m_form_disp As Integer
Dim m_prs_vlg As String
Dim m_prs_noinst As String
Dim m_prs_nodirect As String
Dim typ_serh As Integer





Function display_fld()
If Not IsNull(PERSON.Resultset![prs_no]) Then
  m_prs_no.Text = PERSON.Resultset![prs_no]
 End If
If Not IsNull(PERSON.Resultset![prs_name]) Then
  m_prs_name.Text = PERSON.Resultset![prs_name]
 End If
  
If Not IsNull(PERSON.Resultset![prs_brth_dte]) Then
  m_prs_dte.Text = PERSON.Resultset![prs_brth_dte]
  Else
  m_prs_dte = "__/__/____"
 End If

 m_form_disp = 2
 If Not IsNull(PERSON.Resultset![prs_vlg]) Then
          m_prs_vlg = PERSON.Resultset![prs_vlg]
           v_form1.sql = "EXEC SERH_SUB_NAME " & "'" & m_prs_vlg & "'"
           v_form1.Refresh
           
             If Not v_form1.Resultset.EOF And Not v_form1.Resultset.BOF Then
               m_vlg.Text = v_form1.Resultset![sub_name]
               Else
                 m_vlg.Text = ""
             End If
       Else
        m_vlg.Text = ""
    End If
 If Not IsNull(PERSON.Resultset![prs_qualty]) Then
      If PERSON.Resultset![prs_politc] = "" Then
          M_PRS_QUALTY.BoundText = Space(2)
      Else
        M_PRS_QUALTY.BoundText = "18" + PERSON.Resultset![prs_qualty]
      End If
      End If
  m_form_disp = 2
 If Not IsNull(PERSON.Resultset![prs_inst]) Then
          m_prs_noinst = PERSON.Resultset![prs_inst]
           v_form1.sql = "EXEC SERH_SUB_NAME " & "'" & m_prs_noinst & "'"
           v_form1.Refresh
           
             If Not v_form1.Resultset.EOF And Not v_form1.Resultset.BOF Then
               m_prs_inst.Text = v_form1.Resultset![sub_name]
               Else
                 m_prs_noinst = ""
                 m_prs_inst.Text = ""
             End If
       Else
             m_prs_noinst = ""
             m_prs_inst.Text = ""
    End If
If Not IsNull(PERSON.Resultset![prs_inst_tel]) Then
  M_PRS_INST_TEL.Text = PERSON.Resultset![prs_inst_tel]
 End If
If Not IsNull(PERSON.Resultset![prs_adrs1]) Then
  M_PRS_ADRS1.Text = PERSON.Resultset![prs_adrs1]
 End If
  
 
If Not IsNull(PERSON.Resultset![prs_inst_box]) Then
  M_PRS_INST_BOX.Text = PERSON.Resultset![prs_inst_box]
 End If
 If Not IsNull(PERSON.Resultset![prs_inst_email]) Then
  M_PRS_INST_EMAIL.Text = PERSON.Resultset![prs_inst_email]
 End If
   If Not IsNull(PERSON.Resultset![prs_adrs]) Then
  M_PRS_ADRS.Text = PERSON.Resultset![prs_adrs]
 End If
If Not IsNull(PERSON.Resultset![prs_tel]) Then
  M_PRS_TEL.Text = PERSON.Resultset![prs_tel]
 End If
If Not IsNull(PERSON.Resultset![prs_email]) Then
  M_PRS_EMAIL.Text = PERSON.Resultset![prs_email]
 End If
If Not IsNull(PERSON.Resultset![prs_box]) Then
  M_PRS_BOX.Text = PERSON.Resultset![prs_box]
 End If
If Not IsNull(PERSON.Resultset![prs_icht_dte1]) Then
  m_prs_dte1.Text = PERSON.Resultset![prs_icht_dte1]
  Else
  m_prs_dte1.Text = "__/__/____"
 End If
 If Not IsNull(PERSON.Resultset![prs_social_media]) Then
  m_prs_social_media.Text = PERSON.Resultset![prs_social_media]
 End If
 If Not IsNull(PERSON.Resultset![prs_mzhb]) Then
      If PERSON.Resultset![prs_mzhb] = "" Then
          m_prs_mzhb.BoundText = Space(2)
      Else
        m_prs_mzhb.BoundText = "17" + PERSON.Resultset![prs_mzhb]
      End If
      End If
      If Not IsNull(PERSON.Resultset![prs_politc]) Then
      If PERSON.Resultset![prs_politc] = "" Then
          m_prs_poltic.BoundText = Space(2)
      Else
        m_prs_poltic.BoundText = "18" + PERSON.Resultset![prs_politc]
      End If
      End If
      If Not IsNull(PERSON.Resultset![prs_sex]) Then
      If PERSON.Resultset![prs_sex] = "" Then
          m_prs_sex.BoundText = Space(2)
      Else
        m_prs_sex.BoundText = "40" + PERSON.Resultset![prs_sex]
      End If
      End If
       If Not IsNull(PERSON.Resultset![prs_oldjob]) Then
      If PERSON.Resultset![prs_oldjob] = "" Then
          M_PRS_QUALTY.BoundText = Space(2)
      Else
        m_prs_oldjob.BoundText = "18" + PERSON.Resultset![prs_oldjob]
      End If
      End If
End Function
Private Sub Command1_Click()

 
m_prs_name.Text = ""
m_prs_dte.Text = ""
m_vlg.Text = ""
m_prs_inst.Text = ""
M_PRS_INST_TEL.Text = ""
M_PRS_INST_BOX.Text = ""
M_PRS_INST_EMAIL.Text = ""
M_PRS_ADRS1.Text = ""
M_PRS_ADRS.Text = ""
M_PRS_TEL.Text = ""
M_PRS_BOX.Text = ""
M_PRS_EMAIL.Text = ""
m_prs_inst_direct.Text = ""
M_PRS_QUALTY.Text = ""
m_typ_icht.value = False
m_typ_icht1.value = False
m_prs_dte1.Text = ""
m_prs_dte2.Text = ""
m_prs_sex.Text = ""
m_prs_oldjob = ""
m_typ_icht.SetFocus
m_typ_opr = 1
End Sub


Private Sub Command10_Click()
sql = "execute insr_person1 " & "'" & m_prs_no.Text & "'"
                cn.Execute sql, rdExecDirect
m_prs_name.SetFocus
Frame3.Visible = False


End Sub

Private Sub Command11_Click()
Unload person_f
End Sub

Private Sub Command12_Click()
Frame2.Visible = False
Command8.SetFocus


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
PERSON.sql = "exec SERH_person " & "'" & m_mn_app_no & "'"
PERSON.Refresh
typ_serh = 2
If Not PERSON.Resultset.EOF Or Not PERSON.Resultset.BOF Then
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
   sql = "execute insr_person " & "'" & m_prs_no.Text & "'" & "," & "'" & m_prs_name.Text & "'" & "," _
   & "'" & Format(m_prs_dte.Text, "yyyy/mm/dd") & "'" & "," & "'" & m_prs_vlg & "'" & "," _
    & "'" & m_prs_icht & "'" & "," & "'" & M_PRS_QUALTY.BoundText & "'" & "," _
     & "'" & m_prs_noinst & "'" & "," & "'" & M_PRS_INST_TEL.Text & "'" & "," _
     & "'" & M_PRS_INST_BOX.Text & "'" & "," & "'" & m_prs_nodirect & "'" & "," _
     & "'" & M_PRS_INST_EMAIL.Text & "'" & "," & "'" & M_PRS_ADRS1.Text & "'" & "," _
     & "'" & M_PRS_ADRS.Text & "'" & "," & "'" & M_PRS_TEL.Text & "'" & "," _
      & "'" & M_PRS_BOX.Text & "'" & "," & "'" & M_PRS_EMAIL.Text & "'" & "," _
      & "'" & Format(m_prs_dte1.Text, "yyyy/mm/dd") & "'" & "," _
      & "'" & Format(m_prs_dte2.Text, "yyyy/mm/dd") & "'"
       
'       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
     m_typ_opr = 2
     Frame1.Visible = False
     PERSON.Refresh
  Command1.SetFocus
  
End Sub

Private Sub Command3_Click()
Frame1.Visible = False
M_PRS_EMAIL.SetFocus
End Sub

Private Sub Command4_Click()
'Dim cn As New rdoConnection
 Dim sql As String
 Dim m_bk_ser As Variant
  Dim m_dte, m_dte1 As Variant
 If m_prs_dte = "__/__/____" Then
    m_dte = ""
  Else
    m_dte = m_prs_dte.Text
 End If
 
 If m_prs_dte1 = "__/__/____" Then
    m_dte1 = ""
  Else
    m_dte1 = m_prs_dte.Text
 End If
   sql = "execute upd_person1 " & "'" & m_prs_no.Text & "'" & "," & "'" & m_prs_name.Text & "'" & "," _
   & "'" & Format(m_dte, "yyyy/mm/dd") & "'" & "," & "'" & m_prs_vlg & "'" & "," _
      & "'" & Mid(M_PRS_QUALTY.BoundText, 3, 3) & "'" & "," _
     & "'" & m_prs_noinst & "'" & "," & "'" & M_PRS_INST_TEL.Text & "'" & "," _
     & "'" & M_PRS_INST_BOX.Text & "'" & "," & "'" & m_prs_nodirect & "'" & "," _
     & "'" & M_PRS_INST_EMAIL.Text & "'" & "," & "'" & M_PRS_ADRS1.Text & "'" & "," _
     & "'" & M_PRS_ADRS.Text & "'" & "," & "'" & M_PRS_TEL.Text & "'" & "," _
      & "'" & M_PRS_BOX.Text & "'" & "," & "'" & M_PRS_EMAIL.Text & "'" & "," _
      & "'" & Format(m_dte1, "yyyy/mm/dd") & "'" & "," _
      & "'" & Mid(m_prs_mzhb.BoundText, 3, 3) & "'" & "," _
      & "'" & Mid(m_prs_poltic.BoundText, 3, 3) & "'" & "," _
      & "'" & m_prs_social_media.Text & "'" & "," _
      & "'" & Mid(m_prs_sex.BoundText, 3, 3) & "'" & "," _
      & "'" & Mid(m_prs_oldjob.BoundText, 3, 3) & "'"
       
                cn.Execute sql, rdExecDirect


  
  
 
End Sub

Private Sub Command5_Click()
If typ_serh = 2 Then
 PERSON.sql = "select *from person"
 PERSON.Refresh
 typ_serh = 1
End If
If Not PERSON.Resultset.BOF Then
  PERSON.Resultset.MovePrevious
If Not PERSON.Resultset.BOF Then
   Call display_fld
Else
 MsgBox "·«ÌÊÃœ «” „«—… ”«»ﬁ… .....!!!"
End If
End If

End Sub

Private Sub Command6_Click()
If typ_serh = 2 Then
 PERSON.sql = "select *from person"
 PERSON.Refresh
 typ_serh = 1
End If
If Not PERSON.Resultset.EOF Then
   PERSON.Resultset.MoveNext
End If
If Not PERSON.Resultset.EOF Then
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
 sql = "exec del_person" & "'" & m_prs_no.Text & "'"
 cn.Execute sql, rdExecDirect
  PERSON.Refresh
m_prs_no.Text = ""
m_prs_name.Text = ""
m_prs_dte.Text = ""
m_vlg.Text = ""
m_prs_inst.Text = ""
M_PRS_INST_TEL.Text = ""
M_PRS_INST_BOX.Text = ""
M_PRS_INST_EMAIL.Text = ""
M_PRS_ADRS1.Text = ""
M_PRS_ADRS.Text = ""
M_PRS_TEL.Text = ""
M_PRS_BOX.Text = ""
M_PRS_EMAIL.Text = ""
m_prs_inst_direct.Text = ""
M_PRS_QUALTY.Text = ""
m_prs_dte1.Text = ""
m_prs_mzhb.Text = ""
m_prs_poltic.Text = ""
m_prs_sex.Text = ""
m_prs_oldjob = ""
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
 PERSON.sql = "exec SERH_person1 " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
  PERSON.Refresh
  typ_serh = 2
  Frame2.Visible = False
  
If Not PERSON.Resultset.EOF Or Not PERSON.Resultset.BOF Then
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
  If m_tabindex = 11 Then
      view_form.Resultset.Bookmark = DBList1.SelectedItem
      m_prs_inst.Text = view_form.Resultset![sub_name]
      m_prs_noinst = view_form.Resultset![sub_typ] + view_form.Resultset![sub_no]
      
      M_PRS_INST_TEL.SetFocus
  ElseIf m_tabindex = 41 Then
       view_form.Resultset.Bookmark = DBList1.SelectedItem
      m_prs_inst_direct.Text = view_form.Resultset![sub_name]
      m_prs_nodirect = view_form.Resultset![sub_typ] + view_form.Resultset![sub_no]
      M_PRS_INST_BOX.SetFocus
      
 ElseIf m_tabindex = 44 Then
       view_form.Resultset.Bookmark = DBList1.SelectedItem
      m_vlg.Text = view_form.Resultset![sub_name]
      m_prs_vlg = view_form.Resultset![sub_typ] + view_form.Resultset![sub_no]
      m_prs_dte.SetFocus
 
 End If
 DBList1.Visible = False
   

ElseIf KeyAscii = 27 Then
  DBList1.Visible = False
  If m_tabindex = 11 Then
     M_PRS_QUALTY.SetFocus
  ElseIf m_tabindex = 41 Then
    M_PRS_ADRS1.SetFocus
  ElseIf m_tabindex = 45 Then
    m_prs_name.SetFocus
   
  End If
  
End If
End Sub

Private Sub DBList2_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 DBList2.Visible = False
 Call display_fld
  m_prs_name.SetFocus
  DBList2.Visible = False
ElseIf KeyAscii = 27 Then
 DBList2.Visible = False
End If
End Sub

Private Sub Form_Load()
typ_serh = 1
m_typ_opr = 2
m_form_disp = 1
m_prs_vlg = Space(10)
m_prs_noinst = Space(10)
m_prs_nodirect = Space(10)
m_prs_icht = 0
 m_mn_app_no = m_prsno
m_prs_no.Text = m_prsno
m_sub_name = m_prs_sub_name
PERSON.sql = "exec SERH1_person " & "'" & m_mn_app_no & "'"
PERSON.Refresh
typ_serh = 2
If Not PERSON.Resultset.EOF Or Not PERSON.Resultset.BOF Then
  Call display_fld
 Else
  Frame3.Visible = True
'  Command10.SetFocus
  
 End If
End Sub

Private Sub m_ist_name_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Command9.SetFocus
  ElseIf KeyAscii = 27 Then
   Frame2.Visible = False
   Command8.SetFocus
   
   
End If

End Sub

Private Sub m_ist_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 v_prs_no = "000000"
    m_no = 0
    m_no = Val(LTrim(m_ist_no.Text))
    v_prs_no = Mid(v_prs_no, 1, 5 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
    m_ist_no.Text = v_prs_no
Command15.SetFocus
ElseIf KeyAscii = 27 Then
 Frame2.Visible = False
 Command10.SetFocus
 
End If

End Sub

Private Sub M_PRS_ADRS_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_PRS_TEL.SetFocus
End If
End Sub

Private Sub M_PRS_ADRS1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
m_prs_inst_direct.SetFocus
 
End If
End Sub

Private Sub M_PRS_BOX_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_prs_dte1.SetFocus
End If

End Sub

Private Sub M_PRS_DTE_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
m_prs_mzhb.SetFocus
  SendKeys "{f4}"
End If
End Sub

Private Sub m_prs_dte1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  M_PRS_EMAIL.SetFocus
End If
End Sub

Private Sub m_prs_dte2_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 Frame1.Visible = True
  M_YESNO.SetFocus
End If
End Sub

Private Sub M_PRS_EMAIL_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_prs_social_media.SetFocus
End If
End Sub

Private Sub M_PRS_INST_BOX_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_PRS_INST_EMAIL.SetFocus
End If

End Sub

Private Sub m_prs_inst_Change()
If m_form_disp = 1 Then
If DBList1.Visible = False Then
    DBList1.Visible = True
    DBList1.Left = 6840
      DBList1.Top = 3840
  End If
  m_tabindex = 11
  If Not Trim(m_prs_inst.Text) = "" Then
      ' If m_typ_serh = 1 Then
         m_desc = m_prs_inst.Text
         
         m_len = Len(Trim(m_prs_inst.Text))
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

Private Sub m_prs_inst_direct_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 40 And Not m_prs_inst_direct.Text = "" Then
   DBList1.SetFocus
   SendKeys "{UP}"
End If
End Sub

Private Sub M_PRS_INST_DIRECT_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_PRS_INST_BOX.SetFocus
End If

End Sub

Private Sub M_PRS_INST_EMAIL_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
m_prs_oldjob.SetFocus
  SendKeys "{f4}"
End If
End Sub

Private Sub m_prs_inst_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 40 And Not m_prs_inst.Text = "" Then
   DBList1.SetFocus
   SendKeys "{UP}"
End If

End Sub

Private Sub M_PRS_INST_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_PRS_INST_TEL.SetFocus
End If
End Sub

Private Sub M_PRS_INST_TEL_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  M_PRS_ADRS1.SetFocus
End If
End Sub

Private Sub m_prs_mzhb_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
m_prs_sex.SetFocus
  SendKeys "{f4}"
End If
End Sub

Private Sub m_prs_name_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then

 Dim sql As String
Dim m_desc As String
Const None As String = ""
m_desc = m_prs_name.Text
If Not IsNull(m_desc) And Not Trim(m_desc) = "" Then
  m_len = Len(m_desc)
   PERSON.sql = "exec SERH_person1 " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
  PERSON.Refresh
  If Not PERSON.Resultset.EOF Or Not PERSON.Resultset.BOF Then
    MsgBox "    «‰ »Â Â–« «·«”„ „ÊÃÊœ ...øøøø"
    m_prs_name.SetFocus
    
    Else
 m_vlg.SetFocus
 End If
 Else
  m_vlg.SetFocus
 End If
End If

End Sub

Private Sub m_prs_oldjob_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_PRS_ADRS.SetFocus
End If

End Sub

Private Sub m_prs_poltic_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
M_PRS_QUALTY.SetFocus
  SendKeys "{f4}"
End If
End Sub

Private Sub M_PRS_QUALTY_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
m_prs_inst.SetFocus
  
End If
End Sub

Private Sub m_prs_sex_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
m_prs_poltic.SetFocus
  SendKeys "{f4}"
End If
End Sub

Private Sub M_PRS_TEL_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_PRS_BOX.SetFocus
End If
End Sub

Private Sub m_typ_icht_Click()
 If m_typ_icht = True Then
    m_prs_icht = 1
  End If
End Sub

Private Sub m_typ_icht_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_prs_name.SetFocus
 
  If m_typ_icht = True Then
    m_prs_icht = 1
  End If
  
End If
End Sub

Private Sub m_typ_icht1_Click()
 If m_typ_icht1 = True Then
    m_prs_icht = 2
  End If
End Sub

Private Sub m_typ_icht1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_prs_name.SetFocus
  If m_typ_icht1 = True Then
    m_prs_icht = 2
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
  m_prs_dte.SetFocus
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

