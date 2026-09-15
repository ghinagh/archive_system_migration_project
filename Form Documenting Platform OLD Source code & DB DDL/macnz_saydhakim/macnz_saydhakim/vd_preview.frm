VERSION 5.00
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{6BF52A50-394A-11D3-B153-00C04F79FAA6}#1.0#0"; "wmp.dll"
Begin VB.Form vd_preview 
   BackColor       =   &H80000007&
   Caption         =   "preview"
   ClientHeight    =   4290
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5745
   LinkTopic       =   "Form6"
   ScaleHeight     =   4290
   ScaleWidth      =   5745
   Begin VB.CommandButton Command9 
      Caption         =   "speed"
      Height          =   375
      Left            =   5040
      TabIndex        =   16
      Top             =   3840
      Width           =   495
   End
   Begin VB.CommandButton Command22 
      BackColor       =   &H00E0E0E0&
      Caption         =   "in"
      Height          =   375
      Left            =   3120
      RightToLeft     =   -1  'True
      TabIndex        =   15
      Top             =   3840
      Width           =   495
   End
   Begin VB.CommandButton Command23 
      Caption         =   "out"
      Height          =   375
      Left            =   3600
      RightToLeft     =   -1  'True
      TabIndex        =   14
      Top             =   3840
      Width           =   495
   End
   Begin VB.CommandButton Command24 
      Caption         =   "to"
      Height          =   375
      Left            =   4560
      TabIndex        =   13
      Top             =   3840
      Width           =   495
   End
   Begin VB.CommandButton Command25 
      Caption         =   "from"
      Height          =   375
      Left            =   4080
      TabIndex        =   12
      Top             =   3840
      Width           =   495
   End
   Begin VB.CommandButton Command8 
      Caption         =   "log in/out"
      Height          =   375
      Left            =   2040
      RightToLeft     =   -1  'True
      TabIndex        =   10
      Top             =   4680
      Width           =   1095
   End
   Begin VB.TextBox m_step 
      Alignment       =   2  'Center
      Height          =   375
      Left            =   1560
      Locked          =   -1  'True
      TabIndex        =   9
      Text            =   "1"
      Top             =   3840
      Width           =   375
   End
   Begin VB.CommandButton Command7 
      Height          =   375
      Left            =   1200
      Picture         =   "vd_preview.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   8
      Top             =   3840
      Width           =   375
   End
   Begin VB.CommandButton Command6 
      Height          =   375
      Left            =   1920
      Picture         =   "vd_preview.frx":03A4
      Style           =   1  'Graphical
      TabIndex        =   7
      Top             =   3840
      Width           =   375
   End
   Begin VB.CommandButton Command2 
      Caption         =   "out"
      Height          =   375
      Left            =   1080
      RightToLeft     =   -1  'True
      TabIndex        =   5
      Top             =   4680
      Width           =   735
   End
   Begin VB.TextBox m_nam_file 
      Alignment       =   1  'Right Justify
      Height          =   375
      Left            =   0
      RightToLeft     =   -1  'True
      TabIndex        =   4
      Top             =   5400
      Width           =   3135
   End
   Begin VB.CommandButton Command3 
      Caption         =   "save EDL"
      Height          =   375
      Left            =   3240
      RightToLeft     =   -1  'True
      TabIndex        =   3
      Top             =   5400
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H00E0E0E0&
      Caption         =   "in"
      Height          =   375
      Left            =   120
      RightToLeft     =   -1  'True
      TabIndex        =   2
      Top             =   4680
      Width           =   735
   End
   Begin VB.CommandButton Command4 
      Caption         =   "clear"
      Height          =   375
      Left            =   4560
      RightToLeft     =   -1  'True
      TabIndex        =   1
      Top             =   4800
      Width           =   1095
   End
   Begin VB.CommandButton Command5 
      Caption         =   "exit"
      Height          =   375
      Left            =   4560
      RightToLeft     =   -1  'True
      TabIndex        =   0
      Top             =   5400
      Width           =   1095
   End
   Begin MSRDC.MSRDC ranj 
      Height          =   375
      Left            =   840
      Top             =   6000
      Visible         =   0   'False
      Width           =   2895
      _ExtentX        =   5106
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
      RecordSource    =   "select ranjpath.* from ranjpath"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "ranj"
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
   Begin WMPLibCtl.WindowsMediaPlayer WindowsMediaPlayer1 
      Height          =   4215
      Left            =   0
      TabIndex        =   11
      Top             =   0
      Width           =   5775
      URL             =   ""
      rate            =   1
      balance         =   0
      currentPosition =   0
      defaultFrame    =   ""
      playCount       =   1
      autoStart       =   -1  'True
      currentMarker   =   0
      invokeURLs      =   -1  'True
      baseURL         =   ""
      volume          =   50
      mute            =   0   'False
      uiMode          =   "full"
      stretchToFit    =   0   'False
      windowlessVideo =   0   'False
      enabled         =   -1  'True
      enableContextMenu=   -1  'True
      fullScreen      =   0   'False
      SAMIStyle       =   ""
      SAMILang        =   ""
      SAMIFilename    =   ""
      captioningID    =   ""
      enableErrorDialogs=   0   'False
      _cx             =   10186
      _cy             =   7435
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H80000007&
      Caption         =   "File name"
      ForeColor       =   &H8000000E&
      Height          =   375
      Left            =   1080
      RightToLeft     =   -1  'True
      TabIndex        =   6
      Top             =   5160
      Width           =   855
   End
End
Attribute VB_Name = "vd_preview"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
 
Dim M_NAM As String
Dim i As Integer
Dim is_mode As Integer







Private Sub Command1_Click()
On Error Resume Next
'If v_mch_stock > 12539 Then
 m_config_path1 = "\\ar2storage\ar2highres\final_archive\"
 'm_config_path1 = "\\192.168.10.101\DataTapeLibrary\Local_Inter\"
'Else
' m_config_path1 = "\\arstorage\HiRes\LoRes"
' m_config_path1 = "\\bqvas\XenData Archive\ARstorage"
'End If

If LEN_MCH(IND) <> 0 Or IND = 0 Then
IND = IND + 1
m_pos = WindowswindowsMediaPlayer1.Controls.CurrentPosition
STREAMSTART(IND) = m_pos * 1000
  ar_path(IND) = m_config_path1 + Trim(V_MCH_STOCK) + ".avi"
End If
'DataGrid1.SetFocus
End Sub

Private Sub Command10_Click()
'WindowsMediaPlayer1.Controls.Rate = 1
End Sub

Private Sub Command2_Click()
On Error Resume Next
If STREAMSTART(IND) <> 0 Then
 LEN_MCH(IND) = WindowsMediaPlayer1.Controls.CurrentPosition * 1000
 LEN_MCH(IND) = LEN_MCH(IND) - STREAMSTART(IND)
End If
'DataGrid1.SetFocus

End Sub

Private Sub Command22_Click()
If is_trans(box_mn_trans) Then
Dim M_O, m_m, m_s As Integer
 
m_time = WindowsMediaPlayer1.Controls.CurrentPosition - 1
M_O = Int(m_time / 3600)
M_REST1 = m_time Mod 3600
m_m = Int(M_REST1 / 60)
m_s = M_REST1 Mod 60
 
If nb_page = 1 Then
Form6.DataGrid1.Columns(7).value = M_O
Form6.DataGrid1.Columns(8).value = m_m
Form6.DataGrid1.Columns(9).value = m_s
 m_row = Form6.rel_digit.Recordset.Bookmark - 1
   Form6.rel_digit.Recordset.Requery
 Form6.rel_digit.Recordset.Move (m_row)
ElseIf nb_page = 2 Then
'If Val(Form2.m_mch_o.Text) = 0 Then
 Form2.m_mch_o.Text = M_O
 
'End If
'If Val(Form2.m_mch_m.Text) = 0 Then
 Form2.m_mch_m.Text = m_m
 
'End If
'If Val(Form2.m_mch_s.Text) = 0 Then
 Form2.m_mch_s.Text = m_s
 
'End If

    Form2.time.sql = "execute time_proc" & "'" & Form2.Text1.Text & "'" & _
    "," & "'" & Form2.Text3.Text & "'" & "," & "'" & Form2.ANALIS.Resultset![an_ser_no] & "'"
    Form2.time.Refresh
     Form2.ANALIS.Resultset.Bookmark = Form2.DBList1(0).SelectedItem
     v_desc_no = Form2.ANALIS.Resultset![an_desc_no]
     v_ser_no = Form2.ANALIS.Resultset![an_ser_no]
    If Form2.time.Resultset.EOF And Form2.time.Resultset.BOF Then
    
     
     sql = "execute insr_time1 " & "'" & Form2.Text1.Text & "'" & "," & "'" & Form2.Text3.Text & "'" & "," _
              & "'" & v_ser_no & "'" & "," & "'" & v_desc_no & "'" & "," & "'" & m_s & "'" & "," & "'" & m_m & "'" & "," & "'" & M_O & "'"
              
         
                cn.Execute sql, rdExecDirect
 
     Else
      m_nb = 1
       sql = "execute upd_time1 " & "'" & Form2.Text1.Text & "'" & "," & "'" & Form2.Text3.Text & "'" & "," _
          & "'" & v_ser_no & "'" & "," & "'" & m_s & "'" & "," & "'" & m_m & "'" & "," & "'" & M_O & "'" _
          & "," & "'" & m_nb & "'"
      
                cn.Execute sql, rdExecDirect
  
    End If

  End If
  End If
End Sub

Private Sub Command23_Click()
If is_trans(box_mn_trans) Then
Dim M_O, m_m, m_s As Integer
 
m_time = WindowsMediaPlayer1.Controls.CurrentPosition - 1
M_O = Int(m_time / 3600)
M_REST1 = m_time Mod 3600
m_m = Int(M_REST1 / 60)
m_s = M_REST1 Mod 60
 
If nb_page = 1 Then

 Form6.DataGrid1.Columns(10) = M_O
 Form6.DataGrid1.Columns(11) = m_m
 Form6.DataGrid1.Columns(12) = m_s
 m_row = Form6.rel_digit.Recordset.Bookmark - 1
    Form6.rel_digit.Recordset.Requery
  Form6.rel_digit.Recordset.Move (m_row)
ElseIf nb_page = 2 Then
'If Val(Form2.m_mch_o1.Text) = 0 Then
 Form2.m_mch_o1.Text = M_O
 
'End If
'If Val(Form2.m_mch_m1.Text) = 0 Then
 Form2.m_mch_m1.Text = m_m
 
'End If
'If Val(Form2.m_mch_s1.Text) = 0 Then
 Form2.m_mch_s1.Text = m_s
 
'End If
 Form2.ANALIS.Resultset.Bookmark = Form2.DBList1(0).SelectedItem
     v_desc_no = Form2.ANALIS.Resultset![an_desc_no]
     v_ser_no = Form2.ANALIS.Resultset![an_ser_no]
 
  m_nb = 2
       sql = "execute upd_time1 " & "'" & Form2.Text1.Text & "'" & "," & "'" & Form2.Text3.Text & "'" & "," _
          & "'" & v_ser_no & "'" & "," & "'" & m_s & "'" & "," & "'" & m_m & "'" & "," & "'" & M_O & "'" _
          & "," & "'" & m_nb & "'"
        
                cn.Execute sql, rdExecDirect
  
End If
End If
End Sub

Private Sub Command24_Click()
WindowsMediaPlayer1.Controls.CurrentPosition = m_time1
WindowsMediaPlayer1.Controls.Pause
'WindowsMediaPlayer1.settings.Rate = 0.5
End Sub

Private Sub Command25_Click()
'MsgBox (WindowsMediaPlayer1.settings.Rate)

WindowsMediaPlayer1.Controls.CurrentPosition = m_time
WindowsMediaPlayer1.Controls.Pause
'WindowsMediaPlayer1.settings.Rate = 1
End Sub

Private Sub Command3_Click()
 Dim var_temp, VAR_TEMP1 As Variant
On Error Resume Next
' m_mch_stock = view_res.result.Recordset![mch_stock]
 auto_no = 0
 STARTTIME = 0

'  PATH_nam = m_config_path + Trim(m_mch_stock) + ".avi"
 var_temp = Chr(34) + "ID" + Chr(34) + ";" + Chr(34) + "Track" + Chr(34) + ";" + Chr(34) + "StartTime" + Chr(34) + ";" + Chr(34) + "Length" + Chr(34) + ";" + Chr(34) + "PlayRate" + Chr(34) + ";" + Chr(34) + "Locked" + Chr(34) + _
 ";" + Chr(34) + "Normalized" + Chr(34) + ";" + Chr(34) + "StretchMethod" + Chr(34) + ";" + Chr(34) + "Looped" + Chr(34) + ";" + Chr(34) + "OnRuler" + Chr(34) + ";" + Chr(34) + "MediaType" + Chr(34) + ";" + Chr(34) + "FileName" + Chr(34) + ";" + Chr(34) + "Stream" + _
 Chr(34) + ";" + Chr(34) + "StreamStart" + Chr(34) + ";" + Chr(34) + "StreamLength" + Chr(34) + ";" + Chr(34) + "FadeTimeIn" + Chr(34) + ";" + Chr(34) + "FadeTimeOut" + Chr(34) + ";" + Chr(34) + "SustainGain" + Chr(34) + ";" + Chr(34) + "CurveIn" + Chr(34) + ";" + Chr(34) + "GainIn" + Chr(34) + _
 ";" + Chr(34) + "CurveOut" + Chr(34) + ";" + Chr(34) + "GainOut" + Chr(34) + ";" + Chr(34) + "Layer" + Chr(34) + ";" + Chr(34) + "Color" + Chr(34) + ";" + Chr(34) + "CurveInR" + Chr(34) + ";" + Chr(34) + "CurveOutR" + Chr(34) + ";" + Chr(34) + "PlayPitch" + Chr(34) + ";" + Chr(34) + "LockPitch" + Chr(34)
' ar_temp = text1.Text
 'M_NAM1 = "\\arstorage\hires\mash\" & Trim(m_nam_file.Text) & ".txt"
  M_NAM1 = "\\ar2storage\ar2highres\mash\" & Trim(m_nam_file.Text) & ".txt"
  Open M_NAM1 For Output As #1
   
   Print #1, var_temp
  For i = 1 To IND
   auto_no = auto_no + 1
     VAR_TEMP1 = LTrim(Str(auto_no)) & ";" & "    1;" & Str(STARTTIME) & ";" & Str(LEN_MCH(i)) & ";" & "    1.000000;    FALSE;    FALSE;    0;    TRUE;    FALSE;    VIDEO;" & Chr(34) & ar_path(i) & Chr(34) & ";   0;" & Str(STREAMSTART(i)) & ";" & Str(LEN_MCH(i)) & ";  0.0000;    0.0000;    1.000000;    4;    0.000000;    4;    0.000000;    0;    -1;    4;    4;    0.000000;    FALSE "
     STARTTIME = STARTTIME + LEN_MCH(i)
     Print #1, VAR_TEMP1
  Next i
  STARTTIME = 0
   For i = 1 To IND
   auto_no = auto_no + 1
     var_temp2 = LTrim(Str(auto_no)) & ";" & "    0;" & Str(STARTTIME) & ";" & Str(LEN_MCH(i)) & ";" & "    1.000000;    FALSE;    FALSE;    0;    TRUE;    FALSE;    AUDIO;" & Chr(34) & ar_path(i) & Chr(34) & ";   0;" & Str(STREAMSTART(i)) & ";" & Str(LEN_MCH(i)) & ";  10.0000;    10.0000;    1.000000;    2;    0.000000;    -2;    0.000000;    0;    -1;    -2;    2;    0.000000;    FALSE "
        STARTTIME = STARTTIME + LEN_MCH(i)
     Print #1, var_temp2
  Next i
   Close #1
   DataGrid1.SetFocus
End Sub

Private Sub Command4_Click()
For i = 1 To 10
 LEN_MCH(i) = 0
 STREAMSTART(i) = 0
 ar_path(i) = ""
Next i
IND = 0
m_nam_file.Text = ""
End Sub

Private Sub Command5_Click()
Unload vd_preview
End Sub

 
Private Sub Command6_Click()
 On Error Resume Next
 If WindowsMediaPlayer1.Controls.CurrentPosition > m_tm Then
 m_tm = WindowsMediaPlayer1.Controls.CurrentPosition
End If

    m_tm = m_tm + Val(m_step.Text)
    WindowsMediaPlayer1.Controls.CurrentPosition = m_tm
     WindowsMediaPlayer1.Controls.Pause
     WindowsMediaPlayer1.Controls.Play
 
End Sub

Private Sub Command6_KeyPress(KeyAscii As Integer)
If Val(V_MCH_STOCK) > 12259 And Val(V_MCH_STOCK) < 14000 Then

 If KeyAscii = 108 Then
WindowsMediaPlayer1.Controls.FileName = M_NAM
m_tm = m_tm + m_step.Text
WindowsMediaPlayer1.Controls.Pause

WindowsMediaPlayer1.Controls.SelectionStart = m_tm
WindowsMediaPlayer1.Controls.SelectionEnd = WindowsMediaPlayer1.Controls.Duration
WindowsMediaPlayer1.Controls.Play
 
 ElseIf KeyAscii = 106 Then
WindowsMediaPlayer1.Controls.FileName = M_NAM
m_tm = m_tm - m_step.Text
WindowsMediaPlayer1.Controls.Pause

WindowsMediaPlayer1.Controls.SelectionStart = m_tm
WindowsMediaPlayer1.Controls.SelectionEnd = WindowsMediaPlayer1.Controls.Duration
WindowsMediaPlayer1.Controls.Play
 
 ElseIf KeyAscii = 107 Then
 WindowsMediaPlayer1.Controls.Pause
 
 End If
 End If
End Sub

Private Sub Command7_Click()
On Error Resume Next
Dim wmpos As Double
Dim WmpCurPos As Double
    m_tm = m_tm - Val(m_step.Text)
    WindowsMediaPlayer1.Controls.CurrentPosition = m_tm
    WindowsMediaPlayer1.Controls.SelectionStart = m_tm
    WindowsMediaPlayer1.Controls.Play

End Sub

Private Sub Command7_KeyPress(KeyAscii As Integer)
If Val(V_MCH_STOCK) > 12259 And Val(V_MCH_STOCK) < 14000 Then

 If KeyAscii = 108 Then
WindowsMediaPlayer1.Controls.FileName = M_NAM
m_tm = m_tm + m_step.Text
WindowsMediaPlayer1.Controls.Pause

WindowsMediaPlayer1.Controls.SelectionStart = m_tm
WindowsMediaPlayer1.Controls.SelectionEnd = WindowsMediaPlayer1.Controls.Duration
WindowsMediaPlayer1.Controls.Play
 
 ElseIf KeyAscii = 106 Then
 If m_tm - m_step.Text > deb_tm Then
WindowsMediaPlayer1.Controls.FileName = M_NAM
m_tm = m_tm - m_step.Text
WindowsMediaPlayer1.Controls.Pause

WindowsMediaPlayer1.Controls.SelectionStart = m_tm
WindowsMediaPlayer1.Controls.SelectionEnd = WindowsMediaPlayer1.Controls.Duration
WindowsMediaPlayer1.Controls.Play
 End If
 ElseIf KeyAscii = 107 Then
 WindowsMediaPlayer1.Controls.Pause
 
 End If
End If
End Sub

Private Sub Command9_Click()

If WindowsMediaPlayer1.settings.isAvailable("Rate") Then
WindowsMediaPlayer1.settings.Rate = 2
End If

 
 
 
 
 
 

End Sub

Private Sub Form_Activate()
  
On Error Resume Next
Dim m_acrh_no  As Integer
 is_mode = 1
If v_mch_digtyp = "02" Then
          
        Else
          m_config_path = m_STCOK_path_new(V_MCH_STOCK)
      End If
 m_time = Val(v_mch_s) + Val(v_mch_m) * 60 + Val(v_mch_o) * 3600
 m_time1 = Val(v_mch_s1) + Val(v_mch_m1) * 60 + Val(v_mch_o1) * 3600
' m_config_path = m_config_path
M_NAM = m_config_path + Trim(V_MCH_STOCK) + "." + v_mch_typ

WindowsMediaPlayer1.URL = M_NAM
WindowsMediaPlayer1.Controls.Pause
'WindowsMediaPlayer1.Controls.SelectionStart = m_time
'WindowsMediaPlayer1.Controls.SelectionEnd = m_time1
WindowsMediaPlayer1.Controls.CurrentPosition = m_time

WindowsMediaPlayer1.Controls.Play
WindowsMediaPlayer1.Controls.Pause
m_tm = m_time
m_tm1 = m_time1
deb_tm = m_time
fin_tm = m_time1
m_nam_file.SetFocus
i = 1
End Sub

 
Private Sub m_step_KeyDown(KeyCode As Integer, Shift As Integer)
On Error Resume Next


If KeyCode = 37 Then

Dim wmpos As Double
Dim WmpCurPos As Double
    m_tm = m_tm - 1
    WindowsMediaPlayer1.Controls.CurrentPosition = m_tm
    'WindowsMediaPlayer1.Controls.SelectionStart = m_tm
    WindowsMediaPlayer1.Controls.Play
ElseIf KeyCode = 39 Then
'If m_tm + 1 < WindowsMediaPlayer1.Controls.SelectionEnd Then
 If WindowsMediaPlayer1.Controls.CurrentPosition > m_tm Then
 m_tm = WindowsMediaPlayer1.Controls.CurrentPosition
 End If

    m_tm = m_tm + 1
    WindowsMediaPlayer1.Controls.CurrentPosition = m_tm
     WindowsMediaPlayer1.Controls.Pause
     WindowsMediaPlayer1.Controls.Play
 ElseIf KeyCode = 32 Then
 m_tm = WindowsMediaPlayer1.Controls.CurrentPosition
     WindowsMediaPlayer1.Controls.Pause
End If
'  End If


 

End Sub

Private Sub m_step_KeyPress(KeyAscii As Integer)
If KeyAscii = 106 Then
 
 On Error Resume Next
Dim wmpos As Double
Dim WmpCurPos As Double
    'acc = acc + 0.04
      m_tm = m_tm - 0.04
    WindowsMediaPlayer1.Controls.CurrentPosition = m_tm
    'WindowsMediaPlayer1.Controls.SelectionStart = m_tm
    WindowsMediaPlayer1.Controls.Pause
    
 ElseIf KeyAscii = 108 Then
 
On Error Resume Next
 If WindowsMediaPlayer1.Controls.CurrentPosition > m_tm Then
 m_tm = WindowsMediaPlayer1.Controls.CurrentPosition
End If
    'acc = acc + 0
    m_tm = m_tm + 0.04
    WindowsMediaPlayer1.Controls.CurrentPosition = m_tm
     WindowsMediaPlayer1.Controls.Pause
 ElseIf KeyAscii = 107 Then
     acc = 0
     WindowsMediaPlayer1.Controls.Pause
 
 End If
 End Sub

Private Sub WindowsMediaPlayer1_Click(ByVal nButton As Integer, ByVal nShiftState As Integer, ByVal fX As Long, ByVal fY As Long)
If is_mode = 1 Then
 m_tm = WindowsMediaPlayer1.Controls.CurrentPosition
    'WindowsMediaPlayer1.Controls.SelectionStart = m_tm
    WindowsMediaPlayer1.Controls.Pause
  is_mode = 2
Else
WindowsMediaPlayer1.Controls.CurrentPosition = m_tm
    'WindowsMediaPlayer1.Controls.SelectionStart = m_tm
    WindowsMediaPlayer1.Controls.Play
    is_mode = 1
End If
End Sub

Function m_STCOK_path_new(m_stock As String)
    Dim M_NAM    As String
    Dim lg As Boolean
    On Error Resume Next
     lg = True
   ranj.Resultset.MoveFirst
   While Not ranj.Resultset.EOF And lg
        If ranj.Resultset![rjp_typ] = 2 Then
          If Val(m_stock) > ranj.Resultset![rjp_nofrom] And Val(m_stock) < ranj.Resultset![rjp_noto] Then
                   m_STCOK_path_new = Trim(ranj.Resultset![rjp_path])
                     lg = False
          End If
    End If
    ranj.Resultset.MoveNext
   Wend
   
      
  End Function
