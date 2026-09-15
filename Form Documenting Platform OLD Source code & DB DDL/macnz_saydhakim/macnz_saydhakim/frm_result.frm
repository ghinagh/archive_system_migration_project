VERSION 5.00
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{CDE57A40-8B86-11D0-B3C6-00A0C90AEA82}#1.0#0"; "MSDATGRD.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form frm_result 
   ClientHeight    =   9960
   ClientLeft      =   60
   ClientTop       =   540
   ClientWidth     =   20220
   LinkTopic       =   "Form1"
   ScaleHeight     =   9960
   ScaleWidth      =   20220
   Begin VB.CommandButton Command12 
      Caption         =   "ÿ»«⁄… „ €Ì—…"
      Height          =   615
      Left            =   120
      TabIndex        =   30
      Top             =   240
      Width           =   735
   End
   Begin VB.CommandButton Command7 
      Caption         =   "⁄—÷ «·ÕﬁÊ· "
      Height          =   795
      Left            =   120
      TabIndex        =   29
      Top             =   960
      Width           =   735
   End
   Begin VB.Frame Frame1 
      Caption         =   "Frame1"
      Height          =   5415
      Left            =   4200
      RightToLeft     =   -1  'True
      TabIndex        =   25
      Top             =   2160
      Visible         =   0   'False
      Width           =   10335
      Begin VB.CommandButton Command5 
         Caption         =   "«·»ÕÀ ⁄‰ ﬂ·„…"
         Height          =   495
         Left            =   8400
         RightToLeft     =   -1  'True
         TabIndex        =   27
         Top             =   4800
         Width           =   1575
      End
      Begin VB.TextBox m_word 
         Alignment       =   1  'Right Justify
         Height          =   375
         Left            =   6240
         RightToLeft     =   -1  'True
         TabIndex        =   26
         Top             =   4800
         Width           =   2055
      End
      Begin RichTextLib.RichTextBox m_rchtext 
         Height          =   4335
         Left            =   -2760
         TabIndex        =   28
         Top             =   0
         Width           =   10095
         _ExtentX        =   17806
         _ExtentY        =   7646
         _Version        =   393217
         ScrollBars      =   2
         MousePointer    =   3
         DisableNoScroll =   -1  'True
         Appearance      =   0
         TextRTF         =   $"frm_result.frx":0000
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
   End
   Begin VB.CommandButton Command4 
      Caption         =   "ÿ»«⁄… «·‰’Ê’"
      Height          =   735
      Left            =   120
      TabIndex        =   24
      Top             =   6240
      Width           =   735
   End
   Begin VB.CommandButton Command3 
      Caption         =   "«·„Ã„Ê⁄"
      Height          =   735
      Left            =   120
      TabIndex        =   23
      Top             =   1800
      Width           =   735
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H8000000C&
      Height          =   4695
      Left            =   2760
      RightToLeft     =   -1  'True
      TabIndex        =   6
      Top             =   5160
      Visible         =   0   'False
      Width           =   6255
      Begin VB.TextBox m_res_subject 
         Alignment       =   1  'Right Justify
         Height          =   285
         Left            =   1800
         TabIndex        =   21
         Top             =   4080
         Width           =   3135
      End
      Begin VB.DriveListBox drvlist 
         Height          =   315
         Left            =   3120
         TabIndex        =   14
         Top             =   480
         Width           =   3015
      End
      Begin VB.DirListBox Dirlist 
         Height          =   1440
         Left            =   3120
         TabIndex        =   13
         Top             =   960
         Width           =   3015
      End
      Begin VB.FileListBox fillist 
         Height          =   1845
         Left            =   120
         TabIndex        =   12
         Top             =   480
         Width           =   2895
      End
      Begin VB.CommandButton Command9 
         Caption         =   "‰”Œ «·«Œ Ì«—"
         Height          =   495
         Left            =   5040
         TabIndex        =   11
         Top             =   2520
         Width           =   1095
      End
      Begin VB.CommandButton Command10 
         Caption         =   "«·€«¡ «·«„—"
         Height          =   495
         Left            =   2760
         TabIndex        =   10
         Top             =   2520
         Width           =   975
      End
      Begin VB.CommandButton Command11 
         Caption         =   "‰”Œ «·ÃœÊ·"
         Height          =   495
         Left            =   3840
         TabIndex        =   9
         Top             =   2520
         Width           =   1095
      End
      Begin VB.TextBox m_res_prs 
         Alignment       =   1  'Right Justify
         Height          =   285
         Left            =   1800
         TabIndex        =   8
         Top             =   3720
         Width           =   3135
      End
      Begin VB.CheckBox isrec 
         BackColor       =   &H8000000C&
         Caption         =   "„⁄  ”ÃÌ· «·ÿ·»"
         Height          =   375
         Left            =   600
         TabIndex        =   7
         Top             =   2640
         Width           =   1455
      End
      Begin MSDataListLib.DataCombo m_res_permit 
         Bindings        =   "frm_result.frx":009D
         Height          =   315
         Left            =   3120
         TabIndex        =   15
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
         Bindings        =   "frm_result.frx":00B6
         Height          =   315
         Left            =   120
         TabIndex        =   16
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
         BackColor       =   &H8000000C&
         Caption         =   "«·„Ê÷Ê⁄"
         Height          =   255
         Left            =   4920
         RightToLeft     =   -1  'True
         TabIndex        =   22
         Top             =   4080
         Width           =   1215
      End
      Begin VB.Label Label19 
         Alignment       =   2  'Center
         BackColor       =   &H8000000C&
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
         TabIndex        =   20
         Top             =   0
         Width           =   3495
      End
      Begin VB.Label Label17 
         Alignment       =   1  'Right Justify
         BackColor       =   &H8000000C&
         Caption         =   "«·ÃÂ… «·„Ê«›ﬁ…"
         Height          =   255
         Left            =   4920
         RightToLeft     =   -1  'True
         TabIndex        =   19
         Top             =   3240
         Width           =   1215
      End
      Begin VB.Label Label18 
         Alignment       =   1  'Right Justify
         BackColor       =   &H8000000C&
         Caption         =   "«·ÃÂ… «·„” ›Ìœ…"
         Height          =   495
         Left            =   1800
         RightToLeft     =   -1  'True
         TabIndex        =   18
         Top             =   3240
         Width           =   855
      End
      Begin VB.Label Label20 
         Alignment       =   1  'Right Justify
         BackColor       =   &H8000000C&
         Caption         =   "«·„” ›Ìœ"
         Height          =   255
         Left            =   4920
         RightToLeft     =   -1  'True
         TabIndex        =   17
         Top             =   3720
         Width           =   1215
      End
   End
   Begin MSDBGrid.DBGrid DBGrid1 
      Bindings        =   "frm_result.frx":00CF
      Height          =   3375
      Left            =   3960
      OleObjectBlob   =   "frm_result.frx":00E5
      TabIndex        =   5
      Top             =   1440
      Visible         =   0   'False
      Width           =   4815
   End
   Begin VB.CommandButton Command2 
      Caption         =   "ÿ»«⁄… «·„·›«  «·«÷«›Ì…"
      Height          =   735
      Left            =   120
      TabIndex        =   4
      Top             =   5280
      Width           =   735
   End
   Begin MSDataGridLib.DataGrid DataGrid1 
      Bindings        =   "frm_result.frx":0AD0
      Height          =   9495
      Left            =   1200
      TabIndex        =   0
      ToolTipText     =   "DBLCLICK ·› Õ «·’Ê—… , F2  ·› Õ «·«” „«—… , F9 ·«Œ Ì«— «·„ﬁ«·… , F3 ·‰”Œ «·„ﬁ«·«  ,f5 › Õ ‰’ «·ÊÀÌﬁ…"
      Top             =   120
      Width           =   18975
      _ExtentX        =   33470
      _ExtentY        =   16748
      _Version        =   393216
      AllowUpdate     =   0   'False
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
      ColumnCount     =   27
      BeginProperty Column00 
         DataField       =   "PER_PER_NO"
         Caption         =   "PER_PER_NO"
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
         DataField       =   "PER_PER_NA"
         Caption         =   "PER_PER_NA"
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
         DataField       =   "PER_PUB_LO"
         Caption         =   "PER_PUB_LO"
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
         DataField       =   "PER_ST_DTE"
         Caption         =   "PER_ST_DTE"
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
         DataField       =   "PER_LANG"
         Caption         =   "PER_LANG"
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
         DataField       =   "PER_RDMD"
         Caption         =   "PER_RDMD"
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
         DataField       =   "PER_TYP"
         Caption         =   "PER_TYP"
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
      BeginProperty Column07 
         DataField       =   "PER_GEO"
         Caption         =   "PER_GEO"
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
         DataField       =   "PER_TYP1"
         Caption         =   "PER_TYP1"
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
         DataField       =   "PER_FREQ"
         Caption         =   "PER_FREQ"
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
         DataField       =   "PER_ADRS"
         Caption         =   "PER_ADRS"
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
         DataField       =   "PER_TEL"
         Caption         =   "PER_TEL"
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
         DataField       =   "PER_AMNT"
         Caption         =   "PER_AMNT"
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
         DataField       =   "PER_PRIX"
         Caption         =   "PER_PRIX"
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
         DataField       =   "PER_PBLSHR"
         Caption         =   "PER_PBLSHR"
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
         DataField       =   "PER_PRIX1"
         Caption         =   "PER_PRIX1"
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
         DataField       =   "PER_PUB"
         Caption         =   "PER_PUB"
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
      BeginProperty Column17 
         DataField       =   "PER_MOASS"
         Caption         =   "PER_MOASS"
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
      BeginProperty Column18 
         DataField       =   "PER_TAHRIR"
         Caption         =   "PER_TAHRIR"
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
      BeginProperty Column19 
         DataField       =   "PER_DIRCT"
         Caption         =   "PER_DIRCT"
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
      BeginProperty Column20 
         DataField       =   "PER_PRESD"
         Caption         =   "PER_PRESD"
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
      BeginProperty Column21 
         DataField       =   "PER_UTILS"
         Caption         =   "PER_UTILS"
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
      BeginProperty Column22 
         DataField       =   "PER_GEO1"
         Caption         =   "PER_GEO1"
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
      BeginProperty Column23 
         DataField       =   "PER_TAH1"
         Caption         =   "PER_TAH1"
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
      BeginProperty Column24 
         DataField       =   "PER_FAX"
         Caption         =   "PER_FAX"
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
      BeginProperty Column25 
         DataField       =   "PER_CREAT"
         Caption         =   "PER_CREAT"
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
      BeginProperty Column26 
         DataField       =   "PER_DTE"
         Caption         =   "PER_DTE"
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
         BeginProperty Column00 
            ColumnWidth     =   1739.906
         EndProperty
         BeginProperty Column01 
            ColumnWidth     =   1739.906
         EndProperty
         BeginProperty Column02 
            ColumnWidth     =   1739.906
         EndProperty
         BeginProperty Column03 
            ColumnWidth     =   1739.906
         EndProperty
         BeginProperty Column04 
            ColumnWidth     =   870.236
         EndProperty
         BeginProperty Column05 
         EndProperty
         BeginProperty Column06 
            ColumnWidth     =   1739.906
         EndProperty
         BeginProperty Column07 
            ColumnWidth     =   1140.095
         EndProperty
         BeginProperty Column08 
            ColumnWidth     =   840.189
         EndProperty
         BeginProperty Column09 
            ColumnWidth     =   870.236
         EndProperty
         BeginProperty Column10 
            ColumnWidth     =   1739.906
         EndProperty
         BeginProperty Column11 
            ColumnWidth     =   1590.236
         EndProperty
         BeginProperty Column12 
            ColumnWidth     =   1739.906
         EndProperty
         BeginProperty Column13 
            ColumnWidth     =   1739.906
         EndProperty
         BeginProperty Column14 
            ColumnWidth     =   1739.906
         EndProperty
         BeginProperty Column15 
            ColumnWidth     =   1739.906
         EndProperty
         BeginProperty Column16 
            ColumnWidth     =   1140.095
         EndProperty
         BeginProperty Column17 
            ColumnWidth     =   1140.095
         EndProperty
         BeginProperty Column18 
            ColumnWidth     =   1140.095
         EndProperty
         BeginProperty Column19 
            ColumnWidth     =   1140.095
         EndProperty
         BeginProperty Column20 
            ColumnWidth     =   1140.095
         EndProperty
         BeginProperty Column21 
            ColumnWidth     =   1739.906
         EndProperty
         BeginProperty Column22 
            ColumnWidth     =   1140.095
         EndProperty
         BeginProperty Column23 
            ColumnWidth     =   1140.095
         EndProperty
         BeginProperty Column24 
         EndProperty
         BeginProperty Column25 
            ColumnWidth     =   1140.095
         EndProperty
         BeginProperty Column26 
            ColumnWidth     =   1739.906
         EndProperty
      EndProperty
   End
   Begin VB.CommandButton Command8 
      Caption         =   "ÿ»«⁄… «·„·›"
      Height          =   735
      Left            =   120
      TabIndex        =   3
      Top             =   3480
      Width           =   735
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Œ‹‹—ÊÃ"
      Height          =   855
      Left            =   120
      TabIndex        =   2
      Top             =   4320
      Width           =   735
   End
   Begin VB.CommandButton Command1 
      Caption         =   "⁄œœ «·„ﬁ«·« "
      Height          =   735
      Index           =   0
      Left            =   120
      RightToLeft     =   -1  'True
      TabIndex        =   1
      Top             =   2640
      Width           =   735
   End
   Begin MSAdodcLib.Adodc result 
      Height          =   330
      Left            =   120
      Top             =   8280
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
      RecordSource    =   "select * from period"
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
   Begin MSRDC.MSRDC bnkout1 
      Height          =   330
      Left            =   5040
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
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "bnkout1"
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
      Height          =   450
      Left            =   9000
      Top             =   8160
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
   Begin MSAdodcLib.Adodc v_coding33 
      Height          =   330
      Left            =   3240
      Top             =   8280
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
   Begin MSAdodcLib.Adodc v_coding32 
      Height          =   330
      Left            =   -120
      Top             =   7920
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
   Begin MSRDC.MSRDC coding_typ 
      Height          =   375
      Left            =   7320
      Top             =   8280
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
   Begin MSRDC.MSRDC bnkout3 
      Height          =   330
      Left            =   2880
      Top             =   8400
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
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "bnkout3"
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
End
Attribute VB_Name = "frm_result"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command1_Click(Index As Integer)
On Error Resume Next

'If result.Recordset.EOF Then
  MsgBox "⁄œœ «·„ﬁ«·«  = " & result.Recordset.RecordCount
  
'End If
End Sub

Private Sub Command12_Click()
MsgBox p_crit
 Path = "d:\winpayrol\bin\wpayrol.exe " & p_crit
 X = Shell(Path, 1)
End Sub

Private Sub Command2_Click()
On Error Resume Next
jad_print = 3
 Screen.MousePointer = vbDefault
  Screen.MousePointer = vbHourglass
  form_report.WindowState = 2
  form_report.Show
  Screen.MousePointer = vbDefault


End Sub

Private Sub Command3_Click()
On Error Resume Next
Dim nb_SOM As Variant

If Not result.Recordset.EOF Then
  result.Recordset.MoveFirst
  While Not result.Recordset.EOF
    
    nb_SOM = nb_SOM + Val(DataGrid1.Columns(DataGrid1.Col))
      result.Recordset.MoveNext
   Wend
  MsgBox "«·„Ã„Ê⁄ = " & nb_SOM
  
    
End If
 End Sub

Private Sub Command4_Click()
On Error Resume Next
  jad_print = 8
 Screen.MousePointer = vbDefault
  Screen.MousePointer = vbHourglass
  form_report.WindowState = 2
  form_report.Show
  Screen.MousePointer = vbDefault

End Sub

Private Sub Command5_Click()
m_rchtext.SelStart = 0
  m_rchtext.SelLength = Len(m_rchtext.Text) - 1
  m_rchtext.SelColor = vbTransparent
 HighlightWords m_rchtext, m_word.Text, vbRed
End Sub

Private Sub Command10_Click()
Frame2.Visible = False
DataGrid1.SetFocus

End Sub

Private Sub Command11_Click()
 On Error Resume Next
 m_path = Dirlist.Path
  ser = 1
 result.Recordset.MoveFirst
 While Not result.Recordset.EOF
 m_cnf_path = ""
 If Not IsNull(result.Recordset![dig_typ1]) Then
 If Not IsNull(result.Recordset![dig_DIG_NO]) Then
 m_dig_typ1 = result.Recordset![dig_typ1]
       If m_dig_typ1 = "01" Then
          m_cnf_path = m_cnf_path_pic + "scan\"
        ElseIf m_dig_typ1 = "02" Then
         m_cnf_path = m_cnf_path_pic + "waves\"
        ElseIf m_dig_typ1 = "03" Then
         m_cnf_path = m_cnf_path_pic + "photos\"
           ElseIf m_dig_typ1 = "04" Then
         m_cnf_path = m_cnf_path_pic + "videos\"
        ElseIf m_dig_typ1 = "05" Then
         m_cnf_path = m_cnf_path_pic + "private\"
       End If
       M_DIG_TYP = Trim(result.Recordset![dig_typ])
         V_REC = result.Recordset![dig_DIG_NO]
         v_nam = result.Recordset![mn_app_no]
     If Not IsNull(result.Recordset![MN_ACT_TTL]) Then
       v_nam = v_nam + filter_desc(Trim(result.Recordset![MN_ACT_TTL]))
      Else
      v_nam = v_nam + ""
      End If
         If Not IsNull(result.Recordset![art_dte]) Then
             
            v_nam = v_nam + Str(Day(result.Recordset![art_dte])) + "-" + Str(Month(result.Recordset![art_dte])) + "-" + Str(Year(result.Recordset![art_dte]))
          
          End If
          If Not m_dig_typ1 = "04" Then
         m_source = m_cnf_path & Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\" & V_REC & "." & M_DIG_TYP
         Else
         m_source = m_cnf_path & V_REC & "." & M_DIG_TYP
         End If
        m_target = m_path & "\" & v_nam & "." & M_DIG_TYP
        myfile = Dir(m_source)
     If myfile <> "" Then
       FileCopy m_source, m_target
      End If
       If isrec.value = 1 Then
          m_dig_no = V_REC
          m_typ1 = m_dig_typ1
          m_typ = M_DIG_TYP
          m_no_ist = result.Recordset![mn_app_no]
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
      result.Recordset.MoveNext
   Wend
  
 
  result.Refresh
   MsgBox "·ﬁœ «‰ ÂÏ ‰”Œ «·„ﬁ«·« ...."

End Sub

Private Sub Command6_Click()
Unload frm_result

End Sub

Private Sub Command7_Click()
DBGrid1.Visible = True

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
  ElseIf box_company = 5 Then
    jad_print = 9
      ElseIf box_company = 7 Then
    jad_print = 11
          
     ElseIf box_company = 8 Then
    jad_print = 13
          
End If
 Screen.MousePointer = vbDefault
  Screen.MousePointer = vbHourglass
  form_report.WindowState = 2
  form_report.Show
  Screen.MousePointer = vbDefault

End Sub

Private Sub Command9_Click()
On Error Resume Next
Dim m_path As Variant
 ser = 1
 m_path = Dirlist.Path
  If main_form = 1 Then
     result.Recordset.MoveFirst
     While Not result.Recordset.EOF
      If result.Recordset![DIG_choice] = 1 Then
     m_cnf_path = ""
If Not IsNull(result.Recordset![dig_typ1]) Then
 If Not IsNull(result.Recordset![dig_DIG_NO]) Then
    m_dig_typ1 = result.Recordset![dig_typ1]
       If m_dig_typ1 = "01" Then
          m_cnf_path = m_cnf_path_pic + "scan\"
        ElseIf m_dig_typ1 = "02" Then
         m_cnf_path = m_cnf_path_pic + "waves\"
        ElseIf m_dig_typ1 = "03" Then
         m_cnf_path = m_cnf_path_pic + "photos\"
        ElseIf m_dig_typ1 = "05" Then
         m_cnf_path = m_cnf_path_pic + "private\"
       End If
      M_DIG_TYP = Trim(result.Recordset![dig_typ])
       v_nam = result.Recordset![mn_app_no]
       If Not IsNull(result.Recordset![MN_ACT_TTL]) Then
       v_nam = v_nam + filter_desc(Trim(result.Recordset![MN_ACT_TTL]))
      Else
       v_nam = v_nam + ""
      End If
      If Not IsNull(result.Recordset![art_dte]) Then
           v_nam = v_nam + Str(Day(result.Recordset![art_dte])) + "-" + Str(Month(result.Recordset![art_dte])) + "-" + Str(Year(result.Recordset![art_dte]))
          
          End If
         V_REC = result.Recordset![dig_DIG_NO]
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
          m_no_ist = result.Recordset![mn_app_no]
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
     result.Recordset.MoveNext
 Wend
  result.Refresh
   MsgBox "·ﬁœ «‰ ÂÏ ‰”Œ «·„ﬁ«·« ...."
 

 End If
Frame2.Visible = False
DataGrid1.SetFocus




End Sub

Private Sub datagrid1_DblClick()
On Error Resume Next
    Dim v_prs_no, m_no As String
    Dim V_REC As Variant
    Dim M_NAM, M_NAM1, M_CD As String
    lkey = KeyAscii
         
If Not result.Recordset.BOF Then
m_cnf_path = ""
 m_dig_typ1 = result.Recordset![dig_typ1]

 If Not m_dig_typ1 = "04" And Not m_dig_typ1 = "02" Then
       If m_dig_typ1 = "01" Then
          m_cnf_path = m_cnf_path_pic + "scan\"
         
        ElseIf m_dig_typ1 = "03" Then
         m_cnf_path = m_cnf_path_pic + "photos\"
        ElseIf m_dig_typ1 = "05" Then
         m_cnf_path = m_cnf_path_pic + "private\"
       End If
M_DIG_TYP = Trim(result.Recordset![dig_typ])
V_REC = result.Recordset![dig_DIG_NO]
M_NAM1 = Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\" & V_REC & "." & M_DIG_TYP
m_x = m_cnf_path & M_NAM1
   m_file = Dir(m_x)
    If m_file <> "" Then
      Call OpenDoc(m_x)
     Else
      MsgBox ("Â–« «·„·› €Ì— „ÊÃÊœ ›Ì «·«—‘Ì›...." & m_x)
      
     End If
     Else
     If Not IsEmpty(result.Recordset![dig_typ]) Then
      v_mch_typ = Trim(result.Recordset![dig_typ])
      Else
      v_mch_typ = ""
      End If
     nb_page = 0
     v_mch_digtyp = m_dig_typ1
     V_REC = result.Recordset![dig_DIG_NO]
      If m_dig_typ1 = "02" Then
       M_NAM1 = Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\"
         m_config_path = m_cnf_path_pic + "waves\" + M_NAM1
         
      End If
     v_mch_o = result.Recordset![dig_o]
 v_mch_m = result.Recordset![dig_m]
 v_mch_s = result.Recordset![dig_s]
v_mch_o1 = result.Recordset![dig_o1]
 v_mch_m1 = result.Recordset![dig_m1]
 v_mch_s1 = result.Recordset![dig_s1]
 V_MCH_STOCK = result.Recordset![dig_DIG_NO]
 Screen.MousePointer = vbDefault
         Screen.MousePointer = vbHourglass
         vd_preview.WindowState = 0
          vd_preview.Show
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
  Dim sql As String
  
'If KeyCode = vbKeyF8 Then
'  If main_form = 1 Then
'     result.Recordset.MoveFirst
'     While Not result.Recordset.EOF
'      If result.Recordset![art_choice] = 1 Then
'         V_REC = result.Recordset![art_flm_no]
'         m_source = m_cnf_path_pic & Mid$(V_REC, 1, 2) & "\" & Mid$(V_REC, 3, 2) & "\" & V_REC & ".tif"
'         m_target = "c:\data_scan\" & V_REC & ".tif"
'         myfile = Dir(m_source)
'         If myfile <> "" Then
'            FileCopy m_source, m_target
'            m_typ = 0
'            SQL = "execute upd_dig_choice " & "'" & V_REC & "'" & "," & "'" & m_typ & "'"
'               cn.Execute SQL, rdExecDirect
'         Else
'           MsgBox V_REC & " Â–Â «·„ﬁ«·… €Ì— „ÊÃÊœ… ›Ì «·«—‘Ì›"
''         End If
 '      End If
 '    result.Recordset.MoveNext
 'Wend
 '
 ' result.Refresh
 '  MsgBox "·ﬁœ «‰ ÂÏ ‰”Œ «·„ﬁ«·« ...."
 'End If
 If KeyCode = vbKeyF9 Then
   
      m_row = result.Recordset.Bookmark - 1
     If result.Recordset![DIG_choice] = 0 Or IsNull(result.Recordset![DIG_choice]) Then
        V_REC = result.Recordset![dig_DIG_NO]
        v_typ = result.Recordset![dig_typ1]
        m_typ = 1
     Else
        m_typ = 0
         v_typ = result.Recordset![dig_typ1]
     V_REC = result.Recordset![dig_DIG_NO]
     End If
     sql = "execute upd_dig_choice " & "'" & V_REC & "'" & "," & "'" & m_typ & "'" _
     & "," & "'" & v_typ & "'"
     cn.Execute sql, rdExecDirect
     result.Refresh
    ' DataGrid1.Row = m_row
     
    result.Recordset.Requery
    result.Recordset.Move (m_row)
 
 ElseIf KeyCode = vbKeyF2 Then
   
    m_bk_no = result.Recordset![mn_app_no]
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
End Sub

 
Private Sub DataGrid1_KeyUp(KeyCode As Integer, Shift As Integer)
On Error Resume Next
If KeyCode = vbKeyF6 Then
' RESULT.Recordset.Bookmark = DataGrid1.Row
v_mch_digtyp = result.Recordset![dig_typ1]
v_mch_o = result.Recordset![dig_o]
 v_mch_m = result.Recordset![dig_m]
 v_mch_s = result.Recordset![dig_s]
v_mch_o1 = result.Recordset![dig_o1]
 v_mch_m1 = result.Recordset![dig_m1]
 v_mch_s1 = result.Recordset![dig_s1]
 v_mch_tit = result.Recordset![MN_ACT_TTL]
 v_mch_no = result.Recordset![mn_app_no]
 V_MCH_STOCK = result.Recordset![dig_DIG_NO]
 nb_page = 0
If Not IsEmpty(result.Recordset![dig_typ_high]) Then
      v_mch_typ_high = Trim(result.Recordset![dig_typ_high])
      ElseIf Not IsEmpty(result.Recordset![dig_typ]) Then
      v_mch_typ_high = Trim(result.Recordset![dig_typ])
      Else
        v_mch_typ_high = "avi"
      End If
    If Not IsEmpty(result.Recordset![dig_typ]) Then
      v_mch_typ = Trim(result.Recordset![dig_typ])
      Else
        v_mch_typ = "avi"
      End If
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 new_vdpreview.WindowState = 0
 new_vdpreview.Show
' vd_prv.WindowState = 0
' vd_prv.Show

 Screen.MousePointer = vbDefault
 
    new_vdpreview.Refresh
   ElseIf KeyCode = vbKeyF7 Then
' RESULT.Recordset.Bookmark = DataGrid1.Row
v_mch_o = result.Recordset![tm_o]
 v_mch_m = result.Recordset![tm_m]
 v_mch_s = result.Recordset![tm_s]
v_mch_o1 = result.Recordset![tm_o1]
 v_mch_m1 = result.Recordset![tm_m1]
 v_mch_s1 = result.Recordset![tm_s1]
 v_mch_tit = result.Recordset![MN_ACT_TTL]
 V_MCH_STOCK = result.Recordset![dig_DIG_NO]
 nb_page = 0
If Not IsEmpty(result.Recordset![dig_typ]) Then
      v_mch_typ = Trim(result.Recordset![dig_typ])
      Else
      v_mch_typ = ""
      End If
 Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 new_vdpreview.WindowState = 0
 new_vdpreview.Show
' vd_prv.WindowState = 0
' vd_prv.Show

 Screen.MousePointer = vbDefault
 
    new_vdpreview.Refresh
  ElseIf KeyCode = vbKeyF4 Then
  Frame1.Visible = True
  m_doc_no = result.Recordset![mn_app_no]
  m_ser_no = result.Recordset![fad_ser_no]
  m_rel_no = result.Recordset![fad_rltv_n]
  
   d_text.sql = "EXECUTE serh_text " & "'" & m_doc_no & "'" & "," & "'" & m_rel_no & "'" & "," & "'" & m_ser_no & "'"
   d_text.Refresh
     m_rchtext.Text = ""
 If Not d_text.Resultset.EOF And Not d_text.Resultset.BOF Then
   d_text.Resultset.MoveFirst
While Not d_text.Resultset.EOF And Not d_text.Resultset.BOF
   If Not IsNull(d_text.Resultset![txt_text]) Then
     m_rchtext.Text = m_rchtext.Text + d_text.Resultset![txt_text]
    End If
   d_text.Resultset.MoveNext
Wend
    End If
      ElseIf KeyCode = vbKeyF5 Then
      Frame1.Visible = True
     m_doc_no = result.Recordset![mn_app_no]
   d_text.sql = "EXECUTE serh_text5 " & "'" & m_doc_no & "'"
   d_text.Refresh
     m_rchtext.Text = ""
 If Not d_text.Resultset.EOF And Not d_text.Resultset.BOF Then
   d_text.Resultset.MoveFirst
While Not d_text.Resultset.EOF And Not d_text.Resultset.BOF
   If Not IsNull(d_text.Resultset![txt_text]) Then
     m_rchtext.Text = m_rchtext.Text + d_text.Resultset![txt_text]
    End If
   d_text.Resultset.MoveNext
Wend
    End If
  End If
End Sub

Private Sub DBGrid1_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
DBGrid1.Visible = False


End If
End Sub

Private Sub Dirlist_Change()
fillist.Path = Dirlist.Path
End Sub

Private Sub Dirlist_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
 Frame2.Visible = False
 DataGrid1.SetFocus
End If

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
  
  m_if1 = 1
  m_if2 = 2
'If ARCHIVE.f2.Checked = True Or ARCHIVE.f5.Checked = True Then
If main_form = 1 Or main_form = 4 Then
 var_ist = "01"
   crit5 = "select view_user_bnkout.* from view_user_bnkout where user_out_choice = " & "'" & m_if1 & "'" & " and user_no = " & "'" & box_user_no & "'" & " and ( user_ist_no = " & "'" & var_ist & "'" & " ) order by user_out_index"
   CRIT6 = "select out_desc,out_len from view_user_bnkout where user_out_choice = " & "'" & m_if1 & "'" & " and user_no = " & "'" & box_user_no & "'" & " and ( user_ist_no = " & "'" & var_ist & "'" & " ) order by user_out_index"
   bnkout1.sql = crit5
   bnkout3.sql = CRIT6
   bnkout3.Refresh
'ElseIf ARCHIVE.f3.Checked = True Then
 ElseIf main_form = 2 Then
var_ist = "02"
crit5 = "select view_user_pout.* from view_user_pout where " & " ( user_ist_no = " & "'" & var_ist & "'" & " ) and (user_out_choice = " & "'" & m_if1 & "'" & " ) and user_no = " & "'" & box_user_no & "'" & " order by user_out_index"
 ' crit2 = "select pout.* from pout"
  'crit2 = crit2 & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
   '       & " and ( user_out_choice = " & "'" & m_if1 & "'" & " )"
  bnkout1.sql = crit5
'ElseIf ARCHIVE.f4.Checked = True Then
ElseIf main_form = 3 Then
  var_ist = "06"
  'crit2 = "select pout.* from pout"
  'crit2 = crit2 & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
   '       & " and ( out_chioce = " & "'" & m_if1 & "'" & " )"
   crit5 = "select view_user_pout.* from view_user_pout where " & " ( user_ist_no = " & "'" & var_ist & "'" & " ) and (user_out_choice = " & "'" & m_if1 & "'" & " ) and user_no = " & "'" & box_user_no & "'" & " order by user_out_index"
  bnkout1.sql = crit5
  ElseIf main_form = 5 Then
  var_ist = "01"
  crit2 = "select pout1.* from pout1"
  crit2 = crit2 & "  where ( pout1.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_chioce = " & "'" & m_if1 & "'" & " )"
  bnkout1.sql = crit2
  ElseIf main_form = 6 Then
  var_ist = "02"
  crit2 = "select pout1.* from pout1"
  crit2 = crit2 & "  where ( pout1.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_chioce = " & "'" & m_if1 & "'" & " )"
  bnkout1.sql = crit2
 ElseIf main_form = 7 Then
   CRIT = "select bnkout.* from bnkout where out_chioce = " & "'" & m_if1 & "'" & "order by out_indx"
   bnkout1.sql = CRIT
 End If
bnkout1.Refresh

'If ARCHIVE.f2.Checked = True Then
If main_form = 1 Then
    result.RecordSource = "execute tmp_result"
   result.Refresh
   bnkout1.Resultset.MoveFirst
     i = 0
    While Not bnkout1.Resultset.EOF
      If bnkout1.Resultset![user_out_choice] = 1 Then
         DataGrid1.Columns(i).DataField = bnkout1.Resultset![OUT_name]
         DataGrid1.Columns(i).Caption = Trim(bnkout1.Resultset![OUT_desc])
         DataGrid1.Columns(i).Width = bnkout1.Resultset![OUT_len1]
                 
       i = i + 1
       End If
       bnkout1.Resultset.MoveNext
    Wend
'ElseIf ARCHIVE.f5.Checked = True Then
ElseIf main_form = 4 Then
    result.RecordSource = "execute tmp_result3"
   result.Refresh
   bnkout1.Resultset.MoveFirst
     i = 0
    While Not bnkout1.Resultset.EOF
      If bnkout1.Resultset![out_chioce] = 1 Then
         DataGrid1.Columns(i).DataField = bnkout1.Resultset![OUT_name]
         DataGrid1.Columns(i).Caption = Trim(bnkout1.Resultset![OUT_desc])
         DataGrid1.Columns(i).Width = bnkout1.Resultset![OUT_len1]
       i = i + 1
       End If
       bnkout1.Resultset.MoveNext
    Wend
 
' ElseIf ARCHIVE.f3.Checked = True Then
 ElseIf main_form = 2 Then
   result.RecordSource = "execute tmp_result1"
   result.Refresh
      bnkout1.Resultset.MoveFirst
     i = 0
    While Not bnkout1.Resultset.EOF
      If bnkout1.Resultset![user_out_choice] = 1 And bnkout1.Resultset![out_ist] = var_ist Then
         DataGrid1.Columns(i).DataField = bnkout1.Resultset![OUT_name]
         DataGrid1.Columns(i).Caption = bnkout1.Resultset![OUT_desc]
         DataGrid1.Columns(i).Width = bnkout1.Resultset![OUT_len1]
       i = i + 1
       End If
       bnkout1.Resultset.MoveNext
    Wend

'ElseIf ARCHIVE.f4.Checked = True Then
ElseIf main_form = 3 Then
   result.RecordSource = "execute tmp_result2"
   result.Refresh
         bnkout1.Resultset.MoveFirst
     i = 0
    While Not bnkout1.Resultset.EOF
      If bnkout1.Resultset![user_out_choice] = 1 And bnkout1.Resultset![out_ist] = var_ist Then
         DataGrid1.Columns(i).DataField = bnkout1.Resultset![OUT_name]
         DataGrid1.Columns(i).Caption = Trim(bnkout1.Resultset![OUT_desc])
         DataGrid1.Columns(i).Width = bnkout1.Resultset![OUT_len1]
       i = i + 1
       End If
       bnkout1.Resultset.MoveNext
    Wend
ElseIf main_form = 5 Then
   result.RecordSource = "execute tmp_result4"
   result.Refresh
         bnkout1.Resultset.MoveFirst
     i = 0
    While Not bnkout1.Resultset.EOF
      If bnkout1.Resultset![out_chioce] = 1 And bnkout1.Resultset![out_ist] = var_ist Then
         DataGrid1.Columns(i).DataField = bnkout1.Resultset![OUT_name]
         DataGrid1.Columns(i).Caption = Trim(bnkout1.Resultset![OUT_desc])
         DataGrid1.Columns(i).Width = bnkout1.Resultset![OUT_len1]
       i = i + 1
       End If
       bnkout1.Resultset.MoveNext
    Wend
ElseIf main_form = 6 Then
   result.RecordSource = "execute tmp_result6"
   result.Refresh
         bnkout1.Resultset.MoveFirst
     i = 0
    While Not bnkout1.Resultset.EOF
      If bnkout1.Resultset![out_chioce] = 1 And bnkout1.Resultset![out_ist] = var_ist Then
         DataGrid1.Columns(i).DataField = bnkout1.Resultset![OUT_name]
         DataGrid1.Columns(i).Caption = Trim(bnkout1.Resultset![OUT_desc])
         DataGrid1.Columns(i).Width = bnkout1.Resultset![OUT_len1]
       i = i + 1
       End If
       bnkout1.Resultset.MoveNext
    Wend
ElseIf main_form = 7 Then
    result.RecordSource = "execute tmp_result7"
   result.Refresh
   bnkout1.Resultset.MoveFirst
     i = 0
    While Not bnkout1.Resultset.EOF
      If bnkout1.Resultset![out_chioce] = 1 Then
         DataGrid1.Columns(i).DataField = bnkout1.Resultset![OUT_name]
         DataGrid1.Columns(i).Caption = Trim(bnkout1.Resultset![OUT_desc])
         DataGrid1.Columns(i).Width = bnkout1.Resultset![OUT_len1]
       i = i + 1
       End If
       bnkout1.Resultset.MoveNext
    Wend
 

End If
   For k = i To 26
     DataGrid1.Columns(k).Visible = False
   Next
   result.Refresh
   
  DataGrid1.Refresh
     
End Sub

Private Sub M_NAM_CD_Change()
'Dim mydb As Database
'Dim MYTAB As Recordset

'Set mydb = DBEngine.Workspaces(0).OpenDatabase("c:\program files\gnr_prg\gnr_11.mdb")
'Set MYTAB = mydb.OpenRecordset("NAM_CD")
'If Not IsEmpty(M_NAM_CD) And Not IsNull(M_NAM_CD) And Not M_NAM_CD = "" Then
'    MYTAB.Edit
'    MYTAB("NAME_CD") = M_NAM_CD
'    MYTAB.Update
'End If
'
End Sub

Private Sub Form1_Click()

End Sub





Private Sub m_rchtext_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
Frame1.Visible = False
End If
End Sub

Private Sub m_res_cote_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_res_prs.SetFocus
 
End If


End Sub

Private Sub m_res_prs_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 m_res_subject.SetFocus
 
End If


End Sub

