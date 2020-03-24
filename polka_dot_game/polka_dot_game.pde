float playerSize;
int score;
int enemyCount;
float enemySpeed;
float powerUpBar;
float freezeUseSpeed;
float checkUseSpeed;
Circle[] enemies;
boolean[] keys;
boolean freeze;
int renderMode;
float checkBar;

void setup() {
  fullScreen();
  colorMode(HSB, 360);
  config();
  setupVariables();
  setupEnemies();
  delay(900);
}

void config() {
  renderMode = 0;
  checkBar = 100;
  textSize(40);
  playerSize = 16;
  score = 0;
  enemyCount = 90;
  enemySpeed = 2;
  powerUpBar = 100;
  checkUseSpeed = 0.1;
  freezeUseSpeed = 1;
}

void setupVariables() {
  keys = new boolean[4];
  enemies = new Circle[enemyCount];
}

void draw() { 
  background(204); 
  fill(0, 0, 360);
  circle(mouseX, mouseY, playerSize);
  drawEnemies();
  text(score, width/2, height/2);
  drawPowerBar();
  drawCheckBar();
} 

void setupEnemies() {
  for (int i = 0; i < enemyCount; i++) {
    enemies[i] = new Circle();
  }
}

void drawEnemies() {
  for (int i = 0; i < enemyCount; i++) {
    enemies[i].render();
    enemies[i].move();
    enemies[i].checkDead();
    enemies[i].checkTouch();
  }
}

class Circle {
  float diameter;
  color fill;
  PVector speed;
  PVector location;
  Circle() {
    generate();
  }

  void render() {
    if (renderMode == 0) {
      fill(fill);
    } else if (renderMode == 1 ) {
      if (diameter <= playerSize) {
        fill(120, 360, 360);
      } else fill(0, 360, 360);
    }

    circle(location.x, location.y, diameter);
  }

  void move() {
    if (freeze) return;
    location.add(speed);
  }

  void checkDead() {
    if (abs(location.x - width/2) >= width/2 + diameter) {
      generate();
    }
    if (abs(location.y - height/2) >= height/2 + diameter) {
      generate();
    }
  }

  void checkTouch() {
    float dx = location.x - mouseX;
    float dy = location.y - mouseY;
    float distance = sqrt(dx * dx + dy * dy);
    if (distance < diameter/2 + playerSize/2) {
      checkKill();
    }
  }

  void checkKill() {
    if (diameter >= playerSize) {
      gameOver();
    } else {
      enemyEaten();
      generate();
    }
  }

  void generate() {
    diameter = genCircleDiameter();
    fill = color(random(0, 360), 360, 360);
    speed = genCircleSpeed();
    location = genCircleLocation(diameter);
  }
}

float genCircleDiameter() { //make this reliant on score
  return random(10 + score, 100 + score);
}

PVector genCircleSpeed() {
  PVector speed = PVector.random2D();
  speed.setMag(enemySpeed);
  return speed;
}

PVector genCircleLocation(float diameter) {
  boolean orientation = boolean(floor(random(0, 2)));
  PVector start = new PVector(random(0, width), random(0, height));
  start = orientation ? new PVector(start.x, (height + 2 * diameter) * int(2 * start.y / height) - diameter) : new PVector((width + 2 * diameter) * int(2 * start.x / width) - diameter, start.y);
  return start;
}

void enemyEaten() {
  playerSize += 1.75;
  score += 1;
}

void gameOver() {
  setup();
}

void drawPowerBar() {
  //rect(width * 0.80, height * 0.02, width / 0.0001 * powerUpBar / 100, height * 0.05);
  fill(240, 360, 360);
  rect(width * 0.01, height * 0.02, (width / 5.5) * powerUpBar / 100, height * 0.01);
  if (keys[0]) {
    updatePowerBar();
    freeze = true;
  } else freeze = false;
  if (powerUpBar <= 0) freeze = false;
}

void drawCheckBar() {
  //rect(width * 0.80, height * 0.02, width / 0.0001 * powerUpBar / 100, height * 0.05);
  fill(120, 360, 360);
  rect(width * 0.01, height * 0.035, (width / 5.5) * checkBar / 100, height * 0.01);
  if (keys[1]) {
    updateCheckBar();
    renderMode = 1;
  } else renderMode = 0;
  if (checkBar <= 0) renderMode = 0;
}

void updatePowerBar() {
  if (powerUpBar > freezeUseSpeed) {
    powerUpBar += -freezeUseSpeed;
  } else powerUpBar = 0;
}

void updateCheckBar() {
  if (checkBar > checkUseSpeed) {
    checkBar += -checkUseSpeed;
  } else checkBar = 0;
}

void keyPressed() { //borrowed from ProcessingSlope by Elijah Smith and Will DePue
  if (key=='c')
    keys[0]=true;
  if (key=='a' || keyCode == LEFT)
    keys[1]=true;
  if (key=='x')
    keys[2]=true;
  if (key=='d' || keyCode == RIGHT)
    keys[3]=true;
}

void keyReleased() { //same as previous section
  if (key=='c')
    keys[0]=false;
  if (key=='a' || keyCode == LEFT)
    keys[1]=false;
  if (key=='x')
    keys[2]=false;
  if (key=='d' || keyCode == RIGHT)
    keys[3]=false; //no self plaigarism here boys
}
