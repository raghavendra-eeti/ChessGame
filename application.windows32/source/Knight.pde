class Knight extends Piece{
  
  Knight(int s, int n){
    
    moves = new Square[8];
    side = s;
    number = n;
    limit = 8;
    type = 'N';
    
    if(s == 0){
      img = loadImage("whiteKnight.png");
      pos.y = 0;
    }
    
    else {
      img = loadImage("blackKnight.png");
      pos.y = 7;
    }
    
    if(n == 0) pos.x = 1;
    else pos.x = 6;
  }  
  
  void storeMoves(){

    moveCounter = 0;
    
    if(pos.x+1 < 8 && pos.y-2 > -1){
     if(board[pos.y-2][pos.x+1] != null){
       if(board[pos.y-2][pos.x+1].side != this.side)
         storeMove(pos.x+1, pos.y-2);
     }
     else storeMove(pos.x+1, pos.y-2);     
    }   
    if(pos.x+1 < 8 && pos.y+2 < 8){
     if(board[pos.y+2][pos.x+1] != null){
       if(board[pos.y+2][pos.x+1].side != this.side)
         storeMove(pos.x+1, pos.y+2);     
     }
     else storeMove(pos.x+1, pos.y+2);     
    }
    if(pos.x+2 < 8 && pos.y-1 > -1){
     if(board[pos.y-1][pos.x+2] != null){
       if(board[pos.y-1][pos.x+2].side != this.side)
         storeMove(pos.x+2, pos.y-1);
     }
     else storeMove(pos.x+2, pos.y-1);     
    }
    if(pos.x+2 < 8 && pos.y+1 < 8){
     if(board[pos.y+1][pos.x+2] != null){
       if(board[pos.y+1][pos.x+2].side != this.side)
         storeMove(pos.x+2, pos.y+1);     
     }
     else storeMove(pos.x+2, pos.y+1);     
    }
    if(pos.x-1 > -1 && pos.y-2 > -1){
     if(board[pos.y-2][pos.x-1] != null){
       if(board[pos.y-2][pos.x-1].side != this.side)
         storeMove(pos.x-1, pos.y-2);     
     }
     else storeMove(pos.x-1, pos.y-2);     
    }
    if(pos.x-1 > -1 && pos.y+2 < 8){
     if(board[pos.y+2][pos.x-1] != null){
       if(board[pos.y+2][pos.x-1].side != this.side)
         storeMove(pos.x-1, pos.y+2);     
     }
     else storeMove(pos.x-1, pos.y+2);     
    }
    if(pos.x-2 > -1 && pos.y-1 > -1){
     if(board[pos.y-1][pos.x-2] != null){
       if(board[pos.y-1][pos.x-2].side != this.side)
         storeMove(pos.x-2, pos.y-1);     
     }
     else storeMove(pos.x-2, pos.y-1);     
    }
    if(pos.x-2 > -1 && pos.y+1 < 8){
     if(board[pos.y+1][pos.x-2] != null){
       if(board[pos.y+1][pos.x-2].side != this.side)
         storeMove(pos.x-2, pos.y+1);     
     }
     else storeMove(pos.x-2, pos.y+1);     
    }
    
  }

}
