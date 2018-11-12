PImage base;
PImage highlight;
boolean selected;
PImage whiteWins;
PImage blackWins;


King whiteKing;
King blackKing;
Queen whiteQueen;
Queen blackQueen;
Rook[] whiteRook = new Rook[2];
Rook[] blackRook = new Rook[2];
Knight[] whiteKnight = new Knight[2];
Knight[] blackKnight = new Knight[2];
Bishop[] whiteBishop = new Bishop[2];
Bishop[] blackBishop = new Bishop[2];
Pawn[] whitePawn = new Pawn[8];
Pawn[] blackPawn = new Pawn[8];
public Piece[][] board = new Piece[8][8];

Square last = new Square();
int turn, winner = -1;

void setup() {
  
  size(900, 900);
  
  selected = false;
  base = loadImage("Base.jpg");
  highlight = loadImage("Highlight.png");
  imageMode(CENTER);
  turn = 0;
  
  whiteWins = loadImage("WhiteWins.png");
  blackWins = loadImage("BlackWins.png");

  
  setupPieces(); 
  
}

void draw() {

 if(selected)
    return;
  
  if(winner == 0) {  
    image(whiteWins, 450, 450);
    return;
  }
  else if(winner == 1) {
    image(blackWins, 450, 450);
    return;
  }
  
  drawBase(); 
  drawHighlight();
  drawPieces();
  checkCheck();  
  checkPawnUpgrades();
}


void setupPieces() {
  
  whiteKing = new King(0);
  board[0][4] = whiteKing;
  blackKing = new King(1);
  board[7][4] = blackKing;
  whiteQueen = new Queen(0);
  board[0][3] = whiteQueen;
  blackQueen = new Queen(1);
  board[7][3] = blackQueen;
  whiteRook[0] = new Rook(0, 0);
  board[0][0] = whiteRook[0];
  whiteRook[1] = new Rook(0, 1);
  board[0][7] = whiteRook[1];
  blackRook[0] = new Rook(1, 0);
  board[7][0] = blackRook[0];
  blackRook[1] = new Rook(1, 1);
  board[7][7] = blackRook[1];
  whiteKnight[0] = new Knight(0, 0);
  board[0][1] = whiteKnight[0];
  whiteKnight[1] = new Knight(0, 1);
  board[0][6] = whiteKnight[1];
  blackKnight[0] = new Knight(1, 0);
  board[7][1] = blackKnight[0];
  blackKnight[1] = new Knight(1, 1);
  board[7][6] = blackKnight[1];
  whiteBishop[0] = new Bishop(0, 0);
  board[0][2] = whiteBishop[0];
  whiteBishop[1] = new Bishop(0, 1);
  board[0][5] = whiteBishop[1];
  blackBishop[0] = new Bishop(1, 0);
  board[7][2] = blackBishop[0];
  blackBishop[1] = new Bishop(1, 1);
  board[7][5] = blackBishop[1];
  for(int i = 0; i < 8; i++){
    whitePawn[i] = new Pawn(0, i);
    board[1][i] = whitePawn[i];
    blackPawn[i] = new Pawn(1, i);
    board[6][i] = blackPawn[i];
  }
}

void drawBase() {
  imageMode(CENTER);
  image(base, height/2, width/2);
}

void drawPieces() {
  
  for(int i = 0; i < 8; i++)
    for(int j = 0; j < 8; j++)
      if(board[i][j] != null)
        board[i][j].show(); 
}

void drawHighlight() {
  
  int x = toPixel(toPos(mouseX));
  int y = toPixel(toPos(mouseY));
  if(x > 50 && x < width - 50 && y > 50 && y < height - 50)
  if(board[toPos(mouseY)][toPos(mouseX)] != null)
  if(board[toPos(mouseY)][toPos(mouseX)].side == turn)
  image(highlight, x, y, 100, 100);  
}

int toPos(int temp) {
  return ((temp - 50 ) / 100);
}

public int toPixel(int temp) {
      return temp * 100 + 100;   
}

void checkCheck() {

   if(isCheck(0)){
      whiteKing.drawCheck();
      if(checkMate(0))
         winner = 1;
   }
   
   if(isCheck(1)) {
       blackKing.drawCheck();
       if(checkMate(1))
          winner = 0;

   }
}
 
boolean isCheck(int s) {
  
  King king;
  if(s == 0) king = whiteKing;
  else king = blackKing;
  
  for(int i = 1; i <= 7; i++)
       if(king.pos.x + i < 8 && king.pos.y + i < 8){
         if(board[king.pos.y+i][king.pos.x+i] != null){
           if(board[king.pos.y+i][king.pos.x+i].side == board[king.pos.y][king.pos.x].side) break;
           else if(board[king.pos.y+i][king.pos.x+i].type == 'B' || board[king.pos.y+i][king.pos.x+i].type == 'Q')
             return true;
           break;
           }
         }
     for(int i = 1; i <= 7; i++)
       if(king.pos.x + i < 8 && king.pos.y - i > -1){
         if(board[king.pos.y-i][king.pos.x+i] != null){
           if(board[king.pos.y-i][king.pos.x+i].side == board[king.pos.y][king.pos.x].side) break;
           else if(board[king.pos.y-i][king.pos.x+i].type == 'B' || board[king.pos.y-i][king.pos.x+i].type == 'Q')
             return true;
        break;
        }
       }
     for(int i = 1; i <= 7; i++)
       if(king.pos.x - i > -1 && king.pos.y + i < 8){
         if(board[king.pos.y+i][king.pos.x-i] != null){
           if(board[king.pos.y+i][king.pos.x-i].side == board[king.pos.y][king.pos.x].side) break;
           else if(board[king.pos.y+i][king.pos.x-i].type == 'B' || board[king.pos.y+i][king.pos.x-i].type == 'Q')
             return true;
          break;
        }
       }
     for(int i = 1; i <= 7; i++)
       if(king.pos.x - i > -1 && king.pos.y - i > -1){
         if(board[king.pos.y-i][king.pos.x-i] != null){
           if(board[king.pos.y-i][king.pos.x-i].side == board[king.pos.y][king.pos.x].side) break;
           else if(board[king.pos.y-i][king.pos.x-i].type == 'B' || board[king.pos.y-i][king.pos.x-i].type == 'Q')
             return true;
         break;
         }
       }
       
       for(int i = 1; king.pos.y+i < 8 ; i++) {
      if(board[king.pos.y+i][king.pos.x] != null){
        if(board[king.pos.y+i][king.pos.x].side != board[king.pos.y][king.pos.x].side)
          if(board[king.pos.y+i][king.pos.x].type == 'R' || board[king.pos.y+i][king.pos.x].type == 'Q')
            return true;
        break;
      }   
    }
    
     for(int i = 1; king.pos.y-i > -1 ; i++) {
      if(board[king.pos.y-i][king.pos.x] != null){
        if(board[king.pos.y-i][king.pos.x].side != board[king.pos.y][king.pos.x].side)
          if(board[king.pos.y-i][king.pos.x].type == 'R' || board[king.pos.y-i][king.pos.x].type == 'Q')
    return true;
        break;
      }
    }

     for(int i = 1; king.pos.x+i < 8 ; i++) {
      if(board[king.pos.y][king.pos.x+i] != null){
        if(board[king.pos.y][king.pos.x+i].side != board[king.pos.y][king.pos.x].side)
          if(board[king.pos.y][king.pos.x+i].type == 'R' || board[king.pos.y][king.pos.x+i].type == 'Q')
    return true;
        break;
      }
    }

     for(int i = 1; king.pos.x-i > -1 ; i++) {
      if(board[king.pos.y][king.pos.x-i] != null){
        if(board[king.pos.y][king.pos.x-i].side != board[king.pos.y][king.pos.x].side)
          if(board[king.pos.y][king.pos.x-i].type == 'R' || board[king.pos.y][king.pos.x-i].type == 'Q')
    return true;
        break;
      }
    }
    
    if(king.pos.x+1 < 8 && king.pos.y-2 > -1){
     if(board[king.pos.y-2][king.pos.x+1] != null){
       if(board[king.pos.y-2][king.pos.x+1].side != board[king.pos.y][king.pos.x].side)
         if(board[king.pos.y-2][king.pos.x+1].type == 'N')
    return true;
     }
    }   

    if(king.pos.x+1 < 8 && king.pos.y+2 < 8){
     if(board[king.pos.y+2][king.pos.x+1] != null){
       if(board[king.pos.y+2][king.pos.x+1].side != board[king.pos.y][king.pos.x].side)
         if(board[king.pos.y+2][king.pos.x+1].type == 'N')
    return true;
     }
    }

    if(king.pos.x+2 < 8 && king.pos.y-1 > -1){
     if(board[king.pos.y-1][king.pos.x+2] != null){
       if(board[king.pos.y-1][king.pos.x+2].side != board[king.pos.y][king.pos.x].side)
         if(board[king.pos.y-1][king.pos.x+2].type == 'N')
    return true;
     }  
    }

    if(king.pos.x+2 < 8 && king.pos.y+1 < 8){
     if(board[king.pos.y+1][king.pos.x+2] != null){
       if(board[king.pos.y+1][king.pos.x+2].side != board[king.pos.y][king.pos.x].side)
         if(board[king.pos.y+1][king.pos.x+2].type == 'N')
    return true;     
     }  
    }

    if(king.pos.x-1 > -1 && king.pos.y-2 > -1){
     if(board[king.pos.y-2][king.pos.x-1] != null){
       if(board[king.pos.y-2][king.pos.x-1].side != board[king.pos.y][king.pos.x].side)
         if(board[king.pos.y-2][king.pos.x-1].type == 'N')
    return true;   
     }    
    }

    if(king.pos.x-1 > -1 && king.pos.y+2 < 8){
     if(board[king.pos.y+2][king.pos.x-1] != null){
       if(board[king.pos.y+2][king.pos.x-1].side != board[king.pos.y][king.pos.x].side)
         if(board[king.pos.y+2][king.pos.x-1].type == 'N')
    return true;
     }
    }
    if(king.pos.x-2 > -1 && king.pos.y-1 > -1){
     if(board[king.pos.y-1][king.pos.x-2] != null){
       if(board[king.pos.y-1][king.pos.x-2].side != board[king.pos.y][king.pos.x].side)
         if(board[king.pos.y-1][king.pos.x-2].type == 'N')
    return true;
     }  
    }
    if(king.pos.x-2 > -1 && king.pos.y+1 < 8){
     if(board[king.pos.y+1][king.pos.x-2] != null){
       if(board[king.pos.y+1][king.pos.x-2].side != board[king.pos.y][king.pos.x].side)
         if(board[king.pos.y+1][king.pos.x-2].type == 'N')
    return true;
     }
    }
    
    if(king.side == 0){
    if(king.pos.x+1 < 8 && king.pos.y+1 < 8)
      if(board[king.pos.y+1][king.pos.x+1] != null)
        if(board[king.pos.y+1][king.pos.x+1].side == 1)
          if(board[king.pos.y+1][king.pos.x+1].type == 'P')
            return true;
    if(king.pos.x-1 > -1 && king.pos.y+1 < 8)
      if(board[king.pos.y+1][king.pos.x-1] != null)
        if(board[king.pos.y+1][king.pos.x-1].side == 1)
          if(board[king.pos.y+1][king.pos.x-1].type == 'P')
            return true;      
    }
    
    if(king.side == 1){
    if(king.pos.x+1 < 8 && king.pos.y-1 > -1)
      if(board[king.pos.y-1][king.pos.x+1] != null)
        if(board[king.pos.y-1][king.pos.x+1].side == 0)
          if(board[king.pos.y-1][king.pos.x+1].type == 'P')
            return true;
    if(king.pos.x-1 > -1 && king.pos.y-1 > -1)
      if(board[king.pos.y-1][king.pos.x-1] != null)
        if(board[king.pos.y-1][king.pos.x-1].side == 0)
          if(board[king.pos.y-1][king.pos.x-1].type == 'P')
            return true;      
    }    
  return false;
}

boolean isCheck(King king) {
  
  for(int i = 1; i <= 7; i++)
       if(king.pos.x + i < 8 && king.pos.y + i < 8){
         if(board[king.pos.y+i][king.pos.x+i] != null){
           if(board[king.pos.y+i][king.pos.x+i].side == king.side) break;
           else if(board[king.pos.y+i][king.pos.x+i].type == 'B' || board[king.pos.y+i][king.pos.x+i].type == 'Q')
             return true;
           break;
           }
         }
     for(int i = 1; i <= 7; i++)
       if(king.pos.x + i < 8 && king.pos.y - i > -1){
         if(board[king.pos.y-i][king.pos.x+i] != null){
           if(board[king.pos.y-i][king.pos.x+i].side == king.side) break;
           else if(board[king.pos.y-i][king.pos.x+i].type == 'B' || board[king.pos.y-i][king.pos.x+i].type == 'Q')
             return true;
        break;
        }
       }
     for(int i = 1; i <= 7; i++)
       if(king.pos.x - i > -1 && king.pos.y + i < 8){
         if(board[king.pos.y+i][king.pos.x-i] != null){
           if(board[king.pos.y+i][king.pos.x-i].side == king.side) break;
           else if(board[king.pos.y+i][king.pos.x-i].type == 'B' || board[king.pos.y+i][king.pos.x-i].type == 'Q')
             return true;
          break;
        }
       }
     for(int i = 1; i <= 7; i++)
       if(king.pos.x - i > -1 && king.pos.y - i > -1){
         if(board[king.pos.y-i][king.pos.x-i] != null){
           if(board[king.pos.y-i][king.pos.x-i].side == king.side) break;
           else if(board[king.pos.y-i][king.pos.x-i].type == 'B' || board[king.pos.y-i][king.pos.x-i].type == 'Q')
             return true;
         break;
         }
       }
       
       for(int i = 1; king.pos.y+i < 8 ; i++) {
      if(board[king.pos.y+i][king.pos.x] != null){
        if(board[king.pos.y+i][king.pos.x].side != king.side)
          if(board[king.pos.y+i][king.pos.x].type == 'R' || board[king.pos.y+i][king.pos.x].type == 'Q')
            return true;
        break;
      }   
    }
    
     for(int i = 1; king.pos.y-i > -1 ; i++) {
      if(board[king.pos.y-i][king.pos.x] != null){
        if(board[king.pos.y-i][king.pos.x].side != king.side)
          if(board[king.pos.y-i][king.pos.x].type == 'R' || board[king.pos.y-i][king.pos.x].type == 'Q')
    return true;
        break;
      }
    }

     for(int i = 1; king.pos.x+i < 8 ; i++) {
      if(board[king.pos.y][king.pos.x+i] != null){
        if(board[king.pos.y][king.pos.x+i].side != king.side)
          if(board[king.pos.y][king.pos.x+i].type == 'R' || board[king.pos.y][king.pos.x+i].type == 'Q')
    return true;
        break;
      }
    }

     for(int i = 1; king.pos.x-i > -1 ; i++) {
      if(board[king.pos.y][king.pos.x-i] != null){
        if(board[king.pos.y][king.pos.x-i].side != king.side)
          if(board[king.pos.y][king.pos.x-i].type == 'R' || board[king.pos.y][king.pos.x-i].type == 'Q')
    return true;
        break;
      }
    }
    
    if(king.pos.x+1 < 8 && king.pos.y-2 > -1){
     if(board[king.pos.y-2][king.pos.x+1] != null){
       if(board[king.pos.y-2][king.pos.x+1].side != king.side)
         if(board[king.pos.y-2][king.pos.x+1].type == 'N')
    return true;
     }
    }   

    if(king.pos.x+1 < 8 && king.pos.y+2 < 8){
     if(board[king.pos.y+2][king.pos.x+1] != null){
       if(board[king.pos.y+2][king.pos.x+1].side != king.side)
         if(board[king.pos.y+2][king.pos.x+1].type == 'N')
    return true;
     }
    }

    if(king.pos.x+2 < 8 && king.pos.y-1 > -1){
     if(board[king.pos.y-1][king.pos.x+2] != null){
       if(board[king.pos.y-1][king.pos.x+2].side != king.side)
         if(board[king.pos.y-1][king.pos.x+2].type == 'N')
    return true;
     }  
    }

    if(king.pos.x+2 < 8 && king.pos.y+1 < 8){
     if(board[king.pos.y+1][king.pos.x+2] != null){
       if(board[king.pos.y+1][king.pos.x+2].side != king.side)
         if(board[king.pos.y+1][king.pos.x+2].type == 'N')
    return true;     
     }  
    }

    if(king.pos.x-1 > -1 && king.pos.y-2 > -1){
     if(board[king.pos.y-2][king.pos.x-1] != null){
       if(board[king.pos.y-2][king.pos.x-1].side != king.side)
         if(board[king.pos.y-2][king.pos.x-1].type == 'N')
    return true;   
     }    
    }

    if(king.pos.x-1 > -1 && king.pos.y+2 < 8){
     if(board[king.pos.y+2][king.pos.x-1] != null){
       if(board[king.pos.y+2][king.pos.x-1].side != king.side)
         if(board[king.pos.y+2][king.pos.x-1].type == 'N')
    return true;
     }
    }
    if(king.pos.x-2 > -1 && king.pos.y-1 > -1){
     if(board[king.pos.y-1][king.pos.x-2] != null){
       if(board[king.pos.y-1][king.pos.x-2].side != king.side)
         if(board[king.pos.y-1][king.pos.x-2].type == 'N')
    return true;
     }  
    }
    if(king.pos.x-2 > -1 && king.pos.y+1 < 8){
     if(board[king.pos.y+1][king.pos.x-2] != null){
       if(board[king.pos.y+1][king.pos.x-2].side != king.side)
         if(board[king.pos.y+1][king.pos.x-2].type == 'N')
    return true;
     }
    }
    
    if(king.side == 0){
    if(king.pos.x+1 < 8 && king.pos.y+1 < 8)
      if(board[king.pos.y+1][king.pos.x+1] != null)
        if(board[king.pos.y+1][king.pos.x+1].side == 1)
          if(board[king.pos.y+1][king.pos.x+1].type == 'P')
            return true;
    if(king.pos.x-1 > -1 && king.pos.y+1 < 8)
      if(board[king.pos.y+1][king.pos.x-1] != null)
        if(board[king.pos.y+1][king.pos.x-1].side == 1)
          if(board[king.pos.y+1][king.pos.x-1].type == 'P')
            return true;      
    }
    
    if(king.side == 1){
    if(king.pos.x+1 < 8 && king.pos.y-1 > -1)
      if(board[king.pos.y-1][king.pos.x+1] != null)
        if(board[king.pos.y-1][king.pos.x+1].side == 0)
          if(board[king.pos.y-1][king.pos.x+1].type == 'P')
            return true;
    if(king.pos.x-1 > -1 && king.pos.y-1 > -1)
      if(board[king.pos.y-1][king.pos.x-1] != null)
        if(board[king.pos.y-1][king.pos.x-1].side == 0)
          if(board[king.pos.y-1][king.pos.x-1].type == 'P')
            return true;      
    }    
  return false;
}

boolean checkMate(int s){
  
  King king;
  if(s == 0) king = whiteKing;
  else king = blackKing;
  
  king.storeMoves();
  int n = king.moveCounter;
  
  King temp = new King(s);
  
  if(king.moveCounter == 0){
  
    if(king.pos.x+1 < 8 && king.pos.y-2 > -1){
     if(board[king.pos.y-2][king.pos.x+1] != null){
       if(board[king.pos.y-2][king.pos.x+1].side != king.side)
         if(board[king.pos.y-2][king.pos.x+1].type == 'N')
     if(checkKnight(board[king.pos.y-2][king.pos.x+1]))
             return false;
     }  
    }   

    if(king.pos.x+1 < 8 && king.pos.y+2 < 8){
     if(board[king.pos.y+2][king.pos.x+1] != null){
       if(board[king.pos.y+2][king.pos.x+1].side != king.side)
       if(board[king.pos.y+2][king.pos.x+1].type == 'N')
    if(checkKnight(board[king.pos.y+2][king.pos.x+1]))
            return false;
     }     
    }
    if(king.pos.x+2 < 8 && king.pos.y-1 > -1){
     if(board[king.pos.y-1][king.pos.x+2] != null){
       if(board[king.pos.y-1][king.pos.x+2].side != king.side)
   if(board[king.pos.y-1][king.pos.x+2].type == 'N')
     if(checkKnight(board[king.pos.y-1][king.pos.x+2]))
    return false;
     }   
    }
    if(king.pos.x+2 < 8 && king.pos.y+1 < 8){
     if(board[king.pos.y+1][king.pos.x+2] != null){
       if(board[king.pos.y+1][king.pos.x+2].side != king.side)
   if(board[king.pos.y+1][king.pos.x+2].type == 'N')
      if(checkKnight(board[king.pos.y+1][king.pos.x+2]))
    return false;
     }
    }
    if(king.pos.x-1 > -1 && king.pos.y-2 > -1){
     if(board[king.pos.y-2][king.pos.x-1] != null){
       if(board[king.pos.y-2][king.pos.x-1].side != king.side)
   if(board[king.pos.y-2][king.pos.x-1].type == 'N')
     if(checkKnight(board[king.pos.y-2][king.pos.x-1]))
    return false;
     }
    }
    if(king.pos.x-1 > -1 && king.pos.y+2 < 8){
     if(board[king.pos.y+2][king.pos.x-1] != null){
       if(board[king.pos.y+2][king.pos.x-1].side != king.side)
   if(board[king.pos.y+2][king.pos.x-1].type == 'N')
      if(checkKnight(board[king.pos.y+2][king.pos.x-1]))
    return false;
     }
    }
    if(king.pos.x-2 > -1 && king.pos.y-1 > -1){
     if(board[king.pos.y-1][king.pos.x-2] != null){
       if(board[king.pos.y-1][king.pos.x-2].side != king.side)
   if(board[king.pos.y-1][king.pos.x-2].type == 'N'){

     if(checkKnight(board[king.pos.y-1][king.pos.x-2]))
    return false;
   }
     }
    }

    if(king.pos.x-2 > -1 && king.pos.y+1 < 8){
     if(board[king.pos.y+1][king.pos.x-2] != null){
       if(board[king.pos.y+1][king.pos.x-2].side != king.side)
   if(board[king.pos.y+1][king.pos.x-2].type == 'N')
     if(checkKnight(board[king.pos.y+1][king.pos.x-2]))
    return false;
     }
    }

return true;
    
       
  }
  
  for(int i = 0; i < n; i++) {
    
    temp.pos.x = king.moves[i].x;
    temp.pos.y = king.moves[i].y;
    
    if(!isCheck(temp))
      return false;   
      
      if(checkShielding()){
        return false;
      }
      
      if(i == n - 1){
      if(checkPiece(board[last.y][last.x]))
        return false;
      }
  }
    return true;
}

boolean checkKnight(Piece knight){

  Piece temp;
  for(int i = 1; i <= 7; i++)
       if(knight.pos.x + i < 8 && knight.pos.y + i < 8){
         if(board[knight.pos.y+i][knight.pos.x+i] != null){
           if(board[knight.pos.y+i][knight.pos.x+i].side == knight.side) break;
           else if(board[knight.pos.y+i][knight.pos.x+i].type == 'B' || board[knight.pos.y+i][knight.pos.x+i].type == 'Q'){
             temp = board[knight.pos.y+i][knight.pos.x+i];
             board[knight.pos.y+i][knight.pos.x+i] = null;
             board[knight.pos.y][knight.pos.x] = null;
             if(!isCheck(1 - knight.side)){
                board[knight.pos.y+i][knight.pos.x+i] = temp;
                board[knight.pos.y][knight.pos.x] = knight;
                return true;
              }
            board[knight.pos.y+i][knight.pos.x+i] = temp;
            board[knight.pos.y][knight.pos.x] = knight;
           }
            break;
           }
         }
     for(int i = 1; i <= 7; i++)
       if(knight.pos.x + i < 8 && knight.pos.y - i > -1){
         if(board[knight.pos.y-i][knight.pos.x+i] != null){
           if(board[knight.pos.y-i][knight.pos.x+i].side == knight.side) break;
           else if(board[knight.pos.y-i][knight.pos.x+i].type == 'B' || board[knight.pos.y-i][knight.pos.x+i].type == 'Q') {
            temp = board[knight.pos.y-i][knight.pos.x+i];
            board[knight.pos.y-i][knight.pos.x+i] = null;
            board[knight.pos.y][knight.pos.x] = null;
              if(!isCheck(1 - knight.side)){
               board[knight.pos.y-i][knight.pos.x+i] = temp;
               board[knight.pos.y][knight.pos.x] = knight;
                return true;
              }
              board[knight.pos.y-i][knight.pos.x+i] = temp;
              board[knight.pos.y][knight.pos.x] = knight;
         }
        break;
        }
       }
     for(int i = 1; i <= 7; i++)
       if(knight.pos.x - i > -1 && knight.pos.y + i < 8){
         if(board[knight.pos.y+i][knight.pos.x-i] != null){
           if(board[knight.pos.y+i][knight.pos.x-i].side == knight.side) break;
           else if(board[knight.pos.y+i][knight.pos.x-i].type == 'B' || board[knight.pos.y+i][knight.pos.x-i].type == 'Q'){
             temp = board[knight.pos.y+i][knight.pos.x-i]; //<>//
             board[knight.pos.y+i][knight.pos.x-i] = null;
             board[knight.pos.y][knight.pos.x] = null;
             if(!isCheck(1 - knight.side)){
               board[knight.pos.y+i][knight.pos.x-i] = temp;
               board[knight.pos.y][knight.pos.x] = knight;
             return true;
             }
             board[knight.pos.y+i][knight.pos.x-i] = temp;
             board[knight.pos.y][knight.pos.x] = knight;
           }
          break;
        }
       }
     for(int i = 1; i <= 7; i++)
       if(knight.pos.x - i > -1 && knight.pos.y - i > -1){
         if(board[knight.pos.y-i][knight.pos.x-i] != null){
           if(board[knight.pos.y-i][knight.pos.x-i].side == knight.side) break;
           else if(board[knight.pos.y-i][knight.pos.x-i].type == 'B' || board[knight.pos.y-i][knight.pos.x-i].type == 'Q'){
             temp = board[knight.pos.y-i][knight.pos.x-i];
             board[knight.pos.y-i][knight.pos.x-i] = null;
             board[knight.pos.y][knight.pos.x] = null;
             if(!isCheck(1 - knight.side)){
               board[knight.pos.y-i][knight.pos.x-i] = temp;
               board[knight.pos.y][knight.pos.x] = knight;
             return true;
             }
             board[knight.pos.y-i][knight.pos.x-i] = temp;
             board[knight.pos.y][knight.pos.x] = knight;
           }
          break;
        }
       }
       
       for(int i = 1; knight.pos.y+i < 8 ; i++) {
      if(board[knight.pos.y+i][knight.pos.x] != null){
        if(board[knight.pos.y+i][knight.pos.x].side != knight.side)
          if(board[knight.pos.y+i][knight.pos.x].type == 'R' || board[knight.pos.y+i][knight.pos.x].type == 'Q'){
            temp = board[knight.pos.y+i][knight.pos.x];
            board[knight.pos.y+i][knight.pos.x] = null;
            board[knight.pos.y][knight.pos.x] = null;
            if(!isCheck(1 - knight.side)){
              board[knight.pos.y+i][knight.pos.x] = temp;
              board[knight.pos.y][knight.pos.x] = knight;
                          print("A");
            return true;
            }
            board[knight.pos.y+i][knight.pos.x] = temp;
            board[knight.pos.y][knight.pos.x] = knight;
          }
        break;
      }   
    }
    
     for(int i = 1; knight.pos.y-i > -1 ; i++) {
      if(board[knight.pos.y-i][knight.pos.x] != null){
        if(board[knight.pos.y-i][knight.pos.x].side != knight.side)
          if(board[knight.pos.y-i][knight.pos.x].type == 'R' || board[knight.pos.y-i][knight.pos.x].type == 'Q'){
            temp = board[knight.pos.y-i][knight.pos.x];
            board[knight.pos.y-i][knight.pos.x] = null;
            board[knight.pos.y][knight.pos.x] = null;
            if(!isCheck(1 - knight.side)){
              board[knight.pos.y-i][knight.pos.x] = temp;
              board[knight.pos.y][knight.pos.x] = knight;
            return true;
            }
            board[knight.pos.y-i][knight.pos.x] = temp;
            board[knight.pos.y][knight.pos.x] = knight;
          }
        break;
      }   
    }

     for(int i = 1; knight.pos.x+i < 8 ; i++) {
      if(board[knight.pos.y][knight.pos.x+i] != null){
        if(board[knight.pos.y][knight.pos.x+i].side != knight.side)
          if(board[knight.pos.y][knight.pos.x+i].type == 'R' || board[knight.pos.y][knight.pos.x+i].type == 'Q'){
            temp = board[knight.pos.y][knight.pos.x+i];
            board[knight.pos.y][knight.pos.x+i] = null;
            board[knight.pos.y][knight.pos.x] = null;
            if(!isCheck(1 - knight.side)){
              board[knight.pos.y][knight.pos.x+i] = temp;
              board[knight.pos.y][knight.pos.x] = knight;
            return true;
            }
            board[knight.pos.y][knight.pos.x+i] = temp;
            board[knight.pos.y][knight.pos.x] = knight;
          }
        break;
      }   
    }

     for(int i = 1; knight.pos.x-i > -1 ; i++) {
      if(board[knight.pos.y][knight.pos.x-i] != null){
        if(board[knight.pos.y][knight.pos.x-i].side != knight.side)
          if(board[knight.pos.y][knight.pos.x-i].type == 'R' || board[knight.pos.y][knight.pos.x-i].type == 'Q'){
            temp = board[knight.pos.y][knight.pos.x-i];
            board[knight.pos.y][knight.pos.x-i] = null;
            board[knight.pos.y][knight.pos.x] = null;
            if(!isCheck(1 - knight.side)){
              board[knight.pos.y][knight.pos.x-i] = temp;
              board[knight.pos.y][knight.pos.x] = knight;
            return true;
            }
            board[knight.pos.y][knight.pos.x-i] = temp;
            board[knight.pos.y][knight.pos.x] = knight;
          }
        break;
      }   
    }
    
    if(knight.pos.x+1 < 8 && knight.pos.y-2 > -1){
     if(board[knight.pos.y-2][knight.pos.x+1] != null){
       if(board[knight.pos.y-2][knight.pos.x+1].side != knight.side)
         if(board[knight.pos.y-2][knight.pos.x+1].type == 'N'){
        temp = board[knight.pos.y-2][knight.pos.x+1];
        board[knight.pos.y-2][knight.pos.x+1] = null;
        board[knight.pos.y][knight.pos.x] = null;
        if(!isCheck(1 - knight.side)){
        board[knight.pos.y-2][knight.pos.x+1] = temp;
        board[knight.pos.y][knight.pos.x] = knight;
        return true;
        }
        board[knight.pos.y-2][knight.pos.x+1] = temp;
        board[knight.pos.y][knight.pos.x] = knight;
     }
    }   
    }
    if(knight.pos.x+1 < 8 && knight.pos.y+2 < 8){
     if(board[knight.pos.y+2][knight.pos.x+1] != null){
       if(board[knight.pos.y+2][knight.pos.x+1].side != knight.side)
         if(board[knight.pos.y+2][knight.pos.x+1].type == 'N'){
        temp = board[knight.pos.y+2][knight.pos.x+1];
        board[knight.pos.y+2][knight.pos.x+1] = null;
        board[knight.pos.y][knight.pos.x] = null;
        if(!isCheck(1 - knight.side)){
        board[knight.pos.y+2][knight.pos.x+1] = temp;
        board[knight.pos.y][knight.pos.x] = knight;
        return true;
        }
        board[knight.pos.y+2][knight.pos.x+1] = temp;
        board[knight.pos.y][knight.pos.x] = knight;
     }
    }   
    }
    
    if(knight.pos.x+2 < 8 && knight.pos.y-1 > -1){
     if(board[knight.pos.y-1][knight.pos.x+2] != null){
       if(board[knight.pos.y-1][knight.pos.x+2].side != knight.side)
         if(board[knight.pos.y-1][knight.pos.x+2].type == 'N'){
        temp = board[knight.pos.y-1][knight.pos.x+2];
        board[knight.pos.y-1][knight.pos.x+2] = null;
        board[knight.pos.y][knight.pos.x] = null;
        if(!isCheck(1 - knight.side)){
        board[knight.pos.y-1][knight.pos.x+2] = temp;
        board[knight.pos.y][knight.pos.x] = knight;
        return true;
        }
        board[knight.pos.y-1][knight.pos.x+2] = temp;
        board[knight.pos.y][knight.pos.x] = knight;
     }
    }   
    }
    if(knight.pos.x+2 < 8 && knight.pos.y+1 < 8){
     if(board[knight.pos.y+1][knight.pos.x+2] != null){
       if(board[knight.pos.y+1][knight.pos.x+2].side != knight.side)
         if(board[knight.pos.y+1][knight.pos.x+2].type == 'N'){
        temp = board[knight.pos.y+1][knight.pos.x+2];
        board[knight.pos.y+1][knight.pos.x+2] = null;
        board[knight.pos.y][knight.pos.x] = null;
        if(!isCheck(1 - knight.side)){
        board[knight.pos.y+1][knight.pos.x+2] = temp;
        board[knight.pos.y][knight.pos.x] = knight;
        return true;
        }
        board[knight.pos.y+1][knight.pos.x+2] = temp;
        board[knight.pos.y][knight.pos.x] = knight;
     }
    }   
    }
    if(knight.pos.x-1 > -1 && knight.pos.y-2 > -1){
     if(board[knight.pos.y-2][knight.pos.x-1] != null){
       if(board[knight.pos.y-2][knight.pos.x-1].side != knight.side)
         if(board[knight.pos.y-2][knight.pos.x-1].type == 'N'){
        temp = board[knight.pos.y-2][knight.pos.x-1];
        board[knight.pos.y-2][knight.pos.x-1] = null;
        board[knight.pos.y][knight.pos.x] = null;
        if(!isCheck(1 - knight.side)){
        board[knight.pos.y-2][knight.pos.x-1] = temp;
        board[knight.pos.y][knight.pos.x] = knight;
        return true;
        }
        board[knight.pos.y-2][knight.pos.x-1] = temp;
        board[knight.pos.y][knight.pos.x] = knight;
     }
    }   
    }
    if(knight.pos.x-1 > -1 && knight.pos.y+2 < 8){
     if(board[knight.pos.y+2][knight.pos.x-1] != null){
       if(board[knight.pos.y+2][knight.pos.x-1].side != knight.side)
         if(board[knight.pos.y+2][knight.pos.x-1].type == 'N'){
        temp = board[knight.pos.y+2][knight.pos.x-1];
        board[knight.pos.y+2][knight.pos.x-1] = null;
        board[knight.pos.y][knight.pos.x] = null;
        if(!isCheck(1 - knight.side)){
        board[knight.pos.y+2][knight.pos.x-1] = temp;
        board[knight.pos.y][knight.pos.x] = knight;
        return true;
        }
        board[knight.pos.y+2][knight.pos.x-1] = temp;
        board[knight.pos.y][knight.pos.x] = knight;
     }
    } 
    }
    if(knight.pos.x-2 > -1 && knight.pos.y-1 > -1){
     if(board[knight.pos.y-1][knight.pos.x-2] != null){
       if(board[knight.pos.y-1][knight.pos.x-2].side != knight.side)
         if(board[knight.pos.y-1][knight.pos.x-2].type == 'N'){
        temp = board[knight.pos.y-1][knight.pos.x-2];
        board[knight.pos.y-1][knight.pos.x-2] = null;
        board[knight.pos.y][knight.pos.x] = null;
        if(!isCheck(1 - knight.side)){
        board[knight.pos.y-1][knight.pos.x-2] = temp;
        board[knight.pos.y][knight.pos.x] = knight;
        return true;
        }
        board[knight.pos.y-1][knight.pos.x-2] = temp;
        board[knight.pos.y][knight.pos.x] = knight;
     }
    }   
    }
    if(knight.pos.x-2 > -1 && knight.pos.y+1 < 8){
     if(board[knight.pos.y+1][knight.pos.x-2] != null){
       if(board[knight.pos.y+1][knight.pos.x-2].side != knight.side)
         if(board[knight.pos.y+1][knight.pos.x-2].type == 'N'){
        temp = board[knight.pos.y+1][knight.pos.x-2];
        board[knight.pos.y+1][knight.pos.x-2] = null;
        board[knight.pos.y][knight.pos.x] = null;
        if(!isCheck(1 - knight.side)){
        board[knight.pos.y+1][knight.pos.x-2] = temp;
        board[knight.pos.y][knight.pos.x] = knight;
        return true;
        }
        board[knight.pos.y+1][knight.pos.x-2] = temp;
        board[knight.pos.y][knight.pos.x] = knight;
     }
    }
    }
    
    if(knight.side == 0){
    if(knight.pos.x+1 < 8 && knight.pos.y+1 < 8)
      if(board[knight.pos.y+1][knight.pos.x+1] != null)
        if(board[knight.pos.y+1][knight.pos.x+1].side == 1)
          if(board[knight.pos.y+1][knight.pos.x+1].type == 'P'){
          temp = board[knight.pos.y+1][knight.pos.x+1];
          board[knight.pos.y+1][knight.pos.x+1] = null;
          board[knight.pos.y][knight.pos.x] = null;
            if(!isCheck(1 - knight.side)){
              board[knight.pos.y+1][knight.pos.x+1] = temp;
              board[knight.pos.y][knight.pos.x] = knight;
              return true;
             }
          board[knight.pos.y+1][knight.pos.x+1] = temp;
          board[knight.pos.y][knight.pos.x] = knight;
     }
    if(knight.pos.x-1 > -1 && knight.pos.y+1 < 8)
      if(board[knight.pos.y+1][knight.pos.x-1] != null)
        if(board[knight.pos.y+1][knight.pos.x-1].side == 1)
          if(board[knight.pos.y+1][knight.pos.x-1].type == 'P'){
          temp = board[knight.pos.y+1][knight.pos.x-1];
          board[knight.pos.y+1][knight.pos.x-1] = null;
          board[knight.pos.y][knight.pos.x] = null;
            if(!isCheck(1 - knight.side)){
              board[knight.pos.y+1][knight.pos.x-1] = temp;
              board[knight.pos.y][knight.pos.x] = knight;
              return true;
             }
          board[knight.pos.y+1][knight.pos.x-1] = temp;
          board[knight.pos.y][knight.pos.x] = knight;
     }
    }
    if(knight.side == 1){
    if(knight.pos.x+1 < 8 && knight.pos.y-1 > -1)
      if(board[knight.pos.y-1][knight.pos.x+1] != null)
        if(board[knight.pos.y-1][knight.pos.x+1].side == 0)
          if(board[knight.pos.y-1][knight.pos.x+1].type == 'P'){
          temp = board[knight.pos.y-1][knight.pos.x+1];
          board[knight.pos.y-1][knight.pos.x+1] = null;
          board[knight.pos.y][knight.pos.x] = null;
            if(!isCheck(1 - knight.side)){
              board[knight.pos.y-1][knight.pos.x+1] = temp;
              board[knight.pos.y][knight.pos.x] = knight;
              return true;
             }
          board[knight.pos.y-1][knight.pos.x+1] = temp;
          board[knight.pos.y][knight.pos.x] = knight;
     }
     
    if(knight.pos.x-1 > -1 && knight.pos.y-1 > -1)
      if(board[knight.pos.y-1][knight.pos.x-1] != null)
        if(board[knight.pos.y-1][knight.pos.x-1].side == 0)
          if(board[knight.pos.y-1][knight.pos.x-1].type == 'P'){
          temp = board[knight.pos.y-1][knight.pos.x-1];
          board[knight.pos.y-1][knight.pos.x-1] = null;
          board[knight.pos.y][knight.pos.x] = null;
            if(!isCheck(1 - knight.side)){
              board[knight.pos.y-1][knight.pos.x-1] = temp;
              board[knight.pos.y][knight.pos.x] = knight;
              return true;
             }
          board[knight.pos.y][knight.pos.x] = knight;
          board[knight.pos.y-1][knight.pos.x-1] = temp;
     }
    }
  return false;
}

void checkPawnUpgrades() {

  for(int i = 0; i < 8; i++) {
    if(whitePawn[i] != null)
    if(whitePawn[i].pos.y == 7){
        Queen temp = new Queen(0, whitePawn[i].pos.x, 7);
        board[7][whitePawn[i].pos.x] = temp;
        whitePawn[i] = null;
        print("A");
    }
     if(blackPawn[i] != null)
    if(blackPawn[i].pos.y == 0){
        Queen temp = new Queen(1, blackPawn[i].pos.x, 0);
        board[0][blackPawn[i].pos.x] = temp;
        blackPawn[i] = null;
    }
  }
  
}


boolean checkPiece(Piece piece){

  Piece temp;
  for(int i = 1; i <= 7; i++)
       if(piece.pos.x + i < 8 && piece.pos.y + i < 8){
         if(board[piece.pos.y+i][piece.pos.x+i] != null){
           if(board[piece.pos.y+i][piece.pos.x+i].side == piece.side) break;
           else if(board[piece.pos.y+i][piece.pos.x+i].type == 'B' || board[piece.pos.y+i][piece.pos.x+i].type == 'Q'){
             temp = board[piece.pos.y+i][piece.pos.x+i];
             board[piece.pos.y+i][piece.pos.x+i] = null;
             board[piece.pos.y][piece.pos.x] = null;
             if(!isCheck(1 - piece.side)){
                board[piece.pos.y+i][piece.pos.x+i] = temp;
                board[piece.pos.y][piece.pos.x] = piece;
                return true;
              }
            board[piece.pos.y+i][piece.pos.x+i] = temp;
            board[piece.pos.y][piece.pos.x] = piece;
           }
            break;
           }
         }
     for(int i = 1; i <= 7; i++)
       if(piece.pos.x + i < 8 && piece.pos.y - i > -1){
         if(board[piece.pos.y-i][piece.pos.x+i] != null){
           if(board[piece.pos.y-i][piece.pos.x+i].side == piece.side) break;
           else if(board[piece.pos.y-i][piece.pos.x+i].type == 'B' || board[piece.pos.y-i][piece.pos.x+i].type == 'Q') {
            temp = board[piece.pos.y-i][piece.pos.x+i];
            board[piece.pos.y-i][piece.pos.x+i] = null;
            board[piece.pos.y][piece.pos.x] = null;
              if(!isCheck(1 - piece.side)){
               board[piece.pos.y-i][piece.pos.x+i] = temp;
               board[piece.pos.y][piece.pos.x] = piece;
                return true;
              }
              board[piece.pos.y-i][piece.pos.x+i] = temp;
              board[piece.pos.y][piece.pos.x] = piece;
         }
        break;
        }
       }
     for(int i = 1; i <= 7; i++)
       if(piece.pos.x - i > -1 && piece.pos.y + i < 8){
         if(board[piece.pos.y+i][piece.pos.x-i] != null){
           if(board[piece.pos.y+i][piece.pos.x-i].side == piece.side) break;
           else if(board[piece.pos.y+i][piece.pos.x-i].type == 'B' || board[piece.pos.y+i][piece.pos.x-i].type == 'Q'){
             temp = board[piece.pos.y+i][piece.pos.x-i];
             board[piece.pos.y+i][piece.pos.x-i] = null;
             board[piece.pos.y][piece.pos.x] = null;
             if(!isCheck(1 - piece.side)){
               board[piece.pos.y+i][piece.pos.x-i] = temp;
               board[piece.pos.y][piece.pos.x] = piece;
             return true;
             }
             board[piece.pos.y+i][piece.pos.x-i] = temp;
             board[piece.pos.y][piece.pos.x] = piece;
           }
          break;
        }
       }
     for(int i = 1; i <= 7; i++)
       if(piece.pos.x - i > -1 && piece.pos.y - i > -1){
         if(board[piece.pos.y-i][piece.pos.x-i] != null){
           if(board[piece.pos.y-i][piece.pos.x-i].side == piece.side) break;
           else if(board[piece.pos.y-i][piece.pos.x-i].type == 'B' || board[piece.pos.y-i][piece.pos.x-i].type == 'Q'){
             temp = board[piece.pos.y-i][piece.pos.x-i];
             board[piece.pos.y-i][piece.pos.x-i] = null;
             board[piece.pos.y][piece.pos.x] = null;
             if(!isCheck(1 - piece.side)){
               board[piece.pos.y-i][piece.pos.x-i] = temp;
               board[piece.pos.y][piece.pos.x] = piece;
             return true;
             }
             board[piece.pos.y-i][piece.pos.x-i] = temp;
             board[piece.pos.y][piece.pos.x] = piece;
           }
          break;
        }
       }
       
       for(int i = 1; piece.pos.y+i < 8 ; i++) {
      if(board[piece.pos.y+i][piece.pos.x] != null){
        if(board[piece.pos.y+i][piece.pos.x].side != piece.side)
          if(board[piece.pos.y+i][piece.pos.x].type == 'R' || board[piece.pos.y+i][piece.pos.x].type == 'Q'){
            temp = board[piece.pos.y+i][piece.pos.x];
            board[piece.pos.y+i][piece.pos.x] = null;
            board[piece.pos.y][piece.pos.x] = null;
            if(!isCheck(1 - piece.side)){
              board[piece.pos.y+i][piece.pos.x] = temp;
              board[piece.pos.y][piece.pos.x] = piece;
                          print("A");
            return true;
            }
            board[piece.pos.y+i][piece.pos.x] = temp;
            board[piece.pos.y][piece.pos.x] = piece;
          }
        break;
      }   
    }
    
     for(int i = 1; piece.pos.y-i > -1 ; i++) {
      if(board[piece.pos.y-i][piece.pos.x] != null){
        if(board[piece.pos.y-i][piece.pos.x].side != piece.side)
          if(board[piece.pos.y-i][piece.pos.x].type == 'R' || board[piece.pos.y-i][piece.pos.x].type == 'Q'){
            temp = board[piece.pos.y-i][piece.pos.x];
            board[piece.pos.y-i][piece.pos.x] = null;
            board[piece.pos.y][piece.pos.x] = null;
            if(!isCheck(1 - piece.side)){
              board[piece.pos.y-i][piece.pos.x] = temp;
              board[piece.pos.y][piece.pos.x] = piece;
            return true;
            }
            board[piece.pos.y-i][piece.pos.x] = temp;
            board[piece.pos.y][piece.pos.x] = piece;
          }
        break;
      }   
    }

     for(int i = 1; piece.pos.x+i < 8 ; i++) {
      if(board[piece.pos.y][piece.pos.x+i] != null){
        if(board[piece.pos.y][piece.pos.x+i].side != piece.side)
          if(board[piece.pos.y][piece.pos.x+i].type == 'R' || board[piece.pos.y][piece.pos.x+i].type == 'Q'){
            temp = board[piece.pos.y][piece.pos.x+i];
            board[piece.pos.y][piece.pos.x+i] = null;
            board[piece.pos.y][piece.pos.x] = null;
            if(!isCheck(1 - piece.side)){
              board[piece.pos.y][piece.pos.x+i] = temp;
              board[piece.pos.y][piece.pos.x] = piece;
            return true;
            }
            board[piece.pos.y][piece.pos.x+i] = temp;
            board[piece.pos.y][piece.pos.x] = piece;
          }
        break;
      }   
    }

     for(int i = 1; piece.pos.x-i > -1 ; i++) {
      if(board[piece.pos.y][piece.pos.x-i] != null){
        if(board[piece.pos.y][piece.pos.x-i].side != piece.side)
          if(board[piece.pos.y][piece.pos.x-i].type == 'R' || board[piece.pos.y][piece.pos.x-i].type == 'Q'){
            temp = board[piece.pos.y][piece.pos.x-i];
            board[piece.pos.y][piece.pos.x-i] = null;
            board[piece.pos.y][piece.pos.x] = null;
            if(!isCheck(1 - piece.side)){
              board[piece.pos.y][piece.pos.x-i] = temp;
              board[piece.pos.y][piece.pos.x] = piece;
            return true;
            }
            board[piece.pos.y][piece.pos.x-i] = temp;
            board[piece.pos.y][piece.pos.x] = piece;
          }
        break;
      }   
    }
    
    if(piece.pos.x+1 < 8 && piece.pos.y-2 > -1){
     if(board[piece.pos.y-2][piece.pos.x+1] != null){
       if(board[piece.pos.y-2][piece.pos.x+1].side != piece.side)
         if(board[piece.pos.y-2][piece.pos.x+1].type == 'N'){
        temp = board[piece.pos.y-2][piece.pos.x+1];
        board[piece.pos.y-2][piece.pos.x+1] = null;
        board[piece.pos.y][piece.pos.x] = null;
        if(!isCheck(1 - piece.side)){
        board[piece.pos.y-2][piece.pos.x+1] = temp;
        board[piece.pos.y][piece.pos.x] = piece;
        return true;
        }
        board[piece.pos.y-2][piece.pos.x+1] = temp;
        board[piece.pos.y][piece.pos.x] = piece;
     }
    }   
    }
    if(piece.pos.x+1 < 8 && piece.pos.y+2 < 8){
     if(board[piece.pos.y+2][piece.pos.x+1] != null){
       if(board[piece.pos.y+2][piece.pos.x+1].side != piece.side)
         if(board[piece.pos.y+2][piece.pos.x+1].type == 'N'){
        temp = board[piece.pos.y+2][piece.pos.x+1];
        board[piece.pos.y+2][piece.pos.x+1] = null;
        board[piece.pos.y][piece.pos.x] = null;
        if(!isCheck(1 - piece.side)){
        board[piece.pos.y+2][piece.pos.x+1] = temp;
        board[piece.pos.y][piece.pos.x] = piece;
        return true;
        }
        board[piece.pos.y+2][piece.pos.x+1] = temp;
        board[piece.pos.y][piece.pos.x] = piece;
     }
    }   
    }
    
    if(piece.pos.x+2 < 8 && piece.pos.y-1 > -1){
     if(board[piece.pos.y-1][piece.pos.x+2] != null){
       if(board[piece.pos.y-1][piece.pos.x+2].side != piece.side)
         if(board[piece.pos.y-1][piece.pos.x+2].type == 'N'){
        temp = board[piece.pos.y-1][piece.pos.x+2];
        board[piece.pos.y-1][piece.pos.x+2] = null;
        board[piece.pos.y][piece.pos.x] = null;
        if(!isCheck(1 - piece.side)){
        board[piece.pos.y-1][piece.pos.x+2] = temp;
        board[piece.pos.y][piece.pos.x] = piece;
        return true;
        }
        board[piece.pos.y-1][piece.pos.x+2] = temp;
        board[piece.pos.y][piece.pos.x] = piece;
     }
    }   
    }
    if(piece.pos.x+2 < 8 && piece.pos.y+1 < 8){
     if(board[piece.pos.y+1][piece.pos.x+2] != null){
       if(board[piece.pos.y+1][piece.pos.x+2].side != piece.side)
         if(board[piece.pos.y+1][piece.pos.x+2].type == 'N'){
        temp = board[piece.pos.y+1][piece.pos.x+2];
        board[piece.pos.y+1][piece.pos.x+2] = null;
        board[piece.pos.y][piece.pos.x] = null;
        if(!isCheck(1 - piece.side)){
        board[piece.pos.y+1][piece.pos.x+2] = temp;
        board[piece.pos.y][piece.pos.x] = piece;
        return true;
        }
        board[piece.pos.y+1][piece.pos.x+2] = temp;
        board[piece.pos.y][piece.pos.x] = piece;
     }
    }   
    }
    if(piece.pos.x-1 > -1 && piece.pos.y-2 > -1){
     if(board[piece.pos.y-2][piece.pos.x-1] != null){
       if(board[piece.pos.y-2][piece.pos.x-1].side != piece.side)
         if(board[piece.pos.y-2][piece.pos.x-1].type == 'N'){
        temp = board[piece.pos.y-2][piece.pos.x-1];
        board[piece.pos.y-2][piece.pos.x-1] = null;
        board[piece.pos.y][piece.pos.x] = null;
        if(!isCheck(1 - piece.side)){
        board[piece.pos.y-2][piece.pos.x-1] = temp;
        board[piece.pos.y][piece.pos.x] = piece;
        return true;
        }
        board[piece.pos.y-2][piece.pos.x-1] = temp;
        board[piece.pos.y][piece.pos.x] = piece;
     }
    }   
    }
    if(piece.pos.x-1 > -1 && piece.pos.y+2 < 8){
     if(board[piece.pos.y+2][piece.pos.x-1] != null){
       if(board[piece.pos.y+2][piece.pos.x-1].side != piece.side)
         if(board[piece.pos.y+2][piece.pos.x-1].type == 'N'){
        temp = board[piece.pos.y+2][piece.pos.x-1];
        board[piece.pos.y+2][piece.pos.x-1] = null;
        board[piece.pos.y][piece.pos.x] = null;
        if(!isCheck(1 - piece.side)){
        board[piece.pos.y+2][piece.pos.x-1] = temp;
        board[piece.pos.y][piece.pos.x] = piece;
        return true;
        }
        board[piece.pos.y+2][piece.pos.x-1] = temp;
        board[piece.pos.y][piece.pos.x] = piece;
     }
    } 
    }
    if(piece.pos.x-2 > -1 && piece.pos.y-1 > -1){
     if(board[piece.pos.y-1][piece.pos.x-2] != null){
       if(board[piece.pos.y-1][piece.pos.x-2].side != piece.side)
         if(board[piece.pos.y-1][piece.pos.x-2].type == 'N'){
        temp = board[piece.pos.y-1][piece.pos.x-2];
        board[piece.pos.y-1][piece.pos.x-2] = null;
        board[piece.pos.y][piece.pos.x] = null;
        if(!isCheck(1 - piece.side)){
        board[piece.pos.y-1][piece.pos.x-2] = temp;
        board[piece.pos.y][piece.pos.x] = piece;
        return true;
        }
        board[piece.pos.y-1][piece.pos.x-2] = temp;
        board[piece.pos.y][piece.pos.x] = piece;
     }
    }   
    }
    if(piece.pos.x-2 > -1 && piece.pos.y+1 < 8){
     if(board[piece.pos.y+1][piece.pos.x-2] != null){
       if(board[piece.pos.y+1][piece.pos.x-2].side != piece.side)
         if(board[piece.pos.y+1][piece.pos.x-2].type == 'N'){
        temp = board[piece.pos.y+1][piece.pos.x-2];
        board[piece.pos.y+1][piece.pos.x-2] = null;
        board[piece.pos.y][piece.pos.x] = null;
        if(!isCheck(1 - piece.side)){
        board[piece.pos.y+1][piece.pos.x-2] = temp;
        board[piece.pos.y][piece.pos.x] = piece;
        return true;
        }
        board[piece.pos.y+1][piece.pos.x-2] = temp;
        board[piece.pos.y][piece.pos.x] = piece;
     }
    }
    }
    
    if(piece.side == 0){
    if(piece.pos.x+1 < 8 && piece.pos.y+1 < 8)
      if(board[piece.pos.y+1][piece.pos.x+1] != null)
        if(board[piece.pos.y+1][piece.pos.x+1].side == 1)
          if(board[piece.pos.y+1][piece.pos.x+1].type == 'P'){
          temp = board[piece.pos.y+1][piece.pos.x+1];
          board[piece.pos.y+1][piece.pos.x+1] = null;
          board[piece.pos.y][piece.pos.x] = null;
            if(!isCheck(1 - piece.side)){
              board[piece.pos.y+1][piece.pos.x+1] = temp;
              board[piece.pos.y][piece.pos.x] = piece;
              return true;
             }
          board[piece.pos.y+1][piece.pos.x+1] = temp;
          board[piece.pos.y][piece.pos.x] = piece;
     }
    if(piece.pos.x-1 > -1 && piece.pos.y+1 < 8)
      if(board[piece.pos.y+1][piece.pos.x-1] != null)
        if(board[piece.pos.y+1][piece.pos.x-1].side == 1)
          if(board[piece.pos.y+1][piece.pos.x-1].type == 'P'){
          temp = board[piece.pos.y+1][piece.pos.x-1];
          board[piece.pos.y+1][piece.pos.x-1] = null;
          board[piece.pos.y][piece.pos.x] = null;
            if(!isCheck(1 - piece.side)){
              board[piece.pos.y+1][piece.pos.x-1] = temp;
              board[piece.pos.y][piece.pos.x] = piece;
              return true;
             }
          board[piece.pos.y+1][piece.pos.x-1] = temp;
          board[piece.pos.y][piece.pos.x] = piece;
     }
    }
    if(piece.side == 1){
    if(piece.pos.x+1 < 8 && piece.pos.y-1 > -1)
      if(board[piece.pos.y-1][piece.pos.x+1] != null)
        if(board[piece.pos.y-1][piece.pos.x+1].side == 0)
          if(board[piece.pos.y-1][piece.pos.x+1].type == 'P'){
          temp = board[piece.pos.y-1][piece.pos.x+1];
          board[piece.pos.y-1][piece.pos.x+1] = null;
          board[piece.pos.y][piece.pos.x] = null;
            if(!isCheck(1 - piece.side)){
              board[piece.pos.y-1][piece.pos.x+1] = temp;
              board[piece.pos.y][piece.pos.x] = piece;
              return true;
             }
          board[piece.pos.y-1][piece.pos.x+1] = temp;
          board[piece.pos.y][piece.pos.x] = piece;
     }
     
    if(piece.pos.x-1 > -1 && piece.pos.y-1 > -1)
      if(board[piece.pos.y-1][piece.pos.x-1] != null)
        if(board[piece.pos.y-1][piece.pos.x-1].side == 0)
          if(board[piece.pos.y-1][piece.pos.x-1].type == 'P'){
          temp = board[piece.pos.y-1][piece.pos.x-1];
          board[piece.pos.y-1][piece.pos.x-1] = null;
          board[piece.pos.y][piece.pos.x] = null;
            if(!isCheck(1 - piece.side)){
              board[piece.pos.y-1][piece.pos.x-1] = temp;
              board[piece.pos.y][piece.pos.x] = piece;
              return true;
             }
          board[piece.pos.y][piece.pos.x] = piece;
          board[piece.pos.y-1][piece.pos.x-1] = temp;
     }
    }
  return false;
}

boolean checkShielding(){

  Piece piece = board[last.y][last.x];
  King king;
  int i;
  if(turn == 0) king = whiteKing;
  else king = blackKing;
  Square temp = new Square();
  
  if(piece.type == 'R' || piece.type == 'Q'){    
    if(piece.pos.x == king.pos.x){
      if(piece.pos.y > king.pos.y)
        temp.x = piece.pos.x;
        temp.y = piece.pos.y;
        for(i = 0; i < (piece.pos.y - king.pos.y); i++){
           if(canShield(temp)) return true;
           temp.y--;
        } 
       if(piece.pos.y < king.pos.y)
        temp.x = piece.pos.x;
        temp.y = piece.pos.y;
        for(i = 0; i < (king.pos.y - piece.pos.y); i++){
           if(canShield(temp)) return true;
           temp.y++;
        } 
    }
    
    if(piece.pos.y == king.pos.y){
      if(piece.pos.x > king.pos.x)
        temp.x = piece.pos.x;
        temp.y = piece.pos.y;
        for(i = 0; i < (piece.pos.x - king.pos.x); i++){
           if(canShield(temp)) return true;
           temp.x++;
        } 
       if(piece.pos.x < king.pos.x)
        temp.x = piece.pos.x;
        temp.y = piece.pos.y;
        for(i = 0; i < (king.pos.x - piece.pos.x); i++){
           if(canShield(temp)) return true;
           temp.x--;
        } 
    }        
  }
  
  if(piece.type == 'B' || piece.type == 'Q'){  
    
    if(piece.pos.x > king.pos.x){
      if(piece.pos.y > king.pos.y)
        temp.x = piece.pos.x;
        temp.y = piece.pos.y;
        for(i = 0; i < (piece.pos.y - king.pos.y); i++){
           if(canShield(temp)) return true;
           temp.y--;
     temp.x--;
        } 
       if(piece.pos.y < king.pos.y)
        temp.x = piece.pos.x;
        temp.y = piece.pos.y;
        for(i = 0; i < (king.pos.y - piece.pos.y); i++){
           if(canShield(temp)) return true;
           temp.y++;
     temp.x--;
        } 
    }
    
    if(piece.pos.x < king.pos.x){
      if(piece.pos.y > king.pos.y)
        temp.x = piece.pos.x;
        temp.y = piece.pos.y;
        for(i = 0; i < (piece.pos.y - king.pos.y); i++){
           if(canShield(temp)) return true;
           temp.y--;
     temp.x++;
        } 
       if(piece.pos.y < king.pos.y)
        temp.x = piece.pos.x;
        temp.y = piece.pos.y;
        for(i = 0; i < (king.pos.y - piece.pos.y); i++){
           if(canShield(temp)) return true;
           temp.y++;
           temp.x++;
        } 
    }      
  }
  
  
       
  return false;
}

boolean canShield(Square square){

  if(turn == 0){
  whiteQueen.storeMoves();
  if(whiteQueen.isValid(square)) return true;
  whiteRook[0].storeMoves();
  if(whiteRook[0].isValid(square)) return true;
  whiteRook[1].storeMoves();
  if(whiteRook[1].isValid(square)) return true;
  whiteBishop[0].storeMoves();
  if(whiteBishop[0].isValid(square)) return true;
  whiteBishop[1].storeMoves();
  if(whiteBishop[0].isValid(square)) return true;
  whiteKnight[0].storeMoves();
  if(whiteKnight[0].isValid(square)) return true;
  whiteKnight[1].storeMoves();
  if(whiteKnight[1].isValid(square)) return true; 
  for(int i = 0; i < 8; i++){
  whitePawn[i].storeMoves();
  if(whitePawn[i].isValid(square)) return true; 
  }
  }
  
  else{
    
   blackQueen.storeMoves();
  if(blackQueen.isValid(square)) return true;
  blackRook[0].storeMoves();
  if(blackRook[0].isValid(square)) return true;
  blackRook[1].storeMoves();
  if(blackRook[1].isValid(square)) return true;
  blackBishop[0].storeMoves();
  if(blackBishop[0].isValid(square)) return true;
  blackBishop[1].storeMoves();
  if(blackBishop[0].isValid(square)) return true;
  blackKnight[0].storeMoves();
  if(blackKnight[0].isValid(square)) return true;
  blackKnight[1].storeMoves();
  if(blackKnight[1].isValid(square)) return true; 
  for(int i = 0; i < 8; i++){
  blackPawn[i].storeMoves();
  if(blackPawn[i].isValid(square)) return true; 
  }
  }
  
  
  return false;
}


  void mousePressed() {
  
  if(winner != -1) return;
  
  if(selected) {
  if(mousePressed) {
   Square temp = new Square();
   Square backup = new Square();
   temp.x = toPos(mouseX);
   temp.y = toPos(mouseY);
   if(temp.x > 7 || temp.x < 0 || temp.y > 7 || temp.y < 0) return;
   backup.x = last.x;
   backup.y = last.y;
   Piece tempnew = board[temp.y][temp.x];
   Piece tempold = board[last.y][last.x];
   
   if(board[last.y][last.x].isValid(temp)){
    board[last.y][last.x].pos.x = temp.x;
    board[last.y][last.x].pos.y = temp.y;
    board[temp.y][temp.x] = board[last.y][last.x];
    board[last.y][last.x] = null;    
    selected = !selected;
    if(isCheck(turn)){   
    tempold.pos.x = last.x;
    tempold.pos.y = last.y;
    board[temp.y][temp.x] = tempnew;
    board[last.y][last.x] = tempold;
      return;
    }
    if(tempnew != null)
    tempnew.alive = false;
    board[last.y][last.x] = null;
    turn = 1 - turn;    
    last.x = temp.x;
    last.y = temp.y;
   }
   else selected = !selected;
  }
  return;
  }
  
  int x = toPos(mouseX);
  int y = toPos(mouseY);
  
  if(x > 8 || x < -1 || y > 8 || y < -1) return;
  
  if(board[toPos(mouseY)][toPos(mouseX)] != null)
  if(board[toPos(mouseY)][toPos(mouseX)].side != turn)
    return;
  
  if(toPixel(x) < 50 || toPixel(x) > width - 50 || toPixel(y) < 50 || toPixel(y) > height - 50);
  else if(board[y][x] != null){
    board[y][x].storeMoves();
    last.x = x;
    last.y = y;
    selected = !selected;
    drawSelected();
    }
}


void drawSelected() {
  if(board[last.y][last.x].moveCounter == 0) selected = !selected;
  board[last.y][last.x].showMoves();
}
