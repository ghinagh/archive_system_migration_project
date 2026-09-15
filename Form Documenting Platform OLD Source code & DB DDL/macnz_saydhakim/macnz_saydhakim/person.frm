VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Begin VB.Form person 
   BackColor       =   &H00FFC0FF&
   Caption         =   "                                                                         «” „«—… «·„” ›Ìœ"
   ClientHeight    =   8595
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11880
   RightToLeft     =   -1  'True
   ScaleHeight     =   8595
   ScaleWidth      =   11880
   Begin MSRDC.MSRDC qualty 
      Height          =   330
      Left            =   120
      Top             =   8040
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
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server = sequel;driver = {sql server};database=macnz;"
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
   Begin MSDBCtls.DBList DBList2 
      Bindings        =   "person.frx":0000
      Height          =   3180
      Left            =   1320
      TabIndex        =   45
      Top             =   1200
      Visible         =   0   'False
      Width           =   4575
      _ExtentX        =   8070
      _ExtentY        =   5609
      _Version        =   393216
      BackColor       =   16761024
      ListField       =   "PRS_NAME"
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox m_vlg 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   6840
      RightToLeft     =   -1  'True
      TabIndex        =   44
      Top             =   1800
      Width           =   3855
   End
   Begin VB.TextBox serch 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   1320
      RightToLeft     =   -1  'True
      TabIndex        =   42
      Top             =   5160
      Visible         =   0   'False
      Width           =   1695
   End
   Begin MSDBCtls.DBList DBList1 
      Bindings        =   "person.frx":0011
      Height          =   3375
      Left            =   1560
      TabIndex        =   41
      Top             =   960
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
      Left            =   6360
      RightToLeft     =   -1  'True
      TabIndex        =   40
      Top             =   3960
      Width           =   4095
   End
   Begin VB.TextBox m_prs_inst_direct 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   1200
      RightToLeft     =   -1  'True
      TabIndex        =   39
      Top             =   4560
      Width           =   4095
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H8000000C&
      Caption         =   "«÷«›…"
      Height          =   615
      Left            =   240
      TabIndex        =   38
      Top             =   240
      Width           =   735
   End
   Begin VB.CommandButton Command8 
      Caption         =   "«·»ÕÀ  ⁄»— «·«”‹„"
      Height          =   615
      Left            =   240
      RightToLeft     =   -1  'True
      TabIndex        =   37
      Top             =   4560
      Width           =   735
   End
   Begin VB.CommandButton Command4 
      BackColor       =   &H008080FF&
      Caption         =   " ”ÃÌ·"
      Height          =   615
      Left            =   240
      MaskColor       =   &H000080FF&
      TabIndex        =   36
      Top             =   960
      Width           =   735
   End
   Begin VB.CommandButton Command5 
      Caption         =   "”«»ﬁ"
      Height          =   615
      Left            =   240
      TabIndex        =   35
      Top             =   3120
      Width           =   735
   End
   Begin VB.CommandButton Command6 
      Caption         =   "·«Õ‹‹ﬁ"
      Height          =   615
      Left            =   240
      TabIndex        =   34
      Top             =   3840
      Width           =   735
   End
   Begin VB.CommandButton Command7 
      Caption         =   "«·€‹‹«¡"
      Height          =   615
      Left            =   240
      TabIndex        =   33
      Top             =   2400
      Width           =   735
   End
   Begin VB.CommandButton Command10 
      BackColor       =   &H80000007&
      Caption         =   "»Õ‹‹À"
      Height          =   615
      Left            =   240
      TabIndex        =   32
      Top             =   1680
      Width           =   735
   End
   Begin VB.CommandButton Command11 
      Caption         =   "Œ—ÊÃ"
      Height          =   615
      Left            =   240
      RightToLeft     =   -1  'True
      TabIndex        =   31
      Top             =   5400
      Width           =   735
   End
   Begin VB.TextBox M_PRS_EMAIL 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   1080
      RightToLeft     =   -1  'True
      TabIndex        =   30
      Top             =   7440
      Width           =   3135
   End
   Begin VB.TextBox M_PRS_BOX 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   8760
      RightToLeft     =   -1  'True
      TabIndex        =   28
      Top             =   7200
      Width           =   2295
   End
   Begin VB.TextBox M_PRS_TEL 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   1320
      RightToLeft     =   -1  'True
      TabIndex        =   26
      Top             =   6600
      Width           =   3015
   End
   Begin VB.TextBox M_PRS_ADRS 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   5160
      RightToLeft     =   -1  'True
      TabIndex        =   23
      Top             =   6600
      Width           =   5535
   End
   Begin VB.TextBox M_PRS_INST_EMAIL 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   4080
      RightToLeft     =   -1  'True
      TabIndex        =   21
      Top             =   5160
      Width           =   3015
   End
   Begin VB.TextBox M_PRS_INST_BOX 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   8280
      RightToLeft     =   -1  'True
      TabIndex        =   19
      Top             =   5280
      Width           =   2895
   End
   Begin VB.TextBox M_PRS_ADRS1 
      Alignment       =   1  'Right Justify
      Height          =   405
      Left            =   6120
      RightToLeft     =   -1  'True
      TabIndex        =   16
      Top             =   4560
      Width           =   4815
   End
   Begin VB.TextBox M_PRS_INST_TEL 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   1200
      RightToLeft     =   -1  'True
      TabIndex        =   14
      Top             =   3840
      Width           =   3495
   End
   Begin MSDBCtls.DBCombo M_PRS_QUALTY 
      Bindings        =   "person.frx":0025
      Height          =   315
      Left            =   7200
      TabIndex        =   11
      Top             =   3120
      Width           =   3855
      _ExtentX        =   6800
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox M_PRS_DTE 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   2760
      RightToLeft     =   -1  'True
      TabIndex        =   9
      Top             =   1680
      Width           =   1695
   End
   Begin VB.OptionButton m_typ_icht1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0FF&
      Caption         =   "⁄‹«œÌ"
      Height          =   315
      Left            =   1920
      RightToLeft     =   -1  'True
      TabIndex        =   6
      Top             =   360
      Width           =   1335
   End
   Begin VB.OptionButton m_typ_icht 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0FF&
      Caption         =   "«‘ —«ﬂ"
      Height          =   255
      Left            =   3000
      RightToLeft     =   -1  'True
      TabIndex        =   5
      Top             =   360
      Width           =   1335
   End
   Begin VB.TextBox m_prs_name 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   5400
      RightToLeft     =   -1  'True
      TabIndex        =   3
      Top             =   1080
      Width           =   5175
   End
   Begin VB.TextBox m_prs_no 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   9600
      RightToLeft     =   -1  'True
      TabIndex        =   1
      Top             =   600
      Width           =   975
   End
   Begin MSRDC.MSRDC PERSON 
      Height          =   330
      Left            =   120
      Top             =   8160
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
      RecordSource    =   "select * FROM PERSON"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server = sequel;driver = {sql server};database=macnz;"
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
      Left            =   2040
      Top             =   8400
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
      RecordSource    =   "select * from pays_form  ORDER BY sub_name"
      UserName        =   "abbas"
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server = sequel;driver = {sql server};database=macnz;"
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
      Left            =   3240
      Top             =   8280
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
      RecordSource    =   "select * from pay_form"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
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
   Begin VB.Label Label18 
      Alignment       =   1  'Right Justify
      Caption         =   "«·»ÕÀ"
      Height          =   375
      Left            =   3000
      RightToLeft     =   -1  'True
      TabIndex        =   43
      Top             =   5160
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.Shape Shape6 
      BorderWidth     =   2
      Height          =   6135
      Left            =   120
      Top             =   120
      Width           =   975
   End
   Begin VB.Shape Shape3 
      BorderWidth     =   2
      Height          =   1815
      Left            =   600
      Shape           =   4  'Rounded Rectangle
      Top             =   6480
      Width           =   11175
   End
   Begin VB.Label Label17 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "E-MAIL :"
      Height          =   375
      Left            =   4200
      RightToLeft     =   -1  'True
      TabIndex        =   29
      Top             =   7440
      Width           =   735
   End
   Begin VB.Label Label16 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "’. ». :"
      Height          =   375
      Left            =   10920
      RightToLeft     =   -1  'True
      TabIndex        =   27
      Top             =   7200
      Width           =   615
   End
   Begin VB.Label Label15 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "«·Â« ›:"
      Height          =   375
      Left            =   4320
      RightToLeft     =   -1  'True
      TabIndex        =   25
      Top             =   6600
      Width           =   615
   End
   Begin VB.Label Label14 
      Alignment       =   1  'Right Justify
      Caption         =   "Label14"
      Height          =   135
      Left            =   4080
      RightToLeft     =   -1  'True
      TabIndex        =   24
      Top             =   6840
      Width           =   15
   End
   Begin VB.Label Label13 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "⁄‰Ê«‰ «·«ﬁ«„… ··„” ›Ìœ:"
      Height          =   375
      Left            =   10440
      RightToLeft     =   -1  'True
      TabIndex        =   22
      Top             =   6600
      Width           =   1215
   End
   Begin VB.Shape Shape2 
      BorderWidth     =   2
      Height          =   3375
      Left            =   720
      Shape           =   4  'Rounded Rectangle
      Top             =   2760
      Width           =   11175
   End
   Begin VB.Label Label12 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   " E-MAIL :"
      Height          =   375
      Left            =   7080
      RightToLeft     =   -1  'True
      TabIndex        =   20
      Top             =   5160
      Width           =   735
   End
   Begin VB.Label Label11 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "’. ». :"
      Height          =   495
      Left            =   11160
      RightToLeft     =   -1  'True
      TabIndex        =   18
      Top             =   5280
      Width           =   495
   End
   Begin VB.Label Label10 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "«”„ «·„œÌ—:"
      Height          =   255
      Left            =   5280
      RightToLeft     =   -1  'True
      TabIndex        =   17
      Top             =   4560
      Width           =   735
   End
   Begin VB.Label Label9 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "⁄‰Ê«‰Â« :"
      Height          =   375
      Left            =   10680
      RightToLeft     =   -1  'True
      TabIndex        =   15
      Top             =   4560
      Width           =   975
   End
   Begin VB.Label Label8 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "—ﬁ„ Â« › «·„ƒ””…:"
      Height          =   375
      Left            =   4440
      RightToLeft     =   -1  'True
      TabIndex        =   13
      Top             =   3840
      Width           =   1575
   End
   Begin VB.Label Label7 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "«·„ƒ””… «· Ì Ì Ê«Ãœ ›ÌÂ«:"
      Height          =   495
      Left            =   10440
      RightToLeft     =   -1  'True
      TabIndex        =   12
      Top             =   3840
      Width           =   1095
   End
   Begin VB.Label Label6 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "«·„Â‰… :"
      Height          =   375
      Left            =   11040
      RightToLeft     =   -1  'True
      TabIndex        =   10
      Top             =   3120
      Width           =   495
   End
   Begin VB.Shape Shape1 
      BorderWidth     =   2
      Height          =   2175
      Left            =   600
      Shape           =   4  'Rounded Rectangle
      Top             =   240
      Width           =   11175
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      Caption         =   " «—ÌŒ «·Ê·«œ…:"
      Height          =   255
      Left            =   3960
      RightToLeft     =   -1  'True
      TabIndex        =   8
      Top             =   1680
      Width           =   1455
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "„ﬂ«‰ «·Ê·«œ… :"
      Height          =   375
      Left            =   10680
      RightToLeft     =   -1  'True
      TabIndex        =   7
      Top             =   1800
      Width           =   975
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "‰Ê⁄ «·„” ›Ìœ:"
      Height          =   255
      Left            =   4560
      RightToLeft     =   -1  'True
      TabIndex        =   4
      Top             =   360
      Width           =   1095
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0C0&
      BorderStyle     =   1  'Fixed Single
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
      BorderStyle     =   1  'Fixed Single
      Caption         =   "—ﬁ„ «·„” ›Ìœ :"
      Height          =   255
      Left            =   10680
      RightToLeft     =   -1  'True
      TabIndex        =   0
      Top             =   600
      Width           =   975
   End
End
Attribute VB_Name = "person"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim m_tabindex As Integer
Dim m_typ_opr As Integer
Dim m_prs_vlg As String
Dim m_prs_noinst As String
Dim m_prs_nodirect As String
Dim m_prs_icht As Integer
Dim typ_serh As Integer





Function display_fld()
If Not IsNull(PERSON.Resultset![prs_no]) Then
  m_prs_no.Text = PERSON.Resultset![prs_no]
 End If
If Not IsNull(PERSON.Resultset![prs_name]) Then
  m_prs_name.Text = PERSON.Resultset![prs_name]
 End If
 If Not IsNull(PERSON.Resultset![prs_typ_icht]) Then
 
     m_prs_icht = PERSON.Resultset![prs_typ_icht]
     If m_prs_icht = 1 Then
        m_typ_icht = True
        m_typ_icht1 = False
      Else
        m_typ_icht = False
        m_typ_icht1 = True
      End If
  End If
If Not IsNull(PERSON.Resultset![prs_brth_dte]) Then
  M_PRS_DTE.Text = PERSON.Resultset![prs_dte]
 End If

  
 If Not IsNull(PERSON.Resultset![prs_vlg]) Then
          m_prs_vlg = PERSON.Resultset![prs_vlg]
           v_form1.SQL = "EXEC SERH_SUB_NAME " & "'" & m_prs_vlg & "'"
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
  M_PRS_QUALTY.BoundText = PERSON.Resultset![prs_qualty]
 End If
 If Not IsNull(PERSON.Resultset![prs_inst]) Then
          m_prs_noinst = PERSON.Resultset![prs_inst]
           v_form1.SQL = "EXEC SERH_SUB_NAME " & "'" & m_prs_noinst & "'"
           v_form1.Refresh
           
             If Not v_form1.Resultset.EOF And Not v_form1.Resultset.BOF Then
               m_prs_inst.Text = v_form1.Resultset![sub_name]
               Else
                 m_prs_noinst = ""
             End If
       Else
             m_prs_noinst = ""
    End If
If Not IsNull(PERSON.Resultset![prs_inst_tel]) Then
  M_PRS_INST_TEL.Text = PERSON.Resultset![prs_inst_tel]
 End If
If Not IsNull(PERSON.Resultset![prs_adrs1]) Then
  M_PRS_ADRS1.Text = PERSON.Resultset![prs_adrs1]
 End If
 If Not IsNull(PERSON.Resultset![prs_inst_dirct]) Then
          m_prs_nodirect = PERSON.Resultset![prs_inst_dirct]
           v_form1.SQL = "EXEC SERH_SUB_NAME " & "'" & m_prs_nodirect & "'"
           v_form1.Refresh
           
             If Not v_form1.Resultset.EOF And Not v_form1.Resultset.BOF Then
                  m_prs_inst_direct.Text = V_FORM.Resultset![sub_name]
               Else
                 m_prs_inst_direct.Text = ""
             End If
       Else
                 m_prs_inst_direct.Text = ""
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

End Function
Private Sub Command1_Click()
If Not PERSON.Resultset.EOF Then
   v_prs_no = "0000"
   m_no = 0
    PERSON.Resultset.MoveLast
    m_no = Val(PERSON.Resultset![prs_no])
    m_no = m_no + 1
    
    v_prs_no = Mid(v_prs_no, 1, 4 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
    m_prs_no.Text = v_prs_no
    
Else
  m_prs_no.Text = "0001"
End If
m_prs_name.Text = ""
M_PRS_DTE.Text = ""
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
m_typ_icht.SetFocus
m_typ_opr = 1
End Sub


Private Sub Command10_Click()
Dim cn As New rdoConnection
Dim SQL As String
Dim M_MN_APP_NO As String
Const None As String = ""
M_MN_APP_NO = ""
M_MN_APP_NO = InputBox("«œŒ· —ﬁ„ «·«” „«—… : ")
M_MN_APP_NO = M_MN_APP_NO
PERSON.SQL = "exec SERH_person " & "'" & M_MN_APP_NO & "'"
PERSON.Refresh
typ_serh = 2
If Not PERSON.Resultset.EOF Or Not PERSON.Resultset.BOF Then
  Call display_fld
 Else
  MsgBox "·« ÌÊÃœ «” „«—… ·Â–« «·—ﬁ„ !!!!"

 End If
End Sub

Private Sub Command4_Click()
Dim cn As New rdoConnection
 Dim SQL As String
 Dim m_bk_ser As Variant
If m_typ_opr = 1 Then
   SQL = "execute insr_person " & "'" & m_prs_no.Text & "'" & "," & "'" & m_prs_name.Text & "'" & "," _
   & "'" & Format(M_PRS_DTE.Text, "yyyy/mm/dd") & "'" & "," & "'" & m_prs_vlg & "'" & "," _
    & "'" & m_prs_icht & "'" & "," & "'" & M_PRS_QUALTY.BoundText & "'" & "," _
     & "'" & m_prs_noinst & "'" & "," & "'" & M_PRS_INST_TEL.Text & "'" & "," _
     & "'" & M_PRS_INST_BOX.Text & "'" & "," & "'" & m_prs_nodirect & "'" & "," _
     & "'" & M_PRS_INST_EMAIL.Text & "'" & "," & "'" & M_PRS_ADRS1.Text & "'" & "," _
     & "'" & M_PRS_ADRS.Text & "'" & "," & "'" & M_PRS_TEL.Text & "'" & "," _
      & "'" & M_PRS_BOX.Text & "'" & "," & "'" & M_PRS_EMAIL.Text & "'"
       
       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute SQL, rdExecDirect
     m_typ_opr = 2
ElseIf m_typ_opr = 2 Then

   SQL = "execute upd_person " & "'" & m_prs_no.Text & "'" & "," & "'" & m_prs_name.Text & "'" & "," _
   & "'" & Format(M_PRS_DTE.Text, "yyyy/mm/dd") & "'" & "," & "'" & m_prs_vlg & "'" & "," _
    & "'" & m_prs_icht & "'" & "," & "'" & M_PRS_QUALTY.BoundText & "'" & "," _
     & "'" & m_prs_noinst & "'" & "," & "'" & M_PRS_INST_TEL.Text & "'" & "," _
     & "'" & M_PRS_INST_BOX.Text & "'" & "," & "'" & m_prs_nodirect & "'" & "," _
     & "'" & M_PRS_INST_EMAIL.Text & "'" & "," & "'" & M_PRS_ADRS1.Text & "'" & "," _
     & "'" & M_PRS_ADRS.Text & "'" & "," & "'" & M_PRS_TEL.Text & "'" & "," _
      & "'" & M_PRS_BOX.Text & "'" & "," & "'" & M_PRS_EMAIL.Text & "'"
       
       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute SQL, rdExecDirect


 End If
 PERSON.Refresh
 
End Sub

Private Sub Command5_Click()
If typ_serh = 2 Then
 PERSON.SQL = "select *from person"
 PERSON.Refresh
 typ_serh = 1
End If
If Not PERSON.Resultset.BOF Then
PERSON.Resultset.MovePrevious
End If
If Not PERSON.Resultset.BOF Then
   Call display_fld
Else
 MsgBox "·«ÌÊÃœ «” „«—… ”«»ﬁ… .....!!!"
End If

End Sub

Private Sub Command6_Click()
If typ_serh = 2 Then
 PERSON.SQL = "select *from person"
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
Dim cn As New rdoConnection
Dim SQL As String
Dim ok As String
Const None As String = ""
 ok = " "
 ok = InputBox("Â·  —Ìœ «·€«¡ Â–Â «·«” „«—… ø(‰/ﬂ)")
' If ok = "y" Then
 If ok = "y" Or ok = "‰" Then
    cn.Connect = "uid=;pwd=;server=SEQUEL;" _
    & "driver={SQL Server};database=macnz;" _
    & "DSN='';"
    
 cn.CursorDriver = rdUseOdbc
 cn.EstablishConnection rdDriverNoPrompt
 SQL = "exec del_person" & m_prs_no.Text
  PERSON.Refresh
  
End If

End Sub

Private Sub Command8_Click()
Dim cn As New rdoConnection
Dim SQL As String
Dim m_desc As String
Const None As String = ""
m_desc = ""
m_desc = InputBox("«œŒ· »œ«Ì… «·«”„ «·À·«ÀÌ : ")
If Not IsNull(m_desc) And Not Trim(m_desc) = "" Then
  m_len = Len(m_desc)
 PERSON.SQL = "exec SERH_person1 " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
  PERSON.Refresh
  typ_serh = 2
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
    Label18.Visible = True
    serch.SetFocus
    
End If
End Sub

Private Sub DBList1_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then
  If m_tabindex = 42 Then
      view_form.Resultset.Bookmark = DBList1.SelectedItem
      m_prs_inst.Text = view_form.Resultset![sub_name]
      m_prs_noinst = view_form.Resultset![sub_typ] + view_form.Resultset![sub_no]
      
      M_PRS_INST_TEL.SetFocus
  ElseIf m_tabindex = 41 Then
       view_form.Resultset.Bookmark = DBList1.SelectedItem
      m_prs_inst_direct.Text = view_form.Resultset![sub_name]
      m_prs_noinst = view_form.Resultset![sub_typ] + view_form.Resultset![sub_no]
 ElseIf m_tabindex = 45 Then
       view_form.Resultset.Bookmark = DBList1.SelectedItem
      m_vlg.Text = view_form.Resultset![sub_name]
      m_prs_novlg = view_form.Resultset![sub_cod]
      M_PRS_DTE.SetFocus
 
 End If
 DBList1.Visible = False
   

ElseIf KeyAscii = 27 Then
  DBList1.Visible = False
  If m_tabindex = 42 Then
  M_PRS_QUALTY.SetFocus
  ElseIf m_tabindex = 41 Then
  M_PRS_ADRS1.SetFocus
  ElseIf m_tabindex = 45 Then
   M_PRS_DTE.SetFocus
   
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

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyInsert Then
  MsgBox "aa"
End If
End Sub

Private Sub Form_Load()
typ_serh = 1
m_typ_opr = 2
m_prs_vlg = Space(10)
m_prs_noinst = Space(10)
m_prs_nodirect = Space(10)
m_prs_icht = 0
 
End Sub

Private Sub M_PRS_ADRS_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_PRS_TEL.SetFocus
End If
End Sub

Private Sub M_PRS_ADRS1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
m_prs_inst_direct.SetFocus
DBList1.Visible = True
DBList1.SetFocus
SendKeys "{up}"
m_tabindex = 41
End If
End Sub

Private Sub M_PRS_BOX_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
M_PRS_EMAIL.SetFocus

End If

End Sub

Private Sub M_PRS_DTE_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
M_PRS_QUALTY.SetFocus
  SendKeys "{f4}"
End If
End Sub

Private Sub M_PRS_INST_BOX_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_PRS_INST_EMAIL.SetFocus
End If

End Sub

Private Sub M_PRS_INST_DIRECT_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_PRS_INST_BOX.SetFocus
End If

End Sub

Private Sub M_PRS_INST_EMAIL_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_PRS_ADRS.SetFocus
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

Private Sub m_prs_name_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 DBList1.Visible = True
 DBList1.SetFocus
 SendKeys "{UP}"
 m_tabindex = 45
 
End If

End Sub

Private Sub M_PRS_QUALTY_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
m_prs_inst.SetFocus
 DBList1.Visible = True
 DBList1.SetFocus
 SendKeys "{up}"
 m_tabindex = 42
End If
End Sub

Private Sub M_PRS_TEL_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
 M_PRS_BOX.SetFocus
End If
End Sub

Private Sub m_typ_icht_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_prs_name.SetFocus
  
End If
End Sub

Private Sub m_typ_icht1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  m_prs_name.SetFocus
  
End If

End Sub

Private Sub M_VLG_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
  M_PRS_DTE.SetFocus
End If

End Sub

Private Sub serch_KeyPress(KeyAscii As Integer)
     If KeyAscii = 13 Then
         m_desc = serch.Text
         m_len = Len(Trim(serch.Text))
         view_form.SQL = "execute serh_allform " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         view_form.Refresh
         DBList1.Refresh
         DBList1.SetFocus
         SendKeys "{UP}"
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
