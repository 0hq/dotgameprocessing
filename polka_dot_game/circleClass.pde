class Circle {
  float diameter;
  color fill;
  PVector speed;
  PVector location;
  Circle() {
    generate(); //on creation generate all the random values
  }

  void render() {
    if (renderMode) { //if powerup ColorMode is activated
      if (diameter <= playerSize) {
        fill(120, 360, 360); //this is used for the ColorMode powerup activated with A
      } else fill(0, 360, 360); //makes all un-eattable enemies the same color
    } else fill(fill);  //normal using unique random hue

    circle(location.x, location.y, diameter); //make a circle at the position
  }

  void move() {
    if (freeze) return; //this is for the freeze powerup activated with c
    location.add(speed); // speed is a 2d vector here
  }

  void checkDead() { //checks if the enemy is offscreen. modified to work with spawning so they dont just appear randomly
    if (abs(location.x - width/2) >= width/2 + diameter || abs(location.y - height/2) >= height/2 + diameter) {
      generate();
    }
  }

  void checkTouch() {
    float dx = location.x - mouseX; //very simple circle collision
    float dy = location.y - mouseY; //could make this more efficient but its pretty light as a whole
    float distance = sqrt(dx * dx + dy * dy);
    if (distance < diameter/2 + playerSize/2) {
      checkKill(); //checkKill preforms both death and kill operations. badly named...
    }
  }

  void checkKill() {
    if (diameter >= playerSize) { //you can't eat things that are exactly your size
      drawPlayer();
      gameOver(); //calls setup() again
    } else {
      enemyEaten(); 
      generate(); //when an enemy is eaten it regenerates itself and spawns again
    }
  }

  void generate() { //main generation function to creata all the random enemy values
    diameter = genCircleDiameter(); //explained below
    fill = color(random(0, 360), 360, 360); //just a random hue with brightness and saturation at max
    speed = genCircleSpeed(); //explained below
    location = genCircleLocation(diameter); //explained below, depends on diameter value which was generated above
  }
}
