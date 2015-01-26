#tag Window
Begin Window Window1
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   1049124863
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "Untitled"
   Visible         =   True
   Width           =   600
   Begin Canvas Canvas1
      AcceptFocus     =   ""
      AcceptTabs      =   ""
      AutoDeactivate  =   True
      Backdrop        =   ""
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   400
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   0
      UseFocusRing    =   True
      Visible         =   True
      Width           =   400
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  Board = New ChessEngine.Board
		End Sub
	#tag EndEvent


	#tag Property, Flags = &h1
		Protected Board As ChessEngine.Board
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected CurrentPiece As Pair
	#tag EndProperty


#tag EndWindowCode

#tag Events Canvas1
	#tag Event
		Sub Paint(g As Graphics)
		  If Board = Nil Then Return
		  For X As Integer = 0 To Me.Width - 50 Step 50
		    For Y As Integer = 0 To Me.Height - 50 Step 50
		      Dim r, c As Integer
		      r = Y / 50
		      c = X / 50
		      g.ForeColor = Board.SquareColor(r, c)
		      g.FillRect(X, Y, 50, 50)
		      Dim isblack As Boolean = Board.Player(r, c) = ChessEngine.Player_Black
		      Dim symbol As Picture
		      Select Case Board.Rank(r, c)
		      Case ChessEngine.Ranks.Pawn
		        If isblack Then
		          symbol = BP
		        Else
		          symbol = WP
		        End If
		      Case ChessEngine.Ranks.Rook
		        If isblack Then
		          symbol = BR
		        Else
		          symbol = WR
		        End If
		      Case ChessEngine.Ranks.Knight
		        If isblack Then
		          symbol = BKn
		        Else
		          symbol = WKn
		        End If
		      Case ChessEngine.Ranks.Bishop
		        If isblack Then
		          symbol = BB
		        Else
		          symbol = WB
		        End If
		      Case ChessEngine.Ranks.Queen
		        If isblack Then
		          symbol = BQ
		        Else
		          symbol = WQ
		        End If
		      Case ChessEngine.Ranks.King
		        If isblack Then
		          symbol = BK
		        Else
		          symbol = WK
		        End If
		      End Select
		      If symbol <> Nil Then g.DrawPicture(symbol, X, Y, 50, 50, 0, 0, symbol.Width, symbol.Height)
		    Next
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Dim r, c As Integer
		  c = X \ 50
		  r = Y \ 50
		  If CurrentPiece = Nil Then
		    CurrentPiece = r:c
		  Else
		    Dim r1, c1 As Integer
		    r1 = CurrentPiece.Left
		    c1 = CurrentPiece.Right
		    If Board.IsLegalMove(r1, c1, r, c) Then
		      Call Board.Move(r1, c1, r, c)
		    Else
		      MsgBox("Illegal move")
		    End If
		    CurrentPiece = Nil
		  End If
		  Me.Invalidate(False)
		  
		  
		End Function
	#tag EndEvent
#tag EndEvents
