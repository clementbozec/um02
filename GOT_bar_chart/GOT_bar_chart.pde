import java.util.*;

float chart_width;
float chart_height;
float margin_vertical;
float margin_horizontal;
float bar_width_data;
float x_origin;
float y_origin;
ArrayList<Float> data = new ArrayList<Float>();
ArrayList<String> name = new ArrayList<String>();
ArrayList<String> datastring = new ArrayList<String>(Arrays.asList("1.128", "1.420", "1.180", "1.068", "1.018", "1.363", "1.459", "1.454", "1.610", "1.006", "1.100", "1.116", "1.378", "1.139"));
Table table;
float maxdata ;

void setup() {
  size(1000, 600);
  background (255);
  margin_horizontal = 10;
  margin_vertical = 10;
  chart_width = width - 2*(margin_horizontal/100)*width;
  chart_height = height - 2*(margin_vertical/100)*height;
  x_origin=width*(margin_horizontal/100);
  y_origin=height*(margin_vertical/100)+chart_height;

  table = loadTable("GOT.csv", "header");
  println(table.getRowCount() + " total rows in table");
  for (TableRow row : table.rows()) {
    float score = row.getFloat("score");
    String short_name = row.getString("short_name");

    if ((score>1)) {
      data.add(new Float(score));
      name.add(new String(short_name));
    }
  }

  //headline
  fill(103, 113, 121);
  textSize(23);
  textAlign(CENTER);
  text("GAME OF THRONES : QUEL PERSONNAGE EST LE PLUS POPULAIRE ?", 0, 0, width, height);

  //titre
  fill(175, 175, 175);
  textSize(15);
  textAlign(CENTER);
  text("Classement des 14 personnages de Game of Thrones ayant le score de popularité le plus élevé (source : GOT.csv, consulté en octobre 2019)", 155, 33, width-310, height);

  //titre axe x
  fill(127, 127, 127);
  textSize(11);
  text("Personnage", width-7*margin_horizontal, height-4*margin_vertical);

  //titre axe y
  fill(127, 127, 127);
  textSize(11);
  text("Score", margin_horizontal+65, margin_vertical+0.1*height);

  maxdata = 1.10*Collections.max(data);
}

void draw() {
  fill(255);

  for (int i = 0; i<data.size(); i++) {
    float bar_width=chart_width/data.size();
    bar_width_data=bar_width*(90.0/100);
    strokeWeight(0);
    fill(131, 166, 151);
    rect(x_origin+i*bar_width, y_origin, bar_width_data, -data.get(i)*(chart_height/maxdata));
    //écriture des noms des personnages
    stroke(153, 122, 144);
    textSize(10);
    textAlign(CENTER);
    text(name.get(i), x_origin+i*bar_width, y_origin+10, bar_width_data, y_origin+10);
    //écriture du score
    stroke(182, 172, 172);
    textSize(10);
    textAlign(CENTER);
    text(datastring.get(i), x_origin+i*bar_width, y_origin-data.get(i)*(chart_height/maxdata)-20, bar_width_data, y_origin-data.get(i)*(chart_height/maxdata)-20);

  //axe x
  strokeWeight(3);
  stroke(48, 48, 48);
  line(x_origin, y_origin, width-x_origin, y_origin);

  //axe y
  strokeWeight(3);
  stroke(48, 48, 48);
  line(x_origin, y_origin, x_origin, height-y_origin);
  }
}
