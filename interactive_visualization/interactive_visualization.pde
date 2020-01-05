import java.util.*;

float chart_width;
float chart_height;
float margin_vertical;
float margin_horizontal;
float bar_width_data;
float x_origin;
float y_origin;
float maxdata;
Dataframe dataframe;
PFont Font1;
PFont Font2;
PFont Font3;
PFont Font4;
PFont Font5;
PFont Font6;
PFont Font7;

void setup() {
  size(1000, 600);
  background (255);
  margin_horizontal = 10;
  margin_vertical = 10;
  chart_width = width - 2*(margin_horizontal/100)*width;
  chart_height = height - 2*(margin_vertical/100)*height;
  x_origin=width*(margin_horizontal/100);
  y_origin=height*(margin_vertical/100)+chart_height;

  dataframe = new Dataframe("Projet3.csv");
  dataframe.selected="price";

  Font1 = createFont("Arial Bold", 23);
  Font2 = createFont("Arial Bold", 15);
  Font3 = createFont("Arial", 11);
  Font4 = createFont("Arial Bold", 12);
  Font5 = createFont("Arial Bold", 11.5);
  Font6 = createFont("Arial", 10.5);
  Font7 = createFont("Arial", 12);
}

void draw_titles() {

  //headline
  textFont(Font1);
  fill(40, 40, 40);
  textSize(23);
  textAlign(CENTER);
  text("QUE CACHENT LES PRIX DE L'IMMOBILIER FRANÇAIS ACTUEL ?", 0, 25, width, height);

  //titre partie 1
  textFont(Font2);
  fill(90, 90, 90);
  textSize(15);
  textAlign(CENTER);
  text("Données du premier trimestre 2018 sur l'immobilier des 12 communes les plus peuplées de France", 105, 55, width-200, height);

  //titre partie 2
  textFont(Font3);
  fill(90, 90, 90);
  textSize(11);
  textAlign(CENTER);
  text("(source : INSEE – journaldunet.com, consultés le 24/12/19)", 155, 75, width-310, height);

  //titre axe x partie 1
  textFont(Font7);
  fill(255, 171, 106);
  textSize(11);
  text("Commune", width-5.5*margin_horizontal, height-4*margin_vertical);
  //titre axe x partie 2
  textFont(Font7);
  fill(255, 171, 106);
  textSize(11);
  text("par population", width-5.5*margin_horizontal, height-2.7*margin_vertical);

  //boutons
  fill(255);
  strokeWeight(1);
  fill(150, 150, 150);
  rect(45, 100, 220, 30);
  fill(114, 67, 155);
  rect(275, 100, 220, 30);
  fill(87, 75, 159);
  rect(505, 100, 220, 30);
  fill(67, 103, 151);
  rect(735, 100, 220, 30);

  //titres des boutons
  textFont(Font4);
  fill(255);
  textSize(12.5);
  textAlign(CENTER);

  text("Prix médian du m² au 1er trim 2018", 45, 108, 220, 30);
  text("Nombre de logements totaux", 275, 108, 220, 30);
  text("% Logements vacants", 505, 108, 220, 30);
  text("% Logements secondaires", 735, 108, 220, 30);
}

void draw_histogram() {
  dataframe.set_fill_color();
  ArrayList<Float> data = dataframe.getData();
  maxdata=1.45*Collections.max(data);
  for (int i = 0; i<data.size(); i++) {
    float bar_width=chart_width/data.size();
    bar_width_data=bar_width*(75.0/100);
    strokeWeight(0);
    rect(10+x_origin+i*bar_width, y_origin, bar_width_data, -data.get(i)*(chart_height/maxdata));
    //écriture de la variable à afficher
    textFont(Font4);
    textSize(12);
    textAlign(CENTER);
    if (dataframe.selected=="price" || dataframe.selected=="nblog") {
      text(str(int(data.get(i))), 10+x_origin+i*bar_width, y_origin-data.get(i)*(chart_height/maxdata)-20, bar_width_data, y_origin-data.get(i)*(chart_height/maxdata)-20);
    } else {
      text(str(data.get(i)), 10+x_origin+i*bar_width, y_origin-data.get(i)*(chart_height/maxdata)-20, bar_width_data, y_origin-data.get(i)*(chart_height/maxdata)-20);
    }
  }
}

void mousePressed()
{
  if (mouseX >45 && mouseX<265 && mouseY>100 && mouseY<130)
    //prix médian du m² au T1 2018
  {
    dataframe.selected="price";
  }

  if (mouseX >275 && mouseX<495 && mouseY>100 && mouseY<130)
    //nombre de logements totaux
  {
    dataframe.selected="nblog";
  } 

  if (mouseX >505 && mouseX<725 && mouseY>100 && mouseY<130)
    //% logements vacants
  {
    dataframe.selected="logvac";
  }

  if (mouseX >735 && mouseX<955 && mouseY>100 && mouseY<130)
    //% logements secondaires
  {
    dataframe.selected="logsec";
  }
} 

void draw() {
  background(255);
  draw_titles();
  dataframe.draw_axis_title();
  draw_histogram();

  ArrayList<Float> data = dataframe.getData();
  for (int i = 0; i<data.size(); i++) {
    float bar_width=chart_width/data.size();
    bar_width_data=bar_width*(100.0/100);
    //écriture des noms des communes
    textFont(Font5);
    fill(255, 125, 81);
    textSize(11.5);
    textAlign(CENTER); 
    text(dataframe.names.get(i), 5+x_origin+i*bar_width, y_origin+11, bar_width_data-5, y_origin+10);
    //écriture des prix de l'immobilier
    textFont(Font6);
    fill(150, 150, 150);
    textSize(11.5);
    textAlign(CENTER);
    text(str(int(dataframe.prices.get(i)))+" €/m²", 5+x_origin+i*bar_width, y_origin+29, bar_width_data-5, y_origin+25);

    //axe x
    strokeWeight(1.3);
    stroke(30, 30, 30);
    line(x_origin, y_origin, width-x_origin, y_origin);

    //axe y
    strokeWeight(1.3);
    stroke(30, 30, 30);
    line(x_origin, y_origin, x_origin, height-y_origin+100);
  }
}
