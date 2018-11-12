class Bishop extends Piece{
  
  Bishop(int s, int n){
    
    moves = new Square[13];
    limit = 13;
    side = s;
    number = n;
    type = 'B';
    
    if(s == 0){
      img = loadImage("whiteBishop.png");
      pos.y = 0;
    }
    
    else {
      img = loadImage("blackBishop.png");
      pos.y = 7;
    }
    
    if(n == 0) pos.x = 2;
    else pos.x = 5;
  }  
  
  void storeMoves() {
      
     moveCounter = 0;
    
     for(int i = 1; i <= 7; i++)
       if(pos.x + i < 8 && pos.y + i < 8){
         if(board[pos.y+i][pos.x+i] != null){
           if(board[pos.y+i][pos.x+i].side == this.side) break;
           if(board[pos.y+i][pos.x+i].side != this.side){
             storeMove(pos.x+i, pos.y+i);
             break;
           }
         }
         else storeMove(pos.x+i, pos.y+i);
         }
     for(int i = 1; i <= 7; i++)
       if(pos.x + i < 8 && pos.y - i > -1){
         if(board[pos.y-i][pos.x+i] != null){
           if(board[pos.y-i][pos.x+i].side == this.side) break;
           if(board[pos.y-i][pos.x+i].side != this.side){
           storeMove(pos.x+i, pos.y-i);
           break;
       }  
         }
         else storeMove(pos.x+i, pos.y-i);
         }
     for(int i = 1; i <= 7; i++)
       if(pos.x - i > -1 && pos.y + i < 8){
         if(board[pos.y+i][pos.x-i] != null){
           if(board[pos.y+i][pos.x-i].side == this.side) break;
           if(board[pos.y+i][pos.x-i].side != this.side){
             storeMove(pos.x-i, pos.y+i);
             break;
           }  
         }
         else storeMove(pos.x-i, pos.y+i);
         }
     for(int i = 1; i <= 7; i++)
       if(pos.x - i > -1 && pos.y - i > -1){
         if(board[pos.y-i][pos.x-i] != null){
           if(board[pos.y-i][pos.x-i].side == this.side) break;
           if(board[pos.y-i][pos.x-i].side != this.side){
           storeMove(pos.x-i, pos.y-i);
           break;
           }  
         }
         else storeMove(pos.x-i, pos.y-i);
         }
     
    }
}
