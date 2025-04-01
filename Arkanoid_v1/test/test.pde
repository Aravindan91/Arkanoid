PImage casse;
int ecart = 76;
int v_ecart=65;
int ecart2 =-38;

void setup() {
  size(960, 630);
  println(v_ecart+65+65);
casse = loadImage("tile.png");
}

void draw(){
  //image(casse,250,250);
        background(0,60,130);
  pavage();
}





//void pavage(){
// for(int j=0; j<10;j++){
//  for (int i = 0; i < 1000; i = i+ecart){
//  image(casse,0,i);

// }
// for (int i = -38; i < 1000;i=i+ecart){
//  image(casse,v_ecart,i);
// }
 
// for (int i = 0; i < 1000;i=i+ecart){
//  image(casse,v_ecart+65,i);
// }
// v_ecart= v_ecart+130;
 

//}
//}



void pavage(){
      for (int i = 0; i < 1000; i = i+ecart){
      image(casse,0,i);
      for (int it = -38; it < 1000;it=it+ecart){
        image(casse,v_ecart,it);
        for (int itt = 0; itt < 1000;itt=itt+ecart){
      image(casse,v_ecart+65,itt);
      }
}
}
 for (int i = -38; i < 1000; i = i+ecart){
      image(casse,v_ecart+65+65,i);
      for (int it = 0; it < 1000;it=it+ecart){
        image(casse,v_ecart+v_ecart+65+65,it);
        for (int itt =-38; itt < 1000;itt=itt+ecart){
      image(casse,v_ecart+65+v_ecart+65+65,itt);
      }
}
}


   for (int i = 0; i < 1000; i = i+ecart){
      image(casse,v_ecart+65+v_ecart+65+65+65,i);
      for (int it = -38; it < 1000;it=it+ecart){
        image(casse,v_ecart+v_ecart+65+v_ecart+65+65+65,it);
        for (int itt = 0; itt < 1000;itt=itt+ecart){
      image(casse,v_ecart+65+v_ecart+65+v_ecart+65+65+65,itt);
      }
}
}
 for (int i = -38; i < 1000; i = i+ecart){
      image(casse,v_ecart+65+65+v_ecart+65+v_ecart+65+65+65,i);
      for (int it = 0; it < 1000;it=it+ecart){
        image(casse,v_ecart+v_ecart+65+65+v_ecart+65+v_ecart+65+65+65,it);
        for (int itt =-38; itt < 1000;itt=itt+ecart){
      image(casse,v_ecart+65+v_ecart+65+65+v_ecart+65+v_ecart+65+65+65,itt);
      }
}
}

}
