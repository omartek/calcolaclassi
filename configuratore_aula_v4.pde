int btnX_pos = 900;        // posizione e dati pulsantiera
int btnY_pos = 20;
int btnY_dist = 30;
int btn_num = 16;          // parametri aula misurabili complessivamente
int btn_num_ON = 16;        // misure visibili modificabili a video dall'utente

int misure_n = btn_num;    // matrici valori e misurazioni
int[] misure = new int[misure_n];
int[] incrementi = new int[misure_n];
int[][] min_max_valori = new int[misure_n][2];
String[] btn_label = new String[btn_num];

int numerofile;            // valori calcolati interassi dalla funzione calcolo_interassi
int numerorighe;
int interasseX;
int interasseY;
int bordo_aula_def;

PShape steel;

void setup() {            // setup valori iniziali                                       
  steel = loadShape("steel_2.svg");
  size(1100, 1000);
                          // parametri aula misurabili
  misure[0] = 480;   // aulaX
  misure[1] = 600;   // aulaY
  misure[2] = 60;    // bancoX
  misure[3] = 40;    // bancoY
  misure[4] = 100;   // interbancoX
  misure[5] = 100;   // interbancoY
  misure[6] = 30;    // distanza fondo aula
  misure[7] = 30;    // distanza bordi aula
  misure[8] = 30;    // spazio-insY dal muro lavagna
  misure[9] = 160;   // cattedraX
  misure[10] = 60;   // cattedraY
  misure[11] = 200;  // distanza asse testa professore/studente
  misure[12] = 0 ;   // posizione cattedra
  misure[13] = 0 ;   // valore passaggio fila più larga
  misure[14] = 1 ;   // banchi aggiuntivi
  misure[15] = 0 ;   // banchi aggiuntivi 
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
  incrementi[12] = 5; // posizione cattedra
  incrementi[13] = 5; // passaggio più largo
  incrementi[14] = 1; // banchi aggiuntivi
  incrementi[15] = 1; // banchi aggiuntivi

                           // valori min e max per le misure
  min_max_valori[0][0] = 200;     // aulaX
  min_max_valori[0][1] = 2000;    // aulaX  
  min_max_valori[1][0] = 200;     // aulaY
  min_max_valori[1][1] = 2000;    // aulaY
  
  min_max_valori[2][0] = 5;      // bancoX
  min_max_valori[2][1] = 200;    // bancoX  
  min_max_valori[3][0] = 5;      // bancoY
  min_max_valori[3][1] = 200;    // bancoY  

  min_max_valori[4][0]= 50;   // interbancoX
  min_max_valori[4][1]= 200;  // interbancoX  
  min_max_valori[5][0]= 50;   // interbancoY
  min_max_valori[5][1]= 200;  // interbancoY
  
  min_max_valori[6][0]= 5;    // distanza fondo aula  
  min_max_valori[6][1]= 200;  // distanza fondo aula
  
  min_max_valori[7][0]= 0;    // distanza bordo aula
  min_max_valori[7][1]= 200;  // distanza bordo aula
  
  min_max_valori[8][0]= 5;    // spazio-insY dal muro lavagna
  min_max_valori[8][1]= 200;  // spazio-insY dal muro lavagna
  
  min_max_valori[9][0]= 5;    // cattedraX
  min_max_valori[9][1]= 200;  // cattedraX
  
  min_max_valori[10][0]= 5;   // cattedraY
  min_max_valori[10][1]= 200; // cattedraY   
  
  min_max_valori[11][0]= 150; // distanza professore
  min_max_valori[11][1]= 300; // distanza professore
  
  min_max_valori[12][0]= -1*(int)(misure[0]-misure[9])/2; // posizione cattedra
  min_max_valori[12][1]= (int)(misure[0]-misure[9])/2;    // posizione cattedra 
  
  min_max_valori[13][0]= 0;   // passaggio più largo
  min_max_valori[13][1]= 200; // passaggio più largo
  
  min_max_valori[14][0]= 0; // riga aggiuntiva
  min_max_valori[14][1]= 2; // riga aggiuntiva 

  min_max_valori[15][0]= 0; // banco rettangolare
  min_max_valori[15][1]= 1; // banco node steel 
  
                           // label pulsanti e valori
  btn_label[0] = "AulaX";
  btn_label[1] = "AulaY";
  btn_label[2] = "BancoX";
  btn_label[3] = "BancoY";
  btn_label[4] = "dist studX";
  btn_label[5] = "dist studY";
  btn_label[6] = "fondo aula";
  btn_label[7] = "bordo aula";
  btn_label[8] = "spazio insY";
  btn_label[9] = "cattedraX";
  btn_label[10] = "cattedraY";
  btn_label[11] = "dist prof";
  btn_label[12] = "pos cattedra";
  btn_label[13] = "fila +larga";
  btn_label[14] = "banchi agg";
  btn_label[15] = "model banco";
} 

void draw() {
background(100);
int x0 = 20; // origine disegno aula
int y0 = 50; // origine disegno aula

 fill(255);
 rect(x0, y0, misure[0], misure[1]);                                      // disegno aula
 carta_millimetrata(x0, y0, misure[0], misure[1]);                        // carta millimetrata
 
 for (int i = 0; i < btn_num_ON; i = i+1) {                               // disegno pulsantiera
    disegna_rect(btnX_pos, btnY_pos + i*btnY_dist, 20, 20,"-");           // pulsante di sinistra
    disegna_rect(btnX_pos + 30, btnY_pos + i*btnY_dist, 20, 20,"+");      // pulsante di destra
    disegna_valori(btnX_pos, btnY_pos + i*btnY_dist, i);                  // scrivi etichette
 }
 
 int sp_insegnante = misure[8] + misure[11];
 calcolo_interassi(misure[0], misure[1], misure[2], misure[3], misure[4], misure[5], misure[6], misure[7], sp_insegnante, misure[13]);                // calcolo interassi
 disegna_banchi(x0, y0, misure[0], misure[1], misure[2], misure[3], misure[6], misure[8], misure[9], misure[10], misure[11], misure[12], misure[13], misure[14], misure[15]); // disegna banchi
//saveFrame("immagine-####.jpg"); 
//shape(steel, 600, 100);

}

void mouseReleased()  {                                                    // CLICK DELLA PULSANTIERA VALORI
  int pulsante;
  int index;
  
  pulsante = verifica_btn(mouseX, mouseY);
  if (pulsante > -1 && pulsante < btn_num_ON){
    index = pulsante;
    if (misure[index] > min_max_valori[index][0]){
    misure[index] = misure[index] - incrementi[index];}
  //println("pulsante "+str(pulsante)+" "+str(misure[pulsante]));
  }
  else if (pulsante > (btn_num_ON-1) && pulsante < (btn_num_ON*2)) {
    index = pulsante - btn_num_ON;
    if (misure[index] < min_max_valori[index][1]){
    misure[index] = misure[index] + incrementi[index];
    //println("pulsante "+str(pulsante)+" "+str(misure[index]));
    }
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
      return i+btn_num_ON;
      }
    }
  }
return -1;
}
                                                                            // DISEGNO AULA E QUOTE
void disegna_banchi(int x0, int y0, int aulaX, int aulaY, int bancoX, int bancoY, int fondo_aula, int spazio_insY, int cattedraX, int cattedraY, int dist_professore, int pos_cattedra, int pass_agg, int banchi_agg, int modello){
  int xs = x0;
  int ys = y0 + aulaY - fondo_aula;
  int dist_professore_reale = aulaY - fondo_aula - spazio_insY - numerorighe*interasseY ;
  int passaggio = 0;
  textSize(10);
  
  fill(180);
  for (int i = 0 ; i < numerofile + 1; i++){                                 // disegno banchi
      for (int ii = 0 ; ii < numerorighe + 1; ii++){
        if (modello==0){                                                       // modello classico
        rect(xs + bordo_aula_def - (int)(bancoX/2), ys - ii*interasseY - bancoY, bancoX, bancoY);  // bancoX e bancoY
        ellipse(xs + bordo_aula_def, ys - ii*interasseY , 25, 25);           // disegno testa
        }
        else if (modello==1){                                                  // modello node steel
        shape(steel, xs + bordo_aula_def - 25, ys - ii*interasseY - bancoY);   // bancoX e bancoY
        //ellipse(xs + bordo_aula_def, ys - ii*interasseY , 50, 50);           // disegno sedia
        //rect(xs + bordo_aula_def - 25, ys - ii*interasseY - bancoY, 50, 25);  // bancoX e bancoY
        }
        
     }
  if (pass_agg > 0 && i == (int)numerofile/2){
      xs = xs + interasseX + pass_agg;
      }
      else  xs = xs + interasseX;
  }
  
  xs = x0;                                                                   // banchi a fianco della cattedra
  for (int i = 0; i < banchi_agg; i++){ 
  for (int ii = 0; ii < (int)numerofile/2; ii++){

    if (dist(xs + bordo_aula_def + ii*interasseX, ys - (numerorighe + 1 + i)*interasseY, x0 + aulaX/2 + pos_cattedra, y0 + spazio_insY) > 225) {
      if (modello==0){
        rect(xs + bordo_aula_def - (int)(bancoX/2) + ii*interasseX, ys - (numerorighe + 1 + i)*interasseY  - bancoY, bancoX, bancoY); 
        ellipse(xs + bordo_aula_def + ii*interasseX, ys - (numerorighe + 1 + i)*interasseY, 25, 25);                 // disegno testa
       }
      else if (modello==1){                                                  // modello node steel
        shape(steel, xs + bordo_aula_def - 25 + ii*interasseX, ys - (numerorighe + 1 + i)*interasseY - bancoY);
        //ellipse(xs + bordo_aula_def  + ii*interasseX, ys - (numerorighe + 1 + i)*interasseY , 50, 50);           // disegno sedia
        //rect(xs + bordo_aula_def - 25 + ii*interasseX, ys - (numerorighe + 1 + i)*interasseY - bancoY, 50, 25);  // bancoX e bancoY
       }  

    }
  }
  }
  
  rect(x0 + aulaX/2 - cattedraX/2 + pos_cattedra, y0 + spazio_insY, cattedraX, cattedraY);  // disegno cattedra
  line(x0 + aulaX/2 + pos_cattedra, y0 + spazio_insY, x0 + aulaX/2 + pos_cattedra, y0 + spazio_insY+(dist_professore+12.5));
  ellipse(x0 + aulaX/2 + pos_cattedra, y0 + spazio_insY, 25, 25);                           // testa insegnate
//  disegna_freccia(x0 + aulaX/2, y0 + spazio_insY+12.5, PI);                               // freccia quota distanza professore
//  disegna_freccia(x0 + aulaX/2, y0 + spazio_insY+dist_professore-12.5, 0);
  fill(0);
  text((int)dist_professore, x0 + (int)aulaX/2+10 + pos_cattedra, y0 + spazio_insY+(int)((dist_professore+25)/2));
  noFill();
  arc(x0 + aulaX/2 + pos_cattedra, y0 + spazio_insY, (dist_professore+12.5)*2, (dist_professore+12.5)*2, 0, 3.14);

  rect(x0 + aulaX, y0 + 100-5, 90, 5);                         // disegna porta ingresso
  arc(x0 + aulaX, y0 + 100, 180, 180, 0, 3.14/2);
  
                                                                             // disegno quote
  text(fondo_aula, x0-15, y0+aulaY-(int)(fondo_aula/2));                     // disegno quote lungo Y
  for (int i = 0 ; i < numerorighe; i++){
       text(interasseY, x0-15, y0+aulaY-(fondo_aula+bancoY)-interasseY*i);
  }
  text(spazio_insY, x0-15, y0+(int)(spazio_insY/2));
  text(dist_professore_reale, x0-15, (int)(y0+spazio_insY+(dist_professore_reale/2)));
  
  xs = 0;
  passaggio = 0;
  translate(x0+(int)bordo_aula_def/2, y0+aulaY+10);
  //text(bordo_aula_def, x0+(int)bordo_aula_def/2, y0+aulaY+10);             // disegno quote lungo X
  text(bordo_aula_def, 0, 0);
  xs = bordo_aula_def/2 + interasseX/2;
  for (int i = 0 ; i < numerofile; i++){
      //text(bordo_aula_def, x0+(int)(bancoX/2)+i*interasseX, y0+aulaY+10);
      text(interasseX + passaggio*pass_agg, xs, 0);
      if (pass_agg > 0 && i == (int)numerofile/2-1){
      xs = xs + interasseX + pass_agg/2;
      passaggio = 1;
      }
      else if (pass_agg > 0 && i == (int)numerofile/2){
      xs = xs + interasseX + pass_agg/2;
      passaggio = 0;
      }
      else  {
      xs = xs + interasseX;
      passaggio = 0;
      }
  }
  
  translate(-1*(x0+(int)bordo_aula_def/2), -1*(y0+aulaY+10));
  text(bordo_aula_def,(int)(x0+aulaX-bordo_aula_def/2), y0+aulaY+10);
  /*
  for (int i = 0 ; i < numerofile; i++){
      //text(bordo_aula_def, x0+(int)(bancoX/2)+i*interasseX, y0+aulaY+10);
      if (pass_agg > 0 && i == (int)numerofile/2) passaggio=1;
       else passaggio=0;
      text(interasseX + passaggio*pass_agg, x0+bordo_aula_def+(int)(interasseX/2)+i*interasseX, y0+aulaY+10);  
  }
  text(bordo_aula_def,(int)(((x0+bordo_aula_def+numerofile*interasseX)+(x0+aulaX))/2), y0+aulaY+10);
  */
  
  fill(0);
  line(x0+bordo_aula_def, y0+aulaY-fondo_aula, x0+bordo_aula_def, y0+aulaY-fondo_aula-interasseY); // linea verticale
  text(interasseY, x0+bordo_aula_def-10, y0+aulaY-fondo_aula-interasseY/2);
  line(x0+bordo_aula_def, y0+aulaY-fondo_aula, x0+bordo_aula_def+interasseX, y0+aulaY-fondo_aula); // linea orizzontale
  text(interasseX, x0+bordo_aula_def+(int)interasseX/2-10, y0+aulaY-fondo_aula-10);
 
}

                                                                                // CALCOLO INTERASSI
void calcolo_interassi(int aulaX, int aulaY, int bancoX, int bancoY, int interX, int interY, int fondo_aula, int bordo_aula, int sp_insegnante, int pass_agg){
   //numerofile = (int) ((aulaX - bancoX) / (bancoX + interX)) ; // interasseX
   numerofile = ((aulaX - pass_agg - bordo_aula*2) % interX); // calcola resto divisione per decidere se ridurre la distanza bordo_aula o meno 
   if (numerofile < 80){                           // i bordi aula vengono aumentati del resto /2
       numerofile = (int)((aulaX - pass_agg - bordo_aula*2) / interX);
       bordo_aula_def = ((aulaX-pass_agg-numerofile*interX)/2);
   }
   else if (numerofile >= 80){                     // i bordi aula vengono diminuti di 10cm per poter aggiungere una fila
       numerofile = (int)((aulaX - pass_agg - bordo_aula*2) / interX) +1 ;
       bordo_aula_def = ((aulaX-pass_agg-numerofile*interX)/2);
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

/*
void crea_Shape(){
  freccia = createShape();
  freccia.beginShape();
  freccia.fill(125);
  freccia.noStroke();
  freccia.vertex(0, 0);
  freccia.vertex(-5, -8);
  freccia.vertex(5, -8);
  freccia.endShape(CLOSE);
}

void disegna_freccia(float posx, float posy, float rotazione){
  translate(posx, posy);
  rotate(rotazione);
  shape(freccia,0,0);
  rotate(-rotazione);
  translate(-posx,-posy);

}
*/

void carta_millimetrata(int x0, int y0, int aulaX, int aulaY){
  for (int i = 0 ; i < aulaX; i = i + 10){
    stroke(200);
    line(x0 + i, y0, x0 + i, y0 + aulaY);
  }
  for (int i = 0 ; i < aulaY; i = i + 10){
    stroke(200);
    line(x0, y0 + i, x0 + aulaX, y0 + i);
  }
stroke(0);
}
