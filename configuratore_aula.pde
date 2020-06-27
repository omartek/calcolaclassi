int btnX_pos = 600;        // posizione e dati pulsantiera
int btnY_pos = 20;
int btnY_dist = 50;
int btn_num = 11;

int misure_n = btn_num;              // matrici valori e misurazioni
int[] misure = new int[misure_n];
int[] incrementi = new int[misure_n];
String[] btn_label = new String[btn_num];

int numerofile;                      // valori calcolati interassi
int numerorighe;
int interasseX;
int interasseY;

void setup() {                       // setup valori iniziali                                       
  size(800, 600);
  
  misure[0] = 400; // aulaX
  misure[1] = 400; // aulaY
  misure[2] = 40;  // bancoX
  misure[3] = 40;  // bancoY
  misure[4] = 50;  // interbancoX
  misure[5] = 60;  // interbancoY
  misure[6] = 50;  // distanza fondo aula
  misure[7] = 50;  // spazio-insY
  misure[8] = 180; // cattedraX
  misure[9] = 50;  // cattedraY
  misure[10] = 80;  // passaggio

  incrementi[0] = 5;  // aulaX
  incrementi[1] = 5;  // aulaY
  incrementi[2] = 5;  // bancoX
  incrementi[3] = 5;  // bancoY
  incrementi[4] = 5;  // interbancoX
  incrementi[5] = 5;  // interbancoY
  incrementi[6] = 5;  // distanza fondo aula  
  incrementi[7] = 5;  // spazio-insY
  incrementi[8] = 5;  // cattedraX
  incrementi[9] = 5;  // cattedraY 
  incrementi[10] = 5;  // passaggio
  
  btn_label[0] = "AulaX";
  btn_label[1] = "AulaY";
  btn_label[2] = "BancoX";
  btn_label[3] = "BancoY";
  btn_label[4] = "distX";
  btn_label[5] = "distY";
  btn_label[6] = "fondoaula";
  btn_label[7] = "spazio-insY";
  btn_label[8] = "cattedraX";
  btn_label[9] = "cattedraY";
  btn_label[10] = "passaggio"; 
} 

void draw() {

background(100);

 for (int i = 0; i < btn_num; i = i+1) {                                  // disegno pulsantiera
    disegna_rect(btnX_pos, btnY_pos + i*btnY_dist, 20, 20,"-");           // pulsante di sinistra
    disegna_rect(btnX_pos + 30, btnY_pos + i*btnY_dist, 20, 20,"+");      // pulsante di destra
    disegna_valori(btnX_pos, btnY_pos + i*btnY_dist, i);                  // scrivi etichette
 }

 rect(20, 50, misure[0], misure[1]);                                      // disegno aula
 int spazio_insegnante = misure[7] + misure[9] + misure[10];
 calcolo_interassi(misure[0], misure[1], misure[2], misure[3], misure[4], misure[5], misure[6], spazio_insegnante);    // calcolo interassi
 disegna_banchi(20, 50, misure[0], misure[1], misure[2], misure[3], misure[6], misure[7], misure[8], misure[9], misure[10]);                       // disegna banchi

}

void mouseReleased()  {                                                    // click del pulsante cambia valore
  int pulsante;
  int index;
  
  pulsante = verifica_btn(mouseX, mouseY);
  if (pulsante > -1 && pulsante < 11){
    index = pulsante;
    misure[index] = misure[index] - incrementi[index];
  //println("pulsante "+str(pulsante)+" "+str(misure[pulsante]));
  }
  else if (pulsante > 10 && pulsante < 22) {
    index = pulsante - 11;
    misure[index] = misure[index] + incrementi[index];
    //println("pulsante "+str(pulsante)+" "+str(misure[index]));
  }
  
}

int verifica_btn(int x, int y){                                            // calcolo quale pulsante è stato premuto
  if ( x > btnX_pos && x < btnX_pos+20 ){                                  // controllo appartenenza alla prima fila
    for(int i = 0; i < btn_num; i++){
      if ( y > (btnY_pos+i*btnY_dist) && y < (btnY_pos+i*btnY_dist+20) ){
      return i;
      }
    }
  }
  if ( x > (btnX_pos+30) && x < (btnX_pos+30+20) ){                        // controllo appartenenza alla seconda fila
    for(int i = 0; i < btn_num; i++){
      if ( y > (btnY_pos+i*btnY_dist) && y < (btnY_pos+i*btnY_dist+20) ){
      return i+11;
      }
    }
  }
return -1;
}
                                                                            // DISEGNO AULA E QUOTE
void disegna_banchi(int x, int y, int aulaX, int aulaY, int bancoX, int bancoY, int fondo_aula, int spazio_insY, int cattedraX, int cattedraY, int passaggio){
  int xs = x; //aulaX
  int ys = y + aulaY - (bancoY + fondo_aula); // aulaY + fondo muro
  textSize(10);
  
  fill(180);
  for (int i = 0 ; i < numerofile + 1; i++){                                // disegno banchi
      for (int ii = 0 ; ii < numerorighe + 1; ii++){
        ellipse(xs + bancoX/2, ys - ii*interasseY + bancoY, (int)bancoX/2, (int)bancoY/2);
        rect(xs, ys - ii*interasseY, bancoX, bancoY);  // bancoX e bancoY
      }
  xs = xs + interasseX;
  }
  
  rect(x + aulaX/2 - cattedraX/2 , y + spazio_insY, cattedraX, cattedraY); // disegno cattedra
  
  fill(255);                                                               // disegno quote

  text(fondo_aula, x-15, y+aulaY-fondo_aula/2);                       // disegno quote lungo Y
  text(bancoY, x-15, y+aulaY-fondo_aula-bancoY/2 +5);
  for (int i = 0 ; i < numerorighe; i++){  
      text(interasseY-bancoY, x-15, y+aulaY-(fondo_aula+bancoY) -interasseY*(i+1) + (int) (bancoY + interasseY)/2 +5);
      text(bancoY, x-15, y+aulaY-(fondo_aula+bancoY) -interasseY*(i+1) + (int)bancoY/2 +5);  
  }
  text(spazio_insY, x-15, y+(int)(spazio_insY/2));
  text(cattedraY, x-15, y+spazio_insY+(int)(cattedraY/2)); 
  text(passaggio, x-15, y+spazio_insY+cattedraY+(int)(passaggio/2)); 
  
  for (int i = 0 ; i < numerofile; i++){                                  // disegno quote lungo X
      text(bancoX, x+(int)(bancoX/2)+i*interasseX, y+aulaY+10);
      text(interasseX-bancoX, x+i*interasseX+(int)((bancoX+interasseX)/2), y+aulaY+10);  
  }
  text(bancoX,x+aulaX-(int)(bancoX/2), y+aulaY+10);
  
  fill(0);
  line(x+(int)(bancoX/2), y+aulaY-fondo_aula-(int)(bancoY/2), x+(int)(bancoX/2), y+aulaY-fondo_aula-(int)(bancoY/2)-interasseY);
  text(interasseY, x+(int)(bancoX/2)-10, y+aulaY-fondo_aula-(int)(bancoY/2)-(int)(interasseY/2)+10);
  line(x+(int)(bancoX/2), y+aulaY-fondo_aula-(int)(bancoY/2), x+(int)(bancoX/2)+interasseX, y+aulaY-fondo_aula-(int)(bancoY/2));
  text(interasseX, x+(int)(bancoX/2)+(int)(interasseX/2)-10, y+aulaY-fondo_aula-(int)(bancoY/2)-2);
 
}

void calcolo_interassi(int aulaX, int aulaY, int bancoX, int bancoY, int interX, int interY, int fondo_aula, int insegnanteY){
   numerofile = (int) ((aulaX - bancoX) / (bancoX + interX)) ; // interasseX
   numerorighe = (int) ((aulaY - insegnanteY - (bancoY + fondo_aula)) / (bancoY + interY)); // interasseY
   interasseX = (int)((aulaX - bancoX) / numerofile);
   interasseY = (int)((aulaY - insegnanteY - (bancoY + fondo_aula)) / numerorighe);
   // println(str(interasseX)+" "+str(interasseY)+" ");
}

void disegna_rect(int x, int y, int a, int b, String btn_text){            // disegno tasto con + o -
  fill(255);
  rect(x, y, a, b);
  textSize(15);
  fill(0);
  text(btn_text, x+5, y+15);
}

void disegna_valori(int x, int y, int index){                              // scrittura etichette
  fill(255);
  text(btn_label[index], x+20+35, y+(int)(20/2)+7.5);
  text(str(misure[index]), x+20+3+50+80, y+(int)(20/2)+7.5);
}
