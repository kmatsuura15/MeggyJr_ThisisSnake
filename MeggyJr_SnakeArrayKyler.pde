#include <MeggyJrSimple.h>

int direction = 270;

int marker = 4;
int xapple = random(8);
int yapple = random(8);
boolean gotApple = false;

struct Point{
  int x;    //x-coordinate of this point.
  int y;    //y-coordinate of this point.
};

Point s1 = {3,4};
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
  drawSnake();
  spawnApple();
  DisplaySlate();
  delay(200);
  ClearSlate();
  updateSnake();
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

void spawnApple()
{
  DrawPx(xapple, yapple, Green);
  if (snakeArray[0].x == xapple && snakeArray[0].y == yapple){
    gotApple = true;
  }
  
  if(gotApple){
    xapple = random(8);
    yapple = random(8);
    gotApple = false;
  }
    
}

void drawSnake()
{
  for (int i = 0; i < marker; i++){
    DrawPx(snakeArray[i].x, snakeArray[i].y, 2);
  }
} 

void updateSnake()
{
  for (int i = marker-1; i > 0; i--){
    snakeArray[i].x =  snakeArray[i-1].x;
    snakeArray[i].y =  snakeArray[i-1].y;
  }
}

