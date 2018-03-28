// noise(), sin(), rotate(),
float x, y, x2, y2, rad, rad2, dist, dist2;
float deg, incr, yIn, rotateBy, ang;
int fc;
boolean save = false;

void setup() {
  size(600, 600);
  //background(#02021A);
  background(255);
  incr = 1; // numVerts = 360/incr
  rad = -20;
  rad2 = -160;
  dist = 500;
  dist2 = 550;
}

void draw() {
 
  noStroke();
  fill(0, 10);
  rect(0, 0, width, height);
  fill(255);
  
  rotateBy += .009;
  pushMatrix();
  translate(width/2, height/2);
  rotate(rotateBy);
  deg = 0;
  while (deg <= 360) {
    deg += incr;
   ang = radians(deg);
   x = cos(ang) * (rad + (dist * noise(y/60, yIn)));
   y = sin(ang) * (rad + (dist * noise(x/80, yIn)));
    ellipse(x, y, 1.5, 1.5);
    x2 = sin(ang) * (rad2 + (dist2 * noise(y2/20, yIn)));
    y2 = cos(ang) * (rad2 + (dist2 * noise(y2/20, yIn)));
    ellipse(x2, y2, 1, 1);
  }
  yIn += .005;
  popMatrix();
  
    if (save) {
    if (frameCount%1==0 && frameCount < fc + 100) saveFrame("image-####.gif");
  }
}

void mouseReleased() {
  //createStuff();
 fc = frameCount;
  save = true;
  saveFrame("image-###.gif");
}
