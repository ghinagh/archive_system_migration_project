VERSION 5.00
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{F0D2F211-CCB0-11D0-A316-00AA00688B10}#1.0#0"; "MSDATLST.OCX"
Begin VB.Form Form5 
   BackColor       =   &H00808080&
   Caption         =   "Form5"
   ClientHeight    =   9600
   ClientLeft      =   990
   ClientTop       =   -165
   ClientWidth     =   20370
   LinkTopic       =   "Form5"
   Moveable        =   0   'False
   ScaleHeight     =   9600
   ScaleWidth      =   20370
   Begin MSAdodcLib.Adodc macnz1 
      Height          =   615
      Left            =   3480
      Top             =   8880
      Visible         =   0   'False
      Width           =   1680
      _ExtentX        =   2963
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
      RecordSource    =   "select * from view_macnz1"
      Caption         =   "macnz1"
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
   Begin MSDataListLib.DataList DataList1 
      Bindings        =   "Form5.frx":0000
      Height          =   2985
      Left            =   14400
      TabIndex        =   19
      Top             =   840
      Width           =   4815
      _ExtentX        =   8493
      _ExtentY        =   5265
      _Version        =   393216
      BackColor       =   12632256
      ListField       =   "SUB_DESC"
      RightToLeft     =   -1  'True
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Œ—ÊÃ"
      Height          =   495
      Left            =   7080
      TabIndex        =   18
      Top             =   7080
      Width           =   1575
   End
   Begin MSRDC.MSRDC macnz 
      Height          =   330
      Left            =   4320
      Top             =   8880
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
      RecordSource    =   "select * from macnz"
      UserName        =   ""
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
   Begin VB.TextBox desc 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   8520
      MaxLength       =   40
      TabIndex        =   14
      Top             =   5880
      Visible         =   0   'False
      Width           =   5895
   End
   Begin VB.TextBox code 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   13080
      TabIndex        =   13
      Top             =   5520
      Visible         =   0   'False
      Width           =   1335
   End
   Begin VB.TextBox Text3 
      BackColor       =   &H00FFFFFF&
      Enabled         =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   4320
      TabIndex        =   12
      TabStop         =   0   'False
      Top             =   4920
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.TextBox Text2 
      BackColor       =   &H00FFFFFF&
      Enabled         =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   10440
      TabIndex        =   11
      Top             =   3840
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.TextBox Text1 
      BackColor       =   &H00FFFFFF&
      Enabled         =   0   'False
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   16200
      TabIndex        =   10
      Top             =   3840
      Width           =   1215
   End
   Begin VB.CommandButton Command4 
      Caption         =   "«·€«¡  (Delete)"
      Height          =   495
      Left            =   10800
      TabIndex        =   8
      Top             =   7080
      Width           =   1695
   End
   Begin VB.CommandButton Command3 
      Caption         =   " ”ÃÌ·"
      Height          =   495
      Left            =   12720
      TabIndex        =   7
      Top             =   7080
      Width           =   1815
   End
   Begin VB.CommandButton Command2 
      Caption         =   " ⁄œÌ·      (F2)"
      Height          =   495
      Left            =   14760
      TabIndex        =   6
      Top             =   7080
      Width           =   1935
   End
   Begin VB.CommandButton Command1 
      Caption         =   "«÷«›…  (insert)"
      Height          =   495
      Left            =   16920
      TabIndex        =   5
      Top             =   7080
      Width           =   1695
   End
   Begin VB.CommandButton Command5 
      Caption         =   "»ÕÀ     (F10)"
      Height          =   495
      Left            =   8880
      TabIndex        =   4
      Top             =   7080
      Width           =   1695
   End
   Begin MSRDC.MSRDC word 
      Height          =   330
      Left            =   5520
      Top             =   8640
      Visible         =   0   'False
      Width           =   2655
      _ExtentX        =   4683
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
      RecordSource    =   "select * from word"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "word"
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
   Begin MSRDC.MSRDC cod3 
      Height          =   330
      Left            =   5280
      Top             =   9240
      Visible         =   0   'False
      Width           =   3135
      _ExtentX        =   5530
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
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "cod3"
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
   Begin MSAdodcLib.Adodc macnz2 
      Height          =   615
      Left            =   9240
      Top             =   8760
      Visible         =   0   'False
      Width           =   1680
      _ExtentX        =   2963
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
      RecordSource    =   "select * from view_macnz1 where sub_code = 'kkkk'"
      Caption         =   "macnz2"
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
   Begin MSDataListLib.DataList DataList2 
      Bindings        =   "Form5.frx":0015
      Height          =   3180
      Left            =   9000
      TabIndex        =   20
      Top             =   600
      Visible         =   0   'False
      Width           =   4575
      _ExtentX        =   8070
      _ExtentY        =   5609
      _Version        =   393216
      BackColor       =   12632256
      ListField       =   "SUB_DESC"
      RightToLeft     =   -1  'True
   End
   Begin MSAdodcLib.Adodc macnz3 
      Height          =   615
      Left            =   9000
      Top             =   8760
      Visible         =   0   'False
      Width           =   1680
      _ExtentX        =   2963
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
      RecordSource    =   "select * from view_macnz1 where sub_code = 'kkkk'"
      Caption         =   "macnz3"
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
   Begin MSDataListLib.DataList DataList3 
      Bindings        =   "Form5.frx":002A
      Height          =   4545
      Left            =   2520
      TabIndex        =   21
      Top             =   360
      Visible         =   0   'False
      Width           =   5295
      _ExtentX        =   9340
      _ExtentY        =   8017
      _Version        =   393216
      BackColor       =   12632256
      ListField       =   "SUB_DESC"
      RightToLeft     =   -1  'True
   End
   Begin VB.Label Label8 
      Alignment       =   2  'Center
      BackColor       =   &H8000000D&
      Caption         =   "«·Ê«’›…"
      Height          =   375
      Left            =   14400
      TabIndex        =   17
      Top             =   5880
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.Label Label7 
      Alignment       =   2  'Center
      BackColor       =   &H8000000D&
      Caption         =   "«·—„“"
      Height          =   375
      Left            =   14400
      TabIndex        =   16
      Top             =   5520
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.Label Label6 
      Alignment       =   2  'Center
      BackColor       =   &H8000000C&
      Caption         =   "„⁄«·Ã« "
      Height          =   255
      Left            =   10200
      RightToLeft     =   -1  'True
      TabIndex        =   15
      Top             =   5040
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.Shape Shape3 
      Height          =   1095
      Left            =   7920
      Top             =   5280
      Visible         =   0   'False
      Width           =   7455
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      BackColor       =   &H8000000C&
      Caption         =   "‘«‘… «·«Ê«„—"
      Height          =   255
      Left            =   15240
      TabIndex        =   9
      Top             =   6720
      Width           =   1695
   End
   Begin VB.Shape Shape4 
      BackColor       =   &H000000FF&
      Height          =   735
      Left            =   6840
      Top             =   6960
      Width           =   11895
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BackColor       =   &H8000000C&
      Caption         =   "«·„” ÊÏ «·À«·À"
      Height          =   375
      Left            =   3480
      TabIndex        =   3
      Top             =   0
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H8000000C&
      Caption         =   "«·„” ÊÏ «·À«‰Ì"
      Height          =   375
      Left            =   10800
      TabIndex        =   2
      Top             =   240
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H8000000C&
      Caption         =   "«·„” ÊÏ «·«Ê·"
      Height          =   375
      Left            =   16920
      TabIndex        =   1
      Top             =   480
      Width           =   1455
   End
   Begin VB.Line Line2 
      Visible         =   0   'False
      X1              =   13560
      X2              =   14280
      Y1              =   2160
      Y2              =   2160
   End
   Begin VB.Line Line1 
      Visible         =   0   'False
      X1              =   7800
      X2              =   9000
      Y1              =   2040
      Y2              =   2040
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H8000000C&
      Caption         =   "„ﬂ‰“ «·„Ê÷Ê⁄« "
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
      Left            =   8400
      TabIndex        =   0
      Top             =   0
      Width           =   2175
   End
End
Attribute VB_Name = "Form5"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim mod_typ As Variant
Dim typ_serh As Integer
Public Function div_word(sw_code As Variant, sw_desc As Variant, m_typ As Variant)
 Dim b, fin_rep   As Boolean
 Dim i, l1 As Integer
 Dim sw_des As String
' Dim cn As New rdoConnection
 Dim sql As String
 find_rep = True
 sw_des = ""
 sw_desc = Trim(sw_desc)
 L = Len(sw_desc)
 m_nb = "0123456789"
 i = 1
'   cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'          & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'            cn.EstablishConnection rdDriverNoPrompt

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
    b = True
   If l1 > 1 Then
        While b
           If Mid(sw_des, 1, 2) = "«·" Then
              sw_des = Mid(sw_des, 3, Len(sw_des) - 2)
           ElseIf Mid(sw_des, 1, 2) = "··" Then
              sw_des = Mid(sw_des, 3, Len(sw_des) - 2)
           ElseIf Mid(sw_des, 1, 2) = "Ê«·" Then
              sw_des = Mid(sw_des, 4, Len(sw_des) - 3)
           ElseIf Mid(sw_des, 1, 1) = "√" Then
            sw_des = "«" + Mid(sw_des, 2, Len(sw_des) - 1)
           Else
            b = False
           End If
       Wend
    End If
    nb = InStr(1, m_nb, Mid(sw_des, 1, 1))
  If Len(sw_des) > 2 And nb = 0 Then
     sql = "exec insr_word " & "'" & sw_des & "'" & "," & "'" & sw_code & "'" _
             & "," & "'" & m_typ & "'"
           
            cn.Execute sql, rdExecDirect
  End If
 Wend
 word.Refresh
 
End Function



Private Sub code_KeyPress(KeyAscii As Integer)
   If KeyAscii = 27 Then
      Label6.Visible = False
      Label7.Visible = False
      Label8.Visible = False
      Shape3.Visible = False
      code.Visible = False
      desc.Visible = False
     If DataList1.Enabled = True Then
       DataList1.SetFocus
     ElseIf DataList2.Enabled = True Then
      DataList2.SetFocus
     ElseIf DataList3.Enabled = True Then
        DataList3.SetFocus
       End If
       SendKeys "{up}"

   ElseIf KeyAscii = 13 Then
      desc.SetFocus
      
   End If
End Sub

Private Sub Command1_Click()
If box_user_no = "244" Then
 
 mod_typ = "1"
  code.Visible = True
  desc.Visible = True
  Label6.Visible = True
  Shape3.Visible = True
  Label7.Visible = True
  Label8.Visible = True
 
 If DataList1.Enabled = True Then
   code.Text = ""
   desc.Text = ""
   code.MaxLength = 9
   
 ElseIf DataList2.Enabled = True Then
   code.Text = ""
   desc.Text = ""
   code.MaxLength = 7
 ElseIf DataList3.Enabled = True Then
     code.Text = ""
   desc.Text = ""
   code.MaxLength = 9
   mod_typ = "2"
    m_sub = Mid(macnz2.Recordset![sub_code], 1, 6)
    sql = "EXECUTE OP_macnz " & "'" & m_sub & "'"
    cn.Execute sql, rdExecDirect
    cod3.sql = "execute max_macnz " & "'" & m_sub & "'"
    cod3.Refresh
    m_cod = m_sub + cod3.Resultset![max1]
   code.Text = m_cod
   code.Refresh
   code.Enabled = False
   desc.Text = ""
    desc.SetFocus
End If
  
End If
End Sub

Private Sub Command2_Click()
  mod_typ = "2"
    If DataList1.Enabled = True Then
      macnz1.Recordset.Bookmark = DataList1.SelectedItem
     code.Text = macnz1.Recordset![sub_code]
     desc.Text = macnz1.Recordset![sub_desc]
  ElseIf DataList2.Enabled = True Then
      macnz2.Recordset.Bookmark = DataList2.SelectedItem
     code.Text = macnz2.Recordset![sub_code]
     desc.Text = macnz2.Recordset![sub_desc]
  ElseIf DataList3.Enabled = True Then
      macnz3.Recordset.Bookmark = DataList3.SelectedItem
     code.Text = macnz3.Recordset![sub_code]
     desc.Text = macnz3.Recordset![sub_desc]
  End If
  code.Visible = True
  desc.Visible = True
  Label6.Visible = True
  Shape3.Visible = True
  Label7.Visible = True
  Label8.Visible = True
  code.Enabled = False
  desc.SetFocus

End Sub

Private Sub Command3_Click()
If box_user_no = "244" Then
 
 Dim m_code As Variant
 Dim m_desc As Variant
' Dim cn As New rdoConnection
 Dim sql As String
  
  If mod_typ = "1" Then
  
    If DataList1.Enabled = True Then
       
       m_leve = "1"
      sql = "execute insr_macnz " & "'" & desc.Text & "'" & "," & "'" & code.Text & "'" _
         & "," & "'" & m_leve & "'"
'            cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
'            cn.CursorDriver = rdUseOdbc
'            cn.EstablishConnection rdDriverNoPrompt
            cn.Execute sql, rdExecDirect
       macnz.Refresh
       macnz1.Refresh
       DataList1.Refresh
       DataList1.SetFocus
       SendKeys "{up}"
    ElseIf DataList2.Enabled = True Then
       macnz2.Recordset.Bookmark = DataList2.SelectedItem
       m_cod = Mid(macnz2.Recordset![sub_code], 1, 2)
       m_code = m_cod + code.Text
       m_leve = "2"
      sql = "execute insr_macnz " & "'" & desc.Text & "'" & "," & "'" & m_code & "'" _
         & "," & "'" & m_leve & "'"
'            cn.Connect = "uid=;pwd=;server=SEQUEL;" _
'           & "driver={SQL Server};database=macnz;" _
'           & "DSN='';"
''            cn.CursorDriver = rdUseOdbc
 '           cn.EstablishConnection rdDriverNoPrompt
            cn.Execute sql, rdExecDirect
       macnz.Refresh
       macnz2.Refresh
       DataList2.Refresh
       DataList2.SetFocus
       SendKeys "{up}"
   ElseIf DataList3.Enabled = True Then
       macnz2.Recordset.Bookmark = DataList2.SelectedItem
       m_cod = Mid(macnz3.Recordset![sub_code], 1, 6)
       m_code = m_cod + code.Text
       m_leve = "3"
      sql = "execute insr_macnz " & "'" & desc.Text & "'" & "," & "'" & m_code & "'" _
         & "," & "'" & m_leve & "'"
     '   cn.Connect = "uid=;pwd=;server=SEQUEL;" _
     '      & "driver={SQL Server};database=macnz;" _
     '      & "DSN='';"
     '       cn.CursorDriver = rdUseOdbc
     '       cn.EstablishConnection rdDriverNoPrompt
            cn.Execute sql, rdExecDirect
       macnz.Refresh
       macnz3.Refresh
       DataList3.Refresh
       DataList3.SetFocus
       SendKeys "{up}"
    End If

      Label6.Visible = False
      Label7.Visible = False
      Label8.Visible = False
      Shape3.Visible = False
      code.Visible = False
      desc.Visible = False
      m_desc = desc.Text
      Call div_word(m_code, m_desc, "1")
      
      
  ElseIf mod_typ = "2" Then
            sql = "execute upd_macnz " & "'" & desc.Text & "'" & "," & "'" & code.Text & "'"
      '       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
      '     & "driver={SQL Server};database=macnz;" _
      '     & "DSN='';"
      ''      cn.CursorDriver = rdUseOdbc
       '     cn.EstablishConnection rdDriverNoPrompt
            cn.Execute sql, rdExecDirect
  If DataList1.Enabled = True Then
   
     macnz1.Refresh
     DataList1.Refresh
     DataList1.SetFocus
     
  ElseIf DataList2.Enabled = True Then
    macnz2.Refresh
    DataList2.Refresh
    DataList2.SetFocus
    
  ElseIf DataList3.Enabled = True Then
    macnz3.Refresh
    DataList3.Refresh
    DataList3.SetFocus
    
   End If
   SendKeys "{up}"
     Label6.Visible = False
      Label7.Visible = False
      Label8.Visible = False
      Shape3.Visible = False
      code.Visible = False
      desc.Visible = False
   
  End If
  End If
End Sub

Private Sub Command4_Click()
If box_user_no = "244" Then
 Dim ok As String
 Dim m_code As Variant
 Dim m_desc As Variant
' Dim cn As New rdoConnection
 Dim sql As String
          
         ok = " "
         ok = InputBox("Â·  —Ìœ «·€«¡ «·„ﬁ«·…(‰/ﬂ)")
If ok = "y" Or ok = "‰" Then
   If DataList1.Enabled = True Then
          macnz1.Recordset.Bookmark = DataList1.SelectedItem
          m_code = macnz1.Recordset![sub_code]
       ElseIf DataList2.Enabled = True Then
          macnz2.Recordset.Bookmark = DataList2.SelectedItem
          m_code = macnz2.Recordset![sub_code]
     ElseIf DataList3.Enabled = True Then
          macnz3.Recordset.Bookmark = DataList3.SelectedItem
          m_code = macnz3.Recordset![sub_code]
      End If

       
            sql = "execute del_macnz " & "'" & m_code & "'"
      '       cn.Connect = "uid=;pwd=;server=SEQUEL;" _
      '     & "driver={SQL Server};database=macnz;" _
      '     & "DSN='';"
      '      cn.CursorDriver = rdUseOdbc
      '      cn.EstablishConnection rdDriverNoPrompt
            cn.Execute sql, rdExecDirect
  If DataList1.Enabled = True Then
   
     macnz1.Refresh
     DataList1.Refresh
     DataList1.SetFocus
    
  ElseIf DataList2.Enabled = True Then
    macnz2.Refresh
    DataList2.Refresh
    DataList2.SetFocus
    
  ElseIf DataList3.Enabled = True Then
    macnz3.Refresh
    DataList3.Refresh
    DataList3.SetFocus
    
   End If
    SendKeys "{up}"
End If
End If
End Sub

Private Sub Command5_Click()
 Dim m_len As Integer
If typ_serh = 1 Then

 Label6.Visible = True
 Label7.Visible = True
 Label8.Visible = True
 desc.Visible = True
 Shape3.Visible = True
 desc.SetFocus
 typ_serh = 2
ElseIf typ_serh = 2 Then
If DataList1.Enabled = True Then
  m_desc = desc.Text
  m_len = Len(Trim(m_desc))
  macnz1.RecordSource = "execute serh_macnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
  macnz1.Refresh
  DataList1.Refresh
ElseIf DataList2.Enabled = True Then
  m_desc = desc.Text
  m_len = Len(Trim(m_desc))
  macnz2.RecordSource = "execute serh_macnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
  macnz2.Refresh
  DataList2.Refresh
 ElseIf DataList3.Enabled = True Then
  m_desc = desc.Text
  m_len = Len(Trim(m_desc))
  macnz3.RecordSource = "execute serh_macnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
  macnz3.Refresh
  DataList3.Refresh
 End If
       typ_serh = 1
        Label6.Visible = False
       Label7.Visible = False
       Label8.Visible = False
'        code.Visible = False
        desc.Visible = False
        Shape3.Visible = False
End If


End Sub


Private Sub Command6_Click()
Unload Form5
End Sub

Private Sub datalist1_Click()
If Not macnz1.Recordset.EOF And Not macnz1.Recordset.BOF Then
 macnz1.Recordset.Bookmark = DataList1.SelectedItem
 Text1.Text = macnz1.Recordset![sub_code]
 End If
End Sub

Private Sub datalist1_DblClick()
 macnz1.Recordset.Bookmark = DataList1.SelectedItem
 m_l1 = 1
 m_l2 = 2
 m_cod = Mid(macnz1.Recordset![sub_code], 1, 2)
 m_lev = "2"
 macnz2.RecordSource = " execute proc_macnz " & "'" & m_l1 & "'" & "," & _
     "'" & m_l2 & "'" & "," & "'" & m_lev & "'" & "," & "'" & m_cod & "'"
 macnz2.Refresh
 DataList2.Visible = True
 Line2.Visible = True
 DataList2.Refresh
 Label3.Visible = True
 DataList1.Enabled = False
 DataList2.SetFocus
 Text2.Visible = True
  SendKeys "{up}"
End Sub

Private Sub datalist1_GotFocus()
   SendKeys "{up}"
End Sub

Private Sub datalist1_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF9 Then
 Label6.Visible = True
 Label7.Visible = True
 Label8.Visible = True
 desc.Visible = True
 Shape3.Visible = True
 desc.SetFocus
 typ_serh = 3
ElseIf KeyCode = vbKeyF8 Then
 Label6.Visible = True
 Label7.Visible = True
 Label8.Visible = True
  desc.Visible = True
  Shape3.Visible = True
  desc.SetFocus
  typ_serh = 2
   
 ElseIf KeyCode = vbKeyF2 Then
  Command2.SetFocus
   SendKeys "{enter}"
 End If
End Sub

Private Sub datalist1_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyInsert Then
 Command1.SetFocus
 SendKeys "{enter}"
 ElseIf KeyCode = vbKeyDelete Then
   Command4.SetFocus
   SendKeys "{enter}"
 End If
End Sub

Private Sub datalist2_Click()
If Not macnz2.Recordset.EOF And Not macnz2.Recordset.BOF Then
 macnz2.Recordset.Bookmark = DataList2.SelectedItem
 Text2.Text = macnz2.Recordset![sub_code]
End If
End Sub

Private Sub datalist2_DblClick()
 macnz2.Recordset.Bookmark = DataList2.SelectedItem
 m_l1 = 1
 m_l2 = 6
 m_cod = Mid(macnz2.Recordset![sub_code], 1, 6)
 m_lev = "3"
 macnz3.RecordSource = " execute proc_macnz " & "'" & m_l1 & "'" & "," & _
     "'" & m_l2 & "'" & "," & "'" & m_lev & "'" & "," & "'" & m_cod & "'"
 macnz3.Refresh
 DataList3.Visible = True
 Line1.Visible = True
 DataList3.Refresh
 Label4.Visible = True
 DataList2.Enabled = False
 DataList3.SetFocus
 Text3.Visible = True
 SendKeys "{up}"
 
End Sub

Private Sub datalist1_KeyPress(KeyAscii As Integer)
   Select Case KeyAscii
      Case 27
        macnz1.RecordSource = " execute proc_macnz1"
        macnz1.Refresh
        DataList1.Refresh
        SendKeys "{up}"
       
      Case 13
        macnz1.Recordset.Bookmark = DataList1.SelectedItem
        m_l1 = 1
        m_l2 = 2
        m_cod = Mid(macnz1.Recordset![sub_code], 1, 2)
        m_lev = "2"
        macnz2.RecordSource = " execute proc_macnz " & "'" & m_l1 & "'" & "," & _
        "'" & m_l2 & "'" & "," & "'" & m_lev & "'" & "," & "'" & m_cod & "'"
         macnz2.Refresh
         DataList2.Visible = True
         Line2.Visible = True
         DataList2.Refresh
         Label3.Visible = True
         DataList1.Enabled = False
         DataList2.SetFocus
         Text2.Visible = True
         SendKeys "{up}"
         
         
   End Select
End Sub

Private Sub datalist2_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF9 Then
 Label6.Visible = True
 Label7.Visible = True
 Label8.Visible = True
 desc.Visible = True
 Shape3.Visible = True
 desc.SetFocus
 typ_serh = 3
ElseIf KeyCode = vbKeyF8 Then
 Label6.Visible = True
 Label7.Visible = True
 Label8.Visible = True
  desc.Visible = True
  Shape3.Visible = True
  desc.SetFocus
  typ_serh = 2
   
 ElseIf KeyCode = vbKeyF2 Then
  Command2.SetFocus
   SendKeys "{enter}"
 End If
End Sub

Private Sub datalist2_KeyPress(KeyAscii As Integer)
   Select Case KeyAscii
      Case 27
       DataList1.Enabled = True
       DataList2.Visible = False
       Line2.Visible = False
       Label3.Visible = False
       DataList1.SetFocus
       Text2.Visible = False
    Case 13
      macnz2.Recordset.Bookmark = DataList2.SelectedItem
       m_l1 = 1
       m_l2 = 6
       m_cod = Mid(macnz2.Recordset![sub_code], 1, 6)
       m_lev = "3"
       macnz3.RecordSource = " execute proc_macnz " & "'" & m_l1 & "'" & "," & _
       "'" & m_l2 & "'" & "," & "'" & m_lev & "'" & "," & "'" & m_cod & "'"
       macnz3.Refresh
       DataList3.Visible = True
        Line1.Visible = True
        DataList3.Refresh
         Label4.Visible = True
         DataList2.Enabled = False
         DataList3.SetFocus
         Text3.Visible = True
         SendKeys "{up}"
    End Select
End Sub

Private Sub datalist2_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyInsert Then
 Command1.SetFocus
 SendKeys "{enter}"
 ElseIf KeyCode = vbKeyDelete Then
   Command4.SetFocus
   SendKeys "{enter}"
 End If
End Sub

Private Sub datalist3_Click()
If Not macnz3.Recordset.EOF And Not macnz3.Recordset.BOF Then
 macnz3.Recordset.Bookmark = DataList3.SelectedItem
 Text3.Text = macnz3.Recordset![sub_code]
End If
End Sub

Private Sub datalist3_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF9 Then
 Label6.Visible = True
 Label7.Visible = True
 Label8.Visible = True
 desc.Visible = True
 Shape3.Visible = True
 desc.Text = ""
 
 desc.SetFocus
 typ_serh = 3
ElseIf KeyCode = vbKeyF8 Then
 Label6.Visible = True
 Label7.Visible = True
 Label8.Visible = True
  desc.Visible = True
  Shape3.Visible = True
   desc.Text = ""
  desc.SetFocus
  typ_serh = 2
  
 ElseIf KeyCode = vbKeyF2 Then
  Command2.SetFocus
   SendKeys "{enter}"
 End If
End Sub


Private Sub datalist3_KeyPress(KeyAscii As Integer)
   Select Case KeyAscii
      Case 27
       DataList2.Enabled = True
       DataList3.Visible = False
       Line1.Visible = False
       Label4.Visible = False
       DataList2.SetFocus
       Text3.Visible = False
  End Select
End Sub



Private Sub datalist3_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyInsert Then
 Command1.SetFocus
 SendKeys "{enter}"
 ElseIf KeyCode = vbKeyDelete Then
   Command4.SetFocus
   SendKeys "{enter}"
 End If
End Sub

Private Sub desc_KeyPress(KeyAscii As Integer)
   On Error Resume Next
   
   If KeyAscii = 27 Then
      Label6.Visible = False
      Label7.Visible = False
      Label8.Visible = False
      Shape3.Visible = False
      code.Visible = False
      desc.Visible = False
      If DataList1.Enabled = True Then
       DataList1.SetFocus
      ElseIf DataList2.Enabled = True Then
       DataList2.SetFocus
       ElseIf DataList3.Enabled = True Then
        DataList3.SetFocus
       End If
       SendKeys "{up}"
   ElseIf KeyAscii = 13 Then
    If typ_serh = 2 Then
       If DataList1.Enabled = True Then
         m_desc = desc.Text
         m_len = Len(Trim(m_desc))
         macnz1.RecordSource = "execute serh_macnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         macnz1.Refresh
         DataList1.Refresh
       ElseIf DataList2.Enabled = True Then
         m_desc = desc.Text
         m_len = Len(Trim(m_desc))
         macnz2.RecordSource = "execute serh_macnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         macnz2.Refresh
         DataList2.Refresh
       ElseIf DataList3.Enabled = True Then
         m_desc = desc.Text
         m_len = Len(Trim(m_desc))
         macnz3.RecordSource = "execute serh_macnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
         macnz3.Refresh
         DataList3.Refresh
       End If
         typ_serh = 1
        Label6.Visible = False
       Label7.Visible = False
       Label8.Visible = False
'        code.Visible = False
        desc.Visible = False
        Shape3.Visible = False
      ElseIf typ_serh = 3 Then
       m_desc = desc.Text
       m_len = Len(Trim(m_desc))
        macnz3.RecordSource = "execute serh_wrdmacnz " & "'" & m_desc & "'" & "," & "'" & m_len & "'"
        macnz3.Refresh
        DataList3.Refresh
        DataList3.SetFocus
        SendKeys "{UP}"
         typ_serh = 1
         Label6.Visible = False
         Label7.Visible = False
         Label8.Visible = False
'        code.Visible = False
        desc.Visible = False
        Shape3.Visible = False
     Else
        Command3.SetFocus
     End If
     
End If

End Sub



Private Sub Form_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then
  MsgBox "aaA"
End If

End Sub

Private Sub Form_Load()
 mod_typ = "0"
 typ_serh = 1
 macnz1.RecordSource = " execute proc_macnz1"
 macnz1.Refresh
 DataList1.Refresh
 
End Sub
