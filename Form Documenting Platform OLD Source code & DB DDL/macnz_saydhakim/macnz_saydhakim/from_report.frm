VERSION 5.00
Object = "{8767A745-088E-4CA6-8594-073D6D2DE57A}#9.2#0"; "crviewer9.dll"
Begin VB.Form form_report 
   Caption         =   " ﬁ—Ì— ··ÿ»«⁄…"
   ClientHeight    =   3090
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   4680
   LinkTopic       =   "Form9"
   ScaleHeight     =   3090
   ScaleWidth      =   4680
   Begin CRVIEWER9LibCtl.CRViewer9 CRViewer91 
      Height          =   8565
      Left            =   -120
      TabIndex        =   0
      Top             =   -600
      Width           =   11925
      lastProp        =   500
      _cx             =   21034
      _cy             =   15108
      DisplayGroupTree=   -1  'True
      DisplayToolbar  =   -1  'True
      EnableGroupTree =   -1  'True
      EnableNavigationControls=   -1  'True
      EnableStopButton=   -1  'True
      EnablePrintButton=   -1  'True
      EnableZoomControl=   -1  'True
      EnableCloseButton=   -1  'True
      EnableProgressControl=   -1  'True
      EnableSearchControl=   -1  'True
      EnableRefreshButton=   -1  'True
      EnableDrillDown =   -1  'True
      EnableAnimationControl=   0   'False
      EnableSelectExpertButton=   0   'False
      EnableToolbar   =   -1  'True
      DisplayBorder   =   0   'False
      DisplayTabs     =   -1  'True
      DisplayBackgroundEdge=   -1  'True
      SelectionFormula=   ""
      EnablePopupMenu =   -1  'True
      EnableExportButton=   -1  'True
      EnableSearchExpertButton=   0   'False
      EnableHelpButton=   0   'False
      LaunchHTTPHyperlinksInNewBrowser=   -1  'True
   End
End
Attribute VB_Name = "form_report"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Report1 As New CrystalReport1
Dim Report2 As New CrystalReport2
Dim Report3 As New CrystalReport3
Dim Report4 As New CrystalReport4
Dim Report5 As New CrystalReport5
Dim Report6 As New CrystalReport6
Dim Report7 As New CrystalReport7
Dim Report8 As New CrystalReport8
Dim Report9 As New CrystalReport9

Dim Report10 As New CrystalReport10
Dim Report11 As New CrystalReport11
Dim Report13 As New CrystalReport13







Private Sub Form_Load()
Screen.MousePointer = vbHourglass
If jad_print = 1 Then
   CRViewer91.ReportSource = Report1
ElseIf jad_print = 2 Then
    CRViewer91.ReportSource = Report2
 ElseIf jad_print = 3 Then
    CRViewer91.ReportSource = Report3
  ElseIf jad_print = 4 Then
    CRViewer91.ReportSource = Report4
   
ElseIf jad_print = 5 Then
    CRViewer91.ReportSource = Report5
ElseIf jad_print = 6 Then
    CRViewer91.ReportSource = Report6
ElseIf jad_print = 7 Then
    CRViewer91.ReportSource = Report7
       
ElseIf jad_print = 8 Then
    CRViewer91.ReportSource = Report8
 ElseIf jad_print = 9 Then
    CRViewer91.ReportSource = Report9
 ElseIf jad_print = 10 Then
    CRViewer91.ReportSource = Report10
 ElseIf jad_print = 11 Then
    CRViewer91.ReportSource = Report11
     ElseIf jad_print = 13 Then
    CRViewer91.ReportSource = Report13
   
End If

CRViewer91.ViewReport
Screen.MousePointer = vbDefault


End Sub

Private Sub Form_Resize()
CRViewer91.Top = 0
CRViewer91.Left = 0
CRViewer91.Height = ScaleHeight
CRViewer91.Width = ScaleWidth

End Sub
