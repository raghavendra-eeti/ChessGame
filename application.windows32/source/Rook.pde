class Rook extends Piece{
  
  Rook(int s, int n){
    
    moves = new Square[14];
    side = s;
    number = n;
    limit = 14;
    type = 'R';
    
    if(s == 0){
      img = loadImage("whiteRook.png");
      pos.y = 0;
    }
    
    else {
      img = loadImage("blackRook.png");
      pos.y = 7;
    }
    
    if(n == 0) pos.x = 0;
    else pos.x = 7;
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
  }    
}
