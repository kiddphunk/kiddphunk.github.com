/////////////////////////////////////
//
// DISCLAIMER: this will not run for anyone because it is highly
// dependant on the local data files and the perl scripts used
// to generate them from del.icio.us data.
//
// I am only releasing the code in case someone was curious about
// something in the processing code.
//
// But really- it's just arcs.
//
// That said, this code grew organically, there are some classes somewhere
// and this is a huge file and ymmv...
//
// Cheers, kiddphunk
//
/////////////////////////////////////

import proxml.*;

/////////////////////////////////////

boolean showOutlyers   = false;   // mark esp. popular urls
boolean useGradient    = true;    // gradient the blue part?
boolean sortByScore    = false;   // sorts columns by raw score
boolean sortByCount    = true;    // sorts columns by raw count
boolean parityTop      = false;   // red on top (versus grey)
boolean connectDots    = true;    // draw connecting items
boolean showAllLines   = false;   // include grey lines in connections
boolean limitColumns   = false;   // limit column number to maxColumns
boolean useArcs        = false;   // arcs, not lines, when arranged on same x-axis
boolean noTextBg       = false;   // no white background behind text
boolean justName       = false;   // just render the username
boolean memOptimize    = true;    // optimize memory usage (somewhat less accurate)
boolean arcsAreSemis   = true;    // if arcs should have height based on color or just semi-circles
boolean plotGrey       = true;    // show grey lines
boolean plotOrange     = true;    // show orange lines
boolean plotRed        = true;    // show red lines
boolean plotOrangeGrey = false;   // plot orange lines grey
boolean plotRedGrey    = false;   // plot red lines grey
boolean leftToRight    = true;    // plot user->tail left->right
boolean alignTop       = true;    // top-flush (vs bottom-flush)
boolean autopilot      = false;   // run through all tests
boolean justMainConns  = false;   // show only connections between top-level users
boolean secondaryConns = false;   // show first and secondary connections
boolean justArcs       = false;   // just plot arcs
boolean arcs2parent    = false;   // connect pairs of top-level users at users node, not other node
boolean arcAtBottom    = false;   // flip chart representation
boolean printTops      = false;   // just print out a list of all the top scores
boolean imagesTop      = false;   // tagline at top
boolean noNames        = false;   // no usernames at all
boolean showOverlapped = false;   // overlapping R,O,G amounts in arc
boolean funkyAllSelf   = false;   // render arcs of user to matches with all of selfs links (vs amount for that user)
boolean funkyPlotAll   = false;   // in funky mode, render all data arcs for user overlayed (R, O, G)
boolean funkyWidths    = false;   // renders with different line widths
boolean arcRenderL2R   = true;    // define arc relationship as L->R (for widths, etc)
boolean freeMemory     = false;   // jettison arrays after rendering, forces non-interactive
boolean justConnPairs  = false;   // just connect pairs of people, rather than whole circle
boolean flipEvenOthers = false;   // flip left->right sort parity on even nodes
int     numPrintTops   = 20;      // number of top matches to print
int     sortSpicyness  = 1;       // method for sort, 0=classic sort (10/100/500/+) / 1=nu sort (R/O/B/G) / 2=OR sort (mild R/O) / 3=OR sort (spicy R/O)
int     supressInfo    = 0;       // don't show mouse-over info 1==true, 0==false
int     textOffsetY    = 0;       // y-adjustment for text placement
int     textOffsetX    = 0;       // x-adjustment for text placement
int     infoOffsetY    = 15;      // y-adjustment for info text placement
int     infoOffsetX    = 0;       // x-adjustment for info text placement
int     lineOpacity    = 200;     // duh
int     maxColumns     = 20;

/////////////////////////////////////

int     textBackWidth  = 1000;
int 	squareSize     = 4;
int 	spacingSize    = squareSize;        

color colorGreyRed, colorRed, colorGreyOrange, colorOrange, colorGrey, colorName;

int     minForGrey     = 1020;    // min grey threshold
int     minForRed      = 3;       // min red threshold
int     minForOrange   = 20;      // min orange threshold
int     minEquals      = 5;       // only show users with at least this many urls in common
int     maxURLs        = 100;     // max number of urls to process for user

/////////////////////////////////////

int     mainXoff       = 15;
int     connectsLeft   = 3;
String  lastHighlight  = "";
String  caseName       = "";
boolean doneCycle      = true;
boolean rendering      = true;
boolean imageDone      = false;
boolean linesDone      = false;
boolean totallyDone    = false;

/////////////////////////////////////

HashMap toplevelNames  = new HashMap();
XMLInOut xmlInOut      = null;
ArrayList allGraphs    = new ArrayList();

PFont fontA, fontB, fontC;

/////////////////////////////////////

// memory profiling
public static int OBJCC;
public static int OBJDC;
{ 
  OBJCC++; 
} 

public static int OBJCM;
public static int OBJDM;
{ 
  OBJCM++; 
} 

int numPut = 0;

void printMemStats() {
  System.gc();
  System.out.println("column: created "+OBJCC+" finalized "+OBJDC+" "+numPut);
  System.out.println("module: created "+OBJCM+" finalized "+OBJDM);
}

/////////////////////////////////////

ArrayList setTypes     = new ArrayList();
String testUser        = "kiddphunk";
int currx              = mainXoff;
int curry              = 150;
int offx               = 150;
int offy               = 150;
int testLimit          = 1;
int testCount          = 0;

/////////////////////////////////////

//void mouseReleased() { saveit(); }

/////////////////////////////////////
/////////////////////////////////////

Integer     currSetType    = new Integer(100);        // what are we rendering?

/////////////////////////////////////
/////////////////////////////////////


void setupTestCases() {
  autopilot = true;
  setTypes.add("1000");
  
/*  
  setTypes.add("112");
  setTypes.add("113");
  setTypes.add("5");
  setTypes.add("6");
  setTypes.add("7");
  setTypes.add("8");
  setTypes.add("9");
  setTypes.add("91");
  setTypes.add("92");
  setTypes.add("30");
  setTypes.add("31");
  setTypes.add("32");
  setTypes.add("33");
  setTypes.add("35");
  setTypes.add("36");
  setTypes.add("37");
  setTypes.add("38");
  setTypes.add("39");
  setTypes.add("40");
  setTypes.add("41");
  setTypes.add("51");
*/
  currSetType = new Integer(setTypes.get(testCount).toString());
}


void setup() {
  setupTestCases();
  int v = currSetType.intValue();
  switch (v) {
  case 100:      
    size(1675*2, 1675*2); //1500
    break;

  default:
    size(1675, 1675); //1500
    break;
  }
  background(255);
  smooth();

  PImage a = loadImage("logo_bw.jpg");
  PImage b = loadImage("tagline3.jpg");

  fontA = loadFont("GillSans.vlw");
  fontC = fontB = fontA;

  if (imagesTop) {
    image(a, 10, 10);
    image(b, 1382, 6);
  } 
  else {
    image(a, 10, 1622);
    image(b, 1382, 1620);
  }

  // general defaults
  if (!limitColumns) {
    maxColumns = 5000;
  }
  caseName = "";
  maxURLs = 10;

  // set the rendering prefs
  // add graphs in the order that you want the dots to be connected
  switch (v) {
  case 1000:
      maxURLs = 500;
      sortSpicyness = 2;
      printTops = true;
      numPrintTops = 25;
      maxColumns = 100;
      sortByScore = false;
      minForGrey = 1000;
      minForRed = 5;
      minForOrange = 25;
      break;  
  default:
    setDefaults();
    setAllArcsDefaults();
    setStandardArcs();
    if (!((10 <= v) && (v <=23)) && v!=112 && v!=113) {
      setAllArcsVarSet1(false);
    }
    setFlattenBlueToGrey();
    setDefaultLineColors();

    sortByScore   = true;
    maxURLs       = 1000; // do NOT change - dependencies below
    maxColumns    = 40;   // do NOT change - dependencies below
    sortSpicyness = 2; //3
    setROG(20, 100, 100);
//    setROG(10, 50, 4000);
    break;      
  }

  // pass two
  switch (currSetType.intValue()) {
    case 1001:
      sortByScore = false;
      break;
  case 10:
  case 11:
  case 112:
  case 113:
  case 12:
  case 13:
  case 14:
  case 15:
  case 16:
  case 17:
  case 18:
  case 19:
  case 20:
  case 21:
  case 22:
  case 23:
  //  funkyWidths = true;
    maxURLs = 2000;
    setROG(3, 20, 1000);
    curry += 250;
    textOffsetX += 100;
    textOffsetY -= 400;
    break;

  case 5:
    setROG(10, -1, 10);
    currx += 50;
    break;

  case 51:      
  case 52:      
    setROG(10, -1, 10);
    break;

  case 6:
    setROG(50, 20, 20);
    currx += 50;
    break;

  case 7:
  case 70:
  case 71:
  case 72:
  case 73:
  case 74:
  case 75:
  case 8:
  case 9:
  case 91:
  case 92:
  case 101:
  case 100:
    setPurpleColorationStyle();
    maxURLs       = 1000;
    setROG(50, 500, 5000);
    noNames       = true;
    currx += 50;
    break;

  case 30:
    maxColumns = 50;
    maxURLs       = 2000;
    setROG(5, 50, 1000);
    currx += 50;
    break;

  case 31:
    maxColumns = 50;
    maxURLs       = 2000;
    setROG(3, 20, 1000);
    currx += 50;
    break;

  case 32:
  case 33:
    maxURLs       = 2000;
    setROG(3, 20, 1000000);
    break;

  case 35:
  case 36:
    maxColumns = 50;
    maxURLs       = 2000;
    setROG(3, 20, 1000);
    currx += 50;
    break;

  case 37:
    maxURLs       = 2000;
    setROG(5, 50, 51);
    currx += 50;
    break;

  case 38:
  case 39:
  case 40:
  case 41:
    maxURLs       = 2000;
    setROG(3, 20, 100);
    currx += 50;
    break;
  }
  
  // pass three
  switch (v) {
  case 10:
    maxColumns = 73;
    sortByScore = false;
    break;
    
  case 11: 
  case 112: 
  case 113: 
    if (v == 112) {
      sortSpicyness = 3;
    }
    if (v == 113) {
      sortSpicyness = 4;
    }
    maxColumns = 73;
    sortByScore = true;
    break;
    
  case 12:
  case 13:
  case 14:
  case 15:
    sortByScore = false;
    maxColumns = 400;
    break;
    
  case 16:
  case 17:
  case 18:
  case 19:
    maxColumns = 200;
    sortByScore = true;
    break;
    
  case 20:
  case 21:
  case 22:
  case 23:
    maxColumns = 200;
    sortByScore = false;  
    break;
      
  case 7:
  case 70:
  case 71:  
  case 72:  
  case 73:  
  case 74:  
  case 75:  
  case 101:
  case 100:
    maxURLs       = 2000;
    sortSpicyness = 2;
    //    setJustMainConns();  
    setGreyNameAtTop();
    setGreyBackground();
    currx -= 15; 
    break;  

  case 8:      
    maxURLs       = 2000;
    sortSpicyness = 2;
    setPurpleColorationStyle2();
    setGreyNameAtTop();
    setJustMainConns();  
    break;      

  case 51:      
  case 52:      
    maxURLs       = 2000;
    maxColumns *= 2;
    offx = round(maxColumns*squareSize*1.5);
    break;      

  case 9:      
  case 91:      
  case 92:      
  case 33:
    maxURLs       = 2000;
    sortSpicyness = 2;
    setPurpleColorationStyle2();
    setGreyNameAtTop();
    setGreyBackground();
    if (v == 91) {
      justConnPairs = true;
      setJustMainConns();  
    } else if (v == 92) {
      justConnPairs = true;
      setSecondaryConns();    
    }
    currx -= 25;     
    break;    

  case 35:
    setSecondaryConns();    
    break;      

  case 36:
    setJustMainConns();  
    break;      

  case 38:
    sortSpicyness = 1;
    break;      

  case 39:
    sortSpicyness = 2;
    break;      

  case 40:
    sortSpicyness = 3;
    break;      

  case 41:
    sortSpicyness = 4;
    break;      
  }

  // pass four
  switch (v) {
  case 5:      
  case 51:      
  case 52:      
    offx = round(maxColumns*squareSize*1.25);
    String[] users45 = {
      "kiddphunk", "quarket", "angusf", "transultimate"           };
    setUserGroup1(users45);
    break;      

  case 30: 
    plotOrangeGrey = false;
    offx = round(maxColumns*squareSize*1.25);
    String[] users30 = {
      "kiddphunk", "quarket", "aum", "answerguru"           };
    setUserGroup1(users30);
    break;      

  case 10:
  case 11:
  case 112: 
  case 113: 
    plotOrangeGrey = false;
    offx = round((maxColumns+2)*squareSize);
    String[] users10 = {
      "angusf", "kiddphunk", "transultimate", "REAS", "quarket"           };
    setUserGroup1(users10);
    break;      
    
  case 31: 
  case 35:
  case 36:
  case 37:
  case 38:
  case 39:
  case 40:
  case 41:
    plotOrangeGrey = false;
    offx = round(maxColumns*squareSize*1.25);
    String[] users31 = {
      "kiddphunk", "quarket", "aum", "answerguru", "angusf"           };
    setUserGroup1(users31);
    break;      

  case 12:
    plotOrangeGrey = false;
    offx = round((maxColumns+2)*squareSize);
    String[] users12 = {
      "kiddphunk"            };
    setUserGroup1(users12);
    break;

  case 1000:
     do1000("korbinian");
    break;

    case 13:
    plotOrangeGrey = false;
    offx = round((maxColumns+2)*squareSize);
    String[] users13 = {
      "angusf"            };
    setUserGroup1(users13);
    break;
    
  case 14:
    plotOrangeGrey = false;
    minEquals = 1;
    offx = round((maxColumns+2)*squareSize);
    String[] users14 = {
      "quarket"            };
    setUserGroup1(users14);
    break;
  
  case 15:
    plotOrangeGrey = false;
    offx = round((maxColumns+2)*squareSize);
    String[] users15 = {
      "transultimate"            };
    setUserGroup1(users15);
    break;

  case 16: 
  case 20: 
    plotOrangeGrey = false;
    offx = round((maxColumns+2)*squareSize);
    String[] users16 = {
      "kiddphunk", "quarket"            };
    setUserGroup1(users16);
    break;

  case 17: 
  case 21: 
    plotOrangeGrey = false;
    offx = round((maxColumns+2)*squareSize);
    String[] users17 = {
      "kiddphunk", "transultimate"            };
    setUserGroup1(users17);
    break;

  case 18: 
  case 22: 
    plotOrangeGrey = false;
    offx = round((maxColumns+2)*squareSize);
    String[] users18 = {
      "kiddphunk", "REAS"            };
    setUserGroup1(users18);
    break;

  case 19: 
  case 23: 
    plotOrangeGrey = false;
    offx = round((maxColumns+2)*squareSize);
    String[] users19 = {
      "kiddphunk", "angusf"            };
    setUserGroup1(users19);
    break;

  case 24: 
    plotOrangeGrey = false;
    offx = round((maxColumns+2)*squareSize);
    String[] users24 = {
      "kiddphunk", "quarket", "aum", "answerguru", "256greys", "angusf", "transultimate", "REAS"            };
    setUserGroup1(users24);
    break;

  case 32:
  case 33:
    justConnPairs = true;
    currx -= 110; 
    offx = round(maxColumns*squareSize*1.25);
    String[] users32 = {
      "kiddphunk", "quarket", "aum", "answerguru", "256greys", "angusf", "transultimate", "REAS"            };
    setUserGroup1(users32);
    break;      

  case 6:      
  case 7:      
  case 8:      
  case 9:     
  case 91:      
  case 92:      
  case 34:
  case 70:
    currx -= 110; 
    if (v == 7) {
      currx -= 15;
    }
    offx = round(maxColumns*squareSize*1.25);
    String[] users6 = {
      "kiddphunk", "quarket", "aum", "answerguru", "256greys", "angusf", "transultimate", "REAS"            };
    setUserGroup1(users6);
    break;      

  case 101: 
    currx -= 110; 
    maxURLs = 1000;
    maxColumns *= 4;
    flipEvenOthers = true;
    leftToRight = false;
    offx = round(maxColumns*squareSize*1.25);
    String[] users101 = {
      "kiddphunk", "kiddphunk"            };
    setUserGroup1(users101);
    break;

  case 100: 
    currx -= 110; 
    //    curry *= 2;
    offx = round(maxColumns*squareSize*1.25);
    maxURLs = 100;
    textOffsetY = 20;//-1675;
    infoOffsetX -= 1675;
    setJustMainConns();  
    String[] users100 = {
      "kiddphunk", "quarket", "aum", "answerguru", "256greys", "angusf", "transultimate", "REAS"            };
    /*
            "kiddphunk", "quarket", "aum", "answerguru", "256greys", "angusf", "transultimate", "REAS",
     "REAS", "transultimate", "angusf", "256greys", "answerguru", "aum", "quarket", "kiddphunk"        };
     */
    setUserGroup1(users100);
    break;      

  case 71:
    //    maxURLs = 1000;
    currx -= 110; 
    maxColumns *= 2;
    offx = round(maxColumns*squareSize*1.25);
    String[] users2 = {
      "kiddphunk", "quarket", "transultimate", "REAS"            };
    setUserGroup1(users2);
    break;

  case 72:
    currx -= 110; 
    maxColumns *= 4;
    offx = round(maxColumns*squareSize*1.25);
    String[] users3 = {
      "kiddphunk", "quarket"            };
    setUserGroup1(users3);
    break;

  case 73:
    currx -= 110; 
    maxColumns *= 4;
    offx = round(maxColumns*squareSize*1.25);
    String[] users4 = {
      "kiddphunk", "transultimate"            };
    setUserGroup1(users4);
    break;

  case 74:
    currx -= 110; 
    maxColumns *= 4;
    offx = round(maxColumns*squareSize*1.25);
    String[] users5 = {
      "kiddphunk", "REAS"            };
    setUserGroup1(users5);
    break;

  case 75:
    maxURLs = 200;
    currx -= 110; 
    maxColumns *= 1.5;
    offx = round(maxColumns*squareSize*1.25);
    String[] users75 = {
      "quarket", "kiddphunk", "transultimate"          };
    setUserGroup1(users75);
    break;
  }    
}

void do1000(String username) {
    String[] users1000 = { username };
    sortByScore = false;
    setUserGroup1(users1000);
    sortSpicyness = 2; 
    sortByScore = true;
    setUserGroup1(users1000);   
    sortSpicyness = 4; 
    setUserGroup1(users1000);    
}

void setROG(int r, int o, int g) {
    minForOrange  = o;
    minForGrey    = g;
    minForRed     = r;
}
void setDefaults() {
  caseName = ""+currSetType;
}
void setJustMainConns() {
  justMainConns = true; 
}
void setSecondaryConns() {
  secondaryConns = true; 
}
void setUserGroup1(String users[]) {
  for (int i=0; i<users.length; i++) {
    allGraphs.add(initUserGraph(users[i], currx, curry, 3)); 
    curry+=offy;  
    currx+=offx;
  }
}
void setGreyBackground() {
  background(240);
  PImage a = loadImage("logo_bw.jpg");
  PImage b = loadImage("tagline3.jpg");

  stroke(255);
  fill(255);
  rect(0, 0, width, 55);
  rect(0, height-55, width, 55);

  infoOffsetY = 77;

  if (imagesTop) {
    image(a, 10, 10);
    image(b, 1382, 8);
  } 
  else {
    image(a, 10, 1622);
    image(b, 1382, 1620);
  }
}
void setPurpleColorationStyle() {       
  plotOrangeGrey = true;
  plotRedGrey = false;
  colorRed = color(255, 255, 255, (funkyWidths) ? round(.80*255): lineOpacity);
  colorGreyRed = color(255, 255, 255, (funkyWidths) ? round(.80*255): lineOpacity);
  colorGreyOrange = color(70, 55, 139, (funkyWidths) ? round(.40*255): lineOpacity);         
  colorGrey = color(131, 55, 139, (funkyWidths) ? round(.20*255): lineOpacity);
}
void setPurpleColorationStyle2() {       
  plotOrangeGrey = true;
  plotRedGrey = false;
  colorRed = color(220, 220, 255, (funkyWidths) ? round(100*255): lineOpacity);
  colorGreyRed = color(255, 255, 255, (funkyWidths) ? round(100*255): lineOpacity);
  colorGreyOrange = color(70, 55, 139, (funkyWidths) ? round(100*255): lineOpacity);         
//  colorGrey = color(240, 240, 240, (funkyWidths) ? round(.50*255): lineOpacity);
  colorGrey = color(220, 220, 220, (funkyWidths) ? round(.50*255): lineOpacity);
}
void setGreyNameAtTop() {
  noNames = false;
  textOffsetY = -788;
  colorName = color(230, 230, 230);
}
void setDefaultLineColors() {
  if (justArcs) {
    colorRed = color(255, 0, 0, (funkyWidths) ? round(.80*255): lineOpacity);
    colorGreyRed = color(200, 128, 128, (funkyWidths) ? round(.80*255): lineOpacity);
    colorOrange = color(255, 205, 50, (funkyWidths) ? round(.40*255): lineOpacity);
    colorGreyOrange = color(180, 180, 180, (funkyWidths) ? round(.40*255): lineOpacity);         
    colorGrey = color(210, 210, 210, (funkyWidths) ? round(.20*255): lineOpacity);
    colorName = color(140, 70, 70);
  } 
  else {
    colorRed = color(255, 0, 0, (funkyWidths) ? round(.40*255): lineOpacity);
    colorGreyRed = color(200, 128, 128, (funkyWidths) ? round(.40*255): lineOpacity);
    colorOrange = color(255, 205, 50, (funkyWidths) ? round(.40*255): lineOpacity);
    colorGreyOrange = color(210, 210, 210, (funkyWidths) ? round(.40*255): lineOpacity);         
    colorGrey = color(210, 210, 210, (funkyWidths) ? round(.40*255): lineOpacity);
    colorName = color(0, 0, 255);
  }
}
void setAllArcsDefaults() {
  limitColumns = true;
  showAllLines = true;
  connectDots = true;
  useArcs = true;
  arcsAreSemis = true;
  parityTop = true;
  justName = true;
  noTextBg = true;
  supressInfo = 1;
  freeMemory = true;
  curry = round(height/2);
  offx = 300;
  offy = 0;
}
void setStandardArcs() {
  arcAtBottom = true;
  if (arcAtBottom) {
    plotOrangeGrey = true;
    curry = 550;
    textOffsetY = 100;
    offx = 305;
  } 
}
void setTopHalfGraph() {
  textOffsetY = -120;
  textOffsetX = 30;
  funkyWidths = true;
  justArcs = false;
  funkyPlotAll = true;
}
void setAllArcsVarSet1(boolean plotSelf) {
  funkyWidths = true;
  justArcs = true;
  funkyAllSelf = plotSelf;
  maxColumns = 50;
  plotOrangeGrey = false;
  minForOrange = 50;
  minForRed = 5;
  funkyPlotAll = true;
  sortByScore = true;
  textOffsetY = 20;
  textOffsetX = 0;
  offx = round(maxColumns*squareSize*1.5);
  curry = round(height/2);
  currx += 128; 
}
void setFlattenBlueToGrey() {
  minForGrey = minForOrange+2;
}


void printStats() {
  fill(230, 230, 230);    
  textFont(fontC, 16);	
  String outString = "";
  outString += " creative commons (cc) 2006 / ian timourian * kiddphunk.com";                      
  outString += "  // maxUrls:"+maxURLs;
  outString += " maxColumns:"+maxColumns;
  if (!caseName.equals("")) {                  
    outString += " case:"+caseName;
  }
  outString += " / minR:"+minForRed;
  outString += " minO:"+minForOrange;
  outString += " minG:"+minForGrey;
  outString += " sort:"+sortSpicyness;
  outString += " / sbc:"+((sortByCount)?"y":"n");
  outString += " pt:"+((parityTop)?"y":"n");
  outString += " cd:"+((connectDots)?"y":"n");
  outString += " sal:"+((showAllLines)?"y":"n");
  outString += " / pg:"+((plotGrey)?"y":"n");
  outString += " po:"+((plotOrange)?"y":"n");
  outString += " pr:"+((plotRed)?"y":"n");
  outString += " pog:"+((plotOrangeGrey)?"y":"n");   
  outString += " //";   
  smooth();
  rotate(PI/2);    
  text(outString, infoOffsetY, -1652+infoOffsetX);  
  rotate(-PI/2);

  for (int i=allGraphs.size()-1; i>=0; i--) { 
    ((DeliciousGraph)allGraphs.get(i)).renderText(-2);
  }
  noSmooth();
}


void saveit() {
  println("saving file");
  try {
    saveFrame(caseName+"_"+connectsLeft+"_"+random(0, 255)+"graph-####.tif"); 
  } 
  catch (Exception e) {
    println("got exception when saving file "+e.toString()); 
  }
  println("save complete");
}


void doTheConnections(int level) {
  System.gc();

  int oldsupress = supressInfo;
  supressInfo = 1;

  for (int i=0; i<allGraphs.size()-1; i++) {
    connectTheDots((DeliciousGraph)allGraphs.get(i), (DeliciousGraph)allGraphs.get(i+1), level);
  }

  // do the remaining bits (optional)
  connectRecurse(0, allGraphs.size()-1, level);      
  supressInfo = oldsupress; 
}

void connectRecurse(int mystart, int myend, int level) {
  if (mystart < myend-1) {
    for (int i=mystart; i<myend-1; i++) {
      connectTheDots((DeliciousGraph)allGraphs.get((justConnPairs) ? i : mystart), (DeliciousGraph)allGraphs.get(i+2), level);
    }
    connectRecurse(mystart+1, myend, level); 
  }
}


DeliciousGraph initUserGraph(String username, int xoff, int yoff, int minEq) {
  System.gc();
  DeliciousGraph graph = new DeliciousGraph(username, minEq, maxURLs, this, xoff, yoff);
  toplevelNames.put("/"+username, graph);
  return graph.initGraph();  
}


void draw() {
  if (totallyDone) { 
    return; 
  }

  if (!rendering && !autopilot) {
    String lastUser = "";
    boolean found = false;
    for (int i=allGraphs.size()-1; i>=0 && !found; i--) { 
      DeliciousGraph graph = (DeliciousGraph)allGraphs.get(i);
      if (mouseX >= graph.xoff && mouseY >= graph.yoff) {
        lastUser = graph.renderText(-1);  
        found = true;
      }
    }
    if (found && !lastUser.equals("") && !lastHighlight.equals(lastUser)) {
      for (int i=0; i<allGraphs.size(); i++) {
        ((DeliciousGraph)allGraphs.get(i)).highlightColumn(lastUser, lastHighlight, false);
      }
      lastHighlight = lastUser;  
    }
  } 
  else if (doneCycle && !imageDone) {
    int total = 0;
    for (int i=0; i<allGraphs.size(); i++) {
      DeliciousGraph o = (DeliciousGraph)(allGraphs.get(i));
      if (flipEvenOthers) {
        leftToRight = !leftToRight;
      }
      total += o.drawData(true);
    }
    if (total == allGraphs.size()) {
      // saveit();
      imageDone = true;
    }
  } 
  else if (imageDone && connectDots && !linesDone) {
    if ((connectsLeft == 3 && plotGrey) ||
      (connectsLeft == 2 && plotOrange) ||
      (connectsLeft == 1 && plotRed)) {
      //      saveit();
      if ((connectsLeft == 1) && justArcs) {
        arcAtBottom = false;
        plotRedGrey = true;
        arcRenderL2R = true;
        doTheConnections(connectsLeft);
      } 
      else if (justArcs) {
        arcAtBottom = false;
        arcRenderL2R = true;
        doTheConnections(connectsLeft);
      }
      arcRenderL2R = false;
      arcAtBottom = true;   
      // buggy
      //      if (flipEvenOthers) {
      //        leftToRight = !leftToRight;
      //      }
      doTheConnections(connectsLeft);
    }
    connectsLeft--;
    if (connectsLeft == 0) {
      printStats();
      println("rendering done");
      rendering = false; 
      linesDone = true;
      if (freeMemory) {
        allGraphs = null;
        System.gc();
      } 
      saveit();      
      if (autopilot) {
        if (++testCount == setTypes.size()) {
          //            totallyDone = true;            
        } 
        else {
          currSetType = new Integer(setTypes.get(testCount).toString());
          autopilot = false;
          toplevelNames = new HashMap();
          allGraphs = new ArrayList();            
          xmlInOut = null;
          caseName = "";
          lastHighlight = "";
          doneCycle = true;
          rendering = true;
          imageDone = false;
          linesDone = false;            
          justConnPairs  = false;
          flipEvenOthers = false;
          connectsLeft = 3;
          supressInfo = 0;
          textOffsetY = 0;
          textOffsetX = 0;
          infoOffsetY = 15;
          mainXoff = 15;
          currx = mainXoff;
          curry = 150;
          offx = 150;
          offy = 150;

          setup();
        }
      }
    }
  }
}


void connectTheDots(DeliciousGraph userA, DeliciousGraph userB, int level) {
  String last = "qbert124151245blah";
  //     println("connecting dots");
  int idx, idx1, idx2;
  Column c, c2;
  String u;
  for (int i=0; i<userA.allColumns.size() && i<maxColumns; i++) {
    idx = userA.allColumns.size()-1-i;
    c = ((Column)userA.allColumns.get(idx));
    u = c.user;

    idx1 = userA.highlightColumn(u, last, true);
    idx2 = userB.highlightColumn(u, last, true);
    c2 = c;
    if (idx2 != -100) {   
      if (justArcs) {
        c2 = ((Column)userB.allColumns.get(userB.allColumns.size()-idx2-1));           
      } 
      else {   
        c2 = ((Column)userB.allColumns.get(idx2));           
      }
      //            if (c2.foundRed()) { println("found red at terminus"); }
      //            if (c2.foundOrange()) { println("found orange at terminus"); }
    }
    last = u;
    boolean skip = false;
    if (idx1 > -1 && idx2 > -1) {
      if (!justArcs) {       
        if (c.foundRed() || c2.foundRed()) {
          stroke((plotRedGrey) ? colorGreyRed : colorRed);
        } 
        else if (c.foundOrange() || c2.foundOrange()) {
          stroke((plotOrangeGrey) ? colorGreyOrange : colorOrange);
        } 
        else {
          stroke(colorGrey);
          if (!showAllLines) {
            skip = true;
          }
        } 
      } 
      else {
        if (level == 3) {
          stroke(colorGrey);
          if (!showAllLines) {
            skip = true;
          }            
        } 
        else if (level == 2) {
          stroke((plotOrangeGrey) ? colorGreyOrange : colorOrange);
        } 
        else {
          stroke((plotRedGrey) ? colorGreyRed : colorRed);
        }         
      }
      if (!justArcs && !funkyWidths) {
        // rendering the orbits incrementally with highest last
        if (((level == 1) && !(c.foundRed()||c2.foundRed())) || 
          ((level == 2) && !(c.foundOrange()||c2.foundOrange())) || 
          ((level == 2) &&  (c.foundRed()||c2.foundRed())) ||            
          ((level == 3) && ((c.foundRed()||c2.foundRed()) || (c.foundOrange()||c2.foundOrange())))) {
          skip = true;
        }
      } 
      else {

        // rendering top
        if (arcRenderL2R) {

          if (idx1 == 0) {
            c = c2; 
          } 
        } 
        else {
          if (idx2 != 0) {
            c = c2; 
          }
        }

        if (secondaryConns) {
          //          println("looking for name, "+u);
          if (!toplevelNames.containsKey(u)) {
            skip = true; 
          }
        } 
        else if (justMainConns) {
          if ((idx1 != 0) && (idx2 != 0)) {
            skip = true; 
          }
        }

        if (funkyPlotAll) {
          if (((level == 1) && !(c.foundRed())) || 
            ((level == 2) && !(c.foundOrange()))) {                       
            skip = true;
          }
        } 
        else {
          if (((level == 1) && !(c.foundRed())) || 
            ((level == 2) &&  (c.foundRed())) ||
            ((level == 3) &&  (c.foundRed() || c.foundOrange())) ||
            ((level == 2) && !(c.foundOrange()))) {                       
            skip = true;
          }
        }
      }
      if (!skip) {
        int x1 = (idx1)*squareSize+userA.xoff+round(squareSize/2);
        int y1 = userA.yoff+c.dataArray.size()*squareSize;
        int x2 = (idx2+1)*squareSize+userB.xoff+round(squareSize/2);
        int y2 = userB.yoff;	

        smooth();
        if (useArcs) {
          noFill();
          int h = 0;
          x2 -= squareSize;
          if (arcsAreSemis) {
            h = round(x2-x1);
          } 
          else {
            int jiggle = 50;
            h = (c.foundRed()) ? 425+(int)random(jiggle) : (c.foundOrange()) ? 275+(int)random(jiggle) : 125+(int)random(jiggle);
          }
          if (arcAtBottom) {
            int adj = 0;
            if (justArcs) {
              adj = squareSize;
            }  
            if (funkyWidths) {
              // deprecated method
              //              strokeWeight(round((idx1+idx2))+1);
              if (showOverlapped) {
                strokeWeight((level == 3) ? c.countG : ((level == 2) ? c.countO : c.countR));              
              } 
              else {
                strokeWeight((level == 3) ? c.countG+c.countO+c.countR : ((level == 2) ? c.countO+c.countR : c.countR));              
              }
            }
            arc(round(x1+x2)/2, y2-adj+squareSize-1, x2-x1, h, 0, PI);
          } 
          else {

            if (funkyWidths) {
              // deprecated method
              //              strokeWeight(round((idx1+idx2))+1);
              if (showOverlapped) {
                strokeWeight((level == 3) ? c.countG : ((level == 2) ? c.countO : c.countR));              
              } 
              else {
                strokeWeight((level == 3) ? c.countG+c.countO+c.countR : ((level == 2) ? c.countO+c.countR : c.countR));              
              }
            }
            arc(round(x1+x2)/2, y2, x2-x1, h, PI, 0);          
          }
        } 
        else {
          if (idx1 == 0) {
            y1 = userA.yoff+c.dataArray.size()+1;
          }
          if (idx2 == 0) {
            x2 -= squareSize;
          }
          line(x1, y1, x2, y2);
        }
        noSmooth();
      }
    }
  }
  //  println("end o dots");
  //  userA.highlightColumn("qbert123151245blah", last, false);
  //  userB.highlightColumn("qbert123151245blah", last, false);
}


class DeliciousGraph {
  int     minEquals    = 13;    // 13
  int     maxURLs      = 1000;  // 1000

    public int     xoff         = 0;
  public int     yoff         = 0;

  int 	squareSize   = 4;
  int 	spacingSize  = squareSize;

  Object  parent;

  String  userName      = ""; 

  XMLElement elt_html;
  XMLElement elt_html2;
  XMLInOut xmlInOut2;

  java.util.HashMap mainHash;

  int lastIdx = 0;
  int lastRenderedIndex = -100;
  boolean doneData = false;
  boolean nameDone = false;
  ArrayList allColumns = new ArrayList();


  DeliciousGraph(String userName, int minEquals, int maxURLs, Object parent, int xoff, int yoff) {
    this.userName 	    = userName;
    this.minEquals     	    = minEquals;
    this.maxURLs 	    = maxURLs;
    this.parent             = parent;
    this.xoff               = xoff;
    this.yoff               = yoff;
  }


  DeliciousGraph initGraph() {
    println("initializing data for user: "+userName);
    try {
      mainHash = new HashMap();
      xmlInOut2 = new XMLInOut((processing.core.PApplet)parent); 
      elt_html = xmlInOut2.loadElementFrom("http://localhost/delicious/data/"+userName+"/master.xml"); 
      String url = "";
      for (int i=0; i<elt_html.countChildren() && i<maxURLs; i++) {
        url = elt_html.getChild(i).getAttribute("value");
//        println(userName+" "+i+" loading "+url);
        xmlInOut = new XMLInOut((processing.core.PApplet)parent);
        try { 
          // blacklisted due to bad chars in extended data or other reasons 
          // that make the parsing choke or run out of memory
          boolean blacklist = false; 
          boolean allUrls = true;
          // removed: list of blacklisted urls, deprecated
          if (!blacklist) {
            if (allUrls) {
              elt_html2 = xmlInOut.loadElementFrom("http://localhost/delicious/data/allurls/"+url);
            } else {
              elt_html2 = xmlInOut.loadElementFrom("http://localhost/delicious/data/"+userName+"/"+url);
            
            }
            initData(elt_html2, url);
            elt_html2 = null;
          }
        } 
        catch (InvalidDocumentException ide) {
          println("File does not exist - "+url);
        }
        xmlInOut = null;
      }
      xmlInOut2 = null;
      elt_html = null;
      sortData();
      if (printTops) {
        println("sortByScore: "+sortByScore+" and sortSpicyness: "+sortSpicyness);
        int n=0;
        for (int i=allColumns.size()-1; i>allColumns.size()-numPrintTops-2; i--) {
          Column c = ((Column)allColumns.get(i));
          if (sortByScore) {
            println(++n+" "+c.user+" "+c.totalScore);          
          } else {
            println(++n+" "+c.user+" "+c.dataArray.size());                    
          }
        }
      }
      //                renderText(-1);
    } 
    catch (InvalidDocumentException ide) {
      println("File does not exist");
    }
    return this;	
  }


  void initData(XMLElement elt_html2, String currentUrl)
  {
    XMLElement curr;	
    XMLElement ol;
    try {
      ol = elt_html2.getChild(0);
    } 
    catch (Exception e) {
      println(currentUrl+" seems to be empty");
      return;
    }
    int count = ol.countChildren();
    int x = 50;
    int y = 100;
    for (int i=0; i<count; i++) {
      curr = ol.getChild(i);
      String href="";
      try {
        href = curr.getAttribute("href");
      } 
      catch (Exception e) {
      }
      if (!href.equals("")) {
        if (!mainHash.containsKey(href)) {
          x+=spacingSize;
          numPut++;
          mainHash.put(href, new Column(x, y, href));
        } 
        else {
          if (count > 0) {
            ((Column)mainHash.get(href)).addItem(currentUrl, count, href, userName);
          } 
          else {
            println("ignoring unique url "+href);
          }
        }
      }
    } 
  }


  int highlightColumn(String user, String lastUser, boolean justInfo) {
    if (user != null && !user.equals("") && lastUser != null && !lastUser.equals("") && mainHash.containsKey(lastUser) && !justInfo) {
      Column obj = (Column)(mainHash.get(lastUser));
      obj.display(obj.newx, obj.user, obj.x, obj.y, false);        
      renderText(1000000);
    }
    if (user != null && mainHash.containsKey(user)) {
      Column obj = (Column)(mainHash.get(user));
      if (obj.currIdx != -1) {
        if (!justInfo) {
          obj.display(obj.newx, obj.user, obj.x, obj.y, true);  
          renderText(obj.currIdx);
        }
        return obj.currIdx;
      }
    }
    return -100;
  }

  void resetStates() {
    lastRenderedIndex = -100; 
  }

  void sortData() {
    Object okey, obj;
    for (Iterator i = (mainHash.keySet()).iterator() ; i.hasNext() ;) {
      okey = i.next();
      obj = mainHash.get(okey);
      if (((Column)obj).dataArray.size() >= minEquals) {
        ((Column)obj).getScore(1);
        allColumns.add(obj);
      }
    }	
    FastQSortAlgorithm fqa = new FastQSortAlgorithm((sortByScore) ? 1 : 3);
    try {
      fqa.sort(allColumns);
    }  
    catch (Exception e) {
    }

    // minimize the size of the array
    allColumns.trimToSize();
    if (memOptimize) {
      ArrayList newList = new ArrayList(maxColumns);
      mainHash = null; // uh, buh-bye
      mainHash = new HashMap();
      int sizer = (maxColumns > allColumns.size()) ? allColumns.size() : maxColumns;
      for (int i=0; i<sizer; i++) {
        Object o = allColumns.get(allColumns.size()-1-i);
        newList.add(0, o); 
        mainHash.put(((Column)o).href, o);
      }
      println("optimized memory and doing forced garbage collection");
      allColumns = null;
      printMemStats();
      allColumns = newList;
    }
    println("done sorting, colsize is "+allColumns.size());
  }


  int drawData(boolean stepIt) {
    if (lastRenderedIndex == -100) {
      lastRenderedIndex = -1;
    }
    doneCycle = false;     
    lastRenderedIndex++;	
    if ((lastRenderedIndex > maxColumns) || (lastRenderedIndex > allColumns.size())) {
      doneCycle = true;
      return 1;
    }
    int idx = (leftToRight) ? allColumns.size()-lastRenderedIndex-1 : lastRenderedIndex;
    int newx = lastRenderedIndex*spacingSize;
    if (idx != -1 && idx != allColumns.size()) {    
      ((Column)allColumns.get(idx)).setIndex(lastRenderedIndex);
      int ss = 0;
      if (!alignTop) {
        int s = ((Column)allColumns.get(idx)).dataArray.size();
        ss = (100-s)*squareSize;
      }
      ((Column)allColumns.get(idx)).display(newx, userName, xoff, yoff+ss, false);	
    }
    if (lastRenderedIndex == maxColumns) {
      return 1;
    }	
    doneCycle = true;
    return 0;
  }


  String renderText(int newIdx) {
    if ((memOptimize && (newIdx != -2)) || noNames) {
      return "";
    }
    String user = "";	
    int realx = mouseX+mainXoff-xoff-squareSize;
    int idx = floor(realx/squareSize)-4;

    if (newIdx >= 0) {
      idx = newIdx;
    }
    if (newIdx == -2) {
      noTextBg = true;
    }

    smooth();
    if (lastIdx != idx) {
      lastIdx = idx;
      stroke(255);
      fill(255);
      if (supressInfo == 0 && !noTextBg) {
        rect(xoff-10+textOffsetX, yoff-37+textOffsetY, textBackWidth, 30);
      }

      if (supressInfo > allGraphs.size()) {
        return "";
      }

      fill(colorName);
      textFont(fontA, 25);	
      float w = textWidth(userName);
      if (!(justName && nameDone) || newIdx == -2) {
        //		    text(userName, xoff+4+textOffsetX, yoff-15+textOffsetY);
      }
      if (newIdx == -2) {
        text(userName, xoff+4+textOffsetX, yoff-15+textOffsetY);                    
      }
      nameDone = true;                  

      if (newIdx == -2) {
        return "";
      }    
      if (supressInfo > 0) {
        supressInfo++;
        return "";
      }

      if (idx < 0) {
        idx = 0;
      }
      if (idx >= 0 && idx < allColumns.size() && idx < maxColumns) {
        idx = allColumns.size()-idx-1;
        int score = ((Column)allColumns.get(idx)).getScore(1);
        int count = ((Column)allColumns.get(idx)).dataArray.size();   

        fill(255, 154, 0);
        user = ((Column)allColumns.get(idx)).user;
        String t = user.substring(1);
        float ww = textWidth(t);
        text("."+t, xoff+w+5+textOffsetX, yoff-15+textOffsetY);
        textFont(fontB, 18);      

        fill(150, 150, 150);     
        text("(score: "+score+", urls: "+count+")", xoff+w+ww+20+textOffsetX, yoff-15+textOffsetY);	
      }
    }   
    return user;     
  }

}


class Column {
  public ArrayList dataArray = new ArrayList();
  Object parent;
  public String href;
  int newx;
  int x;
  int y;
  int currIdx = -1;
  String user;
  int totalScore = 0;
  int countR = 0;
  int countO = 0;
  int countG = 0;

  public void finalize() { 
    OBJDC++; 
  }

  Column(int x, int y, String href) {
    this.x = x;
    //    this.y = y;    
    this.y = -200;
    this.href = href;
    OBJCC++;
  }

  void setIndex(int idx) {
    currIdx = idx;
  }

  boolean foundRed() {
    return (countR > 0) ? true : false;
  }

  boolean foundOrange() {
    return (countO > 0) ? true : false;
  }

  boolean foundGrey() {
    return (countG > 0) ? true : false;
  }

  int getScore(int method) {
    if (totalScore != 0) {
      return totalScore;
    }
    int score = 0;
    for (int i=0; i<dataArray.size(); i++) {
      int count = ((Module)dataArray.get(i)).count;

      switch (sortSpicyness) {

      case 1: // classic
        if (count < 10)   { 
          score += 4; 
        } 
        else
          if (count < 100)  { 
            score += 3; 
          } 
          else
            if (count < 500)  { 
              score += 2; 
            } 
            else
            { 
              score += 1; 
            }         
        break;

      case 2: // nu
        if (count < minForRed)     { 
          score += 4; 
        } 
        else
          if (count < minForOrange)  { 
            score += 3; 
          } 
          else
            if (count > minForGrey)    { 
              score += 1; 
            } 
            else
            { 
              score += 2; 
            }      
        break;

      case 3: // R/O weighted heavy
        if (count < minForRed)     { 
          score += 10; 
        } 
        else
          if (count < minForOrange)  { 
            score += 5; 
          } 
          else
            if (count > minForGrey)    { 
              score += 1; 
            } 
            else
            { 
              score += 2; 
            }    
        break;

      case 4: // R/O exclusive
        if (count < minForRed)     { 
          score += 2; 
        } 
        else
          if (count < minForOrange)  { 
            score += 1; 
          } 
          else
            if (count > minForGrey)    { 
              score += 0; 
            } 
            else
            { 
              score += 0; 
            }    
        break;


      }
    }
    totalScore = score;
    return score;
  }


  void destroyObjects() {
    for (int i=0; i<dataArray.size(); i++) {
      dataArray.remove(i);
    }
    user = null;
    parent = null;
    dataArray = null; 
  }


  void addItem(String currentUrl, int count, String user, String userName) { 
    int spacer = spacingSize;
    this.user = user;
    if (user.equals("/"+userName)) {
      spacer = 2;
    }
    dataArray.add(new Module(currentUrl, count, user));
  }

  void display(int newx, String userName, int xoff, int yoff, boolean highlight) {
    x = xoff;
    y = yoff;
    this.newx = newx;
    boolean showNice = false;

    if (sortByCount) {
      FastQSortAlgorithm fqa = new FastQSortAlgorithm(2);
      try {
        fqa.sort(dataArray);
      } 
      catch (Exception e) {
      }
    }
    if (showNice) { 
      //    	ycnt += ((Module)dataArray.get(i1)).display(newx, ycnt, userName, xoff, yoff, highlight, this, "orangered");
      //    	ycnt += ((Module)dataArray.get(i2)).display(newx, ycnt, userName, xoff, yoff, highlight, this, "grey");
      //    	ycnt += ((Module)dataArray.get(i3)).display(newx, ycnt, userName, xoff, yoff, highlight, this, "blue");
    } 
    else {
      if (parityTop) {
        for (int i=0; i<dataArray.size(); i++) {
          ((Module)dataArray.get(i)).display(newx, i, userName, xoff, yoff, highlight, this, "all");
        }    
      } 
      else {
        for (int i=0; i<dataArray.size(); i++) {
          ((Module)dataArray.get(dataArray.size()-1-i)).display(newx, i, userName, xoff, yoff, highlight, this, "all");
        }
      }
    }
  }
}



class Module {
  int count;
  String url;
  String user;
  boolean userHeight = false;

  public void finalize() { 
    OBJDM++; 
  }


  // Contructor (required)
  Module(String url, int count, String user) {
    OBJCM++;
    this.url = url;
    this.count = count;
    this.user = user;
  }

  int display(int newx, int newy, String userName, int xoff, int yoff, boolean highlight, Column parent, String renderType) {
    noSmooth();
    fill(128, 128, 128);

    if (count < 500) {
      fill(222, 222, 222);
    }
    if (count < 100) {
      fill(0, 0, 255);
    }



    if (useGradient) {
      int v = round(count/4);
      fill(v, v, 255);
      if (v>255) {
        fill(230, 230, 230);
      }
    }

    if (showOutlyers) {
      if (count > 2000) {
        fill(128, 128, 128);
      }
    }
    parent.countG++;

    if (count <= minForOrange) {      
      fill(255, 154, 0);
      parent.countO++;
      parent.countG--;
    }

    if (count <= minForRed) {
      fill(255, 0, 0);
      parent.countR++;
      parent.countO--;
    } 

    if (count > minForGrey) {
      if (!renderType.equals("grey") && !renderType.equals("all")) {
        return 0;
      }
    } 
    else if (count < minForOrange && !renderType.equals("orangered") && !renderType.equals("all")) {
      return 0;
    } 
    else if (count > minForOrange && !renderType.equals("blue") && !renderType.equals("all")) {
      return 0;
    }


    if (highlight) {
      stroke(255, 154, 0);
    } 
    else {
      stroke(255);
    }

    int x = newx;

    if (justArcs) {
      return 1;
    } 

    if (user.equals("/"+userName) || userHeight) {
      int y = newy*1;    
      noStroke();
      //            rect(x+xoff-squareSize, yoff+y, squareSize, 1);
      if (arcAtBottom) {
        rect(x+xoff, yoff-y+2, squareSize, 1);            
      } 
      else {
        rect(x+xoff, yoff+y, squareSize, 1);
      }
      userHeight = true;
    } 
    else {
      int y = newy*squareSize;
      if (arcAtBottom) {
        rect(x+xoff, yoff-y, squareSize, squareSize);
      } 
      else {
        rect(x+xoff, yoff+y, squareSize, squareSize);      
      }
    }
    return 1;
  }
}




/*
 * @(#)QSortAlgorithm.java      1.3   29 Feb 1996 James Gosling
 *
 * Copyright (c) 1994-1996 Sun Microsystems, Inc. All Rights Reserved.
 *
 * Permission to use, copy, modify, and distribute this software
 * and its documentation for NON-COMMERCIAL or COMMERCIAL purposes and
 * without fee is hereby granted. 
 * Please refer to the file http://www.javasoft.com/copy_trademarks.html
 * for further important copyright and trademark information and to
 * http://www.javasoft.com/licensing.html for further important
 * licensing information for the Java (tm) Technology.
 * 
 * SUN MAKES NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY OF
 * THE SOFTWARE, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
 * PARTICULAR PURPOSE, OR NON-INFRINGEMENT. SUN SHALL NOT BE LIABLE FOR
 * ANY DAMAGES SUFFERED BY LICENSEE AS A RESULT OF USING, MODIFYING OR
 * DISTRIBUTING THIS SOFTWARE OR ITS DERIVATIVES.
 * 
 * THIS SOFTWARE IS NOT DESIGNED OR INTENDED FOR USE OR RESALE AS ON-LINE
 * CONTROL EQUIPMENT IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE
 * PERFORMANCE, SUCH AS IN THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT
 * NAVIGATION OR COMMUNICATION SYSTEMS, AIR TRAFFIC CONTROL, DIRECT LIFE
 * SUPPORT MACHINES, OR WEAPONS SYSTEMS, IN WHICH THE FAILURE OF THE
 * SOFTWARE COULD LEAD DIRECTLY TO DEATH, PERSONAL INJURY, OR SEVERE
 * PHYSICAL OR ENVIRONMENTAL DAMAGE ("HIGH RISK ACTIVITIES").  SUN
 * SPECIFICALLY DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR
 * HIGH RISK ACTIVITIES.
 */


/**
 * A quick sort demonstration algorithm
 * SortAlgorithm.java
 *
 * @author James Gosling
 * @author Kevin A. Smith
 * @author kiddphunk.com
 */
public class FastQSortAlgorithm 
{
  int valtype = 1;

  FastQSortAlgorithm(int valtype) {
    this.valtype = valtype;
  }

  private void QuickSort(ArrayList a, int l, int r) throws Exception
  {
    int M = 4;
    int i;
    int j;
    int v;
    if ((r-l)>M)
    {
      i = (r+l)/2;
      if (getVal(a,l)>getVal(a,i)) swap(a,l,i);     // Tri-Median Methode!
      if (getVal(a,l)>getVal(a,r)) swap(a,l,r);
      if (getVal(a,i)>getVal(a,r)) swap(a,i,r);

      j = r-1;
      swap(a,i,j);
      i = l;
      v = getVal(a,j);
      for(;;)
      {
        while(getVal(a,++i)<v);
        while(getVal(a,--j)>v);
        if (j<i) break;
        swap (a,i,j);
      }
      swap(a,i,r-1);
      QuickSort(a,l,j);
      QuickSort(a,i+1,r);
    }
  }

  private void swap(ArrayList a, int i, int j)
  {
    Object c;
    c = getObj(a, i); 
    setVal(a, i, j);
    setVal(a, j, c);
  }

  private int getVal(ArrayList a, int i) {
    if (valtype == 1) {
      return ((Column)a.get(i)).totalScore;
    }
    if (valtype == 2) {
      return ((Module)a.get(i)).count;
    }
    if (valtype == 3) {
      return ((Column)a.get(i)).dataArray.size();
    }

    return 0;
  }

  private void setVal(ArrayList a, int i1, int i2) {
    a.set(i1, a.get(i2));
  }

  private void setVal(ArrayList a, int i, Object c) {
    a.set(i, c);
  }

  private Object getObj(ArrayList a, int i) {
    return (Object)a.get(i);  
  }

  private void InsertionSort(ArrayList a, int lo0, int hi0) throws Exception
  {
    int i;
    int j;
    Object v;
    for (i=lo0+1;i<=hi0;i++)
    {
      v = getObj(a, i);
      j=i;
      int vv = getVal(a, i);
      while ((j>lo0) && (getVal(a, j-1) > vv))
      {
        setVal(a, j, j-1);
        j--;
      }
      setVal(a, j, v);
    }
  }

  public void sort(ArrayList a) throws Exception
  {
    QuickSort(a, 0, a.size()-1);
    InsertionSort(a, 0, a.size()-1);
  }
}

