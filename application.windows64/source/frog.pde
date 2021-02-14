class frog {
  
  float x;
  float y;
  float inc;
  int img;
  PImage frog1, frog2, frog3, broken1, broken2, broken3;
  boolean morreu, tocou;

  frog(float x1, float y1, float inc1, int img1, PImage frog11, PImage frog21, PImage frog31, PImage broken11, PImage broken21, PImage broken31) {

    x=x1;
    y=y1;
    inc=inc1;
    img=img1;
    frog1=frog11;
    frog2=frog21;
    frog3=frog31;
    broken1=broken11;
    broken2=broken21;
    broken3=broken31;
    tocou=false;
  }

  void display() {

    imageMode(CENTER);

    if (y<=height-50) {

      if (img==0) {
        frog1.resize(180, 162);
        image(frog1, x, y);
      } else if (img==1) {
        frog2.resize(180, 162);
        image(frog2, x, y);
      } else {
        frog3.resize(180, 162);
        image(frog3, x, y);
      }
    } else {

      if (img==0) {

        broken1.resize(180, 162);
        image(broken1, x, y);
      } else if (img==1) {
        broken2.resize(180, 162);
        image(broken2, x, y);
      } else {
        broken3.resize(180, 162);
        image(broken3, x, y);
      }
    }
  }


  void slide() {

    if (y>=height-50) {
      inc=0.75;
    }
    y+=inc;
  }

  float getY () {
    return y;
  }

  boolean partir() {
    return y>=height-50;
  }

  boolean morreu() {
    return y>=height;
  }

  void play() {
    if (tocou==false) {
      player.play();
    }
  }

  void rewind() {
    if (tocou==true) {
      player.rewind();
    }
  }

  void pause() {
    if (tocou==false) {
      player.pause();
    }
  }
}
