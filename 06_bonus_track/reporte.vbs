Sub LeerTabla()
'
' LeerTabla Macro
'

'
    With ActiveSheet.QueryTables.Add(Connection:= _
        "TEXT;C:\R\EXAM\interview_konfio\06_bonus_track\export.txt", Destination:= _
        Range("$A$1"))
        .Name = "export_2"
        .FieldNames = True
        .RowNumbers = False
        .FillAdjacentFormulas = False
        .PreserveFormatting = True
        .RefreshOnFileOpen = False
        .RefreshStyle = xlInsertDeleteCells
        .SavePassword = False
        .SaveData = True
        .AdjustColumnWidth = True
        .RefreshPeriod = 0
        .TextFilePromptOnRefresh = False
        .TextFilePlatform = 850
        .TextFileStartRow = 1
        .TextFileParseType = xlDelimited
        .TextFileTextQualifier = xlTextQualifierDoubleQuote
        .TextFileConsecutiveDelimiter = False
        .TextFileTabDelimiter = True
        .TextFileSemicolonDelimiter = False
        .TextFileCommaDelimiter = False
        .TextFileSpaceDelimiter = False
        .TextFileOtherDelimiter = ","
        .TextFileColumnDataTypes = Array(1, 1, 1, 1, 1, 1)
        .TextFileTrailingMinusNumbers = True
        .Refresh BackgroundQuery:=False
    End With
    Range("A1:E14").Select
    Range("E1").Activate
    ActiveSheet.Shapes.AddChart.Select
    ActiveChart.ChartType = xlXYScatter
    ActiveChart.SetSourceData Source:=Range("Hoja1!$A$1:$E$14")
    ActiveSheet.Shapes("1 Gráfico").IncrementLeft 275.25
    ActiveSheet.Shapes("1 Gráfico").IncrementTop -81
    Columns("E:E").EntireColumn.AutoFit
    Columns("E:E").ColumnWidth = 13.86
    Columns("D:D").ColumnWidth = 10.71
    Columns("C:C").ColumnWidth = 10
    Columns("B:B").ColumnWidth = 8.86
    ActiveSheet.Shapes("1 Gráfico").IncrementLeft 38.25
    ActiveSheet.Shapes("1 Gráfico").IncrementTop -6
End Sub
