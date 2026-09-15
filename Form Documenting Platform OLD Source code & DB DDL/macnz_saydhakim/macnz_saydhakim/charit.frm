VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form rec_charit 
   BackColor       =   &H8000000A&
   Caption         =   "”Ã‹‹· «·«‘—ÿ… «·ÃœÌœ…"
   ClientHeight    =   8595
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11880
   RightToLeft     =   -1  'True
   ScaleHeight     =   8595
   ScaleWidth      =   11880
   Begin VB.CommandButton Command15 
      BackColor       =   &H80000010&
      Caption         =   "«·«ŒÌ— «·‰‘—« "
      Height          =   495
      Left            =   8280
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   60
      Top             =   960
      Width           =   1095
   End
   Begin VB.CommandButton Command14 
      BackColor       =   &H80000010&
      Caption         =   "«·«ŒÌ— «·»—«„Ã"
      Height          =   495
      Left            =   9480
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   59
      Top             =   960
      Width           =   1095
   End
   Begin VB.CommandButton Command13 
      BackColor       =   &H80000010&
      Caption         =   "«·«ŒÌ— «Œ»«—"
      Height          =   495
      Left            =   10680
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   58
      Top             =   960
      Width           =   1095
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H8000000C&
      Caption         =   "„⁄«·Ã… «·«‘—ÿ…"
      Height          =   3975
      Left            =   720
      RightToLeft     =   -1  'True
      TabIndex        =   8
      Top             =   3720
      Visible         =   0   'False
      Width           =   10695
      Begin VB.TextBox m_cha_nolto 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         Height          =   405
         Left            =   8280
         RightToLeft     =   -1  'True
         TabIndex        =   61
         Top             =   3120
         Width           =   1695
      End
      Begin VB.TextBox m_cha_no 
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
         Left            =   8280
         RightToLeft     =   -1  'True
         TabIndex        =   10
         Top             =   600
         Width           =   1695
      End
      Begin MSMask.MaskEdBox m_cha_dte1 
         Height          =   375
         Left            =   8280
         TabIndex        =   56
         Top             =   1800
         Width           =   1695
         _ExtentX        =   2990
         _ExtentY        =   661
         _Version        =   393216
         MaxLength       =   8
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Format          =   "dd/mm/yy"
         Mask            =   "##/##/##"
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox m_cha_dte 
         Height          =   405
         Left            =   8280
         TabIndex        =   55
         Top             =   1200
         Width           =   1695
         _ExtentX        =   2990
         _ExtentY        =   714
         _Version        =   393216
         MaxLength       =   8
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Format          =   "dd/mm/yy"
         Mask            =   "##/##/##"
         PromptChar      =   "_"
      End
      Begin VB.TextBox m_nb_charit 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   840
         RightToLeft     =   -1  'True
         TabIndex        =   46
         Top             =   2520
         Visible         =   0   'False
         Width           =   855
      End
      Begin MSDBCtls.DBCombo M_cha_typ1 
         Bindings        =   "charit.frx":0000
         Height          =   315
         Left            =   4560
         TabIndex        =   31
         Top             =   1320
         Width           =   2055
         _ExtentX        =   3625
         _ExtentY        =   556
         _Version        =   393216
         BackColor       =   16777215
         ListField       =   "AR_DESC"
         BoundColumn     =   "AR_CODE"
         Text            =   ""
         RightToLeft     =   -1  'True
      End
      Begin MSDBCtls.DBCombo m_cha_typ 
         Bindings        =   "charit.frx":0016
         Height          =   315
         Left            =   4560
         TabIndex        =   30
         Top             =   600
         Width           =   2055
         _ExtentX        =   3625
         _ExtentY        =   556
         _Version        =   393216
         BackColor       =   16777215
         ListField       =   "AR_DESC"
         BoundColumn     =   "AR_CODE"
         Text            =   ""
         RightToLeft     =   -1  'True
      End
      Begin VB.TextBox m_cha_sub 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         Height          =   405
         Left            =   7680
         RightToLeft     =   -1  'True
         TabIndex        =   29
         Top             =   600
         Width           =   495
      End
      Begin VB.CommandButton Command8 
         BackColor       =   &H80000016&
         Caption         =   " ”ÃÌ·"
         Height          =   495
         Left            =   2400
         MaskColor       =   &H008080FF&
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   27
         Top             =   3360
         Width           =   1575
      End
      Begin VB.CommandButton Command7 
         BackColor       =   &H80000016&
         Caption         =   "«·€«¡ «·«„—"
         Height          =   495
         Left            =   840
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   26
         Top             =   3360
         Width           =   1455
      End
      Begin MSDBCtls.DBCombo m_cha_subjct 
         Bindings        =   "charit.frx":002C
         Height          =   315
         Left            =   2280
         TabIndex        =   25
         Top             =   2520
         Width           =   3015
         _ExtentX        =   5318
         _ExtentY        =   556
         _Version        =   393216
         BackColor       =   16777215
         ListField       =   "SUB_DESC"
         BoundColumn     =   "SUB_CODE"
         Text            =   ""
         RightToLeft     =   -1  'True
      End
      Begin VB.TextBox m_cha_nbdis 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         Height          =   285
         Left            =   5520
         RightToLeft     =   -1  'True
         TabIndex        =   23
         Top             =   2520
         Width           =   1095
      End
      Begin VB.TextBox m_cha_stock 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         Height          =   405
         Left            =   8280
         RightToLeft     =   -1  'True
         TabIndex        =   21
         Top             =   2400
         Width           =   1695
      End
      Begin VB.TextBox m_cha_title 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         Height          =   285
         Left            =   840
         MaxLength       =   70
         RightToLeft     =   -1  'True
         TabIndex        =   19
         Top             =   1920
         Width           =   5775
      End
      Begin MSDBCtls.DBCombo m_cha_source 
         Bindings        =   "charit.frx":0043
         Height          =   315
         Left            =   840
         TabIndex        =   16
         Top             =   1320
         Width           =   2415
         _ExtentX        =   4260
         _ExtentY        =   556
         _Version        =   393216
         BackColor       =   16777215
         ListField       =   "SUB_DESC"
         BoundColumn     =   "SUB_CODE"
         Text            =   ""
         RightToLeft     =   -1  'True
      End
      Begin VB.TextBox m_cha_time 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         Height          =   285
         Left            =   840
         RightToLeft     =   -1  'True
         TabIndex        =   13
         Top             =   600
         Width           =   1575
      End
      Begin VB.Label Label19 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFC0FF&
         BackStyle       =   0  'Transparent
         Caption         =   "—ﬁ„ LTO"
         Height          =   255
         Left            =   8880
         RightToLeft     =   -1  'True
         TabIndex        =   62
         Top             =   2880
         Width           =   1095
      End
      Begin VB.Label Label8 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFC0FF&
         BackStyle       =   0  'Transparent
         Caption         =   "„’œ— «·‘—Ìÿ"
         Height          =   255
         Left            =   2160
         RightToLeft     =   -1  'True
         TabIndex        =   57
         Top             =   1080
         Width           =   1095
      End
      Begin VB.Label Label15 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFC0FF&
         BackStyle       =   0  'Transparent
         Caption         =   "⁄œœ «·«‘—ÿ…  "
         Height          =   255
         Left            =   720
         RightToLeft     =   -1  'True
         TabIndex        =   45
         Top             =   2280
         Visible         =   0   'False
         Width           =   975
      End
      Begin VB.Label Label13 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFC0FF&
         BackStyle       =   0  'Transparent
         Caption         =   "„Ê÷Ê⁄ «·‘—Ìÿ  "
         Height          =   255
         Left            =   4080
         RightToLeft     =   -1  'True
         TabIndex        =   24
         Top             =   2280
         Width           =   1215
      End
      Begin VB.Label Label12 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFC0FF&
         BackStyle       =   0  'Transparent
         Caption         =   "⁄œœ „—«  «·⁄—÷"
         Height          =   255
         Left            =   5280
         RightToLeft     =   -1  'True
         TabIndex        =   22
         Top             =   2280
         Width           =   1335
      End
      Begin VB.Label Label11 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFC0FF&
         BackStyle       =   0  'Transparent
         Caption         =   "—ﬁ„ «·«—‘Ì›  "
         Height          =   255
         Left            =   8880
         RightToLeft     =   -1  'True
         TabIndex        =   20
         Top             =   2160
         Width           =   1095
      End
      Begin VB.Label Label10 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFC0FF&
         BackStyle       =   0  'Transparent
         Caption         =   "⁄‰Ê«‰ «·‘—Ìÿ "
         Height          =   255
         Left            =   5280
         RightToLeft     =   -1  'True
         TabIndex        =   18
         Top             =   1680
         Width           =   1335
      End
      Begin VB.Label Label9 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFC0FF&
         BackStyle       =   0  'Transparent
         Caption         =   " «—ÌŒ «·«” ⁄„«·"
         Height          =   255
         Left            =   8760
         RightToLeft     =   -1  'True
         TabIndex        =   17
         Top             =   1560
         Width           =   1215
      End
      Begin VB.Label Label7 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFC0FF&
         BackStyle       =   0  'Transparent
         Caption         =   "„÷„Ê‰ «·‘—Ìÿ"
         Height          =   255
         Left            =   5400
         RightToLeft     =   -1  'True
         TabIndex        =   15
         Top             =   1080
         Width           =   1215
      End
      Begin VB.Label Label6 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFC0FF&
         BackStyle       =   0  'Transparent
         Caption         =   " «—ÌŒ «·«œŒ«· "
         Height          =   255
         Left            =   8760
         RightToLeft     =   -1  'True
         TabIndex        =   14
         Top             =   960
         Width           =   1215
      End
      Begin VB.Label Label5 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFC0FF&
         BackStyle       =   0  'Transparent
         Caption         =   "„œ…  «·‘—Ìÿ "
         Height          =   255
         Left            =   1320
         RightToLeft     =   -1  'True
         TabIndex        =   12
         Top             =   360
         Width           =   1095
      End
      Begin VB.Label Label4 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFC0FF&
         BackStyle       =   0  'Transparent
         Caption         =   "‰Ê⁄ «·‘—Ìÿ "
         Height          =   255
         Left            =   5520
         RightToLeft     =   -1  'True
         TabIndex        =   11
         Top             =   360
         Width           =   1095
      End
      Begin VB.Label Label3 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFC0FF&
         BackStyle       =   0  'Transparent
         Caption         =   "—„“ «·‘—Ìÿ"
         Height          =   255
         Left            =   9120
         RightToLeft     =   -1  'True
         TabIndex        =   9
         Top             =   360
         Width           =   855
      End
   End
   Begin VB.Frame Frame3 
      BackColor       =   &H8000000C&
      Caption         =   "«·»ÕÀ ⁄‰ «·‘—Ìÿ"
      Height          =   2295
      Left            =   3840
      RightToLeft     =   -1  'True
      TabIndex        =   33
      Top             =   2040
      Visible         =   0   'False
      Width           =   3135
      Begin VB.TextBox m_ist_no1 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         Height          =   375
         Left            =   360
         RightToLeft     =   -1  'True
         TabIndex        =   52
         Top             =   1200
         Width           =   2055
      End
      Begin VB.CommandButton Command11 
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
         Left            =   360
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   36
         Top             =   1680
         Width           =   735
      End
      Begin VB.CommandButton Command12 
         BackColor       =   &H80000016&
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
         Left            =   1320
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   35
         Top             =   1680
         Width           =   735
      End
      Begin VB.TextBox m_ist_no 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         Height          =   375
         Left            =   360
         RightToLeft     =   -1  'True
         TabIndex        =   34
         Top             =   720
         Width           =   2055
      End
      Begin VB.Label Label18 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C0C0FF&
         BackStyle       =   0  'Transparent
         Caption         =   "«·Ï "
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
         TabIndex        =   51
         Top             =   1200
         Width           =   975
      End
      Begin VB.Label Label38 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C0C0FF&
         BackStyle       =   0  'Transparent
         Caption         =   "„‰ "
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
         Left            =   1680
         RightToLeft     =   -1  'True
         TabIndex        =   38
         Top             =   720
         Width           =   1215
      End
      Begin VB.Label Label39 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C0C0FF&
         BackStyle       =   0  'Transparent
         Caption         =   "            —„“ «·‘—Ìÿ "
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
         Left            =   480
         RightToLeft     =   -1  'True
         TabIndex        =   37
         Top             =   480
         Width           =   2655
      End
   End
   Begin VB.Frame Frame4 
      BackColor       =   &H0080C0FF&
      Height          =   2175
      Left            =   3840
      RightToLeft     =   -1  'True
      TabIndex        =   39
      Top             =   2040
      Visible         =   0   'False
      Width           =   3255
      Begin VB.TextBox m_nb2 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C0E0FF&
         Height          =   285
         Left            =   1440
         RightToLeft     =   -1  'True
         TabIndex        =   50
         Top             =   600
         Width           =   1095
      End
      Begin VB.TextBox m_nb1 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C0E0FF&
         Height          =   285
         Left            =   1440
         RightToLeft     =   -1  'True
         TabIndex        =   48
         Top             =   240
         Width           =   1095
      End
      Begin VB.CommandButton Command10 
         BackColor       =   &H008080FF&
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
         Left            =   720
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   44
         Top             =   1560
         Width           =   735
      End
      Begin VB.CommandButton Command5 
         BackColor       =   &H008080FF&
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
         Left            =   1680
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   43
         Top             =   1560
         Width           =   735
      End
      Begin VB.OptionButton Option2 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C0E0FF&
         Caption         =   "ﬂ‹·«"
         Height          =   375
         Left            =   120
         RightToLeft     =   -1  'True
         TabIndex        =   42
         Top             =   960
         Width           =   615
      End
      Begin VB.OptionButton Option1 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00C0E0FF&
         Caption         =   "‰⁄„"
         Height          =   375
         Left            =   720
         RightToLeft     =   -1  'True
         TabIndex        =   41
         Top             =   960
         Width           =   615
      End
      Begin VB.Label Label17 
         Alignment       =   1  'Right Justify
         BackColor       =   &H0080C0FF&
         Caption         =   "«·Ï —ﬁ„:"
         Height          =   255
         Left            =   2520
         RightToLeft     =   -1  'True
         TabIndex        =   49
         Top             =   600
         Width           =   615
      End
      Begin VB.Label Label16 
         Alignment       =   1  'Right Justify
         BackColor       =   &H0080C0FF&
         Caption         =   "„‰ —ﬁ„:"
         Height          =   255
         Left            =   2520
         RightToLeft     =   -1  'True
         TabIndex        =   47
         Top             =   240
         Width           =   615
      End
      Begin VB.Label Label14 
         Alignment       =   1  'Right Justify
         BackColor       =   &H0080C0FF&
         Caption         =   "Â·  —Ìœ «·€«¡ Â–« «·‘—Ìÿ :"
         Height          =   255
         Left            =   1200
         RightToLeft     =   -1  'True
         TabIndex        =   40
         Top             =   1080
         Width           =   1935
      End
   End
   Begin MSDBGrid.DBGrid DBGrid1 
      Bindings        =   "charit.frx":0059
      Height          =   7095
      Left            =   120
      OleObjectBlob   =   "charit.frx":006E
      TabIndex        =   0
      Top             =   1560
      Width           =   11655
   End
   Begin MSMask.MaskEdBox m_dte2 
      Height          =   375
      Left            =   8280
      TabIndex        =   54
      Top             =   360
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   661
      _Version        =   393216
      MaxLength       =   8
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   "dd/mm/yy"
      Mask            =   "##/##/##"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox m_dte1 
      Height          =   375
      Left            =   10320
      TabIndex        =   53
      Top             =   360
      Width           =   1455
      _ExtentX        =   2566
      _ExtentY        =   661
      _Version        =   393216
      MaxLength       =   8
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   "dd/mm/yy"
      Mask            =   "##/##/##"
      PromptChar      =   "_"
   End
   Begin VB.CommandButton Command2 
      BackColor       =   &H80000010&
      Caption         =   "«·€«¡ (delete)"
      Height          =   735
      Left            =   1320
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   32
      Top             =   120
      Width           =   1335
   End
   Begin VB.CommandButton Command9 
      Appearance      =   0  'Flat
      BackColor       =   &H80000010&
      Caption         =   " ⁄œÌ· (Space bar)"
      BeginProperty Font 
         Name            =   "Arabic Transparent"
         Size            =   9.75
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   5280
      MaskColor       =   &H00FF0000&
      RightToLeft     =   -1  'True
      Style           =   1  'Graphical
      TabIndex        =   28
      Top             =   120
      UseMaskColor    =   -1  'True
      Width           =   1335
   End
   Begin MSRDC.MSRDC charit 
      Height          =   330
      Left            =   120
      Top             =   7320
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
      QueryTimeout    =   100
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
      UserName        =   "sa"
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "charit"
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
   Begin MSRDC.MSRDC coding5 
      Height          =   330
      Left            =   -120
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
      RecordSource    =   "select * from view_coding55"
      UserName        =   "sa"
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "coding05"
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
   Begin MSRDC.MSRDC arrays1 
      Height          =   330
      Left            =   2160
      Top             =   7200
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
      RecordSource    =   "select * from view_array1"
      UserName        =   "sa"
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "arrays1"
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
   Begin MSRDC.MSRDC arrays2 
      Height          =   330
      Left            =   2160
      Top             =   7560
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
      RecordSource    =   "select * from view_array2"
      UserName        =   "sa"
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "arrays2"
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
   Begin MSRDC.MSRDC coding12 
      Height          =   330
      Left            =   4320
      Top             =   7560
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
      RecordSource    =   "select * from view_coding30"
      UserName        =   "sa"
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "coding12"
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
   Begin MSRDC.MSRDC charit1 
      Height          =   570
      Left            =   4200
      Top             =   7200
      Visible         =   0   'False
      Width           =   2175
      _ExtentX        =   3836
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
      QueryTimeout    =   100
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
      Caption         =   "charit"
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
   Begin VB.Frame Frame1 
      BackColor       =   &H80000010&
      Caption         =   "‘«‘… «·«Ê«„—"
      Height          =   855
      Left            =   0
      RightToLeft     =   -1  'True
      TabIndex        =   1
      Top             =   0
      Width           =   11895
      Begin VB.CommandButton Command1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000010&
         Caption         =   "«÷«›… (Insert)"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   178
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   735
         Left            =   6600
         MaskColor       =   &H00FF0000&
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   5
         Top             =   120
         UseMaskColor    =   -1  'True
         Width           =   1335
      End
      Begin VB.CommandButton Command3 
         BackColor       =   &H80000010&
         Caption         =   "«·»ÕÀ ⁄‰ —„“ (F10)"
         Height          =   735
         Left            =   2640
         MaskColor       =   &H008080FF&
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   4
         Top             =   120
         Width           =   1335
      End
      Begin VB.CommandButton Command4 
         BackColor       =   &H80000010&
         Caption         =   "»ÕÀ ⁄‰ —ﬁ„ «·«—‘Ì› (F9)"
         Height          =   735
         Left            =   3960
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   3
         Top             =   120
         Width           =   1335
      End
      Begin VB.CommandButton Command6 
         BackColor       =   &H80000010&
         Caption         =   "Œ‹‹—ÊÃ"
         Height          =   735
         Left            =   0
         RightToLeft     =   -1  'True
         Style           =   1  'Graphical
         TabIndex        =   2
         Top             =   120
         Width           =   1335
      End
   End
   Begin MSRDC.MSRDC tmp_chrt 
      Height          =   330
      Left            =   0
      Top             =   0
      Visible         =   0   'False
      Width           =   5175
      _ExtentX        =   9128
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
   Begin MSRDC.MSRDC opr_chrt 
      Height          =   330
      Left            =   0
      Top             =   0
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
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00F3C7B6&
      BackStyle       =   0  'Transparent
      Caption         =   "„‰  «—ÌŒ «·«œŒ«· :"
      Height          =   495
      Left            =   10200
      RightToLeft     =   -1  'True
      TabIndex        =   6
      Top             =   480
      Width           =   1575
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00F3C7B6&
      BackStyle       =   0  'Transparent
      Caption         =   "«·Ï  «—ÌŒ «·«œŒ«·:"
      Height          =   375
      Left            =   8280
      RightToLeft     =   -1  'True
      TabIndex        =   7
      Top             =   480
      Width           =   1455
   End
End
Attribute VB_Name = "rec_charit"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim m_cha_mod As Integer
Dim m_serh_mod As Integer


Private Sub Command1_Click()
'If m_charit_pwd = "ag56" Or m_charit_pwd = "AG56" Or m_charit_pwd = "‘·56" Then
 m_nb_charit.Text = 1
m_cha_mod = 1
Frame2.Visible = True
m_cha_no.SetFocus
m_cha_sub = "00"
m_cha_typ.BoundText = ""
m_cha_time.Text = ""
m_cha_dte.Text = Format(Date, "dd/mm/yy")
M_cha_typ1.BoundText = ""
m_cha_source.BoundText = ""
m_cha_stock.Text = ""
m_cha_dte1.Text = "__/__/__"
m_cha_title.Text = ""
m_cha_nbdis.Text = ""
m_cha_subjct.BoundText = ""
Label15.Visible = True
m_nb_charit.Visible = True
charit1.sql = "execute op_charit"
charit1.Refresh
If Not charit1.Resultset.EOF() Then
  charit1.Resultset.MoveLast
  m_var_no = charit1.Resultset![cha_no]
  v_prs_no = "000000"
  m_no = Val(m_var_no)
  m_no = m_no + 1
  v_prs_no = Mid(v_prs_no, 1, 6 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
  m_var_no = v_prs_no
  m_cha_no.Text = m_var_no
 Else
  m_cha_no.Text = "000000"
 End If
'End If
End Sub

Private Sub Command10_Click()
 Frame4.Visible = False
 DBGrid1.SetFocus
 
End Sub

Private Sub Command11_Click()
Frame3.Visible = False
DBGrid1.SetFocus

End Sub

Private Sub Command12_Click()
If m_serh_mod = 1 Then
     charit.sql = "execute serh_charit " & "'" & m_ist_no.Text & "'" & _
                                     "," & "'" & m_ist_no1.Text & "'"
  
  ElseIf m_serh_mod = 2 Then
    charit.sql = "execute serh1_charit " & "'" & m_ist_no.Text & "'" & "," & "'" & m_ist_no1.Text & "'"
  End If
   Frame3.Visible = False
   charit.Refresh
   'DBGrid1.Refresh
   DBGrid1.SetFocus
   
End Sub

Private Sub Command12_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
If m_serh_mod = 1 Then
     charit.sql = "execute serh_charit " & "'" & m_ist_no.Text & "'" & "," & "'" & m_sub.Text & "'" _
                                    & "," & "'" & m_ist_no1.Text & "'" & "," & "'" & m_sub1.Text & "'"
     m_sub.Visible = False
  ElseIf m_serh_mod = 2 Then
   charit.sql = "execute serh1_charit " & "'" & m_ist_no.Text & "'" & "," & "'" & m_ist_no1.Text & "'"
  End If
   Frame3.Visible = False
   charit.Refresh
   DBGrid1.Refresh
   DBGrid1.SetFocus
   
End If

End Sub


Private Sub Command13_Click()
m_no = 0
m_no1 = 30000
 tmp_chrt.sql = "execute max_nostock " & "'" & m_no & "'" & "," & "'" & m_no1 & "'"
    tmp_chrt.Refresh
    If Frame2.Visible = True Then
     m_cha_stock.Text = tmp_chrt.Resultset![max1] + 1
    Else
     MsgBox tmp_chrt.Resultset![max1]
     End If
End Sub

Private Sub Command14_Click()
m_no = 30000
m_no1 = 100000
 tmp_chrt.sql = "execute max_nostock " & "'" & m_no & "'" & "," & "'" & m_no1 & "'"
    tmp_chrt.Refresh
    If Frame2.Visible = True Then
     m_cha_stock.Text = tmp_chrt.Resultset![max1] + 1
    Else
     MsgBox tmp_chrt.Resultset![max1]
     End If
End Sub

Private Sub Command15_Click()
m_no = 100000
m_no1 = 300000
 tmp_chrt.sql = "execute max_nostock " & "'" & m_no & "'" & "," & "'" & m_no1 & "'"
    tmp_chrt.Refresh
    If Frame2.Visible = True Then
     m_cha_stock.Text = tmp_chrt.Resultset![max1] + 1
    Else
     MsgBox tmp_chrt.Resultset![max1]
     End If

End Sub

Private Sub Command2_Click()
'If m_charit_pwd = "ag56" Or m_charit_pwd = "AG56" Or m_charit_pwd = "‘·56" Then
  Frame4.Visible = True
  Option2.SetFocus
  m_nb1.Text = DBGrid1.Columns(0)
  m_nb2.Text = DBGrid1.Columns(0)
  m_nb1.SetFocus
 ' End If
End Sub

Private Sub Command3_Click()
Frame3.Visible = True
m_ist_no.SetFocus
m_serh_mod = 1
Label39.Caption = "            —„“ «·‘—Ìÿ "
m_ist_no.Text = ""
m_ist_no1.Text = ""
End Sub

Private Sub Command4_Click()
Frame3.Visible = True
m_ist_no.SetFocus
m_serh_mod = 2
Label39.Caption = "            —ﬁ„ «·«—‘Ì›"
m_ist_no.Text = ""
m_ist_no1.Text = ""

End Sub

Private Sub Command5_Click()
Frame4.Visible = False

If Option1.value = True Then
   Dim sql As String
  ' Dim cn As New rdoConnection
   Dim nb_charit As Integer
   '              cn.Connect = "uid=;pwd=;server=SEQUEL;" _
   '        & "driver={SQL Server};database=archive_manar;" _
   '        & "DSN='';"
   '         cn.CursorDriver = rdUseOdbc
   '        cn.EstablishConnection rdDriverNoPrompt

    v_no = m_nb1.Text
    v_sub = DBGrid1.Columns(1)
    nb_charit = Val(m_nb2.Text) - Val(m_nb1.Text) + 1
  
   For i = 1 To nb_charit
    sql = "execute  del_charit " & "'" & v_no & "'" & "," & "'" & v_sub & "'"
                                    
           cn.Execute sql, rdExecDirect
           charit.Refresh
       v_prs_no = "000000"
       m_no = Val(v_no)
       m_no = m_no + 1
       v_prs_no = Mid(v_prs_no, 1, 6 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
       v_no = v_prs_no
    Next i
End If
     DBGrid1.Refresh
     DBGrid1.SetFocus

End Sub

Private Sub Command6_Click()
Unload rec_charit

End Sub

Private Sub Command7_Click()
Frame2.Visible = False
DBGrid1.SetFocus


End Sub

Private Sub Command8_Click()
Frame2.Visible = False

 Dim sql As String
' Dim cn As New rdoConnection
 Dim j As Integer
 Dim m_var_no As String
 m_var_no = m_cha_no.Text
 m_cha_num = 0
    '     cn.Connect = "uid=;pwd=;server=SEQUEL;" _
    '       & "driver={SQL Server};database=archive_manar;" _
    '       & "DSN='';"
    '        cn.CursorDriver = rdUseOdbc
    '       cn.EstablishConnection rdDriverNoPrompt
           
    Dim m_dte1, m_dte2 As Variant
 If m_cha_dte.Text = "__/__/__" Then
      m_dte1 = ""
    Else
      m_dte1 = m_cha_dte.Text
 End If
 If m_cha_dte1 = "__/__/__" Then
    m_dte2 = ""
  Else
    m_dte2 = m_cha_dte1.Text
 End If
If m_cha_mod = 1 Then
  v_cha_title = m_cha_title.Text
    For j = 1 To m_nb_charit.Text
      If Not v_cha_title = "" And m_nb_charit.Text <> 1 Then
        m_cha_title.Text = v_cha_title + " - " + Str(j)
    End If
       sql = "execute  insr_charit1 " & "'" & m_var_no & "'" & "," & "'" & m_cha_sub.Text & "'" _
                                    & "," & "'" & m_cha_typ.BoundText & "'" & "," & "'" & m_cha_time.Text & "'" _
                                    & "," & "'" & Format(m_dte1, "yyyy/mm/dd") & "'" & "," & "'" & m_cha_num & "'" _
                                    & "," & "'" & M_cha_typ1.BoundText & "'" & "," & "'" & Mid(m_cha_source.BoundText, 3, 3) & "'" _
                                    & "," & "'" & Format(m_dte2, "yyyy/mm/dd") & "'" & "," & "'" & m_cha_title.Text & "'" _
                                    & "," & "'" & m_cha_stock.Text & "'" & "," & "'" & m_cha_nbdis.Text & "'" _
                                     & "," & "'" & Mid(m_cha_subjct.BoundText, 3, 3) & "'" & "," & "'" & m_cha_nolto.Text & "'"
                                     
                                     cn.Execute sql, rdExecDirect
                                      charit.Refresh
   
    
   If Not m_cha_stock.Text = "" Then
           m_opr_dte = Format(Date, "dd/mm/yy")
        m_opr_time = time
         If m_opr_dte = "__/__/__" Then
           m_dte = ""
         Else
             m_dte = m_opr_dte
          End If
        m_ddte = ""
        m_opr_cotfrm = "107"
        m_opr_prsfrm = box_user_no
        m_opr_cotto = "112"
        m_opr_prsto = box_user_no
        m_opr_trans = 0
        m_opr_rmk = ""
        m_opr_extcote = ""

     If j = 1 Then
       opr_chrt.sql = "execute op_chrt"
      opr_chrt.Refresh

     v_prs_no = "0000000"
    m_no = 0
    opr_chrt.Resultset.MoveLast
    m_no1 = opr_chrt.Resultset![opr_no]
    m_no = Val(m_no1)
    m_no = m_no + 1
    
    v_prs_no = Mid(v_prs_no, 1, 7 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
    m_opr_no = v_prs_no
     m_trans = 0
     SQL1 = "execute insr_opr_chrt " & "'" & m_opr_no & "'" & "," & "'" & j & "'" & "," _
                                             & "'" & m_trans & "'"
                   cn.Execute SQL1, rdExecDirect
      
      sql = "execute  upd_opr_chrt1 " & "'" & m_opr_no & "'" & "," & "'" & Format(m_dte, "yyyy/mm/dd") & "'" _
                                    & "," & "'" & m_opr_time & "'" _
                                     & "," & "'" & m_opr_cotfrm & "'" & "," & "'" & m_opr_prsfrm & "'" _
                                     & "," & "'" & m_opr_cotto & "'" & "," & "'" & m_opr_prsto & "'" _
                                     & "," & "'" & m_opr_extcote & "'"
                                     
           cn.Execute sql, rdExecDirect
        sql = "execute  upd1_opr_chrt " & "'" & m_opr_no & "'" & "," & "'" & j & "'" & _
                                            "," & "'" & m_var_no & "'" & "," & "'" & m_cha_sub.Text & "'" & "," & "'" & Format(m_ddte, "yyyy/mm/dd") & "'" _
                                            & "," & "'" & m_opr_rmk & "'" & "," & "'" & m_cha_title.Text & "'"
                                      
           cn.Execute sql, rdExecDirect

   ElseIf j > 1 Then
           sql = "execute  INSR2_opr_chrt " & "'" & m_opr_no & "'" & "," & "'" & j & "'" & "," & "'" & Format(m_dte, "yyyy/mm/dd") & "'" _
                                    & "," & "'" & m_opr_time & "'" _
                                     & "," & "'" & m_opr_cotfrm & "'" & "," & "'" & m_opr_prsfrm & "'" _
                                      & "," & "'" & m_opr_cotto & "'" & "," & "'" & m_opr_prsto & "'" _
                                      & "," & "'" & m_var_no & "'" & "," & "'" & m_cha_sub.Text & "'" & "," & "'" & Format(m_ddte, "yyyy/mm/dd") & "'" _
                                       & "," & "'" & m_opr_rmk & "'" & "," & "'" & m_cha_title.Text & "'" & "," & "'" & m_opr_trans & "'" _
                                       & "," & "'" & m_opr_extcote & "'"

           cn.Execute sql, rdExecDirect
   End If
       m_cha_stock = m_cha_stock + 1
    
    End If
    
     sql = "execute upd_cha_status" & "'" & m_var_no & "'" & "," _
            & "'" & m_opr_cotfrm & "'" & "," & "'" & m_opr_cotto & "'" _
            & "," & "'" & m_opr_prsfrm & "'" & "," & "'" & m_opr_prsto & "'" _
             & "," & "'" & m_opr_no & "'"
           cn.Execute sql, rdExecDirec
        v_prs_no = "000000"
    m_no = Val(m_var_no)
    m_no = m_no + 1
    v_prs_no = Mid(v_prs_no, 1, 6 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
    m_var_no = v_prs_no

    Next j
  ElseIf m_cha_mod = 2 Then
          sql = "execute  upd_charit5 " & "'" & m_var_no & "'" & "," & "'" & m_cha_sub.Text & "'" _
                                    & "," & "'" & m_cha_typ.BoundText & "'" & "," & "'" & m_cha_time.Text & "'" _
                                    & "," & "'" & Format(m_dte1, "yyyy/mm/dd") & "'" & "," & "'" & m_cha_num & "'" _
                                     & "," & "'" & M_cha_typ1.BoundText & "'" & "," & "'" & Mid(m_cha_source.BoundText, 3, 3) & "'" _
                                    & "," & "'" & Format(m_dte2, "yyyy/mm/dd") & "'" & "," & "'" & m_cha_title.Text & "'" _
                                    & "," & "'" & m_cha_stock.Text & "'" & "," & "'" & m_cha_nbdis.Text & "'" _
                                     & "," & "'" & Mid(m_cha_subjct.BoundText, 3, 3) & "'" & "," & "'" & m_cha_nolto.Text & "'"
                                     
                                     cn.Execute sql, rdExecDirect
                                        charit.Refresh
  End If
                                    
   DBGrid1.Refresh
   DBGrid1.SetFocus
   
   
End Sub

Private Sub Command9_Click()
'If m_charit_pwd = "ag56" Or m_charit_pwd = "AG56" Or m_charit_pwd = "‘·56" Then
Frame2.Visible = True
m_cha_no.SetFocus
m_cha_mod = 2
m_cha_no.Text = DBGrid1.Columns(0)
m_cha_sub.Text = DBGrid1.Columns(1)
m_cha_typ.BoundText = DBGrid1.Columns(13)
m_cha_time.Text = DBGrid1.Columns(3)
If Not IsNull(DBGrid1.Columns(4)) And Not DBGrid1.Columns(4) = "" Then
'And Not DBGrid1.Columns(8) = "" And Not IsEmpty(DBGrid1.Columns(4)) Then
   m_cha_dte.Text = Format(DBGrid1.Columns(4), "dd/mm/yy")
 End If
m_cha_num = DBGrid1.Columns(5)
M_cha_typ1.BoundText = DBGrid1.Columns(17)
m_cha_source.BoundText = "05" + DBGrid1.Columns(19)
If Not IsNull(DBGrid1.Columns(8)) And Not DBGrid1.Columns(8) = "" Then
'And Not IsEmpty(DBGrid1.Columns(8)) Then
 m_cha_dte1.Text = Format(DBGrid1.Columns(8), "dd/mm/yy")
  
End If
m_cha_title.Text = DBGrid1.Columns(9)
m_cha_stock.Text = DBGrid1.Columns(10)
m_cha_nbdis.Text = DBGrid1.Columns(11)
m_cha_subjct.BoundText = "12" + DBGrid1.Columns(18)
m_cha_nolto.Text = DBGrid1.Columns(14)
m_cha_typ.SetFocus
'End If
End Sub

Private Sub DBGrid1_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF10 Then
     Command3.SetFocus
   SendKeys "{enter}"
ElseIf KeyCode = vbKeyF9 Then
 Command4.SetFocus
   SendKeys "{enter}"
End If
End Sub

Private Sub DBGrid1_KeyPress(KeyAscii As Integer)
MsgBox KeyAscii
If KeyAscii = 32 Then
  Command9.SetFocus
   SendKeys "{enter}"
End If
End Sub

Private Sub DBGrid1_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyInsert Then
  Command1.SetFocus
  SendKeys "{enter}"
ElseIf KeyCode = vbKeyDelete Then
   Command2.SetFocus
  SendKeys "{enter}"
End If
End Sub


 
Private Sub Form_Load()
m_dte1.Text = Format(Date, "dd/mm/yy")
m_dte2.Text = Format(Date, "dd/mm/yy")
End Sub

Private Sub m_cha_nolto_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 Then
  Command8.SetFocus
 End If
End Sub

Private Sub m_cha_title_Change()
 m_len = Len(Trim(m_cha_title.Text))
 If m_cha_title.MaxLength <= m_len + 1 Then
    m_cha_stock.SetFocus
 End If
End Sub

Private Sub m_dte1_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF10 Then
  m_dte2.SetFocus
  
End If
End Sub

Private Sub m_dte1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 If IsDate(m_dte1.Text) Then
  m_dte2.SetFocus
 Else
  m_dte1.SetFocus
 End If
End If
End Sub

Private Sub m_dte2_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF10 Then
  charit.sql = "execute proc_charit" & "'" & m_dte1.Text & "'" & "," _
                                             & "'" & m_dte2.Text & "'"
   charit.Refresh
   DBGrid1.Refresh
  DBGrid1.SetFocus
End If
End Sub

Private Sub m_dte2_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
If IsDate(m_dte2.Text) Then
     charit.sql = "execute proc_charit" & "'" & Format(m_dte1.Text, "yyyy/mm/dd") & "'" & "," _
                                             & "'" & Format(m_dte2.Text, "yyyy/mm/dd") & "'"
   charit.Refresh
   DBGrid1.Refresh
  DBGrid1.SetFocus
 Else
  m_dte2.SetFocus
 End If
End If

End Sub

Private Sub M_CHA_DTE_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
M_cha_typ1.SetFocus
  SendKeys "{f4}"
End If

End Sub

Private Sub m_cha_dte1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_cha_title.SetFocus
 
End If
End Sub

Private Sub m_cha_nbdis_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_cha_subjct.SetFocus
  SendKeys "{f4}"
End If
End Sub

Private Sub m_cha_no_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then
  m_cha_sub.SetFocus
  ElseIf KeyAscii = 27 Then
   Command7.SetFocus
   SendKeys "{enter}"
End If
End Sub

Private Sub m_cha_source_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_cha_dte1.SetFocus
   
End If
End Sub

Private Sub m_cha_stock_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
      tmp_chrt.sql = "execute serh_cha_stock " & "'" & m_cha_stock.Text & "'"
        tmp_chrt.Refresh
        If Not tmp_chrt.Resultset.EOF Or Not tmp_chrt.Resultset.BOF Then
           MsgBox "Â–« «·—ﬁ„ ··«—‘Ì› „ÊÃÊœ ”«»ﬁ«..."
           m_cha_stock.SetFocus
       Else
        m_cha_nbdis.SetFocus
       End If
   
End If
End Sub

Private Sub m_cha_sub_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_cha_typ.SetFocus
  SendKeys "{f4}"
End If

End Sub

Private Sub m_cha_subjct_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 If m_cha_mod = 1 Then
   m_nb_charit.SetFocus
 Else
   Command8.SetFocus
 End If
End If
End Sub

Private Sub m_cha_time_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 Then
  m_cha_dte.SetFocus
End If

End Sub

Private Sub m_cha_title_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_cha_stock.SetFocus
 
End If
End Sub

Private Sub m_cha_typ_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_cha_time.SetFocus
End If
End Sub

Private Sub m_cha_typ1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
m_cha_source.SetFocus
  SendKeys "{f4}"
End If

End Sub


Private Sub m_ist_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  If m_serh_mod = 1 Then
    v_prs_no = "000000"
    m_no = m_ist_no.Text
    v_prs_no = Mid(v_prs_no, 1, 6 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
    m_ist_no.Text = v_prs_no
    m_ist_no1.Text = m_ist_no.Text
   End If
    m_ist_no1.SetFocus
  ElseIf KeyAscii = 27 Then
   Command11.SetFocus
 
 End If
 
End Sub

Private Sub m_ist_no1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  
    Command12.SetFocus
  
 ElseIf KeyAscii = 27 Then
 Command11.SetFocus
 
 End If
 
End Sub

Private Sub m_nb_charit_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 Then
  m_cha_nolto.SetFocus
 End If
End Sub

Private Sub m_nb1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_nb2.SetFocus
End If
End Sub

Private Sub m_nb2_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 Option2.SetFocus
 
 End If
End Sub


Private Sub MaskEdBox1_Change()

End Sub

Private Sub MaskEdBox1_KeyPress(KeyAscii As Integer)

End Sub

Private Sub Option1_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 Then
       Command5.SetFocus
 End If
End Sub

Private Sub Option2_Click()
If KeyAscii = 13 Then
   Command6.SetFocus
   SendKeys "{enter}"
 End If

End Sub
