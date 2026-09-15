VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{CDE57A40-8B86-11D0-B3C6-00A0C90AEA82}#1.0#0"; "MSDATGRD.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{F2BD1C8B-41F5-4842-AC48-3B94E1F85FCE}#1.0#0"; "VideoEdit.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{6BF52A50-394A-11D3-B153-00C04F79FAA6}#1.0#0"; "wmp.dll"
Begin VB.Form new_vdpreview 
   BackColor       =   &H0086C8EC&
   Caption         =   "new_vdpreview"
   ClientHeight    =   9915
   ClientLeft      =   2115
   ClientTop       =   525
   ClientWidth     =   19860
   LinkTopic       =   "Form6"
   ScaleHeight     =   9915
   ScaleWidth      =   19860
   Begin VB.TextBox m_mch_stock 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00D8F9FE&
      Height          =   285
      Left            =   17040
      RightToLeft     =   -1  'True
      TabIndex        =   51
      Top             =   2760
      Width           =   1215
   End
   Begin VB.CommandButton Command20 
      BackColor       =   &H002972B4&
      Caption         =   "ÿ»«⁄… «·ÃœÊ·"
      Height          =   495
      Left            =   12960
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   50
      Top             =   3480
      Width           =   1095
   End
   Begin VB.CommandButton Command5 
      BackColor       =   &H002972B4&
      Caption         =   "copy"
      Height          =   375
      Left            =   7200
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   49
      Top             =   3240
      Width           =   735
   End
   Begin VB.TextBox nb_copy 
      Height          =   375
      Left            =   18720
      TabIndex        =   48
      Top             =   8760
      Width           =   855
   End
   Begin MSComctlLib.ProgressBar ProgressBar1 
      Height          =   375
      Left            =   120
      TabIndex        =   47
      Top             =   9000
      Width           =   18495
      _ExtentX        =   32623
      _ExtentY        =   661
      _Version        =   393216
      Appearance      =   1
   End
   Begin VB.CommandButton Command4 
      BackColor       =   &H002972B4&
      Caption         =   "newstart"
      Height          =   375
      Left            =   8640
      Style           =   1  'Graphical
      TabIndex        =   46
      Top             =   3240
      Width           =   735
   End
   Begin VB.TextBox m_tit1 
      BackColor       =   &H0086C8EC&
      Height          =   285
      Left            =   120
      TabIndex        =   45
      Text            =   " "
      Top             =   8640
      Width           =   18375
   End
   Begin VB.CommandButton Command27 
      Caption         =   "from"
      Height          =   375
      Left            =   4200
      TabIndex        =   44
      Top             =   3960
      Width           =   495
   End
   Begin VB.CommandButton Command28 
      Caption         =   "to"
      Height          =   375
      Left            =   4680
      TabIndex        =   43
      Top             =   3960
      Width           =   495
   End
   Begin VB.CommandButton Command19 
      BackColor       =   &H002972B4&
      Caption         =   "test"
      Height          =   375
      Left            =   7920
      Style           =   1  'Graphical
      TabIndex        =   41
      Top             =   3240
      Width           =   735
   End
   Begin MSDBCtls.DBList DBList1 
      Bindings        =   "new_vdpreview.frx":0000
      Height          =   2985
      Left            =   2160
      TabIndex        =   29
      Top             =   5040
      Visible         =   0   'False
      Width           =   3735
      _ExtentX        =   6588
      _ExtentY        =   5265
      _Version        =   393216
      BackColor       =   2716340
      ForeColor       =   -2147483643
      ListField       =   "user_name"
      BoundColumn     =   "user_no"
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
   Begin VB.CommandButton Command15 
      BackColor       =   &H002972B4&
      Caption         =   "⁄œœ Ê„œ… «·„‘«Âœ"
      Height          =   495
      Left            =   15600
      MaskColor       =   &H00FFFFC0&
      Style           =   1  'Graphical
      TabIndex        =   39
      Top             =   3480
      Width           =   1215
   End
   Begin VB.CommandButton Command14 
      BackColor       =   &H002972B4&
      Caption         =   "«÷«›… - ﬂ«„· «·„‘Âœ"
      Height          =   495
      Left            =   14160
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   38
      Top             =   3480
      Width           =   1335
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H0086C8EC&
      Height          =   1335
      Left            =   7800
      TabIndex        =   33
      Top             =   5520
      Visible         =   0   'False
      Width           =   4575
      Begin VB.CommandButton Command18 
         Caption         =   " ‰›Ì– „‘Âœ"
         Height          =   375
         Left            =   1560
         TabIndex        =   40
         Top             =   840
         Width           =   1095
      End
      Begin VB.CommandButton Command13 
         Caption         =   "«·€«¡ «·«„—"
         Height          =   375
         Left            =   120
         TabIndex        =   36
         Top             =   840
         Width           =   1095
      End
      Begin VB.CommandButton Command3 
         Caption         =   " ‰›Ì– «·ﬂ·"
         Height          =   375
         Left            =   3120
         TabIndex        =   35
         Top             =   840
         Width           =   1095
      End
      Begin MSDBCtls.DBCombo m_view_path 
         Bindings        =   "new_vdpreview.frx":0018
         Height          =   315
         Left            =   120
         TabIndex        =   34
         Top             =   360
         Width           =   4335
         _ExtentX        =   7646
         _ExtentY        =   556
         _Version        =   393216
         BackColor       =   -2147483643
         ListField       =   "SUB_DESC"
         Text            =   ""
      End
   End
   Begin VB.CheckBox Check3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H0086C8EC&
      Caption         =   "ﬂ·Ì»"
      Height          =   495
      Left            =   10320
      TabIndex        =   32
      Top             =   3720
      Width           =   735
   End
   Begin VB.TextBox m_dmd_user 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00D8F9FE&
      Height          =   285
      Left            =   15480
      RightToLeft     =   -1  'True
      TabIndex        =   30
      Top             =   2400
      Width           =   2775
   End
   Begin VB.TextBox m_dmd_no 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00D8F9FE&
      Height          =   285
      Left            =   16920
      RightToLeft     =   -1  'True
      TabIndex        =   28
      Top             =   2040
      Width           =   1215
   End
   Begin VB.CommandButton Command12 
      BackColor       =   &H002972B4&
      Caption         =   "«·‰ ÌÃ…"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   18240
      Style           =   1  'Graphical
      TabIndex        =   26
      Top             =   3480
      Width           =   1215
   End
   Begin VB.CommandButton Command11 
      BackColor       =   &H002972B4&
      Caption         =   "»ÕÀ ÃœÌœ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   16920
      MaskColor       =   &H00FFFFC0&
      Style           =   1  'Graphical
      TabIndex        =   25
      Top             =   3480
      Width           =   1215
   End
   Begin VB.CommandButton Command8 
      BackColor       =   &H002972B4&
      Caption         =   "Œ—ÊÃ"
      Height          =   495
      Left            =   12120
      MaskColor       =   &H80000001&
      Picture         =   "new_vdpreview.frx":0034
      Style           =   1  'Graphical
      TabIndex        =   24
      Top             =   3480
      Width           =   735
   End
   Begin VB.TextBox m_dmd_desc 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00D8F9FE&
      Height          =   285
      Left            =   7200
      RightToLeft     =   -1  'True
      TabIndex        =   23
      Top             =   2880
      Width           =   3855
   End
   Begin VB.TextBox search_text 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00D8F9FE&
      Height          =   285
      Left            =   15480
      RightToLeft     =   -1  'True
      TabIndex        =   21
      Top             =   1560
      Width           =   2655
   End
   Begin VB.TextBox m_step 
      Alignment       =   2  'Center
      Height          =   375
      Left            =   3360
      Locked          =   -1  'True
      TabIndex        =   19
      Text            =   "1"
      Top             =   3960
      Width           =   375
   End
   Begin VB.Frame Frame6 
      BackColor       =   &H002972B4&
      Caption         =   "«·€«¡ «” „«—…"
      ForeColor       =   &H8000000E&
      Height          =   1695
      Left            =   14880
      RightToLeft     =   -1  'True
      TabIndex        =   14
      Top             =   5400
      Visible         =   0   'False
      Width           =   3615
      Begin VB.TextBox M_YESNO 
         Alignment       =   1  'Right Justify
         BackColor       =   &H80000014&
         Height          =   405
         Left            =   480
         RightToLeft     =   -1  'True
         TabIndex        =   17
         Top             =   360
         Width           =   375
      End
      Begin VB.CommandButton Command16 
         BackColor       =   &H0086C8EC&
         Caption         =   " ‰›Ì–"
         BeginProperty Font 
            Name            =   "Arabic Transparent"
            Size            =   9.75
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   465
         Left            =   2520
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   16
         Top             =   1080
         Width           =   735
      End
      Begin VB.CommandButton Command17 
         BackColor       =   &H0086C8EC&
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
         Left            =   1440
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   15
         Top             =   1080
         Width           =   735
      End
      Begin VB.Label Label41 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Â·  —Ìœ «·€«¡  Â–Â «·«” „«—…  (‰ / ﬂ) "
         BeginProperty Font 
            Name            =   "Arabic Transparent"
            Size            =   9.75
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Left            =   840
         RightToLeft     =   -1  'True
         TabIndex        =   18
         Top             =   360
         Width           =   2655
      End
   End
   Begin VB.CommandButton Command10 
      BackColor       =   &H002972B4&
      Caption         =   "«÷«›… "
      Height          =   375
      Left            =   10080
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   13
      Top             =   3240
      Width           =   735
   End
   Begin VB.CheckBox Check2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H0086C8EC&
      Caption         =   "«·ÿ·»«  «·€Ì— „‰Ã“…"
      Height          =   375
      Left            =   15360
      MaskColor       =   &H00D8F9FE&
      RightToLeft     =   -1  'True
      TabIndex        =   12
      Top             =   1080
      Width           =   1695
   End
   Begin VB.CheckBox Check1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H0086C8EC&
      Caption         =   "«·ÿ·»«  «·„‰Ã“…"
      Height          =   375
      Left            =   17520
      MaskColor       =   &H00D8F9FE&
      RightToLeft     =   -1  'True
      TabIndex        =   11
      Top             =   1080
      Width           =   1695
   End
   Begin MSDataGridLib.DataGrid DataGrid1 
      Bindings        =   "new_vdpreview.frx":017E
      Height          =   4095
      Left            =   0
      TabIndex        =   6
      ToolTipText     =   "«Œ Ì«—F1 / «·€«¡ «·«Œ Ì«— F2 /  ÕœÌœ «·„”«— F5"
      Top             =   4440
      Width           =   19575
      _ExtentX        =   34528
      _ExtentY        =   7223
      _Version        =   393216
      AllowUpdate     =   -1  'True
      BackColor       =   8833260
      HeadLines       =   1
      RowHeight       =   15
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
      ColumnCount     =   12
      BeginProperty Column00 
         DataField       =   "user_name"
         Caption         =   "«·„” Œœ„"
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
         DataField       =   "dmd_no"
         Caption         =   "—ﬁ„ «·ÿ·»"
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
         DataField       =   "dmd_ser"
         Caption         =   "«·„ ”·”·"
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
         DataField       =   "dmd_desc"
         Caption         =   "«·‘—Õ"
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
         DataField       =   "dmd_chek"
         Caption         =   "«·«Œ Ì«—"
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
         DataField       =   "dmd_mch_stock"
         Caption         =   "—ﬁ„ «·‘—Ìÿ"
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
         DataField       =   "dmd_in"
         Caption         =   "„‰  ÊﬁÌ "
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
         DataField       =   "dmd_out"
         Caption         =   "«·„œ…"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.00"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column08 
         DataField       =   "time_frm"
         Caption         =   "«·„œ…  "
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
         DataField       =   "mn_act_ttl"
         Caption         =   "«·⁄‰Ê«‰"
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
         DataField       =   "dmd_path"
         Caption         =   "«·„”«—"
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
         DataField       =   "dmd_dte"
         Caption         =   "«· «—ÌŒ"
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
         BeginProperty Column00 
            Object.Visible         =   -1  'True
            ColumnWidth     =   1200.189
         EndProperty
         BeginProperty Column01 
            ColumnWidth     =   915.024
         EndProperty
         BeginProperty Column02 
            ColumnWidth     =   915.024
         EndProperty
         BeginProperty Column03 
            Object.Visible         =   -1  'True
            ColumnWidth     =   3000.189
         EndProperty
         BeginProperty Column04 
            ColumnWidth     =   794.835
         EndProperty
         BeginProperty Column05 
            ColumnWidth     =   900.284
         EndProperty
         BeginProperty Column06 
            ColumnWidth     =   794.835
         EndProperty
         BeginProperty Column07 
            ColumnWidth     =   900.284
         EndProperty
         BeginProperty Column08 
            ColumnWidth     =   794.835
         EndProperty
         BeginProperty Column09 
            ColumnWidth     =   4004.788
         EndProperty
         BeginProperty Column10 
            Object.Visible         =   -1  'True
            ColumnWidth     =   4004.788
         EndProperty
         BeginProperty Column11 
            ColumnWidth     =   1005.165
         EndProperty
      EndProperty
   End
   Begin MSAdodcLib.Adodc view_demand 
      Height          =   375
      Left            =   7920
      Top             =   10560
      Width           =   2295
      _ExtentX        =   4048
      _ExtentY        =   661
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
      UserName        =   "sa"
      Password        =   ""
      RecordSource    =   "select demand.* from demand where dmd_no = 'kkkkkkk'"
      Caption         =   "view_demand"
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
   Begin VIDEOEDITLib.VideoEdit VideoEdit1 
      DragMode        =   1  'Automatic
      Height          =   1575
      Left            =   7080
      TabIndex        =   5
      Top             =   240
      Width           =   3975
      _Version        =   65536
      _ExtentX        =   7011
      _ExtentY        =   2778
      _StockProps     =   0
      VideoCompressor =   5
      AudioCompressor =   3
      OutputFileWidth =   720
      OutputFileHeight=   576
      FrameRate       =   25
      UseVideoCompressor=   -1  'True
      UseAudioCompressor=   -1  'True
      VideoSampleSize =   24
      EnumTransitions =   0   'False
      MPEGAudioSample =   48000
      LicenseKey      =   "10200"
      DvVideoEncoderParam=   1
      QTAudioComp     =   1
      QTVideoComp     =   1
      QTAudioChannels =   2
      QTAudioSampleRate=   48000
      SoundVolume     =   10
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   0
      Top             =   4800
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton Command9 
      BackColor       =   &H002972B4&
      Caption         =   "start"
      Height          =   375
      Left            =   9360
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   3240
      Width           =   735
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H002972B4&
      Caption         =   "in"
      Height          =   375
      Left            =   7080
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   2040
      Width           =   975
   End
   Begin VB.CommandButton Command2 
      BackColor       =   &H002972B4&
      Caption         =   "out"
      Height          =   375
      Left            =   9960
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   2160
      Width           =   975
   End
   Begin VB.CommandButton Command6 
      Height          =   375
      Left            =   3720
      Picture         =   "new_vdpreview.frx":0198
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   3960
      Width           =   375
   End
   Begin VB.CommandButton Command7 
      Height          =   375
      Left            =   3000
      Picture         =   "new_vdpreview.frx":053D
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   3960
      Width           =   375
   End
   Begin MSMask.MaskEdBox M_dmd_dte1 
      Height          =   375
      Left            =   15480
      TabIndex        =   7
      Top             =   600
      Width           =   1935
      _ExtentX        =   3413
      _ExtentY        =   661
      _Version        =   393216
      BackColor       =   14219774
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
   Begin MSMask.MaskEdBox M_dmd_dte 
      Height          =   375
      Left            =   17640
      TabIndex        =   8
      Top             =   600
      Width           =   1575
      _ExtentX        =   2778
      _ExtentY        =   661
      _Version        =   393216
      BackColor       =   14219774
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
   Begin MSRDC.MSRDC tmp 
      Height          =   450
      Left            =   3120
      Top             =   10440
      Visible         =   0   'False
      Width           =   1935
      _ExtentX        =   3413
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
      QueryTimeout    =   160
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
      Caption         =   "tmp"
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
      Left            =   -240
      Top             =   5400
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
   Begin MSRDC.MSRDC view_coding09 
      Height          =   330
      Left            =   -240
      Top             =   4440
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
      RecordSource    =   "select * from view_coding14"
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
   Begin MSRDC.MSRDC ranj 
      Height          =   375
      Left            =   1800
      Top             =   9840
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
   Begin VB.Label Label8 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E0E0E0&
      BackStyle       =   0  'Transparent
      Caption         =   "—ﬁ„ „·› «·›ÌœÌÊ "
      Height          =   255
      Left            =   17760
      TabIndex        =   52
      Top             =   2760
      Width           =   1575
   End
   Begin WMPLibCtl.WindowsMediaPlayer WindowsMediaPlayer1 
      Height          =   4455
      Left            =   0
      TabIndex        =   42
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
      _cy             =   7858
   End
   Begin VB.Label Label9 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E0E0E0&
      BackStyle       =   0  'Transparent
      Caption         =   "F5_· €Ì— «·„”«— «÷€ÿ"
      Height          =   255
      Left            =   9240
      TabIndex        =   37
      Top             =   5760
      Width           =   1935
   End
   Begin VB.Shape Shape2 
      Height          =   4095
      Left            =   6960
      Top             =   120
      Width           =   4215
   End
   Begin VB.Shape Shape1 
      Height          =   4215
      Left            =   11400
      Top             =   120
      Width           =   8175
   End
   Begin VB.Label Label6 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E0E0E0&
      BackStyle       =   0  'Transparent
      Caption         =   "«·„” Œœ„ :"
      Height          =   255
      Left            =   17880
      TabIndex        =   31
      Top             =   2400
      Width           =   1455
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E0E0E0&
      BackStyle       =   0  'Transparent
      Caption         =   "—ﬁ„ «·ÿ·» :"
      Height          =   255
      Left            =   17880
      TabIndex        =   27
      Top             =   2040
      Width           =   1335
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E0E0E0&
      BackStyle       =   0  'Transparent
      Caption         =   "«·‘—Õ "
      Height          =   255
      Left            =   10440
      TabIndex        =   22
      Top             =   2640
      Width           =   495
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E0E0E0&
      BackStyle       =   0  'Transparent
      Caption         =   "«·»ÕÀ      »«·‘—Õ "
      Height          =   255
      Left            =   18120
      TabIndex        =   20
      Top             =   1560
      Width           =   1335
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E0E0E0&
      BackStyle       =   0  'Transparent
      Caption         =   "«·Ï  «—ÌŒ «·ÿ·» :"
      Height          =   495
      Left            =   16200
      TabIndex        =   10
      Top             =   240
      Width           =   1215
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E0E0E0&
      BackStyle       =   0  'Transparent
      Caption         =   "„‰  «—ÌŒ «·ÿ·» :"
      Height          =   375
      Left            =   17640
      RightToLeft     =   -1  'True
      TabIndex        =   9
      Top             =   240
      Width           =   1335
   End
End
Attribute VB_Name = "new_vdpreview"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim M_NAM As String
Public strMode As String
Public iVideo1Width As Integer
Public iVideo2Width As Integer
Public iVideo3Width As Integer
Public iVideo1Height As Integer
Public iVideo2Height As Integer
Public iVideo3Height As Integer
Dim m_path As String

Dim m_streamstart As Double
Dim m_len_mch As Double
Dim m_dmd_ser As Integer
Dim clrTranColor
Dim clrGifTranColor
Dim clrTextColor
Dim clrTextBgColor
Dim crit1, CRIT, crit11, m_dmd_user_no As String
Dim qst1, qst2, qst3, qst4, qst5, qst6, qst7, qst8, qst9, m_disp, first_qst As Integer

'3 Modes START,STOP,PAUSE

Private Const WAIT_FAILED = -1&
Private Const WAIT_OBJECT_0 = 0
Private Const WAIT_ABANDONED = &H80&
Private Const WAIT_ABANDONED_0 = &H80&
Private Const WAIT_TIMEOUT = &H102&
Private Const INFINITE = &HFFFFFFFF       '  Infinite timeout
Private Const NORMAL_PRIORITY_CLASS = &H20
Private Const SYNCHRONIZE = &H100000
Private Declare Function GetWindowThreadProcessId Lib "user32" (ByVal hWnd As Long, lpdwProcessId As Long) As Long
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Private Declare Function WaitForInputIdle Lib "user32" (ByVal hProcess As Long, ByVal dwMilliseconds As Long) As Long
Private Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long
Private Declare Function WaitForSingleObject Lib "kernel32" (ByVal hHandle As Long, ByVal dwMilliseconds As Long) As Long
Private Declare Function OpenProcess Lib "kernel32" (ByVal dwDesiredAccess As Long, ByVal bInheritHandle As Long, ByVal dwProcessId As Long) As Long
Private Declare Function TerminateProcess Lib "kernel32" (ByVal hProcess As Long, ByVal uExitCode As Long) As Long


Private Declare Function GetLongPathName Lib "kernel32" Alias _
    "GetLongPathNameA" (ByVal lpszShortPath As String, _
    ByVal lpszLongPath As String, ByVal cchBuffer As Long) As Long

Const MAX_PATH = 260
''''
Private Declare Function GetShortPathName Lib _
"kernel32.dll" Alias "GetShortPathNameA" _
(ByVal lpszLongPath As String, ByVal lpszShortPath As String, _
ByVal cchBuffer As Long) As Long

Public Function ShortPathName(ByVal FileName As String)
 Dim shortname As String  ' receives short-filename equivalent
    Dim slength As Long  ' receives length of short-filename equivalent
    
    ' Make room in the buffer to receive the 8.3 form of the filename.
    shortname = Space(256)
    ' Get the 8.3 form of the filename specified.
    'the file must exist for the api to do it's stuff
    slength = GetShortPathName(FileName, shortname, 256)
    ' Remove the trailing null and display the result.
    shortname = Left(shortname, slength)
    ShortPathName = shortname
End Function

Public Function LongPathName(ByVal FileName As String) As String
    Dim length As Long, res As String
    On Error Resume Next
    
    res = String$(MAX_PATH, 0)
    length = GetLongPathName(FileName, res, Len(res))
    If length And Err = 0 Then
        LongPathName = Left$(res, length)
    End If
End Function




Private Function Red(ByVal Color As Long) As Integer
    Red = Color Mod &H100
End Function

'-->RETURNS THE GREEN COLOR VALUE
Private Function Green(ByVal Color As Long) As Integer
    Green = (Color \ &H100) Mod &H100
End Function

'-->RETURNS THE BLUE COLOR VALUE
Private Function Blue(ByVal Color As Long) As Integer
    Blue = (Color \ &H10000) Mod &H100
End Function

 
'3 Modes START,STOP,PAUSE



'Purpose   :    Shells a process synchronised i.e. Holds execution until application has closed.
'Inputs    :    sCommandLine        =   The Command line to run the application e.g. "Notepad.exe"
'               State               =   The Window State to run of the shelled program (A Long)
'Outputs   :    Returns the Process Handle
'Notes     :    Have noticed side effects. Other applications like Internet Explorer seem to be effected by this.

Function ShellAndHold(sCommandLine As String, Optional lState As Long = vbNormalFocus) As Long
    Dim FileToOpen As String
    
    'Check to see that the file exists
    If FileExists(sCommandLine) Then
        'Add double quotes around the path (otherwise you can't use spaces in the path)
        If Left$(sCommandLine, 1) <> Chr(34) Then
            sCommandLine = Chr(34) & sCommandLine
        End If
        If Right$(sCommandLine, 1) <> Chr(34) Then
            sCommandLine = sCommandLine & Chr(34)
        End If
    End If
    
    'Start the shell
    lRetVal = Shell(sCommandLine, lState)
    'Open the process
    ShellAndHold = OpenProcess(SYNCHRONIZE, False, lRetVal)
    
    m_max = ShellAndHold
   '  progress.m_tit.Text = "œ„Ã ﬂ· «·„‘«Âœ"
   '  progress.Show 1
    'Wait for the process to complete
    lRetVal = WaitForSingleObject(ShellAndHold, INFINITE)
    lRetVal = CloseHandle(ShellAndHold)
End Function



 













Private Sub Check1_Click()
If Check1.value = 1 Then
       qst4 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       crit1 = crit1 & "dmd_chek = 2"
      Command12.SetFocus
End If
End Sub

Private Sub Check2_Click()
If Check2.value = 1 Then
       qst5 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       crit1 = crit1 & "(dmd_chek <> 2 or dmd_chek IS NULL) "
      Command12.SetFocus
End If
 
End Sub

Private Sub Command1_Click()
If Not V_MCH_STOCK = 0 Then
On Error Resume Next

 
   'm_config_path1 = "\\192.168.1.101\backup\avi_high\"
   m_config_path1 = m_STCOK_path_new(V_MCH_STOCK, 1)
  ' m_config_path1 = "\\ar1storage\Archive_prog\programs_final\"
  'm_config_path = "\\av2storage\Archive_prog\progr_final\"
 
'If LEN_MCH(IND) <> 0 Or IND = 0 Then
IND = IND + 1
m_pos = WindowsMediaPlayer1.Controls.currentPosition
   STREAMSTART(IND) = m_pos
  m_streamstart = m_pos
ar_path(IND) = m_config_path1 + Trim(V_MCH_STOCK) + "." + v_mch_typ_high
m_path = m_config_path1 + Trim(V_MCH_STOCK) + "." + v_mch_typ_high
'End If
End If
'DataGrid1.SetFocus
End Sub

Private Sub Command10_Click()
 ' On Error Resume Next
 If Not m_dmd_desc.Text = "" Then
    m_desc = LTrim(m_dmd_desc.Text)
    m_len = Len(LTrim(m_dmd_desc.Text))
    i = 1
    m_desc1 = ""
   While i < m_len + 1
      m_char = Mid(m_desc, i, 1)
      If m_char = "'" Or m_char = Chr(34) Or m_char = Chr(39) Or m_char = Chr(10) Or m_char = Chr(13) Or m_char = "/" Or m_char = "?" Or m_char = "<" Or m_char = ">" Or m_char = "*" Or m_char = "\" Or m_char = "|" Or m_char = "ø" Or m_char = ":" Then
        m_desc1 = m_desc1 + " "
     Else
        m_desc1 = m_desc1 + Mid(m_desc, i, 1)
     End If
     i = i + 1
   Wend
   m_dmd_desc.Text = m_desc1
End If
 If Not V_MCH_STOCK = 0 Then
 m_time = m_len_mch
m_dmd_o = Int(m_time / 3600)
M_REST1 = m_time Mod 3600
m_dmd_m = Int(M_REST1 / 60)
m_dmd_s = M_REST1 Mod 60
m_dmd_f = 0
If m_dmd_ser = 0 Then
   m_date = Format(Date, "dd/mm/yyyy")
  sql = "exec op_demand "
  cn.Execute sql, rdExecDirect
  tmp.sql = "execute max_demand "
  tmp.Refresh
  m_dmd_no1 = tmp.Resultset![max_dmd_no]
  m_dmd_ser = 1
  sql = "execute upd_demand2 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_dmd_ser & "'" & "," _
                               & "'" & Format(m_date, "yyyy/mm/dd") & "'" & "," & "'" & box_user_no & "'" & "," _
                                & "'" & v_mch_no & "'" & "," & "'" & m_path & "'" & "," _
                                & "'" & m_streamstart & "'" & "," & "'" & m_len_mch & "'" & "," & "'" & V_MCH_STOCK & "'" & "," & "'" & m_dmd_desc.Text & "'" & "," _
                                 & "'" & m_dmd_s & "'" & "," & "'" & m_dmd_m & "'" & "," & "'" & m_dmd_o & "'" & "," & "'" & m_dmd_f & "'"
                                
      cn.Execute sql, rdExecDirect
  view_demand.Refresh
  
Else
m_dmd_no1 = view_demand.Recordset![dmd_no]
   tmp.sql = "execute max_demand_ser " & "'" & m_dmd_no1 & "'"
  tmp.Refresh
  m_dmd_ser = tmp.Resultset![max_dmd_ser]
  m_dmd_ser = m_dmd_ser + 1
  
   m_date = Format(Date, "dd/mm/yyyy")
   sql = "execute insr_demand1 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_dmd_ser & "'" & "," _
                               & "'" & Format(m_date, "yyyy/mm/dd") & "'" & "," & "'" & box_user_no & "'" & "," _
                                & "'" & v_mch_no & "'" & "," & "'" & m_path & "'" & "," _
                                & "'" & m_streamstart & "'" & "," & "'" & m_len_mch & "'" & "," & "'" & V_MCH_STOCK & "'" & "," & "'" & m_dmd_desc.Text & "'" & "," _
                                & "'" & m_dmd_s & "'" & "," & "'" & m_dmd_m & "'" & "," & "'" & m_dmd_o & "'" & "," & "'" & m_dmd_f & "'"
                                
      cn.Execute sql, rdExecDirect
       view_demand.Refresh
  
End If
End If
End Sub

Private Sub Command11_Click()
  M_dmd_dte.Enabled = True
  M_dmd_dte1.Enabled = True
  M_dmd_dte.Text = Format(Date, "dd/mm/yyyy")
  M_dmd_dte1.Text = Format(Date, "dd/mm/yyyy")
  
 'm_user_no.Enabled = True
 'm_user_no.Text = ""
 
Check2.value = False
Check1.value = False

qst1 = 0
qst2 = 0
qst3 = 0
qst4 = 0
qst5 = 0
qst5 = 0
qst8 = 0
qst6 = 0
m_dmd_no.Enabled = True
search_text.Text = ""
m_dmd_user_no = ""
m_dmd_no.Text = ""
m_mch_stock.Text = ""
If box_user_no = "244" Then
 m_disp = 0
 m_dmd_user.Text = ""
 m_disp = 1
 m_dmd_user.Enabled = True
 qst7 = 0
End If
search_text.Enabled = True
m_mch_stock.Enabled = True


m_typ_serh = 1


'M_art_dte.Text = Format(Date, "dd/mm/yy")
first_qst = 0
crit1 = ""
crit11 = ""
 CRIT = "create proc tmp_demand" + box_user_no + " as "
CRIT = CRIT & "SELECT   dbo.demand.dmd_mch_no, dbo.demand.dmd_no, dbo.demand.dmd_ser, dbo.demand.dmd_user, dbo.demand.dmd_dte, dbo.main.mn_act_ttl,rtrim(cast(dbo.demand.dmd_s as char))+ '  ' + rtrim(cast(dbo.demand.dmd_M as char))+ '  ' + rtrim(cast(dbo.demand.dmd_O as char)) as time_frm , " & _
                      " dbo.demand.dmd_in , dbo.demand.dmd_out, dbo.demand.dmd_path, dbo.demand.dmd_time, dbo.demand.dmd_desc, dbo.demand.dmd_chek, dbo.demand.dmd_mch_stock, dbo.config.user_name " & _
" FROM         dbo.demand left JOIN " & _
                     " dbo.main ON dbo.demand.dmd_mch_no = dbo.main.mn_app_no left join " & _
                     " dbo.config ON dbo.demand.dmd_user = dbo.config.user_no "

 If qst1 = 0 And Not M_dmd_dte.Text = "__/__/____" Then
  qst0 = 1
   If first_qst = 0 Then
        crit11 = " where "
        first_qst = 1
      Else
       crit11 = crit11 & " and "
      End If
     
     m_dte = Format(M_dmd_dte.Text, "yyyy/MM/dd")
     crit11 = crit11 & " ( dmd_dte >= " & "convert(datetime," & "'" & Format(m_dte, "yyyy-mm-dd") & "'" & "," & "102))"
   '  M_dmd_dte.Enabled = False
End If
 If qst2 = 0 And Not M_dmd_dte1.Text = "__/__/____" Then
  qst1 = 1
 If first_qst = 0 Then
        crit11 = " where "
        first_qst = 1
      Else
       crit11 = crit11 & " and "
      End If
     
     m_dte1 = Format(M_dmd_dte1.Text, "yyyy/MM/dd")
     crit11 = crit11 & " ( dmd_dte <= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102))"
   '  M_dmd_dte1.Enabled = False
End If
                     
If Not box_user_no = "244" Then
   first_qst = 1
  qst7 = 1
    m_disp = 0
      crit1 = " AND   dmd_user =  " & "'" & box_user_no & "'"
      m_dmd_user.Text = box_user_name
      m_disp = 1
       m_dmd_user.Enabled = False
  End If
'If first_qst > 0 Then
  crit2 = CRIT & crit11 & crit1 & " order by dmd_no desc"
  ''& " order by art_dte"
'    MsgBox crit2
       sql = "drop proc tmp_demand" + box_user_no
       cn.Execute sql, rdExecDirect
       cn.Execute crit2, rdExecDirect
       Screen.MousePointer = vbHourglass
       view_demand.RecordSource = "execute tmp_demand" + box_user_no
       view_demand.Refresh
       DataGrid1.Refresh
       
      Screen.MousePointer = vbDefault
' Else
'      MsgBox "ÌÃ» ÿ—Õ «·”ƒ«· «Ê·«....."
'End If
 
 
'if box_user_start = 1 Then
'view_demand.RecordSource = "execute proc_demand1 " & "'" & Format(v_adte, "yyyy/mm/dd") & "'" & "," _
                                & "'" & Format(v_adte1, "yyyy/mm/dd") & "'"

'Else
'view_demand.RecordSource = "execute proc_demand " & "'" & Format(v_adte, "yyyy/mm/dd") & "'" & "," _
'                                & "'" & Format(v_adte1, "yyyy/mm/dd") & "'" & "," & "'" & box_user_no & "'"
'         End If
'view_demand.Refresh
  If Not view_demand.Recordset.EOF Or Not view_demand.Recordset.EOF Then
   Else
     m_dmd_ser = 0
  End If
  DataGrid1.SetFocus
                     

End Sub

Private Sub Command12_Click()
 
 'If qst1 = 0 And Not M_dmd_dte.Text = "__/__/____" Then
 ' qst1 = 1
 'If first_qst = 0 Then
 '       crit1 = " where "
 '       first_qst = 1
 '     Else
 '      crit1 = crit1 & " and "
 '     End If
 '
 '    m_dte = Format(M_dmd_dte.Text, "yyyy/MM/dd")
 '    crit1 = crit1 & " ( dmd_dte >= " & "convert(datetime," & "'" & Format(m_dte, "yyyy-mm-dd") & "'" & "," & "102))"
 '    M_dmd_dte.Enabled = False
'End If
' If qst2 = 0 And Not M_dmd_dte1.Text = "__/__/____" Then
'  qst2 = 1
'' If first_qst = 0 Then
''        crit1 = " where "
'        first_qst = 1
'      Else
'       crit1 = crit1 & " and "
'      End If
'
'     m_dte1 = Format(M_dmd_dte1.Text, "yyyy/MM/dd")
'     crit1 = crit1 & " ( dmd_dte <= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102))"
 '    M_dmd_dte1.Enabled = False
''End If
If qst5 = 0 And Not search_text.Text = "" Then
  qst5 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      sw_desc = LTrim(search_text.Text)
       If k > 1 Then
         crit1 = crit1 & " and "
       End If
        crit1 = crit1 & "dmd_desc + mn_act_ttl" & " like " & "'" & "%" & sw_desc & "%" & "'"
     search_text.Enabled = False
    Command12.SetFocus
 End If
 If qst6 = 0 And Not m_dmd_no.Text = "" Then
    v_prs_no = "0000000"
     m_no = m_dmd_no.Text
     v_prs_no = Mid(v_prs_no, 1, 7 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
     m_dmd_no.Text = v_prs_no
       qst6 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       crit1 = crit1 & "dmd_no  = " & "'" & m_dmd_no.Text & "'"
       m_dmd_no.Enabled = False
        Command12.SetFocus

End If

  If qst7 = 0 And Not m_dmd_user.Text = "" Then
    qst7 = 1
    If first_qst = 0 Then
         crit1 = " where "
         first_qst = 1
     Else
        crit1 = crit1 & " and "
    End If
      crit1 = crit1 & "dmd_user =  " & "'" & m_dmd_user_no & "'"
       m_dmd_user.Enabled = False
    End If
If qst8 = 0 And Not m_mch_stock.Text = "" Then
  qst8 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      sw_desc = LTrim(m_mch_stock.Text)
       If k > 1 Then
         crit1 = crit1 & " and "
       End If
        crit1 = crit1 & "dmd_mch_stock " & " like " & "'" & "%" & sw_desc & "%" & "'"
     m_mch_stock.Enabled = False
 End If
If first_qst > 0 Then
  crit2 = CRIT & crit11 & crit1 & " order by dmd_no desc"
  ''& " order by art_dte"
'    MsgBox crit2
       sql = "drop proc tmp_demand" + box_user_no
       cn.Execute sql, rdExecDirect
       cn.Execute crit2, rdExecDirect
       Screen.MousePointer = vbHourglass
       view_demand.RecordSource = "execute tmp_demand" + box_user_no
       view_demand.Refresh
       DataGrid1.Refresh
       
      Screen.MousePointer = vbDefault
 Else
      MsgBox "ÌÃ» ÿ—Õ «·”ƒ«· «Ê·«....."
End If

End Sub

Private Sub Command14_Click()
If Not V_MCH_STOCK = 0 Then
 

 m_time = Val(v_mch_s) + Val(v_mch_m) * 60 + Val(v_mch_o) * 3600
 m_time1 = Val(v_mch_s1) + Val(v_mch_m1) * 60 + Val(v_mch_o1) * 3600
 m_streamstart = m_time
  m_config_path1 = m_STCOK_path_new(V_MCH_STOCK, 1)
 m_path = m_config_path1 + Trim(V_MCH_STOCK) + ".avi"
  m_len_mch = m_time1 - m_streamstart
m_dmd_desc = Str(V_MCH_STOCK) + " _ " + Mid(v_mch_tit, 1, 50)
'End If
m_time = m_len_mch
m_dmd_o = Int(m_time / 3600)
M_REST1 = m_time Mod 3600
m_dmd_m = Int(M_REST1 / 60)
m_dmd_s = M_REST1 Mod 60
m_dmd_f = 0
If Not m_dmd_desc.Text = "" Then
    m_desc = LTrim(m_dmd_desc.Text)
    m_len = Len(LTrim(m_dmd_desc.Text))
    i = 1
    m_desc1 = ""
   While i < m_len + 1
      m_char = Mid(m_desc, i, 1)
     If m_char = "'" Or m_char = Chr(34) Or m_char = Chr(39) Or m_char = Chr(10) Or m_char = Chr(13) Or m_char = "/" Or m_char = "?" Or m_char = "<" Or m_char = ">" Or m_char = "*" Or m_char = "\" Or m_char = "|" Or m_char = "ø" Or m_char = ":" Then
        m_desc1 = m_desc1 + " "
     Else
        m_desc1 = m_desc1 + Mid(m_desc, i, 1)
     End If
     i = i + 1
   Wend
   m_dmd_desc.Text = m_desc1
End If
If m_dmd_ser = 0 Then
   m_date = Format(Date, "dd/mm/yyyy")
  sql = "exec op_demand "
  cn.Execute sql, rdExecDirect
  tmp.sql = "execute max_demand "
  tmp.Refresh
  m_dmd_no1 = tmp.Resultset![max_dmd_no]
  m_dmd_ser = 1
  sql = "execute upd_demand2 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_dmd_ser & "'" & "," _
                               & "'" & Format(m_date, "yyyy/mm/dd") & "'" & "," & "'" & box_user_no & "'" & "," _
                                & "'" & v_mch_no & "'" & "," & "'" & m_path & "'" & "," _
                                & "'" & m_streamstart & "'" & "," & "'" & m_len_mch & "'" & "," & "'" & V_MCH_STOCK & "'" & "," & "'" & m_dmd_desc.Text & "'" & "," _
                                 & "'" & m_dmd_s & "'" & "," & "'" & m_dmd_m & "'" & "," & "'" & m_dmd_o & "'" & "," & "'" & m_dmd_f & "'"
                                
      cn.Execute sql, rdExecDirect
  view_demand.Refresh
  
Else
m_dmd_no1 = view_demand.Recordset![dmd_no]
   tmp.sql = "execute max_demand_ser " & "'" & m_dmd_no1 & "'"
  tmp.Refresh
  m_dmd_ser = tmp.Resultset![max_dmd_ser]
  m_dmd_ser = m_dmd_ser + 1
  
   m_date = Format(Date, "dd/mm/yyyy")
   sql = "execute insr_demand1 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_dmd_ser & "'" & "," _
                               & "'" & Format(m_date, "yyyy/mm/dd") & "'" & "," & "'" & box_user_no & "'" & "," _
                                & "'" & v_mch_no & "'" & "," & "'" & m_path & "'" & "," _
                                & "'" & m_streamstart & "'" & "," & "'" & m_len_mch & "'" & "," & "'" & V_MCH_STOCK & "'" & "," & "'" & m_dmd_desc.Text & "'" & "," _
                                & "'" & m_dmd_s & "'" & "," & "'" & m_dmd_m & "'" & "," & "'" & m_dmd_o & "'" & "," & "'" & m_dmd_f & "'"
                                
      cn.Execute sql, rdExecDirect
       view_demand.Refresh
  
End If
End If
End Sub

Private Sub Command15_Click()
Dim nb_rec As Integer
Dim som_out As Double


If view_demand.Recordset.EOF Then
  MsgBox "·«ÌÊÃœ „ﬁ«·«  ·Â–« «·”ƒ«·"
Else
  view_demand.Recordset.MoveFirst
 ' m_code = DataGrid1.Columns(0)
  
  nb_rec = 0
  While Not view_demand.Recordset.EOF
''     If m_code = result.recordset![mch_no] Then
''     Else
       nb_rec = nb_rec + 1
       som_out = som_out + view_demand.Recordset![dmd_out]
''     End If
  ''    m_code = result.recordset![mch_no]
      view_demand.Recordset.MoveNext
   Wend
     view_demand.Recordset.MoveFirst
     m_time = som_out
m_dmd_o = Int(m_time / 3600)
M_REST1 = m_time Mod 3600
m_dmd_m = Int(M_REST1 / 60)
m_dmd_s = M_REST1 Mod 60
  MsgBox "⁄œœ «·„ﬁ«·«  = " & nb_rec & " «·„œ… «·«Ã„«·Ì… : " & m_dmd_o & ":" & m_dmd_m & ":" & m_dmd_s
End If

End Sub

Private Sub Command16_Click()
    Dim sql As String
 If M_YESNO.Text = "‰" Or M_YESNO.Text = "y" Or M_YESNO.Text = "Y" Then
   m_dmd_no1 = DataGrid1.Columns(1)
   m_dmd_ser1 = DataGrid1.Columns(2)
    If Not IsNull(view_demand.Recordset![dmd_chek]) Then
     m_chek = view_demand.Recordset![dmd_chek]
  End If
  If m_chek <> 2 Then

    sql = "exec del_demand" & "'" & m_dmd_no1 & "'" & "," & "'" & m_dmd_ser1 & "'"
    
     cn.Execute sql, rdExecDirect
     view_demand.Refresh
     
End If
Frame6.Visible = False
     DataGrid1.SetFocus
     
     End If
End Sub

Private Sub Command17_Click()
 view_demand.Refresh
 Frame6.Visible = False
     DataGrid1.SetFocus
    
End Sub

Private Sub Command18_Click()
If DataGrid1.Columns(4) = 1 Then
   m_no = DataGrid1.Columns(1)
   m_ser = DataGrid1.Columns(2)
   m_stock = DataGrid1.Columns(5)
   m_stock = Mid("00000", 1, 6 - Len(Trim(m_stock))) + Trim(Str(m_stock))
   m_path = m_view_path.Text + m_stock + ".avi"
  sql = "execute upd_path " & "'" & m_no & "'" & "," & "'" & m_ser & "'" & "," _
                             & "'" & m_path & "'"
                             cn.Execute sql, rdExecDirect
 End If
 Frame1.Visible = False
 view_demand.Refresh
 DataGrid1.SetFocus
 
End Sub

Private Sub Command19_Click()
On Error Resume Next
 Dim m_txt_no As String
m_txt_no = ""
 

 i = 1
stretchmode = 2
view_demand.Recordset.MoveFirst
i = 0

While Not view_demand.Recordset.EOF

  If Check3.value = 1 Then
'   v_nam = v_NAME + ".AVI"
  Else
    v_nam = v_name + Trim(view_demand.Recordset![dmd_desc]) + Trim(Str(view_demand.Recordset![dmd_ser])) + ".avi"
   End If
 m_name1 = Trim(view_demand.Recordset![dmd_desc])
 V_PATH = Trim(view_demand.Recordset![dmd_path])
 v_stream = view_demand.Recordset![dmd_in]
 v_len_mch = view_demand.Recordset![dmd_out]
 m_dmd_mch_stock = view_demand.Recordset![dmd_mch_stock]
   m_chek = 0
  If Not IsNull(view_demand.Recordset![dmd_chek]) Then
     m_chek = view_demand.Recordset![dmd_chek]
  End If
  If m_chek = 1 Then

 M_NAM = ""
 'if merge number of image/video, you need found max width and height
 
 iMaxWidth = 0
 iMaxHeight = 0
'For i = 1 To IND
' If VideoEdit1.IsFileExisting Then
M_NAM = V_PATH
If Dir(M_NAM) <> "" Then
 idur = Round(VideoEdit1.GetFileDuration(V_PATH), 2)

If idur <> 0 Then
Else
  m_txt_no = m_txt_no + Str(m_dmd_mch_stock) + " , "

End If
Else
  m_txt_no = m_txt_no + Str(m_dmd_mch_stock) + " , "
End If
End If
    view_demand.Recordset.MoveNext
'    i = i + 1
Wend
view_demand.Refresh

 If m_txt_no = "" Then
  MsgBox "Ã„Ì⁄ «·„‘«Âœ „ÊÃÊœ…..."
Else
 MsgBox "«—ﬁ«„ «·«‘—ÿ… «· Ì ·«  ‰›– : " & m_txt_no
End If

End Sub

Private Sub Command2_Click()

On Error Resume Next
If Not V_MCH_STOCK = 0 Then
'If STREAMSTART(IND) <> 0 Then
 LEN_MCH(IND) = WindowsMediaPlayer1.Controls.currentPosition
 LEN_MCH(IND) = LEN_MCH(IND) - STREAMSTART(IND)
 m_len_mch = WindowsMediaPlayer1.Controls.currentPosition - m_streamstart
 m_dmd_desc.SetFocus
 End If

'End If
'DataGrid1.SetFocus

End Sub

Private Sub Command13_Click()
' Dim var_temp, VAR_TEMP1 As Variant
'On Error Resume Next
'' m_mch_stock = view_res.result.Recordset![mch_stock]
' auto_no = 0
' STARTTIME = 0
'
''  PATH_nam = m_config_path + Trim(m_mch_stock) + ".avi"
' var_temp = Chr(34) + "ID" + Chr(34) + ";" + Chr(34) + "Track" + Chr(34) + ";" + Chr(34) + "StartTime" + Chr(34) + ";" + Chr(34) + "Length" + Chr(34) + ";" + Chr(34) + "PlayRate" + Chr(34) + ";" + Chr(34) + "Locked" + Chr(34) + _
 ";" + Chr(34) + "Normalized" + Chr(34) + ";" + Chr(34) + "StretchMethod" + Chr(34) + ";" + Chr(34) + "Looped" + Chr(34) + ";" + Chr(34) + "OnRuler" + Chr(34) + ";" + Chr(34) + "MediaType" + Chr(34) + ";" + Chr(34) + "FileName" + Chr(34) + ";" + Chr(34) + "Stream" + _
 Chr(34) + ";" + Chr(34) + "StreamStart" + Chr(34) + ";" + Chr(34) + "StreamLength" + Chr(34) + ";" + Chr(34) + "FadeTimeIn" + Chr(34) + ";" + Chr(34) + "FadeTimeOut" + Chr(34) + ";" + Chr(34) + "SustainGain" + Chr(34) + ";" + Chr(34) + "CurveIn" + Chr(34) + ";" + Chr(34) + "GainIn" + Chr(34) + _
 ";" + Chr(34) + "CurveOut" + Chr(34) + ";" + Chr(34) + "GainOut" + Chr(34) + ";" + Chr(34) + "Layer" + Chr(34) + ";" + Chr(34) + "Color" + Chr(34) + ";" + Chr(34) + "CurveInR" + Chr(34) + ";" + Chr(34) + "CurveOutR" + Chr(34) + ";" + Chr(34) + "PlayPitch" + Chr(34) + ";" + Chr(34) + "LockPitch" + Chr(34)
' ar_temp = text1.Text
 'M_NAM1 = "\\arstorage\hires\mash\" & Trim(m_nam_file.Text) & ".txt"
'  M_NAM1 = "\\ar2storage\ar2highres\mash\" & Trim(m_nam_file.Text) & ".txt"
'  Open M_NAM1 For Output As #1
'
'   Print #1, var_temp
'  For i = 1 To IND
'   auto_no = auto_no + 1
'     VAR_TEMP1 = LTrim(Str(auto_no)) & ";" & "    1;" & Str(STARTTIME) & ";" & Str(LEN_MCH(i)) & ";" & "    1.000000;    FALSE;    FALSE;    0;    TRUE;    FALSE;    VIDEO;" & Chr(34) & ar_path(i) & Chr(34) & ";   0;" & Str(STREAMSTART(i)) & ";" & Str(LEN_MCH(i)) & ";  0.0000;    0.0000;    1.000000;    4;    0.000000;    4;    0.000000;    0;    -1;    4;    4;    0.000000;    FALSE "
'     STARTTIME = STARTTIME + LEN_MCH(i)
'     Print #1, VAR_TEMP1
'  Next i
'  STARTTIME = 0
'   For i = 1 To IND
'   auto_no = auto_no + 1
'     var_temp2 = LTrim(Str(auto_no)) & ";" & "    0;" & Str(STARTTIME) & ";" & Str(LEN_MCH(i)) & ";" & "    1.000000;    FALSE;    FALSE;    0;    TRUE;    FALSE;    AUDIO;" & Chr(34) & ar_path(i) & Chr(34) & ";   0;" & Str(STREAMSTART(i)) & ";" & Str(LEN_MCH(i)) & ";  10.0000;    10.0000;    1.000000;    2;    0.000000;    -2;    0.000000;    0;    -1;    -2;    2;    0.000000;    FALSE "
'        STARTTIME = STARTTIME + LEN_MCH(i)
'     Print #1, var_temp2
'  Next i
'   Close #1
'   DataGrid1.SetFocus
Frame1.Visible = False
End Sub

Private Sub Command20_Click()

 CRIT6 = "create proc tmp_demand_print " + " as "
CRIT6 = CRIT6 & "SELECT   dbo.demand.dmd_mch_no, dbo.demand.dmd_no, dbo.demand.dmd_ser, dbo.demand.dmd_user, dbo.demand.dmd_dte, dbo.main.mn_act_ttl,rtrim(cast(dbo.demand.dmd_s as char))+ '  ' + rtrim(cast(dbo.demand.dmd_M as char))+ '  ' + rtrim(cast(dbo.demand.dmd_O as char)) as time_frm , " & _
                      " dbo.demand.dmd_in , dbo.demand.dmd_out, dbo.demand.dmd_path, dbo.demand.dmd_time, dbo.demand.dmd_desc, dbo.demand.dmd_chek, dbo.demand.dmd_mch_stock, dbo.config.user_name " & _
" FROM         dbo.demand left JOIN " & _
                     " dbo.main ON dbo.demand.dmd_mch_no = dbo.main.mn_app_no left join " & _
                     " dbo.config ON dbo.demand.dmd_user = dbo.config.user_no "
  crit2 = CRIT6 & crit11 & crit1 & " order by dmd_no desc"
  ''& " order by art_dte"
'    MsgBox crit2
       sql = "drop proc tmp_demand_print "
       cn.Execute sql, rdExecDirect
       cn.Execute crit2, rdExecDirect
  jad_print = 10
 Screen.MousePointer = vbDefault
  Screen.MousePointer = vbHourglass
  form_report.WindowState = 2
  form_report.Show
  Screen.MousePointer = vbDefault

End Sub

Private Sub Command4_Click()
 On Error Resume Next
Dim lg As Boolean
Dim m_txt_no, X, v, dest As String
Dim v_name As String
v_name = ""

m_txt_no = ""
lg = False

lg_stop = True
CommonDialog1.CancelError = True
Err.Clear
CommonDialog1.Filter = strFilter
CommonDialog1.ShowSave
If Err.Number = 0 Then
   ' result = Me.VideoEdit1.Save(CommonDialog1.FileName)

Dim ar_path(20), v_nam As String
Dim aR_STREAM(20) As Double
Dim ar_mch(20) As Double
i = 1
nb_copy = 1
v_name = CommonDialog1.FileName
v1_path = PathFileToPath(v_name)
v1_name = nameFileToPath(v_name)
 v_name = ShortPathName(v1_path) + v1_name
stretchmode = 2
view_demand.Recordset.MoveFirst
i = 1
 While Not view_demand.Recordset.EOF And lg_stop
   V_PATH = Trim(view_demand.Recordset![dmd_path])
   V_EXT = Mid(V_PATH, Len(V_PATH) - 3, 4)
'  If Check3.value = 1 Then
'   v_nam = v_NAME + ".AVI"
'  Else
   ' v_nam =  v_name + Trim(view_demand.Recordset![dmd_desc]) + " Clip " + Trim(Str(view_demand.Recordset![dmd_ser])) + ".avi"

    v_nam = v_name + "_" + LTrim(Str(i)) + V_EXT
    ' v_nam = V_NAME + Trim(view_demand.Recordset![dmd_desc]) + " Clip " + Trim(Str(view_demand.Recordset![dmd_ser])) + v_ext
    
'   End If
  If Check3.value = 1 Then
    k = 1
    While FileExists(v_nam)
        v_nam = v_name + "_" + LTrim(Str(k)) + "_" + LTrim(Str(i)) + V_EXT
       k = k + 1
     Wend
 End If
 m_name1 = Trim(view_demand.Recordset![dmd_desc])

 
 v_stream = view_demand.Recordset![dmd_in]
 v_len_mch = view_demand.Recordset![dmd_out]
 m_dmd_mch_stock = view_demand.Recordset![dmd_mch_stock]
   m_chek = 0
  If Not IsNull(view_demand.Recordset![dmd_chek]) Then
     m_chek = view_demand.Recordset![dmd_chek]
  End If
  
 
m_time = v_stream
M_O = Int(m_time / 3600)
M_REST1 = m_time Mod 3600
m_m = Int(M_REST1 / 60)
m_s = M_REST1 Mod 60
v_o = LTrim(Str(M_O))
v_m = LTrim(Str(m_m))
v_s = LTrim(Str(m_s))
If Len(LTrim(v_o)) < 2 Then
 v_o = "0" + LTrim(v_o)
End If

If Len(LTrim(v_m)) < 2 Then
 v_m = "0" + LTrim(v_m)
End If
If Len(LTrim(v_s)) < 2 Then
 v_s = "0" + LTrim(v_s)
End If

m_time1 = v_len_mch
M_O1 = Int(m_time1 / 3600)
M_REST1 = m_time1 Mod 3600
m_m1 = Int(M_REST1 / 60)
m_s1 = M_REST1 Mod 60

v_o1 = LTrim(Str(M_O1))
v_m1 = LTrim(Str(m_m1))
v_s1 = LTrim(Str(m_s1))
If Len(LTrim(v_o1)) < 2 Then
 v_o1 = "0" + LTrim(v_o1)
End If

If Len(LTrim(v_m1)) < 2 Then
 v_m1 = "0" + LTrim(v_m1)
End If
If Len(LTrim(v_s1)) < 2 Then
 v_s1 = "0" + LTrim(v_s1)
End If
time_code = " -ss " + v_o + ":" + v_m + ":" + v_s + " "
time_code1 = " -t " + v_o1 + ":" + v_m1 + ":" + v_s1 + " "
'time_code = " -ss " + Str(m_time) + " "
'time_code1 = " -t " + Str(m_time1) + " "



If m_chek = 1 Then

 M_NAM = ""
 'if merge number of image/video, you need found max width and height
 
 iMaxWidth = 0
 iMaxHeight = 0
'For i = 1 To IND
' If VideoEdit1.IsFileExisting Then
Dim lg1 As Boolean

M_NAM = V_PATH
If Dir(M_NAM) <> "" Then
 ' idur = Round(VideoEdit1.GetFileDuration(V_PATH), 2)
   lg1 = True
  If V_EXT = ".AVI" Or V_EXT = ".avi" Then
   lg1 = False
  End If
'  If idur <> 0 Or lg1 Then
  i = i + 1
X = "c:\ffmpeg " + time_code + " -i " + V_PATH + " -acodec copy  " + " -vcodec copy  " + time_code1 + v_nam
' X = "ffmpeg " + time_code + " -i " + V_PATH + " -ss 0 " + " -acodec copy  " + " -vcodec copy  " + time_code1 + v_nam
  
'  X = "ffmpeg " + time_code + " -i " + V_PATH + " -c copy  " + time_code1 + v_nam
 Dim sCommandLine As String
Dim FileToOpen As String
sCommandLine = X


' X1 = ShellAndHold(x, 0)
    'Check to see that the file exists
    If FileExists(sCommandLine) Then
        'Add double quotes around the path (otherwise you can't use spaces in the path)
        If Left$(sCommandLine, 1) <> Chr(34) Then
            sCommandLine = Chr(34) & sCommandLine
        End If
        If Right$(sCommandLine, 1) <> Chr(34) Then
            sCommandLine = sCommandLine & Chr(34)
        End If
    End If
    
    'Start the shell
    lRetVal = Shell(sCommandLine, vbHide)
    'lState)
    'Open the process
    m_max = OpenProcess(SYNCHRONIZE, False, lRetVal)
    
     m_tit1.Text = m_name1
     m_tit1.Refresh
    ProgressBar1.Max = m_max * 2500
    v_max = m_max * 2500
    For j = 1 To v_max
      ProgressBar1.value = j
    Next j
     
    'Wait for the process to complete
    
    lRetVal = WaitForSingleObject(m_max, INFINITE)
    lRetVal = CloseHandle(m_max)
     nb_copy = nb_copy + 1
     nb_copy.Refresh
     
 
     If FileExists(v_nam) Then
  
       '  progress.m_tit.Text = m_name1
       ' progress.Show 1
    
       m_dmd_no1 = DataGrid1.Columns(1)
       m_ser = DataGrid1.Columns(2)
       m_dmd_chek = 2
       sql = "execute upd_demand1 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_ser & "'" & "," _
              & "'" & m_dmd_chek & "'"
              
       cn.Execute sql, rdExecDirect
       If Check3.value = 1 Then
         
       Else
    Source = v_nam
    dest = v_name + Trim(view_demand.Recordset![dmd_desc]) + " Clip " + Trim(Str(view_demand.Recordset![dmd_ser])) + V_EXT
      k = 1
     While FileExists(dest)
       dest = v_name + LTrim(Str(k)) + "_" + Trim(view_demand.Recordset![dmd_desc]) + " Clip " + Trim(Str(view_demand.Recordset![dmd_ser])) + V_EXT
      k = k + 1
     Wend
    Name Source As dest
  End If
 Else
  m_txt_no = m_txt_no + Str(m_dmd_mch_stock) + " , "
 End If
Else
  m_txt_no = m_txt_no + Str(m_dmd_mch_stock) + " , "
End If
End If
    view_demand.Recordset.MoveNext
'    i = i + 1
Wend
End If
view_demand.Refresh
If m_txt_no = "" Then
  MsgBox "«‰ Â  ⁄„·Ì… «·‰”Œ..."
Else
 MsgBox "«—ﬁ«„ «·«‘—ÿ… «· Ì ·„  ‰›– : " & m_txt_no
End If

End Sub
Private Sub Command5_Click()
 Dim v_nam  As String
Dim v_name  As String
Dim m_txt_no As String

On Error Resume Next

lg_stop = True
CommonDialog1.CancelError = True
Err.Clear
CommonDialog1.Filter = strFilter
CommonDialog1.ShowSave
If Err.Number = 0 Then
v_name = CommonDialog1.FileName
v1_path = PathFileToPath(v_name)
v1_name = nameFileToPath(v_name)
 v_name = ShortPathName(v1_path) + v1_name
While Not view_demand.Recordset.EOF And lg_stop

  If Check3.value = 1 Then
    V_PATH = Trim(view_demand.Recordset![dmd_path])
    V_EXT = Mid(V_PATH, Len(V_PATH) - 3, 4)
    v_nam = v_name + "_" + LTrim(Str(i)) + V_EXT
'   v_nam = v_NAME + ".AVI"
    k = 1
    While FileExists(v_nam)
        v_nam = v_name + "_" + LTrim(Str(k)) + "_" + LTrim(Str(i)) + V_EXT
       k = k + 1
     Wend

  Else
   V_PATH = Trim(view_demand.Recordset![dmd_path])
    V_EXT = Mid(V_PATH, Len(V_PATH) - 3, 4)
    v_nam = v_name + Trim(view_demand.Recordset![dmd_desc]) + " Clip " + Trim(Str(view_demand.Recordset![dmd_ser])) + V_EXT
   End If
   m_chek = 0
  If Not IsNull(view_demand.Recordset![dmd_chek]) Then
     m_chek = view_demand.Recordset![dmd_chek]
  End If
  m_dmd_mch_stock = view_demand.Recordset![dmd_mch_stock]
If m_chek = 1 Then
  M_NAM = V_PATH
  idur = 0
  If V_EXT = ".avi" Or V_EXT = ".AVI" Then
    idur = Round(VideoEdit1.GetFileDuration(V_PATH), 2)
   Else
   idur = 1
  End If
 If idur <> 0 Then
If Dir(M_NAM) <> "" Then
 
    m_tit1.Text = m_name1
     m_tit1.Refresh
    ProgressBar1.Max = 2500
    v_max = 2500
    For j = 1 To v_max
      ProgressBar1.value = j
    Next j
    FileCopy V_PATH, v_nam
     
 If FileLen(M_NAM) <> 0 Then
    m_dmd_no1 = DataGrid1.Columns(1)
    m_ser = DataGrid1.Columns(2)
    m_dmd_chek = 2
    sql = "execute upd_demand1 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_ser & "'" & "," _
            & "'" & m_dmd_chek & "'"
      cn.Execute sql, rdExecDirect
 Else
    m_txt_no = m_txt_no + Str(m_dmd_mch_stock) + " , "
 End If
Else
    m_txt_no = m_txt_no + Str(m_dmd_mch_stock) + " , "
 End If
  Else
     m_txt_no = m_txt_no + Str(m_dmd_mch_stock) + " , "
 End If
 End If
     view_demand.Recordset.MoveNext
Wend
End If
If m_txt_no = "" Then
  MsgBox "«‰ Â  ⁄„·Ì… «·‰”Œ..."
Else
 MsgBox "«—ﬁ«„ «·«‘—ÿ… «· Ì ·„  ‰›– : " & m_txt_no
End If
view_demand.Refresh


 
 
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
If Not m_view_path.Text = "" Then
view_demand.Recordset.MoveFirst
While Not view_demand.Recordset.EOF
If view_demand.Recordset![dmd_chek] = 1 Then
   m_no = view_demand.Recordset![dmd_no]
   m_ser = view_demand.Recordset![dmd_ser]
   m_stock = view_demand.Recordset![dmd_mch_stock]
   m_stock = Mid("00000", 1, 6 - Len(Trim(m_stock))) + Trim(Str(m_stock))
   m_path = m_view_path.Text + m_stock + ".avi"
  sql = "execute upd_path " & "'" & m_no & "'" & "," & "'" & m_ser & "'" & "," _
                             & "'" & m_path & "'"
                             cn.Execute sql, rdExecDirect
 End If
 view_demand.Recordset.MoveNext
 Wend
End If
Frame1.Visible = False
 view_demand.Refresh
 DataGrid1.SetFocus
 
 End Sub

Private Sub Command6_Click()
On Error Resume Next
'WindowsMediaPlayer1.Controls.FileName = m_nam
'm_tm = m_tm + m_step.Text
'WindowsMediaPlayer1.Controls.Pause

'WindowsMediaPlayer1.Controls.SelectionStart = m_tm
'WindowsMediaPlayer1.Controls.SelectionEnd = WindowsMediaPlayer1.Controls.Duration
'WindowsMediaPlayer1.Controls.Play
'WmpCurPos = WindowsMediaPlayer1.Controls.CurrentPosition
   
If WindowsMediaPlayer1.Controls.currentPosition > m_tm Then
 m_tm = WindowsMediaPlayer1.Controls.currentPosition
End If

    m_tm = m_tm + Val(m_step.Text)
    WindowsMediaPlayer1.Controls.currentPosition = m_tm
'If WindowsMediaPlayer1.Controls.CurrentPosition = WindowsMediaPlayer1.Controls.Duration Then
'    WindowsMediaPlayer1.Controls.CurrentPosition = 0
    WindowsMediaPlayer1.Controls.Pause
'    WindowsMediaPlayer1.Controls.Play
'End If
    WindowsMediaPlayer1.Controls.Play

End Sub

Private Sub Command6_KeyPress(KeyAscii As Integer)
On Error Resume Next
'WindowsMediaPlayer1.Controls.FileName = m_nam
'm_tm = m_tm + m_step.Text
'WindowsMediaPlayer1.Controls.Pause

'WindowsMediaPlayer1.Controls.SelectionStart = m_tm
'WindowsMediaPlayer1.Controls.SelectionEnd = WindowsMediaPlayer1.Controls.Duration
'WindowsMediaPlayer1.Controls.Play
'WmpCurPos = WindowsMediaPlayer1.Controls.CurrentPosition
   
If WindowsMediaPlayer1.Controls.currentPosition > m_tm Then
 m_tm = WindowsMediaPlayer1.Controls.currentPosition
End If

    m_tm = m_tm + Val(m_step.Text)
    WindowsMediaPlayer1.Controls.currentPosition = m_tm
'If WindowsMediaPlayer1.Controls.CurrentPosition = WindowsMediaPlayer1.Controls.Duration Then
'    WindowsMediaPlayer1.Controls.CurrentPosition = 0
    WindowsMediaPlayer1.Controls.Pause
'    WindowsMediaPlayer1.Controls.Play
'End If
    WindowsMediaPlayer1.Controls.Play

End Sub

Private Sub Command6_LostFocus()
On Error Resume Next
WindowsMediaPlayer1.Controls.FileName = M_NAM
m_tm = m_tm + m_step.Text
WindowsMediaPlayer1.Controls.Pause

WindowsMediaPlayer1.Controls.SelectionStart = m_tm
WindowsMediaPlayer1.Controls.SelectionEnd = WindowsMediaPlayer1.Controls.duration
WindowsMediaPlayer1.Controls.Play
End Sub

Private Sub Command7_Click()
 
On Error Resume Next
Dim wmpos As Double
Dim WmpCurPos As Double
  '  WmpCurPos = WindowsMediaPlayer1.Controls.CurrentPosition
'If WindowsMediaPlayer1.Controls.CurrentPosition < m_tm Then
' m_tm = WindowsMediaPlayer1.Controls.CurrentPosition
'End If
    'If WindowsMediaPlayer1.Controls.CurrentPosition <= 0 Then
    'WindowsMediaPlayer1.Controls.CurrentPosition = 0
    'End If
    m_tm = m_tm - Val(m_step.Text)
    WindowsMediaPlayer1.Controls.currentPosition = m_tm
'If WindowsMediaPlayer1.Controls.CurrentPosition = WmpCurPos Then
'    WindowsMediaPlayer1.Controls.CurrentPosition = 0
  '  WindowsMediaPlayer1.Controls.pause
'    WindowsMediaPlayer1.Controls.Play
'End If
WindowsMediaPlayer1.Controls.SelectionStart = m_tm
    WindowsMediaPlayer1.Controls.Play


End Sub

Private Sub Command7_KeyPress(KeyAscii As Integer)
On Error Resume Next
Dim wmpos As Double
Dim WmpCurPos As Double
  '  WmpCurPos = WindowsMediaPlayer1.Controls.CurrentPosition
'If WindowsMediaPlayer1.Controls.CurrentPosition < m_tm Then
' m_tm = WindowsMediaPlayer1.Controls.CurrentPosition
'End If
    'If WindowsMediaPlayer1.Controls.CurrentPosition <= 0 Then
    'WindowsMediaPlayer1.Controls.CurrentPosition = 0
    'End If
    m_tm = m_tm - Val(m_step.Text)
    WindowsMediaPlayer1.Controls.currentPosition = m_tm
'If WindowsMediaPlayer1.Controls.CurrentPosition = WmpCurPos Then
'    WindowsMediaPlayer1.Controls.CurrentPosition = 0
  '  WindowsMediaPlayer1.Controls.pause
'    WindowsMediaPlayer1.Controls.Play
'End If
WindowsMediaPlayer1.Controls.SelectionStart = m_tm
    WindowsMediaPlayer1.Controls.Play

End Sub

Private Sub Command9_Click()
'strFilter = "Avi File (*.avi)|*.avi"
On Error Resume Next
Dim lg As Boolean
Dim m_txt_no As String
m_txt_no = ""
lg = False


lg_stop = True
CommonDialog1.CancelError = True
Err.Clear
CommonDialog1.Filter = strFilter
CommonDialog1.ShowSave
If Err.Number = 0 Then
   ' result = Me.VideoEdit1.Save(CommonDialog1.FileName)

Dim ar_path(20) As String
Dim aR_STREAM(20) As Double
Dim ar_mch(20) As Double
i = 1
v_name = CommonDialog1.FileName
stretchmode = 2
view_demand.Recordset.MoveFirst
i = 0
VideoEdit1.OutputType = 8
VideoEdit1.OutputFileHeight = 576
VideoEdit1.OutputFileWidth = 720
VideoEdit1.VideoSampleSize = 32
VideoEdit1.DvVideoEncoderParam = 1
VideoEdit1.AudioCompressor = VideoEdit1.AudioCompressors.FindAudioCompressor("PCM")
VideoEdit1.VideoCompressor = VideoEdit1.VideoCompressors.FindVideoCompressor(box_user_cmpvd)
VideoEdit1.AVPCMSampleRate = 48000

Me.VideoEdit1.VideoSampleSize = 24
'  MsgBox VideoEdit1.VideoCompressor

While Not view_demand.Recordset.EOF And lg_stop

  If Check3.value = 1 Then
'   v_nam = v_NAME + ".AVI"
  Else
    v_nam = v_name + Trim(view_demand.Recordset![dmd_desc]) + " Clip " + Trim(Str(view_demand.Recordset![dmd_ser])) + ".avi"
   End If
 m_name1 = Trim(view_demand.Recordset![dmd_desc])
 V_PATH = Trim(view_demand.Recordset![dmd_path])
 v_stream = view_demand.Recordset![dmd_in]
 v_len_mch = view_demand.Recordset![dmd_out]
 m_dmd_mch_stock = view_demand.Recordset![dmd_mch_stock]
   m_chek = 0
  If Not IsNull(view_demand.Recordset![dmd_chek]) Then
     m_chek = view_demand.Recordset![dmd_chek]
  End If
  If m_chek = 1 Then

 M_NAM = ""
 'if merge number of image/video, you need found max width and height
 
 iMaxWidth = 0
 iMaxHeight = 0
'For i = 1 To IND
' If VideoEdit1.IsFileExisting Then
M_NAM = V_PATH
If Dir(M_NAM) <> "" Then
 idur = Round(VideoEdit1.GetFileDuration(V_PATH), 2)
    

'    iVideo2Width = VideoEdit1.GetFileWidth(ar_path(i))
'    iVideo2Height = VideoEdit1.GetFileHeight(ar_path(i))
'
 
'
'        iMaxWidth = iVideo2Width
'        iMaxHeight = iVideo2Height
 
' If iMaxWidth < iVideo3Width Then
'        iMaxWidth = iVideo3Width
' End If
'
'
' If iMaxHeight < iVideo3Height Then
'        iMaxHeight = iVideo3Height
' End If
 
 
' If iMaxHeight > 576 Then
'        iMaxHeight = 576
' End If
 
' If iMaxWidth > 720 Then
'    iMaxWidth = 720
' End If
 
 
 
'If iMaxHeight Mod 2 <> 0 Then
'    iMaxHeight = iMaxHeight + 1
'End If

'If iMaxWidth Mod 2 <> 0 Then
'    iMaxWidth = iMaxWidth + 1
'End If



 
 
'Select Case SSTab1.Tab
'Case 0
 
  '  Me.VideoEdit1.OutputWMV = False
    ' ' strCompressor = Me.cboVideoCompressor.List(cboVideoCompressor.ListIndex)
 '   CompressorIndex = Me.VideoEdit1.VideoCompressors.FindVideoCompressor(strCompressor)
 '   If CompressorIndex <> -1 Then
 '       VideoEdit1.VideoCompressor = CompressorIndex
 '   End If
    
 '   strAudioCompressor = Me.cboAudioCompressor.List(cboAudioCompressor.ListIndex)
 '   AudioCompressorIndex = Me.VideoEdit1.AudioCompressors.FindAudioCompressor(strAudioCompressor)
'
'    If AudioCompressorIndex <> -1 Then
'        VideoEdit1.AudioCompressor = AudioCompressorIndex
'
'    End If
'Case 1
'    Me.VideoEdit1.OutputType = WMV
'    strFilter = "wmv File (*.wmv)|*.wmv"
'
'
'     If OptionWMVProfile8.value = True Then
'
'       strWMV = Me.cboWMV.List(cboWMV.ListIndex)
'        WMVIndex = Me.VideoEdit1.WMVProfiles.FindWMVProfile(strWMV)
'
'        If WMVIndex <> -1 Then
'            VideoEdit1.WMVProfile = WMVIndex
'        End If
'
'
'      ElseIf OptionWMVProfile9.value = True Then
'
'        strpath = "C:\Program Files\VideoEdit Gold ActiveX Control\Profiles"
'
'        Select Case cbowmv9.ListIndex
'        Case 0
'          strpath = strpath + "\Dial-up Modems (28,8 kbps).prx"
'        Case 1
'          strpath = strpath + "\Dial-up Modems (56 kbps).prx"
'        Case 2
'          strpath = strpath + "\Dial-up Modems or LAN (28,8 to 100 kbps).prx"
'        Case 3
'          strpath = strpath + "\LAN, Cable Modem, or xDSL  (100 to 768kbps).prx"
'        Case 4
'          strpath = strpath + "\Local Network (100 kbps).prx"
'        Case 5
'          strpath = strpath + "\Local Network (256 kbps).prx"
'        Case 6
'          strpath = strpath + "\Local Network (384 kbps).prx"
'        Case 7
'          strpath = strpath + "\Local Network (768 kbps).prx"
'        Case 8
'          strpath = strpath + "\Pocket PC (225kbps).prx"
'
'        End Select
'          VideoEdit1.WMVCustomFileName = strpath
'     Else
        'use wmv profile editor to use wmv profile, the resolution will very good
'         gen_profile iMaxWidth, iMaxHeight
'         VideoEdit1.WMVCustomFileName = "c:\mytestprofile.prx"
'   End If
    
'End Select



'Get Height and Width of new file
'VideoEdit1.OutputType = 8
'VideoEdit1.OutputFileHeight = 576
'VideoEdit1.OutputFileWidth = 720
'VideoEdit1.VideoSampleSize = 32
'VideoEdit1.DvVideoEncoderParam = 1
'VideoEdit1.AudioCompressor = VideoEdit1.AudioCompressors.FindAudioCompressor("PCM")
'VideoEdit1.VideoCompressor = VideoEdit1.VideoCompressors.FindVideoCompressor("MainConcept DV Video Encoder")
'VideoEdit1.AVPCMSampleRate = 48000


'stretchmode = 2
'Me.VideoEdit1.OutputType = 8
'strFilter = "Avi File (*.avi)|*.avi"
'
''Add video & audio track
'Me.VideoEdit1.VideoSampleSize = 24
'Me.VideoEdit1.OutputFileWidth = VideoEdit1.GetFileWidth(V_PATH)
'Me.VideoEdit1.OutputFileHeight = VideoEdit1.GetFileHeight(V_PATH)






'Call OpenDoc(m_nam)
'VideoEdit1.Play

If idur <> 0 Then
  i = i + 1
  STARTTIME = v_stream + v_len_mch
  
If Not Check3.value = 1 Then

  VideoEdit1.InitControl
  
 'sTARTTIME = STREAMSTART(i) + LEN_MCH(i)
 
'Add video track
     Me.VideoEdit1.AddVideo V_PATH, v_stream, STARTTIME, stretchmode
  '  Me.VideoEdit1.AddVideo ar_path(i), aR_STREAM(i), ar_mch(i), stretchmode
   RESULT = Me.VideoEdit1.AddAudio(V_PATH, v_stream, STARTTIME)
  '    result = Me.VideoEdit1.AddAudio(ar_path(i), aR_STREAM(i), ar_mch(i))
    If RESULT = False Then
       MsgBox "audio format fail"
'        Exit Sub
        
    End If
  
      RESULT = Me.VideoEdit1.Save(v_nam)
    If RESULT = False Then
       MsgBox "Fail to save file"
    Else
         progress.m_tit.Text = m_name1
        progress.Show 1
    End If
    Else
       ar_path(i) = V_PATH
       aR_STREAM(i) = v_stream
       ar_mch(i) = STARTTIME
    
    End If
    If lg_stop Then
       m_dmd_no1 = DataGrid1.Columns(1)
    m_ser = DataGrid1.Columns(2)
    m_dmd_chek = 2
  sql = "execute upd_demand1 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_ser & "'" & "," _
            & "'" & m_dmd_chek & "'"
      cn.Execute sql, rdExecDirect
    End If
 Else
  m_txt_no = m_txt_no + Str(m_dmd_mch_stock) + " , "
End If
Else
  m_txt_no = m_txt_no + Str(m_dmd_mch_stock) + " , "

End If
End If
'End If
  ' OverlaySetting
    view_demand.Recordset.MoveNext
'    i = i + 1
Wend
If Check3.value = 1 Then
VideoEdit1.InitControl
 For j = 1 To i
 STARTTIME = STREAMSTART(j) + LEN_MCH(j)
 Me.VideoEdit1.AddVideo ar_path(j), aR_STREAM(j), ar_mch(j), stretchmode
 Next j
  '  Me.VideoEdit1.AddVideo ar_path(i), aR_STREAM(i), ar_mch(i), stretchmode
  For j = 1 To i
  STARTTIME = STREAMSTART(i) + LEN_MCH(i)
   RESULT = Me.VideoEdit1.AddAudio(ar_path(j), aR_STREAM(j), ar_mch(j))
  Next j
   v_nam = v_name + ".avi"
      RESULT = Me.VideoEdit1.Save(v_nam)
       If RESULT = False Then
       MsgBox "Fail to save file"
    Else
         progress.m_tit.Text = "œ„Ã ﬂ· «·„‘«Âœ"
        progress.Show 1
    End If
  End If
view_demand.Refresh
If m_txt_no = "" Then
  MsgBox "«‰ Â  ⁄„·Ì… «·‰”Œ..."
Else
 MsgBox "«—ﬁ«„ «·«‘—ÿ… «· Ì ·„  ‰›– : " & m_txt_no
End If

'result = Me.VideoEdit1.AddAudio(txtAudio2, txtAudioStart2, txtAudioStop2)




'Add  audio track
'If txtAudio1.Text <> "" Then
'    result = Me.VideoEdit1.AddAudio(txtAudio1, txtAudioStart1, txtAudioStop1)
'    If result = False Then
'        MsgBox "Audio format fail"
'        Exit Sub
'    End If
'End If
'
'If txtAudio2.Text <> "" Then
'    result = Me.VideoEdit1.AddAudio(txtAudio2, txtAudioStart2, txtAudioStop2)
'    If result = False Then
'        MsgBox "Audio format fail"
'        Exit Sub
'    End If
'End If
'
'If txtAudio3.Text <> "" Then
'    result = Me.VideoEdit1.AddAudio(txtAudio3, txtAudioStart3, txtAudioStop3)
'    If result = False Then
'        MsgBox "Audio format fail"
'        Exit Sub
'    End If
'End If
'


'Add Transition
'If txt_TranID1 <> "" Then
'    VideoEdit1.AddTransition Me.txt_TranID1, txtTranStart1, txtTranEnd1
'End If
'
'Save is Failed
'If VideoEdit1.GetTotalDuration = 0 Then
'    MsgBox "Timeline empty,cannot process"
'    Exit Sub
'End If



'Save
'CommonDialog1.Filter = strFilter
'CommonDialog1.ShowSave
'If Err.Number = 0 Then
'    result = Me.VideoEdit1.Save(CommonDialog1.FileName)
'    If result = False Then
        'MsgBox "Fail to save file"
''    Else
'        progress.Show 1
 '   End If
'End If
End If
End Sub

Private Sub DataGrid1_AfterColEdit(ByVal ColIndex As Integer)
m_row = view_demand.Recordset.Bookmark - 1
view_demand.Recordset.Requery
view_demand.Recordset.Move (m_row)
End Sub

Private Sub datagrid1_DblClick()
On Error Resume Next




If Not IsNull(DataGrid1.Columns(5)) And Not IsNull(DataGrid1.Columns(3)) Then

m_time = Val(DataGrid1.Columns(6))
m_time1 = Val(DataGrid1.Columns(6)) + Val(DataGrid1.Columns(7))
'm_config_path = DataGrid1.Columns(3)
w_mch_stock = DataGrid1.Columns(5)
  V_PATH = Trim(DataGrid1.Columns(10))
   v_mch_typ = Mid(V_PATH, Len(V_PATH) - 2, 3)
   v_mch_typ_high = v_mch_typ
 m_stock = DataGrid1.Columns(5)
   V_MCH_STOCK = Mid("00000", 1, 6 - Len(Trim(Str(m_stock)))) + Trim(Str(m_stock))
 
m_config_path = m_STCOK_path_new(V_MCH_STOCK, 2)
 
M_NAM = m_config_path + Trim(V_MCH_STOCK) + "." + v_mch_typ
If Dir(M_NAM) <> "" Then
WindowsMediaPlayer1.URL = M_NAM
WindowsMediaPlayer1.Controls.Pause
WindowsMediaPlayer1.Controls.currentPosition = m_time
WindowsMediaPlayer1.Controls.Play
End If
 
End If
End Sub

Private Sub DataGrid1_KeyDown(KeyCode As Integer, Shift As Integer)
'On Error Resume Next
'If KeyCode = vbKeyDown Or KeyCode = vbKeyUp Or KeyCode = vbkeypagup Or KeyCode = vbKeyPageDown Then
 'End If
End Sub

Private Sub DataGrid1_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDelete Then
 Frame6.Visible = True
 M_YESNO.SetFocus
ElseIf KeyCode = vbKeyF5 Then
 If box_user_start = 1 Then
   Frame1.Visible = True
  End If
ElseIf KeyCode = vbKeyF1 Then
   view_demand.Recordset.MoveFirst
While Not view_demand.Recordset.EOF
    m_dmd_no1 = view_demand.Recordset![dmd_no]
    m_ser = view_demand.Recordset![dmd_ser]
    m_dmd_chek = 1
  sql = "execute upd_demand1 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_ser & "'" & "," _
            & "'" & m_dmd_chek & "'"
      cn.Execute sql, rdExecDirect
      view_demand.Recordset.MoveNext
Wend
   view_demand.Refresh
  ElseIf KeyCode = vbKeyF2 Then
   view_demand.Recordset.MoveFirst
   While Not view_demand.Recordset.EOF
      m_dmd_no1 = view_demand.Recordset![dmd_no]
      m_ser = view_demand.Recordset![dmd_ser]
      m_dmd_chek = 2
      sql = "execute upd_demand1 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_ser & "'" & "," _
            & "'" & m_dmd_chek & "'"
       cn.Execute sql, rdExecDirect
       view_demand.Recordset.MoveNext
   Wend
   view_demand.Refresh
    
End If
End Sub

Private Sub DBList1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
m_disp = 0
view_form.Resultset.Bookmark = DBList1.SelectedItem

     m_dmd_user_no = view_form.Resultset![user_no]
      m_dmd_user.Text = view_form.Resultset![user_name]
      m_disp = 1
      DBList1.Visible = False
      Command12.SetFocus
      
ElseIf KeyAscii = 27 Then
       DBList1.Visible = False
       m_disp = 0
       m_dmd_user.Text = ""
       m_disp = 1
      Command12.SetFocus

 End If
End Sub

Private Sub Form_Activate()
 On Error Resume Next
WindowsMediaPlayer1.Controls.EnableTracker = True
WindowsMediaPlayer1.Controls.EnablePositionControls = True
Dim m_acrh_no, m_time, m_time1 As Integer
M_dmd_dte.Text = Format(Date, "dd/mm/yyyy")
M_dmd_dte1.Text = Format(Date, "dd/mm/yyyy")

 If v_mch_digtyp = "02" Then
 V_REC = Trim(V_MCH_STOCK)
 M_NAM1 = Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\"
         m_config_path = m_cnf_path_pic + "waves\" + M_NAM1
 Else
m_config_path = m_STCOK_path_new(Str(V_MCH_STOCK), 2)
End If
 m_time = Val(v_mch_s) + Val(v_mch_m) * 60 + Val(v_mch_o) * 3600
 m_time1 = Val(v_mch_s1) + Val(v_mch_m1) * 60 + Val(v_mch_o1) * 3600
' If Val(v_mch_stock) > 12259 And Val(v_mch_stock) < 14000 Then
'If Dir(m_nam) = "" Then
M_NAM = m_config_path + Trim(V_MCH_STOCK) + "." + v_mch_typ
If Dir(M_NAM) <> "" Then
WindowsMediaPlayer1.URL = M_NAM
WindowsMediaPlayer1.Controls.currentPosition = m_time

WindowsMediaPlayer1.Controls.Play
WindowsMediaPlayer1.Controls.Pause
End If
m_tm = m_time
m_tm1 = m_time1
deb_tm = m_time
fin_tm = m_time1
'End If
'm_nam_file.SetFocus

' If M_dmd_dte.Text = "__/__/____" Then
'    v_adte = ""
'    Else
'     v_adte = M_dmd_dte.Text
' End If
' If M_dmd_dte1.Text = "__/__/____" Then
'    v_adte1 = ""
'    Else
'     v_adte1 = M_dmd_dte1.Text
' End If
  
 
'if box_user_start = 1 Then
'view_demand.RecordSource = "execute proc_demand1 " & "'" & Format(v_adte, "yyyy/mm/dd") & "'" & "," _
                                & "'" & Format(v_adte1, "yyyy/mm/dd") & "'"

'Else
'view_demand.RecordSource = "execute proc_demand " & "'" & Format(v_adte, "yyyy/mm/dd") & "'" & "," _
'                                & "'" & Format(v_adte1, "yyyy/mm/dd") & "'" & "," & "'" & box_user_no & "'"
'         End If
'view_demand.Refresh
   DataGrid1.SetFocus

End Sub

Private Sub Form_Load()
On Error Resume Next
If box_user_start = 1 Then
Command9.Enabled = True
Else
Command9.Enabled = False
End If
m_disp = 1

lg_stop = True
WindowsMediaPlayer1.Controls.EnableTracker = True
WindowsMediaPlayer1.Controls.EnablePositionControls = True
Dim m_acrh_no, m_time, m_time1 As Integer
M_dmd_dte.Text = Format(Date, "dd/mm/yyyy")
M_dmd_dte1.Text = Format(Date, "dd/mm/yyyy")

 
m_config_path = m_STCOK_path_new(V_MCH_STOCK, 2)
 m_time = Val(v_mch_s) + Val(v_mch_m) * 60 + Val(v_mch_o) * 3600
 m_time1 = Val(v_mch_s1) + Val(v_mch_m1) * 60 + Val(v_mch_o1) * 3600
' If Val(v_mch_stock) > 12259 And Val(v_mch_stock) < 14000 Then
'If Dir(m_nam) = "" Then
M_NAM = m_config_path + Trim(V_MCH_STOCK) + ".avi"
If Dir(M_NAM) <> "" Then
WindowsMediaPlayer1.Controls.FileName = M_NAM
WindowsMediaPlayer1.Controls.currentPosition = m_time

WindowsMediaPlayer1.Controls.Play
WindowsMediaPlayer1.Controls.Pause
End If
m_tm = m_time
m_tm1 = m_time1
deb_tm = m_time
fin_tm = m_time1
'End If
'm_nam_file.SetFocus

' If M_dmd_dte.Text = "__/__/____" Then
'    v_adte = ""
'    Else
'     v_adte = M_dmd_dte.Text
' End If
' If M_dmd_dte1.Text = "__/__/____" Then
'    v_adte1 = ""
'    Else
'     v_adte1 = M_dmd_dte1.Text
' End If
m_disp = 1
qst1 = 0
qst2 = 0
qst3 = 0
qst4 = 0
qst5 = 0
qst6 = 0
qst7 = 0
qst8 = 0
m_typ_serh = 1


'M_art_dte.Text = Format(Date, "dd/mm/yy")
first_qst = 0
crit1 = ""
 CRIT = "create proc tmp_demand" + box_user_no + " AS "

CRIT = CRIT & "SELECT   dbo.demand.dmd_mch_no, dbo.demand.dmd_no, dbo.demand.dmd_ser, dbo.demand.dmd_user, dbo.demand.dmd_dte, dbo.main.mn_act_ttl,rtrim(cast(dbo.demand.dmd_s as char))+ '  ' + rtrim(cast(dbo.demand.dmd_M as char))+ '  ' + rtrim(cast(dbo.demand.dmd_O as char)) as time_frm , " & _
                      " dbo.demand.dmd_in , dbo.demand.dmd_out, dbo.demand.dmd_path, dbo.demand.dmd_time, dbo.demand.dmd_desc, dbo.demand.dmd_chek, dbo.demand.dmd_mch_stock, dbo.config.user_name " & _
" FROM         dbo.demand left JOIN " & _
                     " dbo.main ON dbo.demand.dmd_mch_no = dbo.main.mn_app_no left join " & _
                     " dbo.config ON dbo.demand.dmd_user = dbo.config.user_no "
 If qst1 = 0 And Not M_dmd_dte.Text = "__/__/____" Then
  qst1 = 1
   If first_qst = 0 Then
        crit11 = " where "
        first_qst = 1
      Else
       crit11 = crit11 & " and "
      End If
     
     m_dte = Format(M_dmd_dte.Text, "yyyy/MM/dd")
     crit11 = crit11 & " ( dmd_dte >= " & "convert(datetime," & "'" & Format(m_dte, "yyyy-mm-dd") & "'" & "," & "102))"
     M_dmd_dte.Enabled = False
End If
 If qst2 = 0 And Not M_dmd_dte1.Text = "__/__/____" Then
  qst2 = 1
 If first_qst = 0 Then
        crit11 = " where "
        first_qst = 1
      Else
       crit11 = crit11 & " and "
      End If
     
     m_dte1 = Format(M_dmd_dte1.Text, "yyyy/MM/dd")
     crit11 = crit11 & " ( dmd_dte <= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102))"
     M_dmd_dte1.Enabled = False
End If
If Not box_user_no = "244" Then
  qst7 = 1
    m_disp = 0
      crit1 = crit1 & " and dmd_user =  " & "'" & box_user_no & "'"
      m_dmd_user.Text = box_user_name
      m_disp = 1
       m_dmd_user.Enabled = False
       End If

If first_qst > 0 Then
  crit2 = CRIT & crit11 & crit1 & " order by dmd_no desc"
  ''& " order by art_dte"
 '  MsgBox crit2
       sql = "drop proc tmp_demand" + box_user_no
       cn.Execute sql, rdExecDirect
       cn.Execute crit2, rdExecDirect
       Screen.MousePointer = vbHourglass
       view_demand.RecordSource = "execute tmp_demand" + box_user_no
       view_demand.Refresh
       DataGrid1.Refresh
       
      Screen.MousePointer = vbDefault
 Else
      MsgBox "ÌÃ» ÿ—Õ «·”ƒ«· «Ê·«....."
End If
 
 
'if box_user_start = 1 Then
'view_demand.RecordSource = "execute proc_demand1 " & "'" & Format(v_adte, "yyyy/mm/dd") & "'" & "," _
                                & "'" & Format(v_adte1, "yyyy/mm/dd") & "'"

'Else
'view_demand.RecordSource = "execute proc_demand " & "'" & Format(v_adte, "yyyy/mm/dd") & "'" & "," _
'                                & "'" & Format(v_adte1, "yyyy/mm/dd") & "'" & "," & "'" & box_user_no & "'"
'         End If
'view_demand.Refresh
  If Not view_demand.Recordset.EOF Or Not view_demand.Recordset.EOF Then
     view_demand.Recordset.MoveFirst
    If Not IsNull(view_demand.Recordset![dmd_ser]) Then
       m_dmd_ser = view_demand.Recordset![dmd_ser]
      Else
       m_dmd_ser = 0
      End If

   Else
     m_dmd_ser = 0
  End If
  DataGrid1.SetFocus

End Sub

Private Sub m_dmd_desc_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Command10.SetFocus
End If
End Sub

Private Sub M_dmd_dte_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not M_dmd_dte.Text = "__/__/____" Then
  If IsDate(M_dmd_dte.Text) Then
        crit11 = " where "
        first_qst = 1
     
     m_dte = Format(M_dmd_dte.Text, "YYYY/MM/DD")
     crit11 = crit11 & "  dmd_dte >= " & "convert(datetime," & "'" & Format(m_dte, "yyyy-mm-dd") & "'" & "," & "102)"
      m_dte1 = Format(M_dmd_dte1.Text, "YYYY/MM/DD")
     crit11 = crit11 & " and   dmd_dte <= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102)"
     qst0 = 1
     M_dmd_dte.Enabled = False
     M_dmd_dte1.SetFocus
     
  Else
    M_dmd_dte.SetFocus
 End If
End If


End Sub

Private Sub M_dmd_dte1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not M_dmd_dte1.Text = "__/__/____" Then
  If IsDate(M_dmd_dte1.Text) Then
        crit11 = " where "
        first_qst = 1
     
     m_dte1 = Format(M_dmd_dte1.Text, "YYYY/MM/DD")
     crit11 = crit11 & "  dmd_dte <= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102)"
     m_dte = Format(M_dmd_dte.Text, "YYYY/MM/DD")
     crit11 = crit11 & " and   dmd_dte >= " & "convert(datetime," & "'" & Format(m_dte, "yyyy-mm-dd") & "'" & "," & "102)"
     qst1 = 1
     M_dmd_dte1.Enabled = False
    Command12.SetFocus
     
  Else
    M_dmd_dte1.SetFocus
 End If
End If

End Sub

Private Sub m_dmd_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_dmd_no.Text = "" Then
    v_prs_no = "0000000"
     m_no = m_dmd_no.Text
     v_prs_no = Mid(v_prs_no, 1, 7 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
     m_dmd_no.Text = v_prs_no
       qst6 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       crit1 = crit1 & "dmd_no  = " & "'" & m_dmd_no.Text & "'"
       m_dmd_no.Enabled = False
        Command12.SetFocus

End If
End Sub

Private Sub m_dmd_user_Change()
If m_disp = 1 Then
  If DBList1.Visible = False Then
    DBList1.Visible = True
    DBList1.Left = 8880
    DBList1.Top = 2880
  End If
  If Not Trim(m_dmd_user.Text) = "" Then
         m_desc = m_dmd_user.Text
         
         m_len = Len(Trim(m_dmd_user.Text))
         view_form.sql = "execute serh_config " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
         
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If
   End If
Else
   m_disp = 1
End If

End Sub

Private Sub m_dmd_user_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not m_dmd_user.Text = "" Then
   DBList1.SetFocus
  SendKeys "{UP}"
End If
End Sub

Private Sub m_mch_stock_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_mch_stock.Text = "" Then
  qst8 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      sw_desc = LTrim(m_mch_stock.Text)
       If k > 1 Then
         crit1 = crit1 & " and "
       End If
        crit1 = crit1 & "dmd_mch_stock " & " like " & "'" & "%" & sw_desc & "%" & "'"
     m_mch_stock.Enabled = False
    Command12.SetFocus
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
End If
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

Private Sub m_view_path_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Command3.SetFocus
End If
End Sub

Private Sub M_YESNO_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Command16.SetFocus
  
End If
End Sub

 
Private Sub Slider1_Click()
WindowsMediaPlayer1.Controls.Rate = Val(Slider1.value)

End Sub
Private Sub Stop_Video()
  '  strMode = "STOP"
    VideoEdit1.Stop
  '  cmdpause.Enabled = False
  '  cmdstop.Enabled = False
  '  chkuseoverlay.Enabled = True
   
End Sub

Private Sub search_text_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not search_text.Text = "" Then
  qst5 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      sw_desc = LTrim(search_text.Text)
       If k > 1 Then
         crit1 = crit1 & " and "
       End If
        crit1 = crit1 & "dmd_desc + mn_act_ttl" & " like " & "'" & "%" & sw_desc & "%" & "'"
     search_text.Enabled = False
    Command12.SetFocus
 End If

End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)
MsgBox KeyAscii

End Sub

Private Sub VideoEdit1_Complete()
   Stop_Video
    progress.ProgressBar1.value = progress.ProgressBar1.Max
    progress.Hide
    Unload progress
End Sub
Private Sub VideoEdit1_OnPlaying(ByVal iCurrent As Double)
txtTime = iCurrent
End Sub

Private Sub VideoEdit1_Processing(ByVal iCurPos As Double, ByVal iDuration As Double)






 progress.ProgressBar1.Min = 0

If iDuration <> 0 Then
     progress.ProgressBar1.Max = iDuration
End If


If iCurPos < iDuration Then
     progress.ProgressBar1.value = iCurPos
End If

'you can change the image or text at specific iCurPos

End Sub







'Purpose   :    Holds execution until application has closed.
'Inputs    :    sFilePath       =   The path to the application to run e.g. "Notepad.exe"
'               [sCommandLine]  =   Any command line arguments
'               [lState]        =   The Window State to run of the shelled program (A Long)
'               [lMaxTimeOut]   =   The maximum amount of time to wait for the process to finish (in secs).
'                                   -1 = infinate
'Outputs   :    Returns the True if failed open a process or complete within the specified timeout.
'Notes     :    Similiar to ShellAndHold, but will not get any 'spiking' effects using this method.


Function ShellAndWait(sFilePath As String, Optional sCommandLine, Optional lState As VbAppWinStyle = vbNormalFocus, Optional lMaxTimeOut As Long = -1) As Boolean
    Dim lRetVal As Long, siStartTime As Single, lProcID As Long

    'Check to see that the file exists
    If FileExists(sFilePath) Then
        'Add double quotes around the path (otherwise you can't use spaces in the path)
        If Left$(sFilePath, 1) <> Chr(34) Then
            sFilePath = Chr(34) & sFilePath
        End If
        If Right$(sFilePath, 1) <> Chr(34) Then
            sFilePath = sFilePath & Chr(34)
        End If
    End If
    
    'Start the shell
    lRetVal = Shell(Trim$(sFilePath + " " + sCommandLine), lState)
    'Open the process
    lProcID = OpenProcess(SYNCHRONIZE, True, lRetVal)
    
    siStartTime = Timer
    Do
        lRetVal = WaitForSingleObject(lProcID, 0)
        If lRetVal = WAIT_OBJECT_0 Then
            'Finished process
            lRetVal = CloseHandle(lProcID)
            ShellAndWait = False
            Exit Do
        ElseIf lRetVal = WAIT_FAILED Then
            lRetVal = CloseHandle(lProcID)
            'Failed to open process
            ShellAndWait = True
            Exit Do
        End If
        Sleep 100
        If lMaxTimeOut > 0 Then
            'Check timeout has not been exceeded
            If siStartTime + lMaxTimeOut < Timer Then
                'Failed, timeout exceeded
                lRetVal = CloseHandle(lProcID)
                ShellAndWait = True
            End If
        End If
    Loop
End Function


'Purpose   :    Holds execution until application has finished opening
'Inputs    :    sCommandLine     =   The Command line to run the application e.g. "Notepad.exe"
'               lState           =   The Window State to run of the shelled program (A Long)
'Outputs   :    Returns the Process Handle
'Notes     :    Use this when you want to wait for an application to finishing opening before proceeding
'               The side effects mentioned in ShellAndHold will be negligible since the most applications
'               load in under 5 seconds.


Function ShellAndWaitReady(sCommandLine As String, Optional lState As Long = vbNormalFocus) As Long
    Dim lhProc As Long
    
    If Left$(sCommandLine, 1) <> Chr(34) Then
        sCommandLine = Chr(34) & sCommandLine
    End If
    If Right$(sCommandLine, 1) <> Chr(34) Then
        sCommandLine = sCommandLine & Chr(34)
    End If
    lhProc = Shell(sCommandLine, vbMaximizedFocus)
    'Wait for the process to initialize
    Call WaitForInputIdle(lhProc, INFINITE)
    'Return the handle
    ShellAndWaitReady = lhProc
End Function


'Purpose     :  Checks if a file exists
'Inputs      :  sFilePathName                   The path and file name e.g. "C:\Autoexec.bat"
'Outputs     :  Returns True if the file exists


Function FileExists(sFilePathName As String) As Boolean
    
    On Error GoTo ErrFailed
    If Len(sFilePathName) Then
        If (GetAttr(sFilePathName) And vbDirectory) < 1 Then
            'File Exists
            FileExists = True
        End If
    End If
    Exit Function
    
ErrFailed:
    'File Exists
    FileExists = False
    On Error GoTo 0
End Function

'Purpose     :  Converts a File Name and Path to a Path
'Inputs      :  sFilePathName                   The path and file name e.g. "C:\Autoexec.bat"
'Outputs     :  Returns the path


Function PathFileToPath(sFilePathName As String) As String
    Dim ThisChar As Long

    For ThisChar = 0 To Len(sFilePathName) - 1
        If Mid$(sFilePathName, Len(sFilePathName) - ThisChar, 1) = "\" Then
            PathFileToPath = Left$(sFilePathName, Len(sFilePathName) - ThisChar)
            Exit For
        End If
    Next
End Function



Function nameFileToPath(sFilePathName As String) As String
    Dim ThisChar As Long

    For ThisChar = 0 To Len(sFilePathName) - 1
        If Mid$(sFilePathName, Len(sFilePathName) - ThisChar, 1) = "\" Then
            nameFileToPath = Right$(sFilePathName, ThisChar)
            Exit For
        End If
    Next
End Function

Function m_STCOK_path_new(m_stock As String, m_typ As Integer)
    Dim M_NAM    As String
    Dim lg As Boolean
    On Error Resume Next
     lg = True
   ranj.Resultset.MoveFirst
   While Not ranj.Resultset.EOF And lg
        If ranj.Resultset![rjp_typ] = m_typ Then
          If Val(m_stock) > ranj.Resultset![rjp_nofrom] And Val(m_stock) < ranj.Resultset![rjp_noto] Then
                   m_STCOK_path_new = Trim(ranj.Resultset![rjp_path])
                     lg = False
          End If
    End If
    ranj.Resultset.MoveNext
   Wend
   
      
  End Function

