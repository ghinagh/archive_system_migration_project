VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{CDE57A40-8B86-11D0-B3C6-00A0C90AEA82}#1.0#0"; "MSDATGRD.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form user_interface 
   BackColor       =   &H00FFFFC0&
   ClientHeight    =   9735
   ClientLeft      =   -165
   ClientTop       =   225
   ClientWidth     =   19755
   LinkTopic       =   "Form1"
   ScaleHeight     =   9735
   ScaleWidth      =   19755
   Begin VB.TextBox m_geo_chrt 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   1680
      TabIndex        =   68
      Top             =   2880
      Width           =   4935
   End
   Begin MSDBCtls.DBList DBList2 
      Bindings        =   "user_inetrface.frx":0000
      Height          =   1230
      Left            =   8520
      TabIndex        =   22
      TabStop         =   0   'False
      Top             =   1800
      Visible         =   0   'False
      Width           =   5055
      _ExtentX        =   8916
      _ExtentY        =   2170
      _Version        =   393216
      ListField       =   "sub_desc"
      BoundColumn     =   "sub_code"
      RightToLeft     =   -1  'True
   End
   Begin MSDBCtls.DBList DBList1 
      Bindings        =   "user_inetrface.frx":0014
      Height          =   1230
      Left            =   1920
      TabIndex        =   19
      Top             =   3240
      Visible         =   0   'False
      Width           =   4815
      _ExtentX        =   8493
      _ExtentY        =   2170
      _Version        =   393216
      ListField       =   "sub_name"
      BoundColumn     =   "sub_cod"
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox m_geo_text 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   1680
      TabIndex        =   62
      Top             =   2400
      Width           =   4935
   End
   Begin VB.TextBox m_nar_text 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   1680
      TabIndex        =   60
      Top             =   1320
      Width           =   4935
   End
   Begin VB.TextBox m_rel_text 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   1680
      TabIndex        =   58
      Top             =   840
      Width           =   4935
   End
   Begin VB.TextBox m_dig_nochrt 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   15720
      TabIndex        =   47
      Top             =   3840
      Width           =   2175
   End
   Begin VB.TextBox m_txt_text 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   8400
      TabIndex        =   43
      Top             =   3600
      Width           =   3855
   End
   Begin VB.OptionButton Option2 
      BackColor       =   &H00FFFFC0&
      Caption         =   "«·»ÕÀ »ﬂ·„… „⁄Ì‰… "
      Height          =   375
      Left            =   8880
      TabIndex        =   42
      Top             =   840
      Width           =   1215
   End
   Begin VB.OptionButton Option1 
      BackColor       =   &H00FFFFC0&
      Caption         =   "«·»ÕÀ »»œ«Ì… «·«”„ "
      Height          =   495
      Left            =   8880
      TabIndex        =   41
      Top             =   240
      Width           =   1335
   End
   Begin VB.TextBox m_dig_dig_no 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   15720
      TabIndex        =   39
      Top             =   3360
      Width           =   2295
   End
   Begin MSDataListLib.DataCombo m_dig_typ1 
      Bindings        =   "user_inetrface.frx":002C
      Height          =   315
      Left            =   360
      TabIndex        =   38
      Top             =   3360
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   " "
      RightToLeft     =   -1  'True
   End
   Begin MSDataListLib.DataCombo m_res_no 
      Bindings        =   "user_inetrface.frx":0045
      Height          =   315
      Left            =   13920
      TabIndex        =   37
      Top             =   3000
      Width           =   4095
      _ExtentX        =   7223
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "AUT_NAM"
      BoundColumn     =   "AUT_NO"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox m_mn_result 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   8400
      TabIndex        =   28
      Top             =   3240
      Width           =   3855
   End
   Begin VB.CommandButton Command8 
      BackColor       =   &H00C0C000&
      Caption         =   "ÿ»«⁄… «·„·›"
      Height          =   495
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   27
      Top             =   0
      Width           =   1095
   End
   Begin VB.CommandButton Command4 
      BackColor       =   &H00C0C000&
      Caption         =   "»ÕÀ ÃœÌœ"
      Height          =   495
      Left            =   240
      MaskColor       =   &H00FFFFC0&
      Style           =   1  'Graphical
      TabIndex        =   23
      Top             =   600
      UseMaskColor    =   -1  'True
      Width           =   1095
   End
   Begin VB.TextBox m_desc_no 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   1680
      TabIndex        =   21
      Top             =   360
      Width           =   4935
   End
   Begin VB.TextBox m_file_no 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   1680
      TabIndex        =   18
      Top             =   1920
      Width           =   4935
   End
   Begin VB.TextBox m_word 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   13920
      TabIndex        =   16
      Top             =   1320
      Width           =   4095
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H00808000&
      Height          =   4455
      Left            =   6840
      RightToLeft     =   -1  'True
      TabIndex        =   7
      Top             =   4680
      Visible         =   0   'False
      Width           =   6255
      Begin VB.TextBox m_res_subject 
         Alignment       =   1  'Right Justify
         Height          =   285
         Left            =   1800
         TabIndex        =   56
         Top             =   4080
         Width           =   3135
      End
      Begin VB.CheckBox isrec 
         BackColor       =   &H00808000&
         Caption         =   "„⁄  ”ÃÌ· «·ÿ·»"
         Height          =   375
         Left            =   600
         TabIndex        =   55
         Top             =   2640
         Width           =   1455
      End
      Begin VB.TextBox m_res_prs 
         Alignment       =   1  'Right Justify
         Height          =   285
         Left            =   1800
         TabIndex        =   54
         Top             =   3720
         Width           =   3135
      End
      Begin VB.CommandButton Command11 
         BackColor       =   &H00FFFF80&
         Caption         =   "‰”Œ «·ÃœÊ·"
         Height          =   495
         Left            =   3840
         Style           =   1  'Graphical
         TabIndex        =   13
         Top             =   2520
         Width           =   1095
      End
      Begin VB.CommandButton Command10 
         BackColor       =   &H00FFFF80&
         Caption         =   "«·€«¡ «·«„—"
         Height          =   495
         Left            =   2760
         Style           =   1  'Graphical
         TabIndex        =   12
         Top             =   2520
         Width           =   975
      End
      Begin VB.CommandButton Command9 
         BackColor       =   &H00FFFF80&
         Caption         =   "‰”Œ «·«Œ Ì«—"
         Height          =   495
         Left            =   5040
         Style           =   1  'Graphical
         TabIndex        =   11
         Top             =   2520
         Width           =   1095
      End
      Begin VB.FileListBox fillist 
         Height          =   1845
         Left            =   120
         TabIndex        =   10
         Top             =   480
         Width           =   2895
      End
      Begin VB.DirListBox Dirlist 
         Height          =   1440
         Left            =   3120
         TabIndex        =   9
         Top             =   960
         Width           =   3015
      End
      Begin VB.DriveListBox drvlist 
         Height          =   315
         Left            =   3120
         TabIndex        =   8
         Top             =   480
         Width           =   3015
      End
      Begin MSDataListLib.DataCombo m_res_permit 
         Bindings        =   "user_inetrface.frx":005B
         Height          =   315
         Left            =   3120
         TabIndex        =   49
         Top             =   3240
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "sub_desc"
         BoundColumn     =   "sub_code"
         Text            =   ""
         RightToLeft     =   -1  'True
      End
      Begin MSDataListLib.DataCombo m_res_cote 
         Bindings        =   "user_inetrface.frx":0074
         Height          =   315
         Left            =   0
         TabIndex        =   51
         Top             =   3240
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "sub_desc"
         BoundColumn     =   "sub_code"
         Text            =   ""
         RightToLeft     =   -1  'True
      End
      Begin VB.Label Label21 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00808000&
         Caption         =   "«·„Ê÷Ê⁄"
         Height          =   255
         Left            =   4920
         RightToLeft     =   -1  'True
         TabIndex        =   57
         Top             =   4080
         Width           =   1215
      End
      Begin VB.Label Label20 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00808000&
         Caption         =   "«·„” ›Ìœ"
         Height          =   255
         Left            =   4920
         RightToLeft     =   -1  'True
         TabIndex        =   53
         Top             =   3720
         Width           =   1215
      End
      Begin VB.Label Label18 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00808000&
         Caption         =   "«·ÃÂ… «·„” ›Ìœ…"
         Height          =   495
         Left            =   1800
         RightToLeft     =   -1  'True
         TabIndex        =   52
         Top             =   3240
         Width           =   855
      End
      Begin VB.Label Label17 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00808000&
         Caption         =   "«·ÃÂ… «·„Ê«›ﬁ…"
         Height          =   255
         Left            =   4920
         RightToLeft     =   -1  'True
         TabIndex        =   50
         Top             =   3240
         Width           =   1215
      End
      Begin VB.Label Label19 
         Alignment       =   2  'Center
         BackColor       =   &H00808000&
         Caption         =   "          —»ÿ «·„·› «·’Ê Ì   "
         BeginProperty Font 
            Name            =   "Arabic Transparent"
            Size            =   14.25
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   1560
         TabIndex        =   14
         Top             =   0
         Width           =   3495
      End
   End
   Begin VB.CommandButton Command3 
      BackColor       =   &H00C0C000&
      Caption         =   "⁄œœ «·„ﬁ«·« "
      Height          =   495
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   1200
      Width           =   1095
   End
   Begin VB.CommandButton Command2 
      BackColor       =   &H00C0C000&
      Caption         =   "Œ‹‹—ÊÃ"
      Height          =   495
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   2400
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H00C0C000&
      Caption         =   "«·‰ ÌÃ…"
      Height          =   495
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   1800
      Width           =   1095
   End
   Begin MSMask.MaskEdBox M_art_dte1 
      Height          =   375
      Left            =   11040
      TabIndex        =   2
      Top             =   360
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   661
      _Version        =   393216
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
   Begin MSMask.MaskEdBox M_art_dte 
      Height          =   375
      Left            =   16560
      TabIndex        =   3
      Top             =   360
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   661
      _Version        =   393216
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
   Begin MSRDC.MSRDC view_form 
      Height          =   330
      Left            =   2160
      Top             =   9600
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
      Caption         =   "VIEW_FORM"
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
   Begin MSRDC.MSRDC macnz 
      Height          =   330
      Left            =   240
      Top             =   9600
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
   Begin MSRDC.MSRDC coding_typ 
      Height          =   375
      Left            =   4320
      Top             =   9240
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
      RecordSource    =   "select * from VIEW_coding"
      UserName        =   "abbas"
      Password        =   ""
      Connect         =   " "
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
   Begin MSRDC.MSRDC period 
      Height          =   375
      Left            =   7920
      Top             =   8880
      Visible         =   0   'False
      Width           =   1695
      _ExtentX        =   2990
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
      RecordSource    =   "select * from period order by per_per_na"
      UserName        =   "abbas"
      Password        =   ""
      Connect         =   " "
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
   Begin MSRDC.MSRDC AUTHER 
      Height          =   450
      Left            =   8280
      Top             =   8760
      Visible         =   0   'False
      Width           =   1560
      _ExtentX        =   2752
      _ExtentY        =   794
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
      RecordSource    =   "SELECT * FROM AUTHER order by aut_nam"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
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
   Begin MSRDC.MSRDC coding24 
      Height          =   495
      Left            =   8880
      Top             =   8760
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
      RecordSource    =   "select * from view_coding24"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "coding24"
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
   Begin MSMask.MaskEdBox m_ent_dte1 
      Height          =   375
      Left            =   11040
      TabIndex        =   31
      Top             =   840
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   661
      _Version        =   393216
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
   Begin MSMask.MaskEdBox m_ent_dte 
      Height          =   375
      Left            =   16560
      TabIndex        =   32
      Top             =   840
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   661
      _Version        =   393216
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
   Begin MSDataListLib.DataCombo m_art_sub_ty 
      Bindings        =   "user_inetrface.frx":008D
      Height          =   315
      Left            =   13920
      TabIndex        =   35
      Top             =   2040
      Width           =   4215
      _ExtentX        =   7435
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSAdodcLib.Adodc coding_typ1 
      Height          =   330
      Left            =   9960
      Top             =   9240
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
      RecordSource    =   "select * from VIEW_coding"
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
      _Version        =   393216
   End
   Begin MSDataListLib.DataCombo m_art_per_no 
      Bindings        =   "user_inetrface.frx":00A7
      Height          =   315
      Left            =   13920
      TabIndex        =   36
      Top             =   2520
      Width           =   4095
      _ExtentX        =   7223
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "PER_PER_NA"
      BoundColumn     =   "PER_PER_NO"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSAdodcLib.Adodc period1 
      Height          =   330
      Left            =   11040
      Top             =   9960
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
      RecordSource    =   "select * from period order by per_per_na"
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
   Begin MSAdodcLib.Adodc auther1 
      Height          =   330
      Left            =   8280
      Top             =   9240
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
      RecordSource    =   "SELECT * FROM AUTHER order by aut_nam"
      Caption         =   "auther1"
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
   Begin MSAdodcLib.Adodc v_coding24 
      Height          =   330
      Left            =   8760
      Top             =   9480
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
      RecordSource    =   "select * from view_coding24"
      Caption         =   "auther1"
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
   Begin MSDataListLib.DataCombo m_mn_data_en 
      Bindings        =   "user_inetrface.frx":00BD
      Height          =   315
      Left            =   360
      TabIndex        =   45
      Top             =   3840
      Width           =   1935
      _ExtentX        =   3413
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSAdodcLib.Adodc coding3 
      Height          =   450
      Left            =   3720
      Top             =   9360
      Visible         =   0   'False
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   794
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
      RecordSource    =   "select * from  view_coding3"
      Caption         =   "coding3"
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
   Begin MSAdodcLib.Adodc v_coding32 
      Height          =   330
      Left            =   5640
      Top             =   9360
      Visible         =   0   'False
      Width           =   1200
      _ExtentX        =   2117
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
      RecordSource    =   "select * from view_coding32"
      Caption         =   "v_coding32"
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
   Begin MSAdodcLib.Adodc v_coding33 
      Height          =   330
      Left            =   6960
      Top             =   9480
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
      RecordSource    =   "select * from view_coding33"
      Caption         =   "v_coding33"
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
   Begin MSDataGridLib.DataGrid DataGrid1 
      Bindings        =   "user_inetrface.frx":00D3
      Height          =   4815
      Left            =   240
      TabIndex        =   66
      ToolTipText     =   "DBLCLICK ·› Õ «·’Ê—… , F2  ·› Õ «·«” „«—… , F9 ·«Œ Ì«— «·„ﬁ«·… , F3 ·‰”Œ «·„ﬁ«·«  "
      Top             =   4440
      Width           =   19215
      _ExtentX        =   33893
      _ExtentY        =   8493
      _Version        =   393216
      AllowUpdate     =   0   'False
      BackColor       =   16777215
      HeadLines       =   2
      RowHeight       =   17
      RowDividerStyle =   5
      FormatLocked    =   -1  'True
      RightToLeft     =   -1  'True
      BeginProperty HeadFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Caption         =   "ÃœÊ· «” —Ã«⁄ «·„⁄·Ê„« "
      ColumnCount     =   18
      BeginProperty Column00 
         DataField       =   "res_res_no"
         Caption         =   "«·„ƒ·›"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column01 
         DataField       =   "mn_app_no"
         Caption         =   "—ﬁ„ «·«” „«—…"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column02 
         DataField       =   "mn_act_ttl"
         Caption         =   "«·⁄‰Ê«‰ «·›⁄·Ì"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column03 
         DataField       =   "mn_add_ttl"
         Caption         =   "«·⁄‰Ê«‰ «·›—⁄Ì"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column04 
         DataField       =   "dig_typ2"
         Caption         =   "‰Ê⁄ «·ÊÀÌﬁ…"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column05 
         DataField       =   "art_dte"
         Caption         =   " «—ÌŒ «·ÊÀÌﬁ…"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column06 
         DataField       =   "ART_pg_no"
         Caption         =   "ART_pg_no"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column07 
         DataField       =   "art_per_no"
         Caption         =   "ÃÂ… «·’œÊ—"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column08 
         DataField       =   "dig_dig_no"
         Caption         =   "—ﬁ„ «·œÌÃ «·"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column09 
         DataField       =   "dig_typ"
         Caption         =   "dig_typ"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column10 
         DataField       =   "dig_typ1"
         Caption         =   "dig_typ1"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column11 
         DataField       =   "dig_choice"
         Caption         =   "«·«·Œ Ì«—"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column12 
         DataField       =   "dig_s"
         Caption         =   "dig_s"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column13 
         DataField       =   "dig_o"
         Caption         =   "dig_o"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column14 
         DataField       =   "dig_m"
         Caption         =   "dig_m"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column15 
         DataField       =   "dig_s1"
         Caption         =   "dig_s1"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column16 
         DataField       =   "dig_o1"
         Caption         =   "dig_o1"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column17 
         DataField       =   "dig_m1"
         Caption         =   "dig_m1"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      SplitCount      =   1
      BeginProperty Split0 
         MarqueeStyle    =   2
         BeginProperty Column00 
            ColumnWidth     =   1995.024
         EndProperty
         BeginProperty Column01 
            Object.Visible         =   -1  'True
            ColumnWidth     =   1200.189
         EndProperty
         BeginProperty Column02 
            ColumnWidth     =   4004.788
         EndProperty
         BeginProperty Column03 
            ColumnWidth     =   4004.788
         EndProperty
         BeginProperty Column04 
            ColumnWidth     =   1739.906
         EndProperty
         BeginProperty Column05 
            ColumnWidth     =   1739.906
         EndProperty
         BeginProperty Column06 
            Object.Visible         =   0   'False
            ColumnWidth     =   884.976
         EndProperty
         BeginProperty Column07 
            ColumnWidth     =   1500.095
         EndProperty
         BeginProperty Column08 
            ColumnWidth     =   840.189
         EndProperty
         BeginProperty Column09 
            Object.Visible         =   0   'False
            ColumnWidth     =   689.953
         EndProperty
         BeginProperty Column10 
            Object.Visible         =   0   'False
            ColumnWidth     =   615.118
         EndProperty
         BeginProperty Column11 
            ColumnWidth     =   915.024
         EndProperty
         BeginProperty Column12 
            Object.Visible         =   0   'False
            ColumnWidth     =   915.024
         EndProperty
         BeginProperty Column13 
            Object.Visible         =   0   'False
            ColumnWidth     =   915.024
         EndProperty
         BeginProperty Column14 
            Object.Visible         =   0   'False
            ColumnWidth     =   915.024
         EndProperty
         BeginProperty Column15 
            Object.Visible         =   0   'False
            ColumnWidth     =   915.024
         EndProperty
         BeginProperty Column16 
            Object.Visible         =   0   'False
            ColumnWidth     =   915.024
         EndProperty
         BeginProperty Column17 
            Object.Visible         =   0   'False
            ColumnWidth     =   915.024
         EndProperty
      EndProperty
   End
   Begin MSAdodcLib.Adodc result 
      Height          =   330
      Left            =   600
      Top             =   9120
      Visible         =   0   'False
      Width           =   2775
      _ExtentX        =   4895
      _ExtentY        =   582
      ConnectMode     =   0
      CursorLocation  =   3
      IsolationLevel  =   -1
      ConnectionTimeout=   160
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
      RecordSource    =   "  select view_result.* from view_result"
      Caption         =   "Adodc1"
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
   Begin VB.TextBox m_art_pg_no 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   10680
      TabIndex        =   64
      Top             =   3960
      Width           =   1575
   End
   Begin MSDataListLib.DataCombo m_art_lang 
      Bindings        =   "user_inetrface.frx":00E8
      Height          =   315
      Left            =   13920
      TabIndex        =   69
      Top             =   1680
      Width           =   4215
      _ExtentX        =   7435
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSAdodcLib.Adodc coding34 
      Height          =   330
      Left            =   0
      Top             =   9120
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
      RecordSource    =   "select * from coding where substring(sub_code,1,2)='34'"
      Caption         =   "coding34"
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
   Begin VB.Label Label27 
      Alignment       =   2  'Center
      BackColor       =   &H00E8DE8C&
      Caption         =   "«··€…"
      Height          =   255
      Left            =   18240
      TabIndex        =   70
      Top             =   1680
      Width           =   1215
   End
   Begin VB.Label Label26 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "„ﬂ«‰ «· ’ÊÌ—/«·‰‘—"
      Height          =   375
      Left            =   6720
      RightToLeft     =   -1  'True
      TabIndex        =   67
      ToolTipText     =   "«”„«¡ «·‘Œ’Ì«  , Ê«·„ƒ””«  Ê«·ÂÌ∆«  Ê«·«„«ﬂ‰ «·Ã€—«›Ì« Ê«»—“ «·«Õœ«À Ê«·„ ›—ﬁ« "
      Top             =   2880
      Width           =   1455
   End
   Begin VB.Label Label25 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "⁄œœ «·’›Õ« "
      Height          =   255
      Left            =   12120
      RightToLeft     =   -1  'True
      TabIndex        =   65
      Top             =   3960
      Width           =   1455
   End
   Begin VB.Label Label24 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "«·„ﬂ«‰ «·Ã€—«›Ì"
      Height          =   255
      Left            =   6600
      RightToLeft     =   -1  'True
      TabIndex        =   63
      ToolTipText     =   "«”„«¡ «·‘Œ’Ì«  , Ê«·„ƒ””«  Ê«·ÂÌ∆«  Ê«·«„«ﬂ‰ «·Ã€—«›Ì« Ê«»—“ «·«Õœ«À Ê«·„ ›—ﬁ« "
      Top             =   2520
      Width           =   1575
   End
   Begin VB.Label Label23 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "«·«÷Ìﬁ"
      Height          =   375
      Left            =   6720
      RightToLeft     =   -1  'True
      TabIndex        =   61
      Top             =   1320
      Width           =   1455
   End
   Begin VB.Label Label22 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "«·„ —«»ÿ"
      Height          =   375
      Left            =   6720
      RightToLeft     =   -1  'True
      TabIndex        =   59
      Top             =   840
      Width           =   1455
   End
   Begin VB.Label Label16 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "—ﬁ„ «·«—‘Ì› «·ﬁœÌ„"
      Height          =   255
      Left            =   18000
      RightToLeft     =   -1  'True
      TabIndex        =   48
      Top             =   3840
      Width           =   1455
   End
   Begin VB.Label Label15 
      Alignment       =   2  'Center
      BackColor       =   &H00E8DE8C&
      Caption         =   "„œŒ· «·»Ì«‰« "
      Height          =   255
      Left            =   2280
      TabIndex        =   46
      Top             =   3840
      Width           =   1335
   End
   Begin VB.Label Label14 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "ﬂ·„… „‰ «·‰’"
      Height          =   255
      Left            =   12120
      RightToLeft     =   -1  'True
      TabIndex        =   44
      Top             =   3600
      Width           =   1455
   End
   Begin VB.Label Label13 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "—ﬁ„ digital"
      Height          =   255
      Left            =   18120
      RightToLeft     =   -1  'True
      TabIndex        =   40
      Top             =   3360
      Width           =   1455
   End
   Begin VB.Label Label12 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "«·Ï  «—ÌŒ «·«œŒ«·"
      Height          =   375
      Left            =   12360
      TabIndex        =   34
      Top             =   840
      Width           =   1215
   End
   Begin VB.Label Label11 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "„‰  «—ÌŒ «·«œŒ«·"
      Height          =   375
      Left            =   18000
      RightToLeft     =   -1  'True
      TabIndex        =   33
      Top             =   840
      Width           =   1455
   End
   Begin VB.Label Label10 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "‰Ê⁄ «·ÊÀÌﬁ…"
      Height          =   375
      Left            =   2400
      RightToLeft     =   -1  'True
      TabIndex        =   30
      Top             =   3360
      Width           =   855
   End
   Begin VB.Label Label9 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "ﬂ·„… „‰ «·„” Œ·’"
      Height          =   255
      Left            =   12120
      RightToLeft     =   -1  'True
      TabIndex        =   29
      Top             =   3240
      Width           =   1455
   End
   Begin VB.Label Label8 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "«·„”ƒÊ· «·»Ì«‰Ì"
      Height          =   255
      Left            =   18000
      RightToLeft     =   -1  'True
      TabIndex        =   26
      Top             =   3000
      Width           =   1455
   End
   Begin VB.Label Label7 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "ÃÂ… «·’œÊ—"
      Height          =   255
      Left            =   18000
      RightToLeft     =   -1  'True
      TabIndex        =   25
      Top             =   2520
      Width           =   1455
   End
   Begin VB.Label Label6 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "‰Ê⁄ «·ÊÀÌﬁ…"
      Height          =   255
      Left            =   18000
      RightToLeft     =   -1  'True
      TabIndex        =   24
      Top             =   2040
      Width           =   1455
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "«·„Ê÷Ê⁄ :"
      Height          =   375
      Left            =   6720
      RightToLeft     =   -1  'True
      TabIndex        =   20
      Top             =   360
      Width           =   1455
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "«·„·› «·«÷«›Ì"
      Height          =   255
      Left            =   6720
      RightToLeft     =   -1  'True
      TabIndex        =   17
      ToolTipText     =   "«”„«¡ «·‘Œ’Ì«  , Ê«·„ƒ””«  Ê«·ÂÌ∆«  Ê«·«„«ﬂ‰ «·Ã€—«›Ì« Ê«»—“ «·«Õœ«À Ê«·„ ›—ﬁ« "
      Top             =   2040
      Width           =   1455
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "ﬂ·„… „‰ «·⁄‰«ÊÌ‰"
      Height          =   255
      Left            =   18000
      RightToLeft     =   -1  'True
      TabIndex        =   15
      Top             =   1320
      Width           =   1455
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "„‰  «—ÌŒ :"
      Height          =   375
      Left            =   18000
      RightToLeft     =   -1  'True
      TabIndex        =   5
      Top             =   360
      Width           =   1455
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "«·Ï  «—ÌŒ :"
      Height          =   375
      Left            =   12360
      TabIndex        =   4
      Top             =   360
      Width           =   1215
   End
   Begin VB.Shape Shape1 
      Height          =   5175
      Left            =   120
      Top             =   4320
      Width           =   19455
   End
End
Attribute VB_Name = "user_interface"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim CRIT As String
Dim first_qst As Integer
Dim crit1 As String
Dim m_typ_serh As Integer
Dim m_typ_desc, m_typ_file As Integer
Dim qst1, qst2, qst3, qst4, qst5, qst6, qst7, qst8, qst9, qst10, qst11, qst12, qst13, qst14, qst15, qst16, qst17, qst18, qst19, qst20, qst21, qst22 As Integer





Private Sub Command1_Click()
On Error Resume Next
'Dim cn As New rdoConnection

Dim sql As String
Dim qd As rdoQuery
Dim sql_query As String
If qst1 = 0 And Not M_art_dte.Text = "__/__/____" Then
  qst1 = 1
 If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     
     m_dte1 = Format(M_art_dte.Text, "YYYY/MM/DD")
     crit1 = crit1 & "  art_DTE >= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102)"
     M_art_dte.Enabled = False
End If
If qst2 = 0 And Not M_art_dte1.Text = "__/__/____" Then
 qst2 = 1
 If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
    
   m_dte = M_art_dte1.Text
  crit1 = crit1 & "   art_dte <= " & "convert(datetime," & "'" & Format(m_dte, "yyyy-mm-dd") & "'" & "," & "102)"
  M_art_dte1.Enabled = False
End If
If qst11 = 0 And Not m_ent_dte.Text = "__/__/____" Then
  qst11 = 1
 If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     
     m_dte1 = Format(m_ent_dte.Text, "YYYY/MM/DD")
     crit1 = crit1 & "  mn_ent_dte >= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102)"
     M_art_dte.Enabled = False
End If
If qst12 = 0 And Not m_ent_dte1.Text = "__/__/____" Then
 qst12 = 1
 If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
    
   m_dte = m_ent_dte1.Text
  crit1 = crit1 & "   mn_ent_dte <= " & "convert(datetime," & "'" & Format(m_dte, "yyyy-mm-dd") & "'" & "," & "102)"
  m_ent_dte1.Enabled = False
End If
If qst3 = 0 And Not m_word.Text = "" Then
   qst3 = 1
   If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & "mn_act_ttl  + mn_add_ttl  like " & "'" & "%" & m_word.Text & "%" & "'"
      m_word.Enabled = False
End If
If qst9 = 0 And Not m_mn_result.Text = "" Then
  qst9 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & "mn_result  like " & "'" & "%" & m_mn_result.Text & "%" & "'"
      m_mn_result.Enabled = False
      Command1.SetFocus
      
End If
If qst4 = 0 And Not m_art_sub_ty.Text = "" Then
  qst4 = 1
  If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " art_sub_ty = " & "'" & Mid(m_art_sub_ty.BoundText, 3, 2) & "'"
      m_art_sub_ty.Enabled = False
End If
If qst5 = 0 And Not m_art_per_no.Text = "" Then
   qst5 = 1
 If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " art_per_no = " & m_art_per_no.BoundText
      m_art_per_no.Enabled = False
End If
If qst6 = 0 And Not m_res_no.Text = "" Then
  qst6 = 1
  If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " res_res_no = " & m_res_no.BoundText
      m_res_no.Enabled = False
End If
If qst7 = 0 And Not m_desc_no.Text = "" Then
   qst7 = 1
If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       macnz.Resultset.Bookmark = DBList2.SelectedItem
       m_an_no = macnz.Resultset![sub_code]
      crit1 = crit1 & "an_desc_no =  " & "'" & m_an_no & "'"
      CRIT = CRIT & " left join dbo.analis ON dbo.ARTICLE.ART_app_no = dbo.analis.an_app_no "
      m_desc_no.Text = macnz.Resultset![sub_desc]
      DBList2.Visible = False
      m_desc_no.Enabled = False
End If
If qst8 = 0 And Not m_file_no.Text = "" Then
  qst8 = 1
  If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_fad_no = view_form.Resultset![sub_cod]
      crit1 = crit1 & "fad_fad_no =  " & "'" & m_fad_no & "'"
      CRIT = CRIT & " left join dbo.file_add ON dbo.ARTICLE.ART_app_no = dbo.file_add.fad_app_no "
      m_file_no.Text = view_form.Resultset![sub_name]
      DBList1.Visible = False
      m_file_no.Enabled = False
End If
If qst10 = 0 And Not m_dig_typ1.Text = "" Then

qst10 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " dig_Typ1 = " & "'" & Mid(m_dig_typ1.BoundText, 3, 2) & "'"
      m_dig_typ1.Enabled = False
     End If
If qst13 = 0 And Not m_dig_dig_no.Text = "" Then
  qst13 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      ''crit1 = crit1 & "dig_dig_no =  " & "'" & m_dig_dig_no.Text & "'"
       crit1 = crit1 & "dig_dig_no  like " & "'" & "%" & m_dig_dig_no.Text & "%" & "'"
      m_dig_dig_no.Enabled = False
      Command1.SetFocus
      
End If
If qst14 = 0 And Not m_txt_text.Text = "" Then
  qst14 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & "txt_text  like " & "'" & "%" & m_txt_text.Text & "%" & "'"
      CRIT = CRIT & " left join dbo.text1 ON dbo.ARTICLE.ART_app_no = dbo.text1.txt_no "
      m_txt_text.Enabled = False
      Command1.SetFocus
      
End If
If qst15 = 0 And Not m_mn_data_en.Text = "" Then
   qst15 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " mn_data_en = " & "'" & Mid(m_mn_data_en.BoundText, 3, 2) & "'"
       m_mn_data_en.Enabled = False
      Command1.SetFocus
End If
If qst16 = 0 And Not m_dig_nochrt.Text = "" Then
  qst16 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     ' crit1 = crit1 & "dig_dig_no =  " & "'" & m_dig_dig_no.Text & "'"
         crit1 = crit1 & "dig_nochrt  like " & "'" & "%" & m_dig_nochrt.Text & "%" & "'"
      m_dig_nochrt.Enabled = False
      Command1.SetFocus
      
End If
If qst17 = 0 And Not m_rel_text.Text = "" Then
   qst17 = 1
If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       macnz.Resultset.Bookmark = DBList2.SelectedItem
       m_rel_no = macnz.Resultset![sub_code]
      crit1 = crit1 & "rel_rel_no =  " & "'" & m_rel_no & "'"
      CRIT = CRIT & " left join dbo.relative ON dbo.article.ART_app_no = dbo.relative.rel_app_no "
      m_rel_text.Text = macnz.Resultset![sub_desc]
      DBList2.Visible = False
      m_rel_text.Enabled = False
End If
If qst18 = 0 And Not m_nar_text.Text = "" Then
  qst18 = 1
  If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       macnz.Resultset.Bookmark = DBList2.SelectedItem
       m_nar_no = macnz.Resultset![sub_code]
      crit1 = crit1 & "nar_nar_no =  " & "'" & m_nar_no & "'"
      CRIT = CRIT & " left join dbo.narower ON dbo.ARTICLE.ART_app_no = dbo.narower.nar_app_no "
      m_nar_text.Text = macnz.Resultset![sub_desc]
      DBList2.Visible = False
      m_nar_text.Enabled = False
End If
If qst19 = 0 And Not m_geo_text.Text = "" Then
   qst19 = 1
      If first_qst = 1 Then
       crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_geo_no = view_form.Resultset![sub_cod]
      crit1 = crit1 & "geo_geo_no =  " & "'" & m_geo_no & "'"
      CRIT = CRIT & " left join dbo.geo ON dbo.ARTICLE.ART_app_no = dbo.geo.geo_app_no "
      m_geo_text.Text = view_form.Resultset![sub_name]
      DBList1.Visible = False
      m_geo_text.Enabled = False
    End If
    If qst20 = 0 And Not m_art_pg_no.Text = "" Then
  qst20 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     ' crit1 = crit1 & "dig_dig_no =  " & "'" & m_dig_dig_no.Text & "'"
         crit1 = crit1 & "art_pg_no = " & "'" & Val(m_art_pg_no.Text) & "'"
      m_art_pg_no.Enabled = False
      
End If
 If qst21 = 0 And Not m_geo_chrt.Text = "" Then
   qst21 = 1
  
  If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_chrt_no = view_form.Resultset![sub_cod]
      crit1 = crit1 & "dig_geochrt =  " & "'" & m_chrt_no & "'"
      m_geo_chrt.Text = view_form.Resultset![sub_name]
      DBList1.Visible = False
      m_geo_chrt.Enabled = False
     Command1.SetFocus
   End If
 If qst22 = 0 And Not m_art_lang.Text = "" Then
   qst22 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " art_lang1 = " & "'" & Mid(m_art_lang.BoundText, 3, 2) & "'"
      m_art_lang.Enabled = False
End If
If first_qst > 0 Then
  crit2 = CRIT & crit1 & " order by art_dte"
'MsgBox crit2
       sql = "drop proc tmp_result "
       cn.Execute sql, rdExecDirect
       cn.Execute crit2, rdExecDirect
       Screen.MousePointer = vbDefault
       Screen.MousePointer = vbHourglass
       RESULT.RecordSource = "execute tmp_result"
        RESULT.Refresh
       DataGrid1.Refresh
      DataGrid1.SetFocus
      Screen.MousePointer = vbDefault
 Else
      MsgBox "ÌÃ» ÿ—Õ «·”ƒ«· «Ê·«....."
End If
End Sub

Private Sub Command10_Click()
Frame2.Visible = False
DataGrid1.SetFocus

End Sub

Private Sub Command11_Click()
'On Error Resume Next
m_path = Dirlist.Path
 Dim ser As Integer
 ser = 1
 RESULT.Recordset.MoveFirst
 While Not RESULT.Recordset.EOF
 m_cnf_path = ""
 If Not IsNull(RESULT.Recordset![dig_typ1]) Then
 If Not IsNull(RESULT.Recordset![dig_DIG_NO]) Then
 m_dig_typ1 = RESULT.Recordset![dig_typ1]
       If m_dig_typ1 = "01" Then
          m_cnf_path = m_cnf_path_pic + "scan\"
        ElseIf m_dig_typ1 = "02" Then
         m_cnf_path = m_cnf_path_pic + "waves\"
        ElseIf m_dig_typ1 = "03" Then
         m_cnf_path = m_cnf_path_pic + "photos\"
         ElseIf m_dig_typ1 = "05" Then
         m_cnf_path = m_cnf_path_pic + "private\"
       End If
       M_DIG_TYP = Trim(RESULT.Recordset![dig_typ])
         V_REC = RESULT.Recordset![dig_DIG_NO]
         v_nam = RESULT.Recordset![mn_app_no]
          v_nam = v_nam + filter_desc(Trim(RESULT.Recordset![MN_ACT_TTL]))
         If Not IsNull(RESULT.Recordset![art_dte]) Then
           v_nam = v_nam + Str(Day(RESULT.Recordset![art_dte])) + "-" + Str(Month(RESULT.Recordset![art_dte])) + "-" + Str(Year(RESULT.Recordset![art_dte]))
          End If
         m_source = m_cnf_path & Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\" & V_REC & "." & M_DIG_TYP
        m_target = m_path & "\" & v_nam & "." & M_DIG_TYP
        myfile = Dir(m_source)
     If myfile <> "" Then
       FileCopy m_source, m_target
      End If
      If isrec.value = 1 Then
          m_dig_no = V_REC
          m_typ1 = m_dig_typ1
          m_typ = M_DIG_TYP
          m_no_ist = RESULT.Recordset![mn_app_no]
           M_res_dte = Format(Date, "dd/mm/yy")
           
             If ser = 1 Then
                     sql = "execute op_result"
                      cn.Execute sql, rdExecDirect
     
                   coding_typ.sql = "execute max_result"
                       coding_typ.Refresh
                     m_no = coding_typ.Resultset![max1]
             
          
 
             sql = "execute upd_result " & "'" & m_no & "'" & "," & "'" & m_dig_no & "'" & "," & "'" & m_no_ist & "'" & "," _
             & "'" & m_typ & "'" & "," & "'" & m_typ1 & "'" & "," _
             & "'" & m_res_prs.Text & "'" & "," _
        & "'" & Mid(m_res_cote.BoundText, 3, 2) & "'" & "," _
       & "'" & Mid(m_res_permit.BoundText, 3, 2) & "'" & "," & "'" & Format(M_res_dte, "yyyy/mm/dd") & "'" & "," _
       & "'" & box_user_no & "'" & "," & "'" & ser & "'" & "," _
             & "'" & m_res_subject.Text & "'"
                cn.Execute sql, rdExecDirect
 ser = ser + 1
      
      Else
         ser = ser + 1
         
          sql = "execute insr_result " & "'" & m_no & "'" & "," & "'" & m_dig_no & "'" & "," & "'" & m_no_ist & "'" & "," _
             & "'" & m_typ & "'" & "," & "'" & m_typ1 & "'" & "," _
             & "'" & m_res_prs.Text & "'" & "," _
        & "'" & Mid(m_res_cote.BoundText, 3, 2) & "'" & "," _
       & "'" & Mid(m_res_permit.BoundText, 3, 2) & "'" & "," & "'" & Format(M_res_dte, "yyyy/mm/dd") & "'" & "," _
       & "'" & box_user_no & "'" & "," & "'" & ser & "'" & "," _
             & "'" & m_res_subject.Text & "'"
                cn.Execute sql, rdExecDirect

      End If
      End If
       End If
       End If
      RESULT.Recordset.MoveNext
   Wend
  
 
  RESULT.Refresh
   MsgBox "·ﬁœ «‰ ÂÏ ‰”Œ «·„ﬁ«·« ...."


End Sub

Private Sub Command2_Click()
Unload user_interface
End Sub

Private Sub Command3_Click()
On Error Resume Next
Dim nb_rec As Variant
If RESULT.Recordset.EOF Then
  MsgBox "·«ÌÊÃœ „ﬁ«·«  ·Â–« «·”ƒ«·"
Else
  Screen.MousePointer = vbDefault
  Screen.MousePointer = vbHourglass
  RESULT.Recordset.MoveLast
  nb_rec = RESULT.Recordset.RecordCount
  Screen.MousePointer = vbDefault
  MsgBox "⁄œœ «·„ﬁ«·«  = " & nb_rec
End If
 
End Sub

Private Sub Command4_Click()
On Error Resume Next
qst1 = 0
qst2 = 0
qst3 = 0
qst4 = 0
qst5 = 0
qst6 = 0
qst7 = 0
qst8 = 0
qst9 = 0
qst10 = 0
qst11 = 0
qst12 = 0
qst13 = 0
qst14 = 0
qst15 = 0
qst16 = 0
qst17 = 0
qst18 = 0
qst19 = 0
qst20 = 0
qst21 = 0
qs22 = 0
m_mn_result.Enabled = True
m_txt_text.Enabled = True


m_word.Enabled = True
m_art_pg_no.Enabled = True

m_art_sub_ty.Enabled = True
m_art_lang.Enabled = True

m_dig_typ1.Enabled = True
m_art_per_no.Enabled = True
m_res_no.Enabled = True
m_file_no.Enabled = True
m_desc_no.Enabled = True
M_art_dte.Enabled = True
M_art_dte1.Enabled = True
m_ent_dte.Enabled = True
m_ent_dte1.Enabled = True
m_dig_dig_no.Enabled = True
m_dig_nochrt.Enabled = True
m_mn_data_en.Enabled = True
m_rel_text.Enabled = True
m_nar_text.Enabled = True
m_geo_text.Enabled = True
m_geo_chrt.Enabled = True

If DBList1.Visible = True Then
  DBList1.Visible = False
End If
If DBList2.Visible = True Then
  DBList2.Visible = False
End If
first_qst = 0
m_mn_result.Text = ""
m_dig_typ1.Text = ""
m_word.Text = ""
m_art_sub_ty.Text = ""
m_art_per_no.Text = ""
m_res_no.Text = ""
m_file_no.Text = ""
m_desc_no.Text = ""
m_nar_text.Text = ""
m_rel_text.Text = ""
m_txt_text.Text = ""
m_geo_text.Text = ""
m_art_pg_no.Text = ""
m_art_lang.Text = ""
m_dig_dig_no.Text = ""
M_art_dte.Text = "__/__/____"
M_art_dte1.Text = "__/__/____"
m_ent_dte.Text = "__/__/____"
m_ent_dte1.Text = "__/__/____"
m_mn_data_en.Text = ""
m_dig_nochrt.Text = ""
m_geo_chrt.Text = ""
 RESULT.RecordSource = "execute interface_null"
 RESULT.Refresh
 

crit1 = ""
 CRIT = "create proc tmp_result as "

  CRIT = CRIT & "SELECT DISTINCT " & _
                       "dbo.AUTHER.AUT_NAM AS res_res_no, dbo.MAIN.MN_APP_NO AS mn_app_no, dbo.MAIN.MN_ACT_TTL AS mn_act_ttl, " & _
                       "dbo.MAIN.MN_ADD_TTL AS mn_add_ttl, dbo.CODING.SUB_DESC AS dig_typ2, dbo.ARTICLE.ART_DTE AS art_dte,dbo.ARTICLE.ART_pg_no AS ART_pg_no, " & _
                       "dbo.PERIOD.PER_PER_NA AS art_per_no,dbo.digit.dig_dig_no  as dig_dig_no ,dbo.digit.dig_typ as dig_typ  , dbo.digit.dig_typ1 as dig_typ1 , dbo.digit.dig_choice as dig_choice  " & _
                       ", dbo.digit.dig_s as dig_s , dbo.digit.dig_o as dig_o , dbo.digit.dig_m as dig_m , dbo.digit.dig_s1 as dig_s1 , dbo.digit.dig_o1 as dig_o1 , dbo.digit.dig_m1 as dig_m1 , dbo.digit.dig_typ_high as dig_typ_high " & _
"FROM         dbo.MAIN left JOIN " & _
                      "dbo.ARTICLE ON dbo.MAIN.MN_APP_NO = dbo.ARTICLE.ART_APP_NO left JOIN " & _
                      "dbo.RES ON dbo.ARTICLE.ART_APP_NO = dbo.RES.RES_APP_NO left JOIN " & _
                      "dbo.AUTHER ON dbo.RES.RES_RES_NO = dbo.AUTHER.AUT_NO left JOIN " & _
                      "dbo.PERIOD ON dbo.ARTICLE.ART_PER_NO = dbo.PERIOD.PER_PER_NO left join " & _
                     "dbo.digit ON dbo.MAIN.MN_APP_NO = dbo.digit.dig_no left JOIN " & _
                      "dbo.CODING ON '24'+ dbo.digit.dig_typ1 = dbo.CODING.SUB_CODE "
                      

End Sub

Private Sub Command5_Click()

End Sub

Private Sub Command8_Click()
On Error Resume Next
If box_company = 1 Then
   jad_print = 4
ElseIf box_company = 2 Then
jad_print = 5
ElseIf box_company = 3 Then
    jad_print = 1
 ElseIf box_company = 4 Then
    jad_print = 7
   ElseIf box_company = 7 Then
    jad_print = 11
End If

 Screen.MousePointer = vbDefault
  Screen.MousePointer = vbHourglass
  form_report.WindowState = 2
  form_report.Show
  Screen.MousePointer = vbDefault
End Sub

Private Sub Command9_Click()
Dim ser As Integer
ser = 1
On Error Resume Next
If box_serch = 1 Then
Dim m_path As Variant

 m_path = Dirlist.Path
     RESULT.Recordset.MoveFirst
     While Not RESULT.Recordset.EOF
      If RESULT.Recordset![DIG_choice] = 1 Then
     m_cnf_path = ""
If Not IsNull(RESULT.Recordset![dig_typ1]) Then
 If Not IsNull(RESULT.Recordset![dig_DIG_NO]) Then
    m_dig_typ1 = RESULT.Recordset![dig_typ1]
       If m_dig_typ1 = "01" Then
          m_cnf_path = m_cnf_path_pic + "scan\"
        ElseIf m_dig_typ1 = "02" Then
         m_cnf_path = m_cnf_path_pic + "waves\"
        ElseIf m_dig_typ1 = "03" Then
         m_cnf_path = m_cnf_path_pic + "photos\"
         ElseIf m_dig_typ1 = "05" Then
         m_cnf_path = m_cnf_path_pic + "private\"
       End If
      M_DIG_TYP = Trim(RESULT.Recordset![dig_typ])
         V_REC = RESULT.Recordset![dig_DIG_NO]
         v_nam = RESULT.Recordset![mn_app_no]
           v_nam = v_nam + filter_desc(Trim(RESULT.Recordset![MN_ACT_TTL]))
         If Not IsNull(RESULT.Recordset![art_dte]) Then
          v_nam = v_nam + Str(Day(RESULT.Recordset![art_dte])) + "-" + Str(Month(RESULT.Recordset![art_dte])) + "-" + Str(Year(RESULT.Recordset![art_dte]))
          End If
         m_source = m_cnf_path & Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\" & V_REC & "." & M_DIG_TYP
         m_target = m_path & "\" & v_nam & "." & M_DIG_TYP
         myfile = Dir(m_source)
         If myfile <> "" Then
            FileCopy m_source, m_target
            m_typ = 0
            sql = "execute upd_DIG_choice " & "'" & V_REC & "'" & "," & "'" & m_typ & "'" _
            & "," & "'" & m_dig_typ1 & "'"
               cn.Execute sql, rdExecDirect
         Else
           MsgBox V_REC & " Â–Â «·„ﬁ«·… €Ì— „ÊÃÊœ… ›Ì «·«—‘Ì›"
         End If

      If isrec.value = 1 Then
          m_dig_no = V_REC
          m_typ1 = m_dig_typ1
          m_typ = M_DIG_TYP
          m_no_ist = RESULT.Recordset![mn_app_no]
           M_res_dte = Format(Date, "dd/mm/yy")
           
             If ser = 1 Then
                     sql = "execute op_result"
                      cn.Execute sql, rdExecDirect
     
                   coding_typ.sql = "execute max_result"
                       coding_typ.Refresh
                     m_no = coding_typ.Resultset![max1]
               
 
             sql = "execute upd_result " & "'" & m_no & "'" & "," & "'" & m_dig_no & "'" & "," & "'" & m_no_ist & "'" & "," _
             & "'" & m_typ & "'" & "," & "'" & m_typ1 & "'" & "," _
             & "'" & m_res_prs.Text & "'" & "," _
        & "'" & Mid(m_res_cote.BoundText, 3, 2) & "'" & "," _
       & "'" & Mid(m_res_permit.BoundText, 3, 2) & "'" & "," & "'" & Format(M_res_dte, "yyyy/mm/dd") & "'" & "," _
       & "'" & box_user_no & "'" & "," & "'" & ser & "'" & "," _
             & "'" & m_res_subject.Text & "'"
                cn.Execute sql, rdExecDirect

       ser = ser + 1
      Else
         ser = ser + 1
         
          sql = "execute insr_result " & "'" & m_no & "'" & "," & "'" & m_dig_no & "'" & "," & "'" & m_no_ist & "'" & "," _
             & "'" & m_typ & "'" & "," & "'" & m_typ1 & "'" & "," _
             & "'" & m_res_prs.Text & "'" & "," _
        & "'" & Mid(m_res_cote.BoundText, 3, 2) & "'" & "," _
       & "'" & Mid(m_res_permit.BoundText, 3, 2) & "'" & "," & "'" & Format(M_res_dte, "yyyy/mm/dd") & "'" & "," _
       & "'" & box_user_no & "'" & "," & "'" & ser & "'" & "," _
             & "'" & m_res_subject.Text & "'"
                cn.Execute sql, rdExecDirect

      
      End If
       End If
       End If
       End If
       End If
     RESULT.Recordset.MoveNext
 Wend
  RESULT.Refresh
   MsgBox "·ﬁœ «‰ ÂÏ ‰”Œ «·„ﬁ«·« ...."
 

Frame2.Visible = False
DataGrid1.SetFocus



End If

End Sub

Private Sub datagrid1_DblClick()
On Error Resume Next
If box_serch = 1 Then
      Dim v_prs_no, m_no As String
    Dim V_REC As Variant
    Dim M_NAM, M_NAM1, M_CD As String
    lkey = KeyAscii
         
If Not RESULT.Recordset.BOF Then
m_cnf_path = ""
 m_dig_typ1 = RESULT.Recordset![dig_typ1]
       If m_dig_typ1 = "01" Then
          m_cnf_path = m_cnf_path_pic + "scan\"
        ElseIf m_dig_typ1 = "02" Then
         m_cnf_path = m_cnf_path_pic + "waves\"
        ElseIf m_dig_typ1 = "03" Then
         m_cnf_path = m_cnf_path_pic + "photos\"
        ElseIf m_dig_typ1 = "05" Then
         m_cnf_path = m_cnf_path_pic + "private\"
       End If
M_DIG_TYP = Trim(RESULT.Recordset![dig_typ])
V_REC = RESULT.Recordset![dig_DIG_NO]
M_NAM1 = Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\" & V_REC & "." & M_DIG_TYP
m_x = m_cnf_path & M_NAM1
   m_file = Dir(m_x)
    If m_file <> "" Then
      Call OpenDoc(m_x)
     Else
      MsgBox ("Â–« «·„·› €Ì— „ÊÃÊœ ›Ì «·«—‘Ì›...." & m_x)
      
     End If
End If

End If
 
End Sub

Private Sub DataGrid1_KeyDown(KeyCode As Integer, Shift As Integer)
  Dim sql As String
  On Error Resume Next
If box_serch = 1 Then
If KeyCode = vbKeyF9 Then
     m_row = DataGrid1.Row
     If RESULT.Recordset![DIG_choice] = 0 Or IsNull(RESULT.Recordset![DIG_choice]) Then
        V_REC = RESULT.Recordset![dig_DIG_NO]
        v_typ = RESULT.Recordset![dig_typ1]
        m_typ = 1
     Else
        m_typ = 0
         v_typ = RESULT.Recordset![dig_typ1]
     V_REC = RESULT.Recordset![dig_DIG_NO]
     End If
     sql = "execute upd_dig_choice " & "'" & V_REC & "'" & "," & "'" & m_typ & "'" _
     & "," & "'" & v_typ & "'"
     cn.Execute sql, rdExecDirect
     RESULT.Refresh
     DataGrid1.Row = m_row
 ElseIf KeyCode = vbKeyF2 Then
   
    m_bk_no = RESULT.Recordset![mn_app_no]
    If Mid(m_bk_no, 1, 1) = "ﬁ" Then
       m_form_load = 2
       Screen.MousePointer = vbDefault
       Screen.MousePointer = vbHourglass
       Form6.WindowState = 2
       Form6.Show
       Screen.MousePointer = vbDefault
    End If
 
 ElseIf KeyCode = vbKeyF3 Then
   Frame2.Visible = True
 End If
End If
End Sub

Private Sub DataGrid1_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF6 Then
v_mch_o = RESULT.Recordset![dig_o]
 v_mch_m = RESULT.Recordset![dig_m]
 v_mch_s = RESULT.Recordset![dig_s]
v_mch_o1 = RESULT.Recordset![dig_o1]
 v_mch_m1 = RESULT.Recordset![dig_m1]
 v_mch_s1 = RESULT.Recordset![dig_s1]
 v_mch_tit = RESULT.Recordset![MN_ACT_TTL]
 v_mch_no = RESULT.Recordset![mn_app_no]
 V_MCH_STOCK = RESULT.Recordset![dig_DIG_NO]
 nb_page = 0
If Not IsEmpty(RESULT.Recordset![dig_typ]) Then
      v_mch_typ = Trim(RESULT.Recordset![dig_typ])
      Else
      v_mch_typ = ""
      End If
      If Not IsEmpty(RESULT.Recordset![dig_typ_high]) Then
      v_mch_typ_high = Trim(RESULT.Recordset![dig_typ_high])
      ElseIf Not IsEmpty(RESULT.Recordset![dig_typ]) Then
      v_mch_typ_high = Trim(RESULT.Recordset![dig_typ])
      Else
        v_mch_typ_high = "avi"
      End If
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 new_vdpreview.WindowState = 0
 new_vdpreview.Show
' vd_prv.WindowState = 0
' vd_prv.Show

 Screen.MousePointer = vbDefault
 
    new_vdpreview.Refresh
 End If
End Sub

Private Sub DBList1_DblClick()
   If m_typ_file = 1 Then
  qst8 = 1
  
  If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_fad_no = view_form.Resultset![sub_cod]
      crit1 = crit1 & "fad_fad_no =  " & "'" & m_fad_no & "'"
      CRIT = CRIT & " left join dbo.file_add ON dbo.ARTICLE.ART_app_no = dbo.file_add.fad_app_no "
      m_file_no.Text = view_form.Resultset![sub_name]
      DBList1.Visible = False
      m_file_no.Enabled = False
     Command1.SetFocus
   ElseIf m_typ_file = 2 Then
   qst19 = 1
  
  If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_geo_no = view_form.Resultset![sub_cod]
      crit1 = crit1 & "geo_geo_no =  " & "'" & m_geo_no & "'"
      CRIT = CRIT & " left join dbo.geo ON dbo.ARTICLE.ART_app_no = dbo.geo.geo_app_no "
      m_geo_text.Text = view_form.Resultset![sub_name]
      DBList1.Visible = False
      m_geo_text.Enabled = False
     Command1.SetFocus
  ElseIf m_typ_file = 3 Then
   qst21 = 1
  
  If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_chrt_no = view_form.Resultset![sub_cod]
      crit1 = crit1 & "dig_geochrt =  " & "'" & m_chrt_no & "'"
      m_geo_chrt.Text = view_form.Resultset![sub_name]
      DBList1.Visible = False
      m_geo_chrt.Enabled = False
     Command1.SetFocus
   End If

      
End Sub

Private Sub DBList1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 If m_typ_file = 1 Then
  qst8 = 1
  
  If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_fad_no = view_form.Resultset![sub_cod]
      crit1 = crit1 & "fad_fad_no =  " & "'" & m_fad_no & "'"
      CRIT = CRIT & " left join dbo.file_add ON dbo.ARTICLE.ART_app_no = dbo.file_add.fad_app_no "
      m_file_no.Text = view_form.Resultset![sub_name]
      DBList1.Visible = False
      m_file_no.Enabled = False
     Command1.SetFocus
   ElseIf m_typ_file = 2 Then
   qst19 = 1
  
  If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_geo_no = view_form.Resultset![sub_cod]
      crit1 = crit1 & "geo_geo_no =  " & "'" & m_geo_no & "'"
      CRIT = CRIT & " left join dbo.geo ON dbo.ARTICLE.ART_app_no = dbo.geo.geo_app_no "
      m_geo_text.Text = view_form.Resultset![sub_name]
      DBList1.Visible = False
      m_geo_text.Enabled = False
     Command1.SetFocus
  ElseIf m_typ_file = 3 Then
   qst21 = 1
  
  If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_chrt_no = view_form.Resultset![sub_cod]
      crit1 = crit1 & "dig_geochrt =  " & "'" & m_chrt_no & "'"
      m_geo_chrt.Text = view_form.Resultset![sub_name]
      DBList1.Visible = False
      m_geo_chrt.Enabled = False
     Command1.SetFocus
   End If
 ElseIf KeyAscii = 27 Then
     m_file_no.Text = ""
     DBList1.Visible = False
     m_file_no.SetFocus
  
End If
End Sub

Private Sub DBList2_DblClick()
 macnz.Resultset.Bookmark = DBList2.SelectedItem
      m_desc_no.Text = macnz.Resultset![sub_desc]
      DBList2.Visible = False
      m_desc_no.SetFocus
      
End Sub

Private Sub DBList2_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 If m_typ_desc = 1 Then
 qst7 = 1
  If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       macnz.Resultset.Bookmark = DBList2.SelectedItem
       m_an_no = macnz.Resultset![sub_code]
      crit1 = crit1 & "an_desc_no =  " & "'" & m_an_no & "'"
      CRIT = CRIT & " left join dbo.analis ON dbo.ARTICLE.ART_app_no = dbo.analis.an_app_no "
      m_desc_no.Text = macnz.Resultset![sub_desc]
      DBList2.Visible = False
      m_desc_no.Enabled = False
   ElseIf m_typ_desc = 2 Then
    qst17 = 1
   If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       macnz.Resultset.Bookmark = DBList2.SelectedItem
       m_rel_no = macnz.Resultset![sub_code]
      crit1 = crit1 & "rel_rel_no =  " & "'" & m_rel_no & "'"
      CRIT = CRIT & " left join dbo.relative ON dbo.ARTICLE.ART_app_no = dbo.relative.rel_app_no "
      m_rel_text.Text = macnz.Resultset![sub_desc]
      DBList2.Visible = False
      m_rel_text.Enabled = False
   ElseIf m_typ_desc = 3 Then
    qst18 = 1
   If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       macnz.Resultset.Bookmark = DBList2.SelectedItem
       m_nar_no = macnz.Resultset![sub_code]
      crit1 = crit1 & "nar_nar_no =  " & "'" & m_nar_no & "'"
      CRIT = CRIT & " left join dbo.narower ON dbo.ARTICLE.ART_app_no = dbo.narower.nar_app_no "
      m_nar_text.Text = macnz.Resultset![sub_desc]
      DBList2.Visible = False
      m_nar_text.Enabled = False
   End If
      Command1.SetFocus
   ElseIf KeyAscii = 27 Then
     m_desc_no.Text = ""
     DBList2.Visible = False
     m_desc_no.SetFocus
End If
End Sub

Private Sub Dirlist_Change()
fillist.Path = Dirlist.Path
End Sub

Private Sub drvlist_Change()
   On Error GoTo DriveHandler
   ' If new drive was selected, the Dir1 box
   ' updates its display.
   Dirlist.Path = drvlist.Drive
   Exit Sub
' If there is an error, reset drvList.Drive with the
' drive from dirList.Path.
DriveHandler:
   drvlist.Drive = Dirlist.Path
   Exit Sub
End Sub

Private Sub drvlist_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
 Frame2.Visible = False
 DataGrid1.SetFocus
 
End If
End Sub

Private Sub fillist_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
   Frame2.Visible = False
   DataGrid1.SetFocus
End If
End Sub


Private Sub Form_Load()
qst1 = 0
qst2 = 0
qst3 = 0
qst4 = 0
qst5 = 0
qst6 = 0
qst7 = 0
qst8 = 0
qst9 = 0
qst10 = 0
qst11 = 0
qst12 = 0
qst13 = 0
qst14 = 0
m_typ_serh = 1
qst15 = 0
qst16 = 0
qst17 = 0
qst18 = 0
qst19 = 0
qst20 = 0
qst21 = 0
qst22 = 0
Option1.value = True


m_dig_typ1.Text = ""
'M_art_dte.Text = Format(Date, "dd/mm/yy")
first_qst = 0
crit1 = ""
 CRIT = "create proc tmp_result as "

 CRIT = CRIT & "SELECT DISTINCT " & _
                       "dbo.AUTHER.AUT_NAM AS res_res_no, dbo.MAIN.MN_APP_NO AS mn_app_no, dbo.MAIN.MN_ACT_TTL AS mn_act_ttl, " & _
                       "dbo.MAIN.MN_ADD_TTL AS mn_add_ttl, dbo.CODING.SUB_DESC AS dig_typ2, dbo.ARTICLE.ART_DTE AS art_dte,dbo.ARTICLE.ART_pg_no AS ART_pg_no, " & _
                       "dbo.PERIOD.PER_PER_NA AS art_per_no,dbo.digit.dig_dig_no  as dig_dig_no ,dbo.digit.dig_typ as dig_typ  , dbo.digit.dig_typ1 as dig_typ1 , dbo.digit.dig_choice as dig_choice  " & _
                       ", dbo.digit.dig_s as dig_s , dbo.digit.dig_o as dig_o , dbo.digit.dig_m as dig_m , dbo.digit.dig_s1 as dig_s1 , dbo.digit.dig_o1 as dig_o1 , dbo.digit.dig_m1 as dig_m1 , dbo.digit.dig_typ_high as dig_typ_high " & _
"FROM         dbo.MAIN left JOIN " & _
                      "dbo.ARTICLE ON dbo.MAIN.MN_APP_NO = dbo.ARTICLE.ART_APP_NO left JOIN " & _
                      "dbo.RES ON dbo.ARTICLE.ART_APP_NO = dbo.RES.RES_APP_NO left JOIN " & _
                      "dbo.AUTHER ON dbo.RES.RES_RES_NO = dbo.AUTHER.AUT_NO left JOIN " & _
                      "dbo.PERIOD ON dbo.ARTICLE.ART_PER_NO = dbo.PERIOD.PER_PER_NO left join " & _
                     "dbo.digit ON dbo.MAIN.MN_APP_NO = dbo.digit.dig_no left JOIN " & _
                      "dbo.CODING ON '24'+ dbo.digit.dig_typ1 = dbo.CODING.SUB_CODE "
                      

End Sub

Private Sub m_OPR_DTE1_Change()

End Sub

Private Sub M_OPR_DTE1_KeyPress(KeyAscii As Integer)

End Sub

Private Sub m_art_dte_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then
 If Not M_art_dte.Text = "__/__/____" Then
  If IsDate(M_art_dte.Text) Then
     If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     
     m_dte1 = Format(M_art_dte.Text, "YYYY/MM/DD")
     crit1 = crit1 & "  art_DTE >= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102)"
     qst1 = 1
   Else
    M_art_dte.SetFocus
   End If
 End If
  M_art_dte.Enabled = False
  
  
  M_art_dte1.SetFocus
End If


End Sub

Private Sub M_OPR_DTE2_Change()

End Sub

Private Sub M_OPR_DTE2_KeyPress(KeyAscii As Integer)

End Sub

Private Sub m_art_dte1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not M_art_dte1.Text = "__/__/____" Then
  If IsDate(M_art_dte1.Text) Then
    If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
    
   m_dte = M_art_dte1.Text
  crit1 = crit1 & "   art_dte <= " & "convert(datetime," & "'" & Format(m_dte, "yyyy-mm-dd") & "'" & "," & "102)"
  M_art_dte1.Enabled = False
  qst2 = 1
  
  Command1.SetFocus
  
Else
  M_art_dte1.SetFocus
End If
  
End If

End Sub

Private Sub m_art_lang_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_art_lang.Text = "" Then
   qst22 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " art_lang1 = " & "'" & Mid(m_art_lang.BoundText, 3, 2) & "'"
      m_art_lang.Enabled = False
      Command1.SetFocus
End If
End Sub

Private Sub m_art_per_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_art_per_no.Text = "" Then
qst5 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " art_per_no = " & m_art_per_no.BoundText
      m_art_per_no.Enabled = False
      
      
      Command1.SetFocus
End If
End Sub

Private Sub m_art_pg_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_art_pg_no.Text = "" Then
  qst20 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     ' crit1 = crit1 & "dig_dig_no =  " & "'" & m_dig_dig_no.Text & "'"
         crit1 = crit1 & "art_pg_no = " & "'" & Val(m_art_pg_no.Text) & "'"
      m_art_pg_no.Enabled = False
      Command1.SetFocus
      
End If
End Sub

Private Sub m_art_sub_ty_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_art_sub_ty.Text = "" Then
   qst4 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " art_sub_ty = " & "'" & Mid(m_art_sub_ty.BoundText, 3, 2) & "'"
      m_art_sub_ty.Enabled = False
      Command1.SetFocus
End If


End Sub

Private Sub m_desc_no_Change()
  If DBList2.Visible = False Then
    DBList2.Visible = True
    DBList2.Top = 720
    DBList2.Left = 1680
    
    
  End If
   m_typ_desc = 1
    If m_typ_serh = 1 Then
       m_desc = m_desc_no.Text
       m_len = Len(Trim(m_desc))
        macnz.sql = "execute serh_macnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        macnz.Refresh
        DBList2.Refresh
       ' SendKeys "{UP}"
          If macnz.Resultset.EOF Or macnz.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If

 ElseIf m_typ_serh = 2 Then
       m_desc = m_desc_no.Text
       m_len = Len(Trim(m_desc))
        macnz.sql = "execute serh_wrdmacnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        macnz.Refresh
       ' SendKeys "{UP}"
         If macnz.Resultset.EOF Or macnz.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If

  End If
  
End Sub



Private Sub m_desc_no_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 40 And Not m_desc_no.Text = "" Then
   DBList2.SetFocus
   SendKeys "{UP}"
End If

End Sub

Private Sub m_dig_dig_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_dig_dig_no.Text = "" Then
  qst13 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     ' crit1 = crit1 & "dig_dig_no =  " & "'" & m_dig_dig_no.Text & "'"
         crit1 = crit1 & "dig_dig_no  like " & "'" & "%" & m_dig_dig_no.Text & "%" & "'"
      m_dig_dig_no.Enabled = False
      Command1.SetFocus
      
End If
End Sub

Private Sub m_dig_nochrt_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_dig_nochrt.Text = "" Then
  qst16 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     ' crit1 = crit1 & "dig_dig_no =  " & "'" & m_dig_dig_no.Text & "'"
         crit1 = crit1 & "dig_nochrt  like " & "'" & "%" & m_dig_nochrt.Text & "%" & "'"
      m_dig_nochrt.Enabled = False
      Command1.SetFocus
      
End If
End Sub

Private Sub m_dig_typ1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_dig_typ1.Text = "" Then
   qst10 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " dig_Typ1 = " & "'" & Mid(m_dig_typ1.BoundText, 3, 2) & "'"
        
      m_dig_typ1.Enabled = False
      Command1.SetFocus
End If

End Sub

Private Sub m_ent_dte_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 If Not m_ent_dte.Text = "__/__/____" Then
  If IsDate(m_ent_dte.Text) Then
     If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     
     m_dte1 = Format(m_ent_dte.Text, "YYYY/MM/DD")
     crit1 = crit1 & "  mn_ent_dte >= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102)"
     qst11 = 1
   Else
   m_ent_dte.SetFocus
   End If
 End If
  m_ent_dte.Enabled = False
  
  
  m_ent_dte1.SetFocus
End If


End Sub

Private Sub m_ent_dte1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_ent_dte1.Text = "__/__/____" Then
  If IsDate(m_ent_dte1.Text) Then
    If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
    
   m_dte = m_ent_dte1.Text
  crit1 = crit1 & "   mn_ent_dte <= " & "convert(datetime," & "'" & Format(m_dte, "yyyy-mm-dd") & "'" & "," & "102)"
  M_art_dte1.Enabled = False
  qst12 = 1
  Command1.SetFocus
  
Else
  m_ent_dte1.SetFocus
End If
  
End If
End Sub

Private Sub m_file_no_Change()
  If DBList1.Visible = False Then
    DBList1.Visible = True
    DBList1.Top = 2400
    DBList1.Left = 4200
    
  End If
   m_typ_file = 1
  If Not Trim(m_file_no.Text) = "" Then
       If m_typ_serh = 1 Then
         m_desc = m_file_no.Text
         
         m_len = Len(Trim(m_file_no.Text))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
         
        '
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If
      ElseIf m_typ_serh = 2 Then
            m_desc = m_file_no.Text
            m_len = Len(Trim(m_file_no.Text))
            view_form.sql = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
            view_form.Refresh
     
             If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
                MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
             End If
        End If

      ' m_file_no.SetFocus
   End If

End Sub

Private Sub m_res_res_no_Click(Area As Integer)

End Sub

 

Private Sub m_file_no_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not m_file_no.Text = "" Then
   DBList1.SetFocus
  SendKeys "{UP}"
End If
End Sub

Private Sub m_geo_chrt_Change()
If DBList1.Visible = False Then
    DBList1.Visible = True
     DBList1.Top = 3240
    DBList1.Left = 1680
    
  End If
   m_typ_file = 3
  If Not Trim(m_geo_chrt.Text) = "" Then
       If m_typ_serh = 1 Then
         m_desc = m_geo_chrt.Text
         
         m_len = Len(Trim(m_geo_chrt.Text))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
         
        ' DBList1.SetFocus
'         SendKeys "{UP}"
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If
      ElseIf m_typ_serh = 2 Then
            m_desc = m_geo_chrt.Text
            m_len = Len(Trim(m_geo_chrt.Text))
            view_form.sql = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
            view_form.Refresh
    '        DBList1.Refresh
    '        DBList1.SetFocus
    '        m_file_no.Visible = False
          '  Label18.Visible = False
    '        SendKeys "{UP}"
             If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
                MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
             End If
        End If

      ' m_file_no.SetFocus
   End If
End Sub

Private Sub m_geo_chrt_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not m_geo_chrt.Text = "" Then
   DBList1.SetFocus
  SendKeys "{UP}"
End If
End Sub

Private Sub m_geo_text_Change()
If DBList1.Visible = False Then
    DBList1.Visible = True
     DBList1.Top = 2880
    DBList1.Left = 4320
    
  End If
   m_typ_file = 2
  If Not Trim(m_geo_text.Text) = "" Then
       If m_typ_serh = 1 Then
         m_desc = m_geo_text.Text
         
         m_len = Len(Trim(m_geo_text.Text))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
         
        ' DBList1.SetFocus
'         SendKeys "{UP}"
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If
      ElseIf m_typ_serh = 2 Then
            m_desc = m_geo_text.Text
            m_len = Len(Trim(m_geo_text.Text))
            view_form.sql = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
            view_form.Refresh
    '        DBList1.Refresh
    '        DBList1.SetFocus
    '        m_file_no.Visible = False
          '  Label18.Visible = False
    '        SendKeys "{UP}"
             If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
                MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
             End If
        End If

      ' m_file_no.SetFocus
   End If

End Sub

Private Sub m_geo_text_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not m_geo_text.Text = "" Then
   DBList1.SetFocus
  SendKeys "{UP}"
End If
End Sub

Private Sub m_mn_data_en_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_mn_data_en.Text = "" Then
   qst15 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " mn_data_en = " & "'" & Mid(m_mn_data_en.BoundText, 3, 2) & "'"
       m_mn_data_en.Enabled = False
      Command1.SetFocus
End If
End Sub

Private Sub m_mn_result_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_mn_result.Text = "" Then
  qst9 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & "mn_result  like " & "'" & "%" & m_mn_result.Text & "%" & "'"
      m_mn_result.Enabled = False
      Command1.SetFocus
      
End If
End Sub

Private Sub m_mn_text_Change()

End Sub

Private Sub m_nar_text_Change()
If DBList2.Visible = False Then
    DBList2.Visible = True
    DBList2.Top = 1680
    DBList2.Left = 1680
    
  End If
  m_typ_desc = 3
    If m_typ_serh = 1 Then
       m_desc = m_nar_text.Text
       m_len = Len(Trim(m_desc))
        macnz.sql = "execute serh_macnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        macnz.Refresh
        DBList2.Refresh
       ' SendKeys "{UP}"
          If macnz.Resultset.EOF Or macnz.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If

 ElseIf m_typ_serh = 2 Then
       m_desc = m_nar_text.Text
       m_len = Len(Trim(m_desc))
        macnz.sql = "execute serh_wrdmacnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        macnz.Refresh
       ' SendKeys "{UP}"
         If macnz.Resultset.EOF Or macnz.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If

  End If
End Sub

Private Sub m_nar_text_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 40 And Not m_nar_text.Text = "" Then
   DBList2.SetFocus
   SendKeys "{UP}"
End If

End Sub

Private Sub m_rel_text_Change()
  If DBList2.Visible = False Then
    DBList2.Visible = True
    DBList2.Top = 1200
    DBList2.Left = 1680
    
  End If
  m_typ_desc = 2
    If m_typ_serh = 1 Then
       m_desc = m_rel_text.Text
       m_len = Len(Trim(m_desc))
        macnz.sql = "execute serh_macnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        macnz.Refresh
        DBList2.Refresh
       ' SendKeys "{UP}"
          If macnz.Resultset.EOF Or macnz.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If

 ElseIf m_typ_serh = 2 Then
       m_desc = m_rel_text.Text
       m_len = Len(Trim(m_desc))
        macnz.sql = "execute serh_wrdmacnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        macnz.Refresh
       ' SendKeys "{UP}"
         If macnz.Resultset.EOF Or macnz.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If

  End If
End Sub

Private Sub m_rel_text_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 40 And Not m_rel_text.Text = "" Then
   DBList2.SetFocus
   SendKeys "{UP}"
End If

End Sub

Private Sub m_res_cote_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_res_prs.SetFocus
 
End If

End Sub

Private Sub m_res_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_res_no.Text = "" Then
  qst6 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " res_res_no = " & m_res_no.BoundText
      m_res_no.Enabled = False
      
      Command1.SetFocus
End If
End Sub

Private Sub m_res_permit_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_res_cote.SetFocus
 SendKeys "{f4}"
 
End If
End Sub

Private Sub m_res_prs_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_res_subject.SetFocus
 
End If

End Sub

Private Sub m_txt_text_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_txt_text.Text = "" Then
  qst14 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & "txt_text  like " & "'" & "%" & m_txt_text.Text & "%" & "'"
      CRIT = CRIT & " left join dbo.text1 ON dbo.ARTICLE.ART_app_no = dbo.text1.txt_no "
      m_txt_text.Enabled = False
      Command1.SetFocus
      
End If
End Sub

Private Sub m_word_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_word.Text = "" Then
  qst3 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & "mn_act_ttl + mn_add_ttl  like " & "'" & "%" & m_word.Text & "%" & "'"
      m_word.Enabled = False
      Command1.SetFocus
      
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
Function rec_result(m_no As String, m_dig_no As String, m_typ As String, m_typ1 As String)

 M_res_dte = Date
 
             sql = "execute upd_result " & "'" & m_no & "'" & "," & "'" & m_dig_no & "'" & "," _
             & "'" & m_typ & "'" & "," & "'" & m_typ1 & "'" & "," _
             & "'" & m_res_prs.Text & "'" & "," _
        & "'" & Mid(m_res_cote.BoundText, 3, 2) & "'" & "," _
       & "'" & Mid(m_res_permit.BoundText, 3, 2) & "'" & "," & "'" & Format(M_res_dte, "yyyy/mm/dd") & "'" & "," _
       & "'" & box_user_no & "'"
                cn.Execute sql, rdExecDirect

End Function
