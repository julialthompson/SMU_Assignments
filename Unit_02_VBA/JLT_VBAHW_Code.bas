Attribute VB_Name = "Module1"
Sub stocks():

    'loop through all sheets
    For Each ws In Worksheets
        
    'Set variable for holding ticker name
    Dim ticker As String
    
    'Create a variable to hold the total volume for a ticker
    Dim ttlvolume As Double
    
    'variable for yearly change needs
    Dim OpenV As Double
    Dim closev As Double
    
    'variable for percent change
    Dim percent_change As Double
    
    'Set initial volume value = 0
    ttlvolume = 0
    
    'set initial yearly change = 0
    OpenV = 0
    closev = 0
    
    'Create a summary table and keep track of location for each ticker
    Dim Summary_Table_Row As Integer
    Summary_Table_Row = 2
    
    ws.range("J1").Value = "Ticker"
    ws.range("k1").Value = "Yearly Change"
    ws.range("L1").Value = "Percent Change"
    ws.range("M1").Value = "Ttl Volume"
    
    'determine the last row
    lastrow = ws.Cells(Rows.Count, 1).End(xlUp).Row

    'loop through all ticker rows
    For i = 2 To lastrow
    
        'if this is the first line of the ticker
        If ws.Cells(i - 1, 1).Value <> ws.Cells(i, 1).Value Then
            
            'Define that open volume
            OpenV = ws.Cells(i, 3).Value
            

        'if the next ticker does not equal this ticker then
        ElseIf ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
        
            'define the ticker name
            ticker = ws.Cells(i, 1).Value
            
            'add to the total volume for that ticker
            ttlvolume = ttlvolume + ws.Cells(i, 7).Value
            
            'define the close volume
            closev = closev + ws.Cells(i, 6).Value
            
            'print ticker name and total volume in the summary table
            ws.range("J" & Summary_Table_Row).Value = ticker
            'print volume change in summary table
            ws.range("k" & Summary_Table_Row).Value = (closev - OpenV)
            
                'set color conditional
                If ws.range("k" & Summary_Table_Row).Value >= 0 Then
                    ws.range("K" & Summary_Table_Row).Interior.ColorIndex = 4
                Else
                    ws.range("K" & Summary_Table_Row).Interior.ColorIndex = 3
                End If
                
             'print percent change in summary tale & format as percent
            If OpenV = 0 Then
                ws.range("l" & Summary_Table_Row).Value = Null
            Else:
                ws.range("l" & Summary_Table_Row).Value = ((closev - OpenV) / OpenV)
            End If
                
            ws.range("l" & Summary_Table_Row).NumberFormat = "0.00%"
            
            'ws.Range("K" & Summary_Table_Row).value = Yearly Change
            ws.range("M" & Summary_Table_Row).Value = ttlvolume
            
            'add a row to the summary table
            Summary_Table_Row = Summary_Table_Row + 1
            
            'reset volume to equal 0
            ttlvolume = 0
            closev = 0
            OpenV = 0
            
        'if the next ticker does equal this ticker then
        Else
        
            'add to the brand total
            ttlvolume = ttlvolume + ws.Cells(i, 7).Value
            
        
        End If
    
    Next i
Next ws

End Sub

Sub summary():

For Each ws In Worksheets


    'define holders for max and min percent increases and their tickers
    Dim per_Increase As Long
    Dim per_decrease As Long
    Dim ttlvolume As Double
    Dim per_increase_t As String
    Dim per_decrease_t As String
    Dim ttlvolume_t As String
    Dim i As Integer

    'create a second table for mins & max's
    ws.range("q1").Value = "Ticker"
    ws.range("r1").Value = "Value"
    ws.range("p2").Value = "Greatest % Increase"
    ws.range("p3").Value = "Greatest % Decrease"
    ws.range("p4").Value = "Greatest Ttl Volume"

'    'find last row in new table
    lastrow = ws.Cells(Rows.Count, 13).End(xlUp).Row
        
    per_Increase = WorksheetFunction.Max(ws.range("L:L"))
    per_decrease = WorksheetFunction.Min(ws.range("L:L"))
    ttlvolume = WorksheetFunction.Max(ws.range("M:M"))
    ws.range("r2:r3").NumberFormat = "0.00%"
        
        For i = 2 To lastrow
            If ws.Cells(i, 12).Value = WorksheetFunction.Max(ws.range("L:L")) Then
                ws.Cells(i, 12).Value = per_Increase
                ws.Cells(2, 17).Value = WorksheetFunction.Index(ws.range("J:J"), WorksheetFunction.Match(ws.Cells(i, 12).Value, ws.range("l:l")))
                
            ElseIf ws.Cells(i, 12).Value = WorksheetFunction.Min(ws.range("L:L")) Then
                ws.Cells(i, 12).Value = per_decrease
                ws.Cells(i, 10).Value = per_decrease_t
                
            ElseIf ws.Cells(i, 13).Value = WorksheetFunction.Max(ws.range("M:M")) Then
                ws.Cells(i, 13).Value = ttlvolume
                ws.Cells(i, 10).Value = ttlvolume_t
            
            End If
            
        Next i

            
        ws.Cells(2, 18).Value = per_Increase
        ws.Cells(2, 17).Value = per_increase_t
        ws.Cells(3, 18).Value = per_decrease
        ws.Cells(3, 17).Value = per_decrease_t
        ws.Cells(4, 18).Value = ttlvolume
        ws.Cells(4, 17).Value = ttlvolume_t
        



Next ws

End Sub
    











