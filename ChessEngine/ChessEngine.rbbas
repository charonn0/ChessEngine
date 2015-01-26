#tag Module
Protected Module ChessEngine
	#tag Method, Flags = &h0
		Function IsLegalMove(Extends b As ChessEngine.Board, Row1 As Integer, Column1 As Integer, Row2 As Integer, Column2 As Integer) As Boolean
		  Dim moves() As Pair = ChessEngine.Rules.GetLegalMoves(b, Row1, Column1)
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


	#tag Constant, Name = Player_Black, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = Player_White, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant


	#tag Enum, Name = Ranks, Type = Integer, Flags = &h1
		Pawn=1
		  Rook
		  Knight
		  Bishop
		  Queen
		  King
		  None
		OutOfBounds
	#tag EndEnum


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
