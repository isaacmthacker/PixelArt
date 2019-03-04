PixalingClass pc;
int div = 1;
int divstep = 1;
void setup() {
  size(1008, 756);
  color[] colors = {#CD4A4A, #CC6666, #BC5D58, #FF5349, 
    #FD5E53, #FD7C6E, #FDBCB4, #FF6E4A, #FFA089, #EA7E5D, 
    #B4674D, #A5694F, #FF7538, #FF7F49, #DD9475, #FF8243, 
    #FFA474, #9F8170, #CD9575, #EFCDB8, #D68A59, #DEAA88, 
    #FAA76C, #FFCFAB, #FFBD88, #FDD9B5, #FFA343, #EFDBC5, 
    #FFB653, #E7C697, #8A795D, #FAE7B5, #FFCF48, #FCD975, 
    #FDDB6D, #FCE883, #F0E891, #ECEABE, #BAB86C, #FDFC74, 
    #FDFC74, #FFFF99, #C5E384, #B2EC5D, #87A96B, #A8E4A0, 
    #1DF914, #76FF7A, #71BC78, #6DAE81, #9FE2BF, #1CAC78, 
    #30BA8F, #45CEA2, #3BB08F, #1CD3A2, #17806D, #158078, 
    #1FCECB, #78DBE2, #77DDE7, #80DAEB, #414A4C, #199EBD, 
    #1CA9C9, #1DACD6, #9ACEEB, #1A4876, #1974D2, #2B6CC4, 
    #1F75FE, #C5D0E6, #B0B7C6, #5D76CB, #A2ADD0, #979AAA, 
    #ADADD6, #7366BD, #7442C8, #7851A9, #9D81BA, #926EAE, 
    #CDA4DE, #8F509D, #C364C5, #FB7EFD, #FC74FD, #8E4585, 
    #FF1DCE, #FF1DCE, #FF48D0, #E6A8D7, #C0448F, #6E5160, 
    #DD4492, #FF43A4, #F664AF, #FCB4D5, #FFBCD9, #F75394, 
    #FFAACC, #E3256B, #FDD7E4, #CA3767, #DE5D83, #FC89AC, 
    #F780A1, #C8385A, #EE204D, #FF496C, #EF98AA, #FC6C85, 
    #FC2847, #FF9BAA, #CB4154, #EDEDED, #DBD7D2, #CDC5C2, #95918C, #232323};
  pc = new PixalingClass("casaJupiter.jpg", width/div, height/div, true /* resize */, colors);
  println(hex(colors[0]), pc.colorVal(colors[0]));
}


void draw() {
  image(pc.img, 0, 0);
  pc.getColor(mouseX, mouseY);
}

void mousePressed() {
  color c = pc.img.pixels[pc.getIdx(mouseX, mouseY)];
  println(pc.getColor(mouseX, mouseY), pc.colorToString(pc.getClosestColor(c)));
}



void keyPressed() {
  //left = 37, right = 39
  if (keyCode == 39 || keyCode == 37 || key=='r') {
    if (key == 'r') {
      div = 1;
    }
    if (keyCode == 39 && div < 256) {
      div += divstep;
    } else if (keyCode == 37 && div > 1) {
      div -= divstep;
    }
    pc.updateSquares(width/div, height/div);
    pc.pixelate();
  }
  if (key == 'l') {
    pc.useList = !pc.useList;
    pc.updateSquares(width/div, height/div);
    pc.pixelate();
  }
}
