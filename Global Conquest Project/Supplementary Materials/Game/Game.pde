//constants defined for the attack roll box
float bx;
float by;
int boxSizew = 87;
int boxSizeh = 50;
float bx2;
float by2;
int boxSizew2 = 87;
int boxSizeh2 = 50;
//Some basic constants for use
int i, y, x;
int num = 5;
int m = -1;
int large = 5;
//the interger value of drag attacks available
int dragattacks = 3;
//territory bonuses
int SAtroops = 3;
int NAtroops = 5;
int AStroops = 8;
int AUtroops = 2;
int EUtroops = 5;
int AFtroops = 6;

int turns = 0;

int count = 0;
//booleans for flagging release and pressing of territories
boolean releaseSA, releaseNA, releaseAS, releaseAU, releaseEU, releaseAF = false;
boolean pressedSA, pressedNA, pressedAS, pressedAU, pressedEU, pressedAF = false;
// more boolean constants for flagging events
boolean overt = false;
boolean locked = false;
boolean outtroop = false;
boolean overBox = false;
boolean tclicked = false;
float xOffset = 0.0;
float yOffset = 0.0;
//constants to keep track of clicks
int click = 0;
int click2 = 0;
//to keep track of the user attacks and the agents attack count
int uattacks = 2;
int aattacks = 3;
//to roll agents random attacks/troop allocations
int attroll1;
int attroll2;
int attroll3;
//keep tabs on the troop numbers spare
int utn = 15;
int aonetn = 15;
//for the territory positioning
int SAx = 580;
int SAy = 170;
int NAx = 172;
int NAy = 50;
int Asy = 600;
int Asx = 250;
int Auy = 867;
int Aux = 685;
int Euy = 465;
int Eux = 235;
int Afy = 460;
int Afx = 505;
int SAxsize = 230;
int SAysize = 300;
int NAxsize = 400;
int NAysize = 450;
int ASxsize = 475;
int ASysize = 460;
int AUxsize = 180;
int AUysize = 150;
int EUxsize = 290;
int EUysize = 275;
int AFxsize = 220;
int AFysize = 260;
//clock data
int second = second();
int minute = minute();
int hour = hour();
//List of enemy owned territories
IntList tell;
PFont f;
//Territory array, User object and agent objet
Territory[] tArray = new Territory[6];
User[] uArray = new User[1];
Agent[] aArray = new Agent[1];
//graphics
PGraphics pg;


//Images for each continent
PImage Namerica, Samerica, Europe, Africa, Australia, Asia;

void setup()
{
  bx = width / 4.0;
  by = height / 2.0;
  rectMode(RADIUS);

  //Creating the territory array
  tArray[0] = new Territory(SAy, SAx, "Samerica.png", 0, 0, 0);
  tArray[1] = new Territory(NAy, NAx, "Namerica.png", 0, 0, 1);
  tArray[2] = new Territory(Asy, Asx, "Asia.png", 0, 0, 2);
  tArray[3] = new Territory(Auy, Aux, "Australia.png", 0, 0, 3);
  tArray[4] = new Territory(Euy, Eux, "Europe.png", 0, 0, 4);
  tArray[5] = new Territory(Afy, Afx, "Africa.png", 0, 0, 5);

  pg = createGraphics(100, 100);
  //create user array object and agent array object
  uArray[0] = new User(false, false, false, false, false, false, attroll1, attroll2, 0);
  aArray[0] = new Agent(false, false, false, false, false, false, attroll1, attroll2, 0, 0);
  size(1165, 900);

}

void draw()
{
  background(30, 60, 250);
  //lines connecting territories and seperating the game from the feedback area
  fill(0);
  line(265, 490, 465, 490);
  line(348, 660, 463, 600);
  line(0, 150, 1300, 150);

  fill(255);
  // Time and Date..... However Time is slightly broken.
  text("Turn : " + turns, 15, 15);
  text(("Date - " + year() + "/" + month() + "/" + day()), 1060, 15);
  text(second + millis() / 1000 % 60, 1135, 30);
  text(minute + millis() / (1000 * 60) % 60 + ":", 1115, 30);
  text("Time - " + hour / 10 + millis() / (1000 * 60 * 60) % 24 + ":", 1060, 30);
  text("Troops you have left: " + utn, 15, 30);


  // Draws the territories.
  image(tArray[0].terrimage, tArray[0].x, tArray[0].y, SAxsize, SAysize); // South America
  image(tArray[1].terrimage, tArray[1].x, tArray[1].y, NAxsize, NAysize); //North america
  image(tArray[2].terrimage, tArray[2].x, tArray[2].y, ASxsize, ASysize); //Asia
  image(tArray[3].terrimage, tArray[3].x, tArray[3].y, AUxsize, AUysize); //Australia
  image(tArray[4].terrimage, tArray[4].x, tArray[4].y, EUxsize, EUysize); //Eruope
  image(tArray[5].terrimage, tArray[5].x, tArray[5].y, AFxsize, AFysize); //Africa

  //Write out all the user/agent troops on a territory
  text((tArray[0].troopnum), 250, 725);
  text((tArray[1].troopnum), 225, 485);
  text((tArray[2].troopnum), 850, 427);
  text((tArray[3].troopnum), 970, 790);
  text((tArray[4].troopnum), 615, 440);
  text((tArray[5].troopnum), 595, 592);
  fill(0, 0, 0);

  text("Troops enemy has left: " + aonetn, 15, 45);
  text((tArray[0].atroopnum), 265, 725);
  text((tArray[1].atroopnum), 240, 485);
  text((tArray[2].atroopnum), 865, 427);
  text((tArray[3].atroopnum), 985, 790);
  text((tArray[4].atroopnum), 630, 440);
  text((tArray[5].atroopnum), 610, 592);
  fill(255, 255, 255);

  if (utn > 0)
  {
    fill(250, 200, 0);
    text("Territory Bonuses ", 800, 15);
    text("Australia: " + AUtroops, 800, 30);
    text("South America: " + SAtroops, 800, 45);
    text("North America: " + NAtroops, 800, 60);
    text("Europe: " + EUtroops, 800, 75);
    text("Africa: " + AFtroops, 800, 90);
    text("Asia: " + AStroops, 800, 105);
  }

  bx = 625;
  by = 45;


  //While the user is out of troops
  if (utn == 0)
  {
    outtroop = true;

    text("Out of troops!", 450, 25);
    //if the user mouse hovers over roll attack strength/troop allocation box
    if (mouseX > bx - boxSizew && mouseX - boxSizew < bx &&
      mouseY > by - boxSizeh && mouseY < by + boxSizeh)
    {
      overBox = true;
      fill(153);
      rect(bx, by, boxSizew, boxSizeh);
      fill(0);
      text("Roll for attacks!", 585, 40);

    }
    else
    {

      fill(200);
      rect(bx, by, boxSizew, boxSizeh);

      fill(0);
      text("Roll for attacks!", 585, 40);
      overBox = false;

    }
    //print out attack phase information
    fill(255);
    text("Attack strength:", 5, 70);
    text("Troops to be allocated next turn:", 5, 85);
    text(uArray[0].uaroll1, 92, 70);
    text(uArray[0].uaroll2, 180, 85);
    fill(0);
    text("Enemy Attack strength:", 5, 130);
    text("Enemy Troops to be allocated next turn:", 5, 145);
    text(aArray[0].aaroll1, 132, 130);
    text(aArray[0].aaroll2, 220, 145);
    text("Internal Territory Attacks Left : " + uattacks, 800, 30);
    text("External Drag Attacks Left : " + dragattacks, 800, 45);
    text("ATTACK PHASE! To end press ENTER", 800, 15);
    outtroop = false;

  }



  //Assign territories to user when won
  if (tArray[0].troopnum > 0 && tArray[0].atroopnum == 0)
  {
    uArray[0].SAt = true;
  }
  else
  {
    uArray[0].SAt = false;
  }

  if (tArray[1].troopnum > 0 && tArray[1].atroopnum == 0)
  {
    uArray[0].NAt = true;
  }
  else
  {
    uArray[0].NAt = false;
  }

  if (tArray[2].troopnum > 0 && tArray[2].atroopnum == 0)
  {
    uArray[0].ASt = true;
  }
  else
  {
    uArray[0].ASt = false;
  }

  if (tArray[3].troopnum > 0 && tArray[3].atroopnum == 0)
  {
    uArray[0].AUt = true;
  }
  else
  {
    uArray[0].AUt = false;
  }

  if (tArray[4].troopnum > 0 && tArray[4].atroopnum == 0)
  {
    uArray[0].EUt = true;
  }
  else
  {
    uArray[0].EUt = false;
  }

  if (tArray[5].troopnum > 0 && tArray[5].atroopnum == 0)
  {
    uArray[0].AFt = true;
  }
  else
  {
    uArray[0].AFt = false;
  }


  //Assign territories to Agent
  if (tArray[0].atroopnum > 0 && tArray[0].troopnum == 0)
  {
    aArray[0].aSAt = true;
  }
  else
  {
    aArray[0].aSAt = false;
  }
  if (tArray[1].atroopnum > 0 && tArray[1].troopnum == 0)
  {
    aArray[0].aNAt = true;
  }
  else
  {
    aArray[0].aNAt = false;
  }
  if (tArray[2].atroopnum > 0 && tArray[2].troopnum == 0)
  {
    aArray[0].aASt = true;
  }
  else
  {
    aArray[0].aASt = false;
  }
  if (tArray[3].atroopnum > 0 && tArray[3].troopnum == 0)
  {
    aArray[0].aAUt = true;
  }
  else
  {
    aArray[0].aAUt = false;
  }
  if (tArray[4].atroopnum > 0 && tArray[4].troopnum == 0)
  {
    aArray[0].aEUt = true;
  }
  else
  {
    aArray[0].aEUt = false;
  }
  if (tArray[5].atroopnum > 0 && tArray[5].troopnum == 0)
  {
    aArray[0].aAFt = true;
  }
  else
  {
    aArray[0].aAFt = false;
  }

  //IF all territories are owned by agent
  if ((aArray[0].aSAt == true && aArray[0].aNAt == true && aArray[0].aASt == true && aArray[0].aAUt == true && aArray[0].aEUt == true && aArray[0].aAFt == true) || turns > 30)
  {
    text("YOU LOSE!", 100, 800);
  }

  //IF all territories are owned
  if (uArray[0].SAt == true && uArray[0].NAt == true && uArray[0].ASt == true && uArray[0].AUt == true && uArray[0].EUt == true && uArray[0].AFt == true && turns <= 30)
  {
    text("YOU WIN!", 100, 800);
  }
}

void mouseClicked()
{
  // ATTEMPT AT STOPPING TROOP ALLOCATION ON NOT OWNED TROOPS (tArray[0].troopnum > 0 || count < 15)
  tArray[0].update();
  tArray[1].update();
  tArray[2].update();
  tArray[3].update();
  tArray[4].update();
  tArray[5].update();

  //////////////////////////////////////////////////
  //roll for user/agent attacks and troop reserves
  if (mouseX > bx - boxSizew && mouseX - boxSizew < bx &&
    mouseY > by - boxSizeh && mouseY < by + boxSizeh)
  {
    if (click == 0)
    {
      turns = turns + 1;
      click = click + 1;

      //random number rolling
      int aroll1 = int(random(6) + 1);
      uArray[0].uaroll1 = aroll1;
      int aroll2 = (int(random(6) + 1) * 2);
      uArray[0].uaroll2 = aroll2;

      int aaroll1 = int(random(6) + 1);
      aArray[0].aaroll1 = aaroll1;
      int aaroll2 = (int(random(6) + 1) * 2);
      aArray[0].aaroll2 = aaroll2;

    }

  }
  //run the object mouse clicked functions
  uArray[0].mouseClicked();
  aArray[0].mouseClicked();
  if (uattacks == 0)
  {
    //update constants
    //add territory bonuses (USER)
    if (uArray[0].SAt == true)
    {
      tArray[0].troopnum = tArray[0].troopnum + SAtroops;
    }
    if (uArray[0].NAt == true)
    {
      tArray[1].troopnum = tArray[1].troopnum + NAtroops;
    }
    if (uArray[0].ASt == true)
    {
      tArray[2].troopnum = tArray[2].troopnum + AStroops;
    }
    if (uArray[0].AUt == true)
    {
      tArray[3].troopnum = tArray[3].troopnum + AUtroops;
    }
    if (uArray[0].EUt == true)
    {
      tArray[4].troopnum = tArray[4].troopnum + EUtroops;
    }
    if (uArray[0].AFt == true)
    {
      tArray[5].troopnum = tArray[5].troopnum + AFtroops;
    }
    //add territory bonuses (AGENT)
    if (aArray[0].aSAt == true)
    {
      tArray[0].atroopnum = tArray[0].atroopnum + SAtroops;
    }
    if (aArray[0].aNAt == true)
    {
      tArray[1].atroopnum = tArray[1].atroopnum + NAtroops;
    }
    if (aArray[0].aASt == true)
    {
      tArray[2].atroopnum = tArray[2].atroopnum + AStroops;
    }
    if (aArray[0].aAUt == true)
    {
      tArray[3].atroopnum = tArray[3].atroopnum + AUtroops;
    }
    if (aArray[0].aEUt == true)
    {
      tArray[4].atroopnum = tArray[4].atroopnum + EUtroops;
    }
    if (aArray[0].aAFt == true)
    {
      tArray[5].atroopnum = tArray[5].atroopnum + AFtroops;
    }

    aonetn = aonetn + aArray[0].aaroll2;
    utn = utn + uArray[0].uaroll2;
    uattacks = 2;
    click = 0;
    dragattacks = 3;
  }
  count = count + 1;
}
//function for skip rest of attacks
void keyPressed()
{
  if (key == ENTER && click == 1)
  {

    //add territory bonuses (USER)
    if (uArray[0].SAt == true)
    {
      tArray[0].troopnum = tArray[0].troopnum + SAtroops;
    }
    if (uArray[0].NAt == true)
    {
      tArray[1].troopnum = tArray[1].troopnum + NAtroops;
    }
    if (uArray[0].ASt == true)
    {
      tArray[2].troopnum = tArray[2].troopnum + AStroops;
    }
    if (uArray[0].AUt == true)
    {
      tArray[3].troopnum = tArray[3].troopnum + AUtroops;
    }
    if (uArray[0].EUt == true)
    {
      tArray[4].troopnum = tArray[4].troopnum + EUtroops;
    }
    if (uArray[0].AFt == true)
    {
      tArray[5].troopnum = tArray[5].troopnum + AFtroops;
    }
    //add territory bonuses (AGENT)
    if (aArray[0].aSAt == true)
    {
      tArray[0].atroopnum = tArray[0].atroopnum + SAtroops;
    }
    if (aArray[0].aNAt == true)
    {
      tArray[1].atroopnum = tArray[1].atroopnum + NAtroops;
    }
    if (aArray[0].aASt == true)
    {
      tArray[2].atroopnum = tArray[2].atroopnum + AStroops;
    }
    if (aArray[0].aAUt == true)
    {
      tArray[3].atroopnum = tArray[3].atroopnum + AUtroops;
    }
    if (aArray[0].aEUt == true)
    {
      tArray[4].atroopnum = tArray[4].atroopnum + EUtroops;
    }
    if (aArray[0].aAFt == true)
    {
      tArray[5].atroopnum = tArray[5].atroopnum + AFtroops;
    }


    //reset all constants and update troop reserves

    aonetn = aonetn + aArray[0].aaroll2;
    utn = utn + uArray[0].uaroll2;
    uattacks = 2;
    click = 0;
    dragattacks = 3;

  }
}
void mousePressed()
{
  //run the user object function for mouse pressed
  uArray[0].mousePressed();
}
void mouseReleased()
{
  //run the user object function for mouse released
  uArray[0].mouseReleased();
}