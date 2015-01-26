#tag Class
Protected Class Board
	#tag Method, Flags = &h0
		Sub Constructor()
		  Dim w1() As ChessEngine.Ranks
		  w1 = Array(Ranks.Rook, Ranks.Knight, Ranks.Bishop, Ranks.Queen, Ranks.King, Ranks.Bishop, Ranks.Knight, Ranks.Rook)
		  For i As Integer = 0 To UBound(w1)
		    Layout(0, i) = New Dictionary("Player":Player_White, "Rank":w1(i))
		    Layout(1, i) = New Dictionary("Player":Player_White, "Rank":Ranks.Pawn)
		  Next
		  For j As Integer = 2 To 5
		    For i As Integer = 0 To 7
		      Layout(j, i) = New Dictionary("Player":-1, "Rank":Ranks.None)
		    Next
		  Next
		  
		  For i As Integer = 0 To UBound(w1)
		    Layout(7, i) = New Dictionary("Player":Player_Black, "Rank":w1(i))
		    Layout(6, i) = New Dictionary("Player":Player_Black, "Rank":Ranks.Pawn)
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified(Row As Integer, Column As Integer) As Boolean
		  Return Operator_Subscript(Row, Column).Lookup("Modified", False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Row As Integer, Column As Integer, Assigns NewBool As Boolean)
		  Operator_Subscript(Row, Column).Value("Modified") = NewBool
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Move(Row1 As Integer, Col1 As Integer, Row2 As Integer, Col2 As Integer) As Boolean
		  Layout(Row2, Col2) = Layout(Row1, Col1)
		  Layout(Row1, Col1) = New Dictionary("Player":-1, "Rank":Ranks.None)
		  Me.Modified(Row2, Col2) = True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Row As Integer, Column As Integer) As Dictionary
		  If Row > 7 Or Row < 0 Or Column > 7 Or Column < 0 Then Return Nil
		  Return Layout(Row, Column)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Player(Row As Integer, Column As Integer) As Integer
		  Return Operator_Subscript(Row, Column).Lookup("Player", -1)
		Exception
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Rank(Row As Integer, Column As Integer) As ChessEngine.Ranks
		  Return Operator_Subscript(Row, Column).Lookup("Rank", ChessEngine.Ranks.None)
		Exception 
		  Return Ranks.OutOfBounds
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SquareColor(Row As Integer, Column As Integer) As Color
		  Select Case True
		  Case Row = Column, (Row + Column) Mod 2 = 0
		    Return &cC0C0C000 ' black
		    
		  Else
		    Return &cFFFFFF00 ' white
		    
		  End Select
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Layout(7,7) As Dictionary
	#tag EndProperty


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
End Class
#tag EndClass
