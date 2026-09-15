VERSION 5.00
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form Form10 
   Caption         =   "Form10"
   ClientHeight    =   6615
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9465
   LinkTopic       =   "Form10"
   ScaleHeight     =   6615
   ScaleWidth      =   9465
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   7560
      TabIndex        =   1
      Top             =   0
      Width           =   1455
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   1920
      TabIndex        =   0
      Top             =   240
      Width           =   1575
   End
   Begin MSDBGrid.DBGrid DBGrid1 
      Bindings        =   "Form10.frx":0000
      Height          =   3255
      Left            =   0
      OleObjectBlob   =   "Form10.frx":0011
      TabIndex        =   2
      Top             =   1200
      Width           =   11055
   End
   Begin MSRDC.MSRDC AUTHER 
      Height          =   330
      Left            =   840
      Top             =   5160
      Visible         =   0   'False
      Width           =   2400
      _ExtentX        =   4233
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
      RecordSource    =   " select * from trans"
      UserName        =   ""
      Password        =   ""
      Connect         =   "odbc;dsname = abbas ;uid=abbas;pwd=;server=sequel;driver = {sql server};database=macnz;"
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
   Begin VB.Label Label1 
      Caption         =   "„‰  «—ÌŒ"
      Height          =   255
      Left            =   9120
      RightToLeft     =   -1  'True
      TabIndex        =   4
      Top             =   120
      Width           =   1695
   End
   Begin VB.Label Label2 
      Caption         =   "«·Ï  «—ÌŒ"
      Height          =   255
      Left            =   3720
      TabIndex        =   3
      Top             =   240
      Width           =   1215
   End
End
Attribute VB_Name = "Form10"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False



Private Sub Text2_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then

  Dim mydate As Variant
   Dim cn As New rdoConnection
   Dim SQL, crit As String
   Dim qd As rdoQuery
   Dim sql_query As String
        
             cn.Connect = "uid=;pwd=;server=SEQUEL;" _
           & "driver={SQL Server};database=macnz;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
            cn.EstablishConnection rdDriverNoPrompt
  '      SQL = "drop proc tmp_result"
       '     cn.Execute SQL, rdExecDirect
'   MsgBox "delete proc "
        'crit = " execute proc_trans " & "'" & Format(Text1.Text, "yyyy/mm/dd") & "'" & "," & "'" & Format(Text2.Text, "yyyy/mm/dd") & "'"
             ' cn.Execute crit, rdExecDirect
             crit = "select * from trans  "
            
      Set qd = cn.CreateQuery("view_abb", crit)
      AUTHER.SQL = qd.SQL
   End If
End Sub

