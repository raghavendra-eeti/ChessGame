class Pawn extends Piece {
  
  Pawn(int s, int n){
    
    moves = new Square[4];
    side = s;
    number = n;
    limit = 4;
    type =  'P';
    
    if(side == 0){
      img = loadImage("whitePawn.png");
      pos.y = 1;
    }
    else {
      img = loadImage("blackPawn.png");
      pos.y = 6;
    }
    
    pos.x = n;
  }
  
  void storeMoves(){    
    
    moveCounter = 0;
    
    if(side == 0){
     if(pos.y == 1){
     if(board[pos.y+1][pos.x] == null)
     storeMove(pos.x, 2);
     if(board[pos.y+2][pos.x] == null)
     storeMove(pos.x, 3);
      }
     else if(pos.y == 7);     
     else if(board[pos.y+1][pos.x] == null) storeMove(pos.x, pos.y + 1);
     if(pos.x+1 < 8 && pos.y+1 < 8)
       if(board[pos.y+1][pos.x+1] != null)
         if(board[pos.y+1][pos.x+1].side != this.side)
           storeMove(pos.x+1, pos.y+1);
     if(pos.x-1 > -1 && pos.y+1 < 8)
       if(board[pos.y+1][pos.x-1] != null)
         if(board[pos.y+1][pos.x-1].side != this.side)
           storeMove(pos.x-1, pos.y+1);
    } 
    
    else {
      if(pos.y == 6){
     if(board[pos.y-1][pos.x] == null)
     storeMove(pos.x, 5);
     if(board[pos.y-2][pos.x] == null)
     storeMove(pos.x, 4);
      }
     else if(pos.y == 0);
     else if(board[pos.y-1][pos.x] == null) storeMove(pos.x, pos.y - 1);
     
     if(pos.x+1 < 8 && pos.y-1 > -1)
       if(board[pos.y-1][pos.x+1] != null)
         if(board[pos.y-1][pos.x+1].side != this.side)
           storeMove(pos.x+1, pos.y-1);
     if(pos.x-1 > -1 && pos.y-1 > -1)
       if(board[pos.y-1][pos.x-1] != null)
         if(board[pos.y-1][pos.x-1].side != this.side)
           storeMove(pos.x-1, pos.y-1);
    } 
  }

}
