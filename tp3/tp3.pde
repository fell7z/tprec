//Aleksakhina Diana
//comision 1 tp3

//if you slide the mouse on the screen the colors will turn grey in a circle, and if you clic the screen while you are not moving the mouse, the circle will get bigger. When you press R it restarts

PImage img;

int rows = 20;
int columns = 20;

float CircleSize;
float radioInteraction = 100; 
float radioIncrease = 20; 

boolean increaseRadio = false; 

void setup() {
  size(800, 400);
  img = loadImage("picture.jpg");
  background(112, 117, 120);

  CircleSize = height / rows;
}

void draw() {
  background(112, 117, 120);
  image(img, 0, 0, height, height);

  for (int i = 0; i < columns; i++) {
    for (int j = 0; j < rows; j++) {
      float x = width / 2 + i * CircleSize + CircleSize / 2;
      float y = j * CircleSize + CircleSize / 2;

      float diameter = CircleSize * 0.8; 
      int circleColor;

      if (dist(mouseX, mouseY, x, y) <= radioInteraction) {
        diameter = calculateDiameter(x, y);
        circleColor = calculateColor(x, y);
      } else {
        circleColor = ((i + j) % 2 == 0) ? color(210, 214, 213) : color(24, 26, 25); 
      }

      if ((i < columns / 2 && j < rows / 2) || (i >= columns / 2 && j >= rows / 2)) {
       if ((i + j) % 2 == 0) {
          diameter *= 1.2; 
        } else {
          diameter *= 0.8; 
        }
      } else {
        if ((i + j) % 2 == 0) {
          diameter *= 0.8; 
        } else {
          diameter *= 1.2; 
        }
      }

      fill(circleColor);
      noStroke();
      drawCircle(x, y, diameter);
    }
  }

  if (increaseRadio) {
    radioInteraction += radioIncrease;
    increaseRadio = false; 
  }
}

void drawCircle(float x, float y, float diameter) {
  ellipse(x, y, diameter, diameter);
}

float calculateDiameter(float x, float y) {
  float mouseDistance = dist(x, y, mouseX, mouseY);
  float distanciaMaxima = dist(0, 0, width, height);
  float diameter = map(mouseDistance, 0, distanciaMaxima, CircleSize * 1.2, CircleSize * 0.8);
  return diameter;
}

//calculates the color of a circle based of the distance to the pointer. If the distance is bigger than radioInteraction it returns one of the predefined colors. If distance is less or equal it interpolates between two colors.
int calculateColor(float x, float y) {
  float mouseDistance = dist(x, y, mouseX, mouseY);
  if (mouseDistance > radioInteraction) {
    return ((x + y) % 2 == 0) ? color(210, 214, 213) : color(24, 26, 25); 
  }

  float factor = map(mouseDistance, 0, radioInteraction, 0, 0.5); 
  
  int colorOriginal = ((x + y) % 2 == 0) ? color(210, 214, 213) : color(24, 26, 25); 
  int colorOpposite = ((x + y) % 2 == 0) ? color(24, 26, 25) : color(210, 214, 213); 
  
  return lerpColor(colorOriginal, colorOpposite, factor);
}

//determines if a circle is on the edge, returns true if the circle is in the first or last row or column.
boolean edge(int i, int j) {
  return i == 0 || i == columns - 1 || j == 0 || j == rows - 1;
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    restart();
  }
}

void mouseClicked() {
  increaseRadio = true;
}

void restart() {
  radioInteraction = 100; 
  CircleSize = height / rows; 
}
