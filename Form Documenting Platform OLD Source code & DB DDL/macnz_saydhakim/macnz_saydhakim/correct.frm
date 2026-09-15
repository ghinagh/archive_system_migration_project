VERSION 5.00
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Begin VB.Form correct 
   Caption         =   "Form1"
   ClientHeight    =   8430
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   13095
   LinkTopic       =   "Form1"
   ScaleHeight     =   8430
   ScaleWidth      =   13095
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command10 
      Caption         =   "Command10"
      Height          =   1575
      Left            =   7320
      TabIndex        =   17
      Top             =   1920
      Width           =   2895
   End
   Begin VB.CommandButton Command9 
      Caption         =   " —ﬁÌ„ Ê €ÌÌ— «·—ﬁ„ ›Ì «·Ãœ«Ê·"
      Height          =   735
      Left            =   5760
      TabIndex        =   16
      Top             =   3240
      Width           =   975
   End
   Begin VB.CommandButton Command8 
      Caption         =   " —ﬁÌ„ Ê €ÌÌ— «·—ﬁ„ ›Ì «·Ãœ«Ê·"
      Height          =   735
      Left            =   5760
      TabIndex        =   15
      Top             =   2160
      Width           =   975
   End
   Begin VB.CommandButton Command7 
      Caption         =   " —ﬁÌ„ Ê €ÌÌ— «·—ﬁ„ ›Ì «·Ãœ«Ê·"
      Height          =   735
      Left            =   120
      TabIndex        =   14
      Top             =   4200
      Width           =   975
   End
   Begin VB.CommandButton Command6 
      Caption         =   " —ﬁÌ„ Ê €ÌÌ— «·—ﬁ„ ›Ì «·Ãœ«Ê·"
      Height          =   735
      Left            =   0
      TabIndex        =   13
      Top             =   3000
      Width           =   975
   End
   Begin VB.CommandButton Command5 
      Caption         =   " —ﬁÌ„ Ê €ÌÌ— «·—ﬁ„ ›Ì «·Ãœ«Ê·"
      Height          =   735
      Left            =   0
      TabIndex        =   12
      Top             =   1920
      Width           =   975
   End
   Begin VB.CommandButton Command4 
      Caption         =   " —ﬁÌ„ Ê €ÌÌ— «·—ﬁ„ ›Ì «·Ãœ«Ê·"
      Height          =   735
      Left            =   5280
      TabIndex        =   11
      Top             =   1080
      Width           =   2895
   End
   Begin VB.CommandButton Command3 
      Caption         =   " —ﬁÌ„ Ê €ÌÌ— «·—ﬁ„ ›Ì «·Ãœ«Ê·"
      Height          =   735
      Left            =   8760
      TabIndex        =   10
      Top             =   960
      Width           =   2895
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H8000000C&
      Height          =   3135
      Left            =   2400
      RightToLeft     =   -1  'True
      TabIndex        =   3
      Top             =   4440
      Visible         =   0   'False
      Width           =   5535
      Begin VB.CommandButton Command18 
         Caption         =   "«·€«¡ «·«„—"
         Height          =   375
         Left            =   600
         TabIndex        =   8
         Top             =   2520
         Width           =   1695
      End
      Begin VB.CommandButton Command19 
         Caption         =   "‰”Œ «·„·› «·Ï «·«—‘Ì›"
         Height          =   375
         Left            =   3240
         TabIndex        =   7
         Top             =   2520
         Width           =   1815
      End
      Begin VB.FileListBox fillist 
         Height          =   1845
         Left            =   120
         TabIndex        =   6
         Top             =   480
         Width           =   2895
      End
      Begin VB.DirListBox Dirlist 
         Height          =   1440
         Left            =   3120
         TabIndex        =   5
         Top             =   960
         Width           =   2175
      End
      Begin VB.DriveListBox drvlist 
         Height          =   315
         Left            =   3120
         TabIndex        =   4
         Top             =   480
         Width           =   2175
      End
      Begin VB.Label Label22 
         Alignment       =   2  'Center
         BackColor       =   &H8000000C&
         Caption         =   "—»ÿ «·„·›«  «·„ÿ·Ê»… »«·«” „«—…"
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
         Left            =   1200
         TabIndex        =   9
         Top             =   480
         Width           =   3495
      End
   End
   Begin VB.CommandButton Command1 
      Caption         =   " —ﬁÌ„ Ê €ÌÌ— «·’Ê—… "
      Height          =   735
      Left            =   2160
      TabIndex        =   2
      Top             =   3120
      Width           =   2895
   End
   Begin VB.TextBox Text1 
      Height          =   855
      Left            =   120
      TabIndex        =   1
      Text            =   "Text1"
      Top             =   840
      Width           =   855
   End
   Begin VB.CommandButton Command2 
      Caption         =   " —ﬁÌ„ Ê €ÌÌ— «·—ﬁ„ ›Ì «·Ãœ«Ê·"
      Height          =   735
      Left            =   2040
      TabIndex        =   0
      Top             =   960
      Width           =   2895
   End
   Begin MSRDC.MSRDC main 
      Align           =   1  'Align Top
      Height          =   495
      Left            =   0
      Top             =   495
      Width           =   13095
      _ExtentX        =   23098
      _ExtentY        =   873
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
      DataSourceName  =   "sqlserver1"
      RecordSource    =   "select * from main order by mn_app_no"
      UserName        =   ""
      Password        =   ""
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "main"
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
   Begin MSRDC.MSRDC article 
      Align           =   1  'Align Top
      Height          =   495
      Left            =   0
      Top             =   0
      Width           =   13095
      _ExtentX        =   23098
      _ExtentY        =   873
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
      RecordSource    =   "select * from article order by art_PIC"
      UserName        =   ""
      Password        =   ""
      Connect         =   ""
      LogMessages     =   ""
      Caption         =   "article"
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
Attribute VB_Name = "correct"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
          cn.Connect = "uid=;pwd=;server=pc;" _
           & "driver={SQL Server};database=macnz_manar;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
           
m_no = 0
article.Resultset.MoveFirst
Do While Not article.Resultset.EOF
If Not IsNull(article.Resultset![art_flm_no]) Then
  m_no1 = article.Resultset![ART_app_no]
 V_REC = article.Resultset![ART_PIC]
       m_source = "d:\nasrala1\" & V_REC & ".tif"
       
        m_target = "d:\scan" & "\" & Mid(V_REC, 1, 2) & "\" & Mid(V_REC, 3, 2) & "\" & V_REC & ".tif"
        myfile = Dir(m_source)
     If myfile <> "" Then
       FileCopy m_source, m_target
      End If
      End If
article.Resultset.MoveNext
Text1.Text = m_no2
Text1.Refresh


  
Loop
MsgBox "fin"

End Sub





Private Sub Command10_Click()
MsgBox KeyAscii
End Sub

Private Sub Command10_KeyPress(KeyAscii As Integer)
MsgBox KeyAscii
End Sub

Private Sub Command2_Click()
typ_prog = 0
          cn.Connect = "uid=;pwd=;server=server1;" _
           & "driver={SQL Server};database=macnz_manar;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
           
m_no = 0
main.Resultset.MoveFirst
Do While Not main.Resultset.EOF
  m_no1 = main.Resultset![mn_app_no]
 v_prs_no = "0000000"
 m_no = m_no + 1
 v_prs_no = Mid(v_prs_no, 1, 7 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
 m_no2 = v_prs_no
   sql = "execute upd_analis_no " & "'" & m_no1 & "'" & "," & "'" & m_no2 & "'"
   cn.Execute sql, rdExecDirect
main.Resultset.MoveNext
 Text1.Text = m_no2
 Text1.Refresh
 
  
Loop
MsgBox "fin"

End Sub

Private Sub Command3_Click()
typ_prog = 0
          cn.Connect = "uid=;pwd=;server=pc;" _
           & "driver={SQL Server};database=m1_manar;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
           
m_no = 0
main.Resultset.MoveFirst
Do While Not main.Resultset.EOF
  m_no1 = main.Resultset![mn_app_no]
    m_no2 = main.Resultset![m_no]
   sql = "execute upd_an_NO " & "'" & m_no1 & "'" & "," & "'" & m_no2 & "'"
   cn.Execute sql, rdExecDirect
main.Resultset.MoveNext
 Text1.Text = m_no2
 Text1.Refresh
 
  
Loop
MsgBox "fin"

End Sub

Private Sub Command4_Click()
         cn.Connect = "uid=;pwd=;server=pc;" _
           & "driver={SQL Server};database=m1_manar;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
           
m_no = 0
main.Resultset.MoveFirst
Do While Not main.Resultset.EOF
If Not IsNull(main.Resultset![mn_app_no]) Then
  m_no1 = main.Resultset![mn_app_no]
 v_prs_no = "000000"
 m_no = m_no + 1
 v_prs_no = Mid(v_prs_no, 1, 6 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
 m_no2 = "ﬁ" + v_prs_no
   sql = "execute upd_main_NO " & "'" & m_no2 & "'" & "," & "'" & m_no1 & "'"
   cn.Execute sql, rdExecDirect
main.Resultset.MoveNext
 Text1.Text = m_no2
 Text1.Refresh
 
End If
Loop
MsgBox "fin"

End Sub

Private Sub Command5_Click()
  cn.Connect = "uid=;pwd=;server=pc;" _
           & "driver={SQL Server};database=m1_manar;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
           
m_no = 0
main.Resultset.MoveFirst
Do While Not main.Resultset.EOF
  m_no1 = main.Resultset![mn_app_no]
  main.Resultset.MoveNext
 Do While main.Resultset![mn_app_no] = m_no1 And Not main.Resultset.EOF
  m_no2 = main.Resultset![AUTO]
   sql = "execute del_ARTICLE1 " & "'" & m_no2 & "'"
   cn.Execute sql, rdExecDirect
   
main.Resultset.MoveNext
Loop
 Text1.Text = m_no2
 Text1.Refresh
  
Loop
MsgBox "fin"
End Sub

Private Sub Command6_Click()
 cn.Connect = "uid=;pwd=;server=pc;" _
           & "driver={SQL Server};database=m1_manar;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
           
m_no = 0
article.Resultset.MoveFirst
Do While Not article.Resultset.EOF
  m_no1 = article.Resultset![ART_app_no]
 article.Resultset.MoveNext
 Do While article.Resultset![ART_app_no] = m_no1 And Not article.Resultset.EOF
  m_no2 = article.Resultset![AUTO]
   sql = "execute del_ARTICLE1 " & "'" & m_no2 & "'"
   cn.Execute sql, rdExecDirect
   
article.Resultset.MoveNext
Loop
 Text1.Text = m_no2
 Text1.Refresh
  
Loop
MsgBox "fin"
End Sub

Private Sub Command7_Click()
         cn.Connect = "uid=;pwd=;server=pc;" _
           & "driver={SQL Server};database=MACNZ_manar;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
           
m_no = 22572
article.Resultset.MoveFirst
Do While Not article.Resultset.EOF
If Not IsNull(article.Resultset![art_flm_no]) Then
If IsNull(article.Resultset![ART_PIC]) Then
  m_no1 = article.Resultset![ART_app_no]
 v_prs_no = "000000"
 m_no = m_no + 1
 v_prs_no = Mid(v_prs_no, 1, 6 - Len(Trim(Str(m_no)))) + Trim(Str(m_no))
 m_no2 = v_prs_no
   sql = "execute upd_ARTICLE_NO " & "'" & m_no2 & "'" & "," & "'" & m_no1 & "'"
   cn.Execute sql, rdExecDirect
 End If
article.Resultset.MoveNext
If Not IsNull(article.Resultset![ART_PIC]) Then
 Text1.Text = article.Resultset![ART_PIC]
 Else
 Text1.Text = m_no2
 End If
 Text1.Refresh
Else
article.Resultset.MoveNext

End If
Loop
MsgBox "fin"
End Sub

Private Sub Command8_Click()
  cn.Connect = "uid=;pwd=;server=pc;" _
           & "driver={SQL Server};database=MACNZ_manar;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
           
m_no = 0
article.Resultset.MoveFirst
Do While Not article.Resultset.EOF
If Not IsNull(article.Resultset![art_flm_no]) Then
  m_no1 = article.Resultset![ART_app_no]
  m_no2 = article.Resultset![ART_PIC]
       V_REC = article.Resultset![art_flm_no]
       m_source = "d:\NASRALA\" & V_REC & ".tif"
        m_target = "d:\NASRALA1" & "\" & m_no2 & ".tif"
        myfile = Dir(m_source)
     If myfile <> "" Then
       FileCopy m_source, m_target
      End If
      End If
article.Resultset.MoveNext
Text1.Text = m_no2
Text1.Refresh


  
Loop
MsgBox "fin"

End Sub

Private Sub Command9_Click()
         cn.Connect = "uid=;pwd=;server=pc;" _
           & "driver={SQL Server};database=MACNZ_manar;" _
           & "DSN='';"
            cn.CursorDriver = rdUseOdbc
           cn.EstablishConnection rdDriverNoPrompt
           
article.Resultset.MoveFirst
Do While Not article.Resultset.EOF
If Not IsNull(article.Resultset![ART_PIC]) Then
   m_no1 = article.Resultset![ART_app_no]
  m_no2 = article.Resultset![ART_PIC]
   sql = "execute INSR_DIGIT_NO " & "'" & m_no1 & "'" & "," & "'" & m_no2 & "'"
   cn.Execute sql, rdExecDirect
article.Resultset.MoveNext
 Text1.Text = m_no2
 
 Text1.Refresh
Else
article.Resultset.MoveNext
End If
Loop
MsgBox "fin"

End Sub

