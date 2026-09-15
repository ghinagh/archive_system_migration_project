VERSION 5.00
Object = "{FAEEE763-117E-101B-8933-08002B2F4F5A}#1.1#0"; "DBLIST32.OCX"
Object = "{F6125AB1-8AB1-11CE-A77F-08002B2F4E98}#2.0#0"; "MSRDC20.OCX"
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{CDE57A40-8B86-11D0-B3C6-00A0C90AEA82}#1.0#0"; "MSDATGRD.OCX"
Begin VB.Form CAT_OUTFRM 
   Caption         =   "Form1"
   ClientHeight    =   9030
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   19905
   LinkTopic       =   "Form1"
   ScaleHeight     =   9030
   ScaleWidth      =   19905
   StartUpPosition =   3  'Windows Default
   Begin MSDBCtls.DBList DBList1 
      Bindings        =   "CAT_OUTFRM.frx":0000
      Height          =   3180
      Left            =   15360
      TabIndex        =   3
      Top             =   5160
      Width           =   4335
      _ExtentX        =   7646
      _ExtentY        =   5609
      _Version        =   393216
      BackColor       =   -2147483644
      ListField       =   "SUB_DESC"
      BoundColumn     =   "SUB_CODE"
   End
   Begin VB.CheckBox Check2 
      Caption         =   "ÇÓÆáÉ ÇáÇÓÊÑÌÇÚ"
      Height          =   255
      Left            =   3840
      TabIndex        =   2
      Top             =   360
      Width           =   1695
   End
   Begin VB.CheckBox Check1 
      Caption         =   "ÍÞæá ÇáÚÑÖ"
      Height          =   375
      Left            =   2160
      TabIndex        =   1
      Top             =   240
      Width           =   1575
   End
   Begin MSDataGridLib.DataGrid DataGrid1 
      Bindings        =   "CAT_OUTFRM.frx":001C
      Height          =   4335
      Left            =   0
      TabIndex        =   0
      Top             =   720
      Width           =   19695
      _ExtentX        =   34740
      _ExtentY        =   7646
      _Version        =   393216
      AllowUpdate     =   -1  'True
      BackColor       =   8833260
      HeadLines       =   1
      RowHeight       =   15
      FormatLocked    =   -1  'True
      AllowAddNew     =   -1  'True
      AllowDelete     =   -1  'True
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
      ColumnCount     =   5
      BeginProperty Column00 
         DataField       =   "OUT_NUM"
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
      BeginProperty Column01 
         DataField       =   "OUT_DESC"
         Caption         =   "ÇÓã ÇáÍÞá"
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
         DataField       =   "OUT_INDX"
         Caption         =   "ÊÑÊíÈ ÍÞæá ÇáÚÑÖ"
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
         DataField       =   "OUT_INDX3"
         Caption         =   "ÊÑÊíÈ ÇáÇÓÆáÉ"
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
         DataField       =   "out_cond"
         Caption         =   "ÇáÓÄÇá"
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
            Locked          =   -1  'True
            ColumnWidth     =   1695.118
         EndProperty
         BeginProperty Column01 
            Locked          =   -1  'True
            ColumnWidth     =   3000.189
         EndProperty
         BeginProperty Column02 
         EndProperty
         BeginProperty Column03 
            Object.Visible         =   -1  'True
         EndProperty
         BeginProperty Column04 
            Object.Visible         =   -1  'True
            ColumnWidth     =   3495.118
         EndProperty
      EndProperty
   End
   Begin MSAdodcLib.Adodc f_tmp 
      Height          =   330
      Left            =   120
      Top             =   8640
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
      RecordSource    =   "select VIEW_CAT.* from VIEW_CAT "
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
   Begin MSRDC.MSRDC view_coding37 
      Height          =   375
      Left            =   3960
      Top             =   8640
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
      RecordSource    =   "select * from VIEW_coding37"
      UserName        =   ""
      Password        =   ""
      Connect         =   " "
      LogMessages     =   ""
      Caption         =   "view_coding31"
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
   Begin MSAdodcLib.Adodc f_cat 
      Height          =   330
      Left            =   0
      Top             =   8160
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
   Begin MSDataGridLib.DataGrid DataGrid2 
      Bindings        =   "CAT_OUTFRM.frx":0030
      Height          =   2055
      Left            =   120
      TabIndex        =   4
      Top             =   5400
      Width           =   14895
      _ExtentX        =   26273
      _ExtentY        =   3625
      _Version        =   393216
      AllowUpdate     =   -1  'True
      BackColor       =   8833260
      HeadLines       =   1
      RowHeight       =   15
      FormatLocked    =   -1  'True
      AllowAddNew     =   -1  'True
      AllowDelete     =   -1  'True
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
      ColumnCount     =   5
      BeginProperty Column00 
         DataField       =   "auto"
         Caption         =   "auto"
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
      BeginProperty Column01 
         DataField       =   "desc_cat"
         Caption         =   "ÇÓã ÇáÊÕäíÝ"
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
         DataField       =   "cat_num"
         Caption         =   "ÑÞã ÇáÍÞá"
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
         DataField       =   "cat_no"
         Caption         =   "cat_no"
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
         DataField       =   "desc_out"
         Caption         =   "ÇÓã ÇáÍÞá"
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
            Locked          =   -1  'True
            ColumnWidth     =   915.024
         EndProperty
         BeginProperty Column01 
            Locked          =   -1  'True
            ColumnWidth     =   2594.835
         EndProperty
         BeginProperty Column02 
            ColumnWidth     =   1005.165
         EndProperty
         BeginProperty Column03 
            Object.Visible         =   0   'False
            ColumnWidth     =   540.284
         EndProperty
         BeginProperty Column04 
            ColumnWidth     =   2594.835
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "CAT_OUTFRM"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim m_code As String

Private Sub Check1_Click()
 If Check1.value = 1 Then
 f_tmp.RecordSource = " SELECT     dbo.bnkout.OUT_NUM, dbo.bnkout.OUT_DESC, dbo.bnkout.OUT_INDX, dbo.bnkout.OUT_INDX3, dbo.bnkout.OUT_CAT," & _
                      " dbo.CODING.SUB_DESC AS DESC_CAT FROM dbo.bnkout " & _
                      " LEFT OUTER JOIN  Dbo.CODING ON '37' + dbo.bnkout.OUT_CAT = dbo.CODING.SUB_CODE " & _
                      " WHERE OUT_CHIOCE > 0 ORDER BY OUT_NUM "
f_tmp.Refresh
DataGrid1.Refresh

  Else
  f_tmp.RecordSource = " SELECT     dbo.bnkout.OUT_NUM, dbo.bnkout.OUT_DESC, dbo.bnkout.OUT_INDX, dbo.bnkout.OUT_INDX3, dbo.bnkout.OUT_CAT," & _
                      " dbo.CODING.SUB_DESC AS DESC_CAT FROM dbo.bnkout " & _
                      " LEFT OUTER JOIN  Dbo.CODING ON '37' + dbo.bnkout.OUT_CAT = dbo.CODING.SUB_CODE "
f_tmp.Refresh
DataGrid1.Refresh

 End If

End Sub

Private Sub Check2_Click()
If Check2.value = 1 Then
 f_tmp.RecordSource = " SELECT     dbo.bnkout.OUT_NUM,dbo.bnkout.OUT_cond as out_cond , dbo.bnkout.OUT_DESC, dbo.bnkout.OUT_INDX, dbo.bnkout.OUT_INDX3, dbo.bnkout.OUT_CAT," & _
                      " dbo.CODING.SUB_DESC AS DESC_CAT FROM dbo.bnkout " & _
                      " LEFT OUTER JOIN  Dbo.CODING ON '37' + dbo.bnkout.OUT_CAT = dbo.CODING.SUB_CODE " & _
                      " WHERE OUT_IF > 0 ORDER BY OUT_NUM  "
f_tmp.Refresh
DataGrid1.Refresh

  Else
  f_tmp.RecordSource = " SELECT     dbo.bnkout.OUT_NUM,dbo.bnkout.OUT_cond as out_cond , dbo.bnkout.OUT_DESC, dbo.bnkout.OUT_INDX, dbo.bnkout.OUT_INDX3, dbo.bnkout.OUT_CAT," & _
                      " dbo.CODING.SUB_DESC AS DESC_CAT FROM dbo.bnkout " & _
                      " LEFT OUTER JOIN  Dbo.CODING ON '37' + dbo.bnkout.OUT_CAT = dbo.CODING.SUB_CODE "
f_tmp.Refresh
DataGrid1.Refresh

 End If
End Sub

Private Sub DataGrid1_AfterColEdit(ByVal ColIndex As Integer)
 If DataGrid1.Col > 3 Then
m_row = f_tmp.Recordset.Bookmark - 1
    f_tmp.Recordset.Requery
f_tmp.Recordset.Move (m_row)
 End If
End Sub

Private Sub datagrid1_KeyPress(KeyAscii As Integer)
If KeyAscii = 32 Then
  
          DBList6.Visible = True
          DBList6.SetFocus
   End If
End Sub

Private Sub DBList6_KeyPress(KeyAscii As Integer)
 On Error Resume Next
  If KeyAscii = 13 Then
     m_row = f_tmp.Recordset.Bookmark - 1
    m_typ_CAT = Mid(DBList6.BoundText, 3, 2)
    m_out_num = DataGrid1.Columns(0)
  '  MsgBox m_typ_auther & m_typ_aut1
     sql = "execute upd_OUT_CAT " & "'" & m_out_num & "'" & "," & "'" & m_typ_CAT & "'" _
        
                cn.Execute sql, rdExecDirect
      
    DBList6.Visible = False
    'res1.Refresh
    f_tmp.Refresh
    DataGrid1.Refresh
    DataGrid1.SetFocus
    f_tmp.Recordset.Move (m_row)
    ElseIf KeyAscii = 27 Then
      DBList6.Visible = False
      DataGrid1.SetFocus
  End If
End Sub

Private Sub DataGrid2_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyInsert Then
m_code = Mid(view_coding37.Resultset![sub_code], 3, 4)
sql = "execute insr_catogorie" & "'" & m_code & "'"
  cn.Execute sql, rdExecDirect
  f_cat.Refresh
End If
End Sub

Private Sub DBList1_DblClick()
view_coding37.Resultset.Bookmark = DBList1.SelectedItem
m_code = Mid(view_coding37.Resultset![sub_code], 3, 4)
f_cat.RecordSource = "execute proc_catogorie " & "'" & m_code & "'"
f_cat.Refresh
DataGrid2.SetFocus

End Sub

Private Sub Form_Load()
f_tmp.RecordSource = " SELECT     dbo.bnkout.OUT_NUM,dbo.bnkout.OUT_cond as out_cond , dbo.bnkout.OUT_DESC, dbo.bnkout.OUT_INDX, dbo.bnkout.OUT_INDX3, dbo.bnkout.OUT_CAT," & _
                      " dbo.CODING.SUB_DESC AS DESC_CAT FROM dbo.bnkout " & _
                      " LEFT OUTER JOIN  Dbo.CODING ON '37' + dbo.bnkout.OUT_CAT = dbo.CODING.SUB_CODE "
f_tmp.Refresh
DataGrid1.Refresh

End Sub
