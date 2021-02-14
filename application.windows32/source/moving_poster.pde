/*;
 WELCOME TO THE MOVING POSTER PROJECT OF AN EXHIBITION OF 'BALADA DE UM BATRÁQUIO' SHORT, DIRECTED BY LEONOR TELES.
 
 THIS PROJECT WAS DEVELOPED BY RICARDO SACADURA IN HIS 2ND YEAR AT DESIGN AND MULTIMEDIA'S BACHELOR FROM UNIVERSITY OF COIMBRA, JANUARY 2020;
 SPECIAL THANKS, FOR THEIR MENTORSHIP, TO PROFESSOR PEDRO MARTINS, NUNO COELHO AND PAUL HARDMAN.
 
 RECOMENDATIONS- FOR THE POSTER TO RUN AS EXPECTED YOU MUST HAVE BOTH SOUND. AND MINIM. LIBRARIES FROM PROCESSING DOWNLOADED;
 THE PROGRAMME USES YOUR COMPUTER'S MICROPHONE TO READ EXTERNAL AMPLITUDE, AND SO IT WORKS BETTER IF YOUR LISTENING THE OUTPUT WITH HEADPHONES;
 FINNALY, IF YOUR ON A MAC, YOU SHOULD HIDE YOUR DOCK FOR WHILE TO SEE THE WHOLE APPLICATION (COMMAND+OPTION+D).
 
 NOW JUST HAVE A FUN :)
 */


//processing libraries
import processing.sound.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
Amplitude amp;
AudioIn in;

//class invocation
ArrayList<frog> Frog;

//images upload
PImage[] imgs = new PImage[7];
PImage frog1, frog2, frog3, broken1, broken2, broken3;

//other important variables
int tamanho;
int numBatraquios=8;
int contador=0, img;

float x, y, inc;
float  quantosBatraquios, ampatual, delay;

String filename="smash_fadedout.wav";

void setup() {

  size(614, 868,P2D); //30% - x-526 y-744
  pixelDensity(2);
  surface.setTitle("Balada de um Batráquio - Moving Poster");

  //libraries storage
  minim= new Minim(this);
  player= minim.loadFile(filename);
  in = new AudioIn(this, 0);
  amp= new Amplitude(this);
  in.start();
  amp.input(in);

  //class upload
  Frog= new ArrayList<frog>();

  //frog's upload
  frog1=loadImage("frog.png");
  frog2=loadImage("frog_2.png");
  frog3=loadImage("frog_3.png");

  broken1=loadImage("broken.png");
  broken2=loadImage("broken_2.png");
  broken3=loadImage("broken_3.png");


  //back poster upload
  for (int i=0; i<imgs.length; i++) {
    imgs[i]=loadImage("poster"+i+".jpg");
  }
}

void draw() {

  background(255);
  println(amp.analyze(), frameRate);

  //mic's input reception and mapping to numbers of frogs and background speed
  ampatual=amp.analyze();

  if (frameCount%25==0) {

    delay=round(map(ampatual, 0, 0.5, 50, 10));

    if (frameCount % delay==0) {
      contador=(contador+1)%imgs.length;
    }
  }
  if (frameCount%50==0) {

    quantosBatraquios= round(map(ampatual, 0, 0.5, 0, numBatraquios));

    for (int f=0; f<quantosBatraquios; f++) {
      x=random(112.5, width-112.5);
      inc=random(6, 14);
      y=-180;
      img=round(random(2));
      Frog.add(new frog(x, y, inc, img, 
        frog1, frog2, frog3, broken1, broken2, broken3));
    }
  }


  //background running in stop-motion
  imageMode(CENTER);
  image(imgs[contador], width/2, height/2, 614, 868);

  //frogs display and slide
  for (int a=Frog.size()-1; a>=0; a--) {

    Frog.get(a).display();
    Frog.get(a).slide();

    if (Frog.get(a).partir()==true) {

      if (Frog.get(a).getY()>=height) {

        Frog.get(a).rewind();
      } else if (Frog.get(a).getY()>=height-2) {

        Frog.get(a).pause();
        Frog.get(a).tocou=true;
      } else {

        Frog.get(a).tocou=false;
        Frog.get(a).play();
      }
    }

    if (Frog.get(a).morreu()==true) {
      Frog.remove(a);
    }
  }
}
