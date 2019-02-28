class PixalingClass {
  PImage img;
  int w, h;
  int bw, bh;
  PixalingClass(PImage i, int ll, int hh) {
    img = i;
    img.loadPixels();
    w = ll;
    h = hh;
    println(img.width, img.height);
    println("total squares: ", w*h);
    bw = img.width/w;
    bh = img.height/h;
    println(w, h);
    println(bw, bh);
    pixelate();
    img.updatePixels();
  }

  int getIdx(int x, int y) {
    return y*img.width+x;
  }
  void pixelate() {
    int x = -bw/2;
    for (int i = 0; i < w; ++i) {
      x += bw;
      int y = bh/2;
      for (int j = 0; j < h; ++j) {
        //println(i, j, x, y);
        int f = 2;
        float ravg = 0.0;
        float gavg = 0.0;
        float bavg = 0.0;
        float cnt = 0.0;
        for (int r = x-bw/f; r <= x+bw/f; ++r) {
          for (int q = y-bh/f; q <= y+bh/f; ++q) {
            int idx = getIdx(r, q);
            if (idx < img.pixels.length) {
              color c = img.pixels[idx];
              img.pixels[idx] = color(255, 0, 255);
              ravg += red(c);
              gavg += green(c);
              bavg += blue(c);
              ++cnt;
            }
          }
        }
        ravg /= cnt;
        gavg /= cnt;
        bavg /= cnt;
        color avgColor = color(ravg, gavg, bavg);
        for (int r = x-bw/f; r <= x+bw/f; ++r) {
          for (int q = y-bh/f; q <= y+bh/f; ++q) {
            int idx = getIdx(r, q);
            if (idx < img.pixels.length) {
              img.pixels[idx] = avgColor;
            }
          }
        }
        //img.pixels[getIdx(x, y)] = color(255, 0, 255);
        y += bh;
      }
    }
  }
  void pixel(int x, int y) {
    println(getIdx(x, y));
    int amt = 25;
    for (int i = x-amt; i < x+amt; ++i) {
      for (int j = y-amt; j < y+amt; ++j) {
        img.pixels[getIdx(i, j)] = color(0, 0, 255);
      }
    }
    img.updatePixels();
  }
}
