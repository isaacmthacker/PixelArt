PixalingClass pc;
int div = 1;
int divstep = 1;
void setup() {
  size(730, 420);
  //img = loadImage("puppy.jpg");
  //img = loadImage("sunset.jpg");
  //img.resize(width/4, height/4);
  pc = new PixalingClass("puppy.jpg", width/div, height/div);
}


void draw() {
  image(pc.img, 0, 0);
  pc.getColor(mouseX, mouseY);
}


void mousePressed() {
  println(mouseX, mouseY);
  //pc.pixel(mouseX, mouseY);
  ellipse(mouseX, mouseY, 10, 10);
}

void keyPressed() {
  //left = 37, right = 39
  if (keyCode == 39 || keyCode == 37) {
    if (keyCode == 39 && div < 256) {
      div += divstep;
    } else if (keyCode == 37 && div > 1) {
      div -= divstep;
    }
    pc.updateSquares(width/div, height/div);
    pc.pixelate();
  }
}
