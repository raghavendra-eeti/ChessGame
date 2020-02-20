abstract class Piece {
   
  Square pos = new Square();
  boolean alive = true;
  int side;
  int number;
  int limit;
  char type;
  PImage img;
  PImage move = loadImage("Move.png");
  Square[] moves;
  int moveCounter = 0;
  boolean demo = true;
  
  void show(){
    image(img, toPixel(pos.x), toPixel(pos.y), 100, 100);
  }
  
  void storeMove(int x, int y){
    moves[moveCounter++] = new Square(x, y);
  }
  
 abstract void storeMoves();
  
  void showMoves(){      
      for(int i = 0; i < moveCounter; i++)
      image(move, toPixel(moves[i].x), toPixel(moves[i].y), 100, 100);
}

boolean isValid(Square temp) {
 
  for(int i = 0; i < moveCounter; i++)
    if(moves[i].x == temp.x && moves[i].y == temp.y)
      return true;  
  return false;
}

}
