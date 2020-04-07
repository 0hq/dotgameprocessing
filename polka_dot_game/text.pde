void drawText() {
  scoreRender();


  if (tickCounter < 300) {
    listRender(scoreText, textPos, 16, scoreTextColors, 4, 0.03 * height);
  } 

  listRender(barText, barPos, 16, powerTextColors, 4, 0.02 * height);
}

void scoreRender() {
  textSize(16);
  fill(0, 0, 0);
  for (int x = -1; x < 4; x++) {
    text(score, width/2 + x, height/2);
    text(score, width/2, height/2 + x);
  }
  fill(90, 360, 360);
  text(score, width/2, height/2);
}

void listRender(String[] lines, PVector position, int textSize, color[] colors, int weight, float shift) {
  textSize(textSize);
  fill(0, 0, 0);
  for (int move = -1; move < weight; move++) { //make this move in a circle right now it only moves up and down which isnt optimal
    for (int i = 0; i < lines.length; i++) {
      text(lines[i], position.x + move, position.y + shift * i);
      text(lines[i], position.x, position.y + move + shift * i);
    }
  }
  for (int i = 0; i < lines.length; i++) {
    fill(colors[i % colors.length]);
    text(lines[i], position.x, position.y + shift * i);
  }
}

void drawPowerBar() {
  fill(300, 360, 360); //color of the Freeze powerup
  rect(width * 0.01, height * 0.02, (width / 5.5) * powerUpBar / 100, height * 0.01); //rendering the bar
  if (keys[0]) {
    updatePowerBar(); //lower the powerup amount left
    freeze = true; //freeze enemy movement
  } else freeze = false; //go back to normal
  if (powerUpBar <= 0) freeze = false; //if you have no powerup left dont freeze
}

void drawCheckBar() {
  fill(120, 360, 360);
  rect(width * 0.01, height * 0.035, (width / 5.5) * checkBar / 100, height * 0.01); //rendering the bar
  if (keys[1]) {
    updateCheckBar(); //lower the CheckMode powerup amount left
    renderMode = true; //render everything in CheckMode
  } else renderMode = false; //go back to normal
  if (checkBar <= 0) renderMode = false; //if you have no powerup left don't render in CheckMode
}

void updatePowerBar() {
  if (powerUpBar > freezeUseSpeed) { //stops the bar from inverting bc its just a rectangle
    powerUpBar += -freezeUseSpeed;
  } else powerUpBar = 0; 
}

void updateCheckBar() {
  if (checkBar > checkUseSpeed) { //stops the bar from inverting bc its just a rectangle
    checkBar += -checkUseSpeed;
  } else checkBar = 0;
}
