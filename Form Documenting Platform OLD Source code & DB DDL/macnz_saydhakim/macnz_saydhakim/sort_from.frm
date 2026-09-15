VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form sort_form 
   BackColor       =   &H00808080&
   Caption         =   "main_form"
   ClientHeight    =   9630
   ClientLeft      =   270
   ClientTop       =   540
   ClientWidth     =   19875
   ForeColor       =   &H80000001&
   LinkTopic       =   "Form1"
   Moveable        =   0   'False
   ScaleHeight     =   9630
   ScaleWidth      =   19875
   ShowInTaskbar   =   0   'False
   WindowState     =   2  'Maximized
   Begin VB.CommandButton Command3 
      Caption         =   " ⁄·Ì„ ÕﬁÊ· «·⁄—÷"
      Height          =   495
      Left            =   7320
      TabIndex        =   26
      Top             =   2520
      Width           =   1695
   End
   Begin MSDataListLib.DataCombo M_OUT_CAT 
      Bindings        =   "sort_from.frx":0000
      Height          =   315
      Left            =   9120
      TabIndex        =   25
      Top             =   2640
      Width           =   2775
      _ExtentX        =   4895
      _ExtentY        =   556
      _Version        =   393216
      BackColor       =   -2147483626
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
   End
   Begin VB.OptionButton Option2 
      BackColor       =   &H00808080&
      Caption         =   "»ÕÀ »ﬂ·„… „⁄Ì‰… F9"
      Height          =   375
      Left            =   16080
      TabIndex        =   24
      Top             =   2520
      Width           =   1575
   End
   Begin VB.OptionButton Option1 
      BackColor       =   &H00808080&
      Caption         =   "»ÕÀ »«·»œ«Ì… F8"
      Height          =   375
      Left            =   18120
      TabIndex        =   23
      Top             =   2520
      Width           =   1215
   End
   Begin MSRDC.MSRDC BNKOUT2 
      Height          =   330
      Left            =   7920
      Top             =   9000
      Visible         =   0   'False
      Width           =   3000
      _ExtentX        =   5292
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
      RecordSource    =   "SELECT * FROM VIEW_BNKOUT1"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "BNKOUT2"
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
      Bindings        =   "sort_from.frx":001C
      Height          =   4935
      Left            =   6000
      TabIndex        =   21
      Top             =   3360
      Width           =   5895
      _ExtentX        =   10398
      _ExtentY        =   8705
      _Version        =   393216
      BackColor       =   12632256
      ListField       =   "out_name1"
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   15.75
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.TextBox searcher 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0C0C0&
      Height          =   405
      Left            =   480
      RightToLeft     =   -1  'True
      TabIndex        =   4
      Top             =   2520
      Visible         =   0   'False
      Width           =   4935
   End
   Begin MSDBCtls.DBList c_getcond 
      Bindings        =   "sort_from.frx":0032
      DataSource      =   "data2"
      Height          =   3360
      Left            =   480
      TabIndex        =   3
      Top             =   3360
      Width           =   4935
      _ExtentX        =   8705
      _ExtentY        =   5927
      _Version        =   393216
      BackColor       =   12632256
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   14.25
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSRDC.MSRDC result 
      Height          =   330
      Left            =   1920
      Top             =   9000
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
      RecordSource    =   ""
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "result"
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
   Begin MSRDC.MSRDC bnkout1 
      Height          =   330
      Left            =   5640
      Top             =   9000
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
   Begin VB.ComboBox c_operation 
      BackColor       =   &H80000016&
      Height          =   315
      ItemData        =   "sort_from.frx":0046
      Left            =   7320
      List            =   "sort_from.frx":0056
      TabIndex        =   2
      Top             =   2040
      Width           =   2535
   End
   Begin MSRDC.MSRDC data2 
      Height          =   330
      Left            =   3840
      Top             =   9120
      Visible         =   0   'False
      Width           =   1695
      _ExtentX        =   2990
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
      RecordSource    =   ""
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "data2"
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
      Bindings        =   "sort_from.frx":0067
      DataSource      =   "bnkout"
      Height          =   4935
      Left            =   13200
      TabIndex        =   1
      Top             =   3360
      Width           =   6135
      _ExtentX        =   10821
      _ExtentY        =   8705
      _Version        =   393216
      BackColor       =   12632256
      ListField       =   "OUT_COND"
      RightToLeft     =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arabic Transparent"
         Size            =   15.75
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.ComboBox cb_serh 
      Height          =   315
      ItemData        =   "sort_from.frx":007C
      Left            =   8400
      List            =   "sort_from.frx":0086
      TabIndex        =   20
      Top             =   2040
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.TextBox x_cond1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0C0C0&
      Height          =   285
      Left            =   480
      RightToLeft     =   -1  'True
      TabIndex        =   19
      Top             =   2640
      Visible         =   0   'False
      Width           =   4935
   End
   Begin VB.CommandButton Command1 
      Caption         =   "«€·«ﬁ"
      Height          =   975
      Left            =   720
      TabIndex        =   13
      Top             =   7200
      Width           =   1815
   End
   Begin VB.CommandButton cmd_result 
      Caption         =   "‰ «∆‹‹‹Ã «·»Õ‹À"
      Height          =   975
      Left            =   3360
      TabIndex        =   7
      Top             =   7200
      Width           =   1935
   End
   Begin VB.CommandButton x_or 
      BackColor       =   &H00808000&
      Caption         =   "«Ê"
      Height          =   375
      Left            =   18240
      TabIndex        =   12
      Top             =   1920
      Width           =   1215
   End
   Begin VB.TextBox x_criteria 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00808000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   975
      Left            =   600
      MultiLine       =   -1  'True
      RightToLeft     =   -1  'True
      TabIndex        =   5
      Top             =   600
      Width           =   18855
   End
   Begin VB.CommandButton x_and 
      Caption         =   "Ê"
      Height          =   375
      Left            =   16560
      TabIndex        =   6
      Top             =   1920
      Width           =   1335
   End
   Begin VB.CommandButton x_right 
      Caption         =   ")"
      Height          =   375
      Left            =   14880
      TabIndex        =   11
      Top             =   1920
      Width           =   1455
   End
   Begin VB.CommandButton x_left 
      Caption         =   "("
      Height          =   375
      Left            =   13200
      TabIndex        =   10
      Top             =   1920
      Width           =   1455
   End
   Begin VB.CommandButton x_del 
      Caption         =   "«·€«¡"
      Height          =   375
      Left            =   4080
      TabIndex        =   9
      Top             =   1920
      Width           =   1335
   End
   Begin VB.CommandButton x_add 
      Caption         =   "«÷«›…"
      Height          =   375
      Left            =   720
      TabIndex        =   8
      Top             =   1920
      Width           =   1215
   End
   Begin VB.TextBox x_getcond 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00C0C0C0&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   480
      TabIndex        =   0
      Top             =   2640
      Visible         =   0   'False
      Width           =   4935
   End
   Begin VB.Data Data4 
      Caption         =   "Data4"
      Connect         =   "Access"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   420
      Left            =   0
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   "BNKOUT"
      Top             =   9000
      Visible         =   0   'False
      Width           =   2775
   End
   Begin MSRDC.MSRDC bnkout 
      Height          =   330
      Left            =   360
      Top             =   8880
      Visible         =   0   'False
      Width           =   1695
      _ExtentX        =   2990
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
      RecordSource    =   "select * from bnkout where out_if = 1 oder by out_indx3"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "bnkout"
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
   Begin MSAdodcLib.Adodc VIEW_CODING37 
      Height          =   330
      Left            =   10800
      Top             =   9000
      Visible         =   0   'False
      Width           =   3615
      _ExtentX        =   6376
      _ExtentY        =   582
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
      UserName        =   ""
      Password        =   ""
      RecordSource    =   "select * from VIEW_coding37"
      Caption         =   "f_tmp"
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
   Begin MSAdodcLib.Adodc f_cat 
      Height          =   330
      Left            =   10320
      Top             =   9000
      Visible         =   0   'False
      Width           =   3615
      _ExtentX        =   6376
      _ExtentY        =   582
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
      UserName        =   ""
      Password        =   ""
      RecordSource    =   "select view_catog.* from view_catog"
      Caption         =   "f_cat"
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
   Begin VB.Label Label6 
      Alignment       =   2  'Center
      BackColor       =   &H00808000&
      Caption         =   "·Ê«∆Õ ·ÕﬁÊ· «·⁄—÷"
      Height          =   255
      Left            =   10200
      TabIndex        =   27
      Top             =   2400
      Width           =   1695
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H00808000&
      Caption         =   "ÕﬁÊ· «·⁄—÷ ›Ì «·ÃœÊ·"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   8040
      TabIndex        =   22
      Top             =   3000
      Width           =   2415
   End
   Begin VB.Label Label7 
      Alignment       =   2  'Center
      BackColor       =   &H00808000&
      Caption         =   "»—‰«„Ã «·«” —Ã«⁄ ·ﬁÊ«⁄œ «·»Ì«‰« "
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   18
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   7800
      TabIndex        =   18
      Top             =   0
      Width           =   4695
   End
   Begin VB.Shape Shape7 
      Height          =   9015
      Left            =   -4680
      Shape           =   4  'Rounded Rectangle
      Top             =   0
      Width           =   24975
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      BackColor       =   &H00808000&
      Caption         =   "«·«œÊ« "
      Height          =   255
      Left            =   8520
      TabIndex        =   17
      Top             =   1800
      Width           =   855
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BackColor       =   &H00808000&
      Caption         =   "«Œ Ì«— «·«ÃÊ»…"
      Height          =   255
      Left            =   2040
      TabIndex        =   16
      Top             =   2280
      Width           =   1095
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H00808000&
      Caption         =   "„œŒ· «·»ÕÀ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   15600
      TabIndex        =   15
      Top             =   3000
      Width           =   1815
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H00808000&
      Caption         =   "«·«”∆‹‹‹·… «·„ —«ﬂ„‹‹‹‹‹‹…"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   16680
      TabIndex        =   14
      Top             =   0
      Width           =   2775
   End
   Begin VB.Shape Shape5 
      Height          =   1215
      Left            =   480
      Shape           =   4  'Rounded Rectangle
      Top             =   480
      Width           =   19095
   End
   Begin VB.Shape Shape4 
      Height          =   5655
      Left            =   5880
      Shape           =   4  'Rounded Rectangle
      Top             =   3000
      Width           =   13815
   End
   Begin VB.Shape Shape3 
      Height          =   5415
      Left            =   360
      Shape           =   4  'Rounded Rectangle
      Top             =   3120
      Width           =   5175
   End
   Begin VB.Shape Shape2 
      Height          =   495
      Left            =   360
      Shape           =   4  'Rounded Rectangle
      Top             =   2520
      Width           =   19215
   End
   Begin VB.Shape Shape1 
      Height          =   615
      Left            =   600
      Shape           =   4  'Rounded Rectangle
      Top             =   1800
      Width           =   18975
   End
End
Attribute VB_Name = "sort_form"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
 Public M_SCR_NAME As String, M_CRITERIA As String, M_PRINT As Variant, crit_new As String
 Dim dyn_arr()
 Public count1 As Variant
 Public count_rel As Variant
 Public count_slct1 As Variant
 Dim arr_table(20) As Variant
 Dim arr_table1(20) As Variant
 Dim arr_tbl(20) As Variant
 Dim arr_tbl1(20) As Variant
 Dim arr_fld_rel(20) As Variant
 'Public m_crit1 As Variant
 Public m_list_len As Variant
 Public m_nb_fldout As Integer
 Dim arr_rel1(20) As Variant
 Dim arr_rel2(20) As Variant
 Dim arr_relition(20) As Variant
 Dim arr_reltbl(20) As Variant
 Dim arr_reltblm(20) As Variant
 Dim arr_relition1(20) As Variant
 Dim arr_reltbl1(20) As Variant
 Dim arr_ind1(20) As Integer
 Dim arr_indic(20) As Integer
 Dim arr_ind2(20) As Integer
 Public count2, v_get, v_view As Variant
 Public tm_criteria As String
 Public v_bookmark1, v_bookmark2, nb_ad, nb_or, nb_and As Variant
 Public count3 As Variant
 Dim m_key_serh As Integer
 Public count_relm As Integer
 Dim var_ist As String
 
  
 
 



Private Sub c_listfields_Click(Area As Integer)
     
   Dim posit, posit1, L, l1 As Integer
   Dim str1, str2, d_type, d_query, d_view, d_view1, d_get, d_get1, d_get2, d_cond, d_table As Variant
   Dim CRIT, crit1, crit11, crit2, crit3 As String
   Dim mydate As Variant
   x_getcond = " "
        
    bnkout.Resultset.Bookmark = c_listfields.SelectedItem
    

    v_bookmark1 = bnkout.Resultset![out_num]
 If bnkout.Resultset![out_nature] = "1" Or bnkout.Resultset![out_nature] = "8" Then
 '  x_getcond.Text = ""
   x_getcond.Visible = True
   c_getcond.Visible = False
   x_cond1.Visible = False
   [cb_serh].Visible = False
 
 
 ElseIf bnkout.Resultset![out_nature] = "3" Then
  ' mydate = Date
  x_getcond = Date
  'Format(mydate, "  /  /  ")
  
  x_getcond.Visible = True
  c_getcond.Visible = False
  x_cond1.Visible = False
  [cb_serh].Visible = False
 ElseIf bnkout.Resultset![out_nature] = "2" Or bnkout.Resultset![out_nature] = "9" Then
  x_getcond.Visible = False
   c_getcond.Visible = True
   x_cond1.Visible = False
   c_operation.Visible = True
  [cb_serh].Visible = False

    d_type = bnkout.Resultset![out_nature]
    d_query = bnkout.Resultset![out_slct1]
    d_view = bnkout.Resultset![out_namcod]
    d_get = bnkout.Resultset![out_cod]
    d_cond = bnkout.Resultset![out_cond1]
   d_table = bnkout.Resultset![out_slct1]
   
   crit1 = " SELECT DISTINCTROW " & d_view
   crit11 = "," & d_get
   crit2 = " FROM " & d_query
   crit3 = " WHERE " & d_cond
   crit4 = " order by " & d_view
   
   If Trim$(d_cond) <> "1 = 1" Then
   CRIT = crit1 & crit11 & crit2 & crit3 & crit4
   Else
   CRIT = crit1 & crit11 & crit2 & crit4
   End If
  
  data2.sql = CRIT
  data2.Refresh

    posit = InStr(1, d_view, "[")
    L = Len(d_view)
    d_view1 = Mid$(d_view, posit + 1, L - (posit + 1))
  
  posit1 = InStr(1, d_get, "field1")
 
  If posit1 <> 0 Then
  d_get1 = Mid(d_get, posit1, 6)
 
  Else
  
   posit = InStr(1, d_get, "[")
   L = Len(d_get)
   d_get1 = Mid$(d_get, posit + 1, L - (posit + 1))
   End If
   
   v_get = d_get1
   v_view = d_view1
   c_getcond.ListField = v_view
   c_getcond.BoundColumn = v_get
  
' ElseIf bnkout.resultset![out_nature] = "6" Then
'   MsgBox "we enter "
'  ElseIf bnkout.resultset![out_nature] = "6" Then
'     [x_getcond].Visible = False
'     [c_getcond].Visible = False
'     [x_cond1].Visible = True
'     [cb_serh].Visible = True
  
ElseIf bnkout.Resultset![out_nature] = "6" Then
   [cb_serh].Visible = True
    c_operation = "= "
    
      
End If




txt_display.Visible = False


End Sub

Private Sub c_listfields_LostFocus()
txt_display.Visible = False
End Sub

Private Sub c_listfields_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
  bnkout.Resultset.Bookmark = c_listfields.SelectedItem
  txt_display.Visible = True
  txt_display.Text = IIf(IsNull(bnkout.Resultset![out_display]), "hh", bnkout.Resultset![out_display])

End Sub

Private Sub c_listfields_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
  bnkout.Resultset.Bookmark = c_listfields.SelectedItem
  txt_display.Visible = True
  txt_display.Text = IIf(IsNull(bnkout.Resultset![out_display]), "hh", bnkout.Resultset![out_display])

End Sub

Private Sub c_listfields_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
  
  bnkout.Resultset.Bookmark = c_listfields.SelectedItem
  txt_display.Visible = True
  txt_display.Text = IIf(IsNull(bnkout.Resultset![out_display]), "hh", bnkout.Resultset![out_display])

End Sub



Private Sub c_getcond_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF8 Then
   bnkout.Resultset.Bookmark = DBList3.SelectedItem
 If RTrim(bnkout.Resultset![out_slct1]) = "form" Or RTrim(bnkout.Resultset![out_slct1]) = "macnz" _
Or RTrim(bnkout.Resultset![out_slct1]) = "view_form1" Or RTrim(bnkout.Resultset![out_slct1]) = "main" Or RTrim(bnkout.Resultset![out_slct1]) = "auther" Or RTrim(bnkout.Resultset![out_slct1]) = "period" Then
     x_getcond.Visible = False
     x_cond1.Visible = False
     searcher.Visible = True
     m_key_serh = 1
     searcher.SetFocus
   End If
 ElseIf KeyCode = vbKeyF9 Then
 If RTrim(bnkout.Resultset![out_slct1]) = "form" Or RTrim(bnkout.Resultset![out_slct1]) = "macnz" Or RTrim(bnkout.Resultset![out_slct1]) = "view_form" _
   Or RTrim(bnkout.Resultset![out_slct1]) = "view_form1" Or RTrim(bnkout.Resultset![out_slct1]) = "main" Or RTrim(bnkout.Resultset![out_slct1]) = "auther" _
   Or RTrim(bnkout.Resultset![out_slct1]) = "period" Then
     x_getcond.Visible = False
     x_cond1.Visible = False
     searcher.Visible = True
     m_key_serh = 2
     searcher.SetFocus
   End If

 End If
End Sub

Private Sub c_getcond_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  Call add_question
End If
End Sub

Private Sub cb_serh_Click()
'MsgBox [cb_serh].ListIndex
'   Dim cn As New rdoConnection
   Dim sql As String
   Dim qd As rdoQuery
   Dim sql_query As String


If [cb_serh].ListIndex = 0 Then

     [x_getcond].Visible = False
     [c_getcond].Visible = False
     [x_cond1].Visible = True
     [cb_serh].Visible = True

Else
  x_getcond.Visible = False
   c_getcond.Visible = True
   x_cond1.Visible = False
   [cb_serh].Visible = True
    d_type = bnkout.Resultset![out_nature]
    d_query = bnkout.Resultset![out_slct1]
    d_view = bnkout.Resultset![out_namcod]
    d_get = bnkout.Resultset![out_cod]
    d_cond = bnkout.Resultset![out_cond1]
    d_table = bnkout.Resultset![out_slct1]
    'MsgBox "d_view=" & d_view
   ' MsgBox "d_get=" & d_get
  '  MsgBox "d_cond=" & d_cond
 '   MsgBox "d_query=" & d_query
   
   crit1 = " SELECT " & d_view
   crit11 = "," & d_get
   crit2 = " FROM " & d_query
   crit3 = " WHERE " & d_cond
   crit4 = " order by " & d_view
   
   If Trim$(d_cond) <> "1 = 1" Then
      'MsgBox "we enter"
   CRIT = crit1 & crit11 & crit2 & crit3 & crit4
   Else
   CRIT = crit1 & crit11 & crit2 & crit4
   End If
               
'             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'            cn.EstablishConnection rdDriverNoPrompt
            'cn.Execute SQL, rdExecDirect
            
   Set qd = cn.CreateQuery("view_abb", CRIT)
   data2.sql = qd.sql
   data2.Refresh

'  MsgBox "crit = " & crit

'If Not IsEmpty(d_view) And Not IsNull(d_view) And Not d_view = "" Then
    posit = InStr(1, d_view, "[")
    L = Len(d_view)
    d_view1 = Mid$(d_view, posit + 1, L - (posit + 1))
  
  posit1 = InStr(1, d_get, "field1")
  
  If posit1 <> 0 Then
  d_get1 = Mid(d_get, posit1, 6)
  
  Else
  
   posit = InStr(1, d_get, "[")
   L = Len(d_get)
   d_get1 = Mid$(d_get, posit + 1, L - (posit + 1))
   End If
   
   v_get = d_get1
   v_view = d_view1
'MsgBox "v_view = " & v_view
'MsgBox "v_get =" & v_get
   c_getcond.ListField = v_view
   c_getcond.BoundColumn = v_get
'  End If
  

End If

End Sub

Private Sub cmd_result_Click()
If nb_ad > 0 Then

Screen.MousePointer = vbHourglass
On Error Resume Next

Dim CRIT As Variant
Dim MyRecordSource As String
Dim datax As Integer, datay As Integer, LabelX As Integer, LabelY As Integer
Dim MyForm As String, MyFormCreate As Form, MyLabel As Control, MYCONTROL As Control, cnt_nam As Control, disp_form As Form
Dim f_field As Field
Dim lg2 As Variant
Dim m_out_len, m_out_num, m_out_slct1, m_out_rel, m_out_field, m_out_select, m_out_slct, m_out_nature As Variant
Dim m_out_fld, m_out_len1, m_out_indx1, m_out_cod, m_out_choice, m_out_vcod, m_out_desc, m_out_namcod, m_out_name As Variant
Dim m_slct_fld, m_out_typ, m_list_len, m_nb_fldout As Variant
Dim fin_innerjoin, db_acolad, tm_innerjoin As String
Dim lg1, i, j, k As Integer
Dim sql As String
Dim qd As rdoQuery
Dim sql_query As String
 

    count_slct1 = 0
    fin_innerjoin = ")"
     db_acolad = ""
    lg2 = 1
'  If Not MYTAB.NoMatch Then
     bnkout1.Resultset.MoveFirst
    While Not bnkout1.Resultset.EOF
      If bnkout1.Resultset![user_out_choice] = 1 Then
      m_out_rel = bnkout1.Resultset![out_rel]
      m_out_select = bnkout1.Resultset![out_select]
      m_out_nature = bnkout1.Resultset![out_nature]
      m_out_slct1 = bnkout1.Resultset![out_slct1]
      m_out_cod = bnkout1.Resultset![out_cod]
      m_out_namcod = bnkout1.Resultset![out_namcod]
      m_out_desc = bnkout1.Resultset![OUT_desc]
      m_out_fld = bnkout1.Resultset![out_scond1]
      m_out_fld1 = bnkout1.Resultset![out_indx1]
      m_out_scond = bnkout1.Resultset![OUT_scond]
      m_out_scond0 = bnkout1.Resultset![OUT_scond0]
      
      If Not bnkout1.Resultset![out_RCRN] = "2" Then
      
        lg1 = 1
                lg2 = 1
        lg3 = 1
        If count1 > 0 Then
            i = 1
              While i < count1 + 1 And lg1 = 1
                  If arr_table(i) = m_out_select Then
                     lg1 = 0
                  End If
                  i = i + 1
                 If lg1 <> 0 Then
                    For L = 1 To count_slct1
                     If arr_reltbl(L) = m_out_select Then
                        lg1 = 0
                      End If
                    Next
              End If
              Wend
        End If
    
      If lg1 = 1 Then
             count1 = count1 + 1
             arr_table1(count1) = m_out_select
             arr_table(count1) = m_out_select
             arr_fld_rel(count1) = m_out_rel
      End If
       '***********************************************************
      '**********************************************************
    Else
        lg1 = 1
                lg2 = 1
        lg3 = 1
 
   If count1 > 0 Then
     i = 1
   While i < count1 + 1 And lg1 = 1
        If arr_table(i) = bnkout1.Resultset![out_select] Then
              lg1 = 0
          End If

          i = i + 1
        Wend
    End If
        If lg1 = 1 And bnkout1.Resultset![out_RCRN] = "2" Then
        
           count1 = count1 + 1
           arr_table1(count1) = bnkout1.Resultset![out_select]
           arr_table(count1) = bnkout1.Resultset![out_select]
           arr_fld_rel(count1) = bnkout1.Resultset![out_rel]
            If lg1 = 0 Then
                arr_table1(count1) = arr_table(count1) & " as " & arr_table(count1) & "_" & Trim(Str(count1))
                arr_table(count1) = arr_table(count1) & "_" & Trim(Str(count1))
              End If

           If Not IsEmpty(bnkout1.Resultset![out_REL1]) And Not IsNull(bnkout1.Resultset![out_REL1]) And Not bnkout1.Resultset![out_REL1] = "" Then
              count2 = count2 + 1
              arr_rel1(count2) = bnkout1.Resultset![out_REL1]
              arr_ind1(count2) = count1
              arr_tbl(count2) = bnkout1.Resultset![out_select]
              If lg1 = 0 Then
                  arr_tbl(count2) = arr_table(count1)
              End If
              
           End If
           If Not IsEmpty(bnkout1.Resultset![out_REL2]) And Not IsNull(bnkout1.Resultset![out_REL2]) And Not bnkout1.Resultset![out_REL2] = "" Then
              count3 = count3 + 1
              arr_rel2(count3) = bnkout1.Resultset![out_REL2]
              arr_ind2(count3) = count1
              arr_tbl1(count3) = bnkout1.Resultset![out_select]
              If lg1 = 0 Then
                  arr_tbl1(count3) = arr_table(count1)
              End If
              
        End If
       End If
       
       
        
      End If

      '****************************************************
      '************************************************************************************************************
    
      
      
         If m_out_nature = 2 Then
            For L = 1 To count_slct1
               If arr_reltbl(L) = m_out_slct1 Then
                   lg2 = 0
                   lg3 = 0
              End If
             Next
            For L = 1 To count1
               If arr_table(L) = m_out_slct1 Then
                   lg2 = 0
              End If
             Next
             For L = 1 To count_rel
                If arr_reltbl(L) = m_out_slct1 Then
                  lg2 = 0
                 End If
             Next L
     If lg2 = 1 Then
         count_slct1 = count_slct1 + 1
         arr_reltbl(count_slct1) = m_out_slct1
         db_acolad = db_acolad & "("
         fin_innerjoin = fin_innerjoin & " left  join " & m_out_slct1 & " on " & m_out_fld & ")"
      End If
      If lg3 = 0 Then
          count_slct1 = count_slct1 + 1
         arr_reltbl(count_slct1) = m_out_slct1
         db_acolad = db_acolad & "("
         m_reltbl = m_out_slct1 & "_" & Trim(Str(count_slct1))
         m_tmp_join = m_out_slct1 & " as " & m_out_slct1 & "_" & Trim(Str(count_slct1)) & _
                 " on " & m_out_scond0 & " = " & m_reltbl & ".[" & m_out_fld1 & "]" & ")"
         fin_innerjoin = fin_innerjoin & " left join " & m_tmp_join
         bnkout1.Resultset.Edit
         bnkout1.Resultset![out_indx12] = count_slct1
         bnkout1.Resultset.Update
      End If
      End If
'      End If
      
   End If
       bnkout1.Resultset.MoveNext
    Wend
    
  If count_relm > 0 Then
    For L = 1 To count_relm
      db_acolad = db_acolad & "("
      If arr_indic(L) = 1 Then
        m_tmp_join1 = arr_reltblm(L) & " on " & arr_reltblm(L) & ".[" & arr_relition(L) & "] = " & arr_reltbl1(L) & ".[" & arr_relition1(L) & "]" & ")"
     Else
        m_tmp_join1 = Mid(arr_reltblm(L), 1, Len(Trim(arr_reltblm(L))) - 2) & " as " & arr_reltblm(L) & " on " & arr_reltblm(L) & ".[" & arr_relition(L) & "] = " & _
                      arr_reltbl1(L) & ".[" & arr_relition1(L) & "]" & ")"
      End If
      fin_innerjoin = fin_innerjoin & " left join " & m_tmp_join1
      
    Next
 End If
  fin_innerjoin = Mid$(fin_innerjoin, 1, Len(fin_innerjoin) - 1)


'*****************************
'***************************************************************************************************
 j = 1
 k = 1
 If count1 > 1 Then
      tm_innerjoin = tm_innerjoin & arr_table1(1) & " LEFT JOIN " & arr_table1(2) & " on " & "(" & arr_table(1) & ".[" & arr_fld_rel(1) & "]" & " = " & arr_table(2) & ".[" & arr_fld_rel(2) & "]" & ")" & ")"
       
       If arr_ind1(j) = 1 Then
         j = j + 1
         End If
          If arr_ind1(j) = 2 And arr_ind1(j) <> 0 Then
            If j > 1 Then
             tm_innerjoin = Mid$(tm_innerjoin, 1, Len(tm_innerjoin) - 1)
               tm_innerjoin = tm_innerjoin & " and " & " (" & arr_tbl(1) & ".[" & arr_rel1(1) & "]" & " = " & arr_tbl(2) & ".[" & arr_rel1(2) & "]" & ")" & ")"
            End If
              j = j + 1
           End If
           If arr_ind2(k) = 1 Then
             k = k + 1
            End If
          If arr_ind2(k) = 2 And arr_ind2(k) <> 0 Then
             If k > 1 Then
              tm_innerjoin = Mid$(tm_innerjoin, 1, Len(tm_innerjoin) - 1)
              tm_innerjoin = tm_innerjoin & " and " & " (" & arr_tbl(1) & ".[" & arr_rel2(1) & "]" & " = " & arr_tbl(2) & ".[" & arr_rel2(2) & "]" & ")" & ")"
              End If
              k = k + 1
           End If

   For i = 2 To count1 - 1

   ' If Trim(arr_table1(i + 1)) = "res" Then
   '   tm_innerjoin = "(" & tm_innerjoin & " left join " & arr_table1(i + 1) & " on " & "(" & arr_table(i) & ".[" & arr_fld_rel(i) & "]" & " = " & arr_table(i + 1) & ".[" & arr_fld_rel(i + 1) & "]" & ")" & ")"
   ' Else
     tm_innerjoin = "(" & tm_innerjoin & " left join " & arr_table1(i + 1) & " on " & "(" & arr_table(i) & ".[" & arr_fld_rel(i) & "]" & " = " & arr_table(i + 1) & ".[" & arr_fld_rel(i + 1) & "]" & ")" & ")"
   ' End If
      If count2 > 1 And arr_ind1(j) = i + 1 And arr_ind1(j) <> 0 Then
        If j > 1 Then
          tm_innerjoin = Mid$(tm_innerjoin, 1, Len(tm_innerjoin) - 1)
           tm_innerjoin = tm_innerjoin & " and " & " (" & arr_tbl(j - 1) & ".[" & arr_rel1(j - 1) & "]" & " = " & arr_tbl(j) & ".[" & arr_rel1(j) & "]" & ")" & ")"
        End If
         j = j + 1
      End If
      If count3 > 1 And arr_ind2(k) = i + 1 And arr_ind2(k) <> 0 Then
        If k > 1 Then
            tm_innerjoin = Mid$(tm_innerjoin, 1, Len(tm_innerjoin) - 1)
            tm_innerjoin = tm_innerjoin & " and " & " (" & arr_tbl1(k - 1) & ".[" & arr_rel2(k - 1) & "]" & " = " & arr_tbl1(k) & ".[" & arr_rel2(k) & "]" & ")" & ")"
         End If
         k = k + 1
      End If
   Next
     tm_innerjoin = Mid$(tm_innerjoin, 1, Len(tm_innerjoin) - 1)
    tm_innerjoin = db_acolad & tm_innerjoin & fin_innerjoin
       
Else
  tm_innerjoin = arr_table(1)
  tm_innerjoin = tm_innerjoin & Mid(fin_innerjoin, 2, Len(fin_innerjoin) - 1)
  tm_innerjoin = Mid(db_acolad, 2, Len(db_acolad) - 1) & tm_innerjoin

 End If

'************************************************************************************


 '  MYTAB.Index = "user_out_choice"
 '  MYTAB.Seek "=", 1
   m_slct_fld = ""
   m_slct_fld1 = ""
   m_list_len = ""
   m_nb_fldout = 0
  lg = 1
 '  If Not MYTAB.NoMatch Then
     bnkout1.Resultset.MoveFirst
       While Not bnkout1.Resultset.EOF
           If bnkout1.Resultset![user_out_choice] = 1 Then
            lg = 2
             m_nb_fldout = m_nb_fldout + 1
             m_out_fld = bnkout1.Resultset![OUT_scond]
             m_out_slct = bnkout1.Resultset![out_select]
             m_out_len = bnkout1.Resultset![out_len]
             m_out_nature = bnkout1.Resultset![out_nature]
             m_out_slct1 = bnkout1.Resultset![out_slct1]
             m_out_cod = bnkout1.Resultset![out_cod]
             m_out_namcod = bnkout1.Resultset![out_namcod]
             m_out_desc = bnkout1.Resultset![OUT_desc]
             m_out_name = bnkout1.Resultset![OUT_name]
             m_out_indx12 = bnkout1.Resultset![out_indx12]
            m_out_namcod1 = bnkout1.Resultset![out_namcod1]

             m_list_len = m_list_len & Str(m_out_len) & "cm;"
             If m_out_nature = 2 Then
                If m_out_indx12 = 0 Then
                    m_slct_fld = m_slct_fld & m_out_namcod & " as " & "[" & m_out_name & "]" & ", "
                    m_slct_fld1 = m_slct_fld1 & m_out_namcod & " as " & "[" & LTrim(m_out_desc) & "]" & ", "
                 Else
                   m_slct_fld = m_slct_fld & m_out_slct1 & "_" & Trim(Str(m_out_indx12)) & ".[" & m_out_namcod1 & "]" & " as " & "[" & m_out_name & "]" & ", "
                   m_slct_fld1 = m_slct_fld1 & m_out_slct1 & "_" & Trim(Str(m_out_indx12)) & ".[" & m_out_namcod1 & "]" & " as " & "[" & m_out_desc & "]" & ", "
                   bnkout1.Resultset.Edit
                   bnkout1.Resultset![out_indx12] = 0
                    bnkout1.Resultset.Update
                                     
                 End If
             Else
                m_slct_fld = m_slct_fld & m_out_fld & " as " & "[" & m_out_name & "]" & ", "
                m_slct_fld1 = m_slct_fld1 & m_out_fld & " as " & "[" & LTrim(m_out_desc) & "]" & ", "
             End If
        End If
          bnkout1.Resultset.MoveNext
          
       Wend
       If lg = 2 Then
         m_slct_fld = Mid$(m_slct_fld, 1, (Len(m_slct_fld) - 2))
          m_slct_fld1 = Mid$(m_slct_fld1, 1, (Len(m_slct_fld1) - 2))
         m_slct_fld = "select distinct " & m_slct_fld
         m_slct_fld1 = "select distinct " & m_slct_fld1
          
       End If

     
m_crit1 = m_slct_fld & " from " & tm_innerjoin & " where " & tm_criteria
m_crit2 = m_slct_fld1 & " from " & tm_innerjoin & " where " & tm_criteria

'''''''''
 ' MYTAB.Index = "out_chio1"
 '  MYTAB.Seek "=", 1
   m_indx_fld = ""
   lg = 1
 '  If Not MYTAB.NoMatch Then
 bnkout1.Resultset.MoveFirst
 
       While Not bnkout1.Resultset.EOF
         If bnkout1.Resultset![user_out_choi1] = 1 Then
             lg = 2
             m_out_nature = bnkout1.Resultset![out_nature]
             m_out_namcod = bnkout1.Resultset![out_namcod]
             m_out_fld = bnkout1.Resultset![OUT_scond]
             If m_out_nature = 2 Then
                 m_indx_fld = m_indx_fld & m_out_namcod & ", "
             Else
                m_indx_fld = m_indx_fld & m_out_fld & ", "
             End If
          End If
              bnkout1.Resultset.MoveNext
       Wend
       If lg = 2 Then
          m_indx_fld = Mid$(m_indx_fld, 1, (Len(m_indx_fld) - 2))
          m_indx_fld = "order by " & m_indx_fld
        End If
        
        
        
        'MsgBox "indx = " & m_indx_fld
   'End If
'Me![m_crit1] = m_slct_fld & tm_innerjoin & " where " & tm_criteria

CRIT = m_crit1
CRIT = m_crit1 & m_indx_fld & ";"
p_crit = m_crit2 & m_indx_fld & ";"
''''''''''
'p_crit = CRIT


'MsgBox "crit = " & CRIT


If main_form = 1 Then
        sql = "drop proc tmp_result"
            cn.Execute sql, rdExecDirect
        CRIT = "create proc tmp_result as " & CRIT
               cn.Execute CRIT, rdExecDirect
            
'      Set qd = cn.CreateQueryDef("view_abb1", "{call tmp_result()}")


ElseIf main_form = 2 Then
'             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'            cn.EstablishConnection rdDriverNoPrompt
        sql = "drop proc tmp_result1"
            cn.Execute sql, rdExecDirect
'   MsgBox "delete proc "
        CRIT = "create proc tmp_result1 as " & CRIT
               cn.Execute CRIT, rdExecDirect
            
      Set qd = cn.CreateQueryDef("view_abb1", "{call tmp_result1()}")
'     result.SQL = qd.SQL
'    result.Refresh

'Set q1 = mydb.CreateQueryDef("result", crit)



'*****************************************


'DoCmd.DeleteObject A_FORM, "form1"



' Screen.MousePointer = vbDefault
'
       
' Screen.MousePointer = vbHourglass
'
' Form8.WindowState = 2
' Form8.Show
' Screen.MousePointer = vbDefault
'
ElseIf main_form = 3 Then
'             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'            cn.EstablishConnection rdDriverNoPrompt
        sql = "drop proc tmp_result2"
            cn.Execute sql, rdExecDirect
'   MsgBox "delete proc "
        CRIT = "create proc tmp_result2 as " & CRIT
               cn.Execute CRIT, rdExecDirect
            
     ' Set qd = cn.CreateQueryDef("view_abb1", "{call tmp_result2()}")

ElseIf main_form = 4 Then

'             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'            cn.EstablishConnection rdDriverNoPrompt
        sql = "drop proc tmp_result3"
            cn.Execute sql, rdExecDirect
        CRIT = "create proc tmp_result3 as " & CRIT
               cn.Execute CRIT, rdExecDirect
            
     ' Set qd = cn.CreateQueryDef("view_abb1", "{call tmp_result()}")
ElseIf main_form = 5 Then

'             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'            cn.EstablishConnection rdDriverNoPrompt
        sql = "drop proc tmp_result4"
            cn.Execute sql, rdExecDirect
        CRIT = "create proc tmp_result4 as " & CRIT
               cn.Execute CRIT, rdExecDirect
            
     ' Set qd = cn.CreateQueryDef("view_abb1", "{call tmp_result4()}")
ElseIf main_form = 6 Then

'             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'            cn.EstablishConnection rdDriverNoPrompt
        sql = "drop proc tmp_result6"
            cn.Execute sql, rdExecDirect
        CRIT = "create proc tmp_result6 as " & CRIT
               cn.Execute CRIT, rdExecDirect
            
   '   Set qd = cn.CreateQueryDef("view_abb1", "{call tmp_result6()}")

End If
 Screen.MousePointer = vbDefault

       
 Screen.MousePointer = vbHourglass
 
' frm_view.WindowState = 2
' frm_view.Show
frm_result.WindowState = 2
frm_result.Show

 
 Screen.MousePointer = vbDefault

Else
MsgBox "·« ÌÊÃœ ÃÊ«» ·«‰Â ·„  ÿ·» ”Ê«· "
End If

End Sub

Private Sub Command1_Click()
Unload sort_form
End Sub

Private Sub Command2_Click()
 BNKOUT2.Resultset.MoveFirst
       While Not BNKOUT2.Resultset.EOF
         If BNKOUT2.Resultset![out_chioce] = 2 Then
          If BNKOUT2.Resultset![out_num] = 2 Or BNKOUT2.Resultset![out_num] = 3 Or BNKOUT2.Resultset![out_num] = 124 Or _
          BNKOUT2.Resultset![out_num] = 12 Or BNKOUT2.Resultset![out_num] = 13 Or BNKOUT2.Resultset![out_num] = 126 Or BNKOUT2.Resultset![out_num] = 41 Then
           sql = "execute upd_bnkout " & "'" & BNKOUT2.Resultset![out_num] & "'"
               cn.Execute sql, rdExecDirect
          End If
          
         End If
       BNKOUT2.Resultset.MoveNext
    Wend
    bnkout.Refresh
  BNKOUT2.Refresh
  bnkout1.Refresh
    
End Sub

 

Private Sub Command8_Click()
   
   Dim posit, posit1, L, l1 As Integer
   Dim str1, str2, d_type, d_query, d_view, d_view1, d_get, d_get1, d_get2, d_cond, d_table As Variant
   Dim CRIT, crit1, crit11, crit2, crit3 As String
     
    
    bnkout.Resultset.Bookmark = c_listfields.SelectedItem
    
    
    v_bookmark1 = bnkout.Resultset![out_num]
    
 If bnkout.Resultset![out_nature] = "1" Then
   
   x_getcond.Visible = True
   c_getcond.Visible = False
  
 
 
 ElseIf bnkout.Resultset![out_nature] = "3" Then
     
  x_getcond.Visible = True
  c_getcond.Visible = False

 
 ElseIf bnkout.Resultset![out_nature] = "2" Then
   
   x_getcond.Visible = False
   c_getcond.Visible = True
  
    d_type = bnkout.Resultset![out_nature]
    d_query = bnkout.Resultset![out_slct1]
    d_view = bnkout.Resultset![out_namcod]
    d_get = bnkout.Resultset![out_cod]
    d_cond = bnkout.Resultset![out_cond1]
    d_table = bnkout.Resultset![out_slct1]
    

   crit1 = " SELECT DISTINCTROW " & d_view
   crit11 = "," & d_get
   crit2 = " FROM " & d_query
   crit3 = " WHERE " & d_cond
   If Trim$(d_cond) <> "1 = 1" Then
   CRIT = crit1 & crit11 & crit2 & crit3
   Else
    CRIT = crit1 & crit11 & crit2
   End If
  
     
'   MsgBox "crit = " & crit
  data2.sql = CRIT
  data2.Refresh

 
  
    posit = InStr(1, d_view, "[")
    L = Len(d_view)
    d_view1 = Mid$(d_view, posit + 1, L - (posit + 1))
  
  posit1 = InStr(1, d_get, "field1")
  
  If posit1 <> 0 Then
  d_get1 = Mid(d_get, posit1, 6)
  
  Else
  
   posit = InStr(1, d_get, "[")
   L = Len(d_get)
   d_get1 = Mid$(d_get, posit + 1, L - (posit + 1))
   End If
   v_get = d_get1
   v_view = d_view1
   
   c_getcond.ListField = v_view
   c_getcond.BoundColumn = v_get

      
End If

End Sub
 

Private Sub Command3_Click()

sql = "execute upd_userbnkout_FREE " & "'" & box_user_no & "'" & "," & "'" & var_ist & "'"
               cn.Execute sql, rdExecDirect
              view_coding37.Recordset.Bookmark = M_OUT_CAT.SelectedItem
              m_code = Mid(view_coding37.Recordset![sub_code], 3, 4)
               f_cat.RecordSource = "execute serh_cat" & "'" & m_code & "'"
               f_cat.Refresh
f_cat.Recordset.MoveFirst
       While Not f_cat.Recordset.EOF
         m_num = f_cat.Recordset![cat_num]
         
           sql = "execute upd_user_bnkout_choice " & "'" & m_num & "'" & "," & "'" & box_user_no & "'" & "," & "'" & var_ist & "'"
               cn.Execute sql, rdExecDirect
       f_cat.Recordset.MoveNext
    Wend
    bnkout.Refresh
  BNKOUT2.Refresh
  bnkout1.Refresh
End Sub

Private Sub DBList2_DblClick()
On Error Resume Next
   BNKOUT2.Resultset.Bookmark = DBList2.SelectedItem
   m_num = BNKOUT2.Resultset![user_out_num]
   m_choice = BNKOUT2.Resultset![user_out_choice]
   sql = "execute upd_user_bnkout  " & "'" & box_user_no & "'" & "," & "'" & m_num & "'" & "," & "'" & m_choice & "'" & "," & "'" & var_ist & "'"
      cn.Execute sql, rdExecDirect
      BNKOUT2.Refresh
      bnkout1.Refresh
End Sub

Private Sub DBList2_KeyDown(KeyCode As Integer, Shift As Integer)
On Error Resume Next

If KeyCode = vbKeyF10 Then
    BNKOUT2.Resultset.Bookmark = DBList2.SelectedItem
   m_num = BNKOUT2.Resultset![user_out_num]
   m_choice = BNKOUT2.Resultset![user_out_choi1]
   sql = "execute upd_user_choi1  " & "'" & box_user_no & "'" & "," & "'" & m_num & "'" & "," & "'" & m_choice & "'" & "," & "'" & var_ist & "'"
      cn.Execute sql, rdExecDirect
      BNKOUT2.Refresh
      bnkout1.Refresh
  bnkout.Refresh
  BNKOUT2.Refresh
  bnkout1.Refresh
 End If
End Sub

Private Sub DBList2_77(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF2 Then
BNKOUT2.Resultset.Bookmark = DBList2.SelectedItem
   BNKOUT2.Resultset.Edit
   
  If BNKOUT2.Resultset![out_chioce] = 1 Then
    BNKOUT2.Resultset![out_chioce] = 2
 '    m_ser_fld = m_ser_fld + 1
 '    BNKOUT2.Resultset![out_serial] = m_ser_fld
    If BNKOUT2.Resultset![out_chio1] = 1 Then
        BNKOUT2.Resultset![OUT_desc] = Mid(BNKOUT2.Resultset![OUT_desc], 5, Len(BNKOUT2.Resultset![OUT_desc]) - 4)
     Else
      BNKOUT2.Resultset![OUT_desc] = Mid(BNKOUT2.Resultset![OUT_desc], 3, Len(BNKOUT2.Resultset![OUT_desc]) - 2)
    End If
    BNKOUT2.Resultset![out_chio1] = 2
  Else
     BNKOUT2.Resultset![out_chioce] = 1
     BNKOUT2.Resultset![OUT_desc] = "# " + BNKOUT2.Resultset![OUT_desc]
     
  End If
  BNKOUT2.Resultset.Update
  BNKOUT2.Refresh
  bnkout.Refresh
  BNKOUT2.Refresh
  bnkout1.Refresh
End If
End Sub

Private Sub DBList3_Click()
On Error Resume Next
   Dim posit, posit1, L, l1 As Integer
   Dim str1, str2, d_type, d_query, d_view, d_view1, d_get, d_get1, d_get2, d_cond, d_table As Variant
   Dim CRIT, crit1, crit11, crit2, crit3 As String
   Dim mydate As Variant
'   Dim cn As New rdoConnection
   Dim sql As String
   Dim qd As rdoQuery
   Dim sql_query As String
 
   searcher.Text = ""
   x_getcond = " "
'     txt_display.Visible = True
    bnkout.Resultset.Bookmark = DBList3.SelectedItem
    

    v_bookmark1 = bnkout.Resultset![out_num]
 If bnkout.Resultset![out_nature] = "1" Or bnkout.Resultset![out_nature] = "8" Or bnkout.Resultset![out_nature] = "0" Then
 '  x_getcond.Text = ""
   x_getcond.Visible = True
  ' c_getcond.Visible = False
   x_cond1.Visible = False
   [cb_serh].Visible = False
   searcher.Visible = False
   x_getcond.SetFocus
   
 
 
 ElseIf bnkout.Resultset![out_nature] = "3" Then
  ' mydate = Date
  x_getcond = Date
  'Format(mydate, "  /  /  ")
    
  x_getcond.Visible = True
  'c_getcond.Visible = False
  searcher.Visible = False
  x_cond1.Visible = False
  [cb_serh].Visible = False
  x_getcond.SetFocus
 ElseIf bnkout.Resultset![out_nature] = "2" Or bnkout.Resultset![out_nature] = "9" _
    Or bnkout.Resultset![out_nature] = "6" Then
    searcher.Visible = True
'  x_getcond.Visible = False
   c_getcond.Visible = True
   x_cond1.Visible = True
   c_operation.Visible = True
  [cb_serh].Visible = False

    d_type = bnkout.Resultset![out_nature]
    d_query = bnkout.Resultset![out_slct1]
    d_view = bnkout.Resultset![out_namcod]
    d_get = bnkout.Resultset![out_cod]
    d_cond = bnkout.Resultset![out_cond1]
   d_table = bnkout.Resultset![out_slct1]
   
   crit1 = " SELECT " & d_view
   crit11 = "," & d_get
   crit2 = " FROM " & d_query
   crit3 = " WHERE " & d_cond
   crit4 = " order by " & d_view
   
   If Trim$(d_cond) <> "1 = 1" Then
   CRIT = crit1 & crit11 & crit2 & crit3 & crit4
   Else
   CRIT = crit1 & crit11 & crit2 & crit4
   End If
  
  
             
'             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'            cn.EstablishConnection rdDriverNoPrompt
            'cn.Execute SQL, rdExecDirect
            
   Set qd = cn.CreateQuery("view_abb", CRIT)
   data2.sql = qd.sql
   
   data2.Refresh
    
  
  

    posit = InStr(1, d_view, "[")
    L = Len(d_view)
    d_view1 = Mid$(d_view, posit + 1, L - (posit + 1))
  
  posit1 = InStr(1, d_get, "field1")
 
  If posit1 <> 0 Then
  d_get1 = Mid(d_get, posit1, 6)
 
  Else
  
   posit = InStr(1, d_get, "[")
   d_get = Trim(d_get)
   L = Len(d_get)
   d_get1 = Mid$(d_get, posit + 1, L - (posit + 1))
   End If
   
   v_get = d_get1
   v_view = d_view1
   c_getcond.ListField = v_view
   c_getcond.BoundColumn = v_get
   searcher.SetFocus
' ElseIf bnkout.resultset![out_nature] = "6" Then
'   MsgBox "we enter "
'  ElseIf bnkout.resultset![out_nature] = "6" Then
'     [x_getcond].Visible = False
'     [c_getcond].Visible = False
'     [x_cond1].Visible = True
'     [cb_serh].Visible = True
  
'ElseIf bnkout.Resultset![out_nature] = "6" Then
'   [cb_serh].Visible = False
'    c_operation = "= "
'    c_operation.Visible = False
    
    
    
      
End If




'txt_display.Visible = False



End Sub
Function add_question()

 On Error Resume Next
 Dim m_getcond, m_getcond1 As Variant
 Dim i, lg1 As Integer
 m_getcond = ""
 If nb_and + nb_or = nb_ad Then
 'x_string = strin("right(x_criteria , 1) , ('/',')','(')")
 
 'If x_string And Me![x_criteria] <> "" Then
 '  MsgBox "ÌÃ» «œŒ«· «·„⁄«œ·…"
 '  Exit Sub
 'End If
 nb_ad = nb_ad + 1
bnkout.Resultset.Bookmark = v_bookmark1
 
 If bnkout.Resultset![out_nature] = "1" Or bnkout.Resultset![out_nature] = "8" Or bnkout.Resultset![out_nature] = "0" Then
   m_getcond = Trim(x_getcond)
   m_getcond1 = Trim(x_getcond)
    
 ElseIf bnkout.Resultset![out_nature] = "3" Then
   m_getcond = x_getcond
   m_getcond1 = x_getcond
 
 ElseIf bnkout.Resultset![out_nature] = "2" Or bnkout.Resultset![out_nature] = "6" Or bnkout.Resultset![out_nature] = "9" Then
'MsgBox c_getcond.BoundColumn

   m_getcond1 = c_getcond.BoundText
   m_getcond = c_getcond
     
End If
 
 If IsNull(c_operation) Or IsNull(m_getcond) Or m_getcond = "" Then
   MsgBox "INVALID CONDITION"
 Else
     lg1 = 1
    If count1 > 0 Then
       i = 1
       While i < count1 + 1 And lg1 = 1
           If arr_table(i) = bnkout.Resultset![out_select] Then
                lg1 = 0
            End If

            i = i + 1
        Wend
     End If
        If lg1 = 1 Or bnkout.Resultset![out_RCRN] = "2" Then
        
           count1 = count1 + 1
           arr_table1(count1) = bnkout.Resultset![out_select]
           arr_table(count1) = bnkout.Resultset![out_select]
           arr_fld_rel(count1) = bnkout.Resultset![out_rel]
            If lg1 = 0 Then
                arr_table1(count1) = arr_table(count1) & " as " & arr_table(count1) & "_" & Trim(Str(count1))
                arr_table(count1) = arr_table(count1) & "_" & Trim(Str(count1))
              End If

           If Not IsEmpty(bnkout.Resultset![out_REL1]) And Not IsNull(bnkout.Resultset![out_REL1]) And Not bnkout.Resultset![out_REL1] = "" Then
              count2 = count2 + 1
              arr_rel1(count2) = bnkout.Resultset![out_REL1]
              arr_ind1(count2) = count1
              arr_tbl(count2) = bnkout.Resultset![out_select]
              If lg1 = 0 Then
                  arr_tbl(count2) = arr_table(count1)
              End If
              
           End If
           If Not IsEmpty(bnkout.Resultset![out_REL2]) And Not IsNull(bnkout.Resultset![out_REL2]) And Not bnkout.Resultset![out_REL2] = "" Then
              count3 = count3 + 1
              arr_rel2(count3) = bnkout.Resultset![out_REL2]
              arr_ind2(count3) = count1
              arr_tbl1(count3) = bnkout.Resultset![out_select]
              If lg1 = 0 Then
                  arr_tbl1(count3) = arr_table(count1)
              End If
              
        End If
       End If

 End If
    If bnkout.Resultset![out_nature] = "9" Then
           lg4 = 1
            If count_relm > 0 Then
              i = 1
             While i < count_relm + 1 And lg4 = 1
                If arr_reltbl(i) = bnkout.Resultset![out_mcond1] Then
                  lg4 = 0
                 End If
                 i = i + 1
             Wend
           End If
          If lg4 = 1 Then
            count_relm = count_relm + 1
            arr_relition(count_relm) = bnkout.Resultset![out_scond1]
            arr_reltblm(count_relm) = bnkout.Resultset![out_mcond1]
            arr_relition1(count_relm) = bnkout.Resultset![out_fldselect]
            arr_reltbl1(count_relm) = arr_table(count1)
            arr_indic(count_relm) = 1
          ElseIf lg4 = 0 Then
             count_relm = count_relm + 1
            arr_relition(count_relm) = bnkout.Resultset![out_scond1]
            arr_reltblm(count_relm) = bnkout.Resultset![out_mcond1]
            arr_reltblm(count_relm) = arr_reltblm(count_relm) & "_" & Trim(Str(count_relm))
            arr_relition1(count_relm) = bnkout.Resultset![out_fldselect]
            arr_reltbl1(count_relm) = arr_table(count1)
            arr_indic(count_relm) = 0
          End If
    End If

 ' *********************************************************
   Select Case bnkout.Resultset![out_TYP]
   Case "C"
      If bnkout.Resultset![out_nature] = "0" Then
       tm_criteria = tm_criteria & " (" & bnkout.Resultset![OUT_scond] & " LIKE " & "'" & "%" & m_getcond1 & "%" & "'"
         x_criteria = x_criteria & " (" & bnkout.Resultset![out_cond] & " LIKE " & "'" & "%" & m_getcond1 & "%" & "'"
      ElseIf bnkout.Resultset![out_nature] = "9" Then
             x_criteria = x_criteria & "[" & bnkout.Resultset![out_cond] & "]" & c_operation & "'" & m_getcond & "'"
              tm_criteria = tm_criteria & " (" & arr_reltblm(count_relm) & "." & bnkout.Resultset![OUT_scond] & c_operation & "'" & m_getcond1 & "'"
      Else
       x_criteria = x_criteria & "[" & bnkout.Resultset![out_cond] & "]" & c_operation & "'" & m_getcond & "'"
      If bnkout.Resultset![out_RCRN] = "1" Or lg1 = 1 Then
         If Not IsEmpty(Trim(bnkout.Resultset![out_mcond])) And Not IsNull(bnkout.Resultset![out_mcond]) And Not Trim(bnkout.Resultset![out_mcond]) = "" Then
            If Not IsNull(Trim(bnkout.Resultset![out_EXT])) Then
             nw_getcond1 = Trim(bnkout.Resultset![out_EXT]) + Mid(m_getcond1, bnkout.Resultset![out_mcond1], bnkout.Resultset![out_mcond])
             Else
             nw_getcond1 = Mid(m_getcond1, bnkout.Resultset![out_mcond1], bnkout.Resultset![out_mcond])
             End If
             tm_criteria = tm_criteria & " (" & bnkout.Resultset![OUT_scond] & c_operation & "'" & nw_getcond1 & "'"
           Else
            tm_criteria = tm_criteria & " (" & bnkout.Resultset![OUT_scond] & c_operation & "'" & m_getcond1 & "'"
          End If
      Else
        If Not IsEmpty(Trim(bnkout.Resultset![out_mcond])) And Not IsNull(bnkout.Resultset![out_mcond]) And Not Trim(bnkout.Resultset![out_mcond]) = "" Then
             nw_getcond1 = Mid(m_getcond1, bnkout.Resultset![out_mcond1], bnkout.Resultset![out_mcond])
             tm_criteria = tm_criteria & " (" & "substring(" & arr_table(count1) & "." & bnkout.Resultset![OUT_field] & _
             "," & bnkout.Resultset![out_mcond1] & "," & bnkout.Resultset![out_mcond] & ")" & c_operation & "'" & nw_getcond1 & "'"
           Else
                  tm_criteria = tm_criteria & " (" & arr_table(count1) & "." & bnkout.Resultset![OUT_field] & c_operation & "'" & m_getcond1 & "'"
          End If
'      tm_criteria = tm_criteria & arr_table(count1) & "." & bnkout.resultset![out_field] & Me![c_operation] & "'" & m_getcond1 & "'"
'      MsgBox tm_criteria
       End If
     End If

   Case "N"
     x_criteria = x_criteria & "[" & bnkout.Resultset![out_cond] & "]" & c_operation & m_getcond
     'tm_criteria = tm_criteria & Me![c_listfields].column(11) & ".[" & Me![c_listfields].column(4) & "]" & Me![C_OPERATION] & m_getcond1
     If bnkout.Resultset![out_RCRN] = "1" Or lg1 = 1 Then
         tm_criteria = tm_criteria & " (" & bnkout.Resultset![OUT_scond] & c_operation & m_getcond1
     Else
         tm_criteria = tm_criteria & " (" & arr_table(count1) & "." & bnkout.Resultset![OUT_field] & c_operation & m_getcond1
     End If


   Case "D"
       x_criteria = x_criteria & "[" & bnkout.Resultset![out_cond] & "]" & c_operation & "#" & Format(m_getcond, "dd/mm/yyyy") & "#"
       If bnkout.Resultset![out_RCRN] = "1" Or lg1 = 1 Then
          tm_criteria = tm_criteria & " (" & bnkout.Resultset![OUT_scond] & c_operation & "convert(datetime," & "'" & Format(m_getcond1, "yyyy-mm-dd") & "'" & "," & "102)"
       Else
           tm_criteria = tm_criteria & " (" & arr_table(count1) & "." & bnkout.Resultset![OUT_field] & Me![c_operation] & "convert(datetime," & "'" & Format(m_getcond1, "yyyy-mm-dd") & "'" & "," & "102)"
        End If
   
   End Select
    If Not IsEmpty(bnkout.Resultset![out_REL3]) And Not IsNull(bnkout.Resultset![out_REL3]) And Not bnkout.Resultset![out_REL3] = "" Then
        tm_criteria = tm_criteria & " and " & arr_table(count1) & "." & bnkout.Resultset![out_REL3]
     
    End If
    If Not IsEmpty(bnkout.Resultset![out_T2]) And Not IsNull(bnkout.Resultset![out_T2]) And Not Trim(bnkout.Resultset![out_T2]) = "" Then
          tm_criteria = tm_criteria & " and " & arr_table(count1) & "." & bnkout.Resultset![out_T2]
    End If
 
 x_getcond = ""
 c_getcond = ""
 tm_criteria = tm_criteria & " )"
' *********************************************************

Else
 MsgBox "·«Ì„ﬂ‰ «÷«›… ”ƒ«· «Œ— «·« »⁄œ «÷«›… /Ê/ ,/«Ê/"
End If
  
End Function
Private Sub Form_Load()
'Dim cn As New rdoConnection
   Dim sql As String
   Dim qd As rdoQuery
m_key_serh = 1

   
 x_criteria = ""
  x_getcond = ""
  cb_serh = ""
  c_listfields = ""
  c_operation = "="
 ' c_getcond.Visible = False
  x_getcond.Visible = True
  x_getcond = ""
   cb_serh.Visible = False
'crst_rep1.Action = 2
'[main_frm].crst_rep1.Destination = 1
'[main_frm].crst_rep1.Destination = 0
   
Option1.value = 1

   
  'Me![x_getcond].Format = ""
  'Me![x_getcond].InputMask = ""
  count1 = 0
  count2 = 0
  count3 = 0
  count_slct1 = 0
   nb_ad = 0
   nb_or = 0
   nb_and = 0
   count_relm = 0
  L = 0
  For L = 1 To 20
   arr_ind1(L) = 0
   arr_ind2(L) = 0
  Next
  
  M_CRITERIA = ""
  tm_criteria = ""
  m_selectuse = False
  'sql = ""
 
  m_if1 = 1
  m_if2 = 2
'If ARCHIVE.f2.Checked = True Then
If main_form = 1 Then
  var_ist = "01"
   bnkout.sql = "select * from bnkout where (out_if = 1 or out_if = 3 or out_if = 4) order by out_indx3"
   BNKOUT2.sql = "select * from view_user_bnkout where (user_no = " & "'" & box_user_no & "'" & " ) and  (user_out_choice = 1 or user_out_choice = 2) " & " and ( user_ist_no = " & "'" & var_ist & "'" & " ) order by user_out_index"
   CRIT = "select view_user_bnkout.* from view_user_bnkout where user_out_choice = " & "'" & m_if1 & "'" & " and user_no = " & "'" & box_user_no & "'" & " and ( user_ist_no = " & "'" & var_ist & "'" & " )"
   bnkout1.sql = CRIT
   
'ElseIf ARCHIVE.f3.Checked = True Then
ElseIf main_form = 2 Then
 var_ist = "02"
  CRIT = "select pout.* from pout"
  CRIT = CRIT & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_if = " & "'" & m_if1 & "'" & " or out_if = " & "'" & m_if2 & "'" & " )"
  
  bnkout.sql = CRIT
  
  
  'crit1 = "select pout.* from pout"
  'crit1 = crit1 & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( USER_out_choice = " & "'" & m_if1 & "'" & " or user_out_choice = " & "'" & m_if2 & "'" & " )"
  'BNKOUT2.sql = crit1
  BNKOUT2.sql = "select * from view_user_pout where (user_no = " & "'" & box_user_no & "'" & " ) and (user_ist_no = " & "'" & var_ist & "'" & " ) and  (user_out_choice = 1 or user_out_choice = 2) order by user_out_index"
  
  crit2 = "select view_user_pout.*,view_user_pout.out_name as out_name1 from view_user_pout "
  crit2 = crit2 & "  where ( out_ist = " & "'" & var_ist & "'" & " ) and (user_no = " & "'" & box_user_no & "'" _
          & " ) and ( user_out_choice = " & "'" & m_if1 & "'" & " )"
  bnkout1.sql = crit2
'ElseIf ARCHIVE.f4.Checked = True Then
ElseIf main_form = 3 Then
  var_ist = "06"
  'CRIT = "select pout.* from pout"
  'CRIT = CRIT & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
   '       & " and ( out_if = " & "'" & m_if1 & "'" & " or out_if = " & "'" & m_if2 & "'" & " )"
  
  'bnkout.sql = CRIT
  'crit1 = "select pout.* from pout"
  'crit1 = crit1 & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
  '        & " and ( user_out_choice = " & "'" & m_if1 & "'" & " or user_out_choice = " & "'" & m_if2 & "'" & " )"
  'BNKOUT2.sql = crit1
  'crit2 = "select pout.* from pout"
  'crit2 = crit2 & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
  '        & " and ( user_out_choice = " & "'" & m_if1 & "'" & " )"
  'bnkout1.sql = crit2
  CRIT = "select pout.* from pout"
  CRIT = CRIT & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_if = " & "'" & m_if1 & "'" & " or out_if = " & "'" & m_if2 & "'" & " )"
  
  bnkout.sql = CRIT
  
  
  'crit1 = "select pout.* from pout"
  'crit1 = crit1 & "  where ( pout.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( USER_out_choice = " & "'" & m_if1 & "'" & " or user_out_choice = " & "'" & m_if2 & "'" & " )"
  'BNKOUT2.sql = crit1
  BNKOUT2.sql = "select * from view_user_pout where (user_no = " & "'" & box_user_no & "'" & " ) and (user_ist_no = " & "'" & var_ist & "'" & " ) and  (user_out_choice = 1 or user_out_choice = 2) order by user_out_index"
  
  crit2 = "select view_user_pout.*,view_user_pout.out_name as out_name1 from view_user_pout "
  crit2 = crit2 & "  where ( out_ist = " & "'" & var_ist & "'" & " ) and (user_no = " & "'" & box_user_no & "'" _
          & " ) and ( user_out_choice = " & "'" & m_if1 & "'" & " )"
  bnkout1.sql = crit2

'ElseIf ARCHIVE.f5.Checked = True Then
ElseIf main_form = 4 Then
   bnkout.sql = "select * from bnkout where (out_if = 3 or out_if = 4) order by out_indx3"
   BNKOUT2.sql = "select * from bnkout where (user_out_choice = 1 or user_out_choice = 2) order by out_indx"
   CRIT = "select bnkout.* from bnkout where user_out_choice = " & "'" & m_if1 & "'"
   bnkout1.sql = CRIT
ElseIf main_form = 5 Then
  var_ist = "01"
  CRIT = "select pout1.* from pout1"
  CRIT = CRIT & "  where ( pout1.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_if = " & "'" & m_if1 & "'" & " or out_if = " & "'" & m_if2 & "'" & " )"
  
  bnkout.sql = CRIT
  crit1 = "select pout1.* from pout1"
  crit1 = crit1 & "  where ( pout1.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( user_out_choice = " & "'" & m_if1 & "'" & " or user_out_choice = " & "'" & m_if2 & "'" & " )"
  BNKOUT2.sql = crit1
  crit2 = "select pout1.* from pout1"
  crit2 = crit2 & "  where ( pout1.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( user_out_choice = " & "'" & m_if1 & "'" & " )"
  bnkout1.sql = crit2
ElseIf main_form = 6 Then
  var_ist = "02"
  CRIT = "select pout1.* from pout1"
  CRIT = CRIT & "  where ( pout1.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( out_if = " & "'" & m_if1 & "'" & " or out_if = " & "'" & m_if2 & "'" & " )"
  
  bnkout.sql = CRIT
  crit1 = "select pout1.* from pout1"
  crit1 = crit1 & "  where ( pout1.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( user_out_choice = " & "'" & m_if1 & "'" & " or user_out_choice = " & "'" & m_if2 & "'" & " )"
  BNKOUT2.sql = crit1
  crit2 = "select pout1.* from pout1"
  crit2 = crit2 & "  where ( pout1.out_ist = " & "'" & var_ist & "'" & " )" _
          & " and ( user_out_choice = " & "'" & m_if1 & "'" & " )"
  bnkout1.sql = crit2


End If
bnkout.Refresh
BNKOUT2.Refresh
bnkout1.Refresh

End Sub

Private Sub MSIPrint1_GotFocus()

End Sub

Private Sub Form_Unload(Cancel As Integer)
 'Archive.f3.Checked = False
 'Archive.f2.Checked = False
 'Archive.f4.Checked = False
 'Archive.f5.Checked = False
 
End Sub


Private Sub Option1_Click()
If Option1.value = True Then
 m_key_serh = 1
End If

End Sub

Private Sub Option2_Click()
If Option2.value = True Then
 m_key_serh = 2
End If

End Sub

Private Sub searcher_Change()
If Not Trim(searcher.Text) = "" Then
If m_key_serh = 1 Then
 If RTrim(bnkout.Resultset![out_slct1]) = "form" Or RTrim(bnkout.Resultset![out_slct1]) = "view_form1" Or RTrim(bnkout.Resultset![out_slct1]) = "view_form" Then
         m_desc = searcher.Text
         m_len = Len(Trim(searcher))
         data2.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        data2.Refresh
        c_getcond.BoundColumn = "sub_cod"
  ElseIf RTrim(bnkout.Resultset![out_slct1]) = "macnz" Then
       m_desc = searcher.Text
       m_len = Len(Trim(m_desc))
        data2.sql = "execute serh_macnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        c_getcond.BoundColumn = "sub_code"
        data2.Refresh

    ElseIf RTrim(bnkout.Resultset![out_slct1]) = "auther" Then
         m_desc = searcher.Text
         m_len = Len(Trim(m_desc))
         data2.sql = "execute serh_auther " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         
         data2.Refresh
         c_getcond.BoundColumn = "no_auther"
         
  ElseIf RTrim(bnkout.Resultset![out_slct1]) = "period" Then
       m_desc = searcher.Text
       m_len = Len(Trim(m_desc))
        data2.sql = "execute serh_period " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        c_getcond.BoundColumn = "per_per_no"
        data2.Refresh
       
    ElseIf RTrim(bnkout.Resultset![out_slct1]) = "position" Then
       m_desc = searcher.Text
       m_len = Len(Trim(m_desc))
        data2.sql = "execute serh_positon " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        c_getcond.BoundColumn = "pos_no"
        data2.Refresh
         
ElseIf RTrim(bnkout.Resultset![out_slct1]) = "main" Then
      m_desc = searcher.Text
      m_len = Len(Trim(m_desc))
      m_typ_ist = "ﬂ"
      m_typ_ist1 = "Ê"
   If Not IsNull(m_desc) And Not Trim(m_desc) = "" Then
       data2.sql = "exec SERH_main " & "'" & m_desc & "'" & "," & "'" & m_len & "'" & _
                           "," & "'" & m_typ_ist & "'" & "," & "'" & m_typ_ist1 & "'"
                          
      data2.Refresh
      c_getcond.BoundColumn = "mn_app_no"
      
    End If
End If
ElseIf m_key_serh = 2 Then
If RTrim(bnkout.Resultset![out_slct1]) = "form" Or RTrim(bnkout.Resultset![out_slct1]) = "view_form1" Then
         m_desc = searcher.Text
         m_len = Len(Trim(searcher))
        data2.sql = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        data2.Refresh
        c_getcond.BoundColumn = "sub_cod"
  ElseIf RTrim(bnkout.Resultset![out_slct1]) = "macnz" Then
       m_desc = searcher.Text
       m_len = Len(Trim(m_desc))
        data2.sql = "execute serh_wrdmacnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        c_getcond.BoundColumn = "sub_code"
        data2.Refresh

    ElseIf RTrim(bnkout.Resultset![out_slct1]) = "auther" Then
         m_desc = searcher.Text
         m_len = Len(Trim(m_desc))
          data2.sql = "execute serh_auther2 " & "'" & m_desc & "'"
         data2.Refresh
         c_getcond.BoundColumn = "aut_no"
         
ElseIf RTrim(bnkout.Resultset![out_slct1]) = "main" Then
      m_desc = searcher.Text
      m_len = Len(Trim(m_desc))
   If Not IsNull(m_desc) And Not Trim(m_desc) = "" Then
       data2.sql = "exec SERH_wrd_main " & "'" & m_desc & "'"
      data2.Refresh
      c_getcond.BoundColumn = "mn_app_no"
      
    End If
ElseIf RTrim(bnkout.Resultset![out_slct1]) = "period" Then
       m_desc = searcher.Text
       m_len = Len(Trim(m_desc))
        data2.sql = "execute serh_wrdperiod " & "'" & m_desc & "'"
        c_getcond.BoundColumn = "per_per_no"
        data2.Refresh
End If
End If
    c_getcond.Refresh
      'c_getcond.SetFocus
      searcher.SetFocus
      
 End If

End Sub

Private Sub searcher_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyDown And Not searcher.Text = "" Then
  c_getcond.SetFocus
   SendKeys "{UP}"
End If
End Sub

Private Sub searcher_KeyPress(KeyAscii As Integer)
 Select Case KeyAscii
   Case 13
    bnkout.Resultset.Bookmark = DBList3.SelectedItem
    
If m_key_serh = 1 Then
 If RTrim(bnkout.Resultset![out_slct1]) = "form" Or RTrim(bnkout.Resultset![out_slct1]) = "view_form1" Then
         m_desc = searcher.Text
         m_len = Len(Trim(searcher))
         data2.sql = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        data2.Refresh
        c_getcond.BoundColumn = "sub_cod"
  ElseIf RTrim(bnkout.Resultset![out_slct1]) = "macnz" Then
       m_desc = searcher.Text
       m_len = Len(Trim(m_desc))
        data2.sql = "execute serh_macnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        c_getcond.BoundColumn = "sub_code"
        data2.Refresh

    ElseIf RTrim(bnkout.Resultset![out_slct1]) = "auther" Then
         m_desc = searcher.Text
         m_len = Len(Trim(m_desc))
         data2.sql = "execute serh_auther " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         
         data2.Refresh
         c_getcond.BoundColumn = "no_auther"
         
  ElseIf RTrim(bnkout.Resultset![out_slct1]) = "period" Then
       m_desc = searcher.Text
       m_len = Len(Trim(m_desc))
        data2.sql = "execute serh_period " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        c_getcond.BoundColumn = "per_per_no"
        data2.Refresh
        
ElseIf RTrim(bnkout.Resultset![out_slct1]) = "main" Then
      m_desc = searcher.Text
      m_len = Len(Trim(m_desc))
      m_typ_ist = "ﬂ"
      m_typ_ist1 = "Ê"
   If Not IsNull(m_desc) And Not Trim(m_desc) = "" Then
       data2.sql = "exec SERH_main " & "'" & m_desc & "'" & "," & "'" & m_len & "'" & _
                           "," & "'" & m_typ_ist & "'" & "," & "'" & m_typ_ist1 & "'"
                          
      data2.Refresh
      c_getcond.BoundColumn = "mn_app_no"
      
    End If
End If
ElseIf m_key_serh = 2 Then
If RTrim(bnkout.Resultset![out_slct1]) = "form" Or RTrim(bnkout.Resultset![out_slct1]) = "view_form1" Then
         m_desc = searcher.Text
         m_len = Len(Trim(searcher))
        data2.sql = "execute serh_wrdform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        data2.Refresh
        c_getcond.BoundColumn = "sub_cod"
  ElseIf RTrim(bnkout.Resultset![out_slct1]) = "macnz" Then
       m_desc = searcher.Text
       m_len = Len(Trim(m_desc))
        data2.sql = "execute serh_wrdmacnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        c_getcond.BoundColumn = "sub_code"
        data2.Refresh

    ElseIf RTrim(bnkout.Resultset![out_slct1]) = "auther" Then
         m_desc = searcher.Text
         m_len = Len(Trim(m_desc))
          data2.sql = "execute serh_auther2 " & "'" & m_desc & "'"
         data2.Refresh
         c_getcond.BoundColumn = "aut_no"
         
ElseIf RTrim(bnkout.Resultset![out_slct1]) = "main" Then
      m_desc = searcher.Text
      m_len = Len(Trim(m_desc))
   If Not IsNull(m_desc) And Not Trim(m_desc) = "" Then
       data2.sql = "exec SERH_wrd_main " & "'" & m_desc & "'"
      data2.Refresh
      c_getcond.BoundColumn = "mn_app_no"
      
    End If
End If
End If
    c_getcond.Refresh
      c_getcond.SetFocus
  
  End Select
   
  

End Sub

Private Sub x_add_Click()
  Call add_question
End Sub

Private Sub x_and_Click()
 On Error Resume Next
 If nb_and + nb_or < nb_ad Then
  If Right(Me![x_criteria], 1) <> "/" And Me![x_criteria] <> "" Then
    Me![x_criteria] = Me![x_criteria] & " " & " /Ê/ "
    tm_criteria = tm_criteria & " AND "
    nb_and = nb_and + 1
  End If
  Else
   If nb_and + nb_or = 0 Then
    MsgBox "·«Ì„ﬂ‰ «÷«›… /Ê/ ﬁ»· «Œ Ì«— «·”ƒ«·"
   Else
     MsgBox "·« Ì„ﬂ‰ «÷«›… /Ê/ ·«‰Â« „ÊÃÊœ…"
     End If
  End If

End Sub

Private Sub x_cond1_dblClick()

On Error Resume Next
Dim mydb As Database
'Dim q3, q1 As QueryDef
'Dim mytab As resultset
'Dim data7 As Variant
Dim crit12, crit11, crit1 As String
Dim L As Variant

'  mydb.QueryDefs.Delete ("q_word2")
L = 0
Set mydb = DBEngine.Workspaces(0).OpenDatabase("c:\program files\gnr_prg\gnr_11.mdb")
'MsgBox bnkout.resultset![out_slct1]

 If bnkout.Resultset![out_slct1] = "macnz" Or bnkout.Resultset![out_slct1] = "MACNZ" Then
 
 crit11 = "SELECT MACNZ.SUB_DESC, MACNZ.SUB_CODE, WORD.SUB_DESC6 FROM MACNZ INNER JOIN WORD ON MACNZ.SUB_CODE = WORD.SUB_CODE6"
 crit12 = " WHERE (((WORD.SUB_DESC6)=" & "'" & x_cond1 & "'" & "));"
 crit1 = crit11 & crit12
 L = 1
Else
  L = 2
crit11 = "SELECT FORM.SUB_NAME, FORM.[SUB_TYP],FORM.[SUB_NO], WORD.SUB_DESC6,word.sub_code6 FROM FORM INNER JOIN WORD ON FORM.SUB_TYP & FORM.SUB_NO = WORD.SUB_CODE6"
crit12 = " WHERE (((WORD.SUB_DESC6)=" & "'" & x_cond1 & "'" & "));"
crit1 = crit11 & crit12

End If

' MsgBox "crit1 = " & crit1
'Set q3 = mydb.CreateQueryDef("q_word2", crit1)

[c_getcond].Visible = True
 

 
 data2.sql = crit1
 data2.Refresh
  
 If L = 1 Then
    c_getcond.ListField = "sub_DESC"
   c_getcond.BoundColumn = "sub_code"
 Else
    c_getcond.ListField = "sub_NAME"
      c_getcond.BoundColumn = "SUB_CODE6"
  
 End If
   
[c_getcond].SetFocus
[x_cond1].Visible = False
SendKeys "^{f4}"


End Sub

Private Sub x_del_Click()
    
    
    Dim L As Integer
  x_criteria = ""
  x_getcond = ""
  cb_serh = ""
  c_listfields = ""
  c_operation = "="
  searcher = ""
  'c_getcond.Visible = False
  x_getcond.Visible = True
  x_getcond = ""
   cb_serh.Visible = False
  c_getcond.ListField = ""
  
  
  
  
   
  'Me![x_getcond].Format = ""
  'Me![x_getcond].InputMask = ""
  count1 = 0
  count2 = 0
  count3 = 0
  count_rel = 0
  count_slct1 = 0
   nb_ad = 0
   nb_or = 0
   nb_and = 0
   count_relm = 0
  L = 0
  For L = 1 To 20
   arr_ind1(L) = 0
   arr_ind2(L) = 0
  Next
  
  M_CRITERIA = ""
  tm_criteria = ""
  m_selectuse = False
  'sql = ""

End Sub

Private Sub x_getcond_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
  Call add_question
 End If
End Sub

Private Sub x_left_Click()
   [x_criteria] = [x_criteria] & "  " & ")"
 [x_criteria].Refresh
 tm_criteria = tm_criteria & " " & ") "

End Sub

Private Sub x_or_Click()
If nb_and + nb_or < nb_ad Then
    If Right(Me![x_criteria], 1) <> "/" And Me![x_criteria] <> "" Then
   Me![x_criteria] = Me![x_criteria] & " " & " /√Ê/ "
   tm_criteria = tm_criteria & " OR "
   nb_or = nb_or + 1
 End If
 Else
 If nb_and + nb_or = 0 Then
    MsgBox "·«Ì„ﬂ‰ «÷«›… /«Ê/ ﬁ»· «Œ Ì«— «·”ƒ«·"
   Else
  MsgBox "·«Ì„ﬂ‰ «÷«›… /«Ê/ ·«‰Â« „ÊÃÊœ…"
  End If
  End If
  

End Sub

Private Sub x_right_Click()
 [x_criteria] = [x_criteria] & "  " & "("
 [x_criteria].Refresh
 tm_criteria = tm_criteria & " " & "( "

End Sub
