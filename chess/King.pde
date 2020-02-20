class King extends Piece  {
   
  PImage check = loadImage("Check.png");
    
  King(int s){
    
    moves = new Square[8];
    side = s;
    limit = 8;
    type = 'K';
    if(side == 0) {
      img = loadImage("whiteKing.png");
       pos.x = 4 ;
       pos.y = 0;
    }
    else {
      img = loadImage("blackKing.png");
      pos.x = 4;
      pos.y = 7;
    }
  }
  
void storeMoves(){
  
  moveCounter = 0;
  
  if(pos.x - 1 > -1) {
    
    if(pos.y - 1 > -1){
      if(board[pos.y-1][pos.x-1] != null){
        if(board[pos.y-1][pos.x-1].side != this.side)
          storeMove(pos.x-1, pos.y-1);
      }
      else storeMove(pos.x-1, pos.y-1);
    }
    
    if(pos.y + 1 < 8){
      if(board[pos.y+1][pos.x-1] != null){
        if(board[pos.y+1][pos.x-1].side != this.side)
          storeMove(pos.x-1, pos.y+1);
      }
      else storeMove(pos.x-1, pos.y+1);
    }
    
    if(board[pos.y][pos.x-1] != null){
      if(board[pos.y][pos.x-1].side != this.side)
        storeMove(pos.x-1, pos.y);
    }
    else storeMove(pos.x-1, pos.y);
  }
  
    if(pos.x + 1 < 8) {
    
    if(pos.y - 1 > -1){
      if(board[pos.y-1][pos.x+1] != null){
        if(board[pos.y-1][pos.x+1].side != this.side)
          storeMove(pos.x+1, pos.y-1);
      }
      else storeMove(pos.x+1, pos.y-1);
    }
    
    if(pos.y + 1 < 8){
      if(board[pos.y+1][pos.x+1] != null){
        if(board[pos.y+1][pos.x+1].side != this.side)
          storeMove(pos.x+1, pos.y+1);
      }
      else storeMove(pos.x+1, pos.y+1);
    }
    
    if(board[pos.y][pos.x+1] != null){
      if(board[pos.y][pos.x+1].side != this.side)
        storeMove(pos.x+1, pos.y);
    }
    else storeMove(pos.x+1, pos.y);
  }
  
  if(pos.y - 1 > -1){
    if(board[pos.y-1][pos.x] != null){
      if(board[pos.y-1][pos.x].side != this.side)
      storeMove(pos.x, pos.y-1);
    }
    else storeMove(pos.x, pos.y-1);
  }
  
  if(pos.y + 1 < 8) {
  if(board[pos.y+1][pos.x] != null){
      if(board[pos.y+1][pos.x].side != this.side)
      storeMove(pos.x, pos.y+1);
  }
    else storeMove(pos.x, pos.y+1);
  }  
 } 
 
 void drawCheck() { //<>//
   image(check, toPixel(pos.x), toPixel(pos.y), 100, 100);
 } 
}
