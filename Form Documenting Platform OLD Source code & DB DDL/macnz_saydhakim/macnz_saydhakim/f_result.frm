VERSION 5.00
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{CDE57A40-8B86-11D0-B3C6-00A0C90AEA82}#1.0#0"; "MSDATGRD.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form f_result 
   BackColor       =   &H00FFFFC0&
   Caption         =   "ÇÑÔíÝ ØáÈÇÊ ÇáÇÓÊÝÇÏÉ"
   ClientHeight    =   9660
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11700
   LinkTopic       =   "Form1"
   ScaleHeight     =   9660
   ScaleWidth      =   11700
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command5 
      BackColor       =   &H00C0C000&
      Caption         =   "ãÚÇáÌÉ ØáÈÇÊ ãÚíäÉ"
      Height          =   495
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   41
      Top             =   2400
      Width           =   1095
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H8000000C&
      Height          =   3135
      Left            =   720
      RightToLeft     =   -1  'True
      TabIndex        =   26
      Top             =   5280
      Visible         =   0   'False
      Width           =   6255
      Begin VB.CommandButton Command6 
         Caption         =   "ÇáÛÇÁ ÇáØáÈ"
         Height          =   495
         Left            =   2760
         TabIndex        =   42
         Top             =   2520
         Width           =   975
      End
      Begin VB.TextBox v_res_no 
         Alignment       =   1  'Right Justify
         Height          =   285
         Left            =   3600
         TabIndex        =   39
         Top             =   1800
         Width           =   1335
      End
      Begin VB.CommandButton Command9 
         Caption         =   "ÊÚÏíá"
         Height          =   495
         Left            =   5040
         TabIndex        =   31
         Top             =   2520
         Width           =   1095
      End
      Begin VB.CommandButton Command10 
         Caption         =   "ÇáÛÇÁ ÇáÇãÑ"
         Height          =   495
         Left            =   1680
         TabIndex        =   30
         Top             =   2520
         Width           =   975
      End
      Begin VB.CommandButton Command11 
         Caption         =   "ÇÖÇÝÉ"
         Height          =   495
         Left            =   3840
         TabIndex        =   29
         Top             =   2520
         Width           =   1095
      End
      Begin VB.TextBox v_res_prs 
         Alignment       =   1  'Right Justify
         Height          =   285
         Left            =   1800
         TabIndex        =   28
         Top             =   960
         Width           =   3135
      End
      Begin VB.TextBox v_res_subject 
         Alignment       =   1  'Right Justify
         Height          =   285
         Left            =   1800
         TabIndex        =   27
         Top             =   1320
         Width           =   3135
      End
      Begin MSDataListLib.DataCombo v_res_permit 
         Bindings        =   "f_result.frx":0000
         Height          =   315
         Left            =   3120
         TabIndex        =   32
         Top             =   480
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "sub_desc"
         BoundColumn     =   "sub_code"
         Text            =   ""
         RightToLeft     =   -1  'True
      End
      Begin MSDataListLib.DataCombo v_res_cote 
         Bindings        =   "f_result.frx":0019
         Height          =   315
         Left            =   0
         TabIndex        =   33
         Top             =   480
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   556
         _Version        =   393216
         ListField       =   "sub_desc"
         BoundColumn     =   "sub_code"
         Text            =   ""
         RightToLeft     =   -1  'True
      End
      Begin VB.Label Label9 
         Alignment       =   1  'Right Justify
         BackColor       =   &H8000000C&
         Caption         =   "ÑÞã ÇáØáÈ"
         Height          =   255
         Left            =   4920
         RightToLeft     =   -1  'True
         TabIndex        =   40
         Top             =   1800
         Width           =   1215
      End
      Begin VB.Label Label19 
         Alignment       =   2  'Center
         BackColor       =   &H8000000C&
         Caption         =   "ãÚÇáÌÉ ØáÈÇÊ ãÚíäÉ"
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
         TabIndex        =   38
         Top             =   0
         Width           =   3495
      End
      Begin VB.Label Label8 
         Alignment       =   1  'Right Justify
         BackColor       =   &H8000000C&
         Caption         =   "ÇáÌåÉ ÇáãæÇÝÞÉ"
         Height          =   255
         Left            =   4920
         RightToLeft     =   -1  'True
         TabIndex        =   37
         Top             =   480
         Width           =   1215
      End
      Begin VB.Label Label7 
         Alignment       =   1  'Right Justify
         BackColor       =   &H8000000C&
         Caption         =   "ÇáÌåÉ ÇáãÓÊÝíÏÉ"
         Height          =   495
         Left            =   1800
         RightToLeft     =   -1  'True
         TabIndex        =   36
         Top             =   480
         Width           =   855
      End
      Begin VB.Label Label6 
         Alignment       =   1  'Right Justify
         BackColor       =   &H8000000C&
         Caption         =   "ÇáãÓÊÝíÏ"
         Height          =   255
         Left            =   4920
         RightToLeft     =   -1  'True
         TabIndex        =   35
         Top             =   960
         Width           =   1215
      End
      Begin VB.Label Label21 
         Alignment       =   1  'Right Justify
         BackColor       =   &H8000000C&
         Caption         =   "ÇáãæÖæÚ"
         Height          =   255
         Left            =   4920
         RightToLeft     =   -1  'True
         TabIndex        =   34
         Top             =   1320
         Width           =   1215
      End
   End
   Begin VB.TextBox m_res_no 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   8640
      TabIndex        =   24
      Top             =   3960
      Width           =   1575
   End
   Begin VB.TextBox M_DIG_TYP 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   6240
      TabIndex        =   22
      Top             =   3000
      Width           =   615
   End
   Begin MSDataGridLib.DataGrid DataGrid1 
      Bindings        =   "f_result.frx":0032
      Height          =   3975
      Left            =   360
      TabIndex        =   21
      Top             =   4440
      Width           =   11175
      _ExtentX        =   19711
      _ExtentY        =   7011
      _Version        =   393216
      AllowUpdate     =   -1  'True
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
      Caption         =   " "
      ColumnCount     =   14
      BeginProperty Column00 
         DataField       =   "res_no"
         Caption         =   "ÑÞã ÇáØáÈ"
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
      BeginProperty Column01 
         DataField       =   "MN_ACT_TTL"
         Caption         =   "ÇáÚäæÇä"
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
         DataField       =   "desc_cote"
         Caption         =   "ÌåÉ ÇáÇÓÊÝÇÏÉ"
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
         DataField       =   "res_no_ist"
         Caption         =   "ÑÞã ÇáÇÓÊãÇÑÉ"
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
         DataField       =   "desc_permit"
         Caption         =   "ÇáÌåÉ ÇáãæÇÝÞÉ"
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
         DataField       =   "res_no"
         Caption         =   "res_no"
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
         DataField       =   "res_ser"
         Caption         =   "ÇáãÊÓáÓá"
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
         DataField       =   "res_dig_no"
         Caption         =   "ÑÞã ÇáÏíÌÊÇá"
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
         DataField       =   "res_typ"
         Caption         =   "äæÚ ÇáãáÝ"
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
         DataField       =   "res_dte"
         Caption         =   "ÇáÊÇÑíÎ"
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   1
            Format          =   "dd/MM/yyyy"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1033
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column10 
         DataField       =   "res_user_no"
         Caption         =   "ÇáãÓÊÎÏã"
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
         DataField       =   "res_prs"
         Caption         =   "ÇÓã ÇáãÓÊÝíÏ"
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
         DataField       =   "res_subject"
         Caption         =   "ÇáãæÖæÚ"
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
         DataField       =   "desc_typ1"
         Caption         =   "äæÚ ÇáæËíÞÉ"
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
            ColumnWidth     =   915.024
         EndProperty
         BeginProperty Column01 
            ColumnWidth     =   3000.189
         EndProperty
         BeginProperty Column02 
            ColumnWidth     =   2505.26
         EndProperty
         BeginProperty Column03 
            Object.Visible         =   -1  'True
            ColumnWidth     =   1500.095
         EndProperty
         BeginProperty Column04 
            ColumnWidth     =   2505.26
         EndProperty
         BeginProperty Column05 
            Object.Visible         =   0   'False
            ColumnWidth     =   915.024
         EndProperty
         BeginProperty Column06 
            ColumnWidth     =   915.024
         EndProperty
         BeginProperty Column07 
            ColumnWidth     =   840.189
         EndProperty
         BeginProperty Column08 
            ColumnWidth     =   615.118
         EndProperty
         BeginProperty Column09 
            ColumnWidth     =   1140.095
         EndProperty
         BeginProperty Column10 
            ColumnWidth     =   884.976
         EndProperty
         BeginProperty Column11 
            ColumnWidth     =   2505.26
         EndProperty
         BeginProperty Column12 
            Object.Visible         =   -1  'True
            ColumnWidth     =   2505.26
         EndProperty
         BeginProperty Column13 
            ColumnWidth     =   1995.024
         EndProperty
      EndProperty
   End
   Begin VB.TextBox m_res_prs 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   7200
      TabIndex        =   13
      Top             =   2520
      Width           =   3135
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H00C0C000&
      Caption         =   "ÇáäÊíÌÉ"
      Height          =   495
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   1800
      Width           =   1095
   End
   Begin VB.CommandButton Command2 
      BackColor       =   &H00C0C000&
      Caption         =   "ÎÜÜÑæÌ"
      Height          =   495
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   3000
      Width           =   1095
   End
   Begin VB.CommandButton Command3 
      BackColor       =   &H00C0C000&
      Caption         =   "ÚÏÏ ÇáãÞÇáÇÊ"
      Height          =   495
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   1200
      Width           =   1095
   End
   Begin VB.TextBox m_word 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   6120
      TabIndex        =   3
      Top             =   1560
      Width           =   4095
   End
   Begin VB.CommandButton Command4 
      BackColor       =   &H00C0C000&
      Caption         =   "ÈÍË ÌÏíÏ"
      Height          =   495
      Left            =   240
      MaskColor       =   &H00FFFFC0&
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   600
      UseMaskColor    =   -1  'True
      Width           =   1095
   End
   Begin VB.CommandButton Command8 
      BackColor       =   &H00C0C000&
      Caption         =   "ØÈÇÚÉ ÇáãáÝ"
      Height          =   495
      Left            =   240
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   0
      Width           =   1095
   End
   Begin VB.TextBox m_dig_dig_no 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   8520
      TabIndex        =   0
      Top             =   3000
      Width           =   1575
   End
   Begin MSMask.MaskEdBox M_res_dte1 
      Height          =   375
      Left            =   6120
      TabIndex        =   7
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
   Begin MSMask.MaskEdBox M_res_dte 
      Height          =   375
      Left            =   8760
      TabIndex        =   8
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
   Begin MSDataListLib.DataCombo m_res_permit 
      Bindings        =   "f_result.frx":0049
      Height          =   315
      Left            =   8520
      TabIndex        =   14
      Top             =   2040
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
      Bindings        =   "f_result.frx":0062
      Height          =   315
      Left            =   5400
      TabIndex        =   15
      Top             =   2040
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "sub_desc"
      BoundColumn     =   "sub_code"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin MSDataListLib.DataCombo m_dig_typ1 
      Bindings        =   "f_result.frx":007B
      Height          =   315
      Left            =   8640
      TabIndex        =   19
      Top             =   3480
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   " "
      RightToLeft     =   -1  'True
   End
   Begin MSAdodcLib.Adodc v_coding33 
      Height          =   330
      Left            =   480
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
      Left            =   2040
      Top             =   9000
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
   Begin MSAdodcLib.Adodc v_coding24 
      Height          =   330
      Left            =   3600
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
   Begin MSAdodcLib.Adodc d_result 
      Height          =   330
      Left            =   6240
      Top             =   8880
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
      RecordSource    =   "select * from view_result  "
      Caption         =   "d_result"
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
      Left            =   8520
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
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "ÑÞã ÇáØáÈ"
      Height          =   255
      Left            =   10200
      RightToLeft     =   -1  'True
      TabIndex        =   25
      Top             =   3960
      Width           =   1455
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "äæÚ DIGITAL"
      Height          =   255
      Left            =   6840
      RightToLeft     =   -1  'True
      TabIndex        =   23
      Top             =   3000
      Width           =   1455
   End
   Begin VB.Label Label10 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "äæÚ ÇáæËíÞÉ"
      Height          =   375
      Left            =   10680
      RightToLeft     =   -1  'True
      TabIndex        =   20
      Top             =   3480
      Width           =   855
   End
   Begin VB.Label Label17 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "ÇáÌåÉ ÇáãæÇÝÞÉ"
      Height          =   255
      Left            =   10320
      RightToLeft     =   -1  'True
      TabIndex        =   18
      Top             =   2040
      Width           =   1215
   End
   Begin VB.Label Label18 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "ÇáÌåÉ ÇáãÓÊÝíÏÉ"
      Height          =   495
      Left            =   7200
      RightToLeft     =   -1  'True
      TabIndex        =   17
      Top             =   2040
      Width           =   855
   End
   Begin VB.Label Label20 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "ÇáãÓÊÝíÏ"
      Height          =   255
      Left            =   10320
      RightToLeft     =   -1  'True
      TabIndex        =   16
      Top             =   2520
      Width           =   1215
   End
   Begin VB.Shape Shape1 
      Height          =   4455
      Left            =   120
      Top             =   4320
      Width           =   11535
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "Çáì ÊÇÑíÎ :"
      Height          =   375
      Left            =   7440
      TabIndex        =   12
      Top             =   360
      Width           =   1215
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "ãä ÊÇÑíÎ :"
      Height          =   375
      Left            =   10200
      RightToLeft     =   -1  'True
      TabIndex        =   11
      Top             =   360
      Width           =   1455
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "ßáãÉ ãä ÇáÚäÇæíä"
      Height          =   255
      Left            =   10200
      RightToLeft     =   -1  'True
      TabIndex        =   10
      Top             =   1560
      Width           =   1455
   End
   Begin VB.Label Label13 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00E8DE8C&
      Caption         =   "ÑÞã digital"
      Height          =   255
      Left            =   10080
      RightToLeft     =   -1  'True
      TabIndex        =   9
      Top             =   3000
      Width           =   1455
   End
End
Attribute VB_Name = "f_result"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim CRIT As String
Dim first_qst As Integer
Dim crit1 As String
Dim m_typ_serh As Integer
Dim qst1, qst2, qst3, qst4, qst5, qst6, qst7, qst8, qst9, qst10, qst11    As Integer

Private Sub Command1_Click()
On Error Resume Next
'Dim cn As New rdoConnection

Dim sql As String
Dim qd As rdoQuery
Dim sql_query As String
If qst1 = 0 And Not M_res_dte.Text = "__/__/____" Then
  qst1 = 1
 If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     
     m_dte1 = Format(M_res_dte.Text, "YYYY/MM/DD")
     crit1 = crit1 & "  RES_DTE >= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102)"
     M_res_dte.Enabled = False
End If
If qst2 = 0 And Not M_res_dte1.Text = "__/__/____" Then
 qst2 = 1
 If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
    
   m_dte = M_res_dte1.Text
  crit1 = crit1 & "   RES_dte <= " & "convert(datetime," & "'" & Format(m_dte, "yyyy-mm-dd") & "'" & "," & "102)"
  M_res_dte1.Enabled = False
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
If qst8 = 0 And Not m_dig_dig_no.Text = "" Then
  qst8 = 1
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
If qst9 = 0 And Not M_DIG_TYP.Text = "" Then

   qst9 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     ' crit1 = crit1 & "dig_dig_no =  " & "'" & m_dig_dig_no.Text & "'"
         crit1 = crit1 & "RES_typ like " & "'" & "%" & M_DIG_TYP.Text & "%" & "'"
     M_DIG_TYP.Enabled = False
      Command1.SetFocus
      
End If
If qst7 = 0 And Not m_res_prs.Text = "" Then
 qst7 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & "res_prs like " & "'" & "%" & m_res_prs.Text & "%" & "'"
      m_res_prs.Enabled = False
      Command1.SetFocus
 End If
 If qst5 = 0 And Not m_res_cote.Text = "" Then
   qst5 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " RES_cote = " & "'" & Mid(m_res_cote.BoundText, 3, 2) & "'"
        
      m_res_cote.Enabled = False
      Command1.SetFocus
End If
If qst6 = 0 And Not m_res_permit.Text = "" Then
   qst6 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " RES_PERMIT = " & "'" & Mid(m_res_permit.BoundText, 3, 2) & "'"
        
      m_res_permit.Enabled = False
      Command1.SetFocus
End If
If qst3 = 0 And Not m_word.Text = "" Then
  qst3 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & "mn_act_ttl  like " & "'" & "%" & m_word.Text & "%" & "'"
      m_word.Enabled = False
      Command1.SetFocus
      
End If
If qst11 = 0 And Not m_res_no.Text = "" Then
  qst11 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     ' crit1 = crit1 & "dig_dig_no =  " & "'" & m_dig_dig_no.Text & "'"
         crit1 = crit1 & " res_no like " & "'" & "%" & m_res_no.Text & "%" & "'"
      m_res_no.Enabled = False
      Command1.SetFocus
      
End If
If first_qst > 0 Then
  crit2 = CRIT & crit1 & " order by RES_dte"
'MsgBox crit2
       sql = "drop proc tmp_dmd_result "
       cn.Execute sql, rdExecDirect
       cn.Execute crit2, rdExecDirect
       Screen.MousePointer = vbDefault
       Screen.MousePointer = vbHourglass
       d_result.RecordSource = "execute tmp_dmd_result"
        d_result.Refresh
      DataGrid1.Refresh
      DataGrid1.SetFocus
      Screen.MousePointer = vbDefault
 Else
      MsgBox "íÌÈ ØÑÍ ÇáÓÄÇá ÇæáÇ....."
End If
End Sub

Private Sub Command10_Click()
Frame2.Visible = False

End Sub

Private Sub Command2_Click()
Unload f_result
End Sub

Private Sub Command3_Click()
On Error Resume Next
Dim nb_rec As Variant
If d_result.Recordset.EOF Then
  MsgBox "áÇíæÌÏ ãÞÇáÇÊ áåÐÇ ÇáÓÄÇá"
Else
  Screen.MousePointer = vbDefault
  Screen.MousePointer = vbHourglass
  d_result.Recordset.MoveLast
  nb_rec = d_result.Recordset.RecordCount
  
  Screen.MousePointer = vbDefault
  MsgBox "ÚÏÏ ÇáãÞÇáÇÊ = " & nb_rec
End If
 
End Sub

Private Sub Command4_Click()

M_res_dte.Enabled = True
M_res_dte1.Enabled = True
m_dig_typ1.Enabled = True
m_res_cote.Enabled = True
m_res_permit.Enabled = True
M_DIG_TYP.Enabled = True
m_res_prs.Enabled = True
m_word.Enabled = True
m_dig_dig_no.Enabled = True
M_res_dte.Enabled = True
m_res_no.Enabled = True

M_res_dte.Text = "__/__/____"
M_res_dte1.Text = "__/__/____"
m_dig_dig_no.Text = ""
m_dig_typ1.BoundText = ""
m_res_cote.BoundText = ""
m_res_permit.BoundText = ""
M_DIG_TYP.Text = ""
m_word.Text = ""
m_res_prs.Text = ""
m_res_no.Text = ""
first_qst = 0
crit1 = ""
  CRIT = "create proc tmp_dmd_result as "




 
 CRIT = CRIT & "SELECT DISTINCT " & _
                   "dbo.result.res_no_ist, dbo.main.MN_ACT_TTL, dbo.CODING.SUB_DESC AS desc_cote, dbo.result.res_permit, CODING_1.SUB_DESC AS desc_permit, " & _
                      "dbo.result.res_no, dbo.result.res_ser, dbo.result.res_dig_no, dbo.result.res_typ, dbo.result.res_dte, dbo.result.res_user_no, dbo.result.res_prs," & _
                      "dbo.result.res_typ1, CODING_2.SUB_DESC AS desc_typ1 , dbo.result.res_subject " & _
" FROM         dbo.result INNER JOIN " & _
                      "dbo.main ON dbo.result.res_no_ist = dbo.main.MN_APP_NO left JOIN " & _
                      "dbo.CODING ON '32'+dbo.result.res_cote = dbo.CODING.SUB_CODE left JOIN " & _
                      "dbo.CODING CODING_1 ON '33'+dbo.result.res_permit = CODING_1.SUB_CODE left JOIN " & _
                      "dbo.CODING CODING_2 ON '24'+dbo.result.res_typ1 = CODING_2.SUB_CODE "




End Sub

Private Sub Command5_Click()

Frame2.Visible = True

End Sub

Private Sub Command6_Click()
If Not v_res_no.Text = "" Then
 If box_user_no = "244" Then

             sql = "execute del_result " & "'" & v_res_no.Text & "'"
                cn.Execute sql, rdExecDirect
                d_result.Refresh
  Frame2.Visible = False
  
  End If
End If
End Sub

Private Sub Command8_Click()
On Error Resume Next
jad_print = 6
 Screen.MousePointer = vbDefault
  Screen.MousePointer = vbHourglass
  form_report.WindowState = 2
  form_report.Show
  Screen.MousePointer = vbDefault
End Sub

Private Sub Command9_Click()
If Not v_res_no.Text = "" Then

             sql = "execute upd_result1 " & "'" & v_res_no.Text & "'" & "," _
             & "'" & v_res_prs.Text & "'" & "," _
        & "'" & Mid(v_res_cote.BoundText, 3, 2) & "'" & "," _
       & "'" & Mid(v_res_permit.BoundText, 3, 2) & "'" & "," _
             & "'" & v_res_subject.Text & "'"
                cn.Execute sql, rdExecDirect
                d_result.Refresh
  Frame2.Visible = False
  
  
End If

End Sub

Private Sub DataGrid1_AfterColUpdate(ByVal ColIndex As Integer)
'm_row = d_result.Recordset.Bookmark - 1
'd_result.Recordset.Move (m_row)
'd_result.Refresh
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
 
m_dig_dig_no.Text = ""
m_dig_typ1.BoundText = ""
m_res_cote.BoundText = ""
m_res_permit.BoundText = ""
M_DIG_TYP.Text = ""
m_word.Text = ""
m_res_prs.Text = ""
'M_RES_dte.Text = Format(Date, "dd/mm/yy")
first_qst = 0
crit1 = ""
 CRIT = "create proc tmp_dmd_result as "




 CRIT = CRIT & "SELECT DISTINCT " & _
                   "dbo.result.res_no_ist, dbo.main.MN_ACT_TTL, dbo.CODING.SUB_DESC AS desc_cote, dbo.result.res_permit, CODING_1.SUB_DESC AS desc_permit, " & _
                      "dbo.result.res_no, dbo.result.res_ser, dbo.result.res_dig_no, dbo.result.res_typ, dbo.result.res_dte, dbo.result.res_user_no, dbo.result.res_prs," & _
                      "dbo.result.res_typ1, CODING_2.SUB_DESC AS desc_typ1 , dbo.result.res_subject " & _
" FROM         dbo.result left JOIN " & _
                      "dbo.main ON dbo.result.res_no_ist = dbo.main.MN_APP_NO left JOIN " & _
                      "dbo.CODING ON '32'+dbo.result.res_cote = dbo.CODING.SUB_CODE left JOIN " & _
                      "dbo.CODING CODING_1 ON '33'+dbo.result.res_permit = CODING_1.SUB_CODE left JOIN " & _
                      "dbo.CODING CODING_2 ON '24'+dbo.result.res_typ1 = CODING_2.SUB_CODE "



End Sub

Private Sub m_dig_dig_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_dig_dig_no.Text = "" Then
  qst8 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     ' crit1 = crit1 & "dig_dig_no =  " & "'" & m_dig_dig_no.Text & "'"
         crit1 = crit1 & "RES_DIG_NO like " & "'" & "%" & m_dig_dig_no.Text & "%" & "'"
      m_dig_dig_no.Enabled = False
      Command1.SetFocus
      
End If

End Sub

Private Sub M_DIG_TYP_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not M_DIG_TYP.Text = "" Then
  qst9 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     ' crit1 = crit1 & "dig_dig_no =  " & "'" & m_dig_dig_no.Text & "'"
         crit1 = crit1 & "RES_typ like " & "'" & "%" & M_DIG_TYP.Text & "%" & "'"
     M_DIG_TYP.Enabled = False
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
      crit1 = crit1 & " RES_Typ1 = " & "'" & Mid(m_dig_typ1.BoundText, 3, 2) & "'"
        
      m_dig_typ1.Enabled = False
      Command1.SetFocus
End If

End Sub

Private Sub m_res_cote_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_res_cote.Text = "" Then
   qst5 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " RES_cote = " & "'" & Mid(m_res_cote.BoundText, 3, 2) & "'"
        
      m_res_cote.Enabled = False
      Command1.SetFocus
End If
End Sub

Private Sub M_res_dte_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then
 If Not M_res_dte.Text = "__/__/____" Then
  If IsDate(M_res_dte.Text) Then
     If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     
     m_dte1 = Format(M_res_dte.Text, "YYYY/MM/DD")
     crit1 = crit1 & "  RES_DTE >= " & "convert(datetime," & "'" & Format(m_dte1, "yyyy-mm-dd") & "'" & "," & "102)"
     qst1 = 1
   Else
    M_res_dte.SetFocus
   End If
 End If
  M_res_dte.Enabled = False
  
  
  M_res_dte1.SetFocus
End If
End Sub

Private Sub M_res_dte1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not M_res_dte1.Text = "__/__/____" Then
  If IsDate(M_res_dte1.Text) Then
    If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
    
   m_dte = M_res_dte1.Text
  crit1 = crit1 & "   RES_dte <= " & "convert(datetime," & "'" & Format(m_dte, "yyyy-mm-dd") & "'" & "," & "102)"
  M_res_dte1.Enabled = False
  qst2 = 1
  
  Command1.SetFocus
  
Else
  M_res_dte1.SetFocus
End If
  
End If

End Sub

Private Sub m_res_no_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_res_no.Text = "" Then
  qst11 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
     ' crit1 = crit1 & "dig_dig_no =  " & "'" & m_dig_dig_no.Text & "'"
         crit1 = crit1 & " res_no like " & "'" & "%" & m_res_no.Text & "%" & "'"
      m_res_no.Enabled = False
      Command1.SetFocus
      
End If

End Sub

Private Sub m_res_permit_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_res_permit.Text = "" Then
   qst6 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & " RES_PERMIT = " & "'" & Mid(m_res_permit.BoundText, 3, 2) & "'"
        
      m_res_permit.Enabled = False
      Command1.SetFocus
End If

End Sub

Private Sub m_res_prs_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 And Not m_res_prs.Text = "" Then
 qst7 = 1
      If first_qst = 0 Then
        crit1 = " where "
        first_qst = 1
      Else
       crit1 = crit1 & " and "
      End If
      crit1 = crit1 & "res_prs like " & "'" & "%" & m_res_prs.Text & "%" & "'"
      m_res_prs.Enabled = False
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
      crit1 = crit1 & "mn_act_ttl  like " & "'" & "%" & m_word.Text & "%" & "'"
      m_word.Enabled = False
      Command1.SetFocus
      
End If
End Sub

Private Sub v_res_cote_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 v_res_prs.SetFocus
 
End If

End Sub

Private Sub v_res_permit_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 v_res_cote.SetFocus
 SendKeys "{f4}"
 
End If

End Sub

Private Sub v_res_prs_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 v_res_subject.SetFocus
 
End If


End Sub

Private Sub v_res_subject_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 v_res_no.SetFocus
 
End If

End Sub
