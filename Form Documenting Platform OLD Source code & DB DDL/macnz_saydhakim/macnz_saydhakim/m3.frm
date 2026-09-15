VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Begin VB.Form Form3 
   Caption         =   "Form3"
   ClientHeight    =   4155
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6675
   LinkTopic       =   "Form3"
   ScaleHeight     =   4155
   ScaleWidth      =   6675
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   3840
      TabIndex        =   5
      Text            =   "Text1"
      Top             =   2160
      Width           =   1695
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Command4"
      Height          =   615
      Left            =   480
      TabIndex        =   4
      Top             =   3360
      Width           =   1935
   End
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   375
      Left            =   3960
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   ""
      Top             =   3360
      Width           =   2415
   End
   Begin MSDBCtls.DBList DBList1 
      Bindings        =   "m3.frx":0000
      Height          =   1815
      Left            =   3720
      TabIndex        =   3
      Top             =   240
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   3201
      _Version        =   393216
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Command3"
      Height          =   615
      Left            =   240
      TabIndex        =   2
      Top             =   2280
      Width           =   2175
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Command2"
      Height          =   855
      Left            =   240
      TabIndex        =   1
      Top             =   1200
      Width           =   2295
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   975
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   2175
   End
End
Attribute VB_Name = "Form3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()

Dim cn As New rdoConnection
Dim cl As rdoColumn
Dim SQL1 As String
Const None As String = ""

cn.Connect = "uid=;pwd=;server=SEQUEL;" _
    & "driver={SQL Server};database=macnz;" _
    & "DSN='';"
    
cn.CursorDriver = rdUseOdbc
cn.EstablishConnection rdDriverNoPrompt

'SQL = "Select Au_Lname, Au_Fname" _
'    & " From Authors A" _
'    & " Where Au_ID in " _
'    & " (Select Au_ID" _
'    & "     from TitleAuthor TA, Titles T" _
'    & "     Where TA.Au_ID = A.Au_ID" _
'    & "     And TA.Title_ID = T.Title_ID " _
'    & "     And T.Title Like '" _
'    & InputBox("Enter search string", , "C") & "')" _
'    & "Select * From Titles Where price > 10"
'SQL = "Select *from main"
'SQL = "{ CALL AB() }"
SQL1 = "SELECT *fROM res"
Set rs = cn.OpenResultSet(SQL1, rdOpenStatic, rdConcurReadOnly, rdAsyncEnable + rdExecDirect)
  MsgBox " " & rs![res_app_no]



End Sub



Private Sub Command2_Click()
Dim en As rdoEnvironment
Dim cnTest As rdoConnection
Dim strAttribs As String
Dim rs As rdoResultsets
Dim SQL As String
Dim RDOQY As rdoQuery


' Build keywords string.
strAttribs = "Description=" _
        & "SQL Server on server SEQUEL" _
  & Chr$(13) & "OemToAnsi=No" _
  & Chr$(13) & "SERVER=SEQUEL" _
  & Chr$(13) & "Network=DBNMPNTW" _
  & Chr$(13) & "Database=WorkDB" _
  & Chr$(13) & "Address=\\SERVER\PIPE\SQL\QUERY"
  
' Create new registered DSN.
rdoEngine.rdoRegisterDataSource "Example", _
         "SQL Server", True, strAttribs
' Open the database.
Set en = rdoEngine.rdoEnvironments(0)
Set cnTest = en.OpenConnection( _
  dsname:="EXAMPLE", _
  Prompt:=rdDriverNoPrompt, _
  Connect:="UID=ABBAS;PWD=;DATABASE=MACNZ")
MsgBox "ABBAS"
'sql = "select *from main"
'Set RS = cnTest.OpenResultSet(sql, rdOpenKeyset, rdConcurValues, rdDIRECTEXEC)
'MsgBox " " & RS.Count
With RDOQY
    Set .ActiveConnection = cnTest
    .SQL = "Select * FROM MAIN"
    .LockType = rdConcurReadOnly
    .RowsetSize = 1
    .CursorType = rdUseServer
End With
Set rs = RDOQY.OpenResultSet(rdOpenForwardOnly)
MsgBox " " & rs.Count

'
'        Debug.Print
'        Do Until rdoRs.EOF
'                For Each rdoCol In rdoRs.rdoColumns
'                    Debug.Print rdoCol
'                Next
'            rdoRs.MoveNext
'        Loop
'
    
End Sub



Private Sub Command3_Click()
Dim rs As rdoResultset
Dim cn As New rdoConnection
Dim cl As rdoColumn
Dim SQL As String
Const None As String = ""

cn.Connect = "uid=;pwd=;server=SEQUEL;" _
    & "driver={SQL Server};database=macnz;" _
    & "DSN='';"
    
cn.CursorDriver = rdUseOdbc
cn.EstablishConnection rdDriverNoPrompt

'SQL = "Select Au_Lname, Au_Fname" _
'    & " From Authors A" _
'    & " Where Au_ID in " _
'    & " (Select Au_ID" _
'    & "     from TitleAuthor TA, Titles T" _
'    & "     Where TA.Au_ID = A.Au_ID" _
'    & "     And TA.Title_ID = T.Title_ID " _
'    & "     And T.Title Like '" _
'    & InputBox("Enter search string", , "C") & "')" _
'    & "Select * From Titles Where price > 10"
SQL = "Select *from main"
Set rs = cn.OpenResultSet(SQL, rdOpenKeyset, _
    rdConcurReadOnly, rdAsyncEnable + rdExecDirect)
   MsgBox " " & rs![mn_app_no]
Debug.Print "Executing ";
While rs.StillExecuting
    Debug.Print ".";
    DoEvents
Wend

Do
    Debug.Print String(50, "-") _
    & "Processing Result Set " & String(50, "-")
    For Each cl In rs.rdoColumns
        Debug.Print cl.Name,
    Next
    Debug.Print
    
    Do Until rs.EOF
        For Each cl In rs.rdoColumns
            Debug.Print cl.Value,
        Next
        rs.MoveNext
    Debug.Print
    Loop
    Debug.Print "Row count="; rs.RowCount
    
Loop Until rs.MoreResults = False

End Sub

Private Sub Command4_Click()
Dim rs As rdoResultset
Dim cn As New rdoConnection
Dim cl As rdoColumn
Dim SQL As String
Const None As String = ""
Dim M_COD  As String
Dim rs As ADODB.Recordset




cn.Connect = "uid=;pwd=;server=SEQUEL;" _
    & "driver={SQL Server};database=macnz;" _
    & "DSN='';"
    
cn.CursorDriver = rdUseOdbc
cn.EstablishConnection rdDriverNoPrompt

'SQL = "Select Au_Lname, Au_Fname" _
'    & " From Authors A" _
'    & " Where Au_ID in " _
'    & " (Select Au_ID" _
'    & "     from TitleAuthor TA, Titles T" _
'    & "     Where TA.Au_ID = A.Au_ID" _
'    & "     And TA.Title_ID = T.Title_ID " _
'    & "     And T.Title Like '" _
'    & InputBox("Enter search string", , "C") & "')" _
'    & "Select * From Titles Where price > 10"
SQL = "Select *from main"
 Set rs = cn.OpenResultSet(SQL, rdOpenKeyset, _
    rdConcurValues, rdAsyncEnable + rdExecDirect)
    MsgBox " " & rs![mn_app_no]
 rs.Edit
 rs![mn_act] = Text1.Text
 rs.Update
 rs.Close
 
End Sub
