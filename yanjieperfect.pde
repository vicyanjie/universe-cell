int fc,num=6000;
ArrayList ballCollection; 
float theta;
boolean save = false;
PGraphics yanjie1, yanjie2, yanjie3;
PGraphics letteran, letteri;
PFont font;
String an="AN", i="I";

void setup() {
  background(20);
  size(842, 330);
  letteran = createGraphics(width, height);
  letteri = createGraphics(width, height);
  font = createFont("Gotham-bold", 250);
  yanjie1 = createGraphics(width, height);
  yanjie2 = createGraphics(width, height);
  yanjie3 = createGraphics(width, height);
  ballCollection = new ArrayList();
  createStuff();
}

void draw() {
  background(225,0,204); 
  for (int i=0; i<ballCollection.size (); i++) {  //i = ball number
    Ball mb = (Ball) ballCollection.get(i);
    mb.run();
  }
  theta += .0723;
  
   if (save) {
    if (frameCount%1==0 && frameCount < fc + 30) saveFrame("image-####.gif");
  }
}


void mouseReleased() {
  //createStuff();
 fc = frameCount;
  save = true;
  saveFrame("image-###.gif");
}

void createStuff() {
  ballCollection.clear();
  yanjie1.beginDraw();
  yanjie1.noStroke();
  yanjie1.background(255);
  yanjie1.fill(0);
  yanjie1.beginShape();
  yanjie1.vertex(110, 100);
  yanjie1.vertex(140, 100);
  yanjie1.vertex(170, 140);
  yanjie1.vertex(200, 100);
  yanjie1.vertex(230, 100);
  yanjie1.vertex(180, 165);
  yanjie1.vertex(180, height);
  yanjie1.vertex(155, height);
  yanjie1.vertex(155, 165);
  yanjie1.vertex(110, 100);
  yanjie1.endShape(CLOSE);
  yanjie1.endDraw();
  yanjie1.loadPixels();

  yanjie2.beginDraw();
  yanjie2.noStroke();
  yanjie2.background(255);
  yanjie2.fill(0);
  yanjie2.beginShape();
  yanjie2.vertex(526, 0);
  yanjie2.vertex(551, 0);
  yanjie2.vertex(551, 225);
  yanjie2.vertex(540, 256);
  yanjie2.vertex(506, 268);
  yanjie2.vertex(505, 247);
  yanjie2.vertex(520, 242);
  yanjie2.vertex(526, 225);
  yanjie2.vertex(526, 0);
  yanjie2.endShape(CLOSE);
  yanjie2.endDraw();
  yanjie2.loadPixels();

  yanjie3.beginDraw();
  yanjie3.noStroke();
  yanjie3.background(255);
  yanjie3.fill(0);
  yanjie3.beginShape();
  yanjie3.vertex(643, 100);
  yanjie3.vertex(726, 100);
  yanjie3.vertex(726, 119);
  yanjie3.vertex(668, 119);
  yanjie3.vertex(668, 153);
  yanjie3.vertex(723, 153);
  yanjie3.vertex(723, 172);
  yanjie3.vertex(668, 172);
  yanjie3.vertex(668, 208);
  yanjie3.vertex(width, 208);
  yanjie3.vertex(width, 228);
  yanjie3.vertex(643, 228);
  yanjie3.vertex(643, 100);
  yanjie3.endShape(CLOSE);
  yanjie3.endDraw();
  yanjie3.loadPixels();


  letteran.beginDraw();
  letteran.noStroke();
  letteran.background(255);
  letteran.fill(0);
  letteran.textFont(font, 195);
  letteran.textAlign(215, 300);
  letteran.text(an, 210, 230);
  letteran.endDraw();
  letteran.loadPixels();

  letteri.beginDraw();
  letteri.noStroke();
  letteri.background(255);
  letteri.fill(0);
  letteri.textFont(font, 195);
  letteri.textAlign(570, 300);
  letteri.text(i, 570, 230);
  letteri.endDraw();
  letteri.loadPixels();

  for (int i=0; i<num; i++) {
    int x = (int)random(width);
    int y = (int)random(height);  //x,y=random dot in the screem

    int yy = yanjie1.pixels[x+y*width];
    int j = yanjie2.pixels[x+y*width];
       int e = yanjie3.pixels[x+y*width];
    int a = letteran.pixels[x+y*width];
    int ii = letteri.pixels[x+y*width];
    if ((brightness(e)<255)||(brightness(yy)<255)||(brightness(j)<255)||(brightness(a)<255)||(brightness(ii)<255)) {
      PVector org = new PVector(x, y);
      float radius = random(5, 10);//r turning speed
      PVector loc = new PVector(org.x+radius, org.y);//add dot(loc) right of dot(org)
      float offSet = random(TWO_PI);
      int dir = 3; 
      float r = random(1);
      if (r>.5) dir =-2;
      Ball myBall = new Ball(org, loc, radius, dir, offSet);
      ballCollection.add(myBall);
    }
  }
}
class Ball {
  PVector org, loc;
  float sz = 1;             //sz = dot size
  float radius, offSet, a;
  int s, dir, countC, d = 20; //d = line length
  boolean[] connection = new boolean[num];

  Ball(PVector _org, PVector _loc, float _radius, int _dir, float _offSet) {
    org = _org;
    loc = _loc;
    radius = _radius;
    dir = _dir;
    offSet = _offSet;
  }

  void run() {
    display();
    move();
    lineBetween();
  }
  void move() {
    loc.x = org.x + sin(theta*dir+offSet)*radius;
    loc.y = org.y + cos(theta*dir+offSet)*radius;
  }

  void lineBetween() {
    countC = 5;
    for (int i=0; i<ballCollection.size(); i++) {
      Ball other = (Ball) ballCollection.get(i);
      float distance = loc.dist(other.loc);
      if (distance >0 && distance < d) {
        a = map(countC, 0, 10, 10, 255);
        stroke(255, a);
        line(loc.x, loc.y, other.loc.x, other.loc.y);
        connection[i] = true;
      } else {
        connection[i] = false;
      }
    }
    for (int i=0; i<ballCollection.size(); i++) {
      if (connection[i]) countC++;
    }
  }

  void display() {
    noStroke();
    fill(255, 200);
    ellipse(loc.x, loc.y, sz, sz);
  }
}