#tag Module
Protected Module Rules
	#tag Method, Flags = &h21
		Private Sub Bishop(Board As ChessEngine.Board, Row As Integer, Column As Integer, ByRef Moves() As Pair)
		  For X As Integer = Row + 1 To 7
		    If Board.Player(X, Column + (X - Row)) = Board.Player(Row, Column) Then Exit For
		    moves.Append(X:Column + (X - Row))
		    If Board.Player(X, Column + (X - Row)) <> -1 Then Exit For
		  Next
		  For X As Integer = Row - 1 DownTo 0
		    If Board.Player(X, Column - (Row - X)) = Board.Player(Row, Column) Then Exit For
		    moves.Append(X:Column - (Row - X))
		    If Board.Player(X, Column - (Row - X)) <> -1 Then Exit For
		  Next
		  
		  For Y As Integer = Column + 1 To 7
		    If Board.Player(Row + (Column - Y), Y) = Board.Player(Row, Column) Then Exit For
		    moves.Append(Row + (Column - Y):Y)
		    If Board.Player(Row + (Column - Y), Y) <> -1 Then Exit For
		  Next
		  For Y As Integer = Column - 1 DownTo 0
		    If Board.Player(Row - (Column - Y), Y) = Board.Player(Row, Column) Then Exit For
		    moves.Append(Row - (Column - Y):Y)
		    If Board.Player(Row - (Column - Y), Y) <> -1 Then Exit For
		  Next
		  
		  For Y As Integer = Column + 1 To 7
		    If Board.Player(Row + (Y - Column), Y) = Board.Player(Row, Column) Then Exit For
		    moves.Append(Row + (Y - Column):Y)
		    If Board.Player(Row + (Y - Column), Y) <> -1 Then Exit For
		  Next
		  For Y As Integer = Column - 1 DownTo 0
		    If Board.Player(Row - (Y - Column), Y) = Board.Player(Row, Column) Then Exit For
		    moves.Append(Row - (Y - Column):Y)
		    If Board.Player(Row - (Y - Column), Y) <> -1 Then Exit For
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetLegalMoves(Board As ChessEngine.Board, Row As Integer, Column As Integer) As Pair()
		  Dim moves() As Pair
		  Select Case Board.Rank(Row, Column)
		  Case Ranks.Pawn
		    Pawn(Board, Row, Column, moves)
		  Case Ranks.Rook
		    Rook(Board, Row, Column, moves)
		  Case Ranks.Knight
		    Knight(Board, Row, Column, moves)
		  Case Ranks.Bishop
		    Bishop(Board, Row, Column, moves)
		  Case Ranks.Queen
		    Queen(Board, Row, Column, moves)
		  Case Ranks.King
		    King(Board, Row, Column, moves)
		  End Select
		  For i As Integer = UBound(moves) DownTo 0
		    If Board.Player(moves(i).Left, moves(i).Right) = Board.Player(Row, Column) Then moves.Remove(i)
		  Next
		  Return moves
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsLegalMove(Board As ChessEngine.Board, Row1 As Integer, Column1 As Integer, Row2 As Integer, Column2 As Integer) As Boolean
		  Dim moves() As Pair = ChessEngine.Rules.GetLegalMoves(Board, Row1, Column1)
		  For Each m As Pair In moves
		    If m.Left = Row2 And m.Right = Column2 Then Return True
		  Next
		  
		  
		  'If Row1 > 7 Or Row1 < 0 Or Row2 > 7 Or Row2 < 0 Or Column1 > 7 Or Column1 < 0 Or Column2 > 7 Or Column2 < 0 Then Return False
		  'If Row1 = Row2 And Column1 = Column2 Then Return False
		  '
		  'Dim start, stop As Dictionary
		  'start = b(Row1, Column1)
		  'stop = b(Row2, Column2)
		  'Dim player As Integer = start.Value("Player")
		  'Select Case start.Value("Rank")
		  'Case Ranks.Pawn
		  'If player = Player_White Then
		  'Return (Row2 = Row1 + 1) And (Column1 = Column2)
		  'Else
		  'Return (Row2 = Row1 - 1) And (Column1 = Column2)
		  'End If
		  'Case Ranks.Rook
		  'Return (Row1 = Row2) Or (Column1 = Column2)
		  '
		  'Case Ranks.Knight
		  'If ((Column1 + 1 = Column2) Or (Column1 - 1 = Column2)) And ((Row1 + 2 = Row2) Or (Row1 - 2 = Row2)) Then
		  'Return b.SquareColor(Row1, Column1) <> b.SquareColor(Row2, Column2)
		  'ElseIf ((Column1 + 2 = Column2) Or (Column1 - 2 = Column2)) And ((Row1 + 1 = Row2) Or (Row1 - 1 = Row2)) Then
		  'Return b.SquareColor(Row1, Column1) <> b.SquareColor(Row2, Column2)
		  'End If
		  '
		  'Case Ranks.Bishop
		  'If b.SquareColor(Row1, Column1) <> b.SquareColor(Row2, Column2) Then Return False
		  'Return Row1 + Column1 = Row2 + Column2
		  '
		  'Case Ranks.Queen
		  'If b.SquareColor(Row1, Column1) <> b.SquareColor(Row2, Column2) Then
		  'Return (Row1 = Row2) Or (Column1 = Column2)
		  'Else
		  'Return Row1 + Column1 = Row2 + Column2
		  'End If
		  '
		  'Case Ranks.King
		  'If Row1 > Row2 + 1 Or Row1 < Row2 - 1 Or Column1 > Column2 + 1 Or Column1 < Column2 - 1 Then Return False
		  'If b.SquareColor(Row1, Column1) <> b.SquareColor(Row2, Column2) Then
		  'Return (Row1 = Row2) Or (Column1 = Column2)
		  'Else
		  'Return Row1 + Column1 = Row2 + Column2
		  'End If
		  'End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsUnderAttack(Board As ChessEngine.Board, Row As Integer, Column As Integer) As Integer
		  For i As Integer = 0 To 7
		    For j As Integer = 0 To 7
		      If Board.Rank(i, j) = Ranks.None Or Board.Rank(i, j) = Ranks.OutOfBounds Then Continue
		      If i = Row And j = Column Then Continue
		      Dim m() As Pair = GetLegalMoves(Board, Row, Column)
		      For Each move As Pair In m
		        If move.Left = Row And move.Right = Column Then Return Board.Player(i, j)
		      Next
		    Next
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub King(Board As ChessEngine.Board, Row As Integer, Column As Integer, ByRef Moves() As Pair)
		  If Row < 7 Then
		    moves.Append(Row + 1:Column)
		    moves.Append(Row + 1:Column + 1)
		    moves.Append(Row + 1:Column - 1)
		  End If
		  If Row > 1 Then
		    moves.Append(Row - 1:Column)
		    moves.Append(Row - 1:Column - 1)
		    moves.Append(Row - 1:Column + 1)
		  End If
		  If Not Board.Modified(Row, Column) Then ' King not moved yet
		    If Board.Player(Row, Column - 1) = -1 _
		      And Board.Player(Row, Column - 2) = -1 _
		      And Board.Player(Row , Column- 3) = Board.Player(Row, Column) _
		      And Board.Rank(Row, Column - 3) = Ranks.Rook Then Moves.Append(-1:-1) ' king-side castle
		      If Board.Player(Row, Column + 1) = -1 _
		        And Board.Player(Row, Column + 2) = -1 _
		        And Board.Player(Row, Column + 3) = -1 _
		        And Board.Player(Row, Column - 4) = Board.Player(Row, Column) _
		        And Board.Rank(Row, Column - 4) = Ranks.Rook Then Moves.Append(-1:-2) ' queen-side castle
		      End If
		      
		      For i As Integer = UBound(Moves) DownTo 0
		        Dim m As Pair = Moves(i)
		        Dim a As Integer = IsUnderAttack(Board, m.Left, m.Right)
		        If a = -1 Or a = Board.Player(Row, Column) Then Continue
		        Moves.Remove(i)
		      Next
		      #pragma Warning "Todo"
		      ' *Moving accross a check
		      
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Knight(Board As ChessEngine.Board, Row As Integer, Column As Integer, ByRef Moves() As Pair)
		  Dim possible() As Pair = Array(Row + 2:Column + 1, Row + 2:Column - 1, Row - 2:Column + 1, Row - 2:Column - 1, Row + 1:Column + 2, Row + 1:Column - 2, Row - 1:Column + 2, Row - 1:Column - 2)
		  
		  For Each p As Pair In possible
		    If Board(p.Left, p.Right) = Nil Then Continue
		    If Board.Player(p.Left, p.Right) = Board.Player(Row, Column) Then Continue
		    Moves.Append(p)
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Pawn(Board As ChessEngine.Board, Row As Integer, Column As Integer, ByRef Moves() As Pair)
		  If Row < 7 And Board.Player(Row, Column) = Player_White Then
		    If Board.Player(Row + 1, Column) = -1 Then moves.Append(Row+1:Column) ' normal move
		    If Board.Player(Row + 1, Column + 1) = Player_Black Then moves.Append(Row + 1:Column + 1) ' capture
		    If Board.Player(Row + 1, Column - 1) = Player_Black Then moves.Append(Row + 1:Column - 1) ' capture
		  End If
		  If Row > 0 And Board.Player(Row, Column) = Player_Black Then
		    If Board.Player(Row - 1, Column) = -1 Then moves.Append(Row - 1:Column) ' normal move
		    If Board.Player(Row - 1, Column - 1) = Player_White Then moves.Append(Row - 1:Column - 1) ' capture
		    If Board.Player(Row - 1, Column + 1) = Player_White Then moves.Append(Row - 1:Column + 1) ' capture
		  End If
		  If Row = 6 And Board.Player(Row, Column) = Player_Black Then moves.Append(Row - 2:Column)' opening double-move
		  If Row = 1 And Board.Player(Row, Column) = Player_White Then moves.Append(Row + 2:Column)' opening double-move
		  
		  #pragma Warning "Todo"
		  ' *en-passant
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Queen(Board As ChessEngine.Board, Row As Integer, Column As Integer, ByRef Moves() As Pair)
		  Bishop(Board, Row, Column, Moves)
		  Rook(Board, Row, Column, Moves)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Rook(Board As ChessEngine.Board, Row As Integer, Column As Integer, ByRef Moves() As Pair)
		  For X As Integer = Row + 1 To 7
		    If Board.Player(X, Column) = Board.Player(Row, Column) Then Exit For
		    moves.Append(X:Column)
		    If Board.Player(X, Column) <> -1 Then Exit For
		  Next
		  For X As Integer = Row - 1 DownTo 0
		    If Board.Player(X, Column) = Board.Player(Row, Column) Then Exit For
		    moves.Append(X:Column)
		    If Board.Player(X, Column) <> -1 Then Exit For
		  Next
		  
		  For Y As Integer = Column + 1 To 7
		    If Board.Player(Row, Y) = Board.Player(Row, Column) Then Exit For
		    moves.Append(Row:Y)
		    If Board.Player(Row, Y) <> -1 Then Exit For
		  Next
		  For Y As Integer = Column - 1 DownTo 0
		    If Board.Player(Row, Y) = Board.Player(Row, Column) Then Exit For
		    moves.Append(Row:Y)
		    If Board.Player(Row, Y) <> -1 Then Exit For
		  Next
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
