int btnX_pos = 800;        // posizione e dati pulsantiera
int btnY_pos = 20;
int btnY_dist = 50;
int btn_num = 12;          // parametri aula misurabili complessivamente
int btn_num_ON = 2;        // misure visibili modificabili a video dall'utente

int misure_n = btn_num;              // matrici valori e misurazioni
int[] misure = new int[misure_n];
int[] incrementi = new int[misure_n];
String[] btn_label = new String[btn_num];

int numerofile;            // valori calcolati interassi dalla funzione calcolo_interassi
int numerorighe;
int interasseX;
int interasseY;
int bordo_aula_def;

void setup() {            // setup valori iniziali                                       
  size(1000, 800);
                     // parametri aula misurabili
  misure[0] = 480;   // aulaX
  misure[1] = 600;   // aulaY
  misure[2] = 40;    // bancoX
  misure[3] = 40;    // bancoY
  misure[4] = 100;   // interbancoX
  misure[5] = 100;   // interbancoY
  misure[6] = 30;    // distanza fondo aula
  misure[7] = 30;    // distanza bordi aula
  misure[8] = 30;    // spazio-insY dal muro lavagna
  misure[9] = 160;   // cattedraX
  misure[10] = 60;   // cattedraY
  misure[11] = 225;  // distanza asse testa professore/studente

                      // valore incremento al click della pulsantiera
  incrementi[0] = 5;  // aulaX
  incrementi[1] = 5;  // aulaY
  incrementi[2] = 5;  // bancoX
  incrementi[3] = 5;  // bancoY
  incrementi[4] = 5;  // interbancoX
  incrementi[5] = 5;  // interbancoY
  incrementi[6] = 5;  // distanza fondo aula  
  incrementi[7] = 5;  // distanza bordo aula   
  incrementi[8] = 5;  // spazio-insY dal muro lavagna
  incrementi[9] = 5;  // cattedraX
  incrementi[10] = 5; // cattedraY 
  incrementi[11] = 5; // distanza professore

                      // label pulsanti e valori
  btn_label[0] = "AulaX";
  btn_label[1] = "AulaY";
  btn_label[2] = "BancoX";
  btn_label[3] = "BancoY";
  btn_label[4] = "distX";
  btn_label[5] = "distY";
  btn_label[6] = "fondo-aula";
  btn_label[7] = "bordo-aula";
  btn_label[8] = "spazio-insY";
  btn_label[9] = "cattedraX";
  btn_label[10] = "cattedraY";
  btn_label[11] = "dist_professore"; 
} 

void draw() {

background(100);
int x0 = 20; // origine disegno aula
int y0 = 50; // origine disegno aula

 fill(255);
 rect(x0, y0, misure[0], misure[1]);                                      // disegno aula

 for (int i = 0; i < btn_num_ON; i = i+1) {                               // disegno pulsantiera
    disegna_rect(btnX_pos, btnY_pos + i*btnY_dist, 20, 20,"-");           // pulsante di sinistra
    disegna_rect(btnX_pos + 30, btnY_pos + i*btnY_dist, 20, 20,"+");      // pulsante di destra
    disegna_valori(btnX_pos, btnY_pos + i*btnY_dist, i);                  // scrivi etichette
 }

 int sp_insegnante = misure[8] + misure[11];
 calcolo_interassi(misure[0], misure[1], misure[2], misure[3], misure[4], misure[5], misure[6], misure[7], sp_insegnante);    // calcolo interassi
 disegna_banchi(x0, y0, misure[0], misure[1], misure[2], misure[3], misure[6], misure[8], misure[9], misure[10], misure[11]); // disegna banchi

}

void mouseReleased()  {                                                    // CLICK DELLA PULSANTIERA VALORI
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
    for(int i = 0; i < btn_num_ON; i++){
      if ( y > (btnY_pos+i*btnY_dist) && y < (btnY_pos+i*btnY_dist+20) ){
      return i;
      }
    }
  }
  if ( x > (btnX_pos+30) && x < (btnX_pos+30+20) ){                        // controllo appartenenza alla seconda fila
    for(int i = 0; i < btn_num_ON; i++){
      if ( y > (btnY_pos+i*btnY_dist) && y < (btnY_pos+i*btnY_dist+20) ){
      return i+11;
      }
    }
  }
return -1;
}
                                                                              // DISEGNO AULA E QUOTE
void disegna_banchi(int x0, int y0, int aulaX, int aulaY, int bancoX, int bancoY, int fondo_aula, int spazio_insY, int cattedraX, int cattedraY, int dist_professore){
  int xs = x0;
  int ys = y0 + aulaY - fondo_aula;
  int dist_professore_reale = aulaY - fondo_aula - spazio_insY - numerorighe*interasseY ;
  textSize(10);
  
  fill(180);
  for (int i = 0 ; i < numerofile + 1; i++){                                 // disegno banchi
      for (int ii = 0 ; ii < numerorighe + 1; ii++){
        ellipse(xs + bordo_aula_def, ys - ii*interasseY , 25, 25);           // disegno testa
        // ellipse(xs + bancoX/2, ys - ii*interasseY + bancoY, (int)bancoX/2, (int)bancoY/2);
        // rect(xs, ys - ii*interasseY, bancoX, bancoY);  // bancoX e bancoY
      }
  xs = xs + interasseX;
  }
   
  rect(x0 + aulaX/2 - cattedraX/2 , y0 + spazio_insY, cattedraX, cattedraY); // disegno cattedra
  ellipse(x0 + aulaX/2, y0 + spazio_insY, 25, 25);                           // testa insegnate
  noFill();
  arc(x0 + aulaX/2, y0 + spazio_insY, (dist_professore-12.5)*2, (dist_professore-12.5)*2, 0, 3.14);
  
  fill(255);                                                                 // disegno quote

  text(fondo_aula, x0-15, y0+aulaY-(int)(fondo_aula/2));                     // disegno quote lungo Y
  for (int i = 0 ; i < numerorighe; i++){  
      text(interasseY, x0-15, y0+aulaY-(fondo_aula+bancoY)-interasseY*i);
  }
  text(spazio_insY, x0-15, y0+(int)(spazio_insY/2));
  text(dist_professore_reale, x0-15, (int)(y0+spazio_insY+(dist_professore_reale/2))); 
  
  text(bordo_aula_def, x0+(int)bordo_aula_def/2, y0+aulaY+10);        // disegno quote lungo X
  for (int i = 0 ; i < numerofile; i++){
      //text(bordo_aula_def, x0+(int)(bancoX/2)+i*interasseX, y0+aulaY+10);
      text(interasseX, x0+bordo_aula_def+(int)(interasseX/2)+i*interasseX, y0+aulaY+10);  
  }
  text(bordo_aula_def,(int)(((x0+bordo_aula_def+numerofile*interasseX)+(x0+aulaX))/2), y0+aulaY+10);
  
  fill(0);
  line(x0+bordo_aula_def, y0+aulaY-fondo_aula, x0+bordo_aula_def, y0+aulaY-fondo_aula-interasseY); // linea verticale
  text(interasseY, x0+bordo_aula_def-10, y0+aulaY-fondo_aula-interasseY/2);
  line(x0+bordo_aula_def, y0+aulaY-fondo_aula, x0+bordo_aula_def+interasseX, y0+aulaY-fondo_aula); // linea orizzontale
  text(interasseX, x0+bordo_aula_def+(int)interasseX/2-10, y0+aulaY-fondo_aula-10);
 
}

                                                                                // CALCOLO INTERASSI
void calcolo_interassi(int aulaX, int aulaY, int bancoX, int bancoY, int interX, int interY, int fondo_aula, int bordo_aula, int sp_insegnante){
   //numerofile = (int) ((aulaX - bancoX) / (bancoX + interX)) ; // interasseX
   numerofile = ((aulaX - bordo_aula*2) % interX); // calcola resto divisione per decidere se ridurre la distanza bordo_aula o meno 
   if (numerofile < 80){                           // i bordi aula vengono aumentati del resto /2
       numerofile = (int)((aulaX - bordo_aula*2) / interX);
       bordo_aula_def = ((aulaX-numerofile*interX)/2);
   }
   else if (numerofile >= 80){                     // i bordi aula vengono diminuti di 15cm per poter aggiungere una fila
       numerofile = (int)((aulaX - bordo_aula*2) / interX) +1 ;
       bordo_aula_def = ((aulaX-numerofile*interX)/2);
   }
   // println("numero file: " + str(numerofile));         // righe per debug
   // println("bordo aula: " + str(bordo_aula_def));      // righe per debug
   numerorighe = (int)((aulaY - sp_insegnante - fondo_aula) / interY); // interasseY
   // println("numero righe: " + str(numerorighe));       // righe per debug

   interasseX = interX;                                 // l'interasse non è variabile
   interasseY = interY;                                 // l'interasse non è variabile
}


                                                                           // DISEGNO PULSANTIERA
void disegna_rect(int x, int y, int a, int b, String btn_text){            // disegno tasto con + o -
  fill(255);
  rect(x, y, a, b);
  textSize(15);
  fill(0);
  text(btn_text, x+5, y+15);
}

void disegna_valori(int x, int y, int index){                              // scrittura etichette
  fill(0);
  text(btn_label[index], x+20+35, y+(int)(20/2)+7.5);
  text(str(misure[index]), x+20+3+50+80, y+(int)(20/2)+7.5);
}
