import java.io.*;
import java.util.*;

int[][] grid;
Queue<Integer> snakeX = new LinkedList<Integer>();
Queue<Integer> snakeY = new LinkedList<Integer>();
int fX, fY;
int screen = 1;
int timeS = 0;
int timeA = 0;
int dir = 1;
int len = 1;
boolean spawned = false;

void setup() {
  size(800,500);
  grid = new int[10][10];
  grid[5][5]=1;
  grid[5][6]=1;
  grid[5][7]=1;
  fX=fY=5;
  snakeX.add(5);
  snakeY.add(7);
  snakeX.add(5);
  snakeY.add(6);
  snakeX.add(5);
  snakeY.add(5);
  stroke(0);
  textAlign(CENTER);
  rectMode(CENTER);
  PFont font1 = loadFont("Monospaced-16.vlw");
  textFont(font1);
}

void draw() {
  if(screen==1) title();
  else if(screen==2) mainMenu();
  else if(screen==3) instructions();
  else if(screen==4) game();
  else if(screen==5) gameOver();
  else exit();
}

void title() { //1
    background(255);
    fill(0);
    text("S N A K E",400,150);
    text("Click any key to continue.",400,300);
}

void mainMenu() { //2
    background(255);
    fill(0);
    text("Main Menu",400,150);
    text("1. Instructions",400,200);
    text("2. Play",400,230);
    text("3. Exit",400,260);
}

void instructions() { //3
    background(255);
    fill(0);
    text("Instructions",400,150);
    text("The snake will move forward on it's own.",400,200);
    text("Use WASD keys to change the direction.",400,230);
    text("Collect green squares to increase length & score.",400,260);
    text("The game will end if you hit a wall or any part of the body.",400,290);
}

void game() { //4
  background(255);
  timeS++;
  timeA++;
  if(timeS%20==0) {
      move();
      timeS=0;
  }
  if(timeA%300==0&&!spawned) {
      spawn();
      timeA=0;
  }
  for(int y=0; y<10; y++) {
    for(int x=0; x<10; x++) {
      if(grid[x][y]==1) {
        fill(0);
      } else if(grid[x][y]==0) {
        fill(#F0F0F0);
      } else {
        fill(#89F7A7);
      }
      rect(x*30+265,y*30+100,30,30);
    }
  }
}

void move() { //1: up, 2: right, 3: down, 4: left
    boolean moved = false;
    if(dir==1) {
      if(fY>0) {
        fY--;
        moved = true;
      }
    } else if(dir==4) {
      if(fX>0) {
        fX--;
        moved = true;
      }
    } else if(dir==3) {
      if(fY<9) {
        fY++;
        moved = true;
      }
    } else if(dir==2) {
      if(fX<9) {
        fX++;
        moved = true;
      }
    }
    if(moved) {
        if(grid[fX][fY]==1) {
            screen = 5;
        } else if(grid[fX][fY]==0) {
            grid[fX][fY]=1;
            snakeX.add(fX);
            snakeY.add(fY);
            int xEnd = snakeX.poll();
            int yEnd = snakeY.poll();
            grid[xEnd][yEnd]=0;
        } else {
            timeA=1;
            spawned = false;
            grid[fX][fY]=1;
            snakeX.add(fX);
            snakeY.add(fY);
            len++;
        }
    } else {
        screen = 5;
    }
}

void gameOver() { //5
    background(255);
    fill(0);
    text("Game Over!",400,150);
    text("Score: "+len,400,190);
    text("Press any key to return to main menu.",400,220);
}

void spawn() { 
    while(true) {
        int x = (int)random(0,10);
        int y = (int)random(0,10);
        if(grid[x][y]!=1) {
            grid[x][y]=2;
            break;
        }
    }
    spawned = true;
}

void keyReleased() {
  if(screen==1||screen==3||screen==5) screen=2;
  else if(screen==2) {
      if(key=='1') screen=3;
      else if(key=='2') screen=4;
      else if(key=='3') screen=6;
  } else if(screen==4) {
      if(key=='w') {
        dir=1;
      } else if(key=='a') {
        dir=4;
      } else if(key=='s') {
        dir=3;
      } else if(key=='d') {
        dir=2;
      }
  }
}
