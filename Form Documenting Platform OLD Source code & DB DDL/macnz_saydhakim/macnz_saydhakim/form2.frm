VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{6BF52A50-394A-11D3-B153-00C04F79FAA6}#1.0#0"; "wmp.dll"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form Form2 
   BackColor       =   &H00808080&
   Caption         =   "ÈÑäÇãÌ ãÚÇáÌÉ ÇáÊÍáíá"
   ClientHeight    =   11115
   ClientLeft      =   675
   ClientTop       =   -165
   ClientWidth     =   19920
   LinkTopic       =   "Form2"
   Moveable        =   0   'False
   RightToLeft     =   -1  'True
   ScaleHeight     =   11115
   ScaleWidth      =   19920
   Visible         =   0   'False
   Begin VB.CommandButton Command8 
      BackColor       =   &H80000004&
      Caption         =   "ãáÝÇÊ ÇÖÇÝíÉ ááÊÑãíÒ "
      Height          =   975
      Left            =   120
      Style           =   1  'Graphical
      TabIndex        =   58
      Top             =   6480
      Width           =   855
   End
   Begin VB.Frame Frame1 
      Caption         =   "ÇáäÕ"
      Height          =   5415
      Left            =   4560
      RightToLeft     =   -1  'True
      TabIndex        =   52
      Top             =   3000
      Visible         =   0   'False
      Width           =   9375
      Begin RichTextLib.RichTextBox m_txt_text 
         Height          =   4335
         Left            =   240
         TabIndex        =   53
         Top             =   480
         Width           =   8895
         _ExtentX        =   15690
         _ExtentY        =   7646
         _Version        =   393217
         Enabled         =   -1  'True
         ScrollBars      =   2
         MousePointer    =   3
         DisableNoScroll =   -1  'True
         Appearance      =   0
         TextRTF         =   $"form2.frx":0000
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Simplified Arabic"
            Size            =   15.75
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.TextBox m_word 
         Alignment       =   1  'Right Justify
         Height          =   375
         Left            =   5760
         RightToLeft     =   -1  'True
         TabIndex        =   57
         Top             =   4800
         Width           =   2055
      End
      Begin VB.CommandButton Command4 
         Caption         =   "ÇáÈÍË Úä ßáãÉ"
         Height          =   495
         Left            =   7800
         RightToLeft     =   -1  'True
         TabIndex        =   56
         Top             =   4800
         Width           =   1575
      End
   End
   Begin MSDBCtls.DBList DBList13 
      Bindings        =   "form2.frx":009D
      Height          =   1425
      Left            =   7320
      TabIndex        =   32
      Top             =   5520
      Visible         =   0   'False
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   2514
      _Version        =   393216
      BackColor       =   14737632
      ListField       =   "pos_nam"
      RightToLeft     =   -1  'True
   End
   Begin VB.CommandButton Command5 
      Caption         =   "ÝÊÍ ÇáäÕ"
      Height          =   975
      Left            =   120
      TabIndex        =   54
      Top             =   4080
      Width           =   855
   End
   Begin VB.CommandButton Command25 
      Caption         =   "out"
      Height          =   375
      Left            =   4320
      RightToLeft     =   -1  'True
      TabIndex        =   51
      Top             =   3240
      Width           =   495
   End
   Begin VB.CommandButton Command26 
      BackColor       =   &H00E0E0E0&
      Caption         =   "in"
      Height          =   375
      Left            =   3840
      RightToLeft     =   -1  'True
      TabIndex        =   50
      Top             =   3240
      Width           =   495
   End
   Begin VB.CommandButton Command6 
      Height          =   375
      Left            =   3480
      Picture         =   "form2.frx":00B4
      Style           =   1  'Graphical
      TabIndex        =   48
      Top             =   3240
      Width           =   375
   End
   Begin VB.CommandButton Command7 
      Height          =   375
      Left            =   2760
      Picture         =   "form2.frx":0459
      Style           =   1  'Graphical
      TabIndex        =   47
      Top             =   3240
      Width           =   375
   End
   Begin VB.TextBox m_step 
      Alignment       =   2  'Center
      Height          =   375
      Left            =   3120
      Locked          =   -1  'True
      TabIndex        =   46
      Text            =   "1"
      Top             =   3240
      Width           =   375
   End
   Begin VB.TextBox m_mch_s1 
      Alignment       =   1  'Right Justify
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
      Height          =   405
      Left            =   3120
      RightToLeft     =   -1  'True
      TabIndex        =   43
      Top             =   9480
      Width           =   495
   End
   Begin VB.TextBox m_mch_o1 
      Alignment       =   1  'Right Justify
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
      Height          =   375
      Left            =   1920
      RightToLeft     =   -1  'True
      TabIndex        =   42
      Top             =   9480
      Width           =   495
   End
   Begin VB.TextBox m_mch_m1 
      Alignment       =   1  'Right Justify
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
      Height          =   375
      Left            =   2520
      RightToLeft     =   -1  'True
      TabIndex        =   41
      Top             =   9480
      Width           =   495
   End
   Begin VB.TextBox m_mch_o 
      Alignment       =   1  'Right Justify
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
      Height          =   375
      Left            =   4920
      RightToLeft     =   -1  'True
      TabIndex        =   40
      Top             =   9480
      Width           =   495
   End
   Begin VB.TextBox m_mch_m 
      Alignment       =   1  'Right Justify
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
      Height          =   375
      Left            =   5520
      RightToLeft     =   -1  'True
      TabIndex        =   39
      Top             =   9480
      Width           =   495
   End
   Begin VB.TextBox m_mch_s 
      Alignment       =   1  'Right Justify
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
      Height          =   375
      Left            =   6120
      RightToLeft     =   -1  'True
      TabIndex        =   38
      Top             =   9480
      Width           =   495
   End
   Begin VB.OptionButton Option1 
      BackColor       =   &H00808080&
      Caption         =   "ÈÍË ÈÇáÈÏÇíÉ"
      Height          =   375
      Left            =   16200
      TabIndex        =   37
      Top             =   360
      Width           =   1215
   End
   Begin VB.OptionButton Option2 
      BackColor       =   &H00808080&
      Caption         =   "ÈÍË ÈßáãÉ ãÚíäÉ "
      Height          =   375
      Left            =   14880
      TabIndex        =   36
      Top             =   360
      Width           =   1215
   End
   Begin VB.CommandButton Command3 
      Caption         =   "ÊÞÏã"
      Height          =   375
      Left            =   1560
      RightToLeft     =   -1  'True
      TabIndex        =   35
      Top             =   3840
      Width           =   975
   End
   Begin VB.CommandButton Command2 
      Caption         =   "ÊÑÇÌÚ"
      Height          =   435
      Left            =   5520
      RightToLeft     =   -1  'True
      TabIndex        =   34
      Top             =   3840
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "ÇÛáÇÞ ÇáÕÝÍÉ"
      Height          =   975
      Left            =   120
      TabIndex        =   16
      Top             =   5280
      Width           =   855
   End
   Begin VB.TextBox Text4 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   6960
      TabIndex        =   30
      Top             =   600
      Visible         =   0   'False
      Width           =   4575
   End
   Begin MSRDC.MSRDC geo1 
      Height          =   330
      Left            =   480
      Top             =   10200
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
      RecordSource    =   "select * from geo"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "geo1"
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
   Begin MSRDC.MSRDC rel2 
      Height          =   330
      Left            =   240
      Top             =   9960
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
      RecordSource    =   "select * from relative"
      UserName        =   ""
      Password        =   ""
      Connect         =   "  "
      LogMessages     =   ""
      Caption         =   "rel2"
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
   Begin MSRDC.MSRDC file_add 
      Height          =   570
      Left            =   3600
      Top             =   10440
      Visible         =   0   'False
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   1005
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
      RecordSource    =   "select * from file_add"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "file_add"
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
   Begin MSDBCtls.DBList DBList12 
      Bindings        =   "form2.frx":07FD
      Height          =   3705
      Left            =   7080
      TabIndex        =   18
      ToolTipText     =   "F8 ááÈÍË Ýí ÇáÈÏÇíÉ  , F9 ááÈÍË Úä ßáãÉ , ENTER ááÇÎÊíÇÑ , ESC ááÎÑæÌ , F2 áÇÆÍÉ ÇáãäÇÕÈ"
      Top             =   1080
      Visible         =   0   'False
      Width           =   4455
      _ExtentX        =   7858
      _ExtentY        =   6535
      _Version        =   393216
      BackColor       =   14737632
      ForeColor       =   0
      ListField       =   "SUB_NAME"
      BoundColumn     =   "SUB_NAME"
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Simplified Arabic"
         Size            =   12
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSRDC.MSRDC view_form 
      Height          =   450
      Left            =   8400
      Top             =   9960
      Visible         =   0   'False
      Width           =   3255
      _ExtentX        =   5741
      _ExtentY        =   794
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
   Begin MSRDC.MSRDC an 
      Height          =   330
      Left            =   11400
      Top             =   10080
      Visible         =   0   'False
      Width           =   2040
      _ExtentX        =   3598
      _ExtentY        =   582
      _Version        =   393216
      Options         =   0
      CursorDriver    =   1
      BOFAction       =   0
      EOFAction       =   0
      RecordsetType   =   1
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
      RecordSource    =   "select * from analis"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "an"
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
   Begin MSDBCtls.DBList DBList11 
      Bindings        =   "form2.frx":0815
      Height          =   3705
      Left            =   7080
      TabIndex        =   17
      ToolTipText     =   "F8 ááÈÍË Ýí ÇáÈÏÇíÉ  , F9 ááÈÍË Úä ßáãÉ , ENTER ááÇÎÊíÇÑ , ESC ááÎÑæÌ "
      Top             =   840
      Visible         =   0   'False
      Width           =   4455
      _ExtentX        =   7858
      _ExtentY        =   6535
      _Version        =   393216
      BackColor       =   14737632
      ForeColor       =   16711680
      ListField       =   "sub_desc"
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Simplified Arabic"
         Size            =   12
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSRDC.MSRDC macnz 
      Height          =   330
      Left            =   12840
      Top             =   10080
      Visible         =   0   'False
      Width           =   1935
      _ExtentX        =   3413
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
      RecordSource    =   "select * from macnz"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "macnz"
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
   Begin MSDBCtls.DBList DBList10 
      Bindings        =   "form2.frx":0829
      Height          =   1485
      Left            =   12000
      TabIndex        =   10
      Top             =   8400
      Width           =   7695
      _ExtentX        =   13573
      _ExtentY        =   2619
      _Version        =   393216
      ListField       =   "sub_name"
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   12
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSDBCtls.DBList DBList9 
      Bindings        =   "form2.frx":0840
      Height          =   1200
      Left            =   12000
      TabIndex        =   9
      Top             =   6960
      Width           =   7695
      _ExtentX        =   13573
      _ExtentY        =   2117
      _Version        =   393216
      ListField       =   "sub_name"
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   12
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSRDC.MSRDC fileadd4 
      Height          =   330
      Left            =   14280
      Top             =   9960
      Visible         =   0   'False
      Width           =   1920
      _ExtentX        =   3387
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
      Caption         =   "fileadd4"
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
   Begin MSRDC.MSRDC fileadd3 
      Height          =   330
      Left            =   14160
      Top             =   10080
      Visible         =   0   'False
      Width           =   2415
      _ExtentX        =   4260
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
      Caption         =   "fileadd3"
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
   Begin MSRDC.MSRDC fileadd2 
      Height          =   330
      Left            =   6960
      Top             =   10080
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
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "fileadd2"
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
   Begin MSDBCtls.DBList DBList8 
      Bindings        =   "form2.frx":0857
      Height          =   915
      Left            =   1200
      TabIndex        =   15
      Top             =   8160
      Width           =   5895
      _ExtentX        =   10398
      _ExtentY        =   1614
      _Version        =   393216
      ListField       =   "sub_name"
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   12
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSDBCtls.DBList DBList7 
      Bindings        =   "form2.frx":086E
      Height          =   915
      Left            =   1200
      TabIndex        =   14
      Top             =   6840
      Width           =   5895
      _ExtentX        =   10398
      _ExtentY        =   1614
      _Version        =   393216
      ListField       =   "sub_name"
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   12
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSRDC.MSRDC fileadd1 
      Height          =   495
      Left            =   1200
      Top             =   8400
      Visible         =   0   'False
      Width           =   1935
      _ExtentX        =   3413
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
      Caption         =   "fileadd1"
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
   Begin MSDBCtls.DBList DBList6 
      Bindings        =   "form2.frx":0885
      Height          =   915
      Left            =   1200
      TabIndex        =   12
      Top             =   4440
      Width           =   5895
      _ExtentX        =   10398
      _ExtentY        =   1614
      _Version        =   393216
      BackColor       =   16777215
      ListField       =   "sub_desc"
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   12
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSRDC.MSRDC rel1 
      Height          =   330
      Left            =   2520
      Top             =   8400
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
      Caption         =   "rel1"
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
   Begin MSRDC.MSRDC NAR1 
      Height          =   375
      Left            =   2400
      Top             =   10320
      Visible         =   0   'False
      Width           =   2655
      _ExtentX        =   4683
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
      Caption         =   "NAR1"
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
      Bindings        =   "form2.frx":0898
      Height          =   915
      Left            =   1200
      TabIndex        =   13
      Top             =   5640
      Width           =   5895
      _ExtentX        =   10398
      _ExtentY        =   1614
      _Version        =   393216
      ListField       =   "SUB_DESC"
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   12
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.TextBox Text3 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   4200
      LinkTimeout     =   2
      TabIndex        =   11
      Text            =   "02"
      Top             =   3840
      Width           =   375
   End
   Begin MSDBCtls.DBList DBList4 
      Bindings        =   "form2.frx":08AB
      Height          =   1200
      Left            =   11880
      TabIndex        =   7
      Top             =   4320
      Width           =   7815
      _ExtentX        =   13785
      _ExtentY        =   2117
      _Version        =   393216
      ListField       =   "SUB_DESC"
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   12
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSRDC.MSRDC RELATIVE 
      Height          =   330
      Left            =   5160
      Top             =   9960
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
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "RELATIVE"
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
   Begin MSRDC.MSRDC narower 
      Height          =   330
      Left            =   6120
      Top             =   10080
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
      Caption         =   "narower"
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
      Bindings        =   "form2.frx":08C2
      Height          =   915
      Left            =   11880
      TabIndex        =   8
      Top             =   5760
      Width           =   7815
      _ExtentX        =   13785
      _ExtentY        =   1614
      _Version        =   393216
      ListField       =   "sub_desc"
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   12
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSRDC.MSRDC GEO 
      Height          =   375
      Left            =   16320
      Top             =   10080
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
      Caption         =   "GEO"
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
      Bindings        =   "form2.frx":08D8
      Height          =   915
      Left            =   11880
      TabIndex        =   6
      Top             =   3120
      Width           =   7815
      _ExtentX        =   13785
      _ExtentY        =   1614
      _Version        =   393216
      ListField       =   "sub_name"
      BoundColumn     =   ""
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   12
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSRDC.MSRDC ANALIS 
      Height          =   330
      Left            =   6480
      Top             =   9960
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
      UserName        =   " "
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "ANALIS"
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
      Bindings        =   "form2.frx":08EA
      DataSource      =   "ANALIS"
      Height          =   1200
      Index           =   0
      Left            =   11880
      TabIndex        =   5
      Top             =   1560
      Width           =   7815
      _ExtentX        =   13785
      _ExtentY        =   2117
      _Version        =   393216
      ListField       =   "SUB_DESC"
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   12
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.TextBox Text2 
      Alignment       =   1  'Right Justify
      Enabled         =   0   'False
      Height          =   285
      Left            =   11880
      RightToLeft     =   -1  'True
      TabIndex        =   1
      Top             =   840
      Width           =   6735
   End
   Begin VB.TextBox Text1 
      Enabled         =   0   'False
      Height          =   285
      Left            =   17520
      TabIndex        =   0
      Top             =   480
      Width           =   1095
   End
   Begin MSRDC.MSRDC MAIN 
      Height          =   330
      Left            =   10320
      Top             =   10200
      Visible         =   0   'False
      Width           =   2730
      _ExtentX        =   4815
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
      UserName        =   " "
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "MAIN"
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
   Begin MSRDC.MSRDC nar2 
      Height          =   330
      Left            =   1560
      Top             =   8520
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
      RecordSource    =   "select * from narower"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "nar2"
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
      Left            =   12600
      Top             =   9960
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
   Begin MSRDC.MSRDC time 
      Height          =   375
      Left            =   14880
      Top             =   10080
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
      UserName        =   " "
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "time"
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
   Begin MSRDC.MSRDC d_text 
      Height          =   330
      Left            =   10080
      Top             =   10080
      Visible         =   0   'False
      Width           =   3255
      _ExtentX        =   5741
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
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "d_text"
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
   Begin MSRDC.MSRDC ranj 
      Height          =   375
      Left            =   16320
      Top             =   9960
      Visible         =   0   'False
      Width           =   2895
      _ExtentX        =   5106
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
      RecordSource    =   "select ranjpath.* from ranjpath"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "ranj"
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
   Begin VB.TextBox M_MN_RESULT 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1125
      Left            =   12000
      MaxLength       =   999
      MultiLine       =   -1  'True
      RightToLeft     =   -1  'True
      TabIndex        =   55
      Top             =   9960
      Width           =   7695
   End
   Begin MSMask.MaskEdBox m_dte_deb 
      Height          =   495
      Left            =   9480
      TabIndex        =   61
      Top             =   9360
      Width           =   1695
      _ExtentX        =   2990
      _ExtentY        =   873
      _Version        =   393216
      BackColor       =   16777215
      MaxLength       =   10
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   "dd/mm/yyyy"
      Mask            =   "##/##/####"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox m_dte_fin 
      Height          =   495
      Left            =   7320
      TabIndex        =   62
      Top             =   9360
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   873
      _Version        =   393216
      BackColor       =   16777215
      MaxLength       =   10
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   "dd/mm/yyyy"
      Mask            =   "##/##/####"
      PromptChar      =   "_"
   End
   Begin MSRDC.MSRDC dte_subject 
      Height          =   375
      Left            =   -600
      Top             =   10320
      Visible         =   0   'False
      Width           =   2655
      _ExtentX        =   4683
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
      Caption         =   "dte_subject"
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
   Begin VB.Label Label19 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00808080&
      Caption         =   "Çáì"
      Height          =   495
      Left            =   3720
      RightToLeft     =   -1  'True
      TabIndex        =   63
      Top             =   9480
      Width           =   615
   End
   Begin VB.Shape Shape7 
      BorderColor     =   &H80000006&
      FillColor       =   &H0000C0C0&
      Height          =   1095
      Left            =   7200
      Top             =   9000
      Width           =   4695
   End
   Begin VB.Label Label18 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00808080&
      Caption         =   "ãÜä ÊÇÑíÎ "
      Height          =   495
      Left            =   11160
      RightToLeft     =   -1  'True
      TabIndex        =   60
      Top             =   9360
      Width           =   615
   End
   Begin VB.Label tit_istext 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00808080&
      ForeColor       =   &H000000FF&
      Height          =   375
      Left            =   9840
      RightToLeft     =   -1  'True
      TabIndex        =   59
      Top             =   0
      Width           =   1815
   End
   Begin WMPLibCtl.WindowsMediaPlayer WindowsMediaPlayer1 
      Height          =   3735
      Left            =   0
      TabIndex        =   49
      Top             =   0
      Width           =   6855
      URL             =   ""
      rate            =   1
      balance         =   0
      currentPosition =   0
      defaultFrame    =   ""
      playCount       =   1
      autoStart       =   -1  'True
      currentMarker   =   0
      invokeURLs      =   -1  'True
      baseURL         =   ""
      volume          =   50
      mute            =   0   'False
      uiMode          =   "full"
      stretchToFit    =   0   'False
      windowlessVideo =   0   'False
      enabled         =   -1  'True
      enableContextMenu=   -1  'True
      fullScreen      =   0   'False
      SAMIStyle       =   ""
      SAMILang        =   ""
      SAMIFilename    =   ""
      captioningID    =   ""
      enableErrorDialogs=   0   'False
      _cx             =   12091
      _cy             =   6588
   End
   Begin VB.Shape Shape6 
      BackColor       =   &H00000000&
      BorderWidth     =   3
      Height          =   3735
      Left            =   0
      Top             =   0
      Width           =   6975
   End
   Begin VB.Shape Shape5 
      Height          =   2415
      Left            =   240
      Top             =   240
      Width           =   5175
   End
   Begin VB.Label Label32 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00808080&
      Caption         =   "ãÜä"
      Height          =   495
      Left            =   6480
      RightToLeft     =   -1  'True
      TabIndex        =   45
      Top             =   9480
      Width           =   615
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00808080&
      Caption         =   "Çáì ÊÇÑíÎ"
      Height          =   375
      Index           =   1
      Left            =   8880
      RightToLeft     =   -1  'True
      TabIndex        =   44
      Top             =   9360
      Width           =   375
   End
   Begin VB.Label Label17 
      BackColor       =   &H00808080&
      Caption         =   "ÇáãäÇÕÈ"
      Height          =   255
      Left            =   8520
      RightToLeft     =   -1  'True
      TabIndex        =   33
      Top             =   6240
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.Label Label16 
      Caption         =   "ÇáÈÍË"
      Height          =   255
      Left            =   2160
      RightToLeft     =   -1  'True
      TabIndex        =   31
      Top             =   8520
      Visible         =   0   'False
      Width           =   615
   End
   Begin VB.Label Label15 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "ãáÝ ÇÖÇÝí Úäå ÚáÇÞÉ ÎÇÕÉ ÜÜ 60"
      Height          =   255
      Left            =   2760
      TabIndex        =   29
      Top             =   7800
      Width           =   2295
   End
   Begin VB.Label Label14 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "ãáÝ ÇÖÇÝí áå ÚáÇÞÉ ÎÇÕÉ ÜÜ 50"
      Height          =   375
      Left            =   2760
      TabIndex        =   28
      Top             =   6600
      Width           =   2175
   End
   Begin VB.Label Label13 
      Caption         =   "Label13"
      Height          =   135
      Left            =   1920
      TabIndex        =   27
      Top             =   3960
      Width           =   15
   End
   Begin VB.Label Label12 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "ãÊÑÇÈØ ÚáÇÞÉ ÎÇÕÉ ÜÜ 30"
      Height          =   375
      Left            =   2880
      TabIndex        =   26
      Top             =   4200
      Width           =   2055
   End
   Begin VB.Label Label11 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "ÇÖíÞ ÚáÇÞÉ ÎÇÕÉ ÜÜ 40"
      Height          =   255
      Left            =   2880
      TabIndex        =   25
      Top             =   5400
      Width           =   2055
   End
   Begin VB.Label Label10 
      BackColor       =   &H00808080&
      Caption         =   "ãáÝ ÇÖÇÝí Úäå ÜÜ 04"
      Height          =   255
      Left            =   15360
      TabIndex        =   24
      Top             =   8160
      Width           =   1575
   End
   Begin VB.Label Label9 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "ãáÝ ÇÖÇÝí áå ÜÜ 03"
      Height          =   255
      Left            =   15240
      TabIndex        =   23
      Top             =   6720
      Width           =   1695
   End
   Begin VB.Label Label8 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "ÇáãÊÑÇÈØ ÜÜ 01"
      Height          =   375
      Left            =   15120
      TabIndex        =   22
      Top             =   4080
      Width           =   1695
   End
   Begin VB.Label Label7 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "ÇáÇÖíÞ ÜÜ 02"
      Height          =   255
      Left            =   15240
      TabIndex        =   21
      Top             =   5520
      Width           =   1695
   End
   Begin VB.Label Label6 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "ÇáÌÛÑÇÝí ÜÜ 20"
      ForeColor       =   &H80000015&
      Height          =   255
      Left            =   15000
      TabIndex        =   20
      Top             =   2880
      Width           =   1815
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "ÇáæÇÕÝÇÊ ÜÜ 10"
      Height          =   255
      Left            =   15120
      TabIndex        =   19
      Top             =   1200
      Width           =   1215
   End
   Begin VB.Shape Shape4 
      Height          =   615
      Left            =   1200
      Top             =   2880
      Width           =   4095
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      Caption         =   ":ÑÞã ÇáÚáÇÞÉ"
      Height          =   255
      Left            =   2640
      TabIndex        =   4
      Top             =   3840
      Width           =   1095
   End
   Begin VB.Shape Shape3 
      Height          =   6375
      Left            =   1080
      Top             =   3720
      Width           =   6135
   End
   Begin VB.Shape Shape2 
      Height          =   12015
      Left            =   11520
      Top             =   1200
      Width           =   8535
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00808080&
      Caption         =   "ÇáÚäæÇä ÇáÝÚáí "
      Height          =   255
      Left            =   18480
      TabIndex        =   3
      Top             =   840
      Width           =   1335
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00808080&
      Caption         =   "ÇáÑÞã "
      Height          =   255
      Left            =   18720
      TabIndex        =   2
      Top             =   480
      Width           =   1095
   End
   Begin VB.Shape Shape1 
      BorderColor     =   &H80000006&
      FillColor       =   &H0000C0C0&
      Height          =   1095
      Left            =   11760
      Top             =   240
      Width           =   8055
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim m_tabindex As Variant
Dim typ_list1 As Variant
Dim m_typ_serh As Integer
Dim an_typ  As Variant
Dim v_ser_no As Variant
Dim m_bookmark As Integer
Dim m_bookmark1 As Integer
Dim m_bookmark2 As Integer
Dim is_mode As Integer


Function disp_time()
 On Error Resume Next
 If Not IsNull(time.Resultset![tm_s]) Then
      m_mch_s.Text = time.Resultset![tm_s]
   Else
     m_mch_s.Text = ""
   End If
   If Not IsNull(time.Resultset![tm_m]) Then
      m_mch_m.Text = time.Resultset![tm_m]
   Else
     m_mch_m.Text = ""
   End If
  If Not IsNull(time.Resultset![tm_o]) Then
      m_mch_o.Text = time.Resultset![tm_o]
   Else
     m_mch_o.Text = ""
   End If
If Not IsNull(time.Resultset![tm_s1]) Then
      m_mch_s1.Text = time.Resultset![tm_s1]
   Else
     m_mch_s1.Text = ""
   End If
   If Not IsNull(time.Resultset![tm_m1]) Then
      m_mch_m1.Text = time.Resultset![tm_m1]
   Else
     m_mch_m1.Text = ""
   End If
  If Not IsNull(time.Resultset![tm_o1]) Then
      m_mch_o1.Text = time.Resultset![tm_o1]
   Else
     m_mch_o1.Text = ""
   End If
   nb_page = 2
   If Not m_mch_o.Text = "" Then
      v_mch_o = m_mch_o.Text
    Else
      v_mch_o = v_mch_o1
   End If
   If Not m_mch_m.Text = "" Then
     v_mch_m = m_mch_m.Text
   Else
      v_mch_m = v_mch_m1
   End If
   If Not m_mch_s.Text = "" Then
     v_mch_s = m_mch_s.Text
    Else
      v_mch_s = v_mch_s1
   End If
   v_mch_o1 = m_mch_o1.Text
   v_mch_m1 = m_mch_m1.Text
   v_mch_s1 = m_mch_s1.Text
   ' V_MCH_STOCK = Trim(m_mch_stock)
     
   
Dim m_acrh_no   As Integer
 
'm_config_path_new = m_STCOK_path(Str(V_MCH_STOCK))
 m_time = Val(v_mch_s) + Val(v_mch_m) * 60 + Val(v_mch_o) * 3600
 m_time1 = Val(v_mch_s1) + Val(v_mch_m1) * 60 + Val(v_mch_o1) * 3600
' m_config_path_new = m_config_path_new
If v_mch_digtyp = "02" Then
          
        Else
m_config_path = m_STCOK_path_new(V_MCH_STOCK)
End If
M_NAM = m_config_path + Trim(V_MCH_STOCK) + "." + v_mch_typ

WindowsMediaPlayer1.URL = M_NAM
WindowsMediaPlayer1.Controls.Pause
'WindowsMediaPlayer1.Controls.SelectionStart = m_time
'WindowsMediaPlayer1.Controls.SelectionEnd = m_time1
WindowsMediaPlayer1.Controls.currentPosition = m_time

WindowsMediaPlayer1.Controls.Play
WindowsMediaPlayer1.Controls.Pause
m_tm = m_time
m_tm1 = m_time1
deb_tm = m_time
fin_tm = m_time1
  'm_config_path_new = m_cnf_path_pic + "avi\"
  '    m_time = Val(m_mch_s) + Val(m_mch_m) * 60 + Val(m_mch_o) * 3600
  '      m_time1 = Val(m_mch_s1) + Val(m_mch_m1) * 60 + Val(m_mch_o1) * 3600
  '      deb_tm = m_time
  '       m_tm = m_time
  '       m_tm1 = m_time1
  '      If m_time1 >= 0 And m_time1 > m_time And m_time >= 0 Then
  '         M_NAM = m_config_path_new + Trim(m_mch_stock) + ".avi"
  '         WindowsMediaPlayer1.Controls.FileName = M_NAM
  '         WindowsMediaPlayer1.Controls.Pause
  '         WindowsMediaPlayer1.Controls.SelectionStart = m_time
  '         WindowsMediaPlayer1.Controls.Play
  '         WindowsMediaPlayer1.Controls.Pause
  '         End If
  ' Screen.MousePointer = vbDefault
      '   Screen.MousePointer = vbHourglass
       '  vd_preview.WindowState = 0
       '   vd_preview.Show
' vd_prv.Show

         '  Screen.MousePointer = vbDefault
 
   ' vd_preview.Refresh
End Function




Function visibl_list(num As Integer, value As Boolean)
Select Case num
   Case 6
     DBList5.Visible = value
     Label11.Visible = value
     DBList7.Visible = value
     Label14.Visible = value
     DBList8.Visible = value
     Label15.Visible = value
   Case 7
      DBList5.Visible = value
     Label11.Visible = value
     DBList6.Visible = value
     Label12.Visible = value
     DBList8.Visible = value
     Label15.Visible = value
   Case 8
      DBList5.Visible = value
     Label11.Visible = value
     DBList6.Visible = value
     Label12.Visible = value
     DBList7.Visible = value
     Label14.Visible = value
   Case 5
      DBList6.Visible = value
     Label12.Visible = value
     DBList7.Visible = value
     Label14.Visible = value
     DBList8.Visible = value
     Label15.Visible = value
  Case 2
     DBList4.Visible = value
     Label6.Visible = value
     DBList3.Visible = value
     Label7.Visible = value
     DBList9.Visible = value
     Label9.Visible = value
     DBList10.Visible = value
     Label10.Visible = value
  Case 3
     DBList4.Visible = value
     Label8.Visible = value
     DBList2.Visible = value
     Label6.Visible = value
     DBList9.Visible = value
     Label9.Visible = value
     DBList10.Visible = value
     Label10.Visible = value
 Case 4
     DBList3.Visible = value
     Label7.Visible = value
     DBList2.Visible = value
     Label6.Visible = value
     DBList9.Visible = value
     Label9.Visible = value
     DBList10.Visible = value
     Label10.Visible = value
   Case 9
     DBList4.Visible = value
     Label8.Visible = value
     DBList2.Visible = value
     Label6.Visible = value
     DBList3.Visible = value
     Label7.Visible = value
     DBList10.Visible = value
     Label10.Visible = value
 Case 10
     DBList4.Visible = value
     Label8.Visible = value
     DBList2.Visible = value
     Label6.Visible = value
     DBList9.Visible = value
     Label9.Visible = value
     DBList3.Visible = value
     Label7.Visible = value
 
  End Select
   
End Function




Private Sub Command1_Click()
 Unload Form2
  m_form_load = 1
End Sub

Private Sub Command19_Click()
On Error Resume Next
Dim wmpos As Double
Dim WmpCurPos As Double
    m_tm = m_tm - Val(m_step.Text)
    WindowsMediaPlayer1.Controls.currentPosition = m_tm
    WindowsMediaPlayer1.Controls.SelectionStart = m_tm
    WindowsMediaPlayer1.Controls.Play
End Sub

Private Sub Command2_Click()
  If typ_list1 = 1 Then
  m_rl_no = Val(Text3.Text)
  If m_rl_no - 1 > 1 Then
    If m_rl_no - 1 < 10 Then
      Text3.Text = "0" + Trim(Str(m_rl_no - 1))
    Else
      Text3.Text = Trim(Str(m_rl_no - 1))
    End If

     NAR1.sql = "EXECUTE NAROWER1_PROC " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
    NAR1.Refresh
    DBList5.Refresh

     rel1.sql = "EXECUTE relative1_PROC " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & _
     "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "2" & "'"
      rel1.Refresh
      DBList6.Refresh
 

fileadd1.sql = "EXECUTE file_add_PROC " & "'" & Text1.Text & "'" & _
 "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "2" & "'" & "," & "'" & Text3.Text & "'" & _
  "," & "'" & "1" & "'"
 fileadd1.Refresh
 DBList7.Refresh

fileadd2.sql = "EXECUTE file_add_PROC " & "'" & Text1.Text & "'" & _
 "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "2" & "'" & "," & "'" & Text3.Text & "'" & _
  "," & "'" & "2" & "'"
 fileadd2.Refresh
 DBList8.Refresh
 m_txt_text = ""
  d_text.sql = "EXECUTE serh_text1 " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
   d_text.Refresh
  If Not d_text.Resultset.EOF And Not d_text.Resultset.BOF Then
   d_text.Resultset.MoveFirst
While Not d_text.Resultset.EOF And Not d_text.Resultset.BOF
   If Not IsNull(d_text.Resultset![txt_text]) Then
     m_txt_text.Text = m_txt_text.Text + d_text.Resultset![txt_text]
    End If
   d_text.Resultset.MoveNext
Wend
Else
m_txt_text = ""

End If
  time.sql = "execute time_proc" & "'" & Text1.Text & "'" & _
  "," & "'" & Text3.Text & "'" & "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
  time.Refresh
  If Not time.Resultset.EOF And Not time.Resultset.BOF Then
    Call disp_time
    Else
     m_mch_o.Text = ""
   m_mch_m.Text = ""
   m_mch_s.Text = ""
   m_mch_o1.Text = ""
    If Not m_mch_o.Text = "" Then
      v_mch_o = m_mch_o.Text
    Else
      v_mch_o = v_mch_o1
   End If
   If Not m_mch_m.Text = "" Then
     v_mch_m = m_mch_m.Text
   Else
      v_mch_m = v_mch_m1
   End If
   If Not m_mch_s.Text = "" Then
     v_mch_s = m_mch_s.Text
    Else
      v_mch_s = v_mch_s1
   End If
   m_mch_m1.Text = ""
   m_mch_s1.Text = ""
  End If
 End If
 Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If

 
End Sub


Private Sub Command20_Click()
 Frame3.Visible = False
  WindowsMediaPlayer1.Controls.Pause
End Sub

Private Sub Command21_Click()
 On Error Resume Next
 If WindowsMediaPlayer1.Controls.currentPosition > m_tm Then
 m_tm = WindowsMediaPlayer1.Controls.currentPosition
End If

    m_tm = m_tm + Val(m_step.Text)
    WindowsMediaPlayer1.Controls.currentPosition = m_tm
     WindowsMediaPlayer1.Controls.Pause
     WindowsMediaPlayer1.Controls.Play
End Sub

 Private Sub Command24_Click()
WindowsMediaPlayer1.Controls.Rate = 2
End Sub

Private Sub Command25_Click()
If is_trans(box_mn_trans) Then
Dim M_O, m_m, m_s As Integer
Dim m_time As Double
m_time = WindowsMediaPlayer1.Controls.currentPosition - 1
M_O = Int(m_time / 3600)
M_REST1 = m_time Mod 3600
m_m = Int(M_REST1 / 60)
m_s = M_REST1 Mod 60
 
 
'If Val(Form2.m_mch_o1.Text) = 0 Then
 Form2.m_mch_o1.Text = M_O
 
'End If
'If Val(Form2.m_mch_m1.Text) = 0 Then
 Form2.m_mch_m1.Text = m_m
 
'End If
'If Val(Form2.m_mch_s1.Text) = 0 Then
 Form2.m_mch_s1.Text = m_s
 
'End If
 Form2.ANALIS.Resultset.Bookmark = Form2.DBList1(0).SelectedItem
     v_desc_no = Form2.ANALIS.Resultset![an_desc_no]
     v_ser_no = Form2.ANALIS.Resultset![an_ser_no]
 
  m_nb = 2
       sql = "execute upd_time1 " & "'" & Form2.Text1.Text & "'" & "," & "'" & Form2.Text3.Text & "'" & "," _
          & "'" & v_ser_no & "'" & "," & "'" & m_s & "'" & "," & "'" & m_m & "'" & "," & "'" & M_O & "'" _
          & "," & "'" & m_nb & "'"
        
                cn.Execute sql, rdExecDirect
 End If

End Sub

Private Sub Command26_Click()
If is_trans(box_mn_trans) Then
Dim M_O, m_m, m_s As Integer
Dim m_time As Double
m_time = WindowsMediaPlayer1.Controls.currentPosition - 1
M_O = Int(m_time / 3600)
M_REST1 = m_time Mod 3600
m_m = Int(M_REST1 / 60)
m_s = M_REST1 Mod 60
 
 
'If Val(Form2.m_mch_o.Text) = 0 Then
 Form2.m_mch_o.Text = M_O
 
'End If
'If Val(Form2.m_mch_m.Text) = 0 Then
 Form2.m_mch_m.Text = m_m
 
'End If
'If Val(Form2.m_mch_s.Text) = 0 Then
 Form2.m_mch_s.Text = m_s
 
'End If

    Form2.time.sql = "execute time_proc" & "'" & Form2.Text1.Text & "'" & _
    "," & "'" & Form2.Text3.Text & "'" & "," & "'" & Form2.ANALIS.Resultset![an_ser_no] & "'"
    Form2.time.Refresh
     Form2.ANALIS.Resultset.Bookmark = Form2.DBList1(0).SelectedItem
     v_desc_no = Form2.ANALIS.Resultset![an_desc_no]
     v_ser_no = Form2.ANALIS.Resultset![an_ser_no]
    If Form2.time.Resultset.EOF And Form2.time.Resultset.BOF Then
    
     
     sql = "execute insr_time1 " & "'" & Form2.Text1.Text & "'" & "," & "'" & Form2.Text3.Text & "'" & "," _
              & "'" & v_ser_no & "'" & "," & "'" & v_desc_no & "'" & "," & "'" & m_s & "'" & "," & "'" & m_m & "'" & "," & "'" & M_O & "'"
              
         
                cn.Execute sql, rdExecDirect
 
     Else
      m_nb = 1
       sql = "execute upd_time1 " & "'" & Form2.Text1.Text & "'" & "," & "'" & Form2.Text3.Text & "'" & "," _
          & "'" & v_ser_no & "'" & "," & "'" & m_s & "'" & "," & "'" & m_m & "'" & "," & "'" & M_O & "'" _
          & "," & "'" & m_nb & "'"
      
                cn.Execute sql, rdExecDirect
  
    End If
End If
End Sub

Private Sub Command27_Click()
WindowsMediaPlayer1.Controls.currentPosition = m_time
WindowsMediaPlayer1.Controls.Pause
End Sub

Private Sub Command28_Click()
WindowsMediaPlayer1.Controls.currentPosition = m_time1
WindowsMediaPlayer1.Controls.Pause
End Sub

Private Sub Command3_Click()
 If typ_list1 = 1 Then
 m_rl_no = Val(Text3.Text)

 If m_rl_no < 9 Then
    Text3.Text = "0" + Trim(Str(m_rl_no + 1))
  Else
    Text3.Text = Trim(Str(m_rl_no + 1))
  End If
     NAR1.sql = "EXECUTE NAROWER1_PROC " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
    NAR1.Refresh
    DBList5.Refresh

     rel1.sql = "EXECUTE relative1_PROC " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & _
     "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "2" & "'"
      rel1.Refresh
      DBList6.Refresh
 

fileadd1.sql = "EXECUTE file_add_PROC " & "'" & Text1.Text & "'" & _
 "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "2" & "'" & "," & "'" & Text3.Text & "'" & _
  "," & "'" & "1" & "'"
 fileadd1.Refresh
 DBList7.Refresh

fileadd2.sql = "EXECUTE file_add_PROC " & "'" & Text1.Text & "'" & _
 "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "2" & "'" & "," & "'" & Text3.Text & "'" & _
  "," & "'" & "2" & "'"
 fileadd2.Refresh
 DBList8.Refresh
 m_txt_text = ""
  d_text.sql = "EXECUTE serh_text1 " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
   d_text.Refresh
  If Not d_text.Resultset.EOF And Not d_text.Resultset.BOF Then
   d_text.Resultset.MoveFirst
While Not d_text.Resultset.EOF And Not d_text.Resultset.BOF
   If Not IsNull(d_text.Resultset![txt_text]) Then
     m_txt_text.Text = m_txt_text.Text + d_text.Resultset![txt_text]
    End If
   d_text.Resultset.MoveNext
Wend
Else
m_txt_text = ""

End If
  time.sql = "execute time_proc" & "'" & Text1.Text & "'" & _
  "," & "'" & Text3.Text & "'" & "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
  time.Refresh
  If Not time.Resultset.EOF And Not time.Resultset.BOF Then
    Call disp_time
    Else
     m_mch_o.Text = ""
   m_mch_m.Text = ""
   m_mch_s.Text = ""
    If Not m_mch_o.Text = "" Then
      v_mch_o = m_mch_o.Text
    Else
      v_mch_o = v_mch_o1
   End If
   If Not m_mch_m.Text = "" Then
     v_mch_m = m_mch_m.Text
   Else
      v_mch_m = v_mch_m1
   End If
   If Not m_mch_s.Text = "" Then
     v_mch_s = m_mch_s.Text
    Else
      v_mch_s = v_mch_s1
   End If
   m_mch_o1.Text = ""
   m_mch_m1.Text = ""
   m_mch_s1.Text = ""
  End If
 Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If

 

  
End Sub

Private Sub Command4_Click()
 m_txt_text.SelStart = 0
  m_txt_text.SelLength = Len(m_txt_text.Text) - 1
  m_txt_text.SelColor = vbTransparent
 HighlightWords m_txt_text, m_word.Text, vbRed
End Sub

Private Sub Command8_Click()
tmp_file.Show

End Sub

Private Sub DBList1_DblClick(Index As Integer)
On Error Resume Next
Dim m_code, M_CODE1 As Variant
DBList1(0).SetFocus
If Not ANALIS.Resultset.BOF Then
   typ_list1 = 1
  ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
  GEO.sql = "execute GEO_PROC " & "'" & _
  ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & Text1.Text & "'"
  GEO.Refresh
   narower.sql = "EXECUTE NAROWER_PROC " & "'" & Text1.Text & "'" & _
   "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
   narower.Refresh
   RELATIVE.sql = "EXECUTE RELATIVE_PROC " & "'" & Text1.Text & "'" & _
    "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "1" & "'"
    RELATIVE.Refresh

    NAR1.sql = "EXECUTE NAROWER1_PROC " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
    NAR1.Refresh
    DBList5.Refresh

     rel1.sql = "EXECUTE relative1_PROC " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & _
     "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "2" & "'"
      rel1.Refresh
      DBList6.Refresh
      fileadd3.sql = "EXECUTE file_add_PROC " & "'" & Text1.Text & "'" & _
      "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "1" & "'" & "," & "'" & "01" & "'" & _
      "," & "'" & "1" & "'"
      fileadd3.Refresh
      DBList9.Refresh

      fileadd4.sql = "EXECUTE file_add_PROC " & "'" & Text1.Text & "'" & _
      "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "1" & "'" & "," & "'" & "01" & "'" & _
  "," & "'" & "2" & "'"
 fileadd4.Refresh
 DBList10.Refresh


fileadd1.sql = "EXECUTE file_add_PROC " & "'" & Text1.Text & "'" & _
 "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "2" & "'" & "," & "'" & Text3.Text & "'" & _
  "," & "'" & "1" & "'"
 fileadd1.Refresh
 DBList7.Refresh

fileadd2.sql = "EXECUTE file_add_PROC " & "'" & Text1.Text & "'" & _
 "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "2" & "'" & "," & "'" & Text3.Text & "'" & _
  "," & "'" & "2" & "'"
 fileadd2.Refresh
 DBList8.Refresh
 m_txt_text = ""
 d_text.sql = "EXECUTE serh_text1 " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
   d_text.Refresh
  If Not d_text.Resultset.EOF And Not d_text.Resultset.BOF Then
   d_text.Resultset.MoveFirst
While Not d_text.Resultset.EOF And Not d_text.Resultset.BOF
   If Not IsNull(d_text.Resultset![txt_text]) Then
     m_txt_text.Text = m_txt_text.Text + d_text.Resultset![txt_text]
    End If
   d_text.Resultset.MoveNext
Wend
Else
m_txt_text = ""
End If
  time.sql = "execute time_proc" & "'" & Text1.Text & "'" & _
  "," & "'" & Text3.Text & "'" & "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
   
  time.Refresh
  If Not time.Resultset.EOF And Not time.Resultset.BOF Then
    Call disp_time
    Else
     m_mch_o.Text = ""
   m_mch_m.Text = ""
   m_mch_s.Text = ""
   If Not m_mch_o.Text = "" Then
      v_mch_o = m_mch_o.Text
    Else
      v_mch_o = v_mch_o1
   End If
   If Not m_mch_m.Text = "" Then
     v_mch_m = m_mch_m.Text
   Else
      v_mch_m = v_mch_m1
   End If
   If Not m_mch_s.Text = "" Then
     v_mch_s = m_mch_s.Text
    Else
      v_mch_s = v_mch_s1
   End If
   m_mch_o1.Text = ""
   m_mch_m1.Text = ""
   m_mch_s1.Text = ""
  End If
  Form2.dte_subject.sql = "execute dte_subject_proc" & "'" & Form2.Text1.Text & "'" & _
    "," & "'" & Form2.Text3.Text & "'" & "," & "'" & Form2.ANALIS.Resultset![an_ser_no] & "'"
    Form2.dte_subject.Refresh
    If Not dte_subject.Resultset.EOF And Not dte_subject.Resultset.BOF Then
     If Not IsNull(dte_subject.Resultset![dte_dte_deb]) Then
        m_dte_deb.Text = Format(dte_subject.Resultset![dte_dte_deb], "dd/mm/yyyy")
     Else
      m_dte_deb.Text = "__/__/____"
     End If
      If Not IsNull(dte_subject.Resultset![dte_dte_fin]) Then
        m_dte_fin.Text = Format(dte_subject.Resultset![dte_dte_fin], "dd/mm/yyyy")
     Else
      m_dte_fin.Text = "__/__/____"
     End If
     Else
     m_dte_deb.Text = "__/__/____"
     m_dte_fin.Text = "__/__/____"
    End If
 Else
  MsgBox "ÇäÊÈå áÇ íæÌÏ æÇÕÝÉ áãÔÇåÏÉ ÚáÇÞÇÊåÇ"
  typ_list1 = 0
End If
End Sub





Private Sub DBList1_GotFocus(Index As Integer)
' SendKeys "{up}"
End Sub


Private Sub DBList1_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown Or KeyCode = vbKeyPageDown Or KeyCode = vbKeyEnd Then
  m_bookmark1 = 2
End If
End Sub

Private Sub DBList1_KeyPress(Index As Integer, KeyAscii As Integer)
  If KeyAscii = 13 Then
   Dim m_code, M_CODE1 As Variant
   DBList1(0).SetFocus
If Not ANALIS.Resultset.BOF Then
   typ_list1 = 1
 If m_bookmark1 = 2 Then
      ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
      End If
      
  GEO.sql = "execute GEO_PROC " & "'" & _
  ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & Text1.Text & "'"
  GEO.Refresh
   narower.sql = "EXECUTE NAROWER_PROC " & "'" & Text1.Text & "'" & _
   "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
   narower.Refresh
   RELATIVE.sql = "EXECUTE RELATIVE_PROC " & "'" & Text1.Text & "'" & _
    "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "1" & "'"
    RELATIVE.Refresh

    NAR1.sql = "EXECUTE NAROWER1_PROC " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
    NAR1.Refresh
    DBList5.Refresh

     rel1.sql = "EXECUTE relative1_PROC " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & _
     "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "2" & "'"
      rel1.Refresh
      DBList6.Refresh
      fileadd3.sql = "EXECUTE file_add_PROC " & "'" & Text1.Text & "'" & _
      "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "1" & "'" & "," & "'" & "01" & "'" & _
      "," & "'" & "1" & "'"
      fileadd3.Refresh
      DBList9.Refresh

      fileadd4.sql = "EXECUTE file_add_PROC " & "'" & Text1.Text & "'" & _
      "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "1" & "'" & "," & "'" & "01" & "'" & _
  "," & "'" & "2" & "'"
 fileadd4.Refresh
 DBList10.Refresh


fileadd1.sql = "EXECUTE file_add_PROC " & "'" & Text1.Text & "'" & _
 "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "2" & "'" & "," & "'" & Text3.Text & "'" & _
  "," & "'" & "1" & "'"
 fileadd1.Refresh
 DBList7.Refresh

fileadd2.sql = "EXECUTE file_add_PROC " & "'" & Text1.Text & "'" & _
 "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "2" & "'" & "," & "'" & Text3.Text & "'" & _
  "," & "'" & "2" & "'"
 fileadd2.Refresh
 DBList8.Refresh
 m_txt_text = ""
  d_text.sql = "EXECUTE serh_text1 " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
   d_text.Refresh
  If Not d_text.Resultset.EOF And Not d_text.Resultset.BOF Then
   d_text.Resultset.MoveFirst
While Not d_text.Resultset.EOF And Not d_text.Resultset.BOF
   If Not IsNull(d_text.Resultset![txt_text]) Then
     m_txt_text.Text = m_txt_text.Text + d_text.Resultset![txt_text]
    End If
   d_text.Resultset.MoveNext
Wend
Else
m_txt_text = ""

End If
 time.sql = "execute time_proc" & "'" & Text1.Text & "'" & _
  "," & "'" & Text3.Text & "'" & "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
  time.Refresh
  If Not time.Resultset.EOF And Not time.Resultset.BOF Then
    Call disp_time
    Else
     m_mch_o.Text = ""
   m_mch_m.Text = ""
   m_mch_s.Text = ""
   If Not m_mch_o.Text = "" Then
      v_mch_o = m_mch_o.Text
    Else
      v_mch_o = v_mch_o1
   End If
   If Not m_mch_m.Text = "" Then
     v_mch_m = m_mch_m.Text
   Else
      v_mch_m = v_mch_m1
   End If
   If Not m_mch_s.Text = "" Then
     v_mch_s = m_mch_s.Text
    Else
      v_mch_s = v_mch_s1
   End If
   m_mch_o1.Text = ""
   m_mch_m1.Text = ""
   m_mch_s1.Text = ""
  End If
   Form2.dte_subject.sql = "execute dte_subject_proc " & "'" & Form2.Text1.Text & "'" & _
    "," & "'" & Form2.Text3.Text & "'" & "," & "'" & Form2.ANALIS.Resultset![an_ser_no] & "'"
    Form2.dte_subject.Refresh
    If Not dte_subject.Resultset.EOF And Not dte_subject.Resultset.BOF Then
     If Not IsNull(dte_subject.Resultset![dte_dte_deb]) Then
        m_dte_deb.Text = Format(dte_subject.Resultset![dte_dte_deb], "dd/mm/yyyy")
     Else
      m_dte_deb.Text = "__/__/____"
     End If
      If Not IsNull(dte_subject.Resultset![dte_dte_fin]) Then
        m_dte_fin.Text = Format(dte_subject.Resultset![dte_dte_fin], "dd/mm/yyyy")
     Else
      m_dte_fin.Text = "__/__/____"
     End If
     Else
     m_dte_deb.Text = "__/__/____"
     m_dte_fin.Text = "__/__/____"
    End If
 Else
  MsgBox "ÇäÊÈå áÇ íæÌÏ æÇÕÝÉ áãÔÇåÏÉ ÚáÇÞÇÊåÇ"
  typ_list1 = 0
End If
      
ElseIf KeyAscii = 32 Or KeyAscii = 77 Then
      DBList11.Visible = True
      DBList11.Refresh
      DBList11.SetFocus
      m_tabindex = DBList1(0).TabIndex
    '  SendKeys "{up}"
      an_typ = 2
   
End If
End Sub

Private Sub DBList1_KeyUp(Index As Integer, KeyCode As Integer, Shift As Integer)
On Error Resume Next
  If KeyCode = vbKeyDelete Then
      If is_trans(box_mn_trans) Then
     Dim v_desc_no As String
'     Dim cn As New rdoConnection
     Dim sql As String
     Dim ok As String
     Const None As String = ""
     
       ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
       
      v_desc_no = ANALIS.Resultset![an_desc_no]
      v_ser_no = ANALIS.Resultset![an_ser_no]
      ok = " "
      ok = InputBox("åá ÊÑíÏ ÇáÛÇÁ ÇáãÞÇáÉ(ä/ß)")
      m_bookmark2 = 1
      If ok = "y" Or ok = "ä" Then
     
          sql = "exec del_analis " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'"
           cn.Execute sql, rdExecDirect
           
           sql = "exec del_geo1 " & "'" & Text1.Text & "'" & "," & "'" & v_ser_no & "'"
           cn.Execute sql, rdExecDirect
            sql = "exec del_rel1 " & "'" & Text1.Text & "'" & "," & "'" & v_ser_no & "'"
           cn.Execute sql, rdExecDirect
            sql = "exec del_nar1 " & "'" & Text1.Text & "'" & "," & "'" & v_ser_no & "'"
           cn.Execute sql, rdExecDirect
            sql = "exec del_fad1 " & "'" & Text1.Text & "'" & "," & "'" & v_ser_no & "'"
           cn.Execute sql, rdExecDirect
            sql = "exec del_time1 " & "'" & Text1.Text & "'" & "," & "'" & v_ser_no & "'"
           cn.Execute sql, rdExecDirect
           ANALIS.Refresh
           DBList1(0).Refresh
          '  SendKeys "{up}"
          End If
       End If
 ElseIf KeyCode = vbKeyInsert Then
       If is_trans(box_mn_trans) Then
       DBList11.Visible = True
       macnz.Refresh
      DBList11.Refresh
      DBList11.SetFocus
      m_tabindex = DBList1(0).TabIndex
    '  searcher.Visible = True
      
'        SendKeys "{up}"
   '  Text4.Visible = True
   '  Text4.Text = ""
   '  Text4.SetFocus
       an_typ = 1
       End If
 End If
End Sub

Private Sub DBList10_GotFocus()
'SendKeys "{up}"
End Sub

Private Sub DBList10_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown Or KeyCode = vbkeypagdown Or KeyCode = vbKeyPageUp Then
  m_bookmark2 = 2
End If

End Sub

Private Sub DBList10_KeyUp(KeyCode As Integer, Shift As Integer)
If typ_list1 = 1 Then
  If KeyCode = vbKeyDelete Then
   If Not fileadd4.Resultset.EOF Or Not fileadd4.Resultset.BOF Then
      If is_trans(box_mn_trans) Then
'       Dim cn As New rdoConnection
         Dim sql As String
         Dim ok As String
           
         Const None As String = ""
          If m_bookmark2 = 2 Then
           fileadd4.Resultset.Bookmark = DBList10.SelectedItem
           End If
         v_ser_no = fileadd4.Resultset![fad_ser_no]
         v_fad_no = fileadd4.Resultset![fad_fad_no]
         v_fad_typ = fileadd4.Resultset![fad_fad_t1]
         v_rel = fileadd4.Resultset![fad_rltv_n]
         v_fad_typ1 = fileadd4.Resultset![fad_fad_t2]
          ' MsgBox v_ser_no & "   " & v_nar
         ok = " "
         ok = InputBox("åá ÊÑíÏ ÇáÛÇÁ ÇáãÞÇáÉ(ä/ß)")
      '   If ok = "y" Then
       m_bookmark2 = 1
        If ok = "y" Or ok = "ä" Then
           
          ' cn.Connect = "uid=;pwd=;server=SEQUEL;" _
         '  & "driver={SQL Server};database=macnz;" _
        '   & "DSN='';"
       '     cn.CursorDriver = rdUseOdbc
      '      cn.EstablishConnection rdDriverNoPrompt
            sql = "exec del_fad " & "'" & Text1.Text & "'" & "," & "'" & v_ser_no & "'" & "," & "'" & v_fad_no & "'" & "," & _
             "'" & v_fad_typ & "'" & "," & "'" & v_rel & "'" & "," & "'" & v_fad_typ1 & "'"
            cn.Execute sql, rdExecDirect
            file_add.Refresh
            fileadd4.Refresh
            DBList10.Refresh
          '   SendKeys "{up}"
       End If
       End If
       End If
       End If
If KeyCode = vbKeyPageUp Then
   DBList10.Height = 4000
   DBList10.Top = 2640
   Call visibl_list(10, False)
ElseIf KeyCode = vbKeyPageDown Then
   DBList10.Height = 540
   DBList10.Top = 6000
    Call visibl_list(10, True)
 End If

    Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If
End Sub

Private Sub DBList11_dblClick()
 If is_trans(box_mn_trans) Then
 Dim v_an_ser_no As String
 Dim v_desc_no As String
' Dim cn As New rdoConnection
 Dim sql As String
 If Not macnz.Resultset.EOF Or Not macnz.Resultset.BOF Then
  If m_bookmark = 2 Then
  macnz.Resultset.Bookmark = DBList11.SelectedItem
End If
  If Val(macnz.Resultset![sub_level]) > 2 Then
Select Case m_tabindex
Case 5
If an_typ = 1 Then

    If Not ANALIS.Resultset.EOF Then
      ANALIS.Resultset.MoveLast
     v_an_ser_no = ANALIS.Resultset![an_ser_no]
    Else
       v_an_ser_no = "0"
    End If

  macnz.Resultset.Bookmark = DBList11.SelectedItem
  If Val(v_an_ser_no) < 9 Then
    v_ser_no = "0" & LTrim((Str(Val(v_an_ser_no) + 1)))
  Else
  v_ser_no = Trim((Str(Val(v_an_ser_no) + 1)))
  End If
   v_desc_no = macnz.Resultset![sub_code]
     sql = "execute insr_analis " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'"
         
                cn.Execute sql, rdExecDirect
   ANALIS.Refresh
   DBList11.Visible = False
   DBList1(0).SetFocus
  ElseIf an_typ = 2 Then
    If Not ANALIS.Resultset.EOF Then
       ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
       v_an_ser_no = ANALIS.Resultset![an_ser_no]
       macnz.Resultset.Bookmark = DBList11.SelectedItem
       v_desc_no = macnz.Resultset![sub_code]
       sql = "execute upd_analis " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'"
         
                cn.Execute sql, rdExecDirect

   ANALIS.Refresh
   DBList11.Visible = False
   DBList1(0).SetFocus
  End If
  End If
  Case 8
  ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
  v_desc_no = ANALIS.Resultset![an_desc_no]
  v_ser_no = ANALIS.Resultset![an_ser_no]
  v_rel = "01"
   v_nar_typ = "1"
  macnz.Resultset.Bookmark = DBList11.SelectedItem
     sql = "execute insr_narower " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," & "'" & macnz.Resultset![sub_code] & "'" & "," _
      & "'" & v_nar_typ & "'" & "," & "'" & v_rel_no & "'"
      
          ' cn.Connect = "uid=;pwd=;server=SEQUEL;" _
         '  & "driver={SQL Server};database=macnz;" _
        '   & "DSN='';"
       '     cn.CursorDriver = rdUseOdbc
     '      cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
  
  narower.Refresh
  DBList11.Visible = False
  DBList3.SetFocus
 
 Case 7
   ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
  v_desc_no = ANALIS.Resultset![an_desc_no]
  v_ser_no = ANALIS.Resultset![an_ser_no]
   v_rel_no = "01"
   v_rel_typ = "1"
   macnz.Resultset.Bookmark = DBList11.SelectedItem
     sql = "execute insr_relative " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," & "'" & macnz.Resultset![sub_code] & "'" & "," _
      & "'" & v_rel_typ & "'" & "," & "'" & v_rel_no & "'"
      
        '   cn.Connect = "uid=;pwd=;server=SEQUEL;" _
       '    & "driver={SQL Server};database=macnz;" _
      '     & "DSN='';"
      '      cn.CursorDriver = rdUseOdbc
     '      cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
  

  RELATIVE.Refresh
  DBList11.Visible = False
  DBList4.SetFocus

 Case 13
   ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
  v_desc_no = ANALIS.Resultset![an_desc_no]
  v_ser_no = ANALIS.Resultset![an_ser_no]
  v_rel = Text3.Text
   v_nar_typ = "2"
  macnz.Resultset.Bookmark = DBList11.SelectedItem
     sql = "execute insr_narower " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," & "'" & macnz.Resultset![sub_code] & "'" & "," _
      & "'" & v_nar_typ & "'" & "," & "'" & v_rel_no & "'"
      
         '  cn.Connect = "uid=;pwd=;server=SEQUEL;" _
        '   & "driver={SQL Server};database=macnz;" _
       '    & "DSN='';"
      '      cn.CursorDriver = rdUseOdbc
     '      cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
  
  NAR1.Refresh
  DBList11.Visible = False
  DBList6.SetFocus
 Case 12
  ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
  v_desc_no = ANALIS.Resultset![an_desc_no]
  v_ser_no = ANALIS.Resultset![an_ser_no]
   v_rel_no = Text3.Text
   v_rel_typ = "2"
   macnz.Resultset.Bookmark = DBList11.SelectedItem
     sql = "execute insr_relative " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," & "'" & macnz.Resultset![sub_code] & "'" & "," _
      & "'" & v_rel_typ & "'" & "," & "'" & v_rel_no & "'"
      
         '  cn.Connect = "uid=;pwd=;server=SEQUEL;" _
        '   & "driver={SQL Server};database=macnz;" _
        ''   & "DSN='';"
        '    cn.CursorDriver = rdUseOdbc
        '   cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
  rel1.Refresh
  DBList11.Visible = False
  DBList5.SetFocus
End Select
Text4.Visible = False
  Else
   MsgBox "ÇäÊÈå áÇ ÊÓÊØíÚ ÇáÇÏÎÇá ÇáÇ ÇáæÇÕÝÇÊ ....!"
 End If
Else
   MsgBox "ÇäÊÈå ÇááÇÆÍÉ ÝÇÑÛÉ áÇÊÓÊØíÚ ÇáÇÏÎÇá....!"
 End If
End If
End Sub

Private Sub DBList11_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF8 Then
  m_typ_serh = 1
  Text4.Visible = True
   Label16.Visible = True
   Text4.SetFocus
   Text4.Text = ""
'  SendKeys "{up}"
ElseIf KeyCode = vbKeyF9 Then
  m_typ_serh = 2
  Text4.Visible = True
   Label16.Visible = True
   Text4.SetFocus
   Text4.Text = ""
'   SendKeys "{up}"
ElseIf KeyCode = vbKeyDown Or KeyCode = vbKeyPageDown Or KeyCode = vbKeyEnd Then
   m_bookmark = 2
 End If
 
End Sub

Private Sub DBList11_KeyPress(KeyAscii As Integer)
 
 If KeyAscii = 27 Then
   DBList11.Visible = False
   Select Case m_tabindex
     Case 5
      DBList1(0).SetFocus
    Case 7
     DBList4.SetFocus
    Case 8
      DBList3.SetFocus
     Case 12
       DBList6.SetFocus
     Case 13
       DBList5.SetFocus
      
   End Select
   'searcher.Text = ""
    '      searcher.Visible = False
ElseIf KeyAscii = 13 Then
  If is_trans(box_mn_trans) Then
'searcher.Text = ""
'   searcher.Visible = False
 Dim v_an_ser_no As String
 Dim v_desc_no As String
'  Dim cn As New rdoConnection
 Dim sql As String
If Not macnz.Resultset.EOF Or Not macnz.Resultset.BOF Then
 If m_bookmark1 = 2 Then
           ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
  End If
  If m_bookmark = 2 Then
  macnz.Resultset.Bookmark = DBList11.SelectedItem
End If
   If Val(macnz.Resultset![sub_level]) > 2 Then
Select Case m_tabindex
 
Case 5
If an_typ = 1 Then
    If Not ANALIS.Resultset.EOF Then
      ANALIS.Resultset.MoveLast
     v_an_ser_no = ANALIS.Resultset![an_ser_no]
    Else
       v_an_ser_no = "0"
    End If
If m_bookmark = 2 Then
  macnz.Resultset.Bookmark = DBList11.SelectedItem
End If
  If Val(v_an_ser_no) < 9 Then
    v_ser_no = "0" & LTrim((Str(Val(v_an_ser_no) + 1)))
  Else
  v_ser_no = Trim((Str(Val(v_an_ser_no) + 1)))
  End If
   v_desc_no = macnz.Resultset![sub_code]
     sql = "execute insr_analis " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'"
                cn.Execute sql, rdExecDirect

   ANALIS.Refresh
   DBList11.Visible = False
   DBList1(0).SetFocus
  ElseIf an_typ = 2 Then
    If Not ANALIS.Resultset.EOF Then
       v_ser_no = ANALIS.Resultset![an_ser_no]
       If m_bookmark = 2 Then
       macnz.Resultset.Bookmark = DBList11.SelectedItem
       End If
       v_desc_no = macnz.Resultset![sub_code]
       sql = "execute upd_analis " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'"
                cn.Execute sql, rdExecDirect

   ANALIS.Refresh
   DBList11.Visible = False
   DBList1(0).SetFocus
   End If
  End If
 Case 8
  v_desc_no = ANALIS.Resultset![an_desc_no]
  v_ser_no = ANALIS.Resultset![an_ser_no]
  v_rel_no = "01"
   v_nar_typ = "1"
   If m_bookmark = 2 Then
      macnz.Resultset.Bookmark = DBList11.SelectedItem
  End If
     sql = "execute insr_narower " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," & "'" & macnz.Resultset![sub_code] & "'" & "," _
      & "'" & v_nar_typ & "'" & "," & "'" & v_rel_no & "'"
      
                cn.Execute sql, rdExecDirect
  
  narower.Refresh
  DBList11.Visible = False
  DBList3.SetFocus
 
 Case 7
'  ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
  v_desc_no = ANALIS.Resultset![an_desc_no]
  v_ser_no = ANALIS.Resultset![an_ser_no]
   v_rel_no = "01"
   v_rel_typ = "1"
   If m_bookmark = 2 Then
   macnz.Resultset.Bookmark = DBList11.SelectedItem
   End If
    m_bookmark = 1
     sql = "execute insr_relative " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," & "'" & macnz.Resultset![sub_code] & "'" & "," _
      & "'" & v_rel_typ & "'" & "," & "'" & v_rel_no & "'"
      
                cn.Execute sql, rdExecDirect
  
  RELATIVE.Refresh
  DBList11.Visible = False
  DBList4.SetFocus

 Case 13
'  ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
  v_desc_no = ANALIS.Resultset![an_desc_no]
  v_ser_no = ANALIS.Resultset![an_ser_no]
  v_rel = Text3.Text
   v_nar_typ = "2"
   If m_bookmark = 2 Then
  macnz.Resultset.Bookmark = DBList11.SelectedItem
  End If
     sql = "execute insr_narower " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," & "'" & macnz.Resultset![sub_code] & "'" & "," _
      & "'" & v_nar_typ & "'" & "," & "'" & v_rel & "'"
      
                cn.Execute sql, rdExecDirect
  
  NAR1.Refresh
  DBList11.Visible = False
  DBList5.SetFocus

 Case 12
' ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
  v_desc_no = ANALIS.Resultset![an_desc_no]
  v_ser_no = ANALIS.Resultset![an_ser_no]
   v_rel_no = Text3.Text
   v_rel_typ = "2"
   If m_bookmark = 2 Then
   macnz.Resultset.Bookmark = DBList11.SelectedItem
   End If
     sql = "execute insr_relative " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," & "'" & macnz.Resultset![sub_code] & "'" & "," _
      & "'" & v_rel_typ & "'" & "," & "'" & v_rel_no & "'"
      
                cn.Execute sql, rdExecDirect
  rel1.Refresh
  DBList11.Visible = False
  DBList6.SetFocus

End Select
m_bookmark = 1
Else
   MsgBox "ÇäÊÈå áÇ ÊÓÊØíÚ ÇáÇÏÎÇá ÇáÇ ÇáæÇÕÝÇÊ ....!"
 End If
Else
   MsgBox "ÇäÊÈå ÇááÇÆÍÉ ÝÇÑÛÉ áÇÊÓÊØíÚ ÇáÇÏÎÇá....!"
 End If
 End If
End If

End Sub


Private Sub DBList12_KeyDown(KeyCode As Integer, Shift As Integer)
  
  If KeyCode = vbKeyF8 Then
      m_typ_serh = 1
     Text4.Visible = True
      Label6.Visible = True
      Text4.SetFocus
      Text4.Text = ""
  '     SendKeys "{up}"
      ElseIf KeyCode = vbKeyF2 Then
          Dim m_code As Variant
          If m_bookmark = 2 Then
           view_form.Resultset.Bookmark = DBList12.SelectedItem
         End If
          m_code = view_form.Resultset![sub_cod]
          v_sub_no = m_code
          position.sql = " execute proc_pos " & "'" & m_code & "'"
          position.Refresh
  '         SendKeys "{up}"
           m_bookmark = 1
           DBList13.Visible = True
             Label17.Visible = True
             DBList13.SetFocus
ElseIf KeyCode = vbKeyF9 Then
      m_typ_serh = 2
     Text4.Visible = True
      Label6.Visible = True
      Text4.SetFocus
      Text4.Text = ""
  '       SendKeys "{up}"
ElseIf KeyCode = vbKeyDown Or KeyCode = vbKeyPageDown Or KeyCode = vbKeyEnd Then
   m_bookmark = 2
  End If
End Sub

Private Sub DBList12_KeyPress(KeyAscii As Integer)
' Dim cn As New rdoConnection
 Dim sql As String
  
  Select Case KeyAscii
       Case 27
         DBList12.Visible = False
          Select Case m_tabindex
                 Case 6
                    DBList2.SetFocus
                 Case 9
                    DBList9.SetFocus
                 Case 10
                    DBList10.SetFocus
                  Case 14
                    DBList7.SetFocus
                  Case 15
                     DBList8.SetFocus
               End Select
              ' searcher.Text = ""
               'searcher.Visible = False
  Case 13
    If is_trans(box_mn_trans) Then

'  searcher.Text = ""
 ' searcher.Visible = False
   If Not view_form.Resultset.EOF Or Not view_form.Resultset.BOF Then
     If m_bookmark1 = 2 Then
           ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
         End If
     Select Case m_tabindex
      Case 6

         v_desc_no = ANALIS.Resultset![an_desc_no]
         v_ser_no = ANALIS.Resultset![an_ser_no]
          If m_bookmark = 2 Then
            view_form.Resultset.Bookmark = DBList12.SelectedItem
          End If
          m_geo_no = view_form.Resultset![sub_typ] + view_form.Resultset![sub_no]
        sql = "execute insr_geo " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," & "'" & m_geo_no & "'"
'           cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
  
  
  GEO.Refresh
  DBList12.Visible = False
  DBList2.SetFocus
 Case 9
  
 ' ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
  v_desc_no = ANALIS.Resultset![an_desc_no]
  v_ser_no = ANALIS.Resultset![an_ser_no]
  If m_bookmark = 2 Then
    view_form.Resultset.Bookmark = DBList12.SelectedItem
    End If
  
  v_rel_no = "01"
  v_fad_t1 = "1"
   v_fad_t2 = "1"
     sql = "execute insr_file_add " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," & "'" & view_form.Resultset![sub_cod] & "'" & "," _
      & "'" & v_fad_t1 & "'" & "," & "'" & v_rel_no & "'" & "," & "'" & v_fad_t2 & "'"
      
        '   cn.Connect = "uid=;pwd=;server=SEQUEL;" _
        '   & "driver={SQL Server};database=macnz;" _
       '    & "DSN='';"
      '      cn.CursorDriver = rdUseOdbc
      '     cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
  
  
  fileadd3.Refresh
  DBList12.Visible = False
  DBList9.SetFocus
 
 Case 10
 ' ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
  v_desc_no = ANALIS.Resultset![an_desc_no]
  v_ser_no = ANALIS.Resultset![an_ser_no]
If m_bookmark = 2 Then
  view_form.Resultset.Bookmark = DBList12.SelectedItem
End If
  v_rel_no = "01"
  v_fad_t1 = "1"
   v_fad_t2 = "2"
     sql = "execute insr_file_add " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," & "'" & view_form.Resultset![sub_cod] & "'" & "," _
      & "'" & v_fad_t1 & "'" & "," & "'" & v_rel_no & "'" & "," & "'" & v_fad_t2 & "'"
      
         '  cn.Connect = "uid=;pwd=;server=SEQUEL;" _
        '   & "driver={SQL Server};database=macnz;" _
       '    & "DSN='';"
       '     cn.CursorDriver = rdUseOdbc
       '    cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
  fileadd4.Refresh
  DBList12.Visible = False
  DBList10.SetFocus
 Case 14
 ' ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
  v_desc_no = ANALIS.Resultset![an_desc_no]
  v_ser_no = ANALIS.Resultset![an_ser_no]
If m_bookmark = 2 Then
  view_form.Resultset.Bookmark = DBList12.SelectedItem
 End If
  v_rel_no = Text3.Text
  v_fad_t1 = "2"
   v_fad_t2 = "1"
     sql = "execute insr_file_add " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," & "'" & view_form.Resultset![sub_cod] & "'" & "," _
      & "'" & v_fad_t1 & "'" & "," & "'" & v_rel_no & "'" & "," & "'" & v_fad_t2 & "'"
      
'           cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
''           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
  fileadd1.Refresh
  DBList12.Visible = False
  DBList7.SetFocus

 Case 15
 '  ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
  v_desc_no = ANALIS.Resultset![an_desc_no]
  v_ser_no = ANALIS.Resultset![an_ser_no]
 If m_bookmark = 2 Then
  view_form.Resultset.Bookmark = DBList12.SelectedItem
  End If
    v_rel_no = Text3.Text
    v_fad_t1 = "2"
    v_fad_t2 = "2"
     sql = "execute insr_file_add " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," & "'" & view_form.Resultset![sub_cod] & "'" & "," _
      & "'" & v_fad_t1 & "'" & "," & "'" & v_rel_no & "'" & "," & "'" & v_fad_t2 & "'"
      
         '  cn.Connect = "uid=;pwd=;server=SEQUEL;" _
         ''  & "driver={SQL Server};database=macnz;" _
        '   & "DSN='';"
        '    cn.CursorDriver = rdUseOdbc
        '   cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
     fileadd2.Refresh
     DBList12.Visible = False
     DBList8.SetFocus

        End Select
        m_bookmark = 1
  Else
    MsgBox "ÇäÊÈå ÇááÇÆÍÉ ÝÇÑÛÉ áÇÊÓÊØíÚ ÇáÇÏÎÇá....!"
  End If
End If
    Case 102
    Case 200
  End Select
  
End Sub

Private Sub DBList13_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown Or KeyCode = vbKeyPageDown Then
 m_bookmark = 2
End If
End Sub

Private Sub DBList13_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
   DBList13.Visible = False
 Label17.Visible = False
 If DBList12.Visible = True Then
  DBList12.SetFocus
 End If
 End If
End Sub



Private Sub DBList2_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown Or KeyCode = vbkeypagdown Or KeyCode = vbKeyPageUp Then
  m_bookmark2 = 2
End If
End Sub

Private Sub DBList2_KeyPress(KeyAscii As Integer)
  If typ_list1 = 1 Then
   Dim m_row As Variant
   Dim v_ser_no As String
   Dim v_geo As String
   If KeyAscii = 13 Then
    DBList12.Visible = True
      DBList12.Refresh
      view_form.Refresh
      view_form.Resultset.MoveFirst
    '  searcher.Visible = True
    '    searcher.Text = ""
    '  searcher.SetFocus
      
      
      m_tabindex = DBList2.TabIndex
      m_bookmark = 1
       DBList12.SetFocus
        SendKeys "{up}"
   End If
 Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If

End Sub

Private Sub DBList2_KeyUp(KeyCode As Integer, Shift As Integer)
On Error Resume Next
If typ_list1 = 1 Then
 If KeyCode = vbKeyDelete Then
    If is_trans(box_mn_trans) Then
     If Not GEO.Resultset.EOF Or Not GEO.Resultset.BOF Then
'      Dim cn As New rdoConnection
     Dim sql As String
     Dim ok As String
     Const None As String = ""
     If m_bookmark2 = 2 Then
      GEO.Resultset.Bookmark = DBList2.SelectedItem
     End If
     v_ser_no = GEO.Resultset![geo_ser_no]
     v_geo = GEO.Resultset![geo_geo_no]
      'MsgBox v_ser_no & "   " & v_geo
     ok = " "
     ok = InputBox("åá ÊÑíÏ ÇáÛÇÁ ÇáãÞÇáÉ(ä/ß)")
 '  If ok = "y" Then
 m_bookmark2 = 1
   If ok = "y" Or ok = "ä" Then
   '  cn.Connect = "uid=;pwd=;server=SEQUEL;" _
   '  & "driver={SQL Server};database=macnz;" _
  '   & "DSN='';"
  '    cn.CursorDriver = rdUseOdbc
  '    cn.EstablishConnection rdDriverNoPrompt
      sql = "exec del_geo " & "'" & Text1.Text & "'" & "," & "'" & v_ser_no & "'" & "," & "'" & v_geo & "'"
      cn.Execute sql, rdExecDirect
      GEO.Refresh
      geo1.Refresh
      DBList2.Refresh
      'SendKeys "{up}"
      m_bookmark2 = 1
 End If
 End If
 End If
 End If
If KeyCode = vbKeyPageUp Then
   DBList2.Height = 4000
   Call visibl_list(2, False)
   
  ElseIf KeyCode = vbKeyPageDown Then
   DBList2.Height = 540
   Call visibl_list(2, True)
 End If
 Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If

End Sub

Private Sub DBList3_GotFocus()
'SendKeys "{up}"
End Sub

Private Sub DBList3_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown Or KeyCode = vbkeypagdown Or KeyCode = vbKeyPageUp Then
  m_bookmark2 = 2
End If

End Sub

Private Sub DBList3_KeyPress(KeyAscii As Integer)
If typ_list1 = 1 Then
   If KeyAscii = 13 Then
      DBList11.Visible = True
      m_tabindex = DBList3.TabIndex
            DBList11.SetFocus
       DBList11.Refresh
       macnz.Refresh
       
     '  searcher.Visible = True
     '  searcher.Text = ""
     ' searcher.SetFocus
      SendKeys "{up}"
   End If
 Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If

End Sub


Private Sub DBList3_KeyUp(KeyCode As Integer, Shift As Integer)
 If typ_list1 = 1 Then
  If KeyCode = vbKeyDelete Then
   If Not narower.Resultset.EOF Or Not narower.Resultset.BOF Then
     If is_trans(box_mn_trans) Then
'      Dim cn As New rdoConnection
     Dim sql As String
     Dim ok As String
     Const None As String = ""
      If m_bookmark2 = 2 Then
        narower.Resultset.Bookmark = DBList3.SelectedItem
      End If
      v_ser_no = narower.Resultset![nar_ser_no]
      v_nar = narower.Resultset![nar_nar_no]
      v_nar_typ = narower.Resultset![nar_nar_ty]
      v_rel = narower.Resultset![nar_rltv_n]
     ' MsgBox v_ser_no & "   " & v_nar
     ok = " "
     ok = InputBox("åá ÊÑíÏ ÇáÛÇÁ ÇáãÞÇáÉ(ä/ß)")
   'If ok = "y" Then
   m_bookmark2 = 1
   If ok = "y" Or ok = "ä" Then
   '  cn.Connect = "uid=;pwd=;server=SEQUEL;" _
  '   & "driver={SQL Server};database=macnz;" _
  '   & "DSN='';"
 ''     cn.CursorDriver = rdUseOdbc
 '     cn.EstablishConnection rdDriverNoPrompt
      sql = "exec del_nar " & "'" & Text1.Text & "'" & "," & "'" & v_ser_no & "'" & "," & "'" & v_nar & "'" & "," & _
            "'" & v_nar_typ & "'" & "," & "'" & v_rel & "'"
      cn.Execute sql, rdExecDirect
      narower.Refresh
      nar2.Refresh
      DBList3.Refresh
      m_bookmark2 = 1
    End If
    End If
    End If
End If
If KeyCode = vbKeyPageUp Then
   DBList3.Height = 4000
   DBList3.Top = 2640
      Call visibl_list(3, False)
ElseIf KeyCode = vbKeyPageDown Then
   DBList3.Height = 540
   DBList3.Top = 4320
     Call visibl_list(3, True)
   
 End If

Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If

End Sub

Private Sub DBList4_GotFocus()
'SendKeys "{up}"
End Sub

Private Sub DBList4_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown Or KeyCode = vbkeypagdown Or KeyCode = vbKeyPageUp Then
  m_bookmark2 = 2
End If

End Sub

Private Sub DBList4_KeyPress(KeyAscii As Integer)
If typ_list1 = 1 Then
   If KeyAscii = 13 Then
      DBList11.Visible = True
      m_tabindex = DBList4.TabIndex
      macnz.Refresh
        DBList11.SetFocus
      DBList11.Refresh
     ' searcher.Visible = True
     ' searcher.Text = ""
     ' searcher.SetFocus
       SendKeys "{up}"
   End If
    Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If

End Sub

Private Sub DBList4_KeyUp(KeyCode As Integer, Shift As Integer)
If typ_list1 = 1 Then
  If KeyCode = vbKeyDelete Then
   If Not RELATIVE.Resultset.EOF Or Not RELATIVE.Resultset.BOF Then
   If is_trans(box_mn_trans) Then
'         Dim cn As New rdoConnection
         Dim sql As String
         Dim ok As String
         Const None As String = ""
        If m_bookmark2 = 2 Then
          RELATIVE.Resultset.Bookmark = DBList4.SelectedItem
        End If
          v_ser_no = RELATIVE.Resultset![rel_ser_no]
         v_rel_no = RELATIVE.Resultset![rel_rel_no]
         v_rel_typ = RELATIVE.Resultset![rel_rltv_t]
         v_rel = RELATIVE.Resultset![rel_rltv_n]
          ' MsgBox v_ser_no & "   " & v_nar
         ok = " "
         ok = InputBox("åá ÊÑíÏ ÇáÛÇÁ ÇáãÞÇáÉ(ä/ß)")
         'If ok = "y" Then
         m_bookmark2 = 1
       If ok = "y" Or ok = "ä" Then
         '  cn.Connect = "uid=;pwd=;server=SEQUEL;" _
        '   & "driver={SQL Server};database=macnz;" _
        '   & "DSN='';"
       '     cn.CursorDriver = rdUseOdbc
       '     cn.EstablishConnection rdDriverNoPrompt
            sql = "exec del_rel " & "'" & Text1.Text & "'" & "," & "'" & v_ser_no & "'" & "," & "'" & v_rel_no & "'" & "," & _
             "'" & v_rel_typ & "'" & "," & "'" & v_rel & "'"
            cn.Execute sql, rdExecDirect
            RELATIVE.Refresh
            rel2.Refresh
            DBList4.Refresh
           '  SendKeys "{up}"
        End If
        End If
      End If
      End If
If KeyCode = vbKeyPageUp Then
   DBList4.Height = 4000
   DBList4.Top = 2640
 Call visibl_list(4, False)
ElseIf KeyCode = vbKeyPageDown Then
    DBList4.Height = 540
    DBList4.Top = 3480
 Call visibl_list(4, True)
   
 End If

Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If

End Sub


Private Sub DBList5_GotFocus()
'SendKeys "{up}"
End Sub

Private Sub DBList5_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown Or KeyCode = vbkeypagdown Or KeyCode = vbKeyPageUp Then
  m_bookmark2 = 2
End If

End Sub

'Private Sub DBList5_dblClick()
'Dim m_code As String
'ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
'NAR1.SQL = "EXECUTE NAROWER1_PROC " & "'" & text1.text & "'"  & "," & "'" & Text3.Text & "'" & "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
'NAR1.Refresh
'DBList5.Refresh

'End Sub

Private Sub DBList5_KeyPress(KeyAscii As Integer)
If typ_list1 = 1 Then
       If KeyAscii = 13 Then
           DBList11.Visible = True
           m_tabindex = DBList5.TabIndex
           DBList11.Refresh
            macnz.Refresh
      '     searcher.Visible = True
      '     searcher.Text = ""
      '     searcher.SetFocus
            DBList11.SetFocus
        SendKeys "{up}"
        End If
 Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If

End Sub

Private Sub DBList5_KeyUp(KeyCode As Integer, Shift As Integer)
If typ_list1 = 1 Then
  If KeyCode = vbKeyDelete Then
   If Not NAR1.Resultset.EOF Or Not NAR1.Resultset.BOF Then
      If is_trans(box_mn_trans) Then
'         Dim cn As New rdoConnection
         Dim sql As String
         Dim ok As String
         Const None As String = ""
          If m_bookmark2 = 2 Then
            NAR1.Resultset.Bookmark = DBList5.SelectedItem
          End If
          v_ser_no = NAR1.Resultset![nar_ser_no]
         v_nar = NAR1.Resultset![nar_nar_no]
         v_nar_typ = NAR1.Resultset![nar_nar_ty]
         v_rel = NAR1.Resultset![nar_rltv_n]
          ' MsgBox v_ser_no & "   " & v_nar
          m_bookmark2 = 1
         ok = " "
         ok = InputBox("åá ÊÑíÏ ÇáÛÇÁ ÇáãÞÇáÉ(ä/ß)")
         If ok = "y" Or ok = "ä" Then
            
         '  cn.Connect = "uid=;pwd=;server=SEQUEL;" _
         '  & "driver={SQL Server};database=macnz;" _
        '   & "DSN='';"
        '    cn.CursorDriver = rdUseOdbc
        '    cn.EstablishConnection rdDriverNoPrompt
            sql = "exec del_nar " & "'" & Text1.Text & "'" & "," & "'" & v_ser_no & "'" & "," & "'" & v_nar & "'" & "," & _
             "'" & v_nar_typ & "'" & "," & "'" & v_rel & "'"
            cn.Execute sql, rdExecDirect
            NAR1.Refresh
            nar2.Refresh
            DBList5.Refresh
          '  SendKeys "{up}"
    End If
    End If
    End If
End If
If KeyCode = vbKeyPageUp Then
   DBList5.Height = 3500
   DBList5.Top = 2400
   
 Call visibl_list(5, False)
 
ElseIf KeyCode = vbKeyPageDown Then
   DBList5.Height = 540
   DBList5.Top = 3240
   Call visibl_list(5, True)
   
 End If
   

Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If

End Sub

Private Sub DBList6_DblClick()
'ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
'rel1.SQL = "EXECUTE relative1_PROC " & "'" & text1.text & "'"  & "," & "'" & Text3.Text & "'" & _
' "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "2" & "'"
' rel1.Refresh
' DBList6.Refresh
 
End Sub

Private Sub DBList6_GotFocus()
'SendKeys "{up}"
End Sub

Private Sub DBList6_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown Or KeyCode = vbkeypagdown Or KeyCode = vbKeyPageUp Then
  m_bookmark2 = 2
End If

End Sub

Private Sub DBList6_KeyPress(KeyAscii As Integer)
 If typ_list1 = 1 Then
  If KeyAscii = 13 Then
         DBList11.Visible = True
         macnz.Refresh
         
         DBList11.Refresh
          DBList11.SetFocus
   '      searcher.Visible = True
   '   searcher.SetFocus
   '   searcher.Text = ""
         m_tabindex = DBList6.TabIndex
      SendKeys "{up}"
  End If
   Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If

End Sub

Private Sub DBList6_KeyUp(KeyCode As Integer, Shift As Integer)
If typ_list1 = 1 Then
 If KeyCode = vbKeyDelete Then
  If Not rel1.Resultset.EOF Or Not rel1.Resultset.BOF Then
      If is_trans(box_mn_trans) Then
'         Dim cn As New rdoConnection
         Dim sql As String
         Dim ok As String
         Const None As String = ""
          If m_bookmark2 = 2 Then
            rel1.Resultset.Bookmark = DBList6.SelectedItem
          End If
           m_bookmark2 = 1
          v_ser_no = rel1.Resultset![rel_ser_no]
         v_rel_no = rel1.Resultset![rel_rel_no]
         v_rel_typ = rel1.Resultset![rel_rltv_t]
         v_rel = rel1.Resultset![rel_rltv_n]
          ' MsgBox v_ser_no & "   " & v_nar
         ok = " "
         ok = InputBox("åá ÊÑíÏ ÇáÛÇÁ ÇáãÞÇáÉ(ä/ß)")
   '      If ok = "y" Then
         If ok = "y" Or ok = "ä" Then
           
         '  cn.Connect = "uid=;pwd=;server=SEQUEL;" _
         ''  & "driver={SQL Server};database=macnz;" _
         ''  & "DSN='';"
         '   cn.CursorDriver = rdUseOdbc
         '   cn.EstablishConnection rdDriverNoPrompt
            sql = "exec del_rel " & "'" & Text1.Text & "'" & "," & "'" & v_ser_no & "'" & "," & "'" & v_rel_no & "'" & "," & _
             "'" & v_rel_typ & "'" & "," & "'" & v_rel & "'"
            cn.Execute sql, rdExecDirect
            rel1.Refresh
            rel2.Refresh
            DBList6.Refresh
       '     SendKeys "{up}"
       End If
       End If
       End If
  End If
  If KeyCode = vbKeyPageUp Then
   DBList6.Height = 3500
   Call visibl_list(6, False)
   
ElseIf KeyCode = vbKeyPageDown Then
   DBList6.Height = 540
   Call visibl_list(6, True)
 End If

   Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If
End Sub

Private Sub DBList7_DblClick()
'ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
'fileadd1.SQL = "EXECUTE file_add_PROC " & "'" & text1.text & "'"  & _
' "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "2" & "'" & "," & "'" & Text3.Text & "'" & _
'  "," & "'" & "1" & "'"
' fileadd1.Refresh
' DBList7.Refresh
 
End Sub


Private Sub DBList7_GotFocus()
'SendKeys "{up}"
End Sub

Private Sub DBList7_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown Or KeyCode = vbkeypagdown Or KeyCode = vbKeyPageUp Then
  m_bookmark2 = 2
End If

End Sub

Private Sub DBList7_KeyPress(KeyAscii As Integer)
If typ_list1 = 1 Then
  If KeyAscii = 13 Then
         DBList12.Visible = True
     '     searcher.Visible = True
     '     searcher.Text = ""
     ' searcher.SetFocus
           DBList12.SetFocus
          m_tabindex = DBList7.TabIndex
         SendKeys "{up}"
  End If
   Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If

End Sub

Private Sub DBList7_KeyUp(KeyCode As Integer, Shift As Integer)
If typ_list1 = 1 Then
 If KeyCode = vbKeyDelete Then
   If Not fileadd1.Resultset.EOF Or Not fileadd1.Resultset.BOF Then
   If is_trans(box_mn_trans) Then
'    Dim cn As New rdoConnection
         Dim sql As String
         Dim ok As String
         Const None As String = ""
          If m_bookmark2 = 2 Then
         fileadd1.Resultset.Bookmark = DBList7.SelectedItem
         End If
         v_ser_no = fileadd1.Resultset![fad_ser_no]
         v_fad_no = fileadd1.Resultset![fad_fad_no]
         v_fad_typ = fileadd1.Resultset![fad_fad_t1]
         v_rel = fileadd1.Resultset![fad_rltv_n]
         v_fad_typ1 = fileadd1.Resultset![fad_fad_t2]
          ' MsgBox v_ser_no & "   " & v_nar
         ok = " "
         ok = InputBox("åá ÊÑíÏ ÇáÛÇÁ ÇáãÞÇáÉ(ä/ß)")
        ' If ok = "y" Then
         m_bookmark2 = 1
         If ok = "y" Or ok = "ä" Then
        
         '  cn.Connect = "uid=;pwd=;server=SEQUEL;" _
         '  & "driver={SQL Server};database=macnz;" _
        '   & "DSN='';"
        '    cn.CursorDriver = rdUseOdbc
        '    cn.EstablishConnection rdDriverNoPrompt
            sql = "exec del_fad " & "'" & Text1.Text & "'" & "," & "'" & v_ser_no & "'" & "," & "'" & v_fad_no & "'" & "," & _
             "'" & v_fad_typ & "'" & "," & "'" & v_rel & "'" & "," & "'" & v_fad_typ1 & "'"
            cn.Execute sql, rdExecDirect
            file_add.Refresh
            fileadd1.Refresh
            DBList7.Refresh
           ' SendKeys "{up}"
       End If
       End If
       End If
End If
If KeyCode = vbKeyPageUp Then
   DBList7.Height = 3500
   DBList7.Top = 2400
   Call visibl_list(7, False)
ElseIf KeyCode = vbKeyPageDown Then
   DBList7.Height = 780
   DBList7.Top = 4080
   Call visibl_list(7, True)
   
   
 End If

  Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If

End Sub

Private Sub DBList8_GotFocus()
'SendKeys "{up}"
End Sub

Private Sub DBList8_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown Or KeyCode = vbkeypagdown Or KeyCode = vbKeyPageUp Then
  m_bookmark2 = 2
End If

End Sub

Private Sub DBList8_KeyPress(KeyAscii As Integer)
If typ_list1 = 1 Then
  If KeyAscii = 13 Then
         DBList12.Visible = True
       '  searcher.Visible = True
       '  searcher.Text = ""
      'searcher.SetFocus
           DBList12.SetFocus
         m_tabindex = DBList8.TabIndex
          SendKeys "{up}"
  End If
  Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If
 
End Sub


 


Private Sub DBList8_KeyUp(KeyCode As Integer, Shift As Integer)
  If typ_list1 = 1 Then
   If KeyCode = vbKeyDelete Then
    If Not fileadd2.Resultset.EOF Or Not fileadd2.Resultset.BOF Then
     If is_trans(box_mn_trans) Then
'   Dim cn As New rdoConnection
         Dim sql As String
         Dim ok As String
         Const None As String = ""
      If m_bookmark2 = 2 Then
         fileadd2.Resultset.Bookmark = DBList8.SelectedItem
      End If
         v_ser_no = fileadd2.Resultset![fad_ser_no]
         v_fad_no = fileadd2.Resultset![fad_fad_no]
         v_fad_typ = fileadd2.Resultset![fad_fad_t1]
         v_rel = fileadd2.Resultset![fad_rltv_n]
         v_fad_typ1 = fileadd2.Resultset![fad_fad_t2]
          ' MsgBox v_ser_no & "   " & v_nar
         ok = " "
         ok = InputBox("åá ÊÑíÏ ÇáÛÇÁ ÇáãÞÇáÉ(ä/ß)")
          m_bookmark2 = 1
        ' If ok = "y" Then
          If ok = "y" Or ok = "ä" Then
          
         '  cn.Connect = "uid=;pwd=;server=SEQUEL;" _
         '  & "driver={SQL Server};database=macnz;" _
        '   & "DSN='';"
        '    cn.CursorDriver = rdUseOdbc
        '    cn.EstablishConnection rdDriverNoPrompt
            sql = "exec del_fad " & "'" & Text1.Text & "'" & "," & "'" & v_ser_no & "'" & "," & "'" & v_fad_no & "'" & "," & _
             "'" & v_fad_typ & "'" & "," & "'" & v_rel & "'" & "," & "'" & v_fad_typ1 & "'"
            cn.Execute sql, rdExecDirect
            file_add.Refresh
            fileadd2.Refresh
            DBList8.Refresh
          '   SendKeys "{up}"
       End If
       End If
       End If
End If
If KeyCode = vbKeyPageUp Then
   DBList8.Height = 3500
   DBList8.Top = 2400
   Call visibl_list(8, False)
ElseIf KeyCode = vbKeyPageDown Then
   DBList8.Height = 780
   DBList8.Top = 5160
   Call visibl_list(8, True)
   
 End If

Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If
End Sub

Private Sub DBList9_GotFocus()
'SendKeys "{up}"
End Sub

Private Sub DBList9_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown Or KeyCode = vbkeypagdown Or KeyCode = vbKeyPageUp Then
  m_bookmark2 = 2
End If

End Sub

Private Sub DBList9_KeyPress(KeyAscii As Integer)
If typ_list1 = 1 Then
'  Select Case KeyAscii
    If KeyAscii = 13 Then
         DBList12.Visible = True
         DBList12.SetFocus
'         searcher.Visible = True
'         searcher.Text = ""
'      searcher.SetFocus
         m_tabindex = DBList9.TabIndex
       SendKeys "{up}"
End If
 Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If

End Sub
Private Sub DBList10_KeyPress(KeyAscii As Integer)
If typ_list1 = 1 Then
' Select Case KeyAscii
   If KeyAscii = 13 Then
   
         DBList12.Visible = True
       '   searcher.Visible = True
    '  searcher.SetFocus
    '  searcher.Text = ""
         m_tabindex = DBList10.TabIndex
          DBList12.SetFocus
       SendKeys "{up}"
         
   End If
 Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If

End Sub


Private Sub DBList9_KeyUp(KeyCode As Integer, Shift As Integer)
If typ_list1 = 1 Then
 If KeyCode = vbKeyDelete Then
  If Not fileadd3.Resultset.EOF Or Not fileadd3.Resultset.BOF Then
    If is_trans(box_mn_trans) Then
         Dim sql As String
         Dim ok As String
         Const None As String = ""
          If m_bookmark2 = 2 Then
            fileadd3.Resultset.Bookmark = DBList9.SelectedItem
          End If
         v_ser_no = fileadd3.Resultset![fad_ser_no]
         v_fad_no = fileadd3.Resultset![fad_fad_no]
         v_fad_typ = fileadd3.Resultset![fad_fad_t1]
         v_rel = fileadd3.Resultset![fad_rltv_n]
         v_fad_typ1 = fileadd3.Resultset![fad_fad_t2]
         ok = " "
         ok = InputBox("åá ÊÑíÏ ÇáÛÇÁ ÇáãÞÇáÉ(ä/ß)")
      m_bookmark2 = 1
         If ok = "y" Or ok = "ä" Then
            
            sql = "exec del_fad " & "'" & Text1.Text & "'" & "," & "'" & v_ser_no & "'" & "," & "'" & v_fad_no & "'" & "," & _
             "'" & v_fad_typ & "'" & "," & "'" & v_rel & "'" & "," & "'" & v_fad_typ1 & "'"
            cn.Execute sql, rdExecDirect
            file_add.Refresh
            fileadd3.Refresh
            DBList9.Refresh
       End If
      End If
      End If
End If
If KeyCode = vbKeyPageUp Then
     DBList9.Height = 4000
     DBList9.Top = 2640
        Call visibl_list(9, False)
  ElseIf KeyCode = vbKeyPageDown Then
    DBList9.Height = 645
    DBList9.Top = 5040
      Call visibl_list(9, True)
 End If
Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If

End Sub





Private Sub Form_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
   Unload Form2
  End If

End Sub

Private Sub Form_Load()
m_typ_serh = 1
Option1.value = True

is_mode = 1
m_bookmark = 1
m_bookmark1 = 1
m_bookmark2 = 1
If Form6.Visible = True Then
  Text1.Text = Form6.m_mn_app_no.Text
  Text2.Text = Form6.m_mn_act_ttl.Text
   
  m_mn_result.Text = Form6.m_mn_result.Text
'ElseIf Form7.Visible = True Then
'  Text1.Text = FORM1.Text1.Text
'  Text2.Text = FORM1.Text3.Text
ElseIf picture_f.Visible = True Then
  Text1.Text = picture_f.M_pic_no.Text
  Text2.Text = picture_f.m_pic_tit.Text
 End If
 typ_list1 = 0
ANALIS.sql = "execute ass " & "'" & Text1.Text & "'"
ANALIS.Refresh
            
    If is_text = True Then
      tit_istext.Caption = ""
     tit_istext.Caption = "íæÌÏ äÕ"
    Else
     tit_istext.Caption = ""
    tit_istext.Caption = "áÇ íæÌÏ äÕ"
    End If
End Sub

Private Sub m_dte_deb_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 If m_dte_deb.Text = "__/__/____" Then
    m_dte = ""
    Else
     m_dte = m_dte_deb.Text
 End If
 
 If m_dte_fin.Text = "__/__/____" Then
    m_dte1 = ""
    Else
     m_dte1 = m_dte_fin.Text
 End If
    Form2.dte_subject.sql = "execute dte_subject_proc" & "'" & Form2.Text1.Text & "'" & _
    "," & "'" & Form2.Text3.Text & "'" & "," & "'" & Form2.ANALIS.Resultset![an_ser_no] & "'"
    Form2.dte_subject.Refresh
     Form2.ANALIS.Resultset.Bookmark = Form2.DBList1(0).SelectedItem
     v_desc_no = Form2.ANALIS.Resultset![an_desc_no]
     v_ser_no = Form2.ANALIS.Resultset![an_ser_no]
    If Form2.dte_subject.Resultset.EOF And Form2.dte_subject.Resultset.BOF Then
    
     
     sql = "execute insr_dte_subject " & "'" & Form2.Text1.Text & "'" & "," & "'" & Form2.Text3.Text & "'" & "," _
              & "'" & v_ser_no & "'" & "," & "'" & v_desc_no & "'" & "," & "'" & Format(m_dte, "yyyy/mm/dd") & "'" & "," & "'" & Format(m_dte1, "yyyy/mm/dd") & "'"
              
         
                cn.Execute sql, rdExecDirect
 
     Else
      m_nb = 1
       sql = "execute upd_dte_subject " & "'" & Form2.Text1.Text & "'" & "," & "'" & Form2.Text3.Text & "'" & "," _
          & "'" & v_ser_no & "'" & "," & "'" & Format(m_dte, "yyyy/mm/dd") & "'" & "," & "'" & Format(m_dte1, "yyyy/mm/dd") & "'"
          
      
                cn.Execute sql, rdExecDirect
  
    End If
End If
End Sub

Private Sub m_dte_fin_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 If m_dte_deb.Text = "__/__/____" Then
    m_dte = ""
    Else
     m_dte = m_dte_deb.Text
 End If
 
 If m_dte_fin.Text = "__/__/____" Then
    m_dte1 = ""
    Else
     m_dte1 = m_dte_fin.Text
 End If
    Form2.dte_subject.sql = "execute dte_subject_proc" & "'" & Form2.Text1.Text & "'" & _
    "," & "'" & Form2.Text3.Text & "'" & "," & "'" & Form2.ANALIS.Resultset![an_ser_no] & "'"
    Form2.dte_subject.Refresh
     Form2.ANALIS.Resultset.Bookmark = Form2.DBList1(0).SelectedItem
     v_desc_no = Form2.ANALIS.Resultset![an_desc_no]
     v_ser_no = Form2.ANALIS.Resultset![an_ser_no]
    If Form2.dte_subject.Resultset.EOF And Form2.dte_subject.Resultset.BOF Then
    
     
     sql = "execute insr_dte_subject " & "'" & Form2.Text1.Text & "'" & "," & "'" & Form2.Text3.Text & "'" & "," _
              & "'" & v_ser_no & "'" & "," & "'" & v_desc_no & "'" & "," & "'" & Format(m_dte, "yyyy/mm/dd") & "'" & "," & "'" & Format(m_dte1, "yyyy/mm/dd") & "'"
              
         
                cn.Execute sql, rdExecDirect
 
     Else
      m_nb = 1
       sql = "execute upd_dte_subject " & "'" & Form2.Text1.Text & "'" & "," & "'" & Form2.Text3.Text & "'" & "," _
          & "'" & v_ser_no & "'" & "," & "'" & Format(m_dte, "yyyy/mm/dd") & "'" & "," & "'" & Format(m_dte1, "yyyy/mm/dd") & "'"
          
      
                cn.Execute sql, rdExecDirect
  
    End If
End If
End Sub

Private Sub m_mch_m_KeyPress(KeyAscii As Integer)
If typ_list1 = 1 Then
 Dim v_desc_no As String
' Dim cn As New rdoConnection
 Dim sql As String
If KeyAscii = 13 Then
 ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
     v_desc_no = ANALIS.Resultset![an_desc_no]
     v_ser_no = ANALIS.Resultset![an_ser_no]
If m_mch_s.Text = "" Then
    MsgBox "íÌÈ Çä ÊãáÃ ÎÇäÉ ÇáÇæáì.........."
  Else
  m_nb = 2
       sql = "execute upd_time " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & "," _
          & "'" & v_ser_no & "'" & "," & "'" & m_mch_m.Text & "'" _
          & "," & "'" & m_nb & "'"
          '  cn.Connect = "uid=;pwd=;server=SEQUEL;" _
          '  & "driver={SQL Server};database=archive_manar;" _
          ' & "DSN='';"
          '  cn.CursorDriver = rdUseOdbc
          ' cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
  
End If
m_mch_o.SetFocus

End If
 Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If
End Sub

Private Sub m_mch_m1_KeyPress(KeyAscii As Integer)
Dim v_desc_no As String
' Dim cn As New rdoConnection
 Dim sql As String
 If typ_list1 = 1 Then
If KeyAscii = 13 Then
 ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
     v_desc_no = ANALIS.Resultset![an_desc_no]
     v_ser_no = ANALIS.Resultset![an_ser_no]
If m_mch_s.Text = "" Then
    MsgBox "íÌÈ Çä ÊãáÃ ÎÇäÉ ÇáÇæáì.........."
  Else
  m_nb = 5
       sql = "execute upd_time " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & "," _
          & "'" & v_ser_no & "'" & "," & "'" & m_mch_m1.Text & "'" _
          & "," & "'" & m_nb & "'"
                cn.Execute sql, rdExecDirect
  
End If
m_mch_o1.SetFocus

End If
 Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If
End Sub

Private Sub m_mch_o_KeyPress(KeyAscii As Integer)
If typ_list1 = 1 Then
Dim v_desc_no As String
' Dim cn As New rdoConnection
 Dim sql As String
If KeyAscii = 13 Then
 ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
     v_desc_no = ANALIS.Resultset![an_desc_no]
     v_ser_no = ANALIS.Resultset![an_ser_no]
If m_mch_s.Text = "" Then
    MsgBox "íÌÈ Çä ÊãáÃ ÎÇäÉ ÇáÇæáì.........."
  Else
  m_nb = 3
       sql = "execute upd_time " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & "," _
          & "'" & v_ser_no & "'" & "," & "'" & m_mch_o.Text & "'" _
          & "," & "'" & m_nb & "'"
        '    cn.Connect = "uid=;pwd=;server=SEQUEL;" _
        '    & "driver={SQL Server};database=archive_manar;" _
        '   & "DSN='';"
        '    cn.CursorDriver = rdUseOdbc
        '   cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
  
End If
m_mch_s1.SetFocus

End If
 Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If
End Sub

Private Sub m_mch_o1_KeyPress(KeyAscii As Integer)
Dim v_desc_no As String
' Dim cn As New rdoConnection
 Dim sql As String
 If typ_list1 = 1 Then
If KeyAscii = 13 Then
 ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
     v_desc_no = ANALIS.Resultset![an_desc_no]
     v_ser_no = ANALIS.Resultset![an_ser_no]
If m_mch_s.Text = "" Then
    MsgBox "íÌÈ Çä ÊãáÃ ÎÇäÉ ÇáÇæáì.........."
  Else
  m_nb = 6
       sql = "execute upd_time " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & "," _
          & "'" & v_ser_no & "'" & "," & "'" & m_mch_o1.Text & "'" _
          & "," & "'" & m_nb & "'"
        
                cn.Execute sql, rdExecDirect
  
End If

End If
   Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If

End Sub

Private Sub m_mch_s_KeyPress(KeyAscii As Integer)
If typ_list1 = 1 Then
Dim v_an_ser_no As String
 Dim v_desc_no As String
' Dim cn As New rdoConnection
 Dim sql As String
  If KeyAscii = 13 Then
    time.sql = "execute time_proc" & "'" & Text1.Text & "'" & _
    "," & "'" & Text3.Text & "'" & "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
    time.Refresh
     ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
     v_desc_no = ANALIS.Resultset![an_desc_no]
     v_ser_no = ANALIS.Resultset![an_ser_no]
    If time.Resultset.EOF And time.Resultset.BOF Then
    
     
     sql = "execute insr_time " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & "," _
              & "'" & v_ser_no & "'" & "," & "'" & v_desc_no & "'" & "," & "'" & m_mch_s.Text & "'"
              
         
                cn.Execute sql, rdExecDirect
 
     Else
      m_nb = 1
       sql = "execute upd_time " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & "," _
          & "'" & v_ser_no & "'" & "," & "'" & m_mch_s.Text & "'" _
          & "," & "'" & m_nb & "'"
      
                cn.Execute sql, rdExecDirect
  
    End If

     m_mch_m.SetFocus
     
   End If
 Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If
End Sub

Private Sub m_mch_s1_KeyPress(KeyAscii As Integer)
Dim v_desc_no As String
' Dim cn As New rdoConnection
 Dim sql As String
 If typ_list1 = 1 Then
If KeyAscii = 13 Then
 ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
     v_desc_no = ANALIS.Resultset![an_desc_no]
     v_ser_no = ANALIS.Resultset![an_ser_no]
If m_mch_s.Text = "" Then
    MsgBox "íÌÈ Çä ÊãáÃ ÎÇäÉ ÇáÇæáì.........."
  Else
  m_nb = 4
       sql = "execute upd_time " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & "," _
          & "'" & v_ser_no & "'" & "," & "'" & m_mch_s1.Text & "'" _
          & "," & "'" & m_nb & "'"
        '    cn.Connect = "uid=;pwd=;server=SEQUEL;" _
        '    & "driver={SQL Server};database=archive_manar;" _
        '   & "DSN='';"
        '    cn.CursorDriver = rdUseOdbc
        '   cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
  
End If
m_mch_m1.SetFocus

End If
 Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If
End Sub

Private Sub m_mn_result_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
  sql = "execute upd_mn_result " & "'" & Text1.Text & "'" & "," & "'" & m_mn_result.Text & "'"
                cn.Execute sql, rdExecDirect
End If
End Sub

Private Sub m_step_KeyDown(KeyCode As Integer, Shift As Integer)
On Error Resume Next

If KeyCode = 37 Then

Dim wmpos As Double
Dim WmpCurPos As Double
    m_tm = m_tm - 1
    WindowsMediaPlayer1.Controls.currentPosition = m_tm
    'WindowsMediaPlayer1.Controls.SelectionStart = m_tm
    WindowsMediaPlayer1.Controls.Play
ElseIf KeyCode = 39 Then
 'If m_tm + 1 < WindowsMediaPlayer1.Controls.SelectionEnd Then
 If WindowsMediaPlayer1.Controls.currentPosition > m_tm Then
 m_tm = WindowsMediaPlayer1.Controls.currentPosition
End If

    m_tm = m_tm + 1
    WindowsMediaPlayer1.Controls.currentPosition = m_tm
     WindowsMediaPlayer1.Controls.Pause
     WindowsMediaPlayer1.Controls.Play

 ' End If
 ElseIf KeyCode = 32 Then
    WindowsMediaPlayer1.Controls.currentPosition = m_tm
     WindowsMediaPlayer1.Controls.Pause
 End If
End Sub

 





 

Private Sub Command10_Click()
WindowsMediaPlayer1.Controls.Rate = 1
End Sub

 
'DataGrid1.SetFocus

 

Private Sub Command22_Click()

Dim M_O, m_m, m_s As Integer
Dim m_time As Double
m_time = WindowsMediaPlayer1.Controls.currentPosition - 1
M_O = Int(m_time / 3600)
M_REST1 = m_time Mod 3600
m_m = Int(M_REST1 / 60)
m_s = M_REST1 Mod 60
 
 
'If Val(Form2.m_mch_o.Text) = 0 Then
 Form2.m_mch_o.Text = M_O
 
'End If
'If Val(Form2.m_mch_m.Text) = 0 Then
 Form2.m_mch_m.Text = m_m
 
'End If
'If Val(Form2.m_mch_s.Text) = 0 Then
 Form2.m_mch_s.Text = m_s
 
'End If

    Form2.time.sql = "execute time_proc" & "'" & Form2.Text1.Text & "'" & _
    "," & "'" & Form2.Text3.Text & "'" & "," & "'" & Form2.ANALIS.Resultset![an_ser_no] & "'"
    Form2.time.Refresh
     Form2.ANALIS.Resultset.Bookmark = Form2.DBList1(0).SelectedItem
     v_desc_no = Form2.ANALIS.Resultset![an_desc_no]
     v_ser_no = Form2.ANALIS.Resultset![an_ser_no]
    If Form2.time.Resultset.EOF And Form2.time.Resultset.BOF Then
    
     
     sql = "execute insr_time1 " & "'" & Form2.Text1.Text & "'" & "," & "'" & Form2.Text3.Text & "'" & "," _
              & "'" & v_ser_no & "'" & "," & "'" & v_desc_no & "'" & "," & "'" & m_s & "'" & "," & "'" & m_m & "'" & "," & "'" & M_O & "'"
              
         
                cn.Execute sql, rdExecDirect
 
     Else
      m_nb = 1
       sql = "execute upd_time1 " & "'" & Form2.Text1.Text & "'" & "," & "'" & Form2.Text3.Text & "'" & "," _
          & "'" & v_ser_no & "'" & "," & "'" & m_s & "'" & "," & "'" & m_m & "'" & "," & "'" & M_O & "'" _
          & "," & "'" & m_nb & "'"
      
                cn.Execute sql, rdExecDirect
  
    End If

   
End Sub

Private Sub Command23_Click()
Dim M_O, m_m, m_s As Integer
Dim m_time As Double
m_time = WindowsMediaPlayer1.Controls.currentPosition - 1
M_O = Int(m_time / 3600)
M_REST1 = m_time Mod 3600
m_m = Int(M_REST1 / 60)
m_s = M_REST1 Mod 60
 
 
'If Val(Form2.m_mch_o1.Text) = 0 Then
 Form2.m_mch_o1.Text = M_O
 
'End If
'If Val(Form2.m_mch_m1.Text) = 0 Then
 Form2.m_mch_m1.Text = m_m
 
'End If
'If Val(Form2.m_mch_s1.Text) = 0 Then
 Form2.m_mch_s1.Text = m_s
 
'End If
 Form2.ANALIS.Resultset.Bookmark = Form2.DBList1(0).SelectedItem
     v_desc_no = Form2.ANALIS.Resultset![an_desc_no]
     v_ser_no = Form2.ANALIS.Resultset![an_ser_no]
 
  m_nb = 2
       sql = "execute upd_time1 " & "'" & Form2.Text1.Text & "'" & "," & "'" & Form2.Text3.Text & "'" & "," _
          & "'" & v_ser_no & "'" & "," & "'" & m_s & "'" & "," & "'" & m_m & "'" & "," & "'" & M_O & "'" _
          & "," & "'" & m_nb & "'"
        
                cn.Execute sql, rdExecDirect
 End Sub

 
 

Private Sub Command5_Click()
If typ_list1 = 1 Then
Frame1.Visible = True
m_txt_text.SetFocus
Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If
End Sub

 
Private Sub Command6_Click()
 On Error Resume Next
 If WindowsMediaPlayer1.Controls.currentPosition > m_tm Then
 m_tm = WindowsMediaPlayer1.Controls.currentPosition
End If

    m_tm = m_tm + Val(m_step.Text)
    WindowsMediaPlayer1.Controls.currentPosition = m_tm
     WindowsMediaPlayer1.Controls.Pause
     WindowsMediaPlayer1.Controls.Play
 
End Sub

Private Sub Command6_KeyPress(KeyAscii As Integer)
If Val(V_MCH_STOCK) > 12259 And Val(V_MCH_STOCK) < 14000 Then

 If KeyAscii = 108 Then
WindowsMediaPlayer1.Controls.FileName = M_NAM
m_tm = m_tm + m_step.Text
WindowsMediaPlayer1.Controls.Pause

WindowsMediaPlayer1.Controls.SelectionStart = m_tm
WindowsMediaPlayer1.Controls.SelectionEnd = WindowsMediaPlayer1.Controls.duration
WindowsMediaPlayer1.Controls.Play
 
 ElseIf KeyAscii = 106 Then
WindowsMediaPlayer1.Controls.FileName = M_NAM
m_tm = m_tm - m_step.Text
WindowsMediaPlayer1.Controls.Pause

WindowsMediaPlayer1.Controls.SelectionStart = m_tm
WindowsMediaPlayer1.Controls.SelectionEnd = WindowsMediaPlayer1.Controls.duration
WindowsMediaPlayer1.Controls.Play
 
 ElseIf KeyAscii = 107 Then
 WindowsMediaPlayer1.Controls.Pause
 
 End If
 End If
End Sub

Private Sub Command7_Click()
On Error Resume Next
Dim wmpos As Double
Dim WmpCurPos As Double
    m_tm = m_tm - Val(m_step.Text)
    WindowsMediaPlayer1.Controls.currentPosition = m_tm
   ' WindowsMediaPlayer1.Controls.SelectionStart = m_tm
    WindowsMediaPlayer1.Controls.Play

End Sub
 
Private Sub Command7_KeyPress(KeyAscii As Integer)
If Val(V_MCH_STOCK) > 12259 And Val(V_MCH_STOCK) < 14000 Then

 If KeyAscii = 108 Then
WindowsMediaPlayer1.Controls.FileName = M_NAM
m_tm = m_tm + m_step.Text
WindowsMediaPlayer1.Controls.Pause

WindowsMediaPlayer1.Controls.SelectionStart = m_tm
WindowsMediaPlayer1.Controls.SelectionEnd = WindowsMediaPlayer1.Controls.duration
WindowsMediaPlayer1.Controls.Play
 
 ElseIf KeyAscii = 106 Then
 If m_tm - m_step.Text > deb_tm Then
WindowsMediaPlayer1.Controls.FileName = M_NAM
m_tm = m_tm - m_step.Text
WindowsMediaPlayer1.Controls.Pause

WindowsMediaPlayer1.Controls.SelectionStart = m_tm
WindowsMediaPlayer1.Controls.SelectionEnd = WindowsMediaPlayer1.Controls.duration
WindowsMediaPlayer1.Controls.Play
 End If
 ElseIf KeyAscii = 107 Then
 WindowsMediaPlayer1.Controls.Pause
 
 End If
End If
End Sub

Private Sub Command9_Click()
WindowsMediaPlayer1.Controls.Rate = 2
End Sub

Private Sub Form_Activate()
is_mode = 1
On Error Resume Next
Dim m_acrh_no As Integer
 
'm_config_path_new = m_STCOK_path(Str(V_MCH_STOCK))
 m_time = Val(v_mch_s) + Val(v_mch_m) * 60 + Val(v_mch_o) * 3600
 m_time1 = Val(v_mch_s1) + Val(v_mch_m1) * 60 + Val(v_mch_o1) * 3600
' m_config_path_new = m_config_path_new
M_NAM = m_config_path + Trim(V_MCH_STOCK) + "." + v_mch_typ

WindowsMediaPlayer1.URL = M_NAM
WindowsMediaPlayer1.Controls.Pause
WindowsMediaPlayer1.Controls.currentPosition = m_time
'WindowsMediaPlayer1.Controls.SelectionEnd = m_time1
WindowsMediaPlayer1.Controls.Play
WindowsMediaPlayer1.Controls.Pause
m_tm = m_time
m_tm1 = m_time1
deb_tm = m_time
fin_tm = m_time1
m_nam_file.SetFocus

End Sub

 
 
Private Sub m_step_KeyPress(KeyAscii As Integer)
If KeyAscii = 106 Then
 
 On Error Resume Next
Dim wmpos As Double
Dim WmpCurPos As Double
    'acc = acc + 0.04
      m_tm = m_tm - 0.04
    WindowsMediaPlayer1.Controls.currentPosition = m_tm
    WindowsMediaPlayer1.Controls.SelectionStart = m_tm
    WindowsMediaPlayer1.Controls.Pause
    
 ElseIf KeyAscii = 108 Then
 
On Error Resume Next
 If WindowsMediaPlayer1.Controls.currentPosition > m_tm Then
 m_tm = WindowsMediaPlayer1.Controls.currentPosition
End If
    'acc = acc + 0
    m_tm = m_tm + 0.04
    WindowsMediaPlayer1.Controls.currentPosition = m_tm
     WindowsMediaPlayer1.Controls.Pause
 ElseIf KeyAscii = 107 Then
     acc = 0
     WindowsMediaPlayer1.Controls.Pause
 
 End If
End Sub

Private Sub m_txt_text_KeyPress(KeyAscii As Integer)
'On Error Resume Next
If KeyAscii = 27 Then

If Not Text1.Text = "" Then
m_txt_text.Text = filter_desc(m_txt_text.Text)
m_len = Len(LTrim(m_txt_text.Text))
m_len1 = 0
m_nbpage = 0
DBList1(0).SetFocus
'If m_len - 1 > 3900 Then
  ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
   v_desc_no = ANALIS.Resultset![an_desc_no]
   v_ser_no = ANALIS.Resultset![an_ser_no]
   v_rel = Text3.Text
   If Val(v_rel) > 1 Then
      v_txt_typ = "2"
   Else
      v_txt_typ = "1"
   End If
      
   d_text.sql = "EXECUTE serh_text1 " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
                     
   d_text.Refresh
    If Not d_text.Resultset.EOF Or Not d_text.Resultset.EOF Then
     d_text.Resultset.MoveLast
     If Not IsNull(d_text.Resultset![txt_nbpage]) Then
       m_nbpage1 = d_text.Resultset![txt_nbpage]
      Else
      m_nbpage1 = 0
      End If
      Else
      m_nbpage1 = 0
  End If
If Not d_text.Resultset.EOF Or Not d_text.Resultset.BOF Then
  While m_len1 < m_len
  v_text = Mid(LTrim(RTrim(m_txt_text.Text)), m_len1 + 1, 3900)
 '  v_text = filter_desc1(v_text)
 If m_nbpage < m_nbpage1 Then
  m_nbpage = m_nbpage + 1
  v_len = Len(v_text)
  i = 1
  k = 1
     sql = "execute upd_text1 " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," _
      & "'" & v_txt_typ & "'" & "," & "'" & v_rel & "'" & "," & "'" & v_text & "'" _
      & "," & "'" & m_nbpage & "'"
               cn.Execute sql, rdExecDirect

Else
   m_nbpage = m_nbpage + 1
     sql = "execute insr_text1 " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," _
      & "'" & v_txt_typ & "'" & "," & "'" & v_rel & "'" & "," & "'" & v_text & "'" _
      & "," & "'" & m_nbpage & "'"
              cn.Execute sql, rdExecDirect

End If
   m_len1 = m_len1 + 3900
 Wend
 If m_nbpage1 > m_nbpage Then
  While m_nbpage1 > m_nbpage
   m_nbpage = m_nbpage + 1
    sql = "EXECUTE del_text2 " & "'" & Text1.Text & "'" & "," & "'" & v_rel & "'" & "," & "'" & ANALIS.Resultset![an_ser_no] & "'" _
             & "," & "'" & m_nbpage & "'"
             cn.Execute sql, rdExecDirect
      
  Wend
 End If
 
Else
 
 While m_len1 < m_len
      m_nbpage = m_nbpage + 1
  v_text = Mid(LTrim(RTrim(m_txt_text.Text)), m_len1 + 1, 3900)
 ' v_len = Len(v_text)
 'v_text = filter_desc1(v_text)
  i = 1
  k = 1
   L = Len(v1_text)
     sql = "execute insr_text1 " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," _
      & "'" & v_txt_typ & "'" & "," & "'" & v_rel & "'" & "," & "'" & v_text & "'" _
      & "," & "'" & m_nbpage & "'"
              cn.Execute sql, rdExecDirect
     m_len1 = m_len1 + 3900

  Wend
End If
End If
Frame1.Visible = False


 
End If

End Sub

Private Sub Option1_Click()
If Option1.value = True Then
 m_typ_serh = 1
End If
End Sub

Private Sub Option2_Click()
If Option2.value = True Then
 m_typ_serh = 2
End If
End Sub

Private Sub searcher_Change()
   If m_typ_serh = 1 Then
     If DBList12.Visible = True Then
         m_desc = searcher.Text
         m_len = Len(Trim(searcher))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
         DBList12.Refresh
         m_bookmark = 1
       '  SendKeys "{UP}"
       ' DBList12.SelectedItem = DBList12.VisibleItems(1)
        
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "ÇäÊÈå ÇááÇÆÍÉ ÝÇÑÛÉ áÇÊÓÊØíÚ ÇáÇÏÎÇá....!"
         End If
         
        
     ElseIf DBList11.Visible = True Then
       m_desc = searcher.Text
       m_len = Len(Trim(m_desc))
        macnz.sql = "execute serh_macnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        macnz.Refresh
        DBList11.Refresh
        m_bookmark = 1
        m_bookmark1 = 1
       ' SendKeys "{UP}"
          If macnz.Resultset.EOF Or macnz.Resultset.BOF Then
            MsgBox "ÇäÊÈå ÇááÇÆÍÉ ÝÇÑÛÉ áÇÊÓÊØíÚ ÇáÇÏÎÇá....!"
         End If

     End If
 ElseIf m_typ_serh = 2 Then
 m_bookmark = 1
   If DBList12.Visible = True Then
         m_desc = searcher.Text
         m_len = Len(Trim(searcher))
         view_form.sql = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
        DBList12.Refresh
       '  SendKeys "{UP}"
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "ÇäÊÈå ÇááÇÆÍÉ ÝÇÑÛÉ áÇÊÓÊØíÚ ÇáÇÏÎÇá....!"
         End If

     ElseIf DBList11.Visible = True Then
       m_desc = searcher.Text
       m_len = Len(Trim(m_desc))
        macnz.sql = "execute serh_wrdmacnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        macnz.Refresh
        DBList11.Refresh
        m_bookmark1 = 1
       ' SendKeys "{UP}"
         If macnz.Resultset.EOF Or macnz.Resultset.BOF Then
            MsgBox "ÇäÊÈå ÇááÇÆÍÉ ÝÇÑÛÉ áÇÊÓÊØíÚ ÇáÇÏÎÇá....!"
         End If

     End If

 ElseIf KeyAscii = 27 Then
   If DBList12.Visible = True Then
          DBList12.SetFocus
       '    SendKeys "{UP}"
    ElseIf DBList11.Visible = True Then
        DBList11.SetFocus
       '    SendKeys "{UP}"
    End If
      searcher.Visible = False
  End If
 
End Sub

Private Sub searcher_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not searcher.Text = "" Then
    If DBList11.Visible = True Then
      DBList11.SetFocus
     Else
      DBList12.SetFocus
     End If
   SendKeys "{UP}"
End If

End Sub

Private Sub searcher_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
   If m_typ_serh = 1 Then
     If DBList12.Visible = True Then
         m_desc = searcher.Text
         m_len = Len(Trim(searcher))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
         DBList12.Refresh
         DBList12.SetFocus
         m_bookmark = 1
       '  SendKeys "{UP}"
       ' DBList12.SelectedItem = DBList12.VisibleItems(1)
        
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "ÇäÊÈå ÇááÇÆÍÉ ÝÇÑÛÉ áÇÊÓÊØíÚ ÇáÇÏÎÇá....!"
         End If
         
        
     ElseIf DBList11.Visible = True Then
       m_desc = searcher.Text
       m_len = Len(Trim(m_desc))
        macnz.sql = "execute serh_macnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        macnz.Refresh
        DBList11.Refresh
        DBList11.SetFocus
        m_bookmark = 1
        m_bookmark1 = 1
       ' SendKeys "{UP}"
          If macnz.Resultset.EOF Or macnz.Resultset.BOF Then
            MsgBox "ÇäÊÈå ÇááÇÆÍÉ ÝÇÑÛÉ áÇÊÓÊØíÚ ÇáÇÏÎÇá....!"
         End If

     End If
 ElseIf m_typ_serh = 2 Then
 m_bookmark = 1
   If DBList12.Visible = True Then
         m_desc = searcher.Text
         m_len = Len(Trim(searcher))
         view_form.sql = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
        DBList12.Refresh
        DBList12.SetFocus
       '  SendKeys "{UP}"
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "ÇäÊÈå ÇááÇÆÍÉ ÝÇÑÛÉ áÇÊÓÊØíÚ ÇáÇÏÎÇá....!"
         End If

     ElseIf DBList11.Visible = True Then
       m_desc = searcher.Text
       m_len = Len(Trim(m_desc))
        macnz.sql = "execute serh_wrdmacnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        macnz.Refresh
        DBList11.Refresh
        DBList11.SetFocus
        m_bookmark1 = 1
       ' SendKeys "{UP}"
         If macnz.Resultset.EOF Or macnz.Resultset.BOF Then
            MsgBox "ÇäÊÈå ÇááÇÆÍÉ ÝÇÑÛÉ áÇÊÓÊØíÚ ÇáÇÏÎÇá....!"
         End If

     End If

    End If
 ElseIf KeyAscii = 27 Then
   If DBList11.Visible = True Then
   
       DBList11.SetFocus
     Else
       DBList12.SetFocus
     End If
   SendKeys "{UP}"
 End If

End Sub

Private Sub Text1_Change()
ANALIS.sql = "execute ass " & Text1.Text
ANALIS.Refresh
End Sub

Private Sub DBList12_dblClick()
 If is_trans(box_mn_trans) Then
 Dim v_an_ser_no As String
 Dim v_desc_no As String
 'Dim cn As New rdoConnection
 Dim sql As String
 If Not view_form.Resultset.EOF Or Not view_form.Resultset.BOF Then
            
 Select Case m_tabindex

 Case 6
    ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
    v_desc_no = ANALIS.Resultset![an_desc_no]
    v_ser_no = ANALIS.Resultset![an_ser_no]
    view_form.Resultset.Bookmark = DBList12.SelectedItem
 
     sql = "execute insr_geo " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," & "'" & view_form.Resultset![sub_cod] & "'"
                cn.Execute sql, rdExecDirect
  
  
  GEO.Refresh
  DBList12.Visible = False
  DBList2.SetFocus
 Case 9
  ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
  v_desc_no = ANALIS.Resultset![an_desc_no]
  v_ser_no = ANALIS.Resultset![an_ser_no]
  view_form.Resultset.Bookmark = DBList12.SelectedItem
  v_rel_no = "01"
  v_fad_t1 = "1"
   v_fad_t2 = "1"
     sql = "execute insr_file_add " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," & "'" & view_form.Resultset![sub_cod] & "'" & "," _
      & "'" & v_fad_t1 & "'" & "," & "'" & v_rel_no & "'" & "," & "'" & v_fad_t2 & "'"
      
                cn.Execute sql, rdExecDirect
  
  
  fileadd3.Refresh
  DBList12.Visible = False
  DBList4.SetFocus
 
 Case 10
  ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
  v_desc_no = ANALIS.Resultset![an_desc_no]
  v_ser_no = ANALIS.Resultset![an_ser_no]
  view_form.Resultset.Bookmark = DBList12.SelectedItem
  v_rel_no = "01"
  v_fad_t1 = "1"
   v_fad_t2 = "2"
     sql = "execute insr_file_add " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," & "'" & view_form.Resultset![sub_cod] & "'" & "," _
      & "'" & v_fad_t1 & "'" & "," & "'" & v_rel_no & "'" & "," & "'" & v_fad_t2 & "'"
      
                cn.Execute sql, rdExecDirect
  fileadd4.Refresh
  DBList12.Visible = False
  DBList10.SetFocus
 Case 14
  ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
  v_desc_no = ANALIS.Resultset![an_desc_no]
  v_ser_no = ANALIS.Resultset![an_ser_no]
  view_form.Resultset.Bookmark = DBList12.SelectedItem
  v_rel_no = Text3.Text
  v_fad_t1 = "2"
   v_fad_t2 = "1"
     sql = "execute insr_file_add " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," & "'" & view_form.Resultset![sub_cod] & "'" & "," _
      & "'" & v_fad_t1 & "'" & "," & "'" & v_rel_no & "'" & "," & "'" & v_fad_t2 & "'"
      
                cn.Execute sql, rdExecDirect
  fileadd1.Refresh
  DBList12.Visible = False
  DBList7.SetFocus

 Case 15
   ANALIS.Resultset.Bookmark = DBList1(0).SelectedItem
  v_desc_no = ANALIS.Resultset![an_desc_no]
  v_ser_no = ANALIS.Resultset![an_ser_no]
  view_form.Resultset.Bookmark = DBList12.SelectedItem
    v_rel_no = Text3.Text
    v_fad_t1 = "2"
    v_fad_t2 = "2"
     sql = "execute insr_file_add " & "'" & Text1.Text & "'" & "," & "'" & v_desc_no & "'" & "," _
      & "'" & v_ser_no & "'" & "," & "'" & view_form.Resultset![sub_cod] & "'" & "," _
      & "'" & v_fad_t1 & "'" & "," & "'" & v_rel_no & "'" & "," & "'" & v_fad_t2 & "'"
      
                cn.Execute sql, rdExecDirect
     fileadd2.Refresh
     DBList12.Visible = False
     DBList8.SetFocus
    searcher.Visible = False

 End Select
  Else
   MsgBox "ÇäÊÈå ÇááÇÆÍÉ ÝÇÑÛÉ áÇÊÓÊØíÚ ÇáÇÏÎÇá....!"
  End If
  End If
End Sub

 

Private Sub Text3_KeyPress(KeyAscii As Integer)
If typ_list1 = 1 Then
 If KeyAscii = 13 Then
     NAR1.sql = "EXECUTE NAROWER1_PROC " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
    NAR1.Refresh
    DBList5.Refresh

     rel1.sql = "EXECUTE relative1_PROC " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & _
     "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "2" & "'"
      rel1.Refresh
      DBList6.Refresh
 

fileadd1.sql = "EXECUTE file_add_PROC " & "'" & Text1.Text & "'" & _
 "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "2" & "'" & "," & "'" & Text3.Text & "'" & _
  "," & "'" & "1" & "'"
 fileadd1.Refresh
 DBList7.Refresh

fileadd2.sql = "EXECUTE file_add_PROC " & "'" & Text1.Text & "'" & _
 "," & "'" & ANALIS.Resultset![an_ser_no] & "'" & "," & "'" & "2" & "'" & "," & "'" & Text3.Text & "'" & _
  "," & "'" & "2" & "'"
 fileadd2.Refresh
 DBList8.Refresh
 m_txt_text = ""
  d_text.sql = "EXECUTE serh_text1 " & "'" & Text1.Text & "'" & "," & "'" & Text3.Text & "'" & "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
   d_text.Refresh
  If Not d_text.Resultset.EOF And Not d_text.Resultset.BOF Then
   d_text.Resultset.MoveFirst
While Not d_text.Resultset.EOF And Not d_text.Resultset.BOF
   If Not IsNull(d_text.Resultset![txt_text]) Then
     m_txt_text.Text = m_txt_text.Text + d_text.Resultset![txt_text]
    End If
   d_text.Resultset.MoveNext
Wend
Else
m_txt_text = ""

End If
    time.sql = "execute time_proc" & "'" & Text1.Text & "'" & _
  "," & "'" & Text3.Text & "'" & "," & "'" & ANALIS.Resultset![an_ser_no] & "'"
  time.Refresh
  If Not time.Resultset.EOF And Not time.Resultset.BOF Then
    Call disp_time
    Else
     m_mch_o.Text = ""
   m_mch_m.Text = ""
   m_mch_s.Text = ""
   If Not m_mch_o.Text = "" Then
      v_mch_o = m_mch_o.Text
    Else
      v_mch_o = v_mch_o1
   End If
   If Not m_mch_m.Text = "" Then
     v_mch_m = m_mch_m.Text
   Else
      v_mch_m = v_mch_m1
   End If
   If Not m_mch_s.Text = "" Then
     v_mch_s = m_mch_s.Text
    Else
      v_mch_s = v_mch_s1
   End If
   m_mch_o1.Text = ""
   m_mch_m1.Text = ""
   m_mch_s1.Text = ""
  End If
 End If
 Else
  MsgBox "áÇíãßä ÇÏÎá ÇáÚáÇÞÇÊ ÇáÇ ÈÚÏ ÊÍÏíÏ ÇáæÇÕÝÉ!!!!"
End If

End Sub

Private Sub Text4_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
    If m_typ_serh = 1 Then
     If DBList12.Visible = True Then
         m_desc = Text4.Text
         m_len = Len(Trim(Text4))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
         DBList12.Refresh
         DBList12.SetFocus
         m_bookmark = 1
       '  SendKeys "{UP}"
       ' DBList12.SelectedItem = DBList12.VisibleItems(1)
        
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "ÇäÊÈå ÇááÇÆÍÉ ÝÇÑÛÉ áÇÊÓÊØíÚ ÇáÇÏÎÇá....!"
         End If
         
        
     ElseIf DBList11.Visible = True Then
       m_desc = Text4.Text
       m_len = Len(Trim(m_desc))
        macnz.sql = "execute serh_macnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        macnz.Refresh
        DBList11.Refresh
        DBList11.SetFocus
        m_bookmark = 1
        m_bookmark1 = 1
       ' SendKeys "{UP}"
          If macnz.Resultset.EOF Or macnz.Resultset.BOF Then
            MsgBox "ÇäÊÈå ÇááÇÆÍÉ ÝÇÑÛÉ áÇÊÓÊØíÚ ÇáÇÏÎÇá....!"
         End If

     End If
       Text4.Visible = False
      Label16.Visible = False
 ElseIf m_typ_serh = 2 Then
 m_bookmark = 1
   If DBList12.Visible = True Then
         m_desc = Text4.Text
         m_len = Len(Trim(Text4))
         view_form.sql = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
        DBList12.Refresh
        DBList12.SetFocus
       '  SendKeys "{UP}"
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "ÇäÊÈå ÇááÇÆÍÉ ÝÇÑÛÉ áÇÊÓÊØíÚ ÇáÇÏÎÇá....!"
         End If

     ElseIf DBList11.Visible = True Then
       m_desc = Text4.Text
       m_len = Len(Trim(m_desc))
        macnz.sql = "execute serh_wrdmacnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        macnz.Refresh
        DBList11.Refresh
        DBList11.SetFocus
        m_bookmark1 = 1
       ' SendKeys "{UP}"
         If macnz.Resultset.EOF Or macnz.Resultset.BOF Then
            MsgBox "ÇäÊÈå ÇááÇÆÍÉ ÝÇÑÛÉ áÇÊÓÊØíÚ ÇáÇÏÎÇá....!"
         End If

     End If
       Text4.Visible = False
      Label16.Visible = False

    End If
 ElseIf KeyAscii = 27 Then
   If DBList12.Visible = True Then
          DBList12.SetFocus
       '    SendKeys "{UP}"
    ElseIf DBList11.Visible = True Then
        DBList11.SetFocus
       '    SendKeys "{UP}"
    End If
      Text4.Visible = False
      Label16.Visible = False
   
  End If
  
End Sub

Private Function HighlightWords(rtb As RichTextBox, _
                                  sFindString As String, _
                                  lColor As Long) _
                                  As Integer

        Dim lFoundPos As Long           'Position of first character
                                        'of match
        Dim lFindLength As Long         'Length of string to find
        Dim lOriginalSelStart As Long
        Dim lOriginalSelLength As Long
        Dim iMatchCount As Integer      'Number of matches

        'Save the insertion points current location and length
        lOriginalSelStart = rtb.SelStart
        lOriginalSelLength = rtb.SelLength

        'Cache the length of the string to find
        lFindLength = Len(sFindString)

        'Attempt to find the first match
        lFoundPos = rtb.Find(sFindString, 0, , rtfNoHighlight)
        While lFoundPos > 0
          iMatchCount = iMatchCount + 1

          rtb.SelStart = lFoundPos
          'The SelLength property is set to 0 as
          'soon as you change SelStart
          rtb.SelLength = lFindLength
          rtb.SelColor = lColor
          'Attempt to find the next match
          lFoundPos = rtb.Find(sFindString, _
            lFoundPos + lFindLength, , rtfNoHighlight)
        Wend

        'Restore the insertion point to its original
        'location and length
        rtb.SelStart = lOriginalSelStart
        rtb.SelLength = lOriginalSelLength

        'Return the number of matches
        HighlightWords = iMatchCount

      End Function



Private Sub WindowsMediaPlayer1_Click(ByVal nButton As Integer, ByVal nShiftState As Integer, ByVal fX As Long, ByVal fY As Long)
If is_mode = 1 Then
 m_tm = WindowsMediaPlayer1.Controls.currentPosition
    'WindowsMediaPlayer1.Controls.SelectionStart = m_tm
    WindowsMediaPlayer1.Controls.Pause
  is_mode = 2
Else
WindowsMediaPlayer1.Controls.currentPosition = m_tm
    'WindowsMediaPlayer1.Controls.SelectionStart = m_tm
    WindowsMediaPlayer1.Controls.Play
    is_mode = 1
End If
End Sub

Function m_STCOK_path_new(m_stock As String)
    Dim M_NAM    As String
    Dim lg As Boolean
    On Error Resume Next
     lg = True
   ranj.Resultset.MoveFirst
   While Not ranj.Resultset.EOF And lg
        If ranj.Resultset![rjp_typ] = 2 Then
          If Val(m_stock) > ranj.Resultset![rjp_nofrom] And Val(m_stock) < ranj.Resultset![rjp_noto] Then
                   m_STCOK_path_new = Trim(ranj.Resultset![rjp_path])
                     lg = False
          End If
    End If
    ranj.Resultset.MoveNext
   Wend
   
      
  End Function
