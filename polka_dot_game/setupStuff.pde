float playerSize, powerUpBar, enemySpeed, checkUseSpeed, freezeUseSpeed, checkBar;
int score, enemyCount, tickCounter;
Circle[] enemies;
boolean[] keys;
boolean freeze, tripMode, renderMode;
String[] scoreText, barText;
color[] powerTextColors, scoreTextColors;
PVector centerPos, textPos, barPos;

void config() { //i started making a function for all the base values that each variable needed. 
  renderMode = false; //this function makes it much easier to restart the game because the entire gamestate is reset
  checkBar = 100; //i split this function in two for the non-configurable and configurable parts
  textSize(40);
  playerSize = 16;
  score = 0;
  enemyCount = 90;
  enemySpeed = 2;
  powerUpBar = 100;
  checkUseSpeed = 0.1;
  freezeUseSpeed = 1;
  tickCounter = 0;
}

void setupVariables() { //i started making a function for all the base values that each variable needed. 
  keys = new boolean[4]; //this function makes it much easier to restart the game because the entire gamestate is reset
  enemies = new Circle[enemyCount]; //i split this function in two for the non-configurable and configurable parts
  textAlign(CENTER, CENTER);
  centerPos = new PVector(width/2, height/2);
  textPos = new PVector(width/2, height/2 + 0.03 * height);
  barPos = new PVector(width * 0.09, height * 0.035 + 0.02 * height);
  scoreText = new String[] {"You're just a small fish in a big pond", "Eat what is smaller than you", "How hard could it be.."};
  barText = new String[] {"A : Show What You Can Eat", "C : Freeze Time"};
  powerTextColors = new color[] {color(120, 360, 360), color(300, 360, 360)};
  scoreTextColors = new color[] {color(90, 360, 360)};
  background(204);
}
