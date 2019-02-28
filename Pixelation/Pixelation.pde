PImage img;
PixalingClass pc;
void setup() {
  size(600, 600);
  int div = 4;
  //img = loadImage("puppy.jpg");
  img = loadImage("sunset.jpg");
  //img.resize(width/4, height/4);
  pc = new PixalingClass(img, width/div, height/div);
  //spc.pixel(width/2, height/2);
}


void draw() {
  image(pc.img, 0, 0);
}


void mousePressed() {
  println(mouseX, mouseY);
  pc.pixel(mouseX, mouseY);
  ellipse(mouseX, mouseY, 10, 10);
}
