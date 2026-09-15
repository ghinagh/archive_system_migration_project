VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Begin VB.Form Form7 
   BackColor       =   &H00FFC0FF&
   Caption         =   "«·’›Õ… «·À«‰Ì… - «·ﬂ »"
   ClientHeight    =   8595
   ClientLeft      =   270
   ClientTop       =   345
   ClientWidth     =   11880
   FillColor       =   &H00FFFFFF&
   LinkTopic       =   "Form7"
   Moveable        =   0   'False
   RightToLeft     =   -1  'True
   ScaleHeight     =   8595
   ScaleWidth      =   11880
   Begin VB.CommandButton Command2 
      Caption         =   "Œ—ÊÃ"
      Height          =   615
      Left            =   120
      TabIndex        =   42
      Top             =   5880
      Width           =   975
   End
   Begin VB.CommandButton Command3 
      Caption         =   "«· Õ·Ì·"
      Height          =   735
      Left            =   120
      RightToLeft     =   -1  'True
      TabIndex        =   18
      Top             =   4920
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H008080FF&
      Caption         =   " ”ÃÌ·"
      Height          =   735
      Left            =   120
      MaskColor       =   &H000080FF&
      TabIndex        =   19
      Top             =   1080
      Width           =   975
   End
   Begin VB.CommandButton Command5 
      Caption         =   "”«»ﬁ"
      Height          =   735
      Left            =   120
      TabIndex        =   21
      Top             =   2880
      Width           =   975
   End
   Begin VB.CommandButton Command4 
      Caption         =   "·«Õ‹‹ﬁ"
      Height          =   855
      Left            =   120
      TabIndex        =   22
      Top             =   3840
      Width           =   975
   End
   Begin VB.CommandButton Command7 
      BackColor       =   &H80000007&
      Caption         =   "»Õ‹‹À"
      Height          =   615
      Left            =   120
      TabIndex        =   20
      Top             =   2040
      Width           =   975
   End
   Begin VB.TextBox m_reg_no 
      BackColor       =   &H8000000A&
      Height          =   375
      Left            =   2640
      TabIndex        =   9
      Top             =   2040
      Width           =   735
   End
   Begin VB.TextBox m_ser_no 
      BackColor       =   &H8000000A&
      Height          =   285
      Left            =   2640
      TabIndex        =   6
      Top             =   1560
      Width           =   735
   End
   Begin VB.ComboBox m_lang 
      BackColor       =   &H8000000A&
      Height          =   315
      ItemData        =   "form7.frx":0000
      Left            =   7080
      List            =   "form7.frx":0010
      RightToLeft     =   -1  'True
      TabIndex        =   8
      Top             =   2520
      Width           =   1095
   End
   Begin VB.ComboBox m_wath_ty 
      BackColor       =   &H8000000A&
      Height          =   315
      ItemData        =   "form7.frx":0020
      Left            =   2400
      List            =   "form7.frx":0036
      TabIndex        =   17
      Top             =   5040
      Width           =   2295
   End
   Begin VB.TextBox m_quater 
      Alignment       =   1  'Right Justify
      BackColor       =   &H8000000A&
      Height          =   285
      Left            =   6120
      TabIndex        =   16
      Top             =   5040
      Width           =   975
   End
   Begin VB.TextBox m_slct_no 
      Alignment       =   1  'Right Justify
      BackColor       =   &H8000000A&
      Height          =   285
      Left            =   8400
      TabIndex        =   15
      Top             =   5040
      Width           =   2295
   End
   Begin VB.ComboBox m_mtrjm 
      BackColor       =   &H8000000A&
      Height          =   315
      ItemData        =   "form7.frx":006F
      Left            =   2280
      List            =   "form7.frx":007C
      TabIndex        =   14
      Top             =   3960
      Width           =   1335
   End
   Begin VB.TextBox m_prix 
      Alignment       =   1  'Right Justify
      BackColor       =   &H8000000A&
      Height          =   285
      Left            =   9240
      TabIndex        =   13
      Top             =   4080
      Width           =   1215
   End
   Begin VB.TextBox m_iktdte 
      Alignment       =   1  'Right Justify
      BackColor       =   &H8000000A&
      Height          =   495
      Left            =   2280
      TabIndex        =   12
      Top             =   3360
      Width           =   1095
   End
   Begin VB.TextBox m_no_cp 
      Alignment       =   1  'Right Justify
      BackColor       =   &H8000000A&
      Height          =   285
      Left            =   7560
      TabIndex        =   11
      Top             =   3360
      Width           =   615
   End
   Begin MSDBCtls.DBCombo m_pub_typ 
      Bindings        =   "form7.frx":008D
      Height          =   315
      Left            =   9240
      TabIndex        =   10
      Top             =   3360
      Width           =   1215
      _ExtentX        =   2143
      _ExtentY        =   556
      _Version        =   393216
      BackColor       =   -2147483638
      ListField       =   "sub_desc"
      BoundColumn     =   "SUB_CODE"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox m_rdmk 
      Alignment       =   1  'Right Justify
      BackColor       =   &H8000000A&
      Height          =   285
      Left            =   9360
      TabIndex        =   7
      Top             =   2520
      Width           =   1455
   End
   Begin VB.TextBox m_ser_ttl 
      Alignment       =   1  'Right Justify
      BackColor       =   &H8000000B&
      Height          =   405
      Left            =   6000
      MaxLength       =   40
      TabIndex        =   5
      Top             =   1680
      Width           =   4335
   End
   Begin VB.TextBox m_vol 
      BackColor       =   &H8000000A&
      Height          =   285
      Left            =   2640
      TabIndex        =   4
      Top             =   1080
      Width           =   615
   End
   Begin VB.TextBox m_prt_no 
      Alignment       =   1  'Right Justify
      BackColor       =   &H8000000A&
      Height          =   285
      Left            =   7200
      TabIndex        =   3
      Top             =   1080
      Width           =   735
   End
   Begin VB.TextBox m_pg_no 
      Alignment       =   1  'Right Justify
      BackColor       =   &H8000000B&
      Height          =   285
      Left            =   10080
      TabIndex        =   2
      Top             =   1080
      Width           =   615
   End
   Begin VB.TextBox Text1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H80000004&
      Enabled         =   0   'False
      Height          =   285
      Left            =   9240
      MaxLength       =   7
      RightToLeft     =   -1  'True
      TabIndex        =   0
      Top             =   240
      Width           =   975
   End
   Begin MSRDC.MSRDC book1 
      Height          =   330
      Left            =   0
      Top             =   8160
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
      RecordSource    =   "select * from book"
      UserName        =   "ABBAS"
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "book1"
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
   Begin MSRDC.MSRDC coding13 
      Height          =   495
      Left            =   0
      Top             =   7680
      Visible         =   0   'False
      Width           =   1815
      _ExtentX        =   3201
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
      RecordSource    =   "select *from view_coding13"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "coding13"
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
   Begin VB.Shape Shape6 
      Height          =   5775
      Left            =   0
      Top             =   840
      Width           =   1215
   End
   Begin VB.Label Label21 
      BackColor       =   &H00FFC0FF&
      Caption         =   "‰Ê⁄ «·Ê⁄«¡ "
      Height          =   255
      Left            =   4680
      TabIndex        =   41
      Top             =   5040
      Width           =   735
   End
   Begin VB.Label Label20 
      BackColor       =   &H00FFC0FF&
      Caption         =   "—ﬁ„ ﬂ« —"
      Height          =   255
      Left            =   7080
      TabIndex        =   40
      Top             =   5040
      Width           =   735
   End
   Begin VB.Label Label19 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0FF&
      Caption         =   "—ﬁ„ œÌÊÌ "
      Height          =   255
      Left            =   10680
      TabIndex        =   39
      Top             =   5040
      Width           =   975
   End
   Begin VB.Label Label18 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0FF&
      Caption         =   "»Ì«‰«  «· ’‰Ì›"
      Height          =   255
      Left            =   8040
      TabIndex        =   38
      Top             =   4680
      Width           =   1215
   End
   Begin VB.Shape Shape3 
      BackColor       =   &H80000001&
      Height          =   615
      Left            =   1560
      Top             =   4800
      Width           =   10215
   End
   Begin VB.Label Label17 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0FF&
      Caption         =   "„ —Ã„"
      Height          =   375
      Left            =   3600
      TabIndex        =   37
      Top             =   3960
      Width           =   735
   End
   Begin VB.Label Label16 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0FF&
      Caption         =   ": «·”⁄—"
      Height          =   255
      Left            =   10440
      TabIndex        =   36
      Top             =   4080
      Width           =   1215
   End
   Begin VB.Label Label15 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0FF&
      Caption         =   " «—ÌŒ «·Ê’Ê· «·Ï «·„ﬂ »…"
      Height          =   495
      Left            =   3360
      TabIndex        =   35
      Top             =   3360
      Width           =   975
   End
   Begin VB.Label Label14 
      BackColor       =   &H00FFC0FF&
      Caption         =   ":  ⁄œœ «·‰”Œ"
      Height          =   255
      Left            =   8160
      TabIndex        =   34
      Top             =   3360
      Width           =   855
   End
   Begin VB.Label Label13 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0FF&
      Caption         =   ":Ê”Ì·… «·«ﬁ ‰«¡ "
      Height          =   255
      Left            =   10440
      TabIndex        =   33
      Top             =   3360
      Width           =   1215
   End
   Begin VB.Label Label12 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0FF&
      Caption         =   "»Ì«‰«  «·„ «»⁄… "
      Height          =   255
      Left            =   7440
      TabIndex        =   32
      Top             =   3000
      Width           =   1455
   End
   Begin VB.Shape Shape1 
      Height          =   1335
      Left            =   1440
      Top             =   3120
      Width           =   10335
   End
   Begin VB.Label Label11 
      BackColor       =   &H00FFC0FF&
      Caption         =   "—ﬁ„ «·„ ”·”·"
      Height          =   375
      Left            =   3360
      TabIndex        =   31
      Top             =   2040
      Width           =   975
   End
   Begin VB.Label Label10 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0FF&
      Caption         =   "·€… «·Ê⁄«¡"
      Height          =   375
      Left            =   8160
      TabIndex        =   30
      Top             =   2520
      Width           =   855
   End
   Begin VB.Label Label9 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0FF&
      Caption         =   "—œ„‹‹‹ﬂ"
      Height          =   255
      Left            =   10800
      TabIndex        =   29
      Top             =   2520
      Width           =   855
   End
   Begin VB.Label Label8 
      BackColor       =   &H00FFC0FF&
      Caption         =   "—ﬁ„ «·”·”·…"
      Height          =   255
      Left            =   3360
      TabIndex        =   28
      Top             =   1560
      Width           =   855
   End
   Begin VB.Label Label7 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0FF&
      Caption         =   "⁄‰Ê«‰ «·”·”·…"
      Height          =   375
      Left            =   10320
      TabIndex        =   27
      Top             =   1680
      Width           =   1215
   End
   Begin VB.Label Label6 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0FF&
      Caption         =   "ÕÃ„ «·Ê⁄«¡ "
      Height          =   255
      Left            =   3240
      TabIndex        =   26
      Top             =   1080
      Width           =   855
   End
   Begin VB.Label Label5 
      BackColor       =   &H00FFC0FF&
      Caption         =   "⁄œœ «·«Ã“«¡"
      Height          =   255
      Left            =   7920
      TabIndex        =   25
      Top             =   1080
      Width           =   855
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0FF&
      Caption         =   "«·’›Õ« "
      Height          =   255
      Left            =   10680
      TabIndex        =   24
      Top             =   1080
      Width           =   855
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFC0FF&
      Caption         =   "«·»Ì«‰«  «·„«œÌ… ··Ê⁄«¡ «·„⁄·Ê„« Ì"
      Height          =   255
      Left            =   8880
      TabIndex        =   23
      Top             =   720
      Width           =   2295
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H00FFC0FF&
      Caption         =   "—ﬁ„ «·«” „«—… "
      Height          =   255
      Left            =   10200
      TabIndex        =   1
      Top             =   240
      Width           =   1335
   End
   Begin VB.Shape Shape2 
      BackColor       =   &H80000001&
      Height          =   2055
      Left            =   1440
      Top             =   960
      Width           =   10335
   End
End
Attribute VB_Name = "Form7"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command1_Click()
 Dim cn As New rdoConnection
 Dim SQL As String
 'Dim m_date As Date

 'm_date = Text2.Text
       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
   ' MsgBox DBCombo5.BoundText
       SQL = "execute upd_BOOK1 " & "'" & Text1.Text & "'" & "," & "'" & m_pg_no.Text & "'" & "," _
        & "'" & m_prt_no.Text & "'" & "," & "'" & m_vol.Text & "'" & "," _
        & "'" & m_ser_ttl.Text & "'" & "," & "'" & m_ser_no.Text & "'" & "," _
        & "'" & m_rdmk.Text & "'" & "," & "'" & m_lang.Text & "'" & "," _
        & "'" & m_reg_no.Text & "'" & "," & "'" & Mid(m_pub_typ.BoundText, 3, 2) & "'" & "," _
        & "'" & m_no_cp.Text & "'" & "," & "'" & Format(m_iktdte.Text, "dd/mm/yy") & "'" & "," _
        & "'" & m_prix.Text & "'" & "," & "'" & m_mtrjm.ListIndex & "'" & "," _
        & "'" & m_slct_no.Text & "'" & "," & "'" & m_quater.Text & "'" & "," _
         & "'" & m_wath_ty.ListIndex & "'"
        
        cn.Execute SQL, rdExecDirect

End Sub

Private Sub Command2_Click()
 Unload Form7
 
 End Sub

Private Sub Command3_Click()
 Dim cn As New rdoConnection
 Dim SQL As String
Dim is_save As String
  is_save = "'"
  is_save = InputBox("Â·  —Ìœ  ”ÃÌ· «·„⁄·Ê„«  ‰/ﬂ)")
 If is_save = "y" Then
            cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
   ' MsgBox DBCombo5.BoundText
       SQL = "execute upd_BOOK1 " & "'" & Text1.Text & "'" & "," & "'" & m_pg_no.Text & "'" & "," _
        & "'" & m_prt_no.Text & "'" & "," & "'" & m_vol.Text & "'" & "," _
        & "'" & m_ser_ttl.Text & "'" & "," & "'" & m_ser_no.Text & "'" & "," _
        & "'" & m_rdmk.Text & "'" & "," & "'" & m_lang.Text & "'" & "," _
        & "'" & m_reg_no.Text & "'" & "," & "'" & Mid(m_pub_typ.BoundText, 3, 2) & "'" & "," _
        & "'" & m_no_cp.Text & "'" & "," & "'" & Format(m_iktdte.Text, "dd/mm/yy") & "'" & "," _
        & "'" & m_prix.Text & "'" & "," & "'" & m_mtrjm.ListIndex & "'" & "," _
        & "'" & m_slct_no.Text & "'" & "," & "'" & m_quater.Text & "'" & "," _
         & "'" & m_wath_ty.ListIndex & "'"
        
        cn.Execute SQL, rdExecDirect
       mod_typ = 2
       book1.Refresh
Else
 'm_date = Text2.Text
       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
   ' MsgBox DBCombo5.BoundText
       SQL = "execute upd_BOOK1 " & "'" & Text1.Text & "'" & "," & "'" & m_pg_no.Text & "'" & "," _
        & "'" & m_prt_no.Text & "'" & "," & "'" & m_vol.Text & "'" & "," _
        & "'" & m_ser_ttl.Text & "'" & "," & "'" & m_ser_no.Text & "'" & "," _
        & "'" & m_rdmk.Text & "'" & "," & "'" & m_lang.Text & "'" & "," _
        & "'" & m_reg_no.Text & "'" & "," & "'" & Mid(m_pub_typ.BoundText, 3, 2) & "'" & "," _
        & "'" & m_no_cp.Text & "'" & "," & "'" & Format(m_iktdte.Text, "dd/mm/yy") & "'" & "," _
        & "'" & m_prix.Text & "'" & "," & "'" & m_mtrjm.ListIndex & "'" & "," _
        & "'" & m_slct_no.Text & "'" & "," & "'" & m_quater.Text & "'" & "," _
         & "'" & m_wath_ty.ListIndex & "'"
        
        cn.Execute SQL, rdExecDirect
End If
Screen.MousePointer = vbDefault
 Screen.MousePointer = vbHourglass
 Form2.WindowState = 2
 Form2.Show
 Screen.MousePointer = vbDefault

End Sub

Private Sub Command4_Click()
If typ_serh = 2 Then
 book1.SQL = "select *from book"
 book1.Refresh
 typ_serh = 1
End If

If Not book1.Resultset.EOF Then
   book1.Resultset.MoveNext
End If
If Not book1.Resultset.EOF Then
 Text1.Text = book1.Resultset![bk_app_no]
   If Not IsNull(book1.Resultset![bk_pg_no]) Then
     m_pg_no.Text = book1.Resultset![bk_pg_no]
   Else
    m_pg_no.Text = 0
   End If
If Not IsNull(book1.Resultset![bk_prt_no]) Then
     m_prt_no.Text = book1.Resultset![bk_prt_no]
   Else
    m_prt_no.Text = 0
   End If
 If Not IsNull(book1.Resultset![bk_vol]) Then
     m_vol.Text = book1.Resultset![bk_vol]
   Else
    m_vol.Text = 0
   End If
  
   If Not IsNull(book1.Resultset![bk_ser_ttl]) Then
     m_ser_ttl.Text = book1.Resultset![bk_ser_ttl]
   Else
     m_ser_ttl.Text = ""
   End If
   If Not IsNull(book1.Resultset![bk_ser_no]) Then
     m_ser_no.Text = book1.Resultset![bk_ser_no]
   Else
     m_ser_no.Text = 0
   End If
       If Not IsNull(book1.Resultset![bk_rdmk]) Then
     m_rdmk.Text = book1.Resultset![bk_rdmk]
   Else
     m_rdmk.Text = ""
   End If
   If Not IsNull(book1.Resultset![bk_reg_no]) Then
     m_reg_no.Text = book1.Resultset![bk_reg_no]
   Else
     m_reg_no.Text = 0
   End If
   If Not IsNull(book1.Resultset![bk_pub_typ]) Then
     m_pub_typ.BoundText = "13" + book1.Resultset![bk_pub_typ]
   Else
     m_pub_typ.BoundText = "  "
   End If
If Not IsNull(book1.Resultset![bk_no_cp]) Then
     m_no_cp.Text = book1.Resultset![bk_no_cp]
   Else
     m_no_cp.Text = 0
   End If
   If Not IsNull(book1.Resultset![bk_iktdte]) Then
     m_iktdte.Text = book1.Resultset![bk_iktdte]
   Else
     m_iktdte.Text = ""
   End If
   If Not IsNull(book1.Resultset![bk_prix]) Then
     m_prix.Text = book1.Resultset![bk_prix]
   Else
     m_prix.Text = 0
   End If
   If Not IsNull(book1.Resultset![bk_mtrjm]) Then
    m_mtrjm.ListIndex = book1.Resultset![bk_mtrjm]
   Else
     m_mtrjm.ListIndex = 0
   End If
   If Not IsNull(book1.Resultset![bk_slct_no]) Then
     m_slct_no.Text = book1.Resultset![bk_slct_no]
   Else
     m_slct_no.Text = ""
   End If
   If Not IsNull(book1.Resultset![bk_quater]) Then
     m_quater.Text = book1.Resultset![bk_quater]
   Else
     m_quater.Text = ""
   End If
    If Not IsNull(book1.Resultset![bk_wath_ty]) Then
    m_wath_ty.ListIndex = book1.Resultset![bk_wath_ty]
   Else
     m_wath_ty.ListIndex = 0
   End If

Else
 MsgBox "·« ÌÊÃœ «” „«—… ”«»ﬁ…"
End If
End Sub

Private Sub Command5_Click()
If typ_serh = 2 Then
 book1.SQL = "select *from book"
 book1.Refresh
 typ_serh = 1
End If
If Not book1.Resultset.BOF Then
book1.Resultset.MovePrevious
End If
If Not book1.Resultset.BOF Then
 Text1.Text = book1.Resultset![bk_app_no]
   If Not IsNull(book1.Resultset![bk_pg_no]) Then
     m_pg_no.Text = book1.Resultset![bk_pg_no]
   Else
    m_pg_no.Text = 0
   End If
If Not IsNull(book1.Resultset![bk_prt_no]) Then
     m_prt_no.Text = book1.Resultset![bk_prt_no]
   Else
    m_prt_no.Text = 0
   End If
 If Not IsNull(book1.Resultset![bk_vol]) Then
     m_vol.Text = book1.Resultset![bk_vol]
   Else
    m_vol.Text = 0
   End If
  
   If Not IsNull(book1.Resultset![bk_ser_ttl]) Then
     m_ser_ttl.Text = book1.Resultset![bk_ser_ttl]
   Else
     m_ser_ttl.Text = ""
   End If
   If Not IsNull(book1.Resultset![bk_ser_no]) Then
     m_ser_no.Text = book1.Resultset![bk_ser_no]
   Else
     m_ser_no.Text = 0
   End If
       If Not IsNull(book1.Resultset![bk_rdmk]) Then
     m_rdmk.Text = book1.Resultset![bk_rdmk]
   Else
     m_rdmk.Text = ""
   End If
   If Not IsNull(book1.Resultset![bk_reg_no]) Then
     m_reg_no.Text = book1.Resultset![bk_reg_no]
   Else
     m_reg_no.Text = 0
   End If
   If Not IsNull(book1.Resultset![bk_pub_typ]) Then
     m_pub_typ.BoundText = "13" + book1.Resultset![bk_pub_typ]
    Else
    m_pub_typ.BoundText = ""
End If
If Not IsNull(book1.Resultset![bk_no_cp]) Then
     m_no_cp.Text = book1.Resultset![bk_no_cp]
   Else
     m_no_cp.Text = 0
   End If
   If Not IsNull(book1.Resultset![bk_iktdte]) Then
     m_iktdte.Text = book1.Resultset![bk_iktdte]
   Else
     m_iktdte.Text = ""
   End If
   If Not IsNull(book1.Resultset![bk_prix]) Then
     m_prix.Text = book1.Resultset![bk_prix]
   Else
     m_prix.Text = 0
   End If
   If Not IsNull(book1.Resultset![bk_mtrjm]) Then
    m_mtrjm.ListIndex = book1.Resultset![bk_mtrjm]
   Else
     m_mtrjm.ListIndex = 0
   End If
   If Not IsNull(book1.Resultset![bk_slct_no]) Then
     m_slct_no.Text = book1.Resultset![bk_slct_no]
   Else
     m_slct_no.Text = ""
   End If
   If Not IsNull(book1.Resultset![bk_quater]) Then
     m_quater.Text = book1.Resultset![bk_quater]
   Else
     m_quater.Text = ""
   End If
    If Not IsNull(book1.Resultset![bk_wath_ty]) Then
    m_wath_ty.ListIndex = book1.Resultset![bk_wath_ty]
   Else
     m_wath_ty.ListIndex = 0
   End If

Else
 MsgBox "·« ÌÊÃœ «” „«—… ”«»ﬁ…"
End If
  
End Sub

Private Sub Command6_Click()

End Sub

Private Sub Command7_Click()
Dim cn As New rdoConnection
Dim SQL As String
Dim M_MN_APP_NO As String
Const None As String = ""
M_MN_APP_NO = ""
M_MN_APP_NO = InputBox("«œŒ· —ﬁ„ «·«” „«—… : ")
M_MN_APP_NO = M_MN_APP_NO
book1.SQL = "exec SERCH_BOOK " & "'" & M_MN_APP_NO & "'"
book1.Refresh
typ_serh = 2
If Not book1.Resultset.EOF Or Not book1.Resultset.BOF Then
 Text1.Text = M_MN_APP_NO
  If Not IsNull(book1.Resultset![bk_pg_no]) Then
     m_pg_no.Text = book1.Resultset![bk_pg_no]
   Else
    m_pg_no.Text = 0
   End If
If Not IsNull(book1.Resultset![bk_prt_no]) Then
     m_prt_no.Text = book1.Resultset![bk_prt_no]
   Else
    m_prt_no.Text = 0
   End If
 If Not IsNull(book1.Resultset![bk_vol]) Then
     m_vol.Text = book1.Resultset![bk_vol]
   Else
    m_vol.Text = 0
   End If
  
   If Not IsNull(book1.Resultset![bk_ser_ttl]) Then
     m_ser_ttl.Text = book1.Resultset![bk_ser_ttl]
   Else
     m_ser_ttl.Text = ""
   End If
   If Not IsNull(book1.Resultset![bk_ser_no]) Then
     m_ser_no.Text = book1.Resultset![bk_ser_no]
   Else
     m_ser_no.Text = 0
   End If
       If Not IsNull(book1.Resultset![bk_rdmk]) Then
     m_rdmk.Text = book1.Resultset![bk_rdmk]
   Else
     m_rdmk.Text = ""
   End If
   If Not IsNull(book1.Resultset![bk_reg_no]) Then
     m_reg_no.Text = book1.Resultset![bk_reg_no]
   Else
     m_reg_no.Text = 0
   End If
   If Not IsNull(book1.Resultset![bk_pub_typ]) Then
     m_pub_typ.BoundText = "13" + book1.Resultset![bk_pub_typ]
   Else
     m_pub_typ.BoundText = "  "
   End If
If Not IsNull(book1.Resultset![bk_no_cp]) Then
     m_no_cp.Text = book1.Resultset![bk_no_cp]
   Else
     m_no_cp.Text = 0
   End If
   If Not IsNull(book1.Resultset![bk_iktdte]) Then
     m_iktdte.Text = book1.Resultset![bk_iktdte]
   Else
     m_iktdte.Text = ""
   End If
   If Not IsNull(book1.Resultset![bk_prix]) Then
     m_prix.Text = book1.Resultset![bk_prix]
   Else
     m_prix.Text = 0
   End If
   If Not IsNull(book1.Resultset![bk_mtrjm]) Then
    m_mtrjm.ListIndex = book1.Resultset![bk_mtrjm]
   Else
     m_mtrjm.ListIndex = 0
   End If
   If Not IsNull(book1.Resultset![bk_slct_no]) Then
     m_slct_no.Text = book1.Resultset![bk_slct_no]
   Else
     m_slct_no.Text = ""
   End If
   If Not IsNull(book1.Resultset![bk_quater]) Then
     m_quater.Text = book1.Resultset![bk_quater]
   Else
     m_quater.Text = ""
   End If
    If Not IsNull(book1.Resultset![bk_wath_ty]) Then
    m_wath_ty.ListIndex = book1.Resultset![bk_wath_ty]
   Else
     m_wath_ty.ListIndex = 0
   End If
Else
 MsgBox "·« ÌÊÃœ «” „«—… ·Â–« «·—ﬁ„ !!!!"
End If

End Sub

 
Private Sub Form_Load()
Dim cn As New rdoConnection
   Dim SQL As String
   Dim qd As rdoQuery
  
 Text1.Text = FORM1.Text1.Text
 book1.SQL = "exec SERCH_BOOK " & "'" & Text1.Text & "'"
book1.Refresh
typ_serh = 2
If Not book1.Resultset.EOF Or Not book1.Resultset.BOF Then
   If Not IsNull(book1.Resultset![bk_pg_no]) Then
     m_pg_no.Text = book1.Resultset![bk_pg_no]
   Else
    m_pg_no.Text = ""
   End If
If Not IsNull(book1.Resultset![bk_prt_no]) Then
     m_prt_no.Text = book1.Resultset![bk_prt_no]
   Else
    m_prt_no.Text = ""
   End If
 If Not IsNull(book1.Resultset![bk_vol]) Then
     m_vol.Text = book1.Resultset![bk_vol]
   Else
    m_vol.Text = ""
   End If
  
   If Not IsNull(book1.Resultset![bk_ser_ttl]) Then
     m_ser_ttl.Text = book1.Resultset![bk_ser_ttl]
   Else
     m_ser_ttl.Text = ""
   End If
   If Not IsNull(book1.Resultset![bk_ser_no]) Then
     m_ser_no.Text = book1.Resultset![bk_ser_no]
   Else
     m_ser_no.Text = ""
   End If
       If Not IsNull(book1.Resultset![bk_rdmk]) Then
     m_rdmk.Text = book1.Resultset![bk_rdmk]
   Else
     m_rdmk.Text = ""
   End If
   If Not IsNull(book1.Resultset![bk_reg_no]) Then
     m_reg_no.Text = book1.Resultset![bk_reg_no]
   Else
     m_reg_no.Text = ""
   End If
  If Not IsNull(book1.Resultset![bk_pub_typ]) Then
     m_pub_typ.BoundText = "13" + book1.Resultset![bk_pub_typ]
   Else
     m_pub_typ.BoundText = "  "
   End If
If Not IsNull(book1.Resultset![bk_no_cp]) Then
     m_no_cp.Text = book1.Resultset![bk_no_cp]
   Else
     m_no_cp.Text = ""
   End If
   If Not IsNull(book1.Resultset![bk_iktdte]) Then
     m_iktdte.Text = book1.Resultset![bk_iktdte]
   Else
     m_iktdte.Text = ""
   End If
   If Not IsNull(book1.Resultset![bk_prix]) Then
     m_prix.Text = book1.Resultset![bk_prix]
   Else
     m_prix.Text = ""
   End If
   If Not IsNull(book1.Resultset![bk_mtrjm]) Then
    m_mtrjm.ListIndex = book1.Resultset![bk_mtrjm]
   Else
     m_mtrjm.ListIndex = 0
   End If
   If Not IsNull(book1.Resultset![bk_slct_no]) Then
     m_slct_no.Text = book1.Resultset![bk_slct_no]
   Else
     m_slct_no.Text = ""
   End If
   If Not IsNull(book1.Resultset![bk_quater]) Then
     m_quater.Text = book1.Resultset![bk_quater]
   Else
     m_quater.Text = ""
   End If
    If Not IsNull(book1.Resultset![bk_wath_ty]) Then
    m_wath_ty.ListIndex = book1.Resultset![bk_wath_ty]
   Else
     m_wath_ty.ListIndex = 0
   End If
 End If
     
 End Sub

 

Private Sub m_pg_no_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
     m_prt_no.SetFocus
   End If
End Sub
Private Sub m_prt_no_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
     m_vol.SetFocus
   End If
End Sub

Private Sub m_vol_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
     m_ser_ttl.SetFocus
   End If
End Sub
Private Sub m_ser_ttl_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
     m_ser_no.SetFocus
   End If
End Sub
Private Sub m_ser_no_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
     m_rdmk.SetFocus
   End If
End Sub
Private Sub m_rdmk_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
     m_lang.SetFocus
     SendKeys "^{f4}"
   End If
End Sub
Private Sub m_lang_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
     m_reg_no.SetFocus
   End If
End Sub
Private Sub m_reg_no_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
     m_pub_typ.SetFocus
     SendKeys "^{f4}"
   End If
End Sub
Private Sub m_pub_typ_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
     m_no_cp.SetFocus
   End If
End Sub
Private Sub m_no_cp_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
     m_iktdte.SetFocus
   End If
End Sub
Private Sub m_iktdte_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
     m_prix.SetFocus
   End If
End Sub
Private Sub m_prix_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
     m_mtrjm.SetFocus
     SendKeys "^{f4}"
   End If
End Sub
Private Sub m_mtrjm_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
     m_slct_no.SetFocus
   End If
End Sub
Private Sub m_slct_no_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
     m_quater.SetFocus
   End If
End Sub
Private Sub m_quater_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
     m_wath_ty.SetFocus
     SendKeys "^{f4}"
   End If
End Sub



Private Sub m_wath_ty_KeyPress(KeyAscii As Integer)
 Command3.SetFocus
End Sub
