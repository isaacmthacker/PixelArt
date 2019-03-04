class PixalingClass {
  String path;
  PImage img;
  int w, h;
  int bw, bh;
  boolean resize;
  color[] colors;
  boolean useList = false;
  PixalingClass(String loc, int ll, int hh, boolean resz, color[] cs) {
    path = loc;
    resize = resz;
    colors = cs;
    updateSquares(ll, hh);
    pixelate();
  }

  void updateSquares(int newll, int newhh) {
    img = loadImage(path);
    img.loadPixels();
    if (resize) {
      img.resize(width, height);
    }
    w = newll;
    h = newhh;
    bw = img.width/w;
    bh = img.height/h;
    println(w, h, w*h);
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
        ArrayList<Long> colorVals = new ArrayList<Long>();
        float ravg = 0.0;
        float gavg = 0.0;
        float bavg = 0.0;
        float numPixels = 0.0;
        for (int r = x-bw/2; r <= x+bw/2; ++r) {
          for (int q = y-bh/2; q <= y+bh/2; ++q) {
            int idx = getIdx(r, q);
            if (idx < img.pixels.length) {
              color c = img.pixels[idx];
              colorVals.add(colorVal(c));
              //img.pixels[idx] = color(255, 0, 255);
              ravg += red(c)*red(c);
              gavg += green(c)*green(c);
              bavg += blue(c)*blue(c);
              ++numPixels;
            }
          }
        } 
        ravg /= numPixels;
        gavg /= numPixels;
        bavg /= numPixels;

        ravg = sqrt(ravg);
        gavg = sqrt(gavg);
        bavg = sqrt(bavg);
        color avgColor = color(ravg, gavg, bavg);
        if (useList) {
          avgColor = getClosestColor(avgColor);
        }
        for (int r = x-bw/2; r <= x+bw/2; ++r) {
          for (int q = y-bh/2; q <= y+bh/2; ++q) {
            int idx = getIdx(r, q);
            if (idx < img.pixels.length) {
              img.pixels[idx] = avgColor;
            }
          }
        }
        y += bh;
      }
    }
    img.updatePixels();
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
  color getClosestColor(color c) {
    float minDiff = colorDiff(c, colors[0]);
    int minIdx = 0;
    for (int ci = 1; ci < colors.length; ++ci) {
      float diff = colorDiff(c, colors[ci]);
      if (diff < minDiff) {
        minDiff = diff;
        minIdx = ci;
      }
    }
    return colors[minIdx];
  }
  long colorVal(color c) {
    long ret = 0;
    ret |= int(alpha(c));
    ret <<= 8;
    ret |= int(red(c));
    ret <<= 8;
    ret |= int(green(c));
    ret <<= 8;
    ret |= int(blue(c)); 
    return ret;
  }
  color longToColor(long l) {
    int blue = int(l&0xFF);
    l >>= 8;
    int green = int(l&0xFF);
    l >>= 8;
    int red = int(l&0xFF);
    return color(red, green, blue);
  }
  float colorDiff(color c1, color c2) {
    return sqrt((red(c1)-red(c2))*(red(c1)-red(c2)) + 
      (green(c1)-green(c2))*(green(c1)-green(c2)) + 
      (blue(c1)-blue(c2))*(blue(c1)-blue(c2)));
    //return abs(colorVal(c1) - colorVal(c2));
  }
  String colorToString(color c) {
    return red(c) + "," + green(c) + "," + blue(c);
  }
  String getColor(int x, int y) {
    color c = img.pixels[getIdx(x, y)];
    String cstr = colorToString(c); 
    text(cstr, x, y+(y < height/2 ? 25 : -25));
    return cstr;
  }
}
