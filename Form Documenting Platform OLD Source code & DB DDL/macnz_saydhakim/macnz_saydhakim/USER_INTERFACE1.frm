VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{CDE57A40-8B86-11D0-B3C6-00A0C90AEA82}#1.0#0"; "MSDATGRD.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{6BF52A50-394A-11D3-B153-00C04F79FAA6}#1.0#0"; "wmp.dll"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form USER_INTERFACE1 
   Appearance      =   0  'Flat
   BackColor       =   &H00151515&
   Caption         =   "»—‰«„Ã «·«—‘Ì›"
   ClientHeight    =   11115
   ClientLeft      =   120
   ClientTop       =   630
   ClientWidth     =   18855
   FillColor       =   &H00FF00FF&
   ForeColor       =   &H80000005&
   LinkTopic       =   "Form6"
   RightToLeft     =   -1  'True
   ScaleHeight     =   11115
   ScaleWidth      =   18855
   Begin VB.TextBox m_tit 
      Alignment       =   1  'Right Justify
      BackColor       =   &H009898FC&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   645
      Left            =   8880
      MultiLine       =   -1  'True
      RightToLeft     =   -1  'True
      TabIndex        =   70
      Text            =   "USER_INTERFACE1.frx":0000
      Top             =   6000
      Visible         =   0   'False
      Width           =   10575
   End
   Begin VB.Frame Frame3 
      Caption         =   "«·⁄‰Ê«‰"
      Height          =   5175
      Left            =   1440
      RightToLeft     =   -1  'True
      TabIndex        =   50
      Top             =   6480
      Visible         =   0   'False
      Width           =   8535
      Begin RichTextLib.RichTextBox m_mch_tit 
         Height          =   615
         Left            =   0
         TabIndex        =   61
         Top             =   360
         Width           =   8295
         _ExtentX        =   14631
         _ExtentY        =   1085
         _Version        =   393217
         BackColor       =   16445662
         TextRTF         =   $"USER_INTERFACE1.frx":0006
      End
      Begin RichTextLib.RichTextBox m_mch_result 
         Height          =   2295
         Left            =   240
         TabIndex        =   60
         Top             =   1320
         Width           =   8295
         _ExtentX        =   14631
         _ExtentY        =   4048
         _Version        =   393217
         BackColor       =   16445662
         ScrollBars      =   2
         DisableNoScroll =   -1  'True
         TextRTF         =   $"USER_INTERFACE1.frx":0097
      End
      Begin VB.CommandButton Command23 
         BackColor       =   &H00E0E0E0&
         Caption         =   "«·€« «·«„—"
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
         Left            =   0
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   55
         Top             =   4440
         Width           =   735
      End
      Begin VB.CommandButton Command22 
         BackColor       =   &H00E0E0E0&
         Caption         =   " ”ÃÌ·"
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
         Left            =   0
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   54
         Top             =   3720
         Width           =   735
      End
      Begin VB.TextBox m_mch_user_rmrk 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00ECFDFD&
         Height          =   885
         Left            =   840
         MultiLine       =   -1  'True
         RightToLeft     =   -1  'True
         TabIndex        =   51
         ToolTipText     =   "„·«Õÿ«  ÕÊ· „⁄·Ê„«  ‰«ﬁ’… Ì”Ã·Â« «·„” ›Ìœ ·Ì „  ⁄œÌ·Â« ·«Õﬁ«"
         Top             =   3960
         Width           =   7575
      End
      Begin VB.Label Label6 
         Alignment       =   1  'Right Justify
         Caption         =   "«·„” Œ·’"
         Height          =   255
         Left            =   5760
         RightToLeft     =   -1  'True
         TabIndex        =   53
         Top             =   960
         Width           =   2655
      End
      Begin VB.Label Label2 
         Alignment       =   1  'Right Justify
         Caption         =   "„·«ÕŸ«  «·„” ›Ìœ :"
         Height          =   255
         Left            =   6360
         RightToLeft     =   -1  'True
         TabIndex        =   52
         Top             =   3720
         Width           =   2055
      End
   End
   Begin MSDBCtls.DBList DBList3 
      Bindings        =   "USER_INTERFACE1.frx":0128
      Height          =   3660
      Left            =   13080
      TabIndex        =   15
      Top             =   7440
      Visible         =   0   'False
      Width           =   4695
      _ExtentX        =   8281
      _ExtentY        =   6456
      _Version        =   393216
      Appearance      =   0
      BackColor       =   11923707
      ListField       =   "pos_nam"
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
   Begin MSDBCtls.DBList DBList1 
      Bindings        =   "USER_INTERFACE1.frx":013F
      Height          =   3660
      Left            =   13440
      TabIndex        =   12
      Top             =   7320
      Visible         =   0   'False
      Width           =   4815
      _ExtentX        =   8493
      _ExtentY        =   6456
      _Version        =   393216
      Appearance      =   0
      BackColor       =   11923707
      ForeColor       =   -2147483640
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
   Begin MSDBCtls.DBList DBList2 
      Bindings        =   "USER_INTERFACE1.frx":0157
      Height          =   2940
      Left            =   13560
      TabIndex        =   13
      Top             =   6840
      Visible         =   0   'False
      Width           =   4575
      _ExtentX        =   8070
      _ExtentY        =   5186
      _Version        =   393216
      Appearance      =   0
      BackColor       =   11923707
      ForeColor       =   -2147483640
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
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
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   0
      Top             =   10800
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton Command28 
      Appearance      =   0  'Flat
      BackColor       =   &H00E0CEB4&
      Caption         =   "to"
      Height          =   375
      Left            =   6000
      MaskColor       =   &H00E0CEB4&
      TabIndex        =   58
      Top             =   5520
      Width           =   495
   End
   Begin VB.CommandButton Command27 
      Appearance      =   0  'Flat
      BackColor       =   &H00D1B58D&
      Caption         =   "from"
      Height          =   375
      Left            =   5280
      MaskColor       =   &H00D1B58D&
      TabIndex        =   57
      Top             =   5520
      Width           =   495
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H00C0C0C0&
      Caption         =   "«·€«¡ «” „«—…"
      ForeColor       =   &H8000000E&
      Height          =   1695
      Left            =   1920
      RightToLeft     =   -1  'True
      TabIndex        =   46
      Top             =   9120
      Visible         =   0   'False
      Width           =   3615
      Begin VB.CommandButton Command21 
         BackColor       =   &H00E0E0E0&
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
         Left            =   600
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   48
         Top             =   840
         Width           =   735
      End
      Begin VB.CommandButton Command20 
         BackColor       =   &H00E0E0E0&
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
         Left            =   2280
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   47
         Top             =   840
         Width           =   735
      End
      Begin VB.Label Label1 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "«·€«¡ «·„‘Âœ „‰ «·ÃœÊ· ......ø"
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
         TabIndex        =   49
         Top             =   360
         Width           =   2655
      End
   End
   Begin VB.Frame Frame6 
      BackColor       =   &H00E0CEB4&
      Caption         =   "«·€«¡ «” „«—…"
      ForeColor       =   &H00FDD9F5&
      Height          =   1695
      Left            =   9720
      RightToLeft     =   -1  'True
      TabIndex        =   42
      Top             =   7920
      Visible         =   0   'False
      Width           =   3615
      Begin VB.CommandButton Command19 
         BackColor       =   &H80000016&
         Caption         =   " ”ÃÌ·"
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
         TabIndex        =   44
         Top             =   1080
         Width           =   735
      End
      Begin VB.CommandButton Command18 
         BackColor       =   &H80000016&
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
         Left            =   840
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   43
         Top             =   1080
         Width           =   735
      End
      Begin VB.Label Label41 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Â–Â «·„«œ…  MXF ·« Ì„ﬂ‰  ‰›Ì–Â« Â·  —Ìœ «· ”ÃÌ·"
         BeginProperty Font 
            Name            =   "Arabic Transparent"
            Size            =   9.75
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   615
         Left            =   -120
         RightToLeft     =   -1  'True
         TabIndex        =   45
         Top             =   360
         Width           =   3375
      End
   End
   Begin VB.CommandButton Command16 
      BackColor       =   &H00808080&
      Caption         =   "„œ… «·„‘«Âœ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   10680
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   26
      Top             =   4920
      Width           =   735
   End
   Begin VB.CommandButton Command15 
      BackColor       =   &H00808080&
      Caption         =   "«÷«›… "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   700
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   7440
      MaskColor       =   &H00404040&
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   25
      Top             =   5280
      UseMaskColor    =   -1  'True
      Width           =   2175
   End
   Begin VB.TextBox m_dmd_desc 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
      Height          =   345
      Left            =   11760
      RightToLeft     =   -1  'True
      TabIndex        =   24
      ToolTipText     =   "⁄‰Ê«‰ «·„‘Âœ «·–Ì ÌŒ «— „‰ «·„‘Âœ «·—∆Ì”Ì"
      Top             =   5400
      Width           =   4455
   End
   Begin VB.CommandButton Command13 
      BackColor       =   &H00808080&
      Caption         =   "out"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   700
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   8520
      MaskColor       =   &H00FFFFFF&
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   23
      Top             =   4560
      UseMaskColor    =   -1  'True
      Width           =   1095
   End
   Begin VB.CommandButton Command12 
      BackColor       =   &H00808080&
      Caption         =   "in"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   700
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   7440
      MaskColor       =   &H00FFFFFF&
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   22
      Top             =   4560
      UseMaskColor    =   -1  'True
      Width           =   975
   End
   Begin VB.CommandButton Command11 
      Height          =   375
      Left            =   3600
      Picture         =   "USER_INTERFACE1.frx":016B
      Style           =   1  'Graphical
      TabIndex        =   18
      Top             =   5520
      Width           =   375
   End
   Begin VB.CommandButton Command10 
      Height          =   375
      Left            =   4320
      Picture         =   "USER_INTERFACE1.frx":050F
      Style           =   1  'Graphical
      TabIndex        =   17
      Top             =   5520
      Width           =   375
   End
   Begin VB.TextBox m_step 
      Alignment       =   2  'Center
      Height          =   375
      Left            =   3960
      Locked          =   -1  'True
      TabIndex        =   16
      Text            =   "1"
      Top             =   5520
      Width           =   375
   End
   Begin MSAdodcLib.Adodc RESULT 
      Height          =   330
      Left            =   13440
      Top             =   10800
      Visible         =   0   'False
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   582
      ConnectMode     =   0
      CursorLocation  =   3
      IsolationLevel  =   -1
      ConnectionTimeout=   15
      CommandTimeout  =   100
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
      UserName        =   "SA"
      Password        =   ""
      RecordSource    =   " select view_result.* from view_result"
      Caption         =   "RESULT"
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
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000007&
      Caption         =   "«·‰ ÌÃ…"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1095
      Left            =   17400
      MaskColor       =   &H00FFFFFF&
      TabIndex        =   7
      Top             =   480
      Width           =   1335
   End
   Begin VB.CommandButton Command2 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0FF&
      Caption         =   "Œ‹‹—ÊÃ"
      CausesValidation=   0   'False
      DisabledPicture =   "USER_INTERFACE1.frx":08B4
      DownPicture     =   "USER_INTERFACE1.frx":0CF6
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   17400
      MaskColor       =   &H00C0C0FF&
      Picture         =   "USER_INTERFACE1.frx":1138
      TabIndex        =   10
      Top             =   3360
      Width           =   1335
   End
   Begin VB.CommandButton Command3 
      Appearance      =   0  'Flat
      Caption         =   "⁄œœ «·„‘«Âœ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   17400
      TabIndex        =   8
      Top             =   2520
      Width           =   1335
   End
   Begin VB.TextBox m_word 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00ECFDFD&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   450
      Left            =   11640
      RightToLeft     =   -1  'True
      TabIndex        =   2
      ToolTipText     =   "ﬂ·„… „⁄Ì‰… „‰ ⁄‰Ê«‰ «·„‘Âœ «Ê «·„” Œ·’"
      Top             =   360
      Width           =   4575
   End
   Begin VB.TextBox m_file_no 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00ECFDFD&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   450
      Left            =   11640
      RightToLeft     =   -1  'True
      TabIndex        =   3
      ToolTipText     =   "«”„«¡ «·‘Œ’Ì«  , Ê«·„ƒ””«  Ê«·ÂÌ∆«  Ê«·«„«ﬂ‰ «·Ã€—«›Ì« Ê«»—“ «·«Õœ«À Ê«·„ ›—ﬁ« "
      Top             =   840
      Width           =   4575
   End
   Begin VB.TextBox m_desc_no 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00ECFDFD&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   450
      Left            =   11640
      RightToLeft     =   -1  'True
      TabIndex        =   4
      ToolTipText     =   "Ê«’›… „‰ «·„ﬂ‰“ «·„” Œœ„"
      Top             =   1320
      Width           =   4575
   End
   Begin VB.CommandButton Command4 
      Appearance      =   0  'Flat
      Caption         =   "»ÕÀ ÃœÌœ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   17400
      MaskColor       =   &H00FFFFC0&
      TabIndex        =   9
      Top             =   1560
      Width           =   1335
   End
   Begin VB.OptionButton Option1 
      Appearance      =   0  'Flat
      BackColor       =   &H00FAF0DE&
      Caption         =   "«·»ÕÀ »œ«Ì…  «·«”„"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   7680
      TabIndex        =   1
      ToolTipText     =   " €ÌÌ— «·»ÕÀ ›Ì Ã„Ì⁄ «·ÕﬁÊ·"
      Top             =   600
      Width           =   1575
   End
   Begin VB.OptionButton Option2 
      Appearance      =   0  'Flat
      BackColor       =   &H00FAF0DE&
      Caption         =   "«·»ÕÀ ﬂ·„… „⁄Ì‰…"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   9360
      TabIndex        =   0
      ToolTipText     =   " €ÌÌ— «·»ÕÀ ›Ì Ã„Ì⁄ «·ÕﬁÊ· "
      Top             =   600
      Width           =   1695
   End
   Begin MSMask.MaskEdBox M_art_dte1 
      Height          =   375
      Left            =   7800
      TabIndex        =   6
      Top             =   1560
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   661
      _Version        =   393216
      BorderStyle     =   0
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
   Begin MSMask.MaskEdBox M_art_dte 
      Height          =   375
      Left            =   9240
      TabIndex        =   5
      Top             =   1560
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   661
      _Version        =   393216
      BorderStyle     =   0
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
   Begin MSRDC.MSRDC view_form 
      Height          =   330
      Left            =   11640
      Top             =   10680
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
   Begin MSRDC.MSRDC macnz 
      Height          =   330
      Left            =   7560
      Top             =   10560
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
      RecordSource    =   "select * from macnz"
      UserName        =   "sa"
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
   Begin MSRDC.MSRDC position 
      Height          =   375
      Left            =   12480
      Top             =   10800
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
      DataSourceName  =   "sqlserver1"
      RecordSource    =   ""
      UserName        =   "sa"
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
   Begin MSMask.MaskEdBox M_dmd_dte1 
      Height          =   375
      Left            =   11640
      TabIndex        =   20
      Top             =   4560
      Width           =   1215
      _ExtentX        =   2143
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
   Begin MSMask.MaskEdBox M_dmd_dte 
      Height          =   375
      Left            =   13680
      TabIndex        =   21
      Top             =   4560
      Width           =   1455
      _ExtentX        =   2566
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
   Begin MSAdodcLib.Adodc view_demand 
      Height          =   375
      Left            =   7560
      Top             =   10920
      Visible         =   0   'False
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
   Begin MSRDC.MSRDC tmp 
      Height          =   450
      Left            =   5640
      Top             =   10920
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
      RecordSource    =   "select * from view_result"
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
   Begin VB.TextBox m_nar_desc 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00ECFDFD&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   450
      Left            =   11640
      RightToLeft     =   -1  'True
      TabIndex        =   31
      ToolTipText     =   "„‰ «·„ﬂ‰“: «· ’—ÌÕ_«·Ê’Ê· _·„€«œ—…_Œÿ» Ê»Ì«‰« "
      Top             =   2280
      Width           =   4575
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H00FAF0DE&
      Caption         =   "«·»ÕÀ ›Ì «·«—‘Ì›"
      ForeColor       =   &H80000008&
      Height          =   3975
      Left            =   7320
      RightToLeft     =   -1  'True
      TabIndex        =   29
      Top             =   240
      Width           =   11415
      Begin VB.TextBox m_txt_text 
         Alignment       =   1  'Right Justify
         Height          =   405
         Left            =   4440
         TabIndex        =   79
         Top             =   3480
         Width           =   4215
      End
      Begin MSDataListLib.DataCombo m_mch_typ 
         Bindings        =   "USER_INTERFACE1.frx":157A
         Height          =   315
         Left            =   360
         TabIndex        =   75
         Top             =   3000
         Width           =   2295
         _ExtentX        =   4048
         _ExtentY        =   556
         _Version        =   393216
         BackColor       =   15531517
         ListField       =   "SUB_DESC"
         BoundColumn     =   "SUB_CODE"
         Text            =   ""
         RightToLeft     =   -1  'True
      End
      Begin VB.TextBox m_file_geo 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00ECFDFD&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   450
         Left            =   4320
         RightToLeft     =   -1  'True
         TabIndex        =   72
         ToolTipText     =   "„ﬂ«‰  ’ÊÌ— «·„‘Âœ"
         Top             =   2520
         Width           =   4575
      End
      Begin VB.TextBox m_file_no1 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00ECFDFD&
         Height          =   450
         Left            =   4320
         RightToLeft     =   -1  'True
         TabIndex        =   66
         ToolTipText     =   "«”„«¡ «·‘Œ’Ì«  , Ê«·„ƒ””«  Ê«·ÂÌ∆«  Ê«·«„«ﬂ‰ «·Ã€—«›Ì« Ê«»—“ «·«Õœ«À Ê«·„ ›—ﬁ« "
         Top             =   1560
         Width           =   4575
      End
      Begin VB.CommandButton Command8 
         Caption         =   "Command8"
         Height          =   375
         Left            =   4320
         RightToLeft     =   -1  'True
         TabIndex        =   74
         Top             =   600
         Width           =   495
      End
      Begin MSDataListLib.DataCombo m_res_no 
         Bindings        =   "USER_INTERFACE1.frx":1594
         Height          =   315
         Left            =   4320
         TabIndex        =   76
         Top             =   3000
         Width           =   4575
         _ExtentX        =   8070
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "AUT_NAM"
         BoundColumn     =   "AUT_NO"
         Text            =   ""
         RightToLeft     =   -1  'True
      End
      Begin MSDataListLib.DataCombo m_dig_typ1 
         Bindings        =   "USER_INTERFACE1.frx":15AA
         Height          =   315
         Left            =   360
         TabIndex        =   77
         Top             =   3360
         Width           =   2295
         _ExtentX        =   4048
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "SUB_DESC"
         BoundColumn     =   "SUB_CODE"
         Text            =   ""
         RightToLeft     =   -1  'True
      End
      Begin VB.Label Label14 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FAF0DE&
         Caption         =   "ﬂ·„… „‰ «·‰’"
         BeginProperty Font 
            Name            =   "MS Serif"
            Size            =   8.25
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   8520
         RightToLeft     =   -1  'True
         TabIndex        =   80
         Top             =   3600
         Width           =   1455
      End
      Begin VB.Label Label13 
         BackColor       =   &H00FAF0DE&
         Caption         =   "„ﬂ«‰ «·„‘Âœ"
         BeginProperty Font 
            Name            =   "MS Serif"
            Size            =   8.25
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   9120
         RightToLeft     =   -1  'True
         TabIndex        =   71
         Top             =   2520
         Width           =   615
      End
      Begin VB.Label Label10 
         BackColor       =   &H00FAF0DE&
         Caption         =   "„·› ·Â"
         BeginProperty Font 
            Name            =   "MS Serif"
            Size            =   8.25
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   9000
         RightToLeft     =   -1  'True
         TabIndex        =   67
         Top             =   1680
         Width           =   615
      End
      Begin VB.Label Label8 
         BackColor       =   &H00FAF0DE&
         Caption         =   "„‰  «—ÌŒ"
         BeginProperty Font 
            Name            =   "MS Serif"
            Size            =   8.25
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2400
         RightToLeft     =   -1  'True
         TabIndex        =   41
         Top             =   960
         Width           =   975
      End
      Begin VB.Label Label5 
         BackColor       =   &H00FAF0DE&
         Caption         =   "«·Ï  «—ÌŒ"
         BeginProperty Font 
            Name            =   "MS Serif"
            Size            =   8.25
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   840
         RightToLeft     =   -1  'True
         TabIndex        =   40
         Top             =   960
         Width           =   855
      End
      Begin VB.Label Label18 
         BackColor       =   &H00FAF0DE&
         Caption         =   "‰Ê⁄ «·ÊÀÌﬁ…"
         BeginProperty Font 
            Name            =   "MS Serif"
            Size            =   8.25
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2760
         RightToLeft     =   -1  'True
         TabIndex        =   39
         Top             =   3480
         Width           =   735
      End
      Begin VB.Label Label16 
         BackColor       =   &H00FAF0DE&
         Caption         =   "‰Ê⁄ «·„ﬁ«·…"
         BeginProperty Font 
            Name            =   "MS Serif"
            Size            =   8.25
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2760
         RightToLeft     =   -1  'True
         TabIndex        =   38
         Top             =   3000
         Width           =   615
      End
      Begin VB.Label Label23 
         BackColor       =   &H00FAF0DE&
         Caption         =   "«·»ÕÀ »ﬂ·„…"
         BeginProperty Font 
            Name            =   "MS Serif"
            Size            =   8.25
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   9120
         RightToLeft     =   -1  'True
         TabIndex        =   37
         Top             =   360
         Width           =   615
      End
      Begin VB.Label Label22 
         BackColor       =   &H00FAF0DE&
         Caption         =   "„·› ⁄«„"
         BeginProperty Font 
            Name            =   "MS Serif"
            Size            =   8.25
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   9000
         RightToLeft     =   -1  'True
         TabIndex        =   36
         Top             =   720
         Width           =   615
      End
      Begin VB.Label Label21 
         BackColor       =   &H00FAF0DE&
         Caption         =   "«·„Ê÷Ê⁄"
         BeginProperty Font 
            Name            =   "MS Serif"
            Size            =   8.25
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   9000
         RightToLeft     =   -1  'True
         TabIndex        =   35
         Top             =   1200
         Width           =   615
      End
      Begin VB.Label Label20 
         BackColor       =   &H00FAF0DE&
         Caption         =   "«·„”ƒÊ· ⁄‰ «·⁄„·"
         BeginProperty Font 
            Name            =   "MS Serif"
            Size            =   8.25
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   8880
         RightToLeft     =   -1  'True
         TabIndex        =   34
         Top             =   3000
         Width           =   1215
      End
      Begin VB.Label Label19 
         BackColor       =   &H00FAF0DE&
         Caption         =   "«·«÷Ìﬁ"
         BeginProperty Font 
            Name            =   "MS Serif"
            Size            =   8.25
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   9240
         RightToLeft     =   -1  'True
         TabIndex        =   33
         Top             =   2160
         Width           =   615
      End
   End
   Begin VB.CommandButton Command6 
      Caption         =   "„”«⁄œ…"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   13920
      MaskColor       =   &H00E0E0E0&
      Style           =   1  'Graphical
      TabIndex        =   14
      Top             =   1800
      UseMaskColor    =   -1  'True
      Width           =   615
   End
   Begin MSAdodcLib.Adodc ranj 
      Height          =   330
      Left            =   3240
      Top             =   10920
      Visible         =   0   'False
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   582
      ConnectMode     =   0
      CursorLocation  =   3
      IsolationLevel  =   -1
      ConnectionTimeout=   15
      CommandTimeout  =   100
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
      UserName        =   "SA"
      Password        =   ""
      RecordSource    =   "select ranjpath.* from ranjpath"
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
      _Version        =   393216
   End
   Begin MSComctlLib.ProgressBar ProgressBar1 
      Height          =   375
      Left            =   480
      TabIndex        =   63
      Top             =   14520
      Width           =   3255
      _ExtentX        =   5741
      _ExtentY        =   661
      _Version        =   393216
      Appearance      =   1
   End
   Begin VB.Frame Frame12 
      Appearance      =   0  'Flat
      BackColor       =   &H00C9FAF9&
      Caption         =   "«Œ Ì«— «·„‘«Âœ"
      DragMode        =   1  'Automatic
      ForeColor       =   &H8000000D&
      Height          =   1575
      Left            =   7320
      RightToLeft     =   -1  'True
      TabIndex        =   28
      Top             =   4320
      Width           =   11415
      Begin VB.CommandButton Command14 
         BackColor       =   &H00808080&
         Caption         =   " ‰›Ìœ"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   178
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   855
         Left            =   2400
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   78
         Top             =   600
         Width           =   735
      End
      Begin VB.CommandButton Command5 
         BackColor       =   &H009898FC&
         Caption         =   "«—”· «·Ï  "" EDLC """
         Height          =   1095
         Left            =   9600
         MaskColor       =   &H00FFFFFF&
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   68
         Top             =   360
         Width           =   1695
      End
      Begin VB.CheckBox Check2 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C9FAF9&
         Caption         =   "«·ÿ·»«  «·€Ì— „‰Ã“…"
         Height          =   375
         Left            =   2400
         MaskColor       =   &H00D8F9FE&
         RightToLeft     =   -1  'True
         TabIndex        =   73
         Top             =   240
         Width           =   1695
      End
      Begin VB.CommandButton Command24 
         BackColor       =   &H00808080&
         Caption         =   "save EDL"
         Height          =   195
         Left            =   9600
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   65
         Top             =   240
         Visible         =   0   'False
         Width           =   735
      End
      Begin VB.Label Label7 
         BackColor       =   &H00C9FAF9&
         Caption         =   "⁄‰Ê«‰ «·„‘Âœ «·ÃœÌœ"
         BeginProperty Font 
            Name            =   "MS Serif"
            Size            =   8.25
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   7800
         RightToLeft     =   -1  'True
         TabIndex        =   56
         Top             =   840
         Width           =   1095
      End
      Begin VB.Label Label12 
         BackColor       =   &H00C9FAF9&
         Caption         =   "«·Ï  «—ÌŒ"
         BeginProperty Font 
            Name            =   "MS Serif"
            Size            =   8.25
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   5640
         RightToLeft     =   -1  'True
         TabIndex        =   32
         Top             =   240
         Width           =   615
      End
      Begin VB.Label Label35 
         BackColor       =   &H00C9FAF9&
         Caption         =   "„‰  «—ÌŒ"
         BeginProperty Font 
            Name            =   "MS Serif"
            Size            =   8.25
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   7920
         RightToLeft     =   -1  'True
         TabIndex        =   30
         Top             =   240
         Width           =   615
      End
   End
   Begin MSDataGridLib.DataGrid DataGrid1 
      Bindings        =   "USER_INTERFACE1.frx":15C3
      Height          =   3255
      Left            =   240
      TabIndex        =   11
      ToolTipText     =   "‰ «∆Ã «·»ÕÀ"
      Top             =   6000
      Width           =   18375
      _ExtentX        =   32411
      _ExtentY        =   5741
      _Version        =   393216
      AllowUpdate     =   0   'False
      AllowArrows     =   -1  'True
      Appearance      =   0
      BackColor       =   16445662
      BorderStyle     =   0
      ForeColor       =   0
      HeadLines       =   2
      RowHeight       =   32
      RowDividerStyle =   5
      FormatLocked    =   -1  'True
      RightToLeft     =   -1  'True
      BeginProperty HeadFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   700
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
      Caption         =   "‰ «∆Ã «·»ÕÀ"
      ColumnCount     =   18
      BeginProperty Column00 
         DataField       =   "res_res_no"
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
         Caption         =   "«·’›Õ…"
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
         Caption         =   "«·„’œ—"
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
         Caption         =   "—ﬁ„ digital"
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
         Caption         =   "‰Ê⁄ «·„·›"
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
         Caption         =   "dig_choice"
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
         Caption         =   "„‰ À"
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
         Caption         =   "„‰ ”"
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
         Caption         =   "„‰ œ"
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
         Caption         =   "«·Ï À"
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
         Caption         =   "«·Ï ”"
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
         Caption         =   "«·Ï œ"
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
         Size            =   2
         BeginProperty Column00 
            ColumnWidth     =   1800
         EndProperty
         BeginProperty Column01 
            ColumnWidth     =   1275.024
         EndProperty
         BeginProperty Column02 
            ColumnWidth     =   3495.118
         EndProperty
         BeginProperty Column03 
            ColumnWidth     =   3000.189
         EndProperty
         BeginProperty Column04 
            ColumnWidth     =   1005.165
         EndProperty
         BeginProperty Column05 
            ColumnWidth     =   1005.165
         EndProperty
         BeginProperty Column06 
            ColumnWidth     =   750.047
         EndProperty
         BeginProperty Column07 
            ColumnWidth     =   1200.189
         EndProperty
         BeginProperty Column08 
            ColumnWidth     =   1170.142
         EndProperty
         BeginProperty Column09 
            Object.Visible         =   -1  'True
            ColumnWidth     =   959.811
         EndProperty
         BeginProperty Column10 
            Object.Visible         =   0   'False
            ColumnWidth     =   780.095
         EndProperty
         BeginProperty Column11 
            Object.Visible         =   0   'False
            ColumnWidth     =   1275.024
         EndProperty
         BeginProperty Column12 
            ColumnWidth     =   494.929
         EndProperty
         BeginProperty Column13 
            ColumnWidth     =   494.929
         EndProperty
         BeginProperty Column14 
            ColumnWidth     =   494.929
         EndProperty
         BeginProperty Column15 
            ColumnWidth     =   494.929
         EndProperty
         BeginProperty Column16 
            ColumnWidth     =   494.929
         EndProperty
         BeginProperty Column17 
            ColumnWidth     =   494.929
         EndProperty
      EndProperty
   End
   Begin MSDataGridLib.DataGrid DataGrid2 
      Bindings        =   "USER_INTERFACE1.frx":15D8
      Height          =   3495
      Left            =   360
      TabIndex        =   19
      ToolTipText     =   "„« Ì „ «Œ Ì«—Â „‰ „‘«Âœ „‰ ﬁ»· «·„” ›Ìœ"
      Top             =   9360
      Width           =   18375
      _ExtentX        =   32411
      _ExtentY        =   6165
      _Version        =   393216
      AllowUpdate     =   -1  'True
      AllowArrows     =   -1  'True
      Appearance      =   0
      BackColor       =   13236985
      BorderStyle     =   0
      ForeColor       =   16711680
      HeadLines       =   2
      RowHeight       =   20
      RowDividerStyle =   6
      FormatLocked    =   -1  'True
      RightToLeft     =   -1  'True
      BeginProperty HeadFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   700
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
      Caption         =   "ÿ·» „Ê«œ „‰ «·«—‘Ì›"
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
      BeginProperty Column02 
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
      BeginProperty Column03 
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
      BeginProperty Column04 
         DataField       =   "dmd_desc"
         Caption         =   "«·‘—Õ"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   "0"
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
         DataField       =   "nam_prg"
         Caption         =   "«”„ «·»—‰«„Ã"
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
            Object.Visible         =   0   'False
            ColumnWidth     =   1995.024
         EndProperty
         BeginProperty Column01 
            ColumnWidth     =   794.835
         EndProperty
         BeginProperty Column02 
            Locked          =   -1  'True
            ColumnWidth     =   915.024
         EndProperty
         BeginProperty Column03 
            Locked          =   -1  'True
            Object.Visible         =   -1  'True
            ColumnWidth     =   794.835
         EndProperty
         BeginProperty Column04 
            ColumnWidth     =   5009.953
         EndProperty
         BeginProperty Column05 
            Locked          =   -1  'True
            ColumnWidth     =   900.284
         EndProperty
         BeginProperty Column06 
            Locked          =   -1  'True
            Object.Visible         =   0   'False
            ColumnWidth     =   1500.095
         EndProperty
         BeginProperty Column07 
            Locked          =   -1  'True
            ColumnWidth     =   14.74
         EndProperty
         BeginProperty Column08 
            Locked          =   -1  'True
            ColumnWidth     =   794.835
         EndProperty
         BeginProperty Column09 
            Locked          =   -1  'True
            ColumnWidth     =   7799.812
         EndProperty
         BeginProperty Column10 
            Object.Visible         =   -1  'True
            ColumnWidth     =   14.74
         EndProperty
         BeginProperty Column11 
            Locked          =   -1  'True
            ColumnWidth     =   1005.165
         EndProperty
      EndProperty
   End
   Begin VB.CommandButton Command7 
      Appearance      =   0  'Flat
      BackColor       =   &H80000010&
      Caption         =   " ‰›Ì–"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   17520
      MaskColor       =   &H00404040&
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   62
      ToolTipText     =   "«·«” ›«œ… ›ﬁÿ „‰ ar2"
      Top             =   5280
      Visible         =   0   'False
      Width           =   615
   End
   Begin VB.CommandButton Command9 
      BackColor       =   &H8000000C&
      Caption         =   "save EDL & Vegas"
      Height          =   615
      Left            =   18120
      MaskColor       =   &H00404040&
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   64
      Top             =   5280
      UseMaskColor    =   -1  'True
      Visible         =   0   'False
      Width           =   615
   End
   Begin VB.CommandButton Command17 
      BackColor       =   &H00808080&
      Caption         =   "«—”«· «·ÿ·» "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   17400
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   27
      Top             =   4440
      Visible         =   0   'False
      Width           =   495
   End
   Begin MSAdodcLib.Adodc coding06 
      Height          =   375
      Left            =   360
      Top             =   10680
      Visible         =   0   'False
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   661
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
      RecordSource    =   "select * from VIEW_coding16 order by sub_desc"
      Caption         =   "coding06"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      _Version        =   393216
   End
   Begin MSAdodcLib.Adodc Adodc1 
      Height          =   330
      Left            =   0
      Top             =   0
      Visible         =   0   'False
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   582
      ConnectMode     =   0
      CursorLocation  =   3
      IsolationLevel  =   -1
      ConnectionTimeout=   15
      CommandTimeout  =   100
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
      UserName        =   "SA"
      Password        =   ""
      RecordSource    =   "select ranjpath.* from ranjpath"
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
      _Version        =   393216
   End
   Begin MSAdodcLib.Adodc coding_typ1 
      Height          =   330
      Left            =   0
      Top             =   0
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
   Begin MSAdodcLib.Adodc auther1 
      Height          =   330
      Left            =   0
      Top             =   0
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
      Left            =   0
      Top             =   0
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
   Begin VB.Label Label11 
      Alignment       =   1  'Right Justify
      Caption         =   "Label11"
      Height          =   375
      Left            =   18000
      RightToLeft     =   -1  'True
      TabIndex        =   69
      Top             =   9240
      Width           =   375
   End
   Begin WMPLibCtl.WindowsMediaPlayer WindowsMediaPlayer1 
      Height          =   5775
      Left            =   360
      TabIndex        =   59
      Top             =   120
      Width           =   6615
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
      volume          =   100
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
      _cx             =   11668
      _cy             =   10186
   End
End
Attribute VB_Name = "USER_INTERFACE1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim CRIT, crit_1 As String
Dim first_qst, m_tabindex As Integer
Dim crit1 As String
Dim m_typ_serh As Integer
Dim m_disp, indice As Integer
Dim m_nbword As Integer
Dim qst1, qst2, qst3, qst4, qst5, qst6, qst7, qst8, qst9, qst10, qst_1, qst_2, qst12, qst13, qst11, qst14, qst15, qst16, qst17 As Integer
Dim m_fad_no, m_mch_geo, m_mch_nprg, m_mch_geo1, m_fad_no1, m_mch_nogeo As String
Dim m_path As String
Dim m_streamstart As Double
Dim m_len_mch As Double
Dim m_dmd_ser, m_typ_add As Integer
Dim fld_index(9) As String
Dim is_mode, is_in, is_out As Integer

'*********************************************************************************
Public strMode As String
Public iVideo1Width As Integer
Public iVideo2Width As Integer
Public iVideo3Width As Integer
Public iVideo1Height As Integer
Public iVideo2Height As Integer
Public iVideo3Height As Integer


Dim clrTranColor
Dim clrGifTranColor
Dim clrTextColor
Dim clrTextBgColor
Dim crit11, m_dmd_user_no As String

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
'**************************************************************************





Private Sub Check2_Click()
m_disp = 1
qst_1 = 0
qst_2 = 0
qst_3 = 0
crit3 = ""
m_typ_serh = 1


'M_art_dte.Text = Format(Date, "dd/mm/yy")
first_qst1 = 0
 crit_1 = "create proc tmp_demand" + box_user_no + " AS "

crit_1 = crit_1 & "SELECT   dbo.demand.dmd_mch_no, dbo.demand.dmd_no, dbo.demand.dmd_ser, dbo.demand.dmd_user, dbo.demand.dmd_dte, dbo.main.mn_act_ttl,rtrim(cast(dbo.demand.dmd_s as char))+ '  ' + rtrim(cast(dbo.demand.dmd_M as char))+ '  ' + rtrim(cast(dbo.demand.dmd_O as char)) as time_frm , " & _
                      " dbo.demand.dmd_in , dbo.demand.dmd_out, dbo.demand.dmd_path, dbo.demand.dmd_time, dbo.demand.dmd_desc, dbo.demand.dmd_chek, dbo.demand.dmd_mch_stock, dbo.config.user_name " & _
" FROM         dbo.demand left JOIN " & _
                     " dbo.main ON dbo.demand.dmd_mch_no = dbo.main.mn_app_no left join " & _
                         "dbo.config ON dbo.demand.dmd_user = dbo.config.user_no "
 If qst_1 = 0 And Not M_dmd_dte.Text = "__/__/____" Then
  qst_1 = 1
   If first_qst1 = 0 Then
        crit11 = " where "
        first_qst1 = 1
      Else
       crit11 = crit11 & " and "
      End If
     
     m_dte = Format(M_dmd_dte.Text, "yyyy/MM/dd")
     crit11 = crit11 & " ( dmd_dte >= " & "convert(datetime," & "'" & Format(m_dte, "yyyy-mm-dd") & "'" & "," & "102))"
' M_dmd_dte.Enabled = False
End If
 If qst_2 = 0 And Not M_dmd_dte1.Text = "__/__/____" Then
  qst_2 = 1
 If first_qst1 = 0 Then
        crit11 = " where "
        first_qst1 = 1
      Else
       crit11 = crit11 & " and "
      End If
     
     m_dte1 = Format(M_dmd_dte1.Text, "yyyy/MM/dd")
     crit11 = crit11 & " ( dmd_dte <= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102))"
'     M_dmd_dte1.Enabled = False
End If
If qst_3 = 0 Then
 
       qst_3 = 1
      If first_qst1 = 0 Then
        crit1 = " where "
        first_qst1 = 1
      Else
       crit11 = crit11 & " and "
      End If
      If Check2.value = 1 Then
       crit11 = crit11 & "(dmd_chek <> 2  or dmd_chek is null ) "
       Else
        crit11 = crit11 & "(dmd_chek = 2  or dmd_chek is null or dmd_chek = 1 ) "
      End If
End If

'If Not box_pwd_cap = 1 Then
' qst7 = 1
    m_disp = 0
      crit3 = crit3 & " and dmd_user =  " & "'" & box_user_no & "'"
     ' m_dmd_user.Text = box_user_name
      m_disp = 1
      ' m_dmd_user.Enabled = False
  'End If

If first_qst1 > 0 Then
  crit2 = crit_1 & crit11 & crit3 & " order by dmd_no desc"
  ''& " order by art_dte"
  ' MsgBox crit2
       sql = "drop proc tmp_demand" + box_user_no
       cn.Execute sql, rdExecDirect
       cn.Execute crit2, rdExecDirect
       Screen.MousePointer = vbHourglass
       view_demand.RecordSource = "execute tmp_demand" + box_user_no
       view_demand.Refresh
       DataGrid2.Refresh
       
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
End Sub

Private Sub Command1_Click()
 On Error Resume Next
'Dim cn As New rdoConnection

Dim sql As String
Dim qd As rdoQuery
Dim sql_query As String
If qst9 = 0 And Not m_mch_typ.Text = "" Then
   qst9 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " art_sub_ty = " & "'" & Mid(m_mch_typ.BoundText, 3, 3) & "'"
      m_mch_typ.Enabled = False
          Command1.SetFocus
End If
If qst3 = 0 And Not M_art_dte.Text = "__/__/____" Then
  qst3 = 1
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
      
      Command1.SetFocus
  End If
'If qst11 = 0 And Not m_nb_mch.Text = "" Then
'  qst11 = 1
''      If first_qst = 0 Then
'        crit1 = " where "
'        first_qst = 1
'      Else
'       crit1 = crit1 & " and "
'      End If
'        crit1 = crit1 & "mch_num = " & "'" & m_nb_mch & "'"
'       m_nb_mch.Enabled = False
'End If

'If qst12 = 0 And Not m_display_dte.Text = "__/__/____" Then
'   If first_qst = 0 Then
'        crit1 = " where "
'        first_qst = 1
'      Else
'       crit1 = crit1 & " and "
'      End If
'
'     m_dte1 = Format(m_display_dte.Text, "YYYY/MM/DD")
'     crit1 = crit1 & "  dte_DTE >= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102)"
'     qst12 = 1
'     m_display_dte.Enabled = False
'End If
''If qst13 = 0 And Not m_display_dte1.Text = "__/__/____" Then
 '  If first_qst = 0 Then
 '       crit1 = " where "
 '       first_qst = 1
 '     Else
 '      crit1 = crit1 & " and "
 '     End If
 '
 '    m_dte1 = Format(m_display_dte1.Text, "YYYY/MM/DD")
 '    crit1 = crit1 & "  dte_DTE <= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102)"
 '    qst13 = 1
   '  m_display_dte1.Enabled = False
'E 'nd If

If qst4 = 0 And Not M_art_dte1.Text = "__/__/____" Then
 qst4 = 1
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
If qst2 = 0 And Not m_word.Text = "" Then
' qst2 = 1
'   If first_qst = 0 Then
'        crit1 = " where "
'        first_qst = 1
'      Else
'       crit1 = crit1 & " and "
'      End If
'      crit1 = crit1 & "mch_tit + mch_result like " & "'" & "%" & m_word.Text & "%" & "'"
'      m_word.Enabled = False
      qst2 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      sw_desc = LTrim(m_word.Text)
      L = Len(sw_desc)
      i = 1
      j = 0
      k = 1
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
    If j >= m_nbword Then
       If k > 1 Then
         crit1 = crit1 & " and "
       End If
        crit1 = crit1 & "mn_result+ mn_act_ttl + mn_add_ttl" & " like " & "'" & "%" & sw_des & "%" & "'"
        
        k = k + 1
    End If
    j = j + 1
   Wend
   m_nbword = j
    Command1.SetFocus

End If
 
If qst5 = 0 And Not m_file_no.Text = "" Then
  qst5 = 1
    If first_qst = 0 Then
         crit1 = " where "
         first_qst = 1
     Else
        crit1 = crit1 & " and "
    End If
      view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_fad_no = view_form.Resultset![sub_cod]
      crit1 = crit1 & "file_add.fad_fad_no =  " & "'" & m_fad_no & "'"
      CRIT = CRIT & " inner join dbo.file_add ON dbo.main.mn_app_no = dbo.file_add.fad_app_no "
       m_file_no.Text = view_form.Resultset![sub_name]
       m_file_no.Enabled = False
 
End If
 
  

If qst8 = 0 And Not m_desc_no.Text = "" Then
   qst8 = 1
If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       macnz.Resultset.Bookmark = DBList2.SelectedItem
       m_an_no = macnz.Resultset![sub_code]
crit1 = crit1 & " (an_desc_no =  " & "'" & m_an_no & "'"
      crit1 = crit1 & " or rel_rel_no =  " & "'" & m_an_no & "'"
   '   crit1 = crit1 & " or nar_nar_no =  " & "'" & m_an_no & "'" & " ) "
      CRIT = CRIT & " left join dbo.analis ON dbo.main.mn_app_no = dbo.analis.an_app_no "
      CRIT = CRIT & " left join dbo.relative ON dbo.main.mn_app_no = dbo.relative.rel_app_no "
' CRIT = CRIT & " left join dbo.narower ON dbo.main.mn_app_no = dbo.narower.nar_app_no "
      m_desc_no.Text = macnz.Resultset![sub_desc]
      DBList2.Visible = False
      m_desc_no.Enabled = False
End If
 
  
If qst14 = 0 And Not m_nar_desc.Text = "" Then
  qst14 = 1
  If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       macnz.Resultset.Bookmark = DBList2.SelectedItem
       m_nar_no = macnz.Resultset![sub_code]
      crit1 = crit1 & " nar_nar_no =  " & "'" & m_nar_no & "'"
     CRIT = CRIT & " left join dbo.narower ON dbo.main.mn_app_no = dbo.narower.nar_app_no "
       m_disp = 2
      m_nar_desc.Enabled = False
    End If
    If qst15 = 0 And Not m_file_no1.Text = "" Then
          qst15 = 1
     If first_qst = 0 Then
         crit1 = " where "
         first_qst = 1
     Else
        crit1 = crit1 & " and "
    End If
        view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_fad_no1 = view_form.Resultset![sub_cod]
  ' crit1 = crit1 & " dbo.file_add_1.fad_fad_no =  " & "'" & m_fad_no1 & "'" & " and dbo.file_add_1.fad_fad_t2 = 1 "
  '     CRIT = CRIT & " left join dbo.file_add AS FILE_ADD_1 ON dbo.main.mn_app_no = dbo.file_add_1.fad_app_no "
   ' crit1 = crit1 & "fad_fad_no =  " & "'" & m_fad_no1 & "'" & " and fad_fad_t2 = " & "'" & m_t & "'"
   '    CRIT = CRIT & " left join dbo.file_add  ON dbo.main.mn_app_no = file_add.fad_app_no "
        crit1 = crit1 & "file_add_1.fad_fad_no =  " & "'" & m_fad_no1 & "'" & " and file_add_1.fad_fad_t2 = " & "'" & m_t & "'"
        CRIT = CRIT & " left join dbo.file_add as file_ADD_1 ON dbo.main.mn_app_no = file_add_1.fad_app_no "

       
       m_disp = 2
       m_file_no1.Text = view_form.Resultset![sub_name]
       m_file_no1.Enabled = False

    End If
 If qst16 = 0 And Not m_file_geo.Text = "" Then
qst16 = 1
    If first_qst = 0 Then
         crit1 = " where "
         first_qst = 1
     Else
        crit1 = crit1 & " and "
    End If
       view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_mch_nogeo = view_form.Resultset![sub_cod]
      crit1 = crit1 & "dig_geochrt =  " & "'" & m_mch_nogeo & "'"
      m_disp = 2
      m_file_geo.Text = view_form.Resultset![sub_name]
      m_file_geo.Enabled = False
          
  End If
   If qst17 = 0 And Not m_txt_text.Text = "" Then
  qst17 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & "txt_text  like " & "'" & "%" & m_txt_text.Text & "%" & "'"
      CRIT = CRIT & " left join dbo.text1 ON dbo.main.mn_app_no = dbo.text1.txt_no "
      m_txt_text.Enabled = False
      Command1.SetFocus
      
End If
If first_qst > 0 Then
   
    
'crit3 = " and  view_charit_to.expr1 <> '101'"
  crit2 = CRIT & crit1 & crit3
  crit2 = crit2 & " order by art_dte desc "
   
  ''& " order by art_dte"
   ' MsgBox CRIT
    'MsgBox crit1
    

       sql = "drop proc interface_result" + box_user_no
       cn.Execute sql, rdExecDirect
       cn.Execute crit2, rdExecDirect
       Screen.MousePointer = vbHourglass
       RESULT.RecordSource = "execute interface_result" + box_user_no
       
       RESULT.Refresh
       DataGrid1.Refresh
       
      Screen.MousePointer = vbDefault
 Else
      MsgBox "ÌÃ» ÿ—Õ «·”ƒ«· «Ê·«....."
End If
End Sub

Private Sub Command10_Click()
On Error Resume Next
'WINDOWSMediaPlayer1.CONTROLS.FileName = m_nam
'm_tm = m_tm + m_step.Text
'WindowsMediaPlayer1.Controls.pause

'WINDOWSMediaPlayer1.CONTROLS.SelectionStart = m_tm
'WINDOWSMediaPlayer1.CONTROLS.SelectionEnd = WINDOWSMediaPlayer1.CONTROLS.Duration
'WINDOWSMediaPlayer1.CONTROLS.Play
'WmpCurPos = WINDOWSMediaPlayer1.CONTROLS.CurrentPosition
   
If WindowsMediaPlayer1.Controls.currentPosition > m_tm Then
 m_tm = WindowsMediaPlayer1.Controls.currentPosition
End If

    m_tm = m_tm + Val(m_step.Text)
    WindowsMediaPlayer1.Controls.currentPosition = m_tm
'If WINDOWSMediaPlayer1.CONTROLS.CurrentPosition = WINDOWSMediaPlayer1.CONTROLS.Duration Then
'    WINDOWSMediaPlayer1.CONTROLS.CurrentPosition = 0
    WindowsMediaPlayer1.Controls.Pause
'    WINDOWSMediaPlayer1.CONTROLS.Play
'End If
    WindowsMediaPlayer1.Controls.Play

End Sub


Private Sub Command11_Click()
On Error Resume Next
Dim wmpos As Double
Dim WmpCurPos As Double
  '  WmpCurPos = WINDOWSMediaPlayer1.CONTROLS.CurrentPosition
'If WINDOWSMediaPlayer1.CONTROLS.CurrentPosition < m_tm Then
' m_tm = WINDOWSMediaPlayer1.CONTROLS.CurrentPosition
'End If
    'If WINDOWSMediaPlayer1.CONTROLS.CurrentPosition <= 0 Then
    'WINDOWSMediaPlayer1.CONTROLS.CurrentPosition = 0
    'End If
    m_tm = m_tm - Val(m_step.Text)
    WindowsMediaPlayer1.Controls.currentPosition = m_tm
'If WINDOWSMediaPlayer1.CONTROLS.CurrentPosition = WmpCurPos Then
'    WINDOWSMediaPlayer1.CONTROLS.CurrentPosition = 0
  '  WindowsMediaPlayer1.Controls.pause
'    WINDOWSMediaPlayer1.CONTROLS.Play
'End If
'WindowsMediaPlayer1.Controls.SelectionStart = m_tm
    WindowsMediaPlayer1.Controls.Play
End Sub

Private Sub Command12_Click()
If Not V_MCH_STOCK = "" Then
On Error Resume Next
is_in = 1
 'If V_MCH_STOCK > 1 And w_MCH_STOCK < 30000 Then
 ' m_config_path1 = "\\ar2storage\ar2highres\final_archive\"
'   m_config_path1 = "\\Xenarchive1\x\Local_Inter\"
 'ElseIf w_MCH_STOCK > 30000 Then
 '  m_config_path1 = "\\Xenarchive1\x\Programs\"
  ' m_config_path1 = "\\ar1storage\Archive_prog\programs_final\"
  'm_config_path = "\\av2storage\Archive_prog\progr_final\"
'End If
m_config_path1 = high_stock_path(V_MCH_STOCK)
'If LEN_MCH(IND) <> 0 Or IND = 0 Then
IND = IND + 1
m_pos = WindowsMediaPlayer1.Controls.currentPosition
   STREAMSTART(IND) = m_pos
  m_streamstart = m_pos
ar_path(IND) = m_config_path1 + Trim(V_MCH_STOCK) + "." + v_mch_ext_high
m_path = m_config_path1 + Trim(V_MCH_STOCK) + "." + v_mch_ext_high
'End If
End If

End Sub

Private Sub Command13_Click()
If is_in = 1 Then
On Error Resume Next
If Not V_MCH_STOCK = 0 Then
'If STREAMSTART(IND) <> 0 Then

 LEN_MCH(IND) = WindowsMediaPlayer1.Controls.currentPosition
If LEN_MCH(IND) > STREAMSTART(IND) Then
 LEN_MCH(IND) = LEN_MCH(IND) - STREAMSTART(IND)
 m_len_mch = WindowsMediaPlayer1.Controls.currentPosition - m_streamstart
 is_out = 1
 m_dmd_desc.SetFocus
Else
IND = IND - 1
 MsgBox "«‰ »Â ·· ÊﬁÌ  .....!!!! "
 End If
 End If
 Else
  MsgBox "·„  ÷€ÿ “— «· in "
 End If


End Sub

Private Sub Command14_Click()
 On Error Resume Next
Dim lg As Boolean
Dim m_txt_no, X, v, dest As String
Dim v_name As String
v_name = ""
k1 = 0

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
k = 0
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
  'If Mid(v_path, 1, 5) = "\\ar2" Then
   V_EXT = Mid(V_PATH, Len(V_PATH) - 3, 4)
'  If Check3.value = 1 Then
'   v_nam = v_NAME + ".AVI"
'  Else
   ' v_nam =  v_name + Trim(view_demand.Recordset![dmd_desc]) + " Clip " + Trim(Str(view_demand.Recordset![dmd_ser])) + ".avi"

    v_nam = v_name + "_" + LTrim(Str(i)) + V_EXT
' v_nam = v_name + Trim(view_demand.Recordset![dmd_desc]) + "_Clip_" + Trim(Str(view_demand.Recordset![dmd_ser])) + v_ext
    
'   End If
'  If Check3.value = 1 Then
'    k = 1
'    While FileExists(v_nam)
'        v_nam = v_name + "_" + LTrim(Str(k)) + "_" + LTrim(Str(i)) + v_ext
'       k = k + 1
'     Wend
' End If
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
 k1 = 1
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
'    ProgressBar1.max = m_max * 2500
'    v_max = m_max * 2500
'    For j = 1 To v_max
'      ProgressBar1.value = j
''    Next j
     
    'Wait for the process to complete
    
    lRetVal = WaitForSingleObject(m_max, INFINITE)
    lRetVal = CloseHandle(m_max)
     nb_copy = nb_copy + 1
     nb_copy.Refresh
     
 
'     If FileExists(v_nam) Then
  
       '  progress.m_tit.Text = m_name1
       ' progress.Show 1
    
       m_dmd_no1 = view_demand.Recordset![dmd_no]
       m_ser = view_demand.Recordset![dmd_ser]
       m_dmd_chek = 2
       sql = "execute upd_demand1 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_ser & "'" & "," _
              & "'" & m_dmd_chek & "'"
              
       cn.Execute sql, rdExecDirect
     '  If Check3.value = 1 Then
     '
     '  Else
     
    m_desc = Trim(view_demand.Recordset![dmd_desc])
    m_len = Len(Trim(view_demand.Recordset![dmd_desc]))
    m_desc1 = ""
    i = 1
    If Not m_desc = "" Then
   While i < m_len + 1
      m_char = Mid(m_desc, i, 1)
     If m_char = ":" Or m_char = Chr(10) Or m_char = Chr(13) Or m_char = Chr(34) Or m_char = "/" Or m_char = "?" Or m_char = "<" Or m_char = ">" Or m_char = "*" Or m_char = "\" Or m_char = "|" Or m_char = "ø" Then
        m_desc1 = m_desc1 + " "
     Else
        m_desc1 = m_desc1 + Mid(m_desc, i, 1)
     End If
     i = i + 1
   Wend
    End If
       Source = v_nam
    dest = v_name + m_desc1 + " Clip " + Trim(Str(view_demand.Recordset![dmd_ser])) + V_EXT
      k = 1
     While FileExists(dest)
       dest = v_name + LTrim(Str(k)) + "_" + m_desc1 + " Clip " + Trim(Str(view_demand.Recordset![dmd_ser])) + V_EXT
    k = k + 1
     Wend
    Name Source As dest
  'End If
'         Else
''  m_txt_no = m_txt_no + Str(m_dmd_mch_stock) + " , "
' End If
Else
  m_txt_no = m_txt_no + Str(m_dmd_mch_stock) + " , "
End If
'End If
Else
   m_chek = 0
  If Not IsNull(view_demand.Recordset![dmd_chek]) Then
     m_chek = view_demand.Recordset![dmd_chek]
  End If
If m_chek = 1 Then
 k = 1
End If
End If
    view_demand.Recordset.MoveNext
'    i = i + 1
Wend
End If
view_demand.Refresh
If m_txt_no = "" Then
 If k1 = 1 Then
  MsgBox "«‰ Â  ⁄„·Ì… «·‰”Œ..."
 Else
  MsgBox "·« ÌÊÃœ „Ê«œ „Œ «—… ·· ‰›Ì–..."
 End If
Else
 MsgBox "«—ﬁ«„ «·«‘—ÿ… «· Ì ·„  ‰›– : " & m_txt_no
End If
If k = 1 Then
 MsgBox "ÌÊÃœ „‘«Âœ ·„  ‰›– «·« „‰ ﬁ»· «·«—‘Ì›"
End If

End Sub

 Private Sub Command15_Click()
If is_in = 1 Or is_out = 1 Then
Dim ok As Integer
m_typ_add = 1
 If is_out = 0 Then
   LEN_MCH(IND) = 60
   m_len_mch = 60

 End If
 ' On Error Resume Next
 ok = 1
' If Not IsNull(RESULT.Recordset![mch_ext]) Then
'  If RESULT.Recordset![mch_ext] = "MXF" Then
'     ok = 2
'     Frame6.Visible = True
'  End If
' End If

 If ok = 1 Then
 If Not m_dmd_desc.Text = "" Then
    m_desc = LTrim(m_dmd_desc.Text)
    m_len = Len(LTrim(m_dmd_desc.Text))
    i = 1
    m_desc1 = ""
   While i < m_len + 1
      m_char = Mid(m_desc, i, 1)
     If m_char = ":" Or m_char = Chr(10) Or m_char = Chr(13) Or m_char = Chr(34) Or m_char = "/" Or m_char = "?" Or m_char = "<" Or m_char = ">" Or m_char = "*" Or m_char = "\" Or m_char = "|" Or m_char = "ø" Then
        m_desc1 = m_desc1 + " "
     Else
        m_desc1 = m_desc1 + Mid(m_desc, i, 1)
     End If
     i = i + 1
   Wend
   m_dmd_desc = m_desc1
  Else
    m_desc = LTrim(Mid(v_mch_tit, 1, 80))
    m_len = Len(LTrim(Mid(v_mch_tit, 1, 80)))
    i = 1
    m_desc1 = ""
   While i < m_len + 1
      m_char = Mid(m_desc, i, 1)
     If m_char = ":" Or m_char = Chr(10) Or m_char = Chr(13) Or m_char = Chr(34) Or m_char = "/" Or m_char = "?" Or m_char = "<" Or m_char = ">" Or m_char = "*" Or m_char = "\" Or m_char = "|" Or m_char = "ø" Then
        m_desc1 = m_desc1 + " "
     Else
        m_desc1 = m_desc1 + Mid(m_desc, i, 1)
     End If
     i = i + 1
   Wend
  m_dmd_desc = Str(V_MCH_STOCK) + " _ " + m_desc1
End If
 If Not V_MCH_STOCK = 0 Then
 m_time = m_len_mch
m_dmd_o = Int(m_time / 3600)
M_REST1 = m_time Mod 3600
m_dmd_m = Int(M_REST1 / 60)
m_dmd_s = M_REST1 Mod 60
m_dmd_f = 0
m_dmd_time1 = time
m_dmd_nature = "001"
m_dmd_cote = Space(50)
If m_len_mch < 400 Or box_user_start < 2 Then
If m_dmd_ser = 0 Then
   m_date = Format(Date, "dd/mm/yyyy")
  sql = "exec op_demand "
  cn.Execute sql, rdExecDirect
  tmp.sql = "execute max_demand "
  tmp.Refresh
  m_dmd_no1 = tmp.Resultset![max_dmd_no]
  m_dmd_ser = 1
  sql = "execute upd_demand4 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_dmd_ser & "'" & "," _
                               & "'" & Format(m_date, "yyyy/mm/dd") & "'" & "," & "'" & box_user_no & "'" & "," _
                                & "'" & v_mch_no & "'" & "," & "'" & m_path & "'" & "," _
                                & "'" & m_streamstart & "'" & "," & "'" & m_len_mch & "'" & "," & "'" & V_MCH_STOCK & "'" & "," & "'" & m_dmd_desc & "'" & "," _
                                 & "'" & m_dmd_s & "'" & "," & "'" & m_dmd_m & "'" & "," & "'" & m_dmd_o & "'" & "," & "'" & m_dmd_f & "'" & "," & "'" & m_dmd_time1 & "'" & "," & "'" & m_dmd_cote & "'"
                                 
                                
      cn.Execute sql, rdExecDirect

  m_dmd_chek = 1
        sql = "execute upd_demand1 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_dmd_ser & "'" & "," _
              & "'" & m_dmd_chek & "'"
              
       cn.Execute sql, rdExecDirect
  view_demand.Refresh
Else
m_dmd_no1 = view_demand.Recordset![dmd_no]
   tmp.sql = "execute max_demand_ser " & "'" & m_dmd_no1 & "'"
  tmp.Refresh
  m_dmd_ser = tmp.Resultset![max_dmd_ser]
  m_dmd_ser = m_dmd_ser + 1
  
   m_date = Format(Date, "dd/mm/yyyy")
   sql = "execute insr_demand4 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_dmd_ser & "'" & "," _
                               & "'" & Format(m_date, "yyyy/mm/dd") & "'" & "," & "'" & box_user_no & "'" & "," _
                                & "'" & v_mch_no & "'" & "," & "'" & m_path & "'" & "," _
                                & "'" & m_streamstart & "'" & "," & "'" & m_len_mch & "'" & "," & "'" & V_MCH_STOCK & "'" & "," & "'" & m_dmd_desc & "'" & "," _
                                & "'" & m_dmd_s & "'" & "," & "'" & m_dmd_m & "'" & "," & "'" & m_dmd_o & "'" & "," & "'" & m_dmd_f & "'" & "," & "'" & m_dmd_time1 & "'" & "," & "'" & m_dmd_cote & "'"
                                
                                
      cn.Execute sql, rdExecDirect
       
       m_dmd_chek = 1
        sql = "execute upd_demand1 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_dmd_ser & "'" & "," _
              & "'" & m_dmd_chek & "'"
              
       cn.Execute sql, rdExecDirect
       view_demand.Refresh

End If
   m_dmd_desc.Text = ""
is_in = 0
is_out = 0
Else
 MsgBox "·« Ì„ﬂ‰ «÷«›… «·„‘Âœ ·«‰ „œ Â «ﬂÀ— „‰ 500 À«‰Ì…"
End If

End If
End If
ElseIf is_in = 0 And is_out = 0 Then
  m_typ_add = 2
 ok = 1
 'If Not IsNull(RESULT.Recordset![mch_ext]) Then
 ' If RESULT.Recordset![mch_ext] = "MXF" Then
 '    ok = 2
 '    Frame6.Visible = True
 ' End If
' End If
 If ok = 1 Then
 If Not RESULT.Recordset.EOF And Not RESULT.Recordset.BOF Then
 V_MCH_STOCK = RESULT.Recordset![dig_DIG_NO]
If Not V_MCH_STOCK = 0 Then
 
m_config_path1 = high_stock_path(V_MCH_STOCK)
v_mch_o = RESULT.Recordset![dig_o]
 v_mch_m = RESULT.Recordset![dig_m]
 v_mch_s = RESULT.Recordset![dig_s]
v_mch_o1 = RESULT.Recordset![dig_o1]
 v_mch_m1 = RESULT.Recordset![dig_m1]
 v_mch_s1 = RESULT.Recordset![dig_s1]
 v_mch_no = RESULT.Recordset![mn_app_no]
v_mch_tit = RESULT.Recordset![MN_ACT_TTL]
 m_time = Val(v_mch_s) + Val(v_mch_m) * 60 + Val(v_mch_o) * 3600
 m_time1 = Val(v_mch_s1) + Val(v_mch_m1) * 60 + Val(v_mch_o1) * 3600
 m_streamstart = m_time
 If (m_time1 - m_time) < 400 Or box_user_start < 2 Then
  If Not IsNull(Trim(RESULT.Recordset![dig_typ])) And Not Trim(RESULT.Recordset![dig_typ]) = "" Then
 v_mch_ext = Trim(RESULT.Recordset![dig_typ])
 Else
 v_mch_ext = "avi"
 End If
 m_config_path1 = high_stock_path(V_MCH_STOCK)
 m_path = m_config_path1 + Trim(V_MCH_STOCK) + "." + v_mch_ext
  m_len_mch = m_time1 - m_streamstart
m_dmd_desc = Str(V_MCH_STOCK) + " _ " + Mid(v_mch_tit, 1, 80)
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
     If m_char = ":" Or m_char = Chr(13) Or m_char = Chr(10) Or m_char = Chr(34) Or m_char = "/" Or m_char = "?" Or m_char = "<" Or m_char = ">" Or m_char = "*" Or m_char = "\" Or m_char = "|" Or m_char = "ø" Then
        m_desc1 = m_desc1 + " "
     Else
        m_desc1 = m_desc1 + Mid(m_desc, i, 1)
     End If
     i = i + 1
   Wend
   m_dmd_desc.Text = m_desc1
End If
m_dmd_time1 = time
m_dmd_nature = "001"
m_dmd_cote = Space(50)
If m_dmd_ser = 0 Then

   m_date = Format(Date, "dd/mm/yyyy")
  sql = "exec op_demand "
  cn.Execute sql, rdExecDirect
  tmp.sql = "execute max_demand "
  tmp.Refresh
  m_dmd_no1 = tmp.Resultset![max_dmd_no]
  m_dmd_ser = 1
  sql = "execute upd_demand5 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_dmd_ser & "'" & "," _
                               & "'" & Format(m_date, "yyyy/mm/dd") & "'" & "," & "'" & box_user_no & "'" & "," _
                                & "'" & v_mch_no & "'" & "," & "'" & m_path & "'" & "," _
                                & "'" & m_streamstart & "'" & "," & "'" & m_len_mch & "'" & "," & "'" & V_MCH_STOCK & "'" & "," & "'" & m_dmd_desc.Text & "'" & "," _
                                 & "'" & m_dmd_s & "'" & "," & "'" & m_dmd_m & "'" & "," & "'" & m_dmd_o & "'" & "," & "'" & m_dmd_f & "'" & "," & "'" & m_dmd_time1 & "'" & "," & "'" & m_dmd_cote & "'"
                              
                                
      cn.Execute sql, rdExecDirect
  
   
       m_dmd_chek = 1
        sql = "execute upd_demand1 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_dmd_ser & "'" & "," _
              & "'" & m_dmd_chek & "'"
              
       cn.Execute sql, rdExecDirect
  view_demand.Refresh
Else
m_dmd_no1 = view_demand.Recordset![dmd_no]
   tmp.sql = "execute max_demand_ser " & "'" & m_dmd_no1 & "'"
  tmp.Refresh
  m_dmd_ser = tmp.Resultset![max_dmd_ser]
  m_dmd_ser = m_dmd_ser + 1
  
   m_date = Format(Date, "dd/mm/yyyy")
   sql = "execute insr_demand4 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_dmd_ser & "'" & "," _
                               & "'" & Format(m_date, "yyyy/mm/dd") & "'" & "," & "'" & box_user_no & "'" & "," _
                                & "'" & v_mch_no & "'" & "," & "'" & m_path & "'" & "," _
                                & "'" & m_streamstart & "'" & "," & "'" & m_len_mch & "'" & "," & "'" & V_MCH_STOCK & "'" & "," & "'" & m_dmd_desc.Text & "'" & "," _
                                & "'" & m_dmd_s & "'" & "," & "'" & m_dmd_m & "'" & "," & "'" & m_dmd_o & "'" & "," & "'" & m_dmd_f & "'" & "," & "'" & m_dmd_time1 & "'" & "," & "'" & m_dmd_cote & "'"
                                  
                                
      cn.Execute sql, rdExecDirect
       m_dmd_chek = 1
        sql = "execute upd_demand1 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_dmd_ser & "'" & "," _
              & "'" & m_dmd_chek & "'"
              
       cn.Execute sql, rdExecDirect
       view_demand.Refresh
  
End If
m_dmd_desc.Text = ""
Else
 MsgBox "·« Ì„ﬂ‰ «÷«›… «·„‘Âœ ·«‰ „œ Â «ﬂÀ— „‰ 500 À«‰Ì…"
End If
End If
End If
End If

End If
End Sub

Private Sub Command16_Click()
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
  MsgBox "⁄œœ «·„‘«Âœ = " & nb_rec & " «·„œ… «·«Ã„«·Ì… : " & m_dmd_o & ":" & m_dmd_m & ":" & m_dmd_s
End If


End Sub

Private Sub Command18_Click()
 
Frame6.Visible = False

End Sub

Private Sub Command19_Click()
Frame6.Visible = False
If m_typ_add = 2 Then
 V_MCH_STOCK = Val(RESULT.Recordset![mch_STOCK])
If Not V_MCH_STOCK = 0 Then
'If V_MCH_STOCK > 1 And w_MCH_STOCK < 30000 Then
'  m_config_path1 = "\\ar2storage\ar2highres\final_archive\"
' ElseIf w_MCH_STOCK > 30000 Then
'   m_config_path1 = "\\Xenarchive1\x\Programs\"
'End If
 m_config_path1 = high_stock_path(V_MCH_STOCK)
v_mch_o = RESULT.Recordset![mch_o]
 v_mch_m = RESULT.Recordset![mch_m]
 v_mch_s = RESULT.Recordset![mch_s]
v_mch_o1 = RESULT.Recordset![mch_o1]
 v_mch_m1 = RESULT.Recordset![mch_m1]
 v_mch_s1 = RESULT.Recordset![mch_s1]
 v_mch_no = RESULT.Recordset![mch_NO]
v_mch_tit = RESULT.Recordset![mch_TIT]
 m_time = Val(v_mch_s) + Val(v_mch_m) * 60 + Val(v_mch_o) * 3600
 m_time1 = Val(v_mch_s1) + Val(v_mch_m1) * 60 + Val(v_mch_o1) * 3600
 m_streamstart = m_time
m_path = m_config_path1 + Trim(V_MCH_STOCK) + "." + RESULT.Recordset![mch_ext]
 m_len_mch = m_time1 - m_streamstart
m_dmd_desc = Str(V_MCH_STOCK) + " _ " + Mid(v_mch_tit, 1, 80)
End If
End If
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
     If m_char = ":" Or m_char = Chr(13) Or m_char = Chr(10) Or m_char = Chr(34) Or m_char = "/" Or m_char = "?" Or m_char = "<" Or m_char = ">" Or m_char = "*" Or m_char = "\" Or m_char = "|" Or m_char = "ø" Then
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
   m_dmd_desc.Text = ""
'End If
End Sub

Private Sub Command2_Click()
Unload USER_INTERFACE1
End Sub

Private Sub Command20_Click()
 m_dmd_no1 = DataGrid2.Columns(2)
   m_dmd_ser1 = DataGrid2.Columns(3)
    If Not IsNull(view_demand.Recordset![dmd_chek]) Then
     m_chek = view_demand.Recordset![dmd_chek]
  End If
  If m_chek <> 2 Then

    sql = "exec del_demand" & "'" & m_dmd_no1 & "'" & "," & "'" & m_dmd_ser1 & "'"
    
     cn.Execute sql, rdExecDirect
     view_demand.Refresh
     m_dmd_ser = m_dmd_ser - 1
End If
Frame2.Visible = False
    DataGrid2.SetFocus
End Sub

Private Sub Command21_Click()
Frame2.Visible = False
DataGrid2.SetFocus

End Sub

Private Sub Command22_Click()
Dim sql As String

 m_no = DataGrid1.Columns(6)
  sql = "execute  upd_mchd_rmrk " & "'" & m_no & "'" & "," & "'" & m_mch_user_rmrk.Text & "'"
    cn.Execute sql, rdExecDirect
    RESULT.Refresh
    
    Frame3.Visible = False
DataGrid1.SetFocus

End Sub

Private Sub Command23_Click()
Frame3.Visible = False
DataGrid1.SetFocus


End Sub

Private Sub Command24_Click()
 Dim var_temp, VAR_TEMP1 As Variant
On Error Resume Next
Dim v_name As String
v_name = ""
' m_mch_stock = view_res.result.Recordset![mch_stock]
 auto_no = 0
 STARTTIME = 0

lg_stop = True
CommonDialog1.CancelError = True
Err.Clear
CommonDialog1.Filter = strFilter
CommonDialog1.ShowSave
If Err.Number = 0 Then
   ' result = Me.VideoEdit1.Save(CommonDialog1.FileName)

v_name = CommonDialog1.FileName
v1_path = PathFileToPath(v_name)
v1_name = nameFileToPath(v_name)
 v_name = ShortPathName(v1_path) + v1_name
  v_name = v_name + ".txt"
 
'  PATH_nam = m_config_path + Trim(m_mch_stock) + ".avi"
 var_temp = Chr(34) + "ID" + Chr(34) + ";" + Chr(34) + "Track" + Chr(34) + ";" + Chr(34) + "StartTime" + Chr(34) + ";" + Chr(34) + "Length" + Chr(34) + ";" + Chr(34) + "PlayRate" + Chr(34) + ";" + Chr(34) + "Locked" + Chr(34) + _
 ";" + Chr(34) + "Normalized" + Chr(34) + ";" + Chr(34) + "StretchMethod" + Chr(34) + ";" + Chr(34) + "Looped" + Chr(34) + ";" + Chr(34) + "OnRuler" + Chr(34) + ";" + Chr(34) + "MediaType" + Chr(34) + ";" + Chr(34) + "FileName" + Chr(34) + ";" + Chr(34) + "Stream" + _
 Chr(34) + ";" + Chr(34) + "StreamStart" + Chr(34) + ";" + Chr(34) + "StreamLength" + Chr(34) + ";" + Chr(34) + "FadeTimeIn" + Chr(34) + ";" + Chr(34) + "FadeTimeOut" + Chr(34) + ";" + Chr(34) + "SustainGain" + Chr(34) + ";" + Chr(34) + "CurveIn" + Chr(34) + ";" + Chr(34) + "GainIn" + Chr(34) + _
 ";" + Chr(34) + "CurveOut" + Chr(34) + ";" + Chr(34) + "GainOut" + Chr(34) + ";" + Chr(34) + "Layer" + Chr(34) + ";" + Chr(34) + "Color" + Chr(34) + ";" + Chr(34) + "CurveInR" + Chr(34) + ";" + Chr(34) + "CurveOutR" + Chr(34) + ";" + Chr(34) + "PlayPitch" + Chr(34) + ";" + Chr(34) + "LockPitch" + Chr(34)
' ar_temp = text1.Text
 'M_NAM1 = "\\arstorage\hires\mash\" & Trim(m_nam_file.Text) & ".txt"
  
  
'  For i = 1 To IND
view_demand.Recordset.MoveFirst
i = 1
 While Not view_demand.Recordset.EOF And lg_stop
 V_PATH = Trim(view_demand.Recordset![dmd_path])
    If Not IsNull(view_demand.Recordset![dmd_chek]) Then
     m_chek = view_demand.Recordset![dmd_chek]
  End If
If m_chek = 1 Then

 If Mid(V_PATH, 1, 5) = "\\ar2" Then
   If auto_no = 0 Then
    Open v_name For Output As #1
     Print #1, var_temp
   End If
    v_nam = v_name + "_" + LTrim(Str(i)) + V_EXT
   m_name1 = Trim(view_demand.Recordset![dmd_desc])
   v_streamstart = view_demand.Recordset![dmd_in] * 1000
   v_len_mch = view_demand.Recordset![dmd_out] * 1000
   m_dmd_mch_stock = view_demand.Recordset![dmd_mch_stock]
   
  
   auto_no = auto_no + 1
     VAR_TEMP1 = LTrim(Str(auto_no)) & ";" & "    1;" & Str(STARTTIME) & ";" & Str(v_len_mch) & ";" & "    1.000000;    FALSE;    FALSE;    0;    TRUE;    FALSE;    VIDEO;" & Chr(34) & V_PATH & Chr(34) & ";   0;" & Str(v_streamstart) & ";" & Str(v_len_mch) & ";  0.0000;    0.0000;    1.000000;    4;    0.000000;    4;    0.000000;    0;    -1;    4;    4;    0.000000;    FALSE "
     STARTTIME = STARTTIME + v_len_mch
     Print #1, VAR_TEMP1
   End If
   End If
     view_demand.Recordset.MoveNext
  Wend
  STARTTIME = 0
view_demand.Recordset.MoveFirst
i = 1
 While Not view_demand.Recordset.EOF And lg_stop
 V_PATH = Trim(view_demand.Recordset![dmd_path])
    If Not IsNull(view_demand.Recordset![dmd_chek]) Then
     m_chek = view_demand.Recordset![dmd_chek]
  End If
If m_chek = 1 Then

 If Mid(V_PATH, 1, 5) = "\\ar2" Then
    v_nam = v_name + "_" + LTrim(Str(i)) + V_EXT
 m_name1 = Trim(view_demand.Recordset![dmd_desc])
 v_streamstart = view_demand.Recordset![dmd_in] * 1000
 v_len_mch = view_demand.Recordset![dmd_out] * 1000
 m_dmd_mch_stock = view_demand.Recordset![dmd_mch_stock]

   auto_no = auto_no + 1
     var_temp2 = LTrim(Str(auto_no)) & ";" & "    0;" & Str(STARTTIME) & ";" & Str(v_len_mch) & ";" & "    1.000000;    FALSE;    FALSE;    0;    TRUE;    FALSE;    AUDIO;" & Chr(34) & V_PATH & Chr(34) & ";   0;" & Str(v_streamstart) & ";" & Str(v_len_mch) & ";  10.0000;    10.0000;    1.000000;    2;    0.000000;    -2;    0.000000;    0;    -1;    -2;    2;    0.000000;    FALSE "
        STARTTIME = STARTTIME + v_len_mch
     Print #1, var_temp2
          m_dmd_no1 = view_demand.Recordset![dmd_no]
       m_ser = view_demand.Recordset![dmd_ser]
       m_dmd_chek = 2
       sql = "execute upd_demand1 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_ser & "'" & "," _
              & "'" & m_dmd_chek & "'"
              
       cn.Execute sql, rdExecDirect
     End If
     End If
     view_demand.Recordset.MoveNext
  Wend
   Close #1
   DataGrid1.SetFocus
 
End If
view_demand.Refresh

If auto_no = 0 Then
     MsgBox "·« ÌÊÃœ „Ê«œ „Œ «—… ·· ‰›Ì–..."
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
m_nbword = 0
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
qst12 = 0
qst13 = 0
qst11 = 0
qst14 = 0
qst15 = 0
qst16 = 0
'm_nb_mch.Text = ""
first_qst = 0
m_word.Text = ""
m_mch_typ.Text = ""
  
 m_dig_typ1.BoundText = ""
m_file_no.Text = ""
m_file_no1.Text = ""
m_desc_no.Text = ""
m_nar_desc.Text = ""
m_file_geo.Text = ""
M_art_dte.Text = "__/__/____"
M_art_dte1.Text = "__/__/____"
  m_txt_text.Text = ""

m_word.Enabled = True
m_mch_typ.Enabled = True
 
m_file_no1.Enabled = True
m_dig_typ1.Enabled = True
m_file_no.Enabled = True
m_file_geo.Enabled = True
m_desc_no.Enabled = True
M_art_dte.Enabled = True
M_art_dte1.Enabled = True
m_txt_text.Enabled = True
m_nar_desc.Enabled = True

If DBList1.Visible = True Then
  DBList1.Visible = False
End If
If DBList2.Visible = True Then
  DBList2.Visible = False
End If
first_qst = 0
 RESULT.RecordSource = "execute interface_null1"
 RESULT.Refresh
 

crit1 = ""
crit1 = ""
 CRIT = "create proc interface_result" + box_user_no + " AS "

 CRIT = CRIT & "SELECT DISTINCT " & _
                       "dbo.AUTHER.AUT_NAM AS res_res_no, dbo.MAIN.MN_APP_NO AS mn_app_no, dbo.MAIN.MN_ACT_TTL AS mn_act_ttl, " & _
                       "dbo.MAIN.MN_ADD_TTL AS mn_add_ttl, dbo.CODING.SUB_DESC AS dig_typ2, dbo.ARTICLE.ART_DTE AS art_dte,dbo.ARTICLE.ART_pg_no AS ART_pg_no, " & _
                       "dbo.PERIOD.PER_PER_NA AS art_per_no,dbo.digit.dig_dig_no  as dig_dig_no ,dbo.digit.dig_typ as dig_typ  , dbo.digit.dig_typ1 as dig_typ1 , dbo.digit.dig_choice as dig_choice  " & _
                       ", dbo.digit.dig_typ_high as dig_typ_high , dbo.digit.dig_s as dig_s , dbo.digit.dig_o as dig_o , dbo.digit.dig_m as dig_m , dbo.digit.dig_s1 as dig_s1 , dbo.digit.dig_o1 as dig_o1 , dbo.digit.dig_m1 as dig_m1 " & _
"FROM         dbo.MAIN left JOIN " & _
                      "dbo.ARTICLE ON dbo.MAIN.MN_APP_NO = dbo.ARTICLE.ART_APP_NO left JOIN " & _
                      "dbo.RES ON dbo.ARTICLE.ART_APP_NO = dbo.RES.RES_APP_NO left JOIN " & _
                      "dbo.AUTHER ON dbo.RES.RES_RES_NO = dbo.AUTHER.AUT_NO left JOIN " & _
                      "dbo.PERIOD ON dbo.ARTICLE.ART_PER_NO = dbo.PERIOD.PER_PER_NO left join " & _
                     "dbo.digit ON dbo.MAIN.MN_APP_NO = dbo.digit.dig_no left JOIN " & _
                      "dbo.CODING ON '24'+ dbo.digit.dig_typ1 = dbo.CODING.SUB_CODE "
                        



End Sub

Private Sub Command5_Click()
 On Error Resume Next
Dim lg As Boolean
Dim m_txt_no, X, v, dest, v_nam_png As String
Dim v_name As String
v_name = ""
k1 = 0
m_tit.Text = ""
m_txt_no = ""
lg = False
 
lg_stop = True
'CommonDialog1.CancelError = True
'Err.Clear
'CommonDialog1.Filter = strFilter
'CommonDialog1.ShowSave
'If Err.Number = 0 Then
   ' result = Me.VideoEdit1.Save(CommonDialog1.FileName)

Dim ar_path(20), v_nam As String
Dim aR_STREAM(20) As Double
Dim ar_mch(20) As Double
i = 1
k = 0
m_t = "«‰ Ÿ— Ì „ ‰”Œ «·„Ê«œ.... «·⁄‰Ê«‰ = "
nb_copy = 1
v_name = box_user_path
'v1_path = PathFileToPath(v_name)
'v1_name = nameFileToPath(v_name)
' v_name = ShortPathName(v1_path) + v1_name
stretchmode = 2
view_demand.Recordset.MoveFirst
i = 1
'Frame4.Visible = True
 
 While Not view_demand.Recordset.EOF And lg_stop
  
   V_PATH = Trim(view_demand.Recordset![dmd_path])
  If Not Mid(V_PATH, 1, 5) = "\\xen" Or box_user_start = 1 Then
   V_EXT = Mid(V_PATH, Len(V_PATH) - 3, 4)
'  If Check3.value = 1 Then
'   v_nam = v_NAME + ".AVI"
'  Else
   ' v_nam =  v_name + Trim(view_demand.Recordset![dmd_desc]) + " Clip " + Trim(Str(view_demand.Recordset![dmd_ser])) + ".avi"
    m_date1 = Trim(Str(Day(Date))) + "-" + Trim(Str(Month(Date))) + "-" + Trim(Str(Year(Date)))
     m_time = Format(time, "HHMMSS")
   ' MsgBox m_time
   ' m_time1 = (Mid(m_time, 1, 2))
   ' m_time1 = m_time1 + Mid(m_time, 4, 2)
   ' m_time1 = m_time1 + Mid(m_time, 7, 2)
   ' m_time1 = Trim(m_time)
     v_nam_png = v_name + "ARCHIVE_" + box_user_no + "_" + m_date1 + "_" + m_time + ".png"
    
    v_name1 = "ARCHIVE_" + box_user_no + "_" + m_date1 + "_" + m_time + V_EXT
     v_nam = v_name + v_name1
    
' v_nam = v_name + Trim(view_demand.Recordset![dmd_desc]) + "_Clip_" + Trim(Str(view_demand.Recordset![dmd_ser])) + v_ext
    
'   End If
'  If Check3.value = 1 Then
'    k = 1
'    While FileExists(v_nam)
'        v_nam = v_name + "_" + LTrim(Str(k)) + "_" + LTrim(Str(i)) + v_ext
'       k = k + 1
'     Wend
' End If
 m_name2 = Trim(view_demand.Recordset![dmd_desc])

 
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
time_code3 = v_o1 + ":" + v_m1 + ":" + v_s1 + " "
'time_code = " -ss " + Str(m_time) + " "
'time_code1 = " -t " + Str(m_time1) + " "



If m_chek = 1 Then
If i = 1 Then
m_tit.Visible = True


 m_tit.Text = m_t + m_name2
  m_tit.Refresh
Else
m_tit.Text = m_t + m_name2
  m_tit.Refresh

End If
 k1 = 1
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
   X = "c:\ffmpeg " + time_code + " -i " + V_PATH + " -acodec pcm_s16le -s 720x576  " + " -vcodec dvvideo  " + time_code1 + v_nam
'X = "ffmpeg " + time_code + " -i " + v_path + " -acodec copy  " + " -vcodec copy  " + time_code1 + v_nam
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
    
'     m_tit1.Text = m_name1
'     m_tit1.Refresh
'    ProgressBar1.max = m_max * 2500
'    v_max = m_max * 2500
'    For j = 1 To v_max
'      ProgressBar1.value = j
''    Next j
     
    'Wait for the process to complete
    
    lRetVal = WaitForSingleObject(m_max, INFINITE)
    lRetVal = CloseHandle(m_max)
'     nb_copy = nb_copy + 1
'     nb_copy.Refresh
     
 
'     If FileExists(v_nam) Then
  
       '  progress.m_tit.Text = m_name1
       ' progress.Show 1
    '    ffmpeg -ss 00:00:02 -i "c:\videoname.avi"  -frames:v 1  "c:\Videothumbnail.png"
   
    
   
      X = "c:\ffmpeg -ss 00:00:02 -i " + v_nam + " -frames:v 1   " + v_nam_png
      sCommandLine = X
      lRetVal = Shell(sCommandLine, vbHide)
If FileExists(v_nam) Then
       
If Not IsNull(box_user_path) And Not box_user_path = "" Then

       m_dmd_no1 = view_demand.Recordset![dmd_no]
       m_ser = view_demand.Recordset![dmd_ser]
       m_dmd_chek = 2
       sql = "execute upd_demand1 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_ser & "'" & "," _
              & "'" & m_dmd_chek & "'"
              
       cn.Execute sql, rdExecDirect
        sql = "execute upd_dmd_user_do  " & "'" & m_dmd_no1 & "'" & "," & "'" & m_ser & "'" & "," _
            & "'" & box_user_no & "'"
      cn.Execute sql, rdExecDirect

 End If
     '  If Check3.value = 1 Then
     '
     '  Else
     
' m_desc = Trim(view_demand.Recordset![dmd_desc])
'ÿ m_len = Len(Trim(view_demand.Recordset![dmd_desc]))
''    m_desc1 = ""
 '   i = 1
 '   If Not m_desc = "" Then
 '  While i < m_len + 1
 '     m_char = Mid(m_desc, i, 1)
 '    If m_char = ":" Or m_char = Chr(10) Or m_char = Chr(13) Or m_char = Chr(34) Or m_char = "/" Or m_char = "?" Or m_char = "<" Or m_char = ">" Or m_char = "*" Or m_char = "\" Or m_char = "|" Or m_char = "ø" Then
 '       m_desc1 = m_desc1 + " "
 '    Else
 '       m_desc1 = m_desc1 + Mid(m_desc, i, 1)
 '    End If
 '    i = i + 1
 '  Wend
 '  End If
      Dim m_finich As Boolean
      
       m_titles = Trim(view_demand.Recordset![dmd_desc])
       m_finch = True
       m_date = Format(Date, "dd/mm/yyyy")
       
       m_user_name = Trim(view_demand.Recordset![user_name])
       m_id = 9
       sql = "execute INSERT_TBL_FILES " & "'" & v_name1 & "'" & "," & "'" & m_titles & "'" & "," _
              & "'" & m_finch & "'" & "," & "'" & m_finch & "'" & "," & "'" & m_titles & "'" & "," _
              & "'" & time_code3 & "'" & "," & "'" & m_user_name & "'" & "," & "'" & m_id & "'"
              
       cn1.Execute sql, rdExecDirect
       
    '& "'" & Format(m_date, "yyyy/mm/dd") & "'"
   '    Source = v_nam
   ' dest = v_name + m_desc1 + " Clip " + Trim(Str(view_demand.Recordset![dmd_ser])) + v_ext
   '   k = 1
   '  While FileExists(dest)
   '    dest = v_name + LTrim(Str(k)) + "_" + m_desc1 + " Clip " + Trim(Str(view_demand.Recordset![dmd_ser])) + v_ext
   ' k = k + 1
   '  Wend
   ' Name Source As dest
  'End If
'         Else
''  m_txt_no = m_txt_no + Str(m_dmd_mch_stock) + " , "
' End If
Else
  m_txt_no = m_txt_no + Str(m_dmd_mch_stock) + " , "
  k = 1
End If
Else
  m_txt_no = m_txt_no + Str(m_dmd_mch_stock) + " , "
  k = 1
End If

End If
Else
   m_chek = 0
  If Not IsNull(view_demand.Recordset![dmd_chek]) Then
     m_chek = view_demand.Recordset![dmd_chek]
  End If
If m_chek = 1 Then
 k = 1
End If
End If
    view_demand.Recordset.MoveNext
'    i = i + 1
Wend
m_tit.Visible = False
 
view_demand.Refresh
If m_txt_no = "" Then
 If k1 = 1 Then
  MsgBox "«‰ Â  ⁄„·Ì… «·‰”Œ..."
 Else
  MsgBox "·« ÌÊÃœ „Ê«œ „Œ «—… ·· ‰›Ì–..."
 End If
Else
 MsgBox "«—ﬁ«„ «·«‘—ÿ… «· Ì ·„  ‰›– : " & m_txt_no
End If
If k = 1 Then
 MsgBox "« ’· »«·«—‘Ì› · ‰›Ì– »«ﬁÌ «·„‘«Âœ"
End If

End Sub

Private Sub Command6_Click()
Dim m_str As String
'm_str = "C:\Program Files\Microsoft Office\Office\winword.exe " & " c:\archive61\archive_manar\" & "„”«⁄œ" & ".doc"
'X = Shell(m_str, 1)
End Sub

Private Sub Command7_Click()
 On Error Resume Next
Dim lg As Boolean
Dim m_txt_no, X, v, dest As String
Dim v_name As String
v_name = ""
k1 = 0

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
k = 0
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
  If Mid(V_PATH, 1, 5) = "\\ar2" Then
   V_EXT = Mid(V_PATH, Len(V_PATH) - 3, 4)
'  If Check3.value = 1 Then
'   v_nam = v_NAME + ".AVI"
'  Else
   ' v_nam =  v_name + Trim(view_demand.Recordset![dmd_desc]) + " Clip " + Trim(Str(view_demand.Recordset![dmd_ser])) + ".avi"

    v_nam = v_name + "_" + LTrim(Str(i)) + V_EXT
' v_nam = v_name + Trim(view_demand.Recordset![dmd_desc]) + "_Clip_" + Trim(Str(view_demand.Recordset![dmd_ser])) + v_ext
    
'   End If
'  If Check3.value = 1 Then
'    k = 1
'    While FileExists(v_nam)
'        v_nam = v_name + "_" + LTrim(Str(k)) + "_" + LTrim(Str(i)) + v_ext
'       k = k + 1
'     Wend
' End If
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
 k1 = 1
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
' X = "ffmpeg " + time_code + " -i " + v_path + " -acodec copy  " + " -vcodec copy  " + time_code1 + v_nam
' X = "ffmpeg " + time_code + " -i " + V_PATH + " -ss 0 " + " -acodec copy  " + " -vcodec copy  " + time_code1 + v_nam
 X = "ffmpeg " + time_code + " -i " + V_PATH + " -acodec pcm_s16le -s 720x576  " + " -vcodec dvvideo  " + time_code1 + v_nam
'  X = "ffmpeg " + time_code + " -i " + V_PATH + " -c copy  " + time_code1 + v_nam
 Dim sCommandLine As String
Dim FileToOpen As String
sCommandLine = X

'-vcodec dvvideo -acodec pcm_s16le -s 720x576
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
'    ProgressBar1.max = m_max * 2500
'    v_max = m_max * 2500
'    For j = 1 To v_max
'      ProgressBar1.value = j
''    Next j
     
    'Wait for the process to complete
    
    lRetVal = WaitForSingleObject(m_max, INFINITE)
    lRetVal = CloseHandle(m_max)
     nb_copy = nb_copy + 1
     nb_copy.Refresh
     
 
'     If FileExists(v_nam) Then
  
       '  progress.m_tit.Text = m_name1
       ' progress.Show 1
    
       m_dmd_no1 = view_demand.Recordset![dmd_no]
       m_ser = view_demand.Recordset![dmd_ser]
       m_dmd_chek = 2
       sql = "execute upd_demand1 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_ser & "'" & "," _
              & "'" & m_dmd_chek & "'"
              
       cn.Execute sql, rdExecDirect
     '  If Check3.value = 1 Then
     '
     '  Else
     
    m_desc = Trim(view_demand.Recordset![dmd_desc])
    m_len = Len(Trim(view_demand.Recordset![dmd_desc]))
    m_desc1 = ""
    i = 1
    If Not m_desc = "" Then
   While i < m_len + 1
      m_char = Mid(m_desc, i, 1)
     If m_char = ":" Or m_char = Chr(10) Or m_char = Chr(13) Or m_char = Chr(34) Or m_char = "/" Or m_char = "?" Or m_char = "<" Or m_char = ">" Or m_char = "*" Or m_char = "\" Or m_char = "|" Or m_char = "ø" Then
        m_desc1 = m_desc1 + " "
     Else
        m_desc1 = m_desc1 + Mid(m_desc, i, 1)
     End If
     i = i + 1
   Wend
    End If
       Source = v_nam
    dest = v_name + m_desc1 + " Clip " + Trim(Str(view_demand.Recordset![dmd_ser])) + V_EXT
      k = 1
     While FileExists(dest)
       dest = v_name + LTrim(Str(k)) + "_" + m_desc1 + " Clip " + Trim(Str(view_demand.Recordset![dmd_ser])) + V_EXT
    k = k + 1
     Wend
    Name Source As dest
  'End If
'         Else
''  m_txt_no = m_txt_no + Str(m_dmd_mch_stock) + " , "
' End If
Else
  m_txt_no = m_txt_no + Str(m_dmd_mch_stock) + " , "
End If
End If
Else
   m_chek = 0
  If Not IsNull(view_demand.Recordset![dmd_chek]) Then
     m_chek = view_demand.Recordset![dmd_chek]
  End If
If m_chek = 1 Then
 k = 1
End If
End If
    view_demand.Recordset.MoveNext
'    i = i + 1
Wend
End If
view_demand.Refresh
If m_txt_no = "" Then
 If k1 = 1 Then
  MsgBox "«‰ Â  ⁄„·Ì… «·‰”Œ..."
 Else
  MsgBox "·« ÌÊÃœ „Ê«œ „Œ «—… ·· ‰›Ì–..."
 End If
Else
 MsgBox "«—ﬁ«„ «·«‘—ÿ… «· Ì ·„  ‰›– : " & m_txt_no
End If
If k = 1 Then
 MsgBox "« ’· »«·«—‘Ì› · ‰›Ì– »«ﬁÌ «·„‘«Âœ"
End If
End Sub

Private Sub DBGrid2_KeyDown(KeyCode As Integer, Shift As Integer)
  Dim sql As String
 If KeyCode = vbKeyF2 Then
 m_bk_no = DBGrid2.Columns(8)
 m_form1_load = 2
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 machad_f2.WindowState = 2
 machad_f2.Show
 Screen.MousePointer = vbDefault

 End If
End Sub

Private Sub Command8_Click()
 
    
        
 
 'Dim hWindow As Long
 '        Dim hThread As Long
 '        Dim hProcess As Long
 '        Dim lProcessId As Long
 '        Dim lngResult As Long
 '        Dim lngReturnValue As Long
'
        ' hWindow = FindWindow(vbNullString, "c:\FFmpeg.exe")
'         hThread = GetWindowThreadProcessId(hWindow, lProcessId)
'         hProcess = OpenProcess(SYNCHRONIZE, 0&, lProcessId)
'        ' lngReturnValue = PostMessage(hWindow, WM_CLOSE, 0&, 0&)
'         lngResult = WaitForSingleObject(hProcess, INFINITE)
'
        ' Does the handle still exist?
'         DoEvents
       '  hWindow = FindWindow(vbNullString, "c:\FFmpeg.exe")
'         'If IsWindow(hWindow) = 1 Then
'            'The handle still exists. Use the TerminateProcess function
            'to close all related processes to this handle. See the
''            'article for more information.
         '   MsgBox "Handle still exists."
 '       ' Else
 '           'Handle does not exist.
 ''           MsgBox "All Program Instances Closed."
        ' End If

End Sub

Private Sub Command9_Click()
 Dim var_temp, VAR_TEMP1 As Variant
On Error Resume Next
Dim v_name As String
v_name = ""
' m_mch_stock = view_res.result.Recordset![mch_stock]
 auto_no = 0
 STARTTIME = 0

lg_stop = True
CommonDialog1.CancelError = True
Err.Clear
CommonDialog1.Filter = strFilter
CommonDialog1.ShowSave
If Err.Number = 0 Then
   ' result = Me.VideoEdit1.Save(CommonDialog1.FileName)

v_name = CommonDialog1.FileName
v1_path = PathFileToPath(v_name)
v1_name = nameFileToPath(v_name)
 v_name = ShortPathName(v1_path) + v1_name
 v_name = v_name + ".txt"
 
'  PATH_nam = m_config_path + Trim(m_mch_stock) + ".avi"
 var_temp = Chr(34) + "ID" + Chr(34) + ";" + Chr(34) + "Track" + Chr(34) + ";" + Chr(34) + "StartTime" + Chr(34) + ";" + Chr(34) + "Length" + Chr(34) + ";" + Chr(34) + "PlayRate" + Chr(34) + ";" + Chr(34) + "Locked" + Chr(34) + _
 ";" + Chr(34) + "Normalized" + Chr(34) + ";" + Chr(34) + "StretchMethod" + Chr(34) + ";" + Chr(34) + "Looped" + Chr(34) + ";" + Chr(34) + "OnRuler" + Chr(34) + ";" + Chr(34) + "MediaType" + Chr(34) + ";" + Chr(34) + "FileName" + Chr(34) + ";" + Chr(34) + "Stream" + _
 Chr(34) + ";" + Chr(34) + "StreamStart" + Chr(34) + ";" + Chr(34) + "StreamLength" + Chr(34) + ";" + Chr(34) + "FadeTimeIn" + Chr(34) + ";" + Chr(34) + "FadeTimeOut" + Chr(34) + ";" + Chr(34) + "SustainGain" + Chr(34) + ";" + Chr(34) + "CurveIn" + Chr(34) + ";" + Chr(34) + "GainIn" + Chr(34) + _
 ";" + Chr(34) + "CurveOut" + Chr(34) + ";" + Chr(34) + "GainOut" + Chr(34) + ";" + Chr(34) + "Layer" + Chr(34) + ";" + Chr(34) + "Color" + Chr(34) + ";" + Chr(34) + "CurveInR" + Chr(34) + ";" + Chr(34) + "CurveOutR" + Chr(34) + ";" + Chr(34) + "PlayPitch" + Chr(34) + ";" + Chr(34) + "LockPitch" + Chr(34)
' ar_temp = text1.Text
 'M_NAM1 = "\\arstorage\hires\mash\" & Trim(m_nam_file.Text) & ".txt"
  
'  For i = 1 To IND
view_demand.Recordset.MoveFirst
i = 1
 While Not view_demand.Recordset.EOF And lg_stop
 V_PATH = Trim(view_demand.Recordset![dmd_path])
   If Not IsNull(view_demand.Recordset![dmd_chek]) Then
     m_chek = view_demand.Recordset![dmd_chek]
  End If
If m_chek = 1 Then
 If Mid(V_PATH, 1, 5) = "\\ar2" Then
    If auto_no = 0 Then
    Open v_name For Output As #1
     Print #1, var_temp
   End If
    v_nam = v_name + "_" + LTrim(Str(i)) + V_EXT
   m_name1 = Trim(view_demand.Recordset![dmd_desc])
   v_streamstart = view_demand.Recordset![dmd_in] * 1000
   v_len_mch = view_demand.Recordset![dmd_out] * 1000
   m_dmd_mch_stock = view_demand.Recordset![dmd_mch_stock]
   
  
   auto_no = auto_no + 1
     VAR_TEMP1 = LTrim(Str(auto_no)) & ";" & "    1;" & Str(STARTTIME) & ";" & Str(v_len_mch) & ";" & "    1.000000;    FALSE;    FALSE;    0;    TRUE;    FALSE;    VIDEO;" & Chr(34) & V_PATH & Chr(34) & ";   0;" & Str(v_streamstart) & ";" & Str(v_len_mch) & ";  0.0000;    0.0000;    1.000000;    4;    0.000000;    4;    0.000000;    0;    -1;    4;    4;    0.000000;    FALSE "
     STARTTIME = STARTTIME + v_len_mch
54321     Print #1, VAR_TEMP1
   End If
   End If
     view_demand.Recordset.MoveNext
  Wend
  STARTTIME = 0
view_demand.Recordset.MoveFirst
i = 1
 While Not view_demand.Recordset.EOF And lg_stop
 V_PATH = Trim(view_demand.Recordset![dmd_path])
   If Not IsNull(view_demand.Recordset![dmd_chek]) Then
     m_chek = view_demand.Recordset![dmd_chek]
  End If
If m_chek = 1 Then
 If Mid(V_PATH, 1, 5) = "\\ar2" Then
    v_nam = v_name + "_" + LTrim(Str(i)) + V_EXT
 m_name1 = Trim(view_demand.Recordset![dmd_desc])
 v_streamstart = view_demand.Recordset![dmd_in] * 1000
 v_len_mch = view_demand.Recordset![dmd_out] * 1000
 m_dmd_mch_stock = view_demand.Recordset![dmd_mch_stock]

   auto_no = auto_no + 1
     var_temp2 = LTrim(Str(auto_no)) & ";" & "    0;" & Str(STARTTIME) & ";" & Str(v_len_mch) & ";" & "    1.000000;    FALSE;    FALSE;    0;    TRUE;    FALSE;    AUDIO;" & Chr(34) & V_PATH & Chr(34) & ";   0;" & Str(v_streamstart) & ";" & Str(v_len_mch) & ";  10.0000;    10.0000;    1.000000;    2;    0.000000;    -2;    0.000000;    0;    -1;    -2;    2;    0.000000;    FALSE "
        STARTTIME = STARTTIME + v_len_mch
     Print #1, var_temp2
        m_dmd_no1 = view_demand.Recordset![dmd_no]
       m_ser = view_demand.Recordset![dmd_ser]
       m_dmd_chek = 2
       sql = "execute upd_demand1 " & "'" & m_dmd_no1 & "'" & "," & "'" & m_ser & "'" & "," _
              & "'" & m_dmd_chek & "'"
              
       cn.Execute sql, rdExecDirect
     End If
     End If
     view_demand.Recordset.MoveNext
  Wend
   Close #1
   If auto_no > 0 Then
   DataGrid1.SetFocus
   X1 = "C:\Program Files\Sony\Vegas 7.0\vegas70.exe "
   X2 = "C:\Program Files\Sony\Vegas pro 10.0\vegas100.exe "
   X3 = "C:\Program Files\Sony\Vegas pro 11.0\vegas110.exe "
   X4 = "C:\Program Files\Sony\Vegas pro 13.0\vegas113.exe "
   X5 = "C:\Program Files\Sony\Vegas pro 12.0\vegas112.exe "
   If Dir(X1) <> "" Then
      X = X1 & v_name
    Else
      If Dir(X2) <> "" Then
        X = X2 & v_name
      Else
        If Dir(X3) <> "" Then
          X = X3 & v_name
        Else
         If Dir(X4) <> "" Then
           X = X4 & v_name
         Else
           If Dir(X5) <> "" Then
             X = X5 & v_name
           End If
         End If
         End If
         End If
         End If
    X = Shell(X)
    Else
     MsgBox "·« ÌÊÃœ „Ê«œ „Œ «—… ·· ‰›Ì–..."
    End If
End If
view_demand.Refresh
End Sub

Private Sub datagrid1_DblClick()
On Error Resume Next
 v_mch_o = RESULT.Recordset![dig_o]
 v_mch_m = RESULT.Recordset![dig_m]
 v_mch_s = RESULT.Recordset![dig_s]
 v_mch_o1 = RESULT.Recordset![dig_o1]
 v_mch_m1 = RESULT.Recordset![dig_m1]
 v_mch_s1 = RESULT.Recordset![dig_s1]
 v_mch_tit = RESULT.Recordset![MN_ACT_TTL]
 If Not IsNull(Trim(RESULT.Recordset![dig_typ])) And Not Trim(RESULT.Recordset![dig_typ]) = "" Then
 v_mch_ext = Trim(RESULT.Recordset![dig_typ])
 Else
 v_mch_ext = "avi"
 End If
 If Not IsNull(Trim(RESULT.Recordset![dig_typ_high])) And Not Trim(RESULT.Recordset![dig_typ_high]) = "" Then
 v_mch_ext_high = Trim(RESULT.Recordset![dig_typ_high])
 Else
 v_mch_ext_high = "avi"
 End If
 V_MCH_STOCK = RESULT.Recordset![dig_DIG_NO]
 m_cnf_path = ""
 m_dig_typ1 = RESULT.Recordset![dig_typ1]

 If Not m_dig_typ1 = "04" And Not m_dig_typ1 = "02" Then
       If m_dig_typ1 = "01" Then
          m_cnf_path = m_cnf_path_pic + "scan\"
        
        ElseIf m_dig_typ1 = "03" Then
         m_cnf_path = m_cnf_path_pic + "photos\"
         ElseIf m_dig_typ1 = "05" Then
         m_cnf_path = m_cnf_path_pic + "private\"
       End If
M_DIG_TYP = RESULT.Recordset![dig_typ]
V_REC = RESULT.Recordset![dig_DIG_NO]
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
     'If Not IsEmpty(DataGrid1.Columns(3)) Then
      'v_mch_typ = Trim(DataGrid1.Columns(3))
'
 '     Else
  '    v_mch_typ = ""
   '   End If
     V_REC = RESULT.Recordset![dig_DIG_NO]
      V_MCH_STOCK = V_REC
       ' m_config_path = m_cnf_path_pic + "avi\"
       v_mch_digtyp = m_dig_typ1
       If m_dig_typ1 = "02" Then
       M_NAM1 = Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\"
         m_config_path = m_cnf_path_pic + "waves\" + M_NAM1
        Else
        m_config_path = low_stock_path(V_MCH_STOCK)
         End If
 v_mch_no = RESULT.Recordset![mn_app_no]
   m_time = Val(v_mch_s) + Val(v_mch_m) * 60 + Val(v_mch_o) * 3600
 m_time1 = Val(v_mch_s1) + Val(v_mch_m1) * 60 + Val(v_mch_o1) * 3600
 m_tm = m_time
m_tm1 = m_time1
deb_tm = m_time
fin_tm = m_time1

     M_NAM = m_config_path + Trim(V_MCH_STOCK) + "." + v_mch_ext
If Dir(M_NAM) <> "" Then
WindowsMediaPlayer1.URL = M_NAM
WindowsMediaPlayer1.Controls.Pause
'WindowsMediaPlayer1.Controls.SelectionStart = m_time
'WindowsMediaPlayer1.Controls.SelectionEnd = m_time1
WindowsMediaPlayer1.Controls.currentPosition = m_time
WindowsMediaPlayer1.Controls.Play
End If
End If
End Sub

Private Sub DataGrid1_KeyDown(KeyCode As Integer, Shift As Integer)
Dim m_word1 As String
Dim m_len As Integer
Dim m_len1 As Integer
Dim m_char As String

If KeyCode = vbKeyF6 Then
 Frame3.Visible = True
 m_mch_result.Text = RESULT.Recordset![mch_result1]
 m_mch_tit.Text = RESULT.Recordset![mch_TIT]
 If Not IsNull(RESULT.Recordset![mch_user_rmrk]) Then
   m_mch_user_rmrk.Text = RESULT.Recordset![mch_user_rmrk]
 Else
   m_mch_user_rmrk.Text = ""
 End If
   m_mch_result.SetFocus
 

   m_mch_tit.SelStart = 0
  m_mch_tit.SelLength = Len(m_mch_tit.Text) - 1
  m_mch_tit.SelColor = vbTransparent
 HighlightWords m_mch_tit, m_word.Text, vbRed
'   m_len = Len(Trim(m_word.text))
'   m_desc = Trim(m_word.text) + " "
'   m_len1 = 1
   
' While m_len >= 0

' m_char = Mid(m_desc, m_len1, 1)
'  If m_char = " " Then
 m_mch_result.SelStart = 0
 If Not m_mch_result.Text = "" And Not IsNull(m_mch_result.Text) Then
  m_mch_result.SelLength = Len(m_mch_result.Text) - 1
  m_mch_result.SelColor = vbTransparent
 HighlightWords m_mch_result, m_word.Text, vbRed
 End If
 End If
' m_word1 = ""
' Else
'  m_word1 = m_word1 + m_char
' End If
'  m_len1 = m_len1 + 1
' m_len = m_len - 1
' Wend
End Sub

Private Sub DataGrid2_DblClick()
On Error Resume Next




If Not IsNull(DataGrid2.Columns(5)) And Not IsNull(DataGrid2.Columns(3)) Then

 m_time = Val(view_demand.Recordset![dmd_in])
 
m_time1 = Val(view_demand.Recordset![dmd_in]) + Val(view_demand.Recordset![dmd_out])
 m_tm = m_time
'm_config_path = DataGrid1.Columns(3)
w_mch_stock = DataGrid2.Columns(5)
V_MCH_STOCK = w_mch_stock
v_mch_no = view_demand.Recordset![dmd_mch_no]
V_PATH = Trim(view_demand.Recordset![dmd_path])
v_mch_ext = Mid(V_PATH, Len(V_PATH) - 2, 3)
v_mch_tit = view_demand.Recordset![mch_TIT]
 
     
     m_config_path = low_stock_path(V_MCH_STOCK)
     M_NAM = m_config_path + Trim(Str(V_MCH_STOCK)) + "." + v_mch_ext
If Dir(M_NAM) <> "" Then
WindowsMediaPlayer1.URL = M_NAM

WindowsMediaPlayer1.Controls.Pause
'WindowsMediaPlayer1.Controls.SelectionStart = m_time
'WindowsMediaPlayer1.Controls.SelectionEnd = m_time1
WindowsMediaPlayer1.Controls.currentPosition = m_time
WindowsMediaPlayer1.Controls.Play
End If
 
End If

End Sub

Private Sub DataGrid2_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDelete Then
 Frame2.Visible = True
 End If
End Sub

Private Sub DBList1_DblClick()
'     view_form.Resultset.Bookmark = DBList1.SelectedItem
'If m_tabindex = 1 Then
'
'     m_mch_nprg = view_form.Resultset![sub_cod]
'      m_txt_nprg.text = view_form.Resultset![sub_name]
' ElseIf m_tabindex = 2 Then
'       m_fad_no = view_form.Resultset![sub_cod]
'       m_file_no.text = view_form.Resultset![sub_name]
'  ElseIf m_tabindex = 3 Then
'       m_res_no = view_form.Resultset![sub_cod]
'       m_txt_res.text = view_form.Resultset![sub_name]
'   ElseIf m_tabindex = 4 Then
    '   m_mch_geo = view_form.Resultset![sub_cod]
'       m_txt_geo.text = view_form.Resultset![sub_name]
'   ElseIf m_tabindex = 5 Then
'       m_mch_geo1 = view_form.Resultset![sub_cod]
    '   M_TXT_GEO1.text = view_form.Resultset![sub_name]
'   ElseIf m_tabindex = 6 Then
'       m_mch_nprg = view_form.Resultset![sub_cod]
'       m_txt_nprg.text = view_form.Resultset![sub_name]
'   ElseIf m_tabindex = 7 Then
'       m_fad_no1 = view_form.Resultset![sub_cod]
'       m_file_no1.text = view_form.Resultset![sub_name]
'    ElseIf m_tabindex = 8 Then
'       m_mch_nogeo = view_form.Resultset![sub_cod]
    '   m_file_geo.text = view_form.Resultset![sub_name]
' End If
'      DBList1.Visible = False
If m_tabindex = 1 Then
    qst1 = 1
    If first_qst = 0 Then
         crit1 = " where "
         first_qst = 1
     Else
        crit1 = crit1 & " and "
    End If
       view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_mch_nprg = view_form.Resultset![sub_cod]
      crit1 = crit1 & "MCH_NPRG =  " & "'" & m_mch_nprg & "'"
      m_disp = 2
      m_txt_nprg.Text = view_form.Resultset![sub_name]
      m_txt_nprg.Enabled = False

  ElseIf m_tabindex = 2 Then
      qst5 = 1
    If first_qst = 0 Then
         crit1 = " where "
         first_qst = 1
     Else
        crit1 = crit1 & " and "
    End If
      view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_fad_no = view_form.Resultset![sub_cod]
      crit1 = crit1 & "file_add.fad_fad_no =  " & "'" & m_fad_no & "'"
      
       CRIT = CRIT & " left join dbo.file_add ON dbo.main.mn_app_no = dbo.file_add.fad_app_no "
       m_disp = 2
       m_file_no.Text = view_form.Resultset![sub_name]
       m_file_no.Enabled = False
  ElseIf m_tabindex = 3 Then
      qst6 = 1
    If first_qst = 0 Then
         crit1 = " where "
         first_qst = 1
     Else
        crit1 = crit1 & " and "
    End If
      view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_res_no = view_form.Resultset![sub_cod]
      crit1 = crit1 & "res_sub_no =  " & "'" & m_res_no & "'"
       CRIT = CRIT & " inner join dbo.res ON dbo.main.mn_app_no = dbo.res.res_no "
       m_disp = 2
       m_txt_res.Text = view_form.Resultset![sub_name]
       m_txt_res.Enabled = False
 ElseIf m_tabindex = 4 Then
      qst7 = 1
    If first_qst = 0 Then
         crit1 = " where "
         first_qst = 1
     Else
        crit1 = crit1 & " and "
    End If
      view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_mch_geo = view_form.Resultset![sub_cod]
       crit1 = crit1 & " ( mch_geo =  " & "'" & m_mch_geo & "'"
       crit1 = crit1 & " or  geo_geo_no =  " & "'" & m_mch_geo & "'" & " ) "
       CRIT = CRIT & " left join dbo.geo ON dbo.main.mn_app_no = dbo.geo.geo_app_no "
       m_disp = 2
       m_txt_geo.Text = view_form.Resultset![sub_name]
       m_txt_geo.Enabled = False
 ElseIf m_tabindex = 5 Then
      qst10 = 1
    If first_qst = 0 Then
         crit1 = " where "
         first_qst = 1
     Else
        crit1 = crit1 & " and "
    End If
        view_form.Resultset.Bookmark = DBList1.SelectedItem
        m_mch_geo1 = Mid(view_form.Resultset![sub_cod], 3, 3)
        crit1 = crit1 & " ( substring(mch_geo,3,3) =  " & "'" & m_mch_geo1 & "'"
        crit1 = crit1 & " or substring(geo_geo_no,3,3) =  " & "'" & m_mch_geo1 & "'" & " ) "
        CRIT = CRIT & " left join dbo.geo ON dbo.main.mn_app_no = dbo.geo.geo_app_no "
        m_disp = 2
        M_TXT_GEO1.Text = view_form.Resultset![sub_name]
       M_TXT_GEO1.Enabled = False
 ElseIf m_tabindex = 7 Then
      qst15 = 1
    If first_qst = 0 Then
         crit1 = " where "
         first_qst = 1
     Else
        crit1 = crit1 & " and "
    End If
    m_t = 1
        view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_fad_no1 = view_form.Resultset![sub_cod]
   crit1 = crit1 & "file_add_1.fad_fad_no =  " & "'" & m_fad_no1 & "'" & " and file_add_1.fad_fad_t2 = " & "'" & m_t & "'"
    CRIT = CRIT & " left join dbo.file_add as file_ADD_1 ON dbo.main.mn_app_no = file_add_1.fad_app_no "
       
 ' crit1 = crit1 & "fad_fad_no =  " & "'" & m_fad_no1 & "'" & " and fad_fad_t2 = " & "'" & m_t & "'"
 '      CRIT = CRIT & " left join dbo.file_add  ON dbo.main.mn_app_no = file_add.fad_app_no "
    
       m_disp = 2
       m_file_no1.Text = view_form.Resultset![sub_name]
       m_file_no1.Enabled = False
    ElseIf m_tabindex = 8 Then
    qst16 = 1
    If first_qst = 0 Then
         crit1 = " where "
         first_qst = 1
     Else
        crit1 = crit1 & " and "
    End If
       view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_mch_nogeo = view_form.Resultset![sub_cod]
      crit1 = crit1 & "MCH_geo =  " & "'" & m_mch_nogeo & "'"
      m_disp = 2
      m_file_geo.Text = view_form.Resultset![sub_name]
      m_file_geo.Enabled = False
    
  End If
  DBList1.Visible = False
  Command1.SetFocus
  
      
End Sub

Private Sub DBList1_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF2 Then
          Dim m_code As Variant
          view_form.Resultset.Bookmark = DBList1.SelectedItem
          m_code = view_form.Resultset![sub_typ] + view_form.Resultset![sub_no]
          v_sub_no = m_code
          position.sql = " execute proc_pos " & "'" & m_code & "'"
          position.Refresh
           SendKeys "{up}"
           DBList3.Visible = True
           DBList3.SetFocus
   End If
End Sub

Private Sub DBList1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 If m_tabindex = 1 Then
    qst1 = 1
    If first_qst = 0 Then
         crit1 = " where "
         first_qst = 1
     Else
        crit1 = crit1 & " and "
    End If
       view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_mch_nprg = view_form.Resultset![sub_cod]
      crit1 = crit1 & "MCH_NPRG =  " & "'" & m_mch_nprg & "'"
      m_disp = 2
      m_txt_nprg.Text = view_form.Resultset![sub_name]
      m_txt_nprg.Enabled = False

  ElseIf m_tabindex = 2 Then
      qst5 = 1
    If first_qst = 0 Then
         crit1 = " where "
         first_qst = 1
     Else
        crit1 = crit1 & " and "
    End If
      view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_fad_no = view_form.Resultset![sub_cod]
      crit1 = crit1 & "file_add.fad_fad_no =  " & "'" & m_fad_no & "'"
      
       CRIT = CRIT & " left join dbo.file_add ON dbo.main.mn_app_no = dbo.file_add.fad_app_no "
       m_disp = 2
       m_file_no.Text = view_form.Resultset![sub_name]
       m_file_no.Enabled = False
  ElseIf m_tabindex = 3 Then
      qst6 = 1
    If first_qst = 0 Then
         crit1 = " where "
         first_qst = 1
     Else
        crit1 = crit1 & " and "
    End If
      view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_res_no = view_form.Resultset![sub_cod]
      crit1 = crit1 & "res_sub_no =  " & "'" & m_res_no & "'"
       CRIT = CRIT & " inner join dbo.res ON dbo.main.mn_app_no = dbo.res.res_no "
       m_disp = 2
       m_txt_res.Text = view_form.Resultset![sub_name]
       m_txt_res.Enabled = False
 ElseIf m_tabindex = 4 Then
      qst7 = 1
    If first_qst = 0 Then
         crit1 = " where "
         first_qst = 1
     Else
        crit1 = crit1 & " and "
    End If
      view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_mch_geo = view_form.Resultset![sub_cod]
       crit1 = crit1 & " ( mch_geo =  " & "'" & m_mch_geo & "'"
       crit1 = crit1 & " or  geo_geo_no =  " & "'" & m_mch_geo & "'" & " ) "
       CRIT = CRIT & " left join dbo.geo ON dbo.main.mn_app_no = dbo.geo.geo_app_no "
       m_disp = 2
       m_txt_geo.Text = view_form.Resultset![sub_name]
       m_txt_geo.Enabled = False
 ElseIf m_tabindex = 5 Then
      qst10 = 1
    If first_qst = 0 Then
         crit1 = " where "
         first_qst = 1
     Else
        crit1 = crit1 & " and "
    End If
        view_form.Resultset.Bookmark = DBList1.SelectedItem
        m_mch_geo1 = Mid(view_form.Resultset![sub_cod], 3, 3)
        crit1 = crit1 & " ( substring(mch_geo,3,3) =  " & "'" & m_mch_geo1 & "'"
        crit1 = crit1 & " or substring(geo_geo_no,3,3) =  " & "'" & m_mch_geo1 & "'" & " ) "
        CRIT = CRIT & " left join dbo.geo ON dbo.main.mn_app_no = dbo.geo.geo_app_no "
        m_disp = 2
        M_TXT_GEO1.Text = view_form.Resultset![sub_name]
       M_TXT_GEO1.Enabled = False
 ElseIf m_tabindex = 7 Then
      qst15 = 1
    If first_qst = 0 Then
         crit1 = " where "
         first_qst = 1
     Else
        crit1 = crit1 & " and "
    End If
    m_t = 1
        view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_fad_no1 = view_form.Resultset![sub_cod]
   crit1 = crit1 & "file_add_1.fad_fad_no =  " & "'" & m_fad_no1 & "'" & " and file_add_1.fad_fad_t2 = " & "'" & m_t & "'"
    CRIT = CRIT & " left join dbo.file_add as file_ADD_1 ON dbo.main.mn_app_no = file_add_1.fad_app_no "
       
 ' crit1 = crit1 & "fad_fad_no =  " & "'" & m_fad_no1 & "'" & " and fad_fad_t2 = " & "'" & m_t & "'"
 '      CRIT = CRIT & " left join dbo.file_add  ON dbo.main.mn_app_no = file_add.fad_app_no "
    
       m_disp = 2
       m_file_no1.Text = view_form.Resultset![sub_name]
       m_file_no1.Enabled = False
    ElseIf m_tabindex = 8 Then
    qst16 = 1
    If first_qst = 0 Then
         crit1 = " where "
         first_qst = 1
     Else
        crit1 = crit1 & " and "
    End If
       view_form.Resultset.Bookmark = DBList1.SelectedItem
       m_mch_nogeo = view_form.Resultset![sub_cod]
      crit1 = crit1 & "dig_geochrt =  " & "'" & m_mch_nogeo & "'"
      m_disp = 2
      m_file_geo.Text = view_form.Resultset![sub_name]
      m_file_geo.Enabled = False
    
  End If
  DBList1.Visible = False
  Command1.SetFocus
 ElseIf KeyAscii = 27 Then
     DBList1.Visible = False
End If
End Sub

Private Sub DBList2_DblClick()
' macnz.Resultset.Bookmark = DBList2.SelectedItem
'ÿ m_desc_no.text = macnz.Resultset![sub_desc]
' DBList2.Visible = False
' m_desc_no.SetFocus
      If m_tabindex = 6 Then
   qst8 = 1
  If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       macnz.Resultset.Bookmark = DBList2.SelectedItem
       m_an_no = macnz.Resultset![sub_code]
      crit1 = crit1 & " ( an_desc_no =  " & "'" & m_an_no & "'"
      crit1 = crit1 & " or rel_rel_no =  " & "'" & m_an_no & "'" & " ) "
     ' crit1 = crit1 & " or nar_nar_no =  " & "'" & m_an_no & "'" & " ) "
      CRIT = CRIT & " left join dbo.analis ON dbo.main.mn_app_no = dbo.analis.an_app_no "
      CRIT = CRIT & " left join dbo.relative ON dbo.analis.an_app_no  = dbo.relative.rel_app_no "
    ' CRIT = CRIT & " left join dbo.narower ON dbo.main.mn_app_no = dbo.narower.nar_app_no "
       m_disp = 2
      m_desc_no.Text = macnz.Resultset![sub_desc]
      DBList2.Visible = False
      m_desc_no.Enabled = False
    ElseIf m_tabindex = 7 Then
    qst14 = 1
  If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       macnz.Resultset.Bookmark = DBList2.SelectedItem
       m_nar_no = macnz.Resultset![sub_code]
      crit1 = crit1 & " nar_nar_no =  " & "'" & m_nar_no & "'"
     CRIT = CRIT & " left join dbo.narower ON dbo.main.mn_app_no = dbo.narower.nar_app_no "
       m_disp = 2
      m_nar_desc.Text = macnz.Resultset![sub_desc]
      DBList2.Visible = False
      m_nar_desc.Enabled = False
    End If
      Command1.SetFocus
  
End Sub

Private Sub DBList2_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  If m_tabindex = 6 Then
   qst8 = 1
  If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       macnz.Resultset.Bookmark = DBList2.SelectedItem
       m_an_no = macnz.Resultset![sub_code]
      crit1 = crit1 & " ( an_desc_no =  " & "'" & m_an_no & "'"
      crit1 = crit1 & " or rel_rel_no =  " & "'" & m_an_no & "'" & " ) "
     ' crit1 = crit1 & " or nar_nar_no =  " & "'" & m_an_no & "'" & " ) "
      CRIT = CRIT & " left join dbo.analis ON dbo.main.mn_app_no = dbo.analis.an_app_no "
      CRIT = CRIT & " left join dbo.relative ON dbo.analis.an_app_no  = dbo.relative.rel_app_no "
    ' CRIT = CRIT & " left join dbo.narower ON dbo.main.mn_app_no = dbo.narower.nar_app_no "
       m_disp = 2
      m_desc_no.Text = macnz.Resultset![sub_desc]
      DBList2.Visible = False
      m_desc_no.Enabled = False
    ElseIf m_tabindex = 7 Then
    qst14 = 1
  If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
       macnz.Resultset.Bookmark = DBList2.SelectedItem
       m_nar_no = macnz.Resultset![sub_code]
      crit1 = crit1 & " nar_nar_no =  " & "'" & m_nar_no & "'"
     CRIT = CRIT & " left join dbo.narower ON dbo.main.mn_app_no = dbo.narower.nar_app_no "
       m_disp = 2
      m_nar_desc.Text = macnz.Resultset![sub_desc]
      DBList2.Visible = False
      m_nar_desc.Enabled = False
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
 DBGrid2.SetFocus
 
End If
End Sub

Private Sub fillist_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
   Frame2.Visible = False
   DBGrid2.SetFocus
End If
End Sub


Private Sub DBList3_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
 DBList3.Visible = False
 DBList1.SetFocus
 End If
End Sub

Private Sub Form_Load()

' cn1.Connect = "uid=sa;pwd=;server=newswire;" _
   '   & "driver={SQL Server};database=MNESDB;" _
   '   & "DSN='';"
   '   cn1.CursorDriver = rdUseOdbc
   '   cn1.EstablishConnection rdDriverNoPrompt
typ_prog = 0
is_mode = 1
 m_disp = 1
 is_in = 0
 is_out = 0
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
qst12 = 0
qst13 = 0
qst11 = 0
qst14 = 0
qst15 = 0
qst16 = 0
qst17 = 0
indice = 4
m_nbword = 0
m_typ_serh = 1
Option1.value = True
USER_INTERFACE1.Caption = USER_INTERFACE1.Caption + " " + box_user_name
'For i = 0 To 8
 ' index.List(i) = DataGrid1.Columns(i).Caption
  'fld_index(i) = DataGrid1.Columns(i).DataField
'Next i
'M_art_dte.Text = Format(Date, "dd/mm/yy") "dbo.view_form ON dbo.MACHAD.MCH_nprg = dbo.view_form.sub_cod LEFT JOIN " &
first_qst = 0
crit1 = ""
 CRIT = "create proc interface_result" + box_user_no + " AS "

CRIT = CRIT & "SELECT DISTINCT " & _
                       "dbo.AUTHER.AUT_NAM AS res_res_no, dbo.MAIN.MN_APP_NO AS mn_app_no, dbo.MAIN.MN_ACT_TTL AS mn_act_ttl, " & _
                       "dbo.MAIN.MN_ADD_TTL AS mn_add_ttl, dbo.CODING.SUB_DESC AS dig_typ2, dbo.ARTICLE.ART_DTE AS art_dte,dbo.ARTICLE.ART_pg_no AS ART_pg_no, " & _
                       "dbo.PERIOD.PER_PER_NA AS art_per_no,dbo.digit.dig_dig_no  as dig_dig_no ,dbo.digit.dig_typ as dig_typ  , dbo.digit.dig_typ1 as dig_typ1 , dbo.digit.dig_choice as dig_choice  " & _
                       ", dbo.digit.dig_typ_high as dig_typ_high , dbo.digit.dig_s as dig_s , dbo.digit.dig_o as dig_o , dbo.digit.dig_m as dig_m , dbo.digit.dig_s1 as dig_s1 , dbo.digit.dig_o1 as dig_o1 , dbo.digit.dig_m1 as dig_m1 " & _
"FROM         dbo.MAIN left JOIN " & _
                      "dbo.ARTICLE ON dbo.MAIN.MN_APP_NO = dbo.ARTICLE.ART_APP_NO left JOIN " & _
                      "dbo.RES ON dbo.ARTICLE.ART_APP_NO = dbo.RES.RES_APP_NO left JOIN " & _
                      "dbo.AUTHER ON dbo.RES.RES_RES_NO = dbo.AUTHER.AUT_NO left JOIN " & _
                      "dbo.PERIOD ON dbo.ARTICLE.ART_PER_NO = dbo.PERIOD.PER_PER_NO left join " & _
                     "dbo.digit ON dbo.MAIN.MN_APP_NO = dbo.digit.dig_no left JOIN " & _
                      "dbo.CODING ON '24'+ dbo.digit.dig_typ1 = dbo.CODING.SUB_CODE "
                        
      


                      
'*****************************************************************************************
On Error Resume Next
If box_user_start = 1 And box_user_start = 3 Then
Command9.Enabled = True
Command24.Enabled = True
Command7.Enabled = True
Command5.Enabled = True
ElseIf box_user_start = 2 Then
Command9.Enabled = False
Command24.Enabled = False
Command7.Enabled = False
Command5.Enabled = False
End If
m_disp = 1

lg_stop = True
'WindowsMediaPlayer1.Controls.EnableTracker = True
'WindowsMediaPlayer1.Controls.EnablePositionControls = True
Dim m_acrh_no, m_time, m_time1 As Integer
M_dmd_dte.Text = Format(Date, "dd/mm/yyyy")
M_dmd_dte1.Text = Format(Date, "dd/mm/yyyy")

 
m_config_path = low_stock_path(V_MCH_STOCK)
 m_time = Val(v_mch_s) + Val(v_mch_m) * 60 + Val(v_mch_o) * 3600
 m_time1 = Val(v_mch_s1) + Val(v_mch_m1) * 60 + Val(v_mch_o1) * 3600
' If Val(v_mch_stock) > 12259 And Val(v_mch_stock) < 14000 Then
'If Dir(m_nam) = "" Then
'm_nam = m_config_path + Trim(V_MCH_STOCK) + ".avi"
M_NAM = m_config_path + Trim(V_MCH_STOCK) + "." + v_mch_ext
M_NAM1 = m_config_path + Trim(V_MCH_STOCK) + "." + v_mch_ext

If Dir(M_NAM1) <> "" Then
WindowsMediaPlayer1.URL = M_NAM1
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
qst_1 = 0
qst_2 = 0
qst_3 = 0
crit3 = ""
m_typ_serh = 1


'M_art_dte.Text = Format(Date, "dd/mm/yy")
first_qst1 = 0
 crit_1 = "create proc tmp_demand" + box_user_no + " AS "

crit_1 = crit_1 & "SELECT   dbo.demand.dmd_mch_no, dbo.demand.dmd_no, dbo.demand.dmd_ser, dbo.demand.dmd_user, dbo.demand.dmd_dte, dbo.main.mn_act_ttl,rtrim(cast(dbo.demand.dmd_s as char))+ '  ' + rtrim(cast(dbo.demand.dmd_M as char))+ '  ' + rtrim(cast(dbo.demand.dmd_O as char)) as time_frm , " & _
                      " dbo.demand.dmd_in,dbo.demand.dmd_s,dbo.demand.dmd_m , dbo.demand.dmd_o , dbo.demand.dmd_out, dbo.demand.dmd_path, dbo.demand.dmd_time, dbo.demand.dmd_desc, dbo.demand.dmd_chek, dbo.demand.dmd_mch_stock, dbo.config.user_name , dbo.main.mn_act_ttl" & _
" FROM         dbo.demand left JOIN " & _
                     " dbo.main ON dbo.demand.dmd_mch_no = dbo.main.mn_app_no left join " & _
                       " dbo.config ON dbo.demand.dmd_user = dbo.config.user_no "
 If qst_1 = 0 And Not M_dmd_dte.Text = "__/__/____" Then
  qst_1 = 1
   If first_qst1 = 0 Then
        crit11 = " where "
        first_qst1 = 1
      Else
       crit11 = crit11 & " and "
      End If
     
     m_dte = Format(M_dmd_dte.Text, "yyyy/MM/dd")
     crit11 = crit11 & " ( dmd_dte >= " & "convert(datetime," & "'" & Format(m_dte, "yyyy-mm-dd") & "'" & "," & "102))"
'     M_dmd_dte.Enabled = False
End If
 If qst_2 = 0 And Not M_dmd_dte1.Text = "__/__/____" Then
  qst_2 = 1
 If first_qst1 = 0 Then
        crit11 = " where "
        first_qst1 = 1
      Else
       crit11 = crit11 & " and "
      End If
     
     m_dte1 = Format(M_dmd_dte1.Text, "yyyy/MM/dd")
     crit11 = crit11 & " ( dmd_dte <= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102))"
'     M_dmd_dte1.Enabled = False
End If
If qst_3 = 0 Then
 Check2.value = 1
       qst_3 = 1
      If first_qst1 = 0 Then
        crit1 = " where "
        first_qst1 = 1
      Else
       crit11 = crit11 & " and "
      End If
      If Check2.value = 1 Then
       crit11 = crit11 & "(dmd_chek <> 2  or dmd_chek is null ) "
      End If
End If
'If Not box_pwd_cap = 1 Then
' qst7 = 1
    m_disp = 0
      crit3 = crit3 & " and dmd_user =  " & "'" & box_user_no & "'"
     ' m_dmd_user.Text = box_user_name
      m_disp = 1
      ' m_dmd_user.Enabled = False
'  End If

If first_qst1 > 0 Then
  crit2 = crit_1 & crit11 & crit3 & " order by dmd_no,dmd_ser desc"
  ''& " order by art_dte"
'    MsgBox crit2
       sql = "drop proc tmp_demand" + box_user_no
       cn.Execute sql, rdExecDirect
       cn.Execute crit2, rdExecDirect
       Screen.MousePointer = vbHourglass
       view_demand.RecordSource = "execute tmp_demand" + box_user_no
       view_demand.Refresh
       DataGrid2.Refresh
       
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
'  DataGrid2.SetFocus

End Sub

Private Sub m_OPR_DTE1_Change()

End Sub

Private Sub M_OPR_DTE1_KeyPress(KeyAscii As Integer)

End Sub

Private Sub index_Click()
indice = Index.ListIndex


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
     crit1 = crit1 & "  art_dte >= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102)"
     qst3 = 1
       M_art_dte.Enabled = False
      M_art_dte1.SetFocus
 
   Else
    M_art_dte.SetFocus
   End If
  End If
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
  qst4 = 1
  Command1.SetFocus
  
Else
  M_art_dte1.SetFocus
End If
  
End If

End Sub

 

 
Private Sub m_display_dte_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_display_dte.Text = "__/__/____" Then
  If IsDate(m_display_dte.Text) Then
     If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     
     m_dte1 = Format(m_display_dte.Text, "YYYY/MM/DD")
     crit1 = crit1 & "  dte_DTE >= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102)"
     qst12 = 1
     m_display_dte.Enabled = False
     m_display_dte1.SetFocus
     
  Else
    m_display_dte.SetFocus
 End If
End If


End Sub

Private Sub m_display_dte1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_display_dte1.Text = "__/__/____" Then
  If IsDate(m_display_dte1.Text) Then
     If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     
     m_dte1 = Format(m_display_dte1.Text, "YYYY/MM/DD")
     crit1 = crit1 & "  dte_DTE <= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102)"
     qst13 = 1
     m_display_dte1.Enabled = False
     Command1.SetFocus
  Else
    m_display_dte1.SetFocus
 End If
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

Private Sub m_dmd_desc_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Command10.SetFocus
End If
End Sub

Private Sub M_dmd_dte_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_dmd_dte1.SetFocus
 
 End If
End Sub

Private Sub M_dmd_dte1_KeyPress(KeyAscii As Integer)
m_disp = 1
qst_1 = 0
qst_2 = 0
crit3 = ""
m_typ_serh = 1


'M_art_dte.Text = Format(Date, "dd/mm/yy")
first_qst1 = 0
 crit_1 = "create proc tmp_demand" + box_user_no + " AS "

crit_1 = crit_1 & "SELECT   dbo.demand.dmd_mch_no, dbo.demand.dmd_no, dbo.demand.dmd_ser, dbo.demand.dmd_user, dbo.demand.dmd_dte, dbo.main.mn_act_ttl,rtrim(cast(dbo.demand.dmd_s as char))+ '  ' + rtrim(cast(dbo.demand.dmd_M as char))+ '  ' + rtrim(cast(dbo.demand.dmd_O as char)) as time_frm , " & _
                      " dbo.demand.dmd_in,dbo.demand.dmd_s,dbo.demand.dmd_m , dbo.demand.dmd_o , dbo.demand.dmd_out, dbo.demand.dmd_path, dbo.demand.dmd_time, dbo.demand.dmd_desc, dbo.demand.dmd_chek, dbo.demand.dmd_mch_stock, dbo.config.user_name , dbo.main.mn_act_ttl" & _
" FROM         dbo.demand left JOIN " & _
                     " dbo.main ON dbo.demand.dmd_mch_no = dbo.main.mn_app_no left join " & _
                       " dbo.config ON dbo.demand.dmd_user = dbo.config.user_no "
 If qst_1 = 0 And Not M_dmd_dte.Text = "__/__/____" Then
  qst_1 = 1
   If first_qst1 = 0 Then
        crit11 = " where "
        first_qst1 = 1
      Else
       crit11 = crit11 & " and "
      End If
     
     m_dte = Format(M_dmd_dte.Text, "yyyy/MM/dd")
     crit11 = crit11 & " ( dmd_dte >= " & "convert(datetime," & "'" & Format(m_dte, "yyyy-mm-dd") & "'" & "," & "102))"
' M_dmd_dte.Enabled = False
End If
 If qst_2 = 0 And Not M_dmd_dte1.Text = "__/__/____" Then
  qst_2 = 1
 If first_qst1 = 0 Then
        crit11 = " where "
        first_qst1 = 1
      Else
       crit11 = crit11 & " and "
      End If
     
     m_dte1 = Format(M_dmd_dte1.Text, "yyyy/MM/dd")
     crit11 = crit11 & " ( dmd_dte <= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102))"
'     M_dmd_dte1.Enabled = False
End If
'If Not box_pwd_cap = 1 Then
' qst7 = 1
    m_disp = 0
      crit3 = crit3 & " and dmd_user =  " & "'" & box_user_no & "'"
     ' m_dmd_user.Text = box_user_name
      m_disp = 1
      ' m_dmd_user.Enabled = False
'  End If

If first_qst1 > 0 Then
  crit2 = crit_1 & crit11 & crit3 & " order by dmd_no desc"
  ''& " order by art_dte"
'    MsgBox crit2
       sql = "drop proc tmp_demand" + box_user_no
       cn.Execute sql, rdExecDirect
       cn.Execute crit2, rdExecDirect
       Screen.MousePointer = vbHourglass
       view_demand.RecordSource = "execute tmp_demand" + box_user_no
       view_demand.Refresh
       DataGrid2.Refresh
       
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
'  DataGrid2.SetFocus

End Sub

Private Sub m_file_geo_Change()
If m_disp = 1 Then
  If DBList1.Visible = False Then
    DBList1.Visible = True
    DBList1.Left = 11400
    DBList1.Top = 3240
     m_tabindex = 8
  End If
  If Not Trim(m_file_geo.Text) = "" Then
       If m_typ_serh = 1 Then
         m_desc = m_file_geo.Text
         
         m_len = Len(Trim(m_file_geo.Text))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
         
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If
      ElseIf m_typ_serh = 2 Then
            m_desc = m_file_geo.Text
            m_len = Len(Trim(m_file_geo.Text))
            
            view_form.sql = "execute serh_wrdform2 " & "'" & m_desc & "'"
            view_form.Refresh
     
             If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
                MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
             End If
        End If

       
   End If
 Else
   m_disp = 1
End If

End Sub

Private Sub m_file_geo_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not m_file_geo.Text = "" Then
   DBList1.SetFocus
  SendKeys "{UP}"
End If
End Sub

Private Sub m_file_no1_Change()
If m_disp = 1 Then
  If DBList1.Visible = False Then
    DBList1.Visible = True
    DBList1.Left = 11760
    DBList1.Top = 2280
     m_tabindex = 7
  End If
  If Not Trim(m_file_no1.Text) = "" Then
       If m_typ_serh = 1 Then
         m_desc = m_file_no1.Text
         
         m_len = Len(Trim(m_file_no1.Text))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
        
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If
      ElseIf m_typ_serh = 2 Then
            m_desc = m_file_no1.Text
            m_len = Len(Trim(m_file_no1.Text))
           ' view_form.sql = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
            view_form.sql = "execute serh_wrdform2 " & "'" & m_desc & "'"
            view_form.Refresh
     
             If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
                MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
             End If
        End If

      
   End If
 Else
   m_disp = 1
End If
End Sub

Private Sub m_file_no1_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not m_file_no1.Text = "" Then
   DBList1.SetFocus
  SendKeys "{UP}"
End If
End Sub

Private Sub m_mch_geo_Change()
End Sub

Private Sub m_mch_result_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
 Frame3.Visible = False
 DataGrid1.SetFocus
 
End If
End Sub

Private Sub m_mch_typ_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_mch_typ.Text = "" Then
   qst9 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " art_sub_ty = " & "'" & Mid(m_mch_typ.BoundText, 3, 3) & "'"
      m_mch_typ.Enabled = False
          Command1.SetFocus
End If


End Sub

Private Sub m_desc_no_Change()
If m_disp = 1 Then
  If DBList2.Visible = False Then
   m_tabindex = 6
    DBList2.Visible = True
    
    
    DBList2.Left = 11480
    DBList2.Top = 1800
   
  End If
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
       ' macnz.sql = "execute serh_wrdmacnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        macnz.sql = "execute serh_wrdmacnz3 " & "'" & m_desc & "'"
        macnz.Refresh
       ' SendKeys "{UP}"
         If macnz.Resultset.EOF Or macnz.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If

  End If
  Else
   m_disp = 1
  End If
End Sub



Private Sub m_desc_no_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 40 And Not m_desc_no.Text = "" Then
   DBList2.SetFocus
   SendKeys "{UP}"
End If

End Sub

Private Sub m_file_no_Change()
If m_disp = 1 Then
  If DBList1.Visible = False Then
    DBList1.Visible = True
    DBList1.Left = 11520
    DBList1.Top = 1320
      m_tabindex = 2
  End If
  If Not Trim(m_file_no.Text) = "" Then
       If m_typ_serh = 1 Then
         m_desc = m_file_no.Text
         
         m_len = Len(Trim(m_file_no.Text))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
         
        ' DBList1.SetFocus
'         SendKeys "{UP}"
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If
      ElseIf m_typ_serh = 2 Then
            m_desc = m_file_no.Text
            m_len = Len(Trim(m_file_no.Text))
           ' view_form.sql = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
            view_form.sql = "execute serh_wrdform2 " & "'" & m_desc & "'"
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
 Else
   m_disp = 1
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


Private Sub m_nar_desc_Change()
If m_disp = 1 Then
  If DBList2.Visible = False Then
    m_tabindex = 7
    DBList2.Visible = True
    DBList2.Left = 11640
    DBList2.Top = 2640
  End If
    If m_typ_serh = 1 Then
       m_desc = m_nar_desc.Text
       m_len = Len(Trim(m_desc))
        macnz.sql = "execute serh_macnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        macnz.Refresh
        DBList2.Refresh
       ' SendKeys "{UP}"
          If macnz.Resultset.EOF Or macnz.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If

 ElseIf m_typ_serh = 2 Then
       m_desc = m_nar_desc.Text
       m_len = Len(Trim(m_desc))
       ' macnz.sql = "execute serh_wrdmacnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        macnz.sql = "execute serh_wrdmacnz3 " & "'" & m_desc & "'"
        macnz.Refresh
       ' SendKeys "{UP}"
         If macnz.Resultset.EOF Or macnz.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If

  End If
  Else
   m_disp = 1
  End If
End Sub

Private Sub m_nar_desc_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not m_nar_desc.Text = "" Then
   DBList2.SetFocus
  SendKeys "{UP}"
End If

End Sub

Private Sub m_nb_mch_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_nb_mch.Text = "" Then
  qst11 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
        crit1 = crit1 & "mch_num = " & "'" & m_nb_mch & "'"
       m_nb_mch.Enabled = False
    Command1.SetFocus
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

Private Sub m_step_KeyPress(KeyAscii As Integer)
If KeyAscii = 106 Then
 
 On Error Resume Next
Dim wmpos As Double
Dim WmpCurPos As Double
    'acc = acc + 0.04
      m_tm = m_tm - 0.04
    WindowsMediaPlayer1.Controls.currentPosition = m_tm
    'WindowsMediaPlayer1.Controls.SelectionStart = m_tm
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
ElseIf KeyCode = 32 Then
   WindowsMediaPlayer1.Controls.Pause
   
  End If

End Sub

 

Private Sub m_txt_geo_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not m_txt_geo.Text = "" Then
   DBList1.SetFocus
  SendKeys "{UP}"
End If
End Sub

Private Sub m_txt_nprg_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not m_txt_nprg.Text = "" Then
   DBList1.SetFocus
   SendKeys "{UP}"
End If
End Sub

 
Private Sub M_TXT_GEO1_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not M_TXT_GEO1.Text = "" Then
   DBList1.SetFocus
  SendKeys "{UP}"
End If
End Sub

Private Sub m_txt_res_Change()
If m_disp = 1 Then
  If DBList1.Visible = False Then
    DBList1.Visible = True
    DBList1.Left = 11400
    DBList1.Top = 3720
     m_tabindex = 3
  End If
  If Not Trim(m_txt_res.Text) = "" Then
       If m_typ_serh = 1 Then
         m_desc = m_txt_res.Text
         
         m_len = Len(Trim(m_txt_res.Text))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
         
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If
      ElseIf m_typ_serh = 2 Then
            m_desc = m_txt_res.Text
            m_len = Len(Trim(m_txt_res.Text))
            view_form.sql = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
            view_form.Refresh
             If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
                MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
             End If
        End If

   End If
Else
   m_disp = 1
End If
End Sub

Private Sub m_txt_res_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not m_txt_res.Text = "" Then
   DBList1.SetFocus
  SendKeys "{UP}"
End If
End Sub

Private Sub m_txt_text_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_txt_text.Text = "" Then
  qst17 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & "txt_text  like " & "'" & "%" & m_txt_text.Text & "%" & "'"
      CRIT = CRIT & " left join dbo.text1 ON dbo.main.mn_app_no = dbo.text1.txt_no "
      m_txt_text.Enabled = False
      Command1.SetFocus
      
End If
End Sub

Private Sub m_word_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_word.Text = "" Then
  qst2 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
   '  m_desc = LTrim(m_word.Text)
   ' Do While Len(m_desc) < 1
    
      'crit1 = crit1 & "mch_tit + mch_result" & " like " & "'" & "%" & m_word.Text & "%" & "'"
      'm_word.Enabled = False
      'Command1.SetFocus
   '   Wend
   '******************
      sw_desc = LTrim(m_word.Text)
      L = Len(sw_desc)
      i = 1
      j = 0
      k = 1
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
    If j >= m_nbword Then
       If k > 1 Then
         crit1 = crit1 & " and "
       End If
        crit1 = crit1 & "mn_result+ mn_act_ttl + mn_add_ttl" & " like " & "'" & "%" & sw_des & "%" & "'"
        
        k = k + 1
    End If
    j = j + 1
   Wend
   m_nbword = j
 ' m_word.Enabled = False
    Command1.SetFocus
 'MsgBox crit1
End If

End Sub

Private Sub MMControl1_Done(NotifyCode As Integer)

End Sub

Private Sub SSTab1_DblClick()

End Sub

Private Sub m_txt_nprg_Change()
If m_disp = 1 Then
 If DBList1.Visible = False Then
    DBList1.Visible = True
    DBList1.Top = 4200
     DBList1.Left = 11400
     m_tabindex = 1
  End If
  If Not Trim(m_txt_nprg.Text) = "" Then
       If m_typ_serh = 1 Then
         m_desc = Trim(m_txt_nprg.Text)
         m_len = Len(Trim(m_txt_nprg.Text))
         view_form.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
         If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
            MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
         End If
      ElseIf m_typ_serh = 2 Then
            m_desc = m_txt_nprg.Text
            m_len = Len(Trim(m_txt_nprg.Text))
            view_form.sql = "execute serh_wrdform2 " & "'" & m_desc & "'"
            'view_form.sql = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
            view_form.Refresh
             If view_form.Resultset.EOF Or view_form.Resultset.BOF Then
                MsgBox "«‰ »Â «··«∆Õ… ›«—€… ·« ” ÿÌ⁄ «·«œŒ«·....!"
             End If
        End If

      ' m_file_no.SetFocus
   End If

Else
 m_disp = 1
End If

End Sub

Private Sub Text2_Change()

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
Function high_stock_path(m_stock As String) As String
     high_stock_path = ""
    Dim lg As Integer
    lg = 1
  '  On Error Resume Next
     ranj.Refresh
     
     ranj.Recordset.MoveFirst
     While Not ranj.Recordset.EOF And Not ranj.Recordset.BOF And lg = 1
      If ranj.Recordset![rjp_nofrom] < Val(m_stock) And Val(m_stock) < ranj.Recordset![rjp_noto] And ranj.Recordset![rjp_typ] = 1 Then
       high_stock_path = Trim(ranj.Recordset![rjp_path])
       lg = 0
      End If
      ranj.Recordset.MoveNext
      
     Wend

   
  End Function
Private Sub WindowsMediaPlayer1_Click(ByVal nButton As Integer, ByVal nShiftState As Integer, ByVal fX As Long, ByVal fY As Long)
If is_mode = 1 Then
WindowsMediaPlayer1.Controls.Pause
m_tm = WindowsMediaPlayer1.Controls.currentPosition
is_mode = 2
Else
WindowsMediaPlayer1.Controls.Play
is_mode = 1
End If

End Sub
'******************
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
    lhProc = Shell(sCommandLine, lState)
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

Function low_stock_path(m_stock As String) As String
    low_stock_path = ""
    Dim lg As Integer
    lg = 1
  '  On Error Resume Next
     ranj.Refresh
     
     ranj.Recordset.MoveFirst
     While Not ranj.Recordset.EOF And Not ranj.Recordset.BOF And lg = 1
      If ranj.Recordset![rjp_nofrom] < m_stock And m_stock < ranj.Recordset![rjp_noto] And ranj.Recordset![rjp_typ] = 2 Then
       low_stock_path = Trim(ranj.Recordset![rjp_path])
       lg = 0
      End If
      ranj.Recordset.MoveNext
      
     Wend

   
  End Function
  
 
