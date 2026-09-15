VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{CDE57A40-8B86-11D0-B3C6-00A0C90AEA82}#1.0#0"; "MSDATGRD.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form Form6 
   BackColor       =   &H00808080&
   Caption         =   "«—‘Ì› ⁄«„"
   ClientHeight    =   9660
   ClientLeft      =   990
   ClientTop       =   -480
   ClientWidth     =   19980
   LinkTopic       =   "Form6"
   Moveable        =   0   'False
   RightToLeft     =   -1  'True
   ScaleHeight     =   9660
   ScaleWidth      =   19980
   Begin MSDBCtls.DBList DBList1 
      Bindings        =   "Form6.frx":0000
      DataField       =   "RES_RES_NO"
      DataSource      =   "res1"
      Height          =   1620
      Left            =   10320
      TabIndex        =   9
      ToolTipText     =   "F8 ··»ÕÀ ›Ì »œ«Ì… «·«”„ , ENTER ··«Œ Ì«—"
      Top             =   4440
      Visible         =   0   'False
      Width           =   2895
      _ExtentX        =   5106
      _ExtentY        =   2858
      _Version        =   393216
      BackColor       =   14737632
      ListField       =   "AUT_NAM"
      BoundColumn     =   "AUT_NO"
      RightToLeft     =   -1  'True
   End
   Begin VB.CommandButton Command22 
      BackColor       =   &H00FFFFFF&
      Caption         =   "«·«ŒÌ—"
      Height          =   615
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   82
      Top             =   8160
      Width           =   975
   End
   Begin MSAdodcLib.Adodc res2 
      Height          =   615
      Left            =   12960
      Top             =   9480
      Visible         =   0   'False
      Width           =   1200
      _ExtentX        =   2117
      _ExtentY        =   1085
      ConnectMode     =   0
      CursorLocation  =   3
      IsolationLevel  =   -1
      ConnectionTimeout=   15
      CommandTimeout  =   30
      CursorType      =   3
      LockType        =   3
      CommandType     =   8
      CursorOptions   =   0
      CacheSize       =   50
      MaxRecords      =   0
      BOFAction       =   0
      EOFAction       =   0
      ConnectStringType=   1
      Appearance      =   1
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      Orientation     =   0
      Enabled         =   -1
      Connect         =   "sqlserver"
      OLEDBString     =   "sqlserver"
      OLEDBFile       =   ""
      DataSourceName  =   ""
      OtherAttributes =   ""
      UserName        =   ""
      Password        =   ""
      RecordSource    =   "select view_res3.* from view_res3"
      Caption         =   "res2"
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
   Begin VB.Frame Frame5 
      BackColor       =   &H00E0E0E0&
      Height          =   2295
      Left            =   11400
      RightToLeft     =   -1  'True
      TabIndex        =   43
      Top             =   120
      Visible         =   0   'False
      Width           =   3375
      Begin VB.CommandButton Command16 
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
         TabIndex        =   46
         Top             =   1440
         Width           =   855
      End
      Begin VB.CommandButton Command15 
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
         TabIndex        =   45
         Top             =   1440
         Width           =   855
      End
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
         TabIndex        =   44
         Top             =   1440
         Width           =   855
      End
      Begin VB.Label Label40 
         Alignment       =   2  'Center
         BackColor       =   &H00E0E0E0&
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
         TabIndex        =   47
         Top             =   240
         Width           =   3135
      End
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H00E0E0E0&
      Height          =   2415
      Left            =   8040
      RightToLeft     =   -1  'True
      TabIndex        =   56
      Top             =   120
      Visible         =   0   'False
      Width           =   3375
      Begin VB.TextBox m_yesno1 
         Alignment       =   1  'Right Justify
         Height          =   405
         Left            =   120
         RightToLeft     =   -1  'True
         TabIndex        =   59
         Top             =   600
         Width           =   375
      End
      Begin VB.CommandButton Command18 
         Caption         =   " ‰›Ì–"
         Height          =   495
         Left            =   2160
         RightToLeft     =   -1  'True
         TabIndex        =   58
         Top             =   1560
         Width           =   735
      End
      Begin VB.CommandButton Command17 
         Caption         =   "«·€«¡ «·«„—"
         Height          =   495
         Left            =   360
         RightToLeft     =   -1  'True
         TabIndex        =   57
         Top             =   1560
         Width           =   735
      End
      Begin VB.Label Label12 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00E0E0E0&
         Caption         =   "Â·  —Ìœ «·€«¡  Â–Â «·”Ã·  (‰ / ﬂ) "
         Height          =   255
         Left            =   480
         RightToLeft     =   -1  'True
         TabIndex        =   60
         Top             =   720
         Width           =   2655
      End
   End
   Begin VB.Frame Frame4 
      BackColor       =   &H00E0E0E0&
      Height          =   2415
      Left            =   10920
      RightToLeft     =   -1  'True
      TabIndex        =   33
      Top             =   480
      Visible         =   0   'False
      Width           =   3135
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
         TabIndex        =   36
         Top             =   720
         Width           =   1095
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
         TabIndex        =   35
         Top             =   1560
         Width           =   735
      End
      Begin VB.CommandButton Command10 
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
         TabIndex        =   34
         Top             =   1560
         Width           =   735
      End
      Begin VB.Label Label38 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00E0E0E0&
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
         TabIndex        =   37
         Top             =   720
         Width           =   1215
      End
   End
   Begin VB.Frame Frame3 
      BackColor       =   &H00E0E0E0&
      Height          =   2415
      Left            =   7440
      RightToLeft     =   -1  'True
      TabIndex        =   69
      Top             =   240
      Visible         =   0   'False
      Width           =   3135
      Begin VB.TextBox m_user_password 
         Alignment       =   1  'Right Justify
         BeginProperty DataFormat 
            Type            =   0
            Format          =   "***"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   12289
            SubFormatType   =   0
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   375
         IMEMode         =   3  'DISABLE
         Left            =   480
         PasswordChar    =   "*"
         RightToLeft     =   -1  'True
         TabIndex        =   74
         Top             =   720
         Width           =   1575
      End
      Begin VB.CommandButton Command21 
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
         TabIndex        =   71
         Top             =   1560
         Width           =   735
      End
      Begin VB.CommandButton Command20 
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
         TabIndex        =   70
         Top             =   1560
         Width           =   735
      End
      Begin VB.Label Label17 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00E0E0E0&
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
         Left            =   2160
         RightToLeft     =   -1  'True
         TabIndex        =   73
         Top             =   960
         Width           =   1215
      End
      Begin VB.Label Label16 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00E0E0E0&
         Caption         =   "ﬂ·„… «·”—"
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
         Left            =   1560
         RightToLeft     =   -1  'True
         TabIndex        =   72
         Top             =   720
         Width           =   1215
      End
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H00E0E0E0&
      Height          =   2415
      Left            =   6840
      RightToLeft     =   -1  'True
      TabIndex        =   38
      Top             =   360
      Visible         =   0   'False
      Width           =   3375
      Begin VB.CommandButton Command13 
         Caption         =   "«·€«¡ «·«„—"
         Height          =   495
         Left            =   360
         RightToLeft     =   -1  'True
         TabIndex        =   41
         Top             =   1560
         Width           =   735
      End
      Begin VB.CommandButton Command11 
         Caption         =   " ‰›Ì–"
         Height          =   495
         Left            =   2160
         RightToLeft     =   -1  'True
         TabIndex        =   40
         Top             =   1560
         Width           =   735
      End
      Begin VB.TextBox M_YESNO 
         Alignment       =   1  'Right Justify
         Height          =   405
         Left            =   120
         RightToLeft     =   -1  'True
         TabIndex        =   39
         Top             =   600
         Width           =   375
      End
      Begin VB.Label Label25 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00E0E0E0&
         Caption         =   "Â·  —Ìœ «·€«¡  Â–Â «·«” „«—…  (‰ / ﬂ) "
         Height          =   255
         Left            =   480
         RightToLeft     =   -1  'True
         TabIndex        =   42
         Top             =   720
         Width           =   2655
      End
   End
   Begin VB.TextBox m_art_no 
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
      Height          =   285
      Left            =   4320
      MaxLength       =   5
      RightToLeft     =   -1  'True
      TabIndex        =   75
      Top             =   3600
      Width           =   735
   End
   Begin MSDBCtls.DBList DBList6 
      Bindings        =   "Form6.frx":0015
      Height          =   1770
      Left            =   9480
      TabIndex        =   67
      Top             =   6120
      Visible         =   0   'False
      Width           =   1935
      _ExtentX        =   3413
      _ExtentY        =   2858
      _Version        =   393216
      BackColor       =   14737632
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      RightToLeft     =   -1  'True
   End
   Begin MSDataListLib.DataCombo m_art_sub_ty 
      Bindings        =   "Form6.frx":0031
      Height          =   315
      Left            =   15000
      TabIndex        =   66
      Top             =   3600
      Width           =   3495
      _ExtentX        =   6165
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSDataListLib.DataCombo m_mn_app_doc 
      Bindings        =   "Form6.frx":004B
      Height          =   315
      Left            =   2160
      TabIndex        =   65
      Top             =   840
      Width           =   3495
      _ExtentX        =   6165
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSDataListLib.DataCombo m_mn_data_en 
      Bindings        =   "Form6.frx":0061
      Height          =   315
      Left            =   14880
      TabIndex        =   64
      Top             =   960
      Width           =   3495
      _ExtentX        =   6165
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   " "
      RightToLeft     =   -1  'True
   End
   Begin MSDataListLib.DataCombo m_art_per_no 
      Bindings        =   "Form6.frx":0077
      Height          =   315
      Left            =   14880
      TabIndex        =   63
      Top             =   1560
      Width           =   3495
      _ExtentX        =   6165
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "PER_PER_NA"
      BoundColumn     =   "PER_PER_NO"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSDataListLib.DataCombo m_art_per1 
      Bindings        =   "Form6.frx":008D
      Height          =   315
      Left            =   14880
      TabIndex        =   62
      Top             =   2040
      Width           =   3495
      _ExtentX        =   6165
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "PER_PER_NA"
      BoundColumn     =   "PER_PER_NO"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSDBCtls.DBList DBList4 
      Bindings        =   "Form6.frx":00A3
      Height          =   1620
      Left            =   11520
      TabIndex        =   61
      Top             =   6120
      Visible         =   0   'False
      Width           =   1935
      _ExtentX        =   3413
      _ExtentY        =   2858
      _Version        =   393216
      BackColor       =   14737632
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      RightToLeft     =   -1  'True
   End
   Begin MSDBCtls.DBList DBList12 
      Bindings        =   "Form6.frx":00BA
      Height          =   2895
      Left            =   4680
      TabIndex        =   55
      ToolTipText     =   "F8 ··»ÕÀ ›Ì «·»œ«Ì…  , F9 ··»ÕÀ ⁄‰ ﬂ·„… , ENTER ··«Œ Ì«— , ESC ··Œ—ÊÃ , F2 ·«∆Õ… «·„‰«’»"
      Top             =   5640
      Visible         =   0   'False
      Width           =   3975
      _ExtentX        =   7011
      _ExtentY        =   5106
      _Version        =   393216
      BackColor       =   14737632
      ForeColor       =   0
      ListField       =   "SUB_NAME"
      BoundColumn     =   "sub_cod"
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
   Begin VB.TextBox searcher1 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   4680
      RightToLeft     =   -1  'True
      TabIndex        =   54
      Top             =   5160
      Visible         =   0   'False
      Width           =   3975
   End
   Begin MSDBCtls.DBList DBList5 
      Bindings        =   "Form6.frx":00D2
      DataField       =   " "
      Height          =   1815
      Left            =   13440
      TabIndex        =   53
      Top             =   6120
      Visible         =   0   'False
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   3201
      _Version        =   393216
      BackColor       =   14737632
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      RightToLeft     =   -1  'True
   End
   Begin MSAdodcLib.Adodc rel_digit 
      Height          =   690
      Left            =   15240
      Top             =   9120
      Visible         =   0   'False
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   1217
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
      RecordSource    =   "select* from view_digit "
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
      Left            =   1920
      MaxLength       =   2000
      MultiLine       =   -1  'True
      RightToLeft     =   -1  'True
      TabIndex        =   50
      Top             =   7800
      Width           =   17535
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   1200
      Top             =   5520
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.TextBox m_art_pg_no 
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
      Height          =   285
      Left            =   6000
      MaxLength       =   5
      RightToLeft     =   -1  'True
      TabIndex        =   32
      Top             =   3600
      Width           =   735
   End
   Begin MSMask.MaskEdBox m_mn_ent_dte 
      Height          =   375
      Left            =   3720
      TabIndex        =   28
      Top             =   360
      Width           =   1935
      _ExtentX        =   3413
      _ExtentY        =   661
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
   Begin VB.CommandButton Command9 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Œ‹‹—ÊÃ"
      Height          =   735
      Left            =   240
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   27
      Top             =   5760
      Width           =   975
   End
   Begin VB.CommandButton Command2 
      BackColor       =   &H00FFFFFF&
      Caption         =   "”Ã· ÃœÌœ"
      Height          =   615
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   240
      Width           =   975
   End
   Begin MSDBCtls.DBList DBList3 
      Bindings        =   "Form6.frx":00E9
      Height          =   2400
      Left            =   1560
      TabIndex        =   26
      Top             =   4080
      Visible         =   0   'False
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   4233
      _Version        =   393216
      Appearance      =   0
      BackColor       =   14737632
      ListField       =   "mn_act_ttl"
      RightToLeft     =   -1  'True
   End
   Begin VB.CommandButton Command8 
      BackColor       =   &H00FFFFFF&
      Caption         =   "«·»ÕÀ »«·⁄‰Ê«‰"
      Height          =   615
      Left            =   240
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   25
      Top             =   5040
      Width           =   975
   End
   Begin VB.TextBox m_mn_app_no 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   17400
      MaxLength       =   7
      RightToLeft     =   -1  'True
      TabIndex        =   24
      Top             =   600
      Width           =   975
   End
   Begin VB.TextBox searcher 
      Alignment       =   1  'Right Justify
      BackColor       =   &H0080FFFF&
      Height          =   285
      Left            =   9960
      RightToLeft     =   -1  'True
      TabIndex        =   22
      Top             =   4080
      Visible         =   0   'False
      Width           =   2415
   End
   Begin MSRDC.MSRDC coding5 
      Height          =   375
      Left            =   -360
      Top             =   8760
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
      RecordSource    =   "select *from view_coding5"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "coding5"
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
      Bindings        =   "Form6.frx":00FE
      DataField       =   "RES_APP_TY"
      DataSource      =   "res1"
      Height          =   1815
      Left            =   13320
      TabIndex        =   21
      Top             =   4440
      Visible         =   0   'False
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   3201
      _Version        =   393216
      BackColor       =   14737632
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      RightToLeft     =   -1  'True
   End
   Begin VB.CommandButton Command3 
      BackColor       =   &H00FFFFFF&
      Caption         =   "«· Õ·Ì·"
      Height          =   615
      Left            =   240
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   7440
      Width           =   975
   End
   Begin VB.TextBox m_mn_act_ttl 
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
      Height          =   285
      Left            =   6360
      MaxLength       =   125
      RightToLeft     =   -1  'True
      TabIndex        =   0
      Top             =   2520
      Width           =   12015
   End
   Begin VB.TextBox m_mn_add_ttl 
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
      Height          =   285
      Left            =   6360
      MaxLength       =   125
      RightToLeft     =   -1  'True
      TabIndex        =   1
      Top             =   3000
      Width           =   12015
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H00FFFFFF&
      Caption         =   " ”ÃÌ·"
      Height          =   615
      Left            =   240
      MaskColor       =   &H000080FF&
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   960
      Width           =   975
   End
   Begin VB.CommandButton Command5 
      BackColor       =   &H00FFFFFF&
      Caption         =   "”«»ﬁ"
      Height          =   615
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   7
      Top             =   3480
      Width           =   975
   End
   Begin VB.CommandButton Command4 
      BackColor       =   &H00FFFFFF&
      Caption         =   "·«Õ‹‹ﬁ"
      Height          =   615
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   8
      Top             =   4320
      Width           =   975
   End
   Begin VB.CommandButton Command6 
      BackColor       =   &H00FFFFFF&
      Caption         =   "«·€‹‹«¡"
      Height          =   615
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   2640
      Width           =   975
   End
   Begin VB.CommandButton Command7 
      BackColor       =   &H00FFFFFF&
      Caption         =   "»Õ‹‹À"
      Height          =   615
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   1800
      Width           =   975
   End
   Begin MSRDC.MSRDC AUTHER 
      Height          =   450
      Left            =   3000
      Top             =   9120
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
      RecordSource    =   "SELECT * FROM AUTHER"
      UserName        =   ""
      Password        =   ""
      Connect         =   ""
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
   Begin MSRDC.MSRDC view_coding29 
      Height          =   375
      Left            =   9000
      Top             =   9120
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
      RecordSource    =   "select * from VIEW_coding29"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "view_coding29"
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
   Begin MSRDC.MSRDC article 
      Height          =   375
      Left            =   5760
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
      RecordSource    =   ""
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "article"
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
   Begin MSRDC.MSRDC MSRDC1 
      Height          =   330
      Left            =   5640
      Top             =   9360
      Visible         =   0   'False
      Width           =   4290
      _ExtentX        =   7567
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
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "MSRDC1"
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
   Begin MSMask.MaskEdBox m_art_dte 
      Height          =   375
      Left            =   3600
      TabIndex        =   29
      Top             =   1560
      Width           =   1935
      _ExtentX        =   3413
      _ExtentY        =   661
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
   Begin MSMask.MaskEdBox m_art_dte1 
      Height          =   375
      Left            =   3600
      TabIndex        =   30
      Top             =   2040
      Width           =   1935
      _ExtentX        =   3413
      _ExtentY        =   661
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
   Begin MSRDC.MSRDC config 
      Height          =   375
      Left            =   1680
      Top             =   9240
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
      RecordSource    =   "select   * from config"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "config"
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
   Begin MSRDC.MSRDC op_art 
      Height          =   375
      Left            =   0
      Top             =   9120
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
      RecordSource    =   " "
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "op_art"
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
   Begin MSRDC.MSRDC coding30 
      Height          =   375
      Left            =   3840
      Top             =   9240
      Visible         =   0   'False
      Width           =   1815
      _ExtentX        =   3201
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
      RecordSource    =   "select *from view_coding30"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "coding5"
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
      Left            =   5160
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
   Begin MSRDC.MSRDC coding25 
      Height          =   375
      Left            =   7440
      Top             =   9000
      Visible         =   0   'False
      Width           =   1815
      _ExtentX        =   3201
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
      RecordSource    =   "select * from view_coding25"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "coding25"
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
   Begin VB.TextBox m_mn_typ 
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
      Height          =   285
      Left            =   2040
      MaxLength       =   7
      RightToLeft     =   -1  'True
      TabIndex        =   49
      Top             =   3600
      Width           =   495
   End
   Begin MSRDC.MSRDC coding26 
      Height          =   375
      Left            =   9240
      Top             =   9240
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
      RecordSource    =   "select * from view_coding26"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "coding26"
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
      Height          =   450
      Left            =   7320
      Top             =   8520
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
   Begin MSDataGridLib.DataGrid DataGrid1 
      Bindings        =   "Form6.frx":0114
      Height          =   1575
      Left            =   1800
      TabIndex        =   52
      ToolTipText     =   "INSERT ··«œŒ«· «·”Ã· , SPACE «·«Œ Ì«— "
      Top             =   5760
      Width           =   17655
      _ExtentX        =   31141
      _ExtentY        =   2778
      _Version        =   393216
      AllowUpdate     =   -1  'True
      BackColor       =   16777215
      HeadLines       =   2
      RowHeight       =   19
      RowDividerStyle =   1
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
         Size            =   9.75
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ColumnCount     =   17
      BeginProperty Column00 
         DataField       =   "DIG_SER"
         Caption         =   "«· ”·”·"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   12289
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column01 
         DataField       =   "dig_typ_high"
         Caption         =   "‰Ê⁄ «·„·› high"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   12289
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column02 
         DataField       =   "desc_typ1"
         Caption         =   "‘ﬂ· «·ÊÀÌﬁ…"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   12289
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column03 
         DataField       =   "DIG_TYP"
         Caption         =   "‰Ê⁄ «·„·›"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   12289
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column04 
         DataField       =   "DIG_DIG_NO"
         Caption         =   "—ﬁ„ digital"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   12289
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column05 
         DataField       =   "desc_typmat"
         Caption         =   "‰Ê⁄ «·„«œ…"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   12289
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column06 
         DataField       =   "DIG_SIZE"
         Caption         =   "ÕÃ„ «·„·›"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "0.00"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   12289
            SubFormatType   =   1
         EndProperty
      EndProperty
      BeginProperty Column07 
         DataField       =   "DIG_O"
         Caption         =   "” - „‰"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   12289
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column08 
         DataField       =   "DIG_M"
         Caption         =   "œ - „‰"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   12289
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column09 
         DataField       =   "DIG_S"
         Caption         =   "À - „‰"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   12289
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column10 
         DataField       =   "DIG_O1"
         Caption         =   "” - «·Ï"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   12289
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column11 
         DataField       =   "DIG_M1"
         Caption         =   "œ - «·Ï "
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   12289
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column12 
         DataField       =   "DIG_S1"
         Caption         =   "À - «·Ï"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   12289
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column13 
         DataField       =   "DIG_newNOCHRT"
         Caption         =   "«·«—‘Ì› «·ÃœÌœ"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   12289
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column14 
         DataField       =   "DIG_NOCHRT"
         Caption         =   "«·«—‘Ì› «·ﬁœÌ„"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   12289
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column15 
         DataField       =   "desc_typchrt"
         Caption         =   "‰Ê⁄ «·‘—Ìÿ"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   12289
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column16 
         DataField       =   "desc_geo"
         Caption         =   "„ﬂ«‰ «· ’ÊÌ—/«·‰‘—"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   12289
            SubFormatType   =   0
         EndProperty
      EndProperty
      SplitCount      =   1
      BeginProperty Split0 
         MarqueeStyle    =   2
         SizeMode        =   1
         Size            =   2
         BeginProperty Column00 
            DividerStyle    =   3
            Locked          =   -1  'True
            ColumnWidth     =   915.024
         EndProperty
         BeginProperty Column01 
            Object.Visible         =   -1  'True
            ColumnWidth     =   915.024
         EndProperty
         BeginProperty Column02 
            Locked          =   -1  'True
            ColumnWidth     =   1005.165
         EndProperty
         BeginProperty Column03 
            ColumnWidth     =   705.26
         EndProperty
         BeginProperty Column04 
            ColumnWidth     =   1739.906
         EndProperty
         BeginProperty Column05 
            Locked          =   -1  'True
            Object.Visible         =   -1  'True
            ColumnWidth     =   794.835
         EndProperty
         BeginProperty Column06 
            ColumnWidth     =   750.047
         EndProperty
         BeginProperty Column07 
            DividerStyle    =   5
            ColumnWidth     =   494.929
         EndProperty
         BeginProperty Column08 
            DividerStyle    =   5
            ColumnWidth     =   494.929
         EndProperty
         BeginProperty Column09 
            DividerStyle    =   1
            ColumnWidth     =   494.929
         EndProperty
         BeginProperty Column10 
            DividerStyle    =   5
            ColumnWidth     =   494.929
         EndProperty
         BeginProperty Column11 
            DividerStyle    =   5
            ColumnWidth     =   494.929
         EndProperty
         BeginProperty Column12 
            DividerStyle    =   5
            ColumnWidth     =   494.929
         EndProperty
         BeginProperty Column13 
            Object.Visible         =   -1  'True
            ColumnWidth     =   1379.906
         EndProperty
         BeginProperty Column14 
            ColumnWidth     =   1080
         EndProperty
         BeginProperty Column15 
            Locked          =   -1  'True
            ColumnWidth     =   1739.906
         EndProperty
         BeginProperty Column16 
            Locked          =   -1  'True
            ColumnWidth     =   1739.906
         EndProperty
      EndProperty
   End
   Begin MSAdodcLib.Adodc period1 
      Height          =   330
      Left            =   11280
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
   Begin MSAdodcLib.Adodc coding3 
      Height          =   450
      Left            =   3840
      Top             =   9120
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
   Begin MSAdodcLib.Adodc coding2 
      Height          =   330
      Left            =   9840
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
      RecordSource    =   "SELECT * FROM VIEW_CODING2"
      Caption         =   " coding2"
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
   Begin MSAdodcLib.Adodc coding_typ1 
      Height          =   330
      Left            =   9840
      Top             =   8520
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
   Begin VB.CommandButton Command19 
      BackColor       =   &H00FFFFFF&
      Caption         =   "› Õ ’·«ÕÌ…"
      Height          =   735
      Left            =   240
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   68
      Top             =   6600
      Width           =   975
   End
   Begin MSDataListLib.DataCombo m_art_lang 
      Bindings        =   "Form6.frx":012C
      Height          =   315
      Left            =   13200
      TabIndex        =   77
      Top             =   3600
      Width           =   1215
      _ExtentX        =   2143
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
   Begin MSRDC.MSRDC ranj 
      Height          =   375
      Left            =   12000
      Top             =   9240
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
   Begin MSDataGridLib.DataGrid DataGrid2 
      Bindings        =   "Form6.frx":0143
      Height          =   1455
      Left            =   1800
      TabIndex        =   81
      ToolTipText     =   "INSERT ··«œŒ«· «·”Ã· , SPACE «·«Œ Ì«— "
      Top             =   4200
      Width           =   17655
      _ExtentX        =   31141
      _ExtentY        =   2566
      _Version        =   393216
      AllowUpdate     =   0   'False
      BackColor       =   16777215
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
      Caption         =   "ÃœÊ· «·„”ƒÊ·Ì… «·»Ì«‰Ì…"
      ColumnCount     =   6
      BeginProperty Column00 
         DataField       =   "RES_APP_NO"
         Caption         =   "RES_APP_NO"
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
         DataField       =   "typ_aut"
         Caption         =   "‰Ê⁄ «·„”ƒÊ·Ì… «·»Ì«‰Ì…"
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
         DataField       =   "AUT_NAM"
         Caption         =   "«·„”ƒÊ· «·»Ì«‰Ì"
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
         DataField       =   "RES_APP_TY"
         Caption         =   "typ_aut"
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
         DataField       =   "RES_RES_NO"
         Caption         =   "RES_RES_NO"
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
         DataField       =   "Expr1"
         Caption         =   "Expr1"
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
            Object.Visible         =   0   'False
            ColumnWidth     =   1080
         EndProperty
         BeginProperty Column01 
            ColumnWidth     =   3000.189
         EndProperty
         BeginProperty Column02 
            ColumnWidth     =   4004.788
         EndProperty
         BeginProperty Column03 
            Object.Visible         =   0   'False
            ColumnWidth     =   1739.906
         EndProperty
         BeginProperty Column04 
            Object.Visible         =   0   'False
            ColumnWidth     =   1739.906
         EndProperty
         BeginProperty Column05 
            Object.Visible         =   0   'False
            ColumnWidth     =   915.024
         EndProperty
      EndProperty
   End
   Begin VB.Label Label20 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00808080&
      Caption         =   "ÃœÊ· —»ÿ «·ÊÀ«∆ﬁ «·—ﬁ„Ì… »«·»Ì«‰« "
      Height          =   255
      Left            =   5280
      RightToLeft     =   -1  'True
      TabIndex        =   80
      Top             =   5760
      Width           =   6375
   End
   Begin VB.Label tit_istext 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00808080&
      ForeColor       =   &H00000000&
      Height          =   495
      Left            =   120
      RightToLeft     =   -1  'True
      TabIndex        =   79
      Top             =   8880
      Width           =   1095
   End
   Begin VB.Label Label19 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "«··€…"
      Height          =   255
      Left            =   14400
      TabIndex        =   78
      Top             =   3600
      Width           =   495
   End
   Begin VB.Label Label18 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "—ﬁ„ «·⁄œœ"
      Height          =   255
      Left            =   5040
      TabIndex        =   76
      Top             =   3600
      Width           =   855
   End
   Begin VB.Label Label15 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "«·„” Œ·’ :"
      Height          =   495
      Left            =   18720
      TabIndex        =   51
      Top             =   7320
      Width           =   735
   End
   Begin VB.Label Label21 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "ÿ»Ì⁄… «·ÊÀÌﬁ… ⁄ ‹ ⁄·‰Ì ° ” ‹ ”—Ì"
      Height          =   495
      Left            =   2640
      TabIndex        =   48
      Top             =   3600
      Width           =   1575
   End
   Begin VB.Label Label14 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "⁄œœ «·’›Õ«  "
      Height          =   375
      Left            =   6840
      TabIndex        =   31
      Top             =   3600
      Width           =   735
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H0080FFFF&
      Caption         =   "«·»ÕÀ"
      Height          =   255
      Left            =   11400
      RightToLeft     =   -1  'True
      TabIndex        =   23
      Top             =   3960
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "«·—ﬁ„ :"
      Height          =   255
      Left            =   18360
      TabIndex        =   20
      Top             =   600
      Width           =   855
   End
   Begin VB.Shape Shape2 
      Height          =   975
      Left            =   1800
      Top             =   360
      Width           =   17775
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   " «—ÌŒ «·«œŒ«· "
      Height          =   255
      Left            =   5520
      TabIndex        =   19
      Top             =   480
      Width           =   1455
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "«·⁄‰Ê«‰ «·›⁄·Ì "
      Height          =   495
      Left            =   18480
      TabIndex        =   18
      Top             =   2520
      Width           =   855
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "«·⁄‰Ê«‰ «·À«‰ÊÌ"
      Height          =   375
      Left            =   18600
      TabIndex        =   17
      Top             =   3000
      Width           =   735
   End
   Begin VB.Label Label6 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "„œŒ· «·»Ì«‰« "
      Height          =   255
      Left            =   18360
      TabIndex        =   16
      Top             =   1080
      Width           =   1095
   End
   Begin VB.Label Label7 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "«·„ÊÀﬁ"
      Height          =   255
      Left            =   5520
      TabIndex        =   15
      Top             =   960
      Width           =   1215
   End
   Begin VB.Shape Shape3 
      Height          =   975
      Left            =   1800
      Top             =   1440
      Width           =   17775
   End
   Begin VB.Label Label8 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "„’œ— «·ÊÀÌﬁ…"
      Height          =   375
      Left            =   18480
      TabIndex        =   14
      Top             =   1560
      Width           =   975
   End
   Begin VB.Label Label9 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   " «—ÌŒ «·ÊÀÌﬁ…"
      Height          =   255
      Left            =   5280
      TabIndex        =   13
      Top             =   1560
      Width           =   1455
   End
   Begin VB.Label Label10 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   " «—ÌŒ «· —Ã„…"
      Height          =   255
      Left            =   5280
      RightToLeft     =   -1  'True
      TabIndex        =   12
      Top             =   2040
      Width           =   1455
   End
   Begin VB.Label Label11 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "„’œ— «· —Ã„…"
      Height          =   375
      Left            =   18360
      TabIndex        =   11
      Top             =   2040
      Width           =   1095
   End
   Begin VB.Shape Shape4 
      Height          =   1095
      Left            =   1800
      Top             =   2400
      Width           =   17775
   End
   Begin VB.Label Label13 
      Alignment       =   2  'Center
      BackColor       =   &H00808080&
      Caption         =   "‰Ê⁄ «·ÊÀ»ﬁ…"
      Height          =   255
      Left            =   18480
      TabIndex        =   10
      Top             =   3600
      Width           =   975
   End
   Begin VB.Shape Shape5 
      Height          =   615
      Left            =   1680
      Top             =   3480
      Width           =   17895
   End
   Begin VB.Shape Shape6 
      Height          =   9255
      Left            =   120
      Top             =   120
      Width           =   1215
   End
   Begin VB.Shape Shape7 
      BorderColor     =   &H80000007&
      Height          =   8895
      Left            =   1920
      Top             =   120
      Width           =   18255
   End
End
Attribute VB_Name = "Form6"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim typ_serh As Variant
Dim mod_typ As Variant
Dim typ_prog As Variant
Dim m_bookmark As Integer
Dim m_mod_typ As Integer
Dim m_ser_digit As Integer
Dim m_col As Integer
Dim m_row As Integer
Dim m_nodelete As Integer

Function display_fld()
On Error Resume Next
 typ_serh = 2
If Not MSRDC1.Resultset.EOF Or Not MSRDC1.Resultset.BOF Then

m_mn_app_no.Text = MSRDC1.Resultset![mn_app_no]
If Not IsNull(MSRDC1.Resultset![MN_ENT_DTE]) Then
  m_mn_ent_dte.Text = Format(MSRDC1.Resultset![MN_ENT_DTE], "dd/mm/yyyy")
Else
 m_mn_ent_dte.Text = "__/__/____"
 End If
If Not IsNull(MSRDC1.Resultset![MN_ACT_TTL]) Then
 m_mn_act_ttl.Text = MSRDC1.Resultset![MN_ACT_TTL]
 Else
 m_mn_act_ttl.Text = ""
 End If
If Not IsNull(MSRDC1.Resultset![MN_Add_ttl]) Then
  m_mn_add_ttl.Text = MSRDC1.Resultset![MN_Add_ttl]
 Else
  m_mn_add_ttl.Text = ""
 End If
 If Not IsNull(MSRDC1.Resultset![mn_trans]) Then
  box_mn_trans = MSRDC1.Resultset![mn_trans]
 Else
  box_mn_trans = 0
 End If
  If Not IsNull(MSRDC1.Resultset![MN_data_en]) Then
    m_mn_data_en.BoundText = "02" + MSRDC1.Resultset![MN_data_en]
   Else
      m_mn_data_en.BoundText = Space(2)
   End If
   If Not IsNull(MSRDC1.Resultset![MN_APP_DOC]) Then
  m_mn_app_doc.BoundText = "01" + MSRDC1.Resultset![MN_APP_DOC]
 Else
   m_mn_app_doc.BoundText = Space(2)
  End If
  
   If Not IsNull(MSRDC1.Resultset![MN_result]) Then
  m_mn_result.Text = MSRDC1.Resultset![MN_result]
 Else
  m_mn_result.Text = ""
 End If
  
   If Not IsNull(MSRDC1.Resultset![MN_typ]) Then
      m_mn_typ.Text = MSRDC1.Resultset![MN_typ]
 Else
      m_mn_typ.Text = ""
 End If
If Not m_mn_app_no.Text = "" Then
article.sql = "execute ARTICLE_MAIN " & "'" & m_mn_app_no.Text & "'"
article.Refresh
If Not article.Resultset.EOF Or Not article.Resultset.BOF Then
If Not IsNull(article.Resultset![art_per_no]) Then
  If article.Resultset![art_per_no] <> 0 Then
 m_art_per_no.BoundText = article.Resultset![art_per_no]
 Else
 m_art_per_no.Text = ""
 End If
Else
m_art_per_no.Text = ""
End If
If Not IsNull(article.Resultset![art_per1]) Then
 If article.Resultset![art_per1] <> 0 Then
   m_art_per1.BoundText = article.Resultset![art_per1]
   Else
  m_art_per1.Text = ""
End If
 Else
 m_art_per1.Text = ""
 End If
If Not IsNull(article.Resultset![art_dte]) Then
  M_art_dte.Text = Format(article.Resultset![art_dte], "dd/mm/yyyy")
Else
 M_art_dte.Text = "__/__/____"
End If
If Not IsNull(article.Resultset![art_dte1]) Then
  M_art_dte1.Text = Format(article.Resultset![art_dte1], "dd/mm/yyyy")
Else
   M_art_dte1.Text = "__/__/____"
End If
 
If Not IsNull(article.Resultset![art_pg_no]) Then
  m_art_pg_no.Text = article.Resultset![art_pg_no]
Else
  m_art_pg_no.Text = ""
End If
If Not IsNull(article.Resultset![art_no]) Then
  m_art_no.Text = article.Resultset![art_no]
Else
  m_art_no.Text = ""
End If
If Not IsNull(article.Resultset![art_sub_ty]) Then
   m_art_sub_ty.BoundText = "03" + article.Resultset![art_sub_ty]
Else
 m_art_sub_ty.BoundText = Space(2)
End If
 If Not IsNull(article.Resultset![art_lang1]) Then
   m_art_lang.BoundText = "34" + article.Resultset![art_lang1]
Else
 m_art_lang.BoundText = Space(2)
End If
End If
If box_mn_trans = 1 Then
 DataGrid1.AllowUpdate = False
Else
 DataGrid1.AllowUpdate = True
End If
 res2.RecordSource = "execute res_proc1 " & "'" & m_mn_app_no.Text & "'"
    res2.Refresh
    rel_digit.RecordSource = "execute rel_digit_proc " & "'" & m_mn_app_no.Text & "'"
   rel_digit.Refresh
                   m_mch_stock = ""
    If Not rel_digit.Recordset.EOF Or Not rel_digit.Recordset.EOF Then
      While Not rel_digit.Recordset.EOF Or Not rel_digit.Recordset.EOF
       If Not IsNull(rel_digit.Recordset![dig_ser]) Then
         m_ser_digit = rel_digit.Recordset![dig_ser]
       Else
         m_ser_digit = 0
       End If
        If Not IsNull(rel_digit.Recordset![dig_typ1]) Then
           If rel_digit.Recordset![dig_typ1] = "04" Then
              If Not IsNull(rel_digit.Recordset![dig_DIG_NO]) Then
                m_mch_stock = rel_digit.Recordset![dig_DIG_NO]
                V_MCH_STOCK = m_mch_stock
              End If
              If Not IsNull(rel_digit.Recordset![dig_o]) Then
                v_mch_o = rel_digit.Recordset![dig_o]
              End If
                If Not IsNull(rel_digit.Recordset![dig_m]) Then
                v_mch_m = rel_digit.Recordset![dig_m]
              End If
               If Not IsNull(rel_digit.Recordset![dig_s]) Then
                v_mch_s = rel_digit.Recordset![dig_s]
              End If
               If Not IsNull(rel_digit.Recordset![dig_o1]) Then
                v_mch_o1 = rel_digit.Recordset![dig_o1]
              End If
               If Not IsNull(rel_digit.Recordset![dig_m1]) Then
                v_mch_m1 = rel_digit.Recordset![dig_m1]
              End If
               If Not IsNull(rel_digit.Recordset![dig_s1]) Then
                v_mch_s1 = rel_digit.Recordset![dig_s1]
              End If
           End If
         End If
       rel_digit.Recordset.MoveNext
      Wend
   Else
     m_ser_digit = 0
  End If
DataGrid1.Refresh
op_art.sql = "execute serh_text2 " & "'" & m_mn_app_no.Text & "'"
  op_art.Refresh
     
               
    If Not op_art.Resultset.EOF Or Not op_art.Resultset.BOF Then
    is_text = True
     tit_istext.Caption = ""
     tit_istext.Caption = "ÌÊÃœ ‰’"
    Else
     is_text = False
     tit_istext.Caption = ""
    tit_istext.Caption = "·« ÌÊÃœ ‰’"
    End If
End If

Else
 MsgBox "·« ÌÊÃœ «” „«—… ·Â–« «·—ﬁ„ !!!!"
End If

End Function

Private Sub Command1_Click()
' Dim cn As New rdoConnection
If Not m_mn_app_no.Text = "" Then
 Dim sql As String
 'Dim m_date As Date
If is_trans(box_mn_trans) Then
'SRDC1.Resultset.
 If m_mn_ent_dte.Text = "__/__/____" Then
    m_ent_dte = ""
    Else
     m_ent_dte = m_mn_ent_dte.Text
 End If
If M_art_dte.Text = "__/__/____" Then
    m_dte = ""
    Else
     m_dte = M_art_dte.Text
 End If
If M_art_dte1.Text = "__/__/____" Then
    m_dte1 = ""
    Else
     m_dte1 = M_art_dte1.Text
 End If
 
             sql = "execute upd_main " & "'" & m_mn_app_no.Text & "'" & "," _
      & "'" & m_mn_act_ttl.Text & "'" & "," _
       & "'" & m_mn_add_ttl.Text & "'" & "," & "'" & Mid(m_mn_data_en.BoundText, 3, 2) & "'" & "," _
       & "'" & Mid(m_mn_app_doc.BoundText, 3, 2) & "'" & "," & "'" & Format(m_ent_dte, "yyyy/mm/dd") & "'" & "," _
       & "'" & m_mn_result.Text & "'" & "," & "'" & m_mn_typ.Text & "'"
                cn.Execute sql, rdExecDirect

 
      sql = "execute upd_article2 " & "'" & m_mn_app_no.Text & "'" & "," & "'" & m_art_per_no.BoundText & "'" & "," _
       & "'" & m_art_per1.BoundText & "'" & "," _
      & "'" & Mid(m_art_sub_ty.BoundText, 3, 2) & "'" & "," & "'" & Format(m_dte, "yyyy/mm/dd") & "'" & "," & "'" & Format(m_dte1, "yyyy/mm/dd") & "'" _
      & "," & "'" & m_art_pg_no.Text & "'" & "," & "'" & Val(m_art_no.Text) & "'" & "," & "'" & Mid(m_art_lang.BoundText, 3, 2) & "'"
       
          cn.Execute sql, rdExecDirect
          
                 
End If
Else
   MsgBox " —ﬁ„ «·«” „«—… ›«—€ ÌÃ» «‰  ÷€ÿ ⁄·Ï ”Ã· ÃœÌœ"
   Command1.SetFocus
   
  End If

End Sub

Private Sub Command10_Click()
Frame4.Visible = False
Command7.SetFocus

End Sub

Private Sub Command11_Click()
  Dim sql As String
  Dim m_no As Variant
  Dim v_no   As Variant
  
 If M_YESNO.Text = "y" Or M_YESNO.Text = "‰" Or M_YESNO.Text = "Y" Then
  sql = "exec del_main " & "'" & m_mn_app_no.Text & "'"
  cn.Execute sql, rdExecDirect
  sql = "exec del_article " & "'" & m_mn_app_no.Text & "'"
  cn.Execute sql, rdExecDirect
  sql = "exec del_res " & "'" & m_mn_app_no.Text & "'"
  cn.Execute sql, rdExecDirect
  
   sql = "exec del_digit1 " & "'" & m_mn_app_no.Text & "'"
  cn.Execute sql, rdExecDirect
  rel_digit.Refresh
       sql = "exec del_analis2 " & "'" & m_mn_app_no.Text & "'"
           cn.Execute sql, rdExecDirect
           
       sql = "exec del_geo2 " & "'" & m_mn_app_no.Text & "'"
       cn.Execute sql, rdExecDirect
       sql = "exec del_rel2 " & "'" & m_mn_app_no.Text & "'"
       cn.Execute sql, rdExecDirect
       sql = "exec del_nar2 " & "'" & m_mn_app_no.Text & "'"
       cn.Execute sql, rdExecDirect
       sql = "exec del_fad2 " & "'" & m_mn_app_no.Text & "'"
           cn.Execute sql, rdExecDirect
v_no = Mid(m_mn_app_no.Text, 2, 6)

m_mn_app_no.Text = ""
m_mn_ent_dte.Text = "__/__/____"
m_mn_data_en.Text = ""
m_mn_app_doc.Text = ""
m_art_per_no.Text = ""
m_art_per1.Text = ""
m_mn_act_ttl.Text = ""
m_mn_add_ttl.Text = ""
M_art_dte.Text = "__/__/____"
M_art_dte1.Text = "__/__/____"
m_art_sub_ty.Text = ""
m_art_pg_no.Text = ""
'm_mn_app_no.SetFocus

'If Val(v_no) = config.Resultset![number_main] Then
'  m_no = config.Resultset![number_main]
''  m_no = m_no - 1
 ' SQL = "execute upd_config " & "'" & m_no & "'"
 '    cn.Execute SQL, rdExecDirect
 '   config.Refresh
'End If
Frame1.Visible = False
Command6.SetFocus
 End If
 End Sub

Private Sub Command12_Click()
On Error Resume Next
Dim sql As String
 MSRDC1.sql = "exec SERCH_main " & "'" & m_ist_no.Text & "'"
 MSRDC1.Refresh
 typ_serh = 2
  V_MCH_STOCK = ""
If Not MSRDC1.Resultset.EOF Or Not MSRDC1.Resultset.BOF Then
 Call display_fld
Else
 MsgBox "·« ÌÊÃœ «” „«—… ·Â–« «·—ﬁ„ !!!!"
End If
Frame4.Visible = False


End Sub

Private Sub Command12_KeyPress(KeyAscii As Integer)

 If KeyAscii = 27 Then
   Frame4.Visible = False
   Command7.SetFocus
  End If
End Sub

Private Sub Command13_Click()
Frame1.Visible = False
Command6.SetFocus

End Sub

Private Sub Command14_Click()
Frame5.Visible = False
Command3.SetFocus
End Sub

Private Sub Command14_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
 Frame5.Visible = False
 Command3.SetFocus
End If
End Sub

Private Sub Command15_Click()
     Frame5.Visible = False
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form2.WindowState = 2
 Form2.Show
 Screen.MousePointer = vbDefault

End Sub

Private Sub Command15_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
 Frame5.Visible = False
 Command3.SetFocus
End If
End Sub

Private Sub Command16_Click()
  If is_trans(box_mn_trans) Then
 If m_mn_ent_dte.Text = "__/__/____" Then
    m_ent_dte = ""
    Else
     m_ent_dte = m_mn_ent_dte.Text
 End If
If M_art_dte.Text = "__/__/____" Then
    m_dte = ""
    Else
     m_dte = M_art_dte.Text
 End If
If M_art_dte1.Text = "__/__/____" Then
    m_dte1 = ""
    Else
     m_dte1 = M_art_dte1.Text
 End If
  
  sql = "execute upd_main " & "'" & m_mn_app_no.Text & "'" & "," _
      & "'" & m_mn_act_ttl.Text & "'" & "," _
       & "'" & m_mn_add_ttl.Text & "'" & "," & "'" & Mid(m_mn_data_en.BoundText, 3, 2) & "'" & "," _
       & "'" & Mid(m_mn_app_doc.BoundText, 3, 2) & "'" & "," & "'" & Format(m_ent_dte, "yyyy/mm/dd") & "'" & "," _
              & "'" & m_mn_result.Text & "'" & "," & "'" & m_mn_typ.Text & "'"
                cn.Execute sql, rdExecDirect

 
      sql = "execute upd_article2 " & "'" & m_mn_app_no.Text & "'" & "," & "'" & m_art_per_no.BoundText & "'" & "," _
       & "'" & m_art_per1.BoundText & "'" & "," _
      & "'" & Mid(m_art_sub_ty.BoundText, 3, 2) & "'" & "," & "'" & Format(m_dte, "yyyy/mm/dd") & "'" & "," & "'" & Format(m_dte1, "yyyy/mm/dd") & "'" _
      & "," & "'" & m_art_pg_no.Text & "'" & "," & "'" & Val(m_art_no.Text) & "'" & "," & "'" & Mid(m_art_lang.BoundText, 3, 2) & "'"
       
        
     
   cn.Execute sql, rdExecDirect
          
    '  SQL = "execute upd_main_vd " & "'" & m_mn_app_no.Text & "'" & "," _
    '  & "'" & m_mn_chrt_no.Text & "'" & "," _
    '   & "'" & Val(m_mn_size.Text) & "'" & "," & "'" & Val(m_mn_o.Text) & "'" & "," & "'" & _
    '   Val(m_mn_m.Text) & "'" & "," & "'" & Val(m_mn_s.Text) & "'" & "," & _
    '   "'" & Val(m_mn_o1.Text) & "'" & "," & "'" & Val(m_mn_m1.Text) & "'" & "," & "'" & Val(m_mn_s1.Text) & "'" & "," & "'" & _
    '   Mid(m_mn_pic.BoundText, 3, 2) & "'" & "," _
    '   & "'" & Mid(m_mn_voi.BoundText, 3, 2) & "'" & "," & "'" & m_mn_typ.Text & "'"
    '            cn.Execute SQL, rdExecDirect
     End If
                Frame5.Visible = False
               
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form2.WindowState = 2
 Form2.Show
 Screen.MousePointer = vbDefault

End Sub

Private Sub Command16_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
 Frame5.Visible = False
 Command3.SetFocus
End If
End Sub

 
Private Sub Command17_Click()
  Frame2.Visible = False
  DataGrid1.SetFocus


End Sub

Private Sub Command18_Click()
On Error Resume Next
 Dim sql As String
 If Not m_mn_app_no.Text = "" Then
 
  If Not IsNull(rel_digit.Recordset![dig_typ1]) Then
       m_dig_typ1 = rel_digit.Recordset![dig_typ1]
    m_no = DataGrid1.Columns(4)
    M_DIG_TYP = DataGrid1.Columns(3)
    m_cnf_path = ""
 If Not IsNull(rel_digit.Recordset![dig_typ1]) And Not IsNull(rel_digit.Recordset![dig_DIG_NO]) Then
       If m_dig_typ1 = "01" Then
          m_cnf_path = m_cnf_path_pic + "scan\"
        ElseIf m_dig_typ1 = "02" Then
         m_cnf_path = m_cnf_path_pic + "waves\"
        ElseIf m_dig_typ1 = "03" Then
         m_cnf_path = m_cnf_path_pic + "photos\"
        ElseIf m_dig_typ1 = "05" Then
         m_cnf_path = m_cnf_path_pic + "private\"
       End If

    m_target_path = m_cnf_path & Mid(m_no, 2, 2) & "\" & Mid(m_no, 4, 2) & "\" & m_no & "." & M_DIG_TYP
    m_file = Dir(m_target_path)
    If m_file <> "" Then
      MsgBox "Â–« «·„·› „ÊÃÊœ ›Ì «·‘Ã—… ÌÃ» «·€«¡Â «Ê·« „‰Â«"
    Else
     m_ser = DataGrid1.Columns(0)
     If m_ser = m_ser_digit Then
      m_ser_digit = m_ser_digit - 1
     End If
     End If
     Else
     m_ser = DataGrid1.Columns(0)
     If m_ser = m_ser_digit Then
      m_ser_digit = m_ser_digit - 1
     End If
     End If
     Else
     m_ser = DataGrid1.Columns(0)
     If m_ser = m_ser_digit Then
      m_ser_digit = m_ser_digit - 1
     End If
     End If
     
     sql = "execute del_digit " & "'" & m_mn_app_no.Text & "'" & "," & "'" & m_ser & "'"
                cn.Execute sql, rdExecDirect
      
      rel_digit.Refresh
       DataGrid1.Refresh
 Frame2.Visible = False
  DataGrid1.SetFocus
  End If
  
End Sub

Private Sub Command19_Click()
On Error Resume Next
If Not m_mn_app_no.Text = "" Then
 
Frame3.Visible = True
If box_mn_trans = 1 Then
Label17.Caption = "«·ÊÀÌﬁ… „ﬁ›·…"
Else
Label17.Caption = "«·ÊÀÌﬁ… „› ÊÕ…"
End If
m_user_password.SetFocus
m_user_password.Text = ""

Else
   MsgBox " —ﬁ„ «·«” „«—… ›«—€ ÌÃ» «‰  ÷€ÿ ⁄·Ï ”Ã· ÃœÌœ"
   Command2.SetFocus
   
  End If
'
End Sub

Private Sub Command2_Click()
Dim v_prs_no As Variant
m_ser_digit = 0

 V_MCH_STOCK = ""
mod_typ = 1
m_mn_app_no.Text = ""
m_mn_ent_dte.Text = Format(Date, "dd/mm/yyyy")
m_mn_data_en.BoundText = "02" + box_user_ent
m_mn_app_doc.BoundText = "01" + box_user_doc
m_art_per_no.Text = ""
m_art_per1.Text = ""
m_art_per_no.Text = ""
m_art_per1.Text = ""
m_mn_act_ttl.Text = ""
m_mn_add_ttl.Text = ""
M_art_dte.Text = "__/__/____"
M_art_dte1.Text = "__/__/____"
m_art_lang.Text = ""
m_art_sub_ty.Text = ""
m_art_pg_no.Text = ""
 m_art_no.Text = ""
m_mn_typ.Text = ""
 m_mn_result.Text = ""
 m_art_lang.BoundText = "3401"
 m_mn_typ.Text = "⁄"
box_mn_trans = 0
 DataGrid1.AllowUpdate = True
sql = "execute op_article"
      cn.Execute sql, rdExecDirect
     
op_art.sql = "execute max_article"
op_art.Refresh
m_mn_app_no.Text = op_art.Resultset![max1]
'SQL = "execute insr_mn " & "'" & m_mn_app_no.Text & "'"
'     cn.Execute SQL
 MSRDC1.sql = "exec SERCH_main " & "'" & m_mn_app_no.Text & "'"
 MSRDC1.Refresh
 m_art_per_no.SetFocus
 period1.Refresh
End Sub

Private Sub Command20_Click()
If Not m_mn_app_no.Text = "" And box_mn_trans = 1 Then
  If LTrim(m_user_password.Text) = "891045" Then
 sql = "execute upd_main_trans " & "'" & m_mn_app_no.Text & "'"
  cn.Execute sql, rdExecDirect
  box_mn_trans = 0
 DataGrid1.AllowUpdate = True
 
  Else
   MsgBox "ﬂ·„… «·”— Œÿ«....ø"
  End If
  End If
  Frame3.Visible = False
 End Sub

Private Sub Command21_Click()
Frame3.Visible = False
End Sub

Private Sub Command22_Click()
 op_art.sql = "execute max_article"
op_art.Refresh
m_mn_app_no.Text = op_art.Resultset![max1]
 
 MSRDC1.sql = "exec SERCH_main " & "'" & m_mn_app_no.Text & "'"
 MSRDC1.Refresh
 If Not MSRDC1.Resultset.EOF Or Not MSRDC1.Resultset.BOF Then
     Call display_fld
    End If
End Sub

Private Sub Command23_Click()
Dim M_O, m_m, m_s As Integer
Dim m_time As Double
m_time = MediaPlayer1.currentPosition - 1
M_O = Int(m_time / 3600)
M_REST1 = m_time Mod 3600
m_m = Int(M_REST1 / 60)
m_s = M_REST1 Mod 60
If m_mch_o1 = "" Then
 m_mch_o1 = M_O
 
End If
If m_mch_m1 = "" Then
 m_mch_m1 = m_m
 
End If
If m_mch_s1 = "" Then
 m_mch_s1 = m_s
 
End If
DataGrid1.Columns(10) = M_O
DataGrid1.Columns(11) = m_m
DataGrid1.Columns(12) = m_s
 m_row = rel_digit.Recordset.Bookmark - 1
   rel_digit.Recordset.Requery
 rel_digit.Recordset.Move (m_row)
End Sub

Private Sub Command24_Click()
MediaPlayer1.Rate = 2
End Sub

Private Sub Command25_Click()
MediaPlayer1.Rate = 1
End Sub

Private Sub Command3_Click()
'On Error Resume Next
' Dim cn As New rdoConnection
If Not m_mn_app_no.Text = "" Then
 Dim sql As String
 Dim is_save As String
  If m_mn_ent_dte.Text = "__/__/____" Then
      m_ent_dte = ""
    Else
      m_ent_dte = m_mn_ent_dte.Text
 End If
If M_art_dte.Text = "__/__/____" Then
    m_dte = ""
    Else
     m_dte = M_art_dte.Text
 End If
If M_art_dte1.Text = "__/__/____" Then
    m_dte1 = ""
    Else
     m_dte1 = M_art_dte1.Text
 End If

 If mod_typ = 1 Then
    If is_trans(box_mn_trans) Then

'    SQL = "execute insr_main " & "'" & m_mn_app_no.Text & "'" & "," _
'      & "'" & m_mn_act_ttl.Text & "'" & "," _
'      & "'" & m_mn_add_ttl.Text & "'" & "," & "'" & Mid(m_mn_data_en.BoundText, 3, 2) & "'" & "," _
'       & "'" & Mid(m_mn_app_doc.BoundText, 3, 2) & "'" & "," & "'" & Format(m_ent_dte, "yyyy/mm/dd") & "'"
'
'               cn.Execute SQL, rdExecDirect
      sql = "execute upd_main " & "'" & m_mn_app_no.Text & "'" & "," _
      & "'" & m_mn_act_ttl.Text & "'" & "," _
       & "'" & m_mn_add_ttl.Text & "'" & "," & "'" & Mid(m_mn_data_en.BoundText, 3, 2) & "'" & "," _
       & "'" & Mid(m_mn_app_doc.BoundText, 3, 2) & "'" & "," & "'" & Format(m_ent_dte, "yyyy/mm/dd") & "'" & "," _
      & "'" & m_mn_result.Text & "'" & "," & "'" & m_mn_typ.Text & "'"
                cn.Execute sql, rdExecDirect



 
sql = "execute upd_article2 " & "'" & m_mn_app_no.Text & "'" & "," & "'" & m_art_per_no.BoundText & "'" & "," _
       & "'" & m_art_per1.BoundText & "'" & "," _
      & "'" & Mid(m_art_sub_ty.BoundText, 3, 2) & "'" & "," & "'" & Format(m_dte, "yyyy/mm/dd") & "'" & "," & "'" & Format(m_dte1, "yyyy/mm/dd") & "'" _
       & "," & "'" & m_art_pg_no.Text & "'" & "," & "'" & Val(m_art_no.Text) & "'" & "," & "'" & Mid(m_art_lang.BoundText, 3, 2) & "'"
       
      
       
          cn.Execute sql, rdExecDirect
            
 '         SQL = "execute upd_main_vd " & "'" & m_mn_app_no.Text & "'" & "," _
 '     & "'" & m_mn_chrt_no.Text & "'" & "," _
 '      & "'" & Val(m_mn_size.Text) & "'" & "," & "'" & Val(m_mn_o.Text) & "'" & "," & "'" & _
 '      Val(m_mn_m.Text) & "'" & "," & "'" & Val(m_mn_s.Text) & "'" & "," & _
 '      "'" & Val(m_mn_o1.Text) & "'" & "," & "'" & Val(m_mn_m1.Text) & "'" & "," & "'" & Val(m_mn_s1.Text) & "'" & "," & "'" & _
 '      Mid(m_mn_pic.BoundText, 3, 2) & "'" & "," _
 '      & "'" & Mid(m_mn_voi.BoundText, 3, 2) & "'" & "," & "'" & m_mn_typ.Text & "'"
 '               cn.Execute SQL, rdExecDirect
      mod_typ = 2
      End If
      Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form2.WindowState = 2
 Form2.Show
 Screen.MousePointer = vbDefault

Else
'  is_save = "'"
'  is_save = InputBox("Â·  —Ìœ  ”ÃÌ· «·„⁄·Ê„«  ‰/ﬂ)")
' If is_save = "y" Or is_save = "‰" Then
  Frame5.Visible = True
   Command16.SetFocus
 End If

Else
   MsgBox " —ﬁ„ «·«” „«—… ›«—€ ÌÃ» «‰  ÷€ÿ ⁄·Ï ”Ã· ÃœÌœ"
   Command2.SetFocus
   
  End If
End Sub

Private Sub Command4_Click()
'  On Error Resume Next
Dim m_max As Variant

    op_art.sql = "execute max_article"
    op_art.Refresh
    m_max = Mid(op_art.Resultset![max1], 2, 6)
   v_mn_no = "000000"
   m_no = Mid(m_mn_app_no.Text, 2, 6)
   v_no = Val(m_no)
    lg = 1
 Do While v_no <= Val(m_max) And lg = 1
   v_no = v_no + 1
   v_mn_no = Mid(v_mn_no, 1, 6 - Len(Trim(Str(v_no)))) + Trim(Str(v_no))
   v_mn_no = "ﬁ" + v_mn_no
   MSRDC1.sql = "exec SERCH_main " & "'" & v_mn_no & "'"
   MSRDC1.Refresh
   typ_serh = 2
    If Not MSRDC1.Resultset.EOF Or Not MSRDC1.Resultset.BOF Then
     Call display_fld
     lg = 0
    End If
  
Loop
If v_no > Val(m_max) Then
  MsgBox "·« ÌÊÃœ «” „«—… ·«Õﬁ…"
End If
End Sub

Private Sub Command5_Click()
On Error Resume Next
 v_mn_no = "000000"
 m_no = Mid(m_mn_app_no.Text, 2, 6)
 v_no = Val(m_no)
  lg = 1
 Do While lg = 1 And v_no > 1
   v_no = v_no - 1
   v_mn_no = Mid(v_mn_no, 1, 6 - Len(Trim(Str(v_no)))) + Trim(Str(v_no))
   v_mn_no = "ﬁ" + v_mn_no
   MSRDC1.sql = "exec SERCH_main " & "'" & v_mn_no & "'"
   MSRDC1.Refresh
   typ_serh = 2
    If Not MSRDC1.Resultset.EOF Or Not MSRDC1.Resultset.BOF Then
     Call display_fld
    lg = 0
  End If
Loop
If lg = 1 Then

  op_art.sql = "execute max_article"
op_art.Refresh
m_mn_app_no.Text = op_art.Resultset![max1]
 
 MSRDC1.sql = "exec SERCH_main " & "'" & m_mn_app_no.Text & "'"
 MSRDC1.Refresh
 If Not MSRDC1.Resultset.EOF Or Not MSRDC1.Resultset.BOF Then
     Call display_fld
    End If
End If
End Sub

Private Sub Command6_Click()
If is_trans(box_mn_trans) Then
Frame1.Visible = True
M_YESNO.Text = ""
M_YESNO.SetFocus
End If

 End Sub

Private Sub Command7_Click()
'Dim cn As New rdoConnection
Frame4.Visible = True
m_ist_no.SetFocus
m_ist_no.Text = ""


End Sub

Private Sub Command8_Click()
'Dim cn As New rdoConnection
Dim sql As String
Dim m_desc As String
Const None As String = ""
m_desc = ""
m_desc = InputBox("«œŒ· «·⁄‰Ê«‰ «·›⁄·Ì : ")
If Not IsNull(m_desc) And Not Trim(m_desc) = "" Then
  m_len = Len(m_desc)
  m_typ_ist = "ﬁ"
  MSRDC1.sql = "exec SERH_main " & "'" & m_desc & "'" & "," & "'" & m_len & "'" _
                                   & "," & "'" & m_typ_ist & "'" & "," & "'" & m_typ_ist & "'"
  MSRDC1.Refresh
  typ_serh = 2
  If Not MSRDC1.Resultset.EOF Or Not MSRDC1.Resultset.BOF Then
     DBList3.Visible = True
     DBList3.SetFocus
     SendKeys "{up}"
Else
 MsgBox "·« ÌÊÃœ «” „«—… ·Â–« «·—ﬁ„ !!!!"
End If
End If
End Sub

Private Sub Command9_Click()
Unload Form6
End Sub

Private Sub DataGrid1_AfterColEdit(ByVal ColIndex As Integer)
'On Error Resume Next
If Not rel_digit.Recordset.BOF Or Not rel_digit.Recordset.EOF Then
m_nodelete = 1
  If (DataGrid1.Col > 2 And DataGrid1.Col < 15 And DataGrid1.Col <> 5) Or DataGrid1.Col = 1 Then
m_row = rel_digit.Recordset.Bookmark - 1
    rel_digit.Recordset.Requery
rel_digit.Recordset.Move (m_row)
 End If
End If
End Sub

 

 
Private Sub datagrid1_DblClick()
On Error Resume Next
m_row = DataGrid1.Row

If Not rel_digit.Recordset.BOF Then
m_cnf_path = ""
 m_dig_typ1 = rel_digit.Recordset![dig_typ1]
  If Not m_dig_typ1 = "04" And Not m_dig_typ1 = "02" Then
       If m_dig_typ1 = "01" Then
          m_cnf_path = m_cnf_path_pic + "scan\"
        
        ElseIf m_dig_typ1 = "03" Then
         m_cnf_path = m_cnf_path_pic + "photos\"
         ElseIf m_dig_typ1 = "05" Then
         m_cnf_path = m_cnf_path_pic + "private\"
       End If
M_DIG_TYP = Trim(DataGrid1.Columns(3))
V_REC = DataGrid1.Columns(4)
M_NAM1 = Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\" & V_REC & "." & M_DIG_TYP
'M_NAM1 = V_REC & "." & m_dig_typ
m_x = m_cnf_path & M_NAM1
   m_file = Dir(m_x)
    If m_file <> "" Then
      Call OpenDoc(m_x)
     Else
      MsgBox ("Â–« «·„·› €Ì— „ÊÃÊœ ›Ì «·«—‘Ì›...." & m_x)
      
     End If
     
     Else
     nb_page = 1
  '  Frame3.Visible = True
  '    m_step.SetFocus
     If Not IsEmpty(DataGrid1.Columns(3)) Then
      v_mch_typ = Trim(DataGrid1.Columns(3))

      Else
      v_mch_typ = ""
      End If
     V_REC = DataGrid1.Columns(4)
      V_MCH_STOCK = V_REC
       ' m_config_path = m_cnf_path_pic + "avi\"
       v_mch_digtyp = m_dig_typ1
       If m_dig_typ1 = "02" Then
       M_NAM1 = Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\"
         m_config_path = m_cnf_path_pic + "waves\" + M_NAM1
        Else
          m_config_path = m_STCOK_path_new(V_MCH_STOCK)
      End If
        v_mch_o = DataGrid1.Columns(7)
        v_mch_m = DataGrid1.Columns(8)
        v_mch_s = DataGrid1.Columns(9)
        v_mch_o1 = DataGrid1.Columns(10)
        v_mch_m1 = DataGrid1.Columns(11)
        v_mch_s1 = DataGrid1.Columns(12)
   '     Dim m_acrh_no  As Integer
   '     m_time = Val(v_mch_s) + Val(v_mch_m) * 60 + Val(v_mch_o) * 3600
   '     m_time1 = Val(v_mch_s1) + Val(v_mch_m1) * 60 + Val(v_mch_o1) * 3600
   '     deb_tm = m_time
   '      m_tm = m_time
   '      m_tm1 = m_time1
        
   '     If m_time1 <> 0 And m_time1 > m_time Then
   '        M_NAM = m_config_path + Trim(m_mch_stock) + ".avi"
   '        MediaPlayer1.FileName = M_NAM
   '        MediaPlayer1.Pause
   '        MediaPlayer1.SelectionStart = m_time
   '        MediaPlayer1.Play
   '        MediaPlayer1.Pause
    '      Else
    '        MsgBox "«‰ »Â Êﬁ  ‰Â«Ì… «·„‘Âœ ...."
    '     End If
         Screen.MousePointer = vbDefault
         Screen.MousePointer = vbHourglass
         vd_preview.WindowState = 0
          vd_preview.Show
' vd_prv.Show

           Screen.MousePointer = vbDefault
 
    vd_preview.Refresh

       End If
     
End If


Exit_DataGrid3_DblClick:
    Exit Sub

Err_Msg:
    MsgBox "·«  „·ﬂ «·’·«ÕÌ… ·› Õ «·„·› „‰ «·«—‘Ì›....."
    Resume Exit_DataGrid3_DblClick
End Sub

Private Sub DataGrid1_KeyDown(KeyCode As Integer, Shift As Integer)
On Error Resume Next
If Not rel_digit.Recordset.BOF Or Not rel_digit.Recordset.BOF Then
If KeyCode = vbKeyF5 Then
If is_trans(box_mn_trans) Then
m_ser_digit = m_ser_digit + 1
'    If rel_digit.Recordset.BOF Then
      sql = "execute op_digit " & "'" & m_mn_app_no.Text & "'" & "," & _
                                "'" & m_ser_digit & "'"
       cn.Execute sql, rdExecDirect
       rel_digit.Refresh
       DataGrid1.SetFocus
       
End If
End If
End If
End Sub

Private Sub datagrid1_KeyPress(KeyAscii As Integer)
On Error Resume Next
If Not rel_digit.Recordset.BOF Or Not rel_digit.Recordset.BOF Then
If Not m_mn_app_no.Text = "" Then
  
  
 If KeyAscii = 32 Then
 If is_trans(box_mn_trans) Then
  
  m_row = rel_digit.Recordset.Bookmark - 1

  
     If DataGrid1.Col = 2 Then
         DataGrid1.Enabled = False
         
          DBList4.Visible = True
          DBList4.SetFocus
          ElseIf DataGrid1.Col = 15 Then
           DataGrid1.Enabled = False
           DBList5.Visible = True
          DBList5.SetFocus
          ElseIf DataGrid1.Col = 16 Then
           DataGrid1.Enabled = False
           DBList12.Visible = True
          searcher1.Visible = True
          searcher1.SetFocus
          ElseIf DataGrid1.Col = 5 Then
            DataGrid1.Enabled = False
           DBList6.Visible = True
          DBList6.SetFocus
       ElseIf DataGrid1.Col = 4 Then
        If IsNull(DataGrid1.Columns(4)) Or LTrim(DataGrid1.Columns(4)) = "" Then
       If Not IsNull(rel_digit.Recordset![dig_typ1]) Then
      m_dig_typ1 = rel_digit.Recordset![dig_typ1]
        '  m_dig_typ1 = DataGrid1.Columns(2)
          m_ser = DataGrid1.Columns(0)
  If m_dig_typ1 <> "04" Then
     CommonDialog1.ShowOpen
     
  If Not CommonDialog1.FileName = "" Then
  '    m_len = Len(Trim(CommonDialog1.FileName))
  ' m_typ_storge = Mid(Trim(CommonDialog1.FileName), m_len - 2, 3)
   m_len = Len(Trim(CommonDialog1.FileName))
 '  m_typ_storge = Mid(Trim(CommonDialog1.FileName), m_len - 2, 3)
    m_typ_storge = Mid(Trim(CommonDialog1.FileName), m_len - 3, 4)
   If Mid(m_typ_storge, 1, 1) = "." Then
     m_typ_storge = Mid(m_typ_storge, 2, 3)
    End If
   '  m_ser_digit = m_ser_digit + 1
'    If rel_digit.Recordset.BOF Then
      sql = "execute op_digit " & "'" & m_mn_app_no.Text & "'" & "," & _
                                "'" & m_ser & "'" & "," & "'" & m_dig_typ1 & "'" _
                                & "," & "'" & m_typ_storge & "'"
       cn.Execute sql, rdExecDirect
        MSRDC1.sql = "execute max_digit" & "'" & m_dig_typ1 & "'"
        MSRDC1.Refresh
       m_no = MSRDC1.Resultset![max1]
    '   LG = 1
'     Else
'      lg = 0
m_cnf_path = ""
 
       If m_dig_typ1 = "01" Then
          m_cnf_path = m_cnf_path_pic + "scan\"
        ElseIf m_dig_typ1 = "02" Then
         m_cnf_path = m_cnf_path_pic + "waves\"
        ElseIf m_dig_typ1 = "03" Then
         m_cnf_path = m_cnf_path_pic + "photos\"
         ElseIf m_dig_typ1 = "05" Then
         m_cnf_path = m_cnf_path_pic + "private\"
       End If
     m_name = CommonDialog1.FileName
     m_source = m_name
    m_target_path = m_cnf_path & Mid(m_no, 1, 2) & "\" & Mid(m_no, 3, 2) & "\" & m_no & "." & m_typ_storge
     m_file = Dir(m_target_path)
    If m_file <> "" Then
      MsgBox "Â–« «·„·› „œŒ· ”«»ﬁ«"
    Else
     FileCopy m_source, m_target_path
     MsgBox "copy the number  " & m_no_disp & " to archive"
             '  SQL = "execute upd_digit1 " & "'" & m_mn_app_no.Text & "'" & "," & "'" & m_ser_digit & "'" _
             '    & "," & "'" & m_typ_storge & "'" & "," & "'" & m_no & "'"
             '   cn.Execute SQL, rdExecDirect
            
 
          
       End If
       rel_digit.Refresh
        DataGrid1.Refresh
          
       rel_digit.Recordset.Move (m_row)
        DataGrid1.Col = 0
       End If
       End If
       End If
       End If
       End If
  
       End If
  ElseIf KeyAscii = 27 Then
   m_mn_result.SetFocus
    
  
       End If
       '  DataGrid1.Enabled = True
       Else
   MsgBox " —ﬁ„ «·«” „«—… ›«—€ ÌÃ» «‰  ÷€ÿ ⁄·Ï ”Ã· ÃœÌœ"
   m_mn_result.SetFocus
   
  End If
  End If
End Sub

Private Sub DataGrid1_KeyUp(KeyCode As Integer, Shift As Integer)
On Error Resume Next
 
If Not m_mn_app_no.Text = "" Then
 If KeyCode = vbKeyDelete Then
 If is_trans(box_mn_trans) Then
     Frame2.Visible = True
     m_yesno1.SetFocus
     End If
     
ElseIf KeyCode = vbKeyInsert Then
If is_trans(box_mn_trans) Then

       m_ser_digit = m_ser_digit + 1
       sql = "execute insr_digit1 " & "'" & m_mn_app_no.Text & "'" & "," & "'" & m_ser_digit & "'"
        cn.Execute sql, rdExecDirect
        If Not rel_digit.Recordset.EOF And Not rel_digit.Recordset.BOF Then
            m_row = rel_digit.Recordset.Bookmark - 1
                   Else
                    m_row = 0
                  End If
        rel_digit.Refresh
'        DataGrid1.Refresh
       rel_digit.Recordset.Move (m_row)
         DataGrid1.SetFocus
         
'    ElseIf KeyCode = vbKeyDown Or KeyCode = vbKeyUp Or KeyCode = vbKeyPageUp Or KeyCode = vbKeyPageDown Then
'      If DataGrid1.Columns(2) = "„ﬁ«·…" Or DataGrid1.Columns(2) = "photo" Then
'      DataGrid1.Columns(6).Visible = False
'      DataGrid1.Columns(7).Visible = False
'        DataGrid1.Columns(8).Visible = False
'         DataGrid1.Columns(9).Visible = False
'          DataGrid1.Columns(10).Visible = False
'           DataGrid1.Columns(11).Visible = False
'            DataGrid1.Columns(12).Visible = False
'             DataGrid1.Columns(14).Visible = False
'            DataGrid1.Columns(15).Visible = False
'           '  DataGrid1.Columns(16).Visible = False
'        ElseIf DataGrid1.Columns(2) = "’Ê Ì" Then
'        DataGrid1.Columns(6).Visible = True
'        DataGrid1.Columns(7).Visible = True
'        DataGrid1.Columns(8).Visible = True
'         DataGrid1.Columns(9).Visible = True
'
'        DataGrid1.Columns(10).Visible = False
'           DataGrid1.Columns(11).Visible = False
'            DataGrid1.Columns(12).Visible = False
'             DataGrid1.Columns(14).Visible = False
'            DataGrid1.Columns(15).Visible = False
'      Else
'      DataGrid1.Columns(6).Visible = True
'        DataGrid1.Columns(7).Visible = True
'        DataGrid1.Columns(8).Visible = True
'         DataGrid1.Columns(9).Visible = True
'          DataGrid1.Columns(10).Visible = True
 '          DataGrid1.Columns(11).Visible = True
''            DataGrid1.Columns(12).Visible = True
 '             DataGrid1.Columns(14).Visible = True
 '           DataGrid1.Columns(15).Visible = True
 '           ' DataGrid1.Columns(16).Visible = True
             
 '    End If

    End If
End If
  Else
   MsgBox " —ﬁ„ «·«” „«—… ›«—€ ÌÃ» «‰  ÷€ÿ ⁄·Ï ”Ã· ÃœÌœ"
   m_mn_result.SetFocus
   
  End If
  
End Sub


 
  
Private Sub DataGrid2_KeyPress(KeyAscii As Integer)
On Error Resume Next
'Dim cn As New rdoConnection
 Dim sql As String
'MsgBox KeyAscii
 If KeyAscii = 32 Then
 If Not (res2.Recordset.EOF And res2.Recordset.BOF) Then
 If is_trans(box_mn_trans) Then
   If DataGrid2.Col = 1 Then
       DBList2.Visible = True
       DBList2.SetFocus
    Else
      DBList1.Visible = True
      DBList1.SetFocus
    End If
    End If
    End If
 ElseIf KeyAscii = 73 Or KeyAscii = 229 Then
 If is_trans(box_mn_trans) Then
  m_res_no = 0
  m_res_typ = "01"
  sql = "execute insr_res " & "'" & m_mn_app_no.Text & "'" & "," & "'" & m_res_typ & "'" & "," _
      & "'" & m_res_no & "'"
     
              cn.Execute sql, rdExecDirect
    
    res2.Refresh
    DataGrid2.Refresh


    End If
ElseIf KeyAscii = 27 Then
DataGrid1.SetFocus
'  SendKeys "{up}"

 End If
End Sub

Private Sub DataGrid2_KeyUp(KeyCode As Integer, Shift As Integer)
 Dim sql As String
On Error Resume Next
If Not m_mn_app_no.Text = "" Then
If KeyCode = vbKeyInsert Then
If is_trans(box_mn_trans) Then
 m_res_no = 0
  m_res_typ = "01"
  sql = "execute insr_res " & "'" & m_mn_app_no.Text & "'" & "," & "'" & m_res_typ & "'" & "," _
      & "'" & m_res_no & "'"
      
              cn.Execute sql, rdExecDirect
    res2.Refresh
    DataGrid2.Refresh
     
    End If
  ElseIf KeyCode = vbKeyDelete Then
     If is_trans(box_mn_trans) Then

      m_auther = DataGrid2.Columns(4)
     sql = "execute del_res1 " & "'" & m_mn_app_no.Text & "'" & "," & "'" & m_auther & "'"
     
                cn.Execute sql, rdExecDirect
      
   
    res2.Refresh
    DataGrid2.Refresh
    End If
End If
 Else
   MsgBox " —ﬁ„ «·«” „«—… ›«—€ ÌÃ» «‰  ÷€ÿ ⁄·Ï ”Ã· ÃœÌœ"
   DataGrid1.SetFocus
   
  End If
End Sub

 
Private Sub DBList12_KeyPress(KeyAscii As Integer)
On Error Resume Next
Dim sql As String
  If KeyAscii = 13 Then
   m_row = rel_digit.Recordset.Bookmark - 1
    m_typ_auther = DBList12.BoundText
    m_ser = DataGrid1.Columns(0)
  '  MsgBox m_typ_auther & m_typ_aut1
     sql = "execute upd_rel_digit2 " & "'" & m_mn_app_no.Text & "'" & "," & "'" & m_typ_auther & "'" _
       & "," & "'" & m_ser & "'"
                cn.Execute sql, rdExecDirect
      
    DBList12.Visible = False
   searcher1.Visible = False
    rel_digit.Refresh
    DataGrid1.Enabled = True
    DataGrid1.Refresh
    DataGrid1.SetFocus
     rel_digit.Recordset.Move (m_row)
    ElseIf KeyAscii = 27 Then
      DBList12.Visible = False
       searcher1.Visible = False
       DataGrid1.Enabled = True
      DataGrid1.SetFocus
  End If
End Sub

Private Sub DBList4_KeyPress(KeyAscii As Integer)
'On Error Resume Next
 Dim sql As String
 
  If KeyAscii = 13 Then
   m_row = rel_digit.Recordset.Bookmark - 1
    m_typ_auther = Mid(DBList4.BoundText, 3, 2)
    m_ser = DataGrid1.Columns(0)
  
     sql = "execute upd_rel_digit " & "'" & m_mn_app_no.Text & "'" & "," & "'" & m_typ_auther & "'" _
       & "," & "'" & m_ser & "'"
                cn.Execute sql, rdExecDirect
     
    DBList4.Visible = False
    rel_digit.Refresh
    DataGrid1.Enabled = True
    DataGrid1.Refresh
    DataGrid1.SetFocus
    rel_digit.Recordset.Move (m_row)
      If m_typ_auther = "04" Then
        DataGrid1.Columns(3).value = "avi"
        DataGrid1.Columns(1).value = "avi"
         rel_digit.Recordset.Requery
      End If
       
    ElseIf KeyAscii = 27 Then
      DBList4.Visible = False
      DataGrid1.Enabled = True
      DataGrid1.SetFocus
  End If
End Sub

Private Sub Dirlist_Change()
fillist.Path = Dirlist.Path
fillist.Refresh

End Sub

Private Sub drvlist_Change()
 On Error GoTo DriveHandler
   ' If new drive was selected, the Dir1 box
   ' updates its display.
   Dirlist.Path = drvlist.Drive
   Dirlist.Refresh
   
   Exit Sub
' If there is an error, reset drvList.Drive with the
' drive from dirList.Path.
DriveHandler:
   drvlist.Drive = Dirlist.Path
   Exit Sub
End Sub

Private Sub fillist_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
   Frame2.Visible = False
 '  DBGrid2.SetFocus
End If
End Sub

Private Sub m_art_flm_typ_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
   DataGrid2.SetFocus
End If
End Sub

Private Sub DBList5_KeyPress(KeyAscii As Integer)
On Error Resume Next
Dim sql As String
  If KeyAscii = 13 Then
     m_row = rel_digit.Recordset.Bookmark - 1
    m_typ_auther = Mid(DBList5.BoundText, 3, 2)
    m_ser = DataGrid1.Columns(0)
  '  MsgBox m_typ_auther & m_typ_aut1
     sql = "execute upd_rel_digit1 " & "'" & m_mn_app_no.Text & "'" & "," & "'" & m_typ_auther & "'" _
       & "," & "'" & m_ser & "'"
                cn.Execute sql, rdExecDirect
      
    DBList5.Visible = False
    'res1.Refresh
    
    rel_digit.Refresh
    DataGrid1.Refresh
     DataGrid1.Enabled = True
    DataGrid1.SetFocus
    rel_digit.Recordset.Move (m_row)
    ElseIf KeyAscii = 27 Then
      DBList5.Visible = False
      DataGrid1.Enabled = True
      DataGrid1.SetFocus
  End If
End Sub

Private Sub DBList6_KeyPress(KeyAscii As Integer)
  On Error Resume Next
  If KeyAscii = 13 Then
     m_row = rel_digit.Recordset.Bookmark - 1
    m_typ_auther = Mid(DBList6.BoundText, 3, 2)
    m_ser = DataGrid1.Columns(0)
  '  MsgBox m_typ_auther & m_typ_aut1
     sql = "execute upd_rel_digit3 " & "'" & m_mn_app_no.Text & "'" & "," & "'" & m_typ_auther & "'" _
       & "," & "'" & m_ser & "'"
                cn.Execute sql, rdExecDirect
      
    DBList6.Visible = False
    'res1.Refresh
    
    rel_digit.Refresh
    DataGrid1.Enabled = True
    DataGrid1.Refresh
    DataGrid1.SetFocus
    rel_digit.Recordset.Move (m_row)
    ElseIf KeyAscii = 27 Then
      DBList6.Visible = False
      DataGrid1.Enabled = True
      DataGrid1.SetFocus
  End If
End Sub

Private Sub m_art_lang_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_art_pg_no.SetFocus
     
 End If

End Sub

Private Sub m_art_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_mn_typ.SetFocus
     
 End If
End Sub

Private Sub m_art_pg_no_Change()
m_len = Len(Trim(m_art_pg_no.Text))
 If m_art_pg_no.MaxLength <= m_len + 1 Then
  m_art_no.SetFocus
   
 End If
End Sub

Private Sub m_art_pg_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_art_no.SetFocus
End If


End Sub

Private Sub m_ist_no_KeyPress(KeyAscii As Integer)
Dim m_no As String
Dim v_prs_no As String

 If KeyAscii = 13 Then
   If Not m_ist_no = "" Then
    v_prs_no = "000000"
     m_no = m_ist_no.Text
     v_prs_no = Mid(v_prs_no, 1, 6 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
     m_ist_no.Text = "ﬁ" + v_prs_no
     Command12.SetFocus
   End If
  ElseIf KeyAscii = 27 Then
   Frame4.Visible = False
   Command7.SetFocus
  End If

End Sub

Private Sub m_mn_act_ttl_Change()
 m_len = Len(Trim(m_mn_act_ttl.Text))
 If m_mn_act_ttl.MaxLength <= m_len + 1 Then
    m_mn_add_ttl.SetFocus
 End If
End Sub

Private Sub m_mn_add_ttl_Change()
m_len = Len(Trim(m_mn_add_ttl.Text))
 If m_mn_add_ttl.MaxLength <= m_len + 1 Then
    m_art_sub_ty.SetFocus
    SendKeys "{f4}"
 End If

End Sub

Private Sub m_mn_chrt_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_mn_size.SetFocus
     
 End If
End Sub

Private Sub m_mn_data_en_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 Then
  m_mn_app_doc.SetFocus
    SendKeys "^{f4}"
 End If
End Sub

Private Sub m_mn_app_doc_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_art_per_no.SetFocus
    SendKeys "^{f4}"
End If
End Sub


Private Sub m_art_per_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_art_dte.SetFocus
End If
End Sub

Private Sub m_art_per1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_art_dte1.SetFocus
End If

End Sub


Private Sub m_art_sub_ty_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 If is_trans(box_mn_trans) Then
  
 Dim sql As String
 'Dim m_date As Date
 
'SRDC1.Resultset.
 If m_mn_ent_dte.Text = "__/__/____" Then
    m_ent_dte = ""
    Else
     m_ent_dte = m_mn_ent_dte.Text
 End If
If M_art_dte.Text = "__/__/____" Then
    m_dte = ""
    Else
     m_dte = M_art_dte.Text
 End If
If M_art_dte1.Text = "__/__/____" Then
    m_dte1 = ""
    Else
     m_dte1 = M_art_dte1.Text
 End If
 
             sql = "execute upd_main " & "'" & m_mn_app_no.Text & "'" & "," _
      & "'" & m_mn_act_ttl.Text & "'" & "," _
       & "'" & m_mn_add_ttl.Text & "'" & "," & "'" & Mid(m_mn_data_en.BoundText, 3, 2) & "'" & "," _
       & "'" & Mid(m_mn_app_doc.BoundText, 3, 2) & "'" & "," & "'" & Format(m_ent_dte, "yyyy/mm/dd") & "'" & "," _
       & "'" & m_mn_result.Text & "'" & "," & "'" & m_mn_typ.Text & "'"
                cn.Execute sql, rdExecDirect

 
      sql = "execute upd_article2 " & "'" & m_mn_app_no.Text & "'" & "," & "'" & m_art_per_no.BoundText & "'" & "," _
       & "'" & m_art_per1.BoundText & "'" & "," _
      & "'" & Mid(m_art_sub_ty.BoundText, 3, 2) & "'" & "," & "'" & Format(m_dte, "yyyy/mm/dd") & "'" & "," & "'" & Format(m_dte1, "yyyy/mm/dd") & "'" _
      & "," & "'" & m_art_pg_no.Text & "'" & "," & "'" & Val(m_art_no.Text) & "'" & "," & "'" & Mid(m_art_lang.BoundText, 3, 2) & "'"
       
          cn.Execute sql, rdExecDirect
          
          m_art_lang.SetFocus
         SendKeys "{f4}"
End If
End If
End Sub

 

 
Private Sub DBList1_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF8 Then
      Label1.Visible = True
      searcher.Text = ""
      searcher.Visible = True
      searcher.SetFocus
  '   SendKeys "{up}"
  ElseIf KeyCode = vbKeyDown Then
   m_bookmark = 2
 End If
End Sub

Private Sub DBList1_KeyPress(KeyAscii As Integer)
' Dim cn As New rdoConnection
 Dim sql As String

  If KeyAscii = 13 Then
    If Not AUTHER.Resultset.EOF Or Not AUTHER.Resultset.BOF Then
     If m_bookmark = 2 Then
       AUTHER.Resultset.Bookmark = DBList1.SelectedItem
     End If
   
    m_auther = AUTHER.Resultset![aut_no]
    
    M_aut1 = DataGrid2.Columns(4)
    m_res_typ = DataGrid2.Columns(3)
     sql = "execute upd_res " & "'" & m_mn_app_no.Text & "'" & "," & "'" & m_auther & "'" _
       & "," & "'" & M_aut1 & "'" & "," & "'" & m_res_typ & "'"
     '  cn.Connect = "uid=;pwd=;server=SEQUEL;" _
     '      & "driver={SQL Server};database=macnz;" _
     '      & "DSN='';"
     '       cn.CursorDriver = rdUseOdbc
     '      cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
      
    DBList1.Visible = False
    'res1.Refresh
    res2.Refresh
    DataGrid2.Refresh
    DataGrid2.SetFocus
 Else
  MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
 End If
 
 ElseIf KeyAscii = 27 Then
      DBList1.Visible = False
      DataGrid2.SetFocus
 
      
End If
End Sub


Private Sub DBList2_KeyPress(KeyAscii As Integer)
' Dim cn As New rdoConnection
 Dim sql As String
  If KeyAscii = 13 Then
    m_typ_auther = Mid(DBList2.BoundText, 3, 2)
    M_aut1 = DataGrid2.Columns(4)
  '  MsgBox m_typ_auther & m_typ_aut1
     sql = "execute upd_res1 " & "'" & m_mn_app_no.Text & "'" & "," & "'" & m_typ_auther & "'" _
       & "," & "'" & M_aut1 & "'"
     '    = "uid=;pwd=;server=SEQUEL;" _
     '      & "driver={SQL Server};database=macnz;" _
     '      & "DSN='';"
     '       cn.CursorDriver = rdUseOdbc
     '      cn.EstablishConnection rdDriverNoPrompt
                cn.Execute sql, rdExecDirect
      
    DBList2.Visible = False
    'res1.Refresh
    res2.Refresh
    DataGrid2.Refresh
    DataGrid2.SetFocus
    ElseIf KeyAscii = 27 Then
      DBList2.Visible = False
      DataGrid2.SetFocus
  End If
End Sub

Private Sub DBList3_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 MSRDC1.Resultset.Bookmark = DBList3.SelectedItem
 DBList3.Visible = False
 m_mn_app_no.Text = MSRDC1.Resultset![mn_app_no]
 Call display_fld
ElseIf KeyAscii = 27 Then
  DBList3.Visible = True
End If
End Sub

Private Sub Form_Activate()
m_nodelete = 1
 
is_text = False
If m_form_load = 1 Then
    mod_typ = 2
   m_bookmark = 1
   typ_serh = 1
   typ_prog = "article"
   'period1.Refresh
  ' Call display_fld
 Else
  MSRDC1.sql = "exec SERCH_main " & "'" & m_bk_no & "'"
  MSRDC1.Refresh
  Call display_fld
End If

End Sub

Private Sub m_mn_m_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_mn_s.SetFocus
     
 End If

End Sub

Private Sub m_mn_m1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_mn_s1.SetFocus
     
 End If

End Sub

Private Sub m_mn_o_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_mn_m.SetFocus
     
 End If

End Sub

Private Sub m_mn_o1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_mn_m1.SetFocus
     
 End If

End Sub

Private Sub m_mn_pic_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_mn_voi.SetFocus
     SendKeys "{f4}"
 End If

End Sub

Private Sub m_mn_s_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_mn_o1.SetFocus
     
 End If

End Sub

Private Sub m_mn_s1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_mn_pic.SetFocus
     SendKeys "{f4}"
 End If

End Sub

Private Sub m_mn_size_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_mn_o.SetFocus
     
 End If

End Sub

Private Sub m_mn_result_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
If Not m_mn_app_no.Text = "" Then

sql = "execute upd_mn_result " & "'" & m_mn_app_no.Text & "'" & "," & "'" & m_mn_result.Text & "'"
                cn.Execute sql, rdExecDirect
  Command3.SetFocus
   Else
   MsgBox " —ﬁ„ «·«” „«—… ›«—€ ÌÃ» «‰  ÷€ÿ ⁄·Ï ”Ã· ÃœÌœ"
   m_mn_result.SetFocus
   
  End If
End If
End Sub

Private Sub m_mn_typ_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  DataGrid2.SetFocus
   ' SendKeys "{up}"
 End If

End Sub

Private Sub m_mn_voi_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_mn_typ.SetFocus
 End If

End Sub

Private Sub m_step_KeyDown(KeyCode As Integer, Shift As Integer)
On Error Resume Next


If KeyCode = 37 Then

Dim wmpos As Double
Dim WmpCurPos As Double
    m_tm = m_tm - 1
    MediaPlayer1.currentPosition = m_tm
    MediaPlayer1.SelectionStart = m_tm
    MediaPlayer1.Play
ElseIf KeyCode = 39 Then
If m_tm + 1 < MediaPlayer1.SelectionEnd Then
 If MediaPlayer1.currentPosition > m_tm Then
 m_tm = MediaPlayer1.currentPosition
 End If

    m_tm = m_tm + 1
    MediaPlayer1.currentPosition = m_tm
     MediaPlayer1.Stop
     MediaPlayer1.Play
End If
  End If

End Sub

Private Sub m_step_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
 Frame3.Visible = False
 DataGrid1.SetFocus
 
 
End If
End Sub

Private Sub m_user_password_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  If Not m_mn_app_no.Text = "" And box_mn_trans = 1 Then
  If LTrim(m_user_password.Text) = "891045" Then
 sql = "execute upd_main_trans " & "'" & m_mn_app_no.Text & "'"
  cn.Execute sql, rdExecDirect
  box_mn_trans = 0
 DataGrid1.AllowUpdate = True
 
  Else
   MsgBox "ﬂ·„… «·”— Œÿ«....ø"
  End If
  End If
  Frame3.Visible = False
  
End If
End Sub

Private Sub M_YESNO_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 Command11.SetFocus
End If
End Sub

Private Sub opr_art_Validate(Action As Integer, Reserved As Integer)

End Sub

Private Sub m_yesno1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Command18.SetFocus
  
End If
End Sub

Private Sub searcher_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
       searcher.Visible = False
       Label1.Visible = False
       m_desc = searcher.Text
       m_len = Len(Trim(m_desc))
       AUTHER.sql = "execute serh_auther " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
       AUTHER.Refresh
       DBList1.Refresh
       DBList1.SetFocus
       m_bookmark = 1
      
       
       
       
    '   SendKeys "{up}"
        If AUTHER.Resultset.EOF Or AUTHER.Resultset.BOF Then
           MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
        End If

    ElseIf KeyAscii = 27 Then
       searcher.Visible = False
       Label1.Visible = False
       DBList1.SetFocus
    End If
       
End Sub




Private Sub m_mn_app_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 If mod_typ = 1 Then
      m_mn_app_no.Text = "ﬁ" + m_mn_app_no.Text
     MSRDC1.sql = "exec SERCH_main " & "'" & m_mn_app_no.Text & "'"
     MSRDC1.Refresh
     m_mn_app_no.Refresh
     typ_serh = 2
   If Not MSRDC1.Resultset.EOF Or Not MSRDC1.Resultset.BOF Then
     MsgBox "Â–« «·—ﬁ„  «»⁄ ·«” „«—… «Œ—Ï!!!!!"
    Else
     m_mn_ent_dte.SetFocus
    End If
  End If
End If
End Sub


Private Sub m_mn_app_no_Change()
If Not IsNull(m_mn_app_no.Text) And Not m_mn_app_no.Text = "" And Not IsEmpty(m_mn_app_no.Text) Then
   res2.RecordSource = "execute res_proc1 " & m_mn_app_no.Text
   res2.Refresh
    rel_digit.RecordSource = "execute rel_digit_proc " & "'" & m_mn_app_no.Text & "'"
   rel_digit.Refresh
  End If

End Sub


Private Sub m_mn_ent_dte_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  If IsDate(m_mn_ent_dte.Text) Or m_mn_ent_dte = "__/__/____" Then
     m_mn_data_en.SetFocus
     SendKeys "^{f4}"
   Else
    m_mn_ent_dte.SetFocus
   End If
  End If

End Sub


 

Private Sub m_art_dte_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  If IsDate(M_art_dte.Text) Or M_art_dte = "__/__/____" Then
     m_art_per1.SetFocus
     SendKeys "^{f4}"
   Else
    M_art_dte.SetFocus
   End If
  End If
End Sub

Private Sub m_mn_act_ttl_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then
   m_mn_add_ttl.SetFocus
End If
End Sub
Private Sub m_mn_add_ttl_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
If is_trans(box_mn_trans) Then
'SRDC1.Resultset.
 If m_mn_ent_dte.Text = "__/__/____" Then
    m_ent_dte = ""
    Else
     m_ent_dte = m_mn_ent_dte.Text
 End If
If M_art_dte.Text = "__/__/____" Then
    m_dte = ""
    Else
     m_dte = M_art_dte.Text
 End If
If M_art_dte1.Text = "__/__/____" Then
    m_dte1 = ""
    Else
     m_dte1 = M_art_dte1.Text
 End If
 
             sql = "execute upd_main " & "'" & m_mn_app_no.Text & "'" & "," _
      & "'" & m_mn_act_ttl.Text & "'" & "," _
       & "'" & m_mn_add_ttl.Text & "'" & "," & "'" & Mid(m_mn_data_en.BoundText, 3, 2) & "'" & "," _
       & "'" & Mid(m_mn_app_doc.BoundText, 3, 2) & "'" & "," & "'" & Format(m_ent_dte, "yyyy/mm/dd") & "'" & "," _
       & "'" & m_mn_result.Text & "'" & "," & "'" & m_mn_typ.Text & "'"
                cn.Execute sql, rdExecDirect

 
      sql = "execute upd_article2 " & "'" & m_mn_app_no.Text & "'" & "," & "'" & m_art_per_no.BoundText & "'" & "," _
       & "'" & m_art_per1.BoundText & "'" & "," _
      & "'" & Mid(m_art_sub_ty.BoundText, 3, 2) & "'" & "," & "'" & Format(m_dte, "yyyy/mm/dd") & "'" & "," & "'" & Format(m_dte1, "yyyy/mm/dd") & "'" _
     & "," & "'" & m_art_pg_no.Text & "'" & "," & "'" & Val(m_art_no.Text) & "'" & "," & "'" & Mid(m_art_lang.BoundText, 3, 2) & "'"
    
          cn.Execute sql, rdExecDirect
          
                 
   '         SQL = "execute upd_main_vd " & "'" & m_mn_app_no.Text & "'" & "," _
   '   & "'" & m_mn_chrt_no.Text & "'" & "," _
   '    & "'" & Val(m_mn_size.Text) & "'" & "," & "'" & Val(m_mn_o.Text) & "'" & "," & "'" & _
   '    Val(m_mn_m.Text) & "'" & "," & "'" & Val(m_mn_s.Text) & "'" & "," & _
   '    "'" & Val(m_mn_o1.Text) & "'" & "," & "'" & Val(m_mn_m1.Text) & "'" & "," & "'" & Val(m_mn_s1.Text) & "'" & "," & "'" & _
   '    Mid(m_mn_pic.BoundText, 3, 2) & "'" & "," _
   '    & "'" & Mid(m_mn_voi.BoundText, 3, 2) & "'" & "," & "'" & m_mn_typ.Text & "'"
   '             cn.Execute SQL, rdExecDirect
   
'End If
End If

  m_art_sub_ty.SetFocus
  SendKeys "{f4}"
  End If
End Sub


Private Sub m_art_dte1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
If IsDate(M_art_dte1.Text) Or M_art_dte1.Text = "__/__/____" Then
     m_mn_act_ttl.SetFocus
   Else
    M_art_dte1.SetFocus
   End If
If KeyAscii = 13 Then
  m_mn_act_ttl.SetFocus
End If
End If
End Sub


Private Sub m_art_flm_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_art_flm_typ.SetFocus
  SendKeys "^{f4}"
'  SendKeys "^{right}"
'  SendKeys "^{right}"
    
End If
End Sub

Private Sub searcher1_Change()
If Not searcher1.Text = "" Then
      m_desc = searcher1.Text
         m_len = Len(Trim(searcher1))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
         DBList12.Refresh
         m_bookmark = 1
       '  SendKeys "{UP}"
       ' DBList12.SelectedItem = DBList12.VisibleItems(1)
        
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If
         End If
End Sub

Private Sub searcher1_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not searcher1.Text = "" Then
    
      DBList12.SetFocus
    
   SendKeys "{UP}"
End If
End Sub

Private Sub searcher1_KeyPress(KeyAscii As Integer)
 If KeyAscii = 27 Then
      DBList12.Visible = False
       searcher1.Visible = False
       DataGrid1.Enabled = True
       
      DataGrid1.SetFocus
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
