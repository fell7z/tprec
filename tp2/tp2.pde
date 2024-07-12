//Aleksakhina Diana
//comision 1 tp3

PImage Image1;
PImage Image2;
PImage Image3;
PFont font;
int screen = 1;
float textX, textY;
float textScale = 1.0;
float textAlpha = 255;
boolean replayButton = false;

void setup() {
  size(640, 480);
  Image1 = loadImage("Image1.jpg");
  Image2 = loadImage("Image2.png");
  Image3 = loadImage("Image3.png");
  font = createFont("Arial", 32);
  textX = width / 2;
  textY = height / 2;
}

void draw() {
  background(255);

  if (screen == 1) {
    image(Image1, 0, 0, width, height);
    animateText("Lost in Translation", textX, textY);
  } else if (screen == 2) {
    image(Image2, 0, 0, width, height);
    animateText("2003", textX, textY);
  } else if (screen == 3) {
    image(Image3, 0, 0, width, height);
    animateText("Directed by Sofia Coppola", textX, textY);
  }

  if (replayButton) {
    displayReplayButton();
  }
}

void animateText(String text, float x, float y) {
  textFont(font);
  textAlign(CENTER, CENTER);
  textSize(32);
  fill(255, 255, 255, textAlpha); 
  text(text, x, y);

  textAlpha -= 1;
  textScale += 0.01;
  textX += random(-1, 1);
  textY += random(-1, 1);

  if (textAlpha <= 0) {
    if (screen < 3) {
      screen++;
      textAlpha = 255;
      textScale = 1.0;
      textX = width / 2;
      textY = height / 2;
    } else {
      replayButton = true;
    }
  }
}

void displayReplayButton() {
  fill(255);
  rect(250, 200, 140, 60);
  fill(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Replay", 320, 230);
}

void mousePressed() {
  if (replayButton && mouseX > 250 && mouseX < 390 && mouseY > 200 && mouseY < 260) {
    screen = 1;
    textAlpha = 255;
    textScale = 1.0;
    textX = width / 2;
    textY = height / 2;
    replayButton = false;
  }
}
