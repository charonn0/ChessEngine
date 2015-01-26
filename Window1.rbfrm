#tag Window
Begin Window Window1
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   4.0e+2
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
   Title           =   "Chess"
   Visible         =   True
   Width           =   4.0e+2
   Begin Canvas Canvas1
      AcceptFocus     =   ""
      AcceptTabs      =   ""
      AutoDeactivate  =   True
      Backdrop        =   ""
      DoubleBuffer    =   True
      Enabled         =   True
      EraseBackground =   False
      Height          =   400
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
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
		  Dim sz As Integer = Min(g.Width / 8, g.Height / 8)
		  For X As Integer = 0 To Me.Width - sz Step sz
		    For Y As Integer = 0 To Me.Height - sz Step sz
		      Dim r, c As Integer
		      r = Y / sz
		      c = X / sz
		      g.ForeColor = Board.SquareColor(r, c)
		      g.FillRect(X, Y, sz, sz)
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
		      If symbol <> Nil Then g.DrawPicture(symbol, X, Y, sz, sz, 0, 0, symbol.Width, symbol.Height)
		    Next
		  Next
		  If CurrentPiece <> Nil Then
		    g.ForeColor = &c00800000
		    g.PenHeight = 3
		    g.PenWidth = 3
		    For Each m As Pair In ChessEngine.Rules.GetLegalMoves(Board, CurrentPiece.Left, CurrentPiece.Right)
		      g.DrawRect(m.Right * sz, m.Left * sz, sz, sz)
		    Next
		    g.ForeColor = &c0080FF00
		    g.DrawRect(CurrentPiece.Right * sz, CurrentPiece.Left * sz, sz, sz)
		  End If
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  Dim r, c As Integer
		  c = X \ 50
		  r = Y \ 50
		  If CurrentPiece = Nil Then
		    If Board.Rank(r, c) = ChessEngine.Ranks.None Then Return False
		    CurrentPiece = r:c
		  Else
		    Dim r1, c1 As Integer
		    r1 = CurrentPiece.Left
		    c1 = CurrentPiece.Right
		    If ChessEngine.Rules.IsLegalMove(Board, r1, c1, r, c) Then
		      Call Board.Move(r1, c1, r, c)
		    ElseIf r1 <> r And c1 <> c Then
		      MsgBox("Illegal move")
		    End If
		    CurrentPiece = Nil
		  End If
		  Me.Invalidate(False)
		  
		  
		End Function
	#tag EndEvent
#tag EndEvents
