#include <MeggyJrSimple.h>

int direction = 270;    //initial direction

int marker = 4;    //initial length (4 pixels)
int xapple = random(8);    //Spawns the apple at a random x-coord
int yapple = random(8);    //Spawns the apple at a random y-coord
boolean gotApple = false;    
boolean alive = false;
int LEDs = 1;

struct Point{
  int x;    //x-coordinate of this point.
  int y;    //y-coordinate of this point.
};

Point s1 = {3,4};    //original points of the snake
Point s2 = {4,4};
Point s3 = {5,4};
Point s4 = {6,4};

Point snakeArray[64] = {s1, s2, s3, s4};

void setup()
{
  MeggyJrSimpleSetup();
}

void loop()
{
  drawSnake();    //Draws Snake
  spawnApple();    //Spawns apple    
  DisplaySlate();
  delay(200);
  ClearSlate();
  updateSnake();    //Updates the snake after it moves.
  CheckButtonsDown();
    if (Button_Up){    //Button_Up is equal to direction 0 
      direction = 0;
    }
    if (Button_Down){    //Button_Down is equal to direction 180
      direction = 180;
    }
    if (Button_Right){    //Button_Right is equal to direction 90
      direction = 90;
    }
    if (Button_Left){    //Button_Left is equal to direction 270
      direction = 270;
    }
    
    if (direction == 0){    //Direction 0 is up, which is ycoord++
        snakeArray[0].y++;
    }
    if(snakeArray[0].y > 7 ){    //If the ycoord is greater than 8, loop it back to the bottom.
      snakeArray[0].y = 0;
    }
    if (direction == 90){    //Directoin 90 is right, which is xcoord++
      snakeArray[0].x++;
    }
   if (snakeArray[0].x > 7){    //If the xcoord is greater than 8, loop it back to the left side.
      snakeArray[0].x = 0;
    }
   if (direction == 180){    //Direction 180 is down, which is ycoord--.
      snakeArray[0].y--;
     }
   if (snakeArray[0].y < 0){    //If the ycoord is less than 0, loop it to the top.
      snakeArray[0].y = 7;
    }
   if (direction == 270){    //Direction 270 is left, which is xcoord--.
      snakeArray[0].x--;
    }
    if (snakeArray[0].x < 0){    //If the xcoord is less than 0, loop it to the right.
      snakeArray[0].x = 7;  
    }
   
}



void spawnApple()    //code to spawn apple
{
  DrawPx(xapple, yapple, Green);    //This recognizes if the snake eat the apple.
    if (snakeArray[0].x == xapple && snakeArray[0].y == yapple){
      gotApple = true;
  }
  
    if(gotApple){    //After the apple is eaten, it spawns at a new, random point.  
      xapple = random(8);
      yapple = random(8);
      SetAuxLEDs(2*LEDs);
      LEDs = 2*LEDs;
      gotApple = false;
      marker++;    //increases length after an apple is eaten.
  }
    
}



void drawSnake()
{
  DrawPx(snakeArray[0].x, snakeArray[0].y, Blue);
  for (int i = 1; i < marker; i++){
    DrawPx(snakeArray[i].x, snakeArray[i].y, 1);    //collision detection code
    if (snakeArray[0].x == snakeArray[i].x && snakeArray[0].y == snakeArray[i].y){
      alive = true;    
    }
    
    if(alive){
      ClearSlate();
      DisplaySlate();
      delay(2000);
      marker = 4;
      SetAuxLEDs(0); 
      alive = false;
    } 
  }
}

void updateSnake()    //updates the snake.
{
  for (int i = marker-1; i > 0; i--){
    snakeArray[i].x =  snakeArray[i-1].x;
    snakeArray[i].y =  snakeArray[i-1].y;
  }
}

