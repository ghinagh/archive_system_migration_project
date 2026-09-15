VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Begin VB.Form Form11 
   Caption         =   "ÈÑäÜÜÇãÜÌ æÕæá ÇáÏæÑíÜÜÇÊ"
   ClientHeight    =   8595
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11880
   LinkTopic       =   "Form11"
   RightToLeft     =   -1  'True
   ScaleHeight     =   8595
   ScaleWidth      =   11880
   Begin VB.ComboBox m_trs_typ 
      Height          =   315
      ItemData        =   "trs_period.frx":0000
      Left            =   4080
      List            =   "trs_period.frx":000D
      RightToLeft     =   -1  'True
      TabIndex        =   22
      Top             =   2280
      Width           =   1455
   End
   Begin VB.TextBox m_trs_num 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   9600
      RightToLeft     =   -1  'True
      TabIndex        =   16
      Top             =   2280
      Width           =   735
   End
   Begin VB.TextBox m_trs_year 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   8040
      RightToLeft     =   -1  'True
      TabIndex        =   15
      Top             =   2280
      Width           =   855
   End
   Begin VB.CommandButton Command7 
      Caption         =   "ÎÑæÌ"
      Height          =   495
      Left            =   2280
      RightToLeft     =   -1  'True
      TabIndex        =   14
      Top             =   4320
      Width           =   855
   End
   Begin VB.CommandButton Command6 
      Caption         =   "ÇáÛÇÁ"
      Height          =   495
      Left            =   3480
      RightToLeft     =   -1  'True
      TabIndex        =   13
      Top             =   4320
      Width           =   975
   End
   Begin VB.CommandButton Command5 
      Caption         =   "ÓÇÈÞ"
      Height          =   495
      Left            =   4800
      RightToLeft     =   -1  'True
      TabIndex        =   12
      Top             =   4320
      Width           =   975
   End
   Begin VB.CommandButton Command4 
      Caption         =   "áÇÍÞ"
      Height          =   495
      Left            =   6120
      RightToLeft     =   -1  'True
      TabIndex        =   11
      Top             =   4320
      Width           =   1095
   End
   Begin VB.CommandButton Command3 
      Caption         =   "ÈÍË"
      Height          =   495
      Left            =   7560
      RightToLeft     =   -1  'True
      TabIndex        =   10
      Top             =   4320
      Width           =   975
   End
   Begin VB.CommandButton Command2 
      Caption         =   "ÊÓÌíÜá"
      Height          =   495
      Left            =   8760
      RightToLeft     =   -1  'True
      TabIndex        =   9
      Top             =   4320
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "ÇÖÜÜÇÝÉ"
      Height          =   495
      Left            =   10080
      RightToLeft     =   -1  'True
      TabIndex        =   8
      Top             =   4320
      Width           =   975
   End
   Begin VB.TextBox m_trs_nb 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   6720
      RightToLeft     =   -1  'True
      TabIndex        =   7
      Top             =   2280
      Width           =   615
   End
   Begin VB.TextBox m_trs_dte 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   4080
      RightToLeft     =   -1  'True
      TabIndex        =   5
      Top             =   1560
      Width           =   1575
   End
   Begin MSDBCtls.DBCombo m_trs_no 
      Bindings        =   "trs_period.frx":0023
      Height          =   315
      Left            =   3840
      TabIndex        =   3
      Top             =   600
      Width           =   3015
      _ExtentX        =   5318
      _ExtentY        =   556
      _Version        =   393216
      ListField       =   "PER_PER_NA"
      BoundColumn     =   "PER_PER_NO"
      Text            =   ""
      RightToLeft     =   -1  'True
   End
   Begin VB.TextBox m_trs_dte1 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   8880
      RightToLeft     =   -1  'True
      TabIndex        =   2
      Top             =   1440
      Width           =   1455
   End
   Begin VB.TextBox m_trs_opno 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   9120
      RightToLeft     =   -1  'True
      TabIndex        =   0
      Top             =   720
      Width           =   1215
   End
   Begin MSRDC.MSRDC period 
      Align           =   2  'Align Bottom
      Height          =   375
      Left            =   0
      Top             =   8220
      Visible         =   0   'False
      Width           =   11880
      _ExtentX        =   20955
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
      RecordSource    =   "select * from trans"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "                                                           ÇÖÛØ Úáì Óåã Çáíãä æÇáíÓÑ áÊäÞá Ýí ÓÌáÇÊ ÇáãáÝ"
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
   Begin MSRDC.MSRDC PERIOD1 
      Height          =   375
      Left            =   0
      Top             =   7800
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
      RecordSource    =   "select * from period order by per_per_na"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "period"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   178
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSRDC.MSRDC perd 
      Height          =   375
      Left            =   240
      Top             =   6480
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
      RecordSource    =   "select * from period"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
      LogMessages     =   ""
      Caption         =   "perd"
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
      Caption         =   "ÚÏÏ ÇáãÌáÏ"
      Height          =   375
      Left            =   10320
      RightToLeft     =   -1  'True
      TabIndex        =   21
      Top             =   2280
      Width           =   855
   End
   Begin VB.Shape Shape1 
      Height          =   3135
      Left            =   360
      Top             =   360
      Width           =   11055
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      Caption         =   "ÑÞã ÇáÚãáíÉ   "
      Height          =   255
      Left            =   10440
      RightToLeft     =   -1  'True
      TabIndex        =   20
      Top             =   720
      Width           =   735
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      Caption         =   "ÇÓã ÇáÏæÑíÉ"
      Height          =   255
      Left            =   6840
      RightToLeft     =   -1  'True
      TabIndex        =   19
      Top             =   600
      Width           =   855
   End
   Begin VB.Label Label8 
      Alignment       =   1  'Right Justify
      Caption         =   "äæÚ ÇáæÕæá :"
      Height          =   375
      Left            =   5400
      RightToLeft     =   -1  'True
      TabIndex        =   18
      Top             =   2280
      Width           =   1095
   End
   Begin VB.Label Label6 
      Alignment       =   1  'Right Justify
      Caption         =   "ÇáÓäÉ :"
      Height          =   255
      Left            =   8760
      RightToLeft     =   -1  'True
      TabIndex        =   17
      Top             =   2400
      Width           =   615
   End
   Begin VB.Shape Shape2 
      Height          =   855
      Left            =   480
      Top             =   4080
      Width           =   10815
   End
   Begin VB.Label Label7 
      Alignment       =   1  'Right Justify
      Caption         =   "ÇáÚÏÏ :"
      Height          =   255
      Left            =   7080
      RightToLeft     =   -1  'True
      TabIndex        =   6
      Top             =   2280
      Width           =   615
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      Caption         =   "ÊÇÑíÎ ÇáÏæÑíÉ"
      Height          =   255
      Left            =   5640
      RightToLeft     =   -1  'True
      TabIndex        =   4
      Top             =   1560
      Width           =   975
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      Caption         =   "ÇáÊÇÑíÎ :"
      Height          =   255
      Left            =   10320
      RightToLeft     =   -1  'True
      TabIndex        =   1
      Top             =   1440
      Width           =   615
   End
End
Attribute VB_Name = "Form11"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim m_opr_typ As Integer
Dim m_typ_serh As Integer
Function display_trs()
       If Not IsNull(period.Resultset![TRS_OPNO]) Then
          m_trs_opno.Text = period.Resultset![TRS_OPNO]
       End If
      If Not IsNull(period.Resultset![trs_no]) Then
           m_trs_no.BoundText = period.Resultset![trs_no]
        Else
           m_trs_no.BoundText = ""
       End If
        
       If Not IsNull(period.Resultset![trs_dte]) Then
         m_trs_dte.Text = period.Resultset![trs_dte]
         
       Else
        m_trs_dte.Text = ""
       End If
       If Not IsNull(period.Resultset![trs_dte1]) Then
         m_trs_dte1.Text = period.Resultset![trs_dte1]
       Else
        m_trs_dte1.Text = ""
       End If
     
       If Not IsNull(period.Resultset![trs_num]) Then
         m_trs_num.Text = period.Resultset![trs_num]
       Else
        m_trs_num.Text = ""
       End If
              If Not IsNull(period.Resultset![trs_nb]) Then
         m_trs_nb.Text = period.Resultset![trs_nb]
       Else
        m_trs_nb.Text = ""
       End If

          If Not IsNull(period.Resultset![trs_year]) Then
         m_trs_year.Text = period.Resultset![trs_year]
       Else
        m_trs_year.Text = ""
       End If
         If Not IsNull(period.Resultset![trs_typ]) Then
         m_trs_typ.ListIndex = Val(period.Resultset![trs_typ])
       Else
           m_trs_typ.Text = ""
       End If

End Function

Private Sub Command1_Click()
Dim qd As rdoQuery
Dim CRIT As String
  Dim cn As New rdoConnection
   Dim SQL As String
m_opr_typ = 1
m_trs_dte1.Text = Date
m_trs_dte.Text = Date
m_trs_nb.Text = 1
m_trs_no.BoundText = ""
 m_trs_num.Text = ""
 m_trs_typ.ListIndex = 1
 m_trs_year.Text = Year(Date)
 'period.Resultset.MoveLast
      
             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
            cn.EstablishConnection rdDriverNoPrompt
        
      m_date = Date - 300
      M_DTE = Format(m_date, "yyyy/mm/dd")
     CRIT = "select  *  from view_trans  where  " & "TRS_DTE1 > " & "'" & M_DTE & "'"
     Set qd = cn.CreateQuery("view_abb1", CRIT)
     perd.SQL = qd.SQL
     perd.Refresh
     perd.Resultset.MoveLast
     
      m_no = perd.Resultset![TRS_OPNO]
       m_no = m_no + 1
     m_trs_opno.Text = m_no
      m_trs_opno.SetFocus
  
  
End Sub

Private Sub Command2_Click()
 Dim cn As New rdoConnection
 Dim SQL As String
 Dim m_bk_ser As Variant
If m_opr_typ = 1 Then
   
   SQL = "execute insr_trans " & "'" & m_trs_opno.Text & "'" & "," & "'" & m_trs_no.BoundText & "'" & "," _
              & "'" & m_trs_year.Text & "'" & "," & "'" & m_trs_nb.Text & "'" & "," & "'" & Str(m_trs_typ.ListIndex) & "'" & "," _
              & "'" & Format(m_trs_dte1.Text, "yyyy/mm/dd") & "'" & "," & "'" & Format(m_trs_dte.Text, "yyyy/mm/dd") & "'" _
              & "," & "'" & m_trs_num.Text & "'"
 
       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute SQL, rdExecDirect
 
 period.Refresh
Else
   SQL = "execute upd_trans " & "'" & m_trs_opno.Text & "'" & "," & "'" & m_trs_no.BoundText & "'" & "," _
              & "'" & m_trs_year.Text & "'" & "," & "'" & m_trs_nb.Text & "'" & "," & "'" & Str(m_trs_typ.ListIndex) & "'" & "," _
              & "'" & Format(m_trs_dte1.Text, "yyyy/mm/dd") & "'" & "," & "'" & Format(m_trs_dte.Text, "yyyy/mm/dd") & "'" _
                 & "," & "'" & m_trs_num.Text & "'"
                  
              
 
       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
                cn.Execute SQL, rdExecDirect
 
    period.Refresh

End If
End Sub

Private Sub Command3_Click()
m_trs_opno.Text = ""
m_trs_opno.SetFocus
m_typ_serh = 2
End Sub

Private Sub Command4_Click()
  If m_typ_serh = 2 Then
     period.SQL = "select * from trans"
     period.Refresh
    m_typ_serh = 1
  End If
 If Not period.Resultset.EOF Then
   period.Resultset.MoveNext
   If Not period.Resultset.EOF Then
      Call display_trs
   Else
   MsgBox "áÇíæÌÏ ÇÓÊãÇÑÉ áÇÍÞÉ !!!"
   End If

   Else
   MsgBox "áÇíæÌÏ ÇÓÊãÇÑÉ áÇÍÞÉ !!!"
   End If
End Sub

Private Sub Command5_Click()
  If m_typ_serh = 2 Then
     period.SQL = "select * from trans"
     period.Refresh
    m_typ_serh = 1
  End If
   
   If Not period.Resultset.BOF Then
   period.Resultset.MovePrevious
   If Not period.Resultset.BOF Then
   Call display_trs
   Else
   MsgBox "áÇíæÌÏ  ÇÓÊãÇÑÉ  ÓÇÈÞÉ!!!"
   End If
Else
   MsgBox "áÇíæÌÏ  ÇÓÊãÇÑÉ  ÓÇÈÞÉ!!!"
   End If

End Sub

Private Sub Command6_Click()
  m_trs_opno.Text = ""
  m_trs_opno.SetFocus
  m_typ_serh = 3
End Sub


Private Sub Command7_Click()
Unload Form11
End Sub

Private Sub Form_Load()
m_typ_serh = 1
 m_opr_typ = 2
m_trs_dte1.Text = ""
m_trs_dte.Text = ""
m_trs_nb.Text = 1
m_trs_no.BoundText = ""
 m_trs_num.Text = ""
 m_trs_typ.ListIndex = 0
 m_trs_no.Text = ""
 
End Sub


Private Sub m_trs_dte_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
       m_trs_num.SetFocus
    End If
End Sub

Private Sub m_trs_dte1_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
       m_trs_dte.SetFocus
    
    End If

End Sub

Private Sub m_trs_nb_KeyPress(KeyAscii As Integer)
       
  If KeyAscii = 13 Then
       m_trs_typ.SetFocus
        SendKeys "^{f4}"
       
    End If

End Sub

Private Sub m_trs_no_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
       m_trs_dte1.SetFocus
       
    End If
End Sub


Private Sub m_trs_num_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 Then
       m_trs_year.SetFocus
        
    End If
       
End Sub

Private Sub m_trs_opno_KeyPress(KeyAscii As Integer)
      Dim cn As New rdoConnection
       Dim SQL As String

    If KeyAscii = 13 Then
      If m_typ_serh = 2 Then
          period.SQL = "exec serh_trans " & "'" & m_trs_opno.Text & "'"
         period.Refresh
           If Not period.Resultset.EOF Or Not period.Resultset.BOF Then
             Call display_trs
          Else
            MsgBox "áÇ íæÌÏ ÇÓÊãÇÑÉ áåÐÇ ÇáÑÞã !!!!"
            
           End If
       ElseIf m_typ_serh = 3 Then
             Dim ok As String
             Const None As String = ""
             ok = " "
               ok = InputBox("åá ÊÑíÏ ÇáÛÇÁ ÇáãÞÇáÉ(ä/ß)")
             If ok = "y" Or ok = "ä" Then
                          cn.Connect = "uid=;pwd=;server=SEQUEL;" _
                             & "driver={SQL Server};database=macnz;" _
                           & "DSN='';"
     
                        cn.CursorDriver = rdUseOdbc
                        cn.EstablishConnection rdDriverNoPrompt
                       SQL = "exec del_trans " & m_trs_opno.Text
                       cn.Execute SQL, rdExecDirect
                    period.SQL = "select * from trans"
                    period.Refresh
                    If Not period.Resultset.EOF Or Not period.Resultset.BOF Then
                         Call display_trs
                    End If
              End If
       
       End If
       m_trs_no.SetFocus
        SendKeys "^{f4}"
    End If
End Sub

Private Sub m_trs_opno_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyInsert Then
 Dim qd As rdoQuery
Dim CRIT As String
  Dim cn As New rdoConnection
   Dim SQL As String
m_opr_typ = 1
m_trs_dte1.Text = Date
m_trs_dte.Text = Date
m_trs_nb.Text = 1
m_trs_no.BoundText = ""
 m_trs_num.Text = ""
 m_trs_typ.ListIndex = 1
 m_trs_year.Text = Year(Date)
 'period.Resultset.MoveLast
      
             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
            cn.EstablishConnection rdDriverNoPrompt
        
      m_date = Date - 300
      M_DTE = Format(m_date, "yyyy/mm/dd")
     CRIT = "select  *  from view_trans  where  " & "TRS_DTE1 > " & "'" & M_DTE & "'"
     Set qd = cn.CreateQuery("view_abb1", CRIT)
     perd.SQL = qd.SQL
     perd.Refresh
     perd.Resultset.MoveLast
     
      m_no = perd.Resultset![TRS_OPNO]
       m_no = m_no + 1
     m_trs_opno.Text = m_no
      m_trs_opno.SetFocus
  
End If

End Sub

Private Sub m_trs_typ_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
       Command2.SetFocus
       
    End If

End Sub

Private Sub m_trs_year_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 Then
       m_trs_nb.SetFocus
    End If
End Sub
