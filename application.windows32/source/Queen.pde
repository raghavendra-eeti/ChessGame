class Queen extends Piece{
 
  Queen(int s){
    
    moves = new Square[27];
    side = s;
    limit = 27;
    type = 'Q';
    
    if(side == 0){
      img = loadImage("whiteQueen.png");
      pos.x = 3;
      pos.y = 0; 
    }
    else {
      img = loadImage("blackQueen.png");
      pos.x = 3;
      pos.y = 7;
   }
  }
  
  Queen(int s, int x, int y){
  moves = new Square[27];
    side = s;
    limit = 27;
    type = 'Q';
    
    if(side == 0){
      img = loadImage("whiteQueen.png");
    }
    else {
      img = loadImage("blackQueen.png");
   }
   pos.x = x;
   pos.y = y;
  }
  
  void storeMoves(){
    
    moveCounter = 0;
  
    for(int i = 1; pos.y+i < 8 ; i++) {
      if(board[pos.y+i][pos.x] != null){
        if(board[pos.y+i][pos.x].side != this.side)
          storeMove(pos.x, pos.y+i);
        break;
      }
      else storeMove(pos.x, pos.y+i);
    }
    
     for(int i = 1; pos.y-i > -1 ; i++) {
      if(board[pos.y-i][pos.x] != null){
        if(board[pos.y-i][pos.x].side != this.side)
          storeMove(pos.x, pos.y-i);
        break;
      }
      else storeMove(pos.x, pos.y-i);
    }
    
     for(int i = 1; pos.x+i < 8 ; i++) {
      if(board[pos.y][pos.x+i] != null){
        if(board[pos.y][pos.x+i].side != this.side)
          storeMove(pos.x+i, pos.y);
        break;
      }
      else storeMove(pos.x+i, pos.y);
    }

     for(int i = 1; pos.x-i > -1 ; i++) {
      if(board[pos.y][pos.x-i] != null){
        if(board[pos.y][pos.x-i].side != this.side)
          storeMove(pos.x-i, pos.y);
        break;
      }
      else storeMove(pos.x-i, pos.y);
    }
    
    for(int i = 1; i <= 7; i++)
       if(pos.x + i < 8 && pos.y + i < 8){
         if(board[pos.y+i][pos.x+i] != null){
           if(board[pos.y+i][pos.x+i].side != this.side)
             storeMove(pos.x+i, pos.y+i);
           break;
         }
         else storeMove(pos.x+i, pos.y+i);
         }
     for(int i = 1; i <= 7; i++)
       if(pos.x + i < 8 && pos.y - i > -1){
         if(board[pos.y-i][pos.x+i] != null){
           if(board[pos.y-i][pos.x+i].side != this.side)
           storeMove(pos.x+i, pos.y-i);
           break;
         }
         else storeMove(pos.x+i, pos.y-i);
         }
     for(int i = 1; i <= 7; i++)
       if(pos.x - i > -1 && pos.y + i < 8){
         if(board[pos.y+i][pos.x-i] != null){
           if(board[pos.y+i][pos.x-i].side != this.side)
           storeMove(pos.x-i, pos.y+i);
           break;
         }
         else storeMove(pos.x-i, pos.y+i);
         }
     for(int i = 1; i <= 7; i++)
       if(pos.x - i > -1 && pos.y - i > -1){
         if(board[pos.y-i][pos.x-i] != null){
           if(board[pos.y-i][pos.x-i].side != this.side)
             storeMove(pos.x-i, pos.y-i);
             break;
         }
         else storeMove(pos.x-i, pos.y-i);
         }
     
  }

}
