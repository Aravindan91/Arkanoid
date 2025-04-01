// arkanoid = https://www.dailymotion.com/video/x5f1vv
/////////////////////////////////////////////////////
//
// Arkanoid
// DM2 "UED 131 - Programmation impérative" 2022-2023
// NOM         : Detchanamourtty
// Prénom      :Aravindan
// N° étudiant :20220383
//
// Collaboration avec : aider par sourya pour la fonction mousemoved
//
/////////////////////////////////////////////////////

//import processing.sound.*;
import processing.sound.*;
SoundFile intro, letsgo, mur, over, raquette, brique;
//===================================================
// les variables globales
//===================================================
/////////////////
///// pour la fonction pavage 
PImage casse;
int ecart = 76;
int v_ecart=65;
int ecart2 =-38;
/////////////

/////////////////////////////
// Pour les effets sonores //
/////////////////////////////

/////////////////////////////
// Pour la balle           //
int balleD, balleVitesse; // les vriable demandé 
float balleX, balleY, balleVx, balleVy;
float  newballeX, newballeY;
PVector vecteur ;
/////////////////////////////

/////////////////////////////
// Pour la raquette        //
int raquetteY, raquetteL, raquetteH, raquetteX; // les vriable demandé
/////////////////////////////

/////////////////////////////
// Pour la zone de jeu     //// contour du jeu , delimitant sa surface 
int minX = 70;// gauche 
int maxX = 640;// droite 
int minY = 630;// bas 
int centreX = 355; //le centre de la surface du jeu 
/////////////////////////////

/////////////////////////////
// Pour les briques        //
/////////////////////////////

/////////////////////////////
// Pour le "boss"          //
/////////////////////////////

/////////////////////////////
// Pour le contrôle global //
/////////////////////////////

////////////////////////////////////
// Pour la gestion de l'affichage //
////////////////////////////////////
////////////////////////////////////
// Pour la gestion des etats //
int etat; 
int INIT = 0;
int INIT2=4;
int GO = 1;
int OVER = 2;
int score =0;// le score 
int highscore = score;
int vie = 3;
boolean ex =false;
////////////////////////////////////



//===================================================
// l'initialisation
//===================================================
void setup() {
  size(960, 630);
  casse = loadImage("tile.png");//pour le pavage
  initBalleEtRaquette();
  background(0, 60, 130);
  intro = new SoundFile(this, "intro.mp3");
  over = new SoundFile(this, "gameover.mp3");

  intro.play();
  etat = INIT;
  
}



//===================================================
// l'initialisation de la balle et de la raquette
//===================================================
void initBalleEtRaquette() {
  raquetteY = 590;
  raquetteL = 100;// largeur de la raquette 
  raquetteH = 20;// sa hauter 
  raquetteX = centreX ;// le centre de la raquette 

  balleD =10;
  balleX = centreX;// le centre de la raquette 
  balleY= raquetteY-14;
  println(raquetteY);
  balleVitesse = 7;
  balleVx = balleVitesse*cos(random((5*PI)/4, (7*PI)/4));
  balleVy = balleVitesse*sin(random((5*PI)/4, (7*PI)/4));
  vecteur = new PVector(balleVx, balleVy);
}







//===================================================
// l'initialisation des briques
//===================================================
void initBriques() {
}

//===================================================
// l'initialisation de la partie
//===================================================
void initJeu() {
}

//===================================================
// la boucle de rendu
//===================================================
void draw(){
        //rebond(balleX,balleY,balleX+newballeX,balleY+newballeY,250,80,200,200);

    if(score>highscore){
 highscore=score;
  }
background(0, 60, 130);
  afficheJeu();
  
   if (etat==GO){
  deplaceBalle();
  miseAJourBalle() ;
  rebondMurs();
  rebondRaquette();
  rebondBoss();

   }
   if(etat==INIT) {
     afficheEcran("GET READY");
   }
   
    if(etat==OVER & vie!=0) {
      textSize(75);
   fill(255, 255, 255);
  text("tu es MORT ", 30, 430);
  noFill();
     //afficheEcran("GET READY");
   }
     
  //   if(vie==2 || vie ==1) {
  //     textSize(80);
  // fill(255, 255, 255);
  //text("T mort ", 50, 430);
  //noFill();
  //etat=INIT2;
  //   }
   
   
   
   if(etat==OVER & vie==0) {
       textSize(80);
   fill(255, 255, 255);
  text("GAME OVER ", 50, 430);
  noFill();
  ex = true;
  //quiter();
   }
  // }
   //if(ex==true){
   //  exit();
   //      delay(2000);

   //}
}



//===================================================
// gère les rebonds sur les murs
//===================================================
void rebondMurs() {// la fonction rebond 
  // inversement avc la multiplication d'une valeur negatif

  if (balleY<32 ) {//plafond 
    balleY=32;//!!!!!IMPORTANT  , imperativement remttre la balle dans la limite car sinon , elle fera des ricohet dans sur les mur et elle va depasser le cadre 
    // inversement avc la multiplication d'une valeur negatif
    balleVx = 1*balleVitesse*cos(random((5*PI)/4, (7*PI)/4));
    balleVy = -1*balleVitesse*sin(random((5*PI)/4, (7*PI)/4));
    vecteur = new PVector(balleVx, balleVy);
    mur = new SoundFile(this, "mur.mp3");
    mur.play();
  }

  if (balleX<35 ) {  // coté droit 
    balleX=35;
    balleVx = -1*balleVitesse*cos(random((5*PI)/4, (7*PI)/4));
    balleVy = -1*balleVitesse*sin(random((5*PI)/4, (7*PI)/4));
    vecteur = new PVector(balleVx, balleVy);
    mur = new SoundFile(this, "mur.mp3");
    mur.play();
  }


  if (balleX>675 ) {  // coté gauche 
    balleX=675;
    balleVx = -1*balleVitesse*cos(random((5*PI)/4, (7*PI)/4));
    balleVy = -1*balleVitesse*sin(random((5*PI)/4, (7*PI)/4));
    vecteur = new PVector(balleVx, balleVy);
    mur = new SoundFile(this, "mur.mp3");
    mur.play();
  }
  
  if(balleY>630){
  println(highscore);

  score=0;
  vie = vie -1;
  etat = OVER;
  over.play();
  println(vie);
  
  if(balleY>630 && vie ==0){
    textSize(80);
   fill(255, 255, 255);
  text("GAME OVER ", 50, 430);
  noFill();
      etat = OVER;
        over.play();
//textSize(80);
//   fill(255, 255, 255);
//  text("GAME OVER ", 50, 430);
//  noFill();
  ex = true;
      

  }
}
}




//===================================================
// gère le rebond sur la raquette
//===================================================
void rebondRaquette() {// la fonction rebond raquette 

  // raquetteG corespond au centre de la raquette-50 et raquetteD celui de raquette+50

  if (balleX>raquetteG && balleX<raquetteD) {// si la balle est entre la surface de la raquette 
    // alors on verifie la deuxieme étape
    if (balleY>raquetteY-5 && balleY<605) {// si la raquette est supérieure (touche) la raquette verticalment alors 

      // on inverse l'inversement en metant au positif 
      balleVx = 1*balleVitesse*cos(random((5*PI)/4, (7*PI)/4));
      balleVy = 1*balleVitesse*sin(random((5*PI)/4, (7*PI)/4));
      vecteur = new PVector(balleVx, balleVy);
      raquette = new SoundFile(this, "raquette.mp3");
      raquette.play();
    }
  }
}
//===================================================
// gère le rebond sur une "boîte"
// 
// --------------------------------------------------

// (x1, y1) = l'ancienne position de la balle
// (x2, y2) = la nouvelle position de la balle
// (bx, by) = le coin supérieur gauche de la boîte
// (bw, bh) = la largeur et la hauteur de la boîte
// --------
// résultat = vrai si rebond / faux sinon
// --------
// met à jour la vitesse de la balle en fonction du 
// rebond
//===================================================
//void rebond(float x1, float y1, float x2, float y2, 
//  float bx, float by, float bw, float bh) {
//    println("X av et apr ", x1,x2,"Y av et apr ",y1,y2);
//        println("coin gauche X ",bx,bx+bw,"coin gauche Y ",by,by+bh);

//  //println("A",x1, y1, x2, y2);
//  if (x2>bx & x2<bx+bw & x1<bx){
//    println("X : ",x2,bx+bw,x1,bx+bw);
//     println("X av et apr ", x1,x2,"Y av et apr ",y1,y2);
//        println("coin gauche X ",bx,bx+bw,"coin gauche Y ",by,by+bh);

//  }
  
//  if (y1<by){
//  if (y2>by & y2<by+bh ){
//    println("Y : ",y2,by+bh,y1,by+bw);

//  }
//  }
//  //return false;
//}


//===================================================
// gère le rebond sur les briques
// --------------------------------------------------
// (x1, y1) = l'ancienne position de la balle
// (x2, y2) = la nouvelle position de la balle
//===================================================

void rebondBriques(float x1, float y1, float x2, float y2) {
}

//===================================================
// gère le rebond sur le boss
// --------------------------------------------------
// (x1, y1) = l'ancienne position de la balle
// (x2, y2) = la nouvelle position de la balle
//===================================================
//void rebondBoss(float x1, float y1, float x2, float y2) {
// rebond boss via les pixel 
void rebondBoss() {

  if (balleY<275) {
    if (balleX>350 && balleX<448) {
      println("gauche ");
      balleVx = 1*balleVitesse*cos(random((5*PI)/4, (7*PI)/4));
      balleVy = -1*balleVitesse*sin(random((5*PI)/4, (7*PI)/4));
      vecteur = new PVector(balleVx, balleVy);
      println("TTTTTTTEST");
      score = score+10;
    }
    if (balleX>250 && balleX<350) {
      println("droite");
      balleVx = -1*balleVitesse*cos(random((5*PI)/4, (7*PI)/4));
      balleVy = -1*balleVitesse*sin(random((5*PI)/4, (7*PI)/4));
      vecteur = new PVector(balleVx, balleVy);
      println("TTTTTTTEST");
      score = score+10;
    }
  }

}





//===================================================
// calcule la nouvelle position de la balle
//===================================================
void deplaceBalle() {
  newballeX = vecteur.x;
  newballeY = vecteur.y;
}

//===================================================
// met à jour la position de la balle
//===================================================
void miseAJourBalle() {
  //println("avant",balleX,balleY);
  balleX = balleX + newballeX;
  balleY = balleY + newballeY;
 //println("après",balleX,balleY);

}

//===================================================
// affiche un écran, avec un message
// --------------------------------------------------
// msg = le message à afficher
//===================================================
void afficheEcran(String msg) {
  
  PImage img = loadImage("arkanoid.png") ;
  img.resize(0, 100);
   image(img, 150, 350);
  // les textes
  textSize(50);
  fill(255, 255, 255);
  text(msg, 170, 500);
  noFill();
  
  
  textSize(10);
  fill(255, 255, 255);
  text("PRESS <SPACE> TO START ", 250, 530);
  noFill();
  
}

//===================================================
// fait le dessin de pavage au fond
//===================================================



void pavage() {
  for (int i = 0; i < 1000; i = i+ecart) {
    image(casse, 0, i);
    for (int it = -38; it < 1000; it=it+ecart) {
      image(casse, v_ecart, it);
      for (int itt = 0; itt < 1000; itt=itt+ecart) {
        image(casse, v_ecart+65, itt);
      }
    }
  }
  for (int i = -38; i < 1000; i = i+ecart) {
    image(casse, v_ecart+65+65, i);
    for (int it = 0; it < 1000; it=it+ecart) {
      image(casse, v_ecart+v_ecart+65+65, it);
      for (int itt =-38; itt < 1000; itt=itt+ecart) {
        image(casse, v_ecart+65+v_ecart+65+65, itt);
      }
    }
  }


  for (int i = 0; i < 1000; i = i+ecart) {
    image(casse, v_ecart+65+v_ecart+65+65+65, i);
    for (int it = -38; it < 1000; it=it+ecart) {
      image(casse, v_ecart+v_ecart+65+v_ecart+65+65+65, it);
      for (int itt = 0; itt < 1000; itt=itt+ecart) {
        image(casse, v_ecart+65+v_ecart+65+v_ecart+65+65+65, itt);
      }
    }
  }
  for (int i = -38; i < 1000; i = i+ecart) {
    image(casse, v_ecart+65+65+v_ecart+65+v_ecart+65+65+65, i);
    for (int it = 0; it < 1000; it=it+ecart) {
      image(casse, v_ecart+v_ecart+65+65+v_ecart+65+v_ecart+65+65+65, it);
      for (int itt =-38; itt < 1000; itt=itt+ecart) {
        image(casse, v_ecart+65+v_ecart+65+65+v_ecart+65+v_ecart+65+65+65, itt);
      }
    }
  }
}
//===================================================
// affiche le cadre
// les variables pour cette fonctions 

//===================================================
void cadre() {

  PImage[] images = new PImage[20];// création d'un tableau du type image et d'une taille 20 ( comme ca on est trkl)
  PImage images2 ;// création d'un tableau du type image et d'une taille 20 ( comme ca on est trkl)
  int esp = 0;// variable pour l'ecart entre wall1 et 2
  for (int i=0; i<6; i++) { // boucle repetant 6 fois 
    // je charge les photo sur le tableau avec l'indice i pour wall1 et l'indice i+1
    images[i] = loadImage("wall1.png");
    images[i+1] = loadImage("wall2.png");
    // je décharge l'image
    image(images[i], 0, esp);
    image(images[i+1], 0, esp+40);
    esp = esp+105;
  }
  // pour le coté gauche 
  esp = 0;
  for (int i=0; i<6; i++) { // boucle repetant 6 fois 
    // je charge les photo sur le tableau avec l'indice i pour wall1 et l'indice i+1
    images[i] = loadImage("wall1.png");
    images[i+1] = loadImage("wall2.png");
    // je décharge l'image
    image(images[i], 680, esp);
    image(images[i+1], 680, esp+40);
    esp = esp+105;
  }

  //pour le haut 

  images2= loadImage("top.png");
  image(images2, 00, 0);


  //            X  Y
}

//===================================================
// formate le score sur 6 chiffres
// --------------------------------------------------
// score = le score à afficher
// --------
// résultat = une chaîne de caractères sur 6 chiffres
//===================================================
String formatScore(int score) {
  return "";
}

//===================================================
// affiche le cartouche de droite
//===================================================
void cartouche() {
  ////les mur en gris 
  fill(128, 128, 128);
  rect(350, 15, 710, 30);
  //    x   y  l  h
  rect(15, 320, 30, 640);
  //    x   y  l  h
  rect(700, 320, 30, 640);
  //    x   y  l  h
  noFill();
  rectMode(CENTER);
  fill(0, 0, 0);
  rect(830, 310, 260, 640);
  PImage img = loadImage("arkanoid.png") ;
  image(img, 705, 0) ;
  // les textes
  textSize(20);
  fill(255, 255, 255);
  text("1UP", 800, 100);
  noFill();

  textSize(20);
  fill(255, 255, 255);
  text("High Score:"+highscore, 730, 200);
  
  textSize(20);
  fill(255, 255, 255);
  text("Vie : "+vie, 750, 170);


  textSize(20);
  fill(255, 255, 255);
  text("Copyright", 760, 560);
  textSize(20);
  fill(255, 255, 255);
  text("D.Aravindan", 750, 580);
  textSize(20);
  fill(255, 255, 255);
  text("2022", 780, 600);



  textSize(20);
  fill(255, 255, 255);
  text("score : "+score, 755, 230);

  // pr le hello avec une police pixel art 
  PFont fonte = createFont("joystix.ttf", 20);
  textFont(fonte);
}

//===================================================
// affiche le boss dans sa cage
//===================================================
void boss() {
  stroke(#FFFFFF);// couleur du contour du cercle 
  strokeWeight(2);// son epaisseur 

  fill(186, 75, 55);
  circle(200, 200, 250);//tete
  fill(255, 85, 0);
  //oeile
  circle(150, 160, 60);//gauche
  circle(250, 160, 60);// droite

  stroke(#FFFFFF);// blanc
  // front 
  line(250, 85, 200, 140);//trait gauche
  line(150, 85, 200, 140);// trait droit
  // les sourcils
  line(170, 95, 190, 118);// petit trait gauche 
  line(210, 118, 230, 95);// petit trait droite 
  //   x     y    x    y
  stroke(#F5DE14);// jaune
  //  oreile droit
  line(250, 85, 300, 15);// cone
  line(300, 15, 300, 124);// cone

  // oreil gauche
  line(100, 15, 100, 124);// cone
  //   x     y    x    y
  line(152, 88, 100, 15);// cone
  //   x     y    x    y
  // oeil pupille
  noStroke();

  fill(0, 0, 0);
  circle(150, 160, 26);
  circle(250, 160, 26);
  fill(12, 255, 12);
  circle(150, 160, 20);
  circle(250, 160, 20);
  //
  noFill();

  //premier cone en bas à gauche 
  stroke(#00E7FF);//////////

  line(50, 310, 120, 296);// cone
  line(50, 310, 100, 275);// cone
  //   x     y    x    y
  //2 eme cone 
  stroke(#FF0000);//////////

  line(40, 280, 100, 275);// cone
  line(40, 280, 85, 250);// cone

  //////cone en bas à droite  
  stroke(#00E7FF);//////////

  line(287, 290, 357, 300);// cone
  line(357, 300, 307, 265);// cone

  stroke(#FF0000);//////////
  line(307, 265, 370, 265);// cone
  line(320, 235, 370, 265);// cone

  stroke(#FFFFFF);//////////
  //la petit barbichette 
  bezier(160, 188, 110, 230, 200, 220, 135, 305);
  //      x     y   x   y     x     y    x   y 
  bezier(260, 188, 280, 230, 200, 220, 260, 310);
  //      y        y         y          y
  arc(197, 306, 125, 90, 0, PI);
  noStroke();

  fill(0, 0, 0);
  textSize(25);
  text("Skull", 160, 385);// son nom
  noFill();
  PImage img = loadImage("cage.png");
  image(img, 0, 0);
}

//===================================================
// affiche la balle
//===================================================
void afficheBalle() {
  fill(#FFFFFF);
  ellipse(balleX, balleY, balleD, balleD);
  noFill();
}

//===================================================
// affiche la raquette
//===================================================
void afficheRaquette() {
  fill(#FFFFFF);
  rect(raquetteX, raquetteY, raquetteL, raquetteH, PI*100);
  noFill();
}

//===================================================
// affiche le jeu
//===================================================
void afficheJeu() {
  // pavage();
  cartouche(); 
  cadre();
  pushMatrix() ;
  translate(250, 80);// deplace mon boss + cage 
  scale(0.5);// reduit l'echele
  // affiche le grand carré gras en bas à droite
  boss();
  popMatrix();
  // affiche le petit carré fin en haut à gauche
  afficheRaquette();
  afficheBalle();
    

}

//===================================================
// gère les interactions clavier
//===================================================
void keyPressed() {
  if(etat==INIT){
    etat=GO;
    intro.stop();
    letsgo=new SoundFile(this, "letsgo.mp3");
    letsgo.play();
    delay(3000);
  }
  
  
  //if(etat==INIT2){
  //  etat=GO;
  //       balleX = centreX;// le centre de la raquette 
  //balleY= raquetteY-14;
  //  intro.stop();
  //  letsgo=new SoundFile(this, "letsgo.mp3");
  //  letsgo.play();
  //  delay(3000);
  //  println("voici l'etat",etat);
  //}
  
  if(etat==OVER){
    etat=INIT;
     balleX = centreX;// le centre de la raquette 
  balleY= raquetteY-14;
  intro.play();
  println("la viiie ",vie);
  
  
  if (vie==0){// redonne la vie à 3
    vie =3;
  }
  }
}

//===================================================
// gère les interactions souris
//===================================================
int raquetteG;// pour la parrtie gauche et droite 
int raquetteD;

void mouseMoved() {
  //balleX=mouseX;
  //balleY=mouseY;
  //println("balleX et balleY",balleX,balleY);// si la souris se deplace entre minX et maxX alors ma raquette bouge  
  //println("X et Y",mouseX,mouseY);
  if (mouseX<maxX && mouseX>minX) {
    raquetteX = mouseX;
    //println(raquetteX);
    raquetteD = raquetteX +50;
    raquetteG = raquetteX -50;
    
  }
}
