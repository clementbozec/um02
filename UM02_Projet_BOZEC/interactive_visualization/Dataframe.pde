class Dataframe {

  ArrayList<Float> prices = new ArrayList<Float>();
  ArrayList<Float> nblogs = new ArrayList<Float>();
  ArrayList<Float> logvacs = new ArrayList<Float>();
  ArrayList<Float> logsecs = new ArrayList<Float>();
  ArrayList<String> names = new ArrayList<String>();

  String selected;

  Dataframe(String filename) {
    Table table = loadTable(filename, "header");
    for (TableRow row : table.rows()) {
      float price = row.getFloat("Prix");
      float nblog = (row.getFloat("NbLog"))/1000;
      float logvac = row.getFloat("LogVac");
      float logsec = row.getFloat("LogSec");
      String name = row.getString("Commune");
      prices.add(price);
      nblogs.add(nblog);
      logvacs.add(logvac);
      logsecs.add(logsec);
      names.add(name);
    }
    selected="price";
    println(prices);
    selected="nblog";
    println(nblogs);
    selected="logvac";
    println(logvacs);
    selected="logsec";
    println(logsecs);
    selected="name";
    println(names);
  }

  ArrayList<Float> getData() {
    switch(selected) {
    case "price":
      return prices;
    case "nblog":
      return nblogs;
    case "logvac":
      return logvacs;
    case "logsec":
      return logsecs;
    default:
      return prices;
    }
  }
  void set_fill_color() {
    switch(selected) {
    case "price":
      fill(150, 150, 150);
      break;
    case "nblog":
      fill(114, 67, 155);
      break;
    case "logvac":
      fill(87, 75, 159);
      break;
    case "logsec":
      fill(67, 103, 151);
      break;
    default:
      fill(150, 150, 150);
      break;
    }
  }

  void draw_axis_title() {
    //axe y title
    switch(selected) {
    case "price":
      textFont(Font7);
      fill(150, 150, 150);
      textSize(12);
      pushMatrix();
      rotate(-HALF_PI);
      text("Prix médian de l'immobilier", margin_horizontal-260, margin_vertical+0.11*height);
      text("au 1er trim 2018 (€/m²)", margin_horizontal-260, margin_vertical+0.135*height);
      popMatrix();
      break;
    case "nblog":
      textFont(Font7);
      fill(114, 67, 155);
      textSize(12);
      pushMatrix();
      rotate(-HALF_PI);
      text("Nombre total de logements", margin_horizontal-260, margin_vertical+0.11*height);
      text("(en milliers)", margin_horizontal-260, margin_vertical+0.135*height);
      popMatrix();
      break;
    case "logvac":
      textFont(Font7);
      fill(87, 75, 159);
      textSize(12);
      pushMatrix();
      rotate(-HALF_PI);
      text("Logements vacants (%)", margin_horizontal-260, margin_vertical+0.125*height);
      popMatrix();
      break;
    case "logsec":
      textFont(Font7);
      fill(67, 103, 151);
      textSize(12);
      pushMatrix();
      rotate(-HALF_PI);
      text("Logements secondaires (%)", margin_horizontal-260, margin_vertical+0.125*height);
      popMatrix();
      break;
    default:
      textFont(Font7);
      fill(150, 150, 150);
      textSize(12);
      pushMatrix();
      rotate(-HALF_PI);
      text("Prix médian de l'immobilier", margin_horizontal-260, margin_vertical+0.11*height);
      text("au 1er trim 2018 (€/m²)", margin_horizontal-260, margin_vertical+0.135*height);
      popMatrix();
      break;
    }
  }
}
