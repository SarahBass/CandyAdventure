import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Weather;
import Toybox.Activity;
import Toybox.ActivityMonitor;
import Toybox.Time.Gregorian;
import Toybox.UserProfile;

enum {
//hair colors
BrownHair       = 0,
HoneyBlondeHair = 1,
BlondeHair      = 2,
BlackHair       = 3,
RedHair         = 4,
PinkHair        = 5,
BlueHair        = 6,
GreenHair       = 7,
PurpleHair      = 8,
WhiteHair       = 9,

// Eye Colors
BlackEyes   = 0,
BrownEyes   = 1,
BlueEyes    = 2,
GreenEyes   = 3,
YellowEyes  = 4,
PurpleEyes  = 5,
GreyEyes    = 6,
PinkEyes    = 7,
RedEyes     = 8,


//candyflow
  TooMuchCandy = 0,
  SomeCandy    = 1,
  NoCandy      = 2,

  //candy
GreenAppleEye   = 0,
ChocolateEye    = 1,
RaspberryEye    = 2,
SourCherrySkull = 3,
RainbowSkull    = 4,
MintSkull       = 5,
EyeCandy        = 6,
SkullCandy      = 7,
SourPotion      = 8,
RainbowEye      = 9,
ScaryPumpkinPop = 10,

// Hair Types
Hair0        = 0,
Hair1        = 1,
Hair2        = 2,
Hair3        = 3,
Hair4        = 4,
Hair5        = 5,

// Dress Styles
DressStyle1 = 0,
DressStyle2 = 1,
DressStyle3 = 2,
BoyClothes  = 3,

// Bangs Styles
Bangs1      = 0,
Bangs2      = 1,
Bangs3      = 2,
BoyHair     = 3,

// Skin Tones
SkinFair    = 0,
SkinMed     = 1,
SkinDark    = 2,
SkinGreen   = 3,
SkinBlue    = 4,
SkinPink    = 5,
SkinPhantom = 6,

// Hair Accessories
HairPieceNone = 0,
HairPiece1    = 1,
HairPiece2    = 2,
HairPiece3    = 3,

// Socks and Skin Options
Girly       = 0,
Boyish        = 1,

// Animal Options
Duck        = 0,
Chicken     = 1,
Pig         = 2,
Cat         = 3,
Butterfly   = 4,
Mouse       = 5,
Frog        = 6

}

var eyes = 0;
var candy = 0;
var hair = 0;
var bangs= 0;
var skin=0;
var pet=0;
var haircolor=0;
var clothes=0;
var hairpiece=1;
var legs=0;

class VirtualPetNothingView extends WatchUi.WatchFace {
  
function initialize() {  WatchFace.initialize(); }

function onLayout(dc as Dc){}


function onShow() as Void { }

function onUpdate(dc as Dc) as Void {
/*                 _       _     _           
  __   ____ _ _ __(_) __ _| |__ | | ___  ___ 
  \ \ / / _` | '__| |/ _` | '_ \| |/ _ \/ __|
   \ V / (_| | |  | | (_| | |_) | |  __/\__ \
    \_/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
                                           */

    /*----------System Variables------------------------------*/
// New variables
var eyes = readKeyInt(Toybox.Application.getApp(), "eyes", 0);
var bangs = readKeyInt(Toybox.Application.getApp(), "bangs", 0);
var skin = readKeyInt(Toybox.Application.getApp(), "skin", 0);
var pet = readKeyInt(Toybox.Application.getApp(), "pet", 0);
var haircolor = readKeyInt(Toybox.Application.getApp(), "haircolor", 0);
var clothes = readKeyInt(Toybox.Application.getApp(), "clothes", 0);
var hairpiece = readKeyInt(Toybox.Application.getApp(), "hairpiece", 1);
var candy = readKeyInt(Toybox.Application.getApp(), "candy", 0);
var legs = readKeyInt(Toybox.Application.getApp(), "legs", 0);
    var mySettings = System.getDeviceSettings();
    var screenHeightY = (System.getDeviceSettings().screenHeight)/360;
    var screenWidthX = (System.getDeviceSettings().screenWidth)/360;
    //Size Variations Pixel Circle
    //360 VenuS2 - The Model I designed it for 
    //390 Size up
    //416 Size up
    //454 Size up
  
    if (System.getDeviceSettings().screenHeight ==390){
        screenHeightY=screenHeightY*1.1;
        screenWidthX=screenWidthX *1.07;
    }
    if (System.getDeviceSettings().screenHeight ==416){
        screenHeightY=screenHeightY*1.15;
        screenWidthX=screenWidthX *1.17;
    }
    if (System.getDeviceSettings().screenHeight ==454){
        screenHeightY=screenHeightY*1.25;
        screenWidthX=screenWidthX *1.27;
    }
       var venus2XL=0;
    if (System.getDeviceSettings().screenHeight  == 390){
        venus2XL = -4;
    }
    if (System.getDeviceSettings().screenHeight  == 416){
      venus2XL = -8;
      
    }
        if (System.getDeviceSettings().screenHeight == 454){
        venus2XL = -13;
    } 
    var myStats = System.getSystemStats();
    var info = ActivityMonitor.getInfo();
    
    /*----------Clock and Calendar Variables------------------------------*/
  
    var clockTime = System.getClockTime();
    var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
    var hours = clockTime.hour;
    if (!System.getDeviceSettings().is24Hour) {
        if (hours == 0) {
            hours = 12; // Display midnight as 12:00
        } else if (hours > 12) {
            hours = hours - 12;
        }
    } else {
        hours = hours;
     }
   
    var weekdayArray = ["Day", "SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY"] as Array<String>;
    var monthArray = ["Month", "JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE", "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"] as Array<String>;
   /*----------Alarms and Notify------------------------------*/
    //var userAlarm = "0";
    //if (mySettings.alarmCount != null) {
    //    userAlarm = Lang.format("$1$", [mySettings.alarmCount.toNumber().format("%2d")]);
    //}

    /*----------Battery------------------------------*/
    var userBattery = "0";
    var batteryMeter = 1;

    if (myStats.battery != null) {
        userBattery = myStats.battery.toNumber().toString(); // Convert to string without zero padding
    } else {
        userBattery = "0";
    }

    if (myStats.battery != null) {
        batteryMeter = myStats.battery.toNumber();
    } else {
        batteryMeter = 1;
    }
        
    /*----------Steps------------------------------*/
    var userSTEPS = 0;
 if (info.steps != null){userSTEPS = info.steps.toNumber();}else{userSTEPS=0;} 
    //var userCAL = 0;
    //if (info.calories != null){userCAL = info.calories.toNumber();}else{userCAL=0;}  
   
   /*----------Weather------------------------------*/
   var getCC = Toybox.Weather.getCurrentConditions();
    var TEMP = "000";
    var FC = "0";
    if (getCC != null && getCC.temperature != null) {
        if (System.getDeviceSettings().temperatureUnits == 0) {
            FC = "C";
            TEMP = getCC.temperature.format("%d");
        } else {
            TEMP = (((getCC.temperature * 9) / 5) + 32).format("%d");
            FC = "F";
        }
    } else {
        TEMP = "000";
    }

    var cond = 0;
    if (getCC != null && getCC.condition != null) {
        cond = getCC.condition.toNumber();
    } else {
        cond = 0; // Default to sun condition if unavailable
    }

    var userHEART = "0";
    var heartRate = getHeartRate();

    if (heartRate == null) {
        userHEART = "0"; // Set to "0" if heart rate is unavailable
    } else {
        userHEART = heartRate.toString();
    }

    var moonnumber = getMoonPhase(today.year, ((today.month)-1), today.day);  
    var moon1 = moonArrFun(moonnumber);
    var centerX = (dc.getWidth()) / 2;
    var centerY = (dc.getHeight()) / 2;
    var wordFont =  WatchUi.loadResource( Rez.Fonts.smallFont );
    var DataFont =  WatchUi.loadResource( Rez.Fonts.wordFont );
    var bigFont= WatchUi.loadResource( Rez.Fonts.bigFont );
    var funFont= DataFont;
    View.onUpdate(dc);

 /*     _                           _            _    
     __| |_ __ __ ___      __   ___| | ___   ___| | __
    / _` | '__/ _` \ \ /\ / /  / __| |/ _ \ / __| |/ /
   | (_| | | | (_| |\ V  V /  | (__| | (_) | (__|   < 
    \__,_|_|  \__,_| \_/\_/    \___|_|\___/ \___|_|\_\
                                                   */

 //Every 360 Steps Pikachu Levels up
 userSTEPS=9000;


    dc.setPenWidth(20);
    dc.setColor(0x3D3C0C, Graphics.COLOR_TRANSPARENT);
    dc.drawCircle(centerX, centerX, centerX*270/360);
    dc.setPenWidth(20);
   dc.setColor(0x2F302F, Graphics.COLOR_TRANSPARENT);
    dc.drawCircle(centerX, centerX, centerX*340/360);

//var monsters = monsterPhase(userSTEPS/1000, today.min);
//monsters.draw(dc);

     dc.setPenWidth(8);
    dc.setColor(0x6F706F, Graphics.COLOR_TRANSPARENT);
    dc.drawCircle(centerX, centerX, centerX*360/360);
     dc.setPenWidth(20);
    dc.setColor(0x00D10D, Graphics.COLOR_TRANSPARENT);
    dc.drawArc(centerX, centerX, centerX*340/360, Graphics.ARC_CLOCKWISE, 1, -((userSTEPS+2)/1000)*36 ); 
     dc.setPenWidth(8);
    dc.setColor(0x4FDF58, Graphics.COLOR_TRANSPARENT);
    dc.drawArc(centerX, centerX, centerX*340/360, Graphics.ARC_CLOCKWISE, 1, -((userSTEPS+2)/1000)*36 ); 
if (bangs != BoyHair) {
  var hairs= hair0Phase(0);
if (hair ==0){hairs = hair0Phase(haircolor);}
else if (hair ==1){ hairs = hair1Phase(haircolor);}
else if (hair ==2){ hairs = hair2Phase(haircolor);}
else if (hair ==3){ hairs = hair3Phase(haircolor);}
else if (hair ==4){ hairs = hair4Phase(haircolor);}
else if (hair ==5){ hairs = hair5Phase(haircolor);}
else{ hairs = hair3Phase(haircolor);}
hairs.draw(dc);
}
var leg = legPhase(0);
if (legs==1){leg = legPhase(2+skin);}else{leg = legPhase(today.min%2);}
leg.draw(dc);

var costume = dressPhase(clothes);
costume.draw(dc);

var head = headPhase(skin);
head.draw(dc);

var bangy = boysPhase();
if (bangs != BoyHair) {
  if (bangs == 0){bangy = bangs0Phase(haircolor);}
  else if (bangs == 1){bangy = bangs1Phase(haircolor);}
  else if (bangs == 2){ bangy = bangs2Phase(haircolor);}
  else if (bangs == 3){bangy = bangs3Phase(haircolor);}
  else { bangy = bangs1Phase(haircolor);}
}
bangy.draw(dc);



if (today.min%2==0){
var arm = arms0Phase(0);
arm.draw(dc);
}else{
var arm = arms1Phase(0);
arm.draw(dc);
}
var eyeball= eyesPhase(eyes);
eyeball.draw(dc);

if (hairpiece>0){
var charmy = charmPhase(hairpiece+1);
charmy.draw(dc);
}

var animal = petPhase(pet);
animal.draw(dc);







   //Draw Moon and Battery
    moon1.draw(dc);
    var shift=-35;
    //hours=hours+2;
    
if (System.getDeviceSettings().is24Hour || hours/10> 0){
    shift = 0;
    var digitHour=(digitPhase(hours/10,-115+shift));
    digitHour.draw(dc);
     } 

    var digitColon=(digitPhase(10,-25+shift));
    digitColon.draw(dc);
    

    var digitHours=(digitPhase(hours%10,-65+shift));
    digitHours.draw(dc);

    var digitSec=(digitPhase(today.min/10,25+shift));
    digitSec.draw(dc);
    var digitSecT=(digitPhase(today.min%10,75+shift));
    digitSecT.draw(dc);


   
   if (System.getDeviceSettings().screenWidth == 320){
    dc.setColor(0x2A3088, Graphics.COLOR_TRANSPARENT);  
    dc.drawText( 210 ,(40*screenHeightY)+venus2XL, wordFont, (TEMP+" " +FC), Graphics.TEXT_JUSTIFY_CENTER );
    dc.setColor(0xFFFFFF, Graphics.COLOR_TRANSPARENT);
    dc.drawText( centerX+5,0, bigFont, weather(cond), Graphics.TEXT_JUSTIFY_CENTER );
    dc.drawText(  45, 150*screenHeightY, funFont,  userHEART, Graphics.TEXT_JUSTIFY_CENTER );
    dc.drawText( 45, 224*screenHeightY, funFont,  (userSTEPS), Graphics.TEXT_JUSTIFY_CENTER );
   }else{
         //Draw Top Font with shadow
    dc.setColor(0x2A3088, Graphics.COLOR_TRANSPARENT);  
    dc.drawText( 221 *screenWidthX+venus2XL,(40*screenHeightY)+venus2XL+15, wordFont, (TEMP+" " +FC), Graphics.TEXT_JUSTIFY_CENTER );
    dc.setColor(0xFFFFFF, Graphics.COLOR_TRANSPARENT);
    dc.drawText( centerX-2,15, bigFont, weather(cond), Graphics.TEXT_JUSTIFY_CENTER );
     dc.drawText(centerX,(78*screenHeightY)+(venus2XL*2)+15,wordFont,(weekdayArray[today.day_of_week]+" , "+ monthArray[today.month]+" "+ today.day +" " +today.year), Graphics.TEXT_JUSTIFY_CENTER );}
 // if (System.getDeviceSettings().screenWidth == 454){
  //dc.drawText(centerX,(78*screenHeightY)+(venus2XL*2),wordFont,(weekdayArray[today.day_of_week]+" , "+ monthArray[today.month]+" "+ today.day +" " +today.year), Graphics.TEXT_JUSTIFY_CENTER );}
   // dc.drawText(  (45 *screenWidthX), 150*screenHeightY, funFont,  userHEART, Graphics.TEXT_JUSTIFY_CENTER );
    //dc.drawText( (45 *screenWidthX), 224*screenHeightY, funFont,  (userSTEPS), Graphics.TEXT_JUSTIFY_CENTER );
  // }
    /*---------------Draw Battery---------------*/
if (System.getDeviceSettings().screenWidth == 320){
 if (batteryMeter >= 10 && batteryMeter <= 32) {
        //Red
        dc.setColor(0xB00B1E, Graphics.COLOR_TRANSPARENT); 
        dc.fillRectangle(centerX +2, (centerY * 88 / 360)+venus2XL, 9, 15);
    } else if (batteryMeter >= 33 && batteryMeter <= 65) {
       //Yellow
       dc.setColor(0xFFFF00, Graphics.COLOR_TRANSPARENT); 
        dc.fillRectangle(centerX +2, (centerY * 88 / 360)+venus2XL, 9,15 );
    } else if (batteryMeter >= 66) {
       //Nothing
    }else{
        //Nothing
    }
}else{

    if (batteryMeter >= 10 && batteryMeter <= 32) {
        //Red
        dc.setColor(0xB00B1E, Graphics.COLOR_TRANSPARENT); 
        dc.fillRectangle(centerX * 350 / 360, (centerX * 88 / 360)+venus2XL+15, 9, 15);
    } else if (batteryMeter >= 33 && batteryMeter <= 65) {
       //Yellow
       dc.setColor(0xFFFF00, Graphics.COLOR_TRANSPARENT); 
        dc.fillRectangle(centerX * 350 / 360, (centerX * 88 / 360)+venus2XL+15, 9,15 );
    } else if (batteryMeter >= 66) {
       //Nothing
    }else{
        //Nothing
    }
}
}
/*            _     _ 
  __   _____ (_) __| |
  \ \ / / _ \| |/ _` |
   \ V / (_) | | (_| |
    \_/ \___/|_|\__,_|
                    */

function onHide() as Void { }
function onExitSleep() as Void {}
function onEnterSleep() as Void {}

/*                    _   _               
__      _____  __ _| |_| |__   ___ _ __ 
\ \ /\ / / _ \/ _` | __| '_ \ / _ \ '__|
 \ V  V /  __/ (_| | |_| | | |  __/ |   
  \_/\_/ \___|\__,_|\__|_| |_|\___|_|   
                                        */

function weather(cond) {
  if (cond == 0 || cond == 40){return "b";}//sun
  else if (cond == 50 || cond == 49 ||cond == 47||cond == 45||cond == 44||cond == 42||cond == 31||cond == 27||cond == 26||cond == 25||cond == 24||cond == 21||cond == 18||cond == 15||cond == 14||cond == 13||cond == 11||cond == 3){return "a";}//rain
  else if (cond == 52||cond == 20||cond == 2||cond == 1){return "e";}//cloud
  else if (cond == 5 || cond == 8|| cond == 9|| cond == 29|| cond == 30|| cond == 33|| cond == 35|| cond == 37|| cond == 38|| cond == 39){return "g";}//wind
  else if (cond == 51 || cond == 48|| cond == 46|| cond == 43|| cond == 10|| cond == 4){return "i";}//snow
  else if (cond == 32 || cond == 37|| cond == 41|| cond == 42){return "f";}//whirlwind 
  else {return "c";}//suncloudrain 
}

/*     _                                        
    __| |_ __ __ ___      __  _ __  _ __   __ _ 
   / _` | '__/ _` \ \ /\ / / | '_ \| '_ \ / _` |
  | (_| | | | (_| |\ V  V /  | |_) | | | | (_| |
   \__,_|_|  \__,_| \_/\_/   | .__/|_| |_|\__, |
                             |_|          |___/ */

function charmPhase(charm) {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  //var screenWidthX = System.getDeviceSettings().screenWidth;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }
  var charmARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.charm0,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.charm1,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.charm2,
      :locX => venus2X,
      :locY => venus2Y
    }))
];
return charmARRAY[charm];
}

function headPhase(head) {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  //var screenWidthX = System.getDeviceSettings().screenWidth;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }
 var headsARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.head_fair,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.head_medium,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.head_dark,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.head_phantom,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.head_pink,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.head_green,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.head_blue,
      :locX => venus2X,
      :locY => venus2Y
    }))
];

return headsARRAY[head];
}

function hair3Phase(hair) {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  //var screenWidthX = System.getDeviceSettings().screenWidth;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }
var hair3ARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair3_blonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair3_black,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair3_brown,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair3_honeyblonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair3_blue,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair3_pink,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair3_red,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair3_green,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair3_purple,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair3_white,
      :locX => venus2X,
      :locY => venus2Y
    }))
];

return hair3ARRAY[hair];
}

function hair0Phase(hair) {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }

  var hair0ARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair0_blonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair0_black,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair0_brown,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair0_honeyblonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair0_blue,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair0_pink,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair0_red,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair0_green,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair0_purple,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair0_white,
      :locX => venus2X,
      :locY => venus2Y
    }))
  ];

  return hair0ARRAY[hair];
}
function hair1Phase(hair) {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }

  var hair1ARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair1_blonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair1_black,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair1_brown,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair1_honeyblonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair1_blue,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair1_pink,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair1_red,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair1_green,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair1_purple,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair1_white,
      :locX => venus2X,
      :locY => venus2Y
    }))
  ];

  return hair1ARRAY[hair];
}
function hair2Phase(hair) {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }

  var hair2ARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair2_blonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair2_black,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair2_brown,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair2_honeyblonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair2_blue,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair2_pink,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair2_red,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair2_green,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair2_purple,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair2_white,
      :locX => venus2X,
      :locY => venus2Y
    }))
  ];

  return hair2ARRAY[hair];
}
function hair4Phase(hair) {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }

  var hair4ARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair4_blonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair4_black,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair4_brown,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair4_honeyblonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair4_blue,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair4_pink,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair4_red,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair4_green,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair4_purple,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair4_white,
      :locX => venus2X,
      :locY => venus2Y
    }))
  ];

  return hair4ARRAY[hair];
}
function hair5Phase(hair) {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }

  var hair5ARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair5_blonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair5_black,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair5_brown,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair5_honeyblonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair5_blue,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair5_pink,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair5_red,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair5_green,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair5_purple,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.hair5_white,
      :locX => venus2X,
      :locY => venus2Y
    }))
  ];

  return hair5ARRAY[hair];
}



function bangs0Phase(hair) {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  //var screenWidthX = System.getDeviceSettings().screenWidth;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }
var bangs0ARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs0_blonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs0_black,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs0_brown,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs0_honeyblonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs0_blue,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs0_pink,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs0_red,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs0_green,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs0_purple,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs0_white,
      :locX => venus2X,
      :locY => venus2Y
    }))
];


return bangs0ARRAY[hair];
}

function bangs1Phase(hair) {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }

  var bangs1ARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs1_blonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs1_black,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs1_brown,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs1_honeyblonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs1_blue,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs1_pink,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs1_red,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs1_green,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs1_purple,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs1_white,
      :locX => venus2X,
      :locY => venus2Y
    }))
  ];

  return bangs1ARRAY[hair];
}
function bangs2Phase(hair) {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }

  var bangs2ARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs2_blonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs2_black,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs2_brown,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs2_honeyblonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs2_blue,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs2_pink,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs2_red,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs2_green,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs2_purple,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs2_white,
      :locX => venus2X,
      :locY => venus2Y
    }))
  ];

  return bangs2ARRAY[hair];
}
function bangs3Phase(hair) {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }

  var bangs3ARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs3_blonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs3_black,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs3_brown,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs3_honeyblonde,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs3_blue,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs3_pink,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs3_red,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs3_green,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs3_purple,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.bangs3_white,
      :locX => venus2X,
      :locY => venus2Y
    }))
  ];

  return bangs3ARRAY[hair];
}

function boysPhase() {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  //var screenWidthX = System.getDeviceSettings().screenWidth;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }
var bangs0ARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.boyhair,
      :locX => venus2X,
      :locY => venus2Y
    }))
    ];
    return bangs0ARRAY[0];
}

function eyesPhase(eyes) {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  //var screenWidthX = System.getDeviceSettings().screenWidth;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }

var eyesARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.eyes0,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.eyes1,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.eyes2,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.eyes3,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.eyes4,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.eyes5,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.eyes6,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.eyes7,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.eyes8,
      :locX => venus2X,
      :locY => venus2Y
    }))
];
return eyesARRAY[eyes];
}

function arms0Phase(arms) {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }

  var arms0ARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.arms0_fair,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.arms0_medium,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.arms0_dark,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.arms0_phantom,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.arms0_pink,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.arms0_green,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.arms0_blue,
      :locX => venus2X,
      :locY => venus2Y
    }))
  ];

  return arms0ARRAY[arms];
}

function arms1Phase(arms) {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  //var screenWidthX = System.getDeviceSettings().screenWidth;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }
var arms1ARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.arms1_fair,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.arms1_medium,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.arms1_dark,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.arms1_phantom,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.arms1_pink,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.arms1_green,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.arms1_blue,
      :locX => venus2X,
      :locY => venus2Y
    }))
];

return arms1ARRAY[arms];
}

function petPhase(pet) {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  //var screenWidthX = System.getDeviceSettings().screenWidth;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }
  var petARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.pet0,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.pet1,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.pet2,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.pet3,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.pet4,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.pet5,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.pet6,
      :locX => venus2X,
      :locY => venus2Y
    }))
];

return petARRAY[pet];
}

function monsterPhase(monster, minutes) {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  //var screenWidthX = System.getDeviceSettings().screenWidth;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }
  var monsterARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.monster0,
      :locX => venus2X,
      :locY => venus2Y -((minutes%3)*5)
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.monster1,
      :locX => venus2X -((minutes%3)*5),
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.monster2,
      :locX => venus2X-((minutes%3)*5),
      :locY => venus2Y
    }))
];

return monsterARRAY[monster];
}

  function legPhase(legs) {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  //var screenWidthX = System.getDeviceSettings().screenWidth;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }
  
var legsARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.legs0,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.legs1,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.legs2_fair,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.legs2_medium,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.legs2_dark,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.legs2_phantom,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.legs2_pink,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.legs2_green,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.legs2_blue,
      :locX => venus2X,
      :locY => venus2Y
    }))
];

return legsARRAY[legs];
  }

  function dressPhase(dress) {
  var screenHeightY = System.getDeviceSettings().screenHeight;
  //var screenWidthX = System.getDeviceSettings().screenWidth;
  var venus2X = 30;
  var venus2Y = 0;

  if (screenHeightY == 390) {
    venus2Y = venus2Y + 30;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 416) {
    venus2Y = venus2Y + 45;
    venus2X = venus2X + 10;
  }

  if (screenHeightY == 454) {
    venus2Y = venus2Y + 90;
    venus2X = venus2X + 40;
  }
  var dressARRAY = [
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.dress0,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.dress1,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.dress2,
      :locX => venus2X,
      :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
      :rezId => Rez.Drawables.dress3,
      :locX => venus2X,
      :locY => venus2Y
    }))
];

return dressARRAY[dress];
  }

function goalPhase(number, seconds, steps){
  var screenHeightY = System.getDeviceSettings().screenHeight;
  var screenWidthX = System.getDeviceSettings().screenWidth;
  var venus2X = ((screenWidthX)* (number)/8);
  //var venus2X = (screenWidthX)-((seconds%20)*20);
  var venus2Y = 0+((seconds%15)*30);


    if (screenHeightY == 390){
   venus2Y = venus2Y;
   venus2X = venus2X+10;}

       if (screenHeightY == 416){
   venus2Y = venus2Y;
   venus2X = venus2X+20;}

    if (screenHeightY == 454){
   venus2Y = venus2Y;
   venus2X = venus2X+40;}

 var goalARRAY = [
   (new WatchUi.Bitmap({
    :rezId => Rez.Drawables.goal0,
    :locX => venus2X,
    :locY => venus2Y
})),
(new WatchUi.Bitmap({
    :rezId => Rez.Drawables.goal1,
    :locX => venus2X,
    :locY => venus2Y
})),
(new WatchUi.Bitmap({
    :rezId => Rez.Drawables.goal2,
    :locX => venus2X,
    :locY => venus2Y
})),
(new WatchUi.Bitmap({
    :rezId => Rez.Drawables.goal3,
    :locX => venus2X,
    :locY => venus2Y
})),
(new WatchUi.Bitmap({
    :rezId => Rez.Drawables.goal4,
    :locX => venus2X,
    :locY => venus2Y
})),
(new WatchUi.Bitmap({
    :rezId => Rez.Drawables.goal5,
    :locX => venus2X,
    :locY => venus2Y
})),
(new WatchUi.Bitmap({
    :rezId => Rez.Drawables.goal6,
    :locX => venus2X,
    :locY => venus2Y
})),
(new WatchUi.Bitmap({
    :rezId => Rez.Drawables.goal7,
    :locX => venus2X,
    :locY => venus2Y
})),
(new WatchUi.Bitmap({
    :rezId => Rez.Drawables.goal8,
    :locX => venus2X,
    :locY => venus2Y
})),
(new WatchUi.Bitmap({
    :rezId => Rez.Drawables.goal9,
    :locX => venus2X,
    :locY => venus2Y
})),
(new WatchUi.Bitmap({
    :rezId => Rez.Drawables.goal10,
    :locX => venus2X,
    :locY => venus2Y
}))
];
if (steps>9999){return goalARRAY[10];}
else{
  return goalARRAY[steps/1000];}

        
}




/* _                     _       __       _       
  | |__   ___  __ _ _ __| |_    /__\ __ _| |_ ___ 
  | '_ \ / _ \/ _` | '__| __|  / \/// _` | __/ _ \
  | | | |  __/ (_| | |  | |_  / _  \ (_| | ||  __/
  |_| |_|\___|\__,_|_|   \__| \/ \_/\__,_|\__\___|
                                                */

private function getHeartRate() {
    // Initialize to null
    var heartRate = null;

    // Get the activity info if possible
    var info = Activity.getActivityInfo();
    if (info != null && info.currentHeartRate != null) {
        heartRate = info.currentHeartRate;
    } else { 
        // Fallback to `getHeartRateHistory`
        var history = ActivityMonitor.getHeartRateHistory(1, true);
        if (history != null) {
            var latestHeartRateSample = history.next();
            if (latestHeartRateSample != null && latestHeartRateSample.heartRate != null) {
                heartRate = latestHeartRateSample.heartRate;
            }
        }
    }

    // Could still be null if the device doesn't support it
    return heartRate;
}


/*
  __  __                 ___ _                 
 |  \/  |___  ___ _ _   | _ \ |_  __ _ ___ ___ 
 | |\/| / _ \/ _ \ ' \  |  _/ ' \/ _` (_-</ -_)
 |_|  |_\___/\___/_||_| |_| |_||_\__,_/__/\___|
 
*/
function getMoonPhase(year, month, day) {

      var c=0;
      var e=0;
      var jd=0;
      var b=0;

      if (month < 3) {
        year--;
        month += 12;
      }

      ++month; 

      c = 365.25 * year;

      e = 30.6 * month;

      jd = c + e + day - 694039.09; 

      jd /= 29.5305882; 

      b = (jd).toNumber(); 

      jd -= b; 

      b = Math.round(jd * 8); 

      if (b >= 8) {
        b = 0; 
      }
     
      return (b).toNumber();
    }

     /*
     0 => New Moon
     1 => Waxing Crescent Moon
     2 => Quarter Moon
     3 => Waxing Gibbous Moon
     4 => Full Moon
     5 => Waning Gibbous Moon
     6 => Last Quarter Moon
     7 => Waning Crescent Moon
     */
function moonArrFun(moonnumber){
    var screenHeightY = System.getDeviceSettings().screenHeight;
    var screenWidthX = System.getDeviceSettings().screenWidth;    
    var venus2Y = 40*(screenHeightY/360);
    var venus2XL = ((screenWidthX)*115/360);
    //Size Variations Pixel Circle
    //360 VenuS2 - The Model I designed it for 
    //390 Size up
    //416 Size up
    //454 Size up
    
    if (screenHeightY == 390){
        venus2XL = ((venus2XL)+4);
      
    }
    if (screenHeightY == 416){
      venus2XL = ((venus2XL)+8);
      
    }
        if (screenHeightY == 454){
        venus2XL = ((venus2XL)+15);
    }
  var moonArray= [
          (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.newmoon,//0
            :locX=> venus2XL,
            :locY=> venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.waxcres,//1
            :locX=> venus2XL,
            :locY=> venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.firstquar,//2
            :locX=> venus2XL,
            :locY=> venus2Y
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.waxgib,//3
            :locX=> venus2XL,
            :locY=> venus2Y
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.full,//4
            :locX=> venus2XL,
            :locY=> venus2Y
        })),
                (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.wangib,//5
            :locX=> venus2XL,
            :locY=> venus2Y
        })),
            (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.thirdquar,//6
            :locX=> venus2XL,
            :locY=> venus2Y
        })),
           (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.wancres,//7
            :locX=> venus2XL,
            :locY=> venus2Y,
        })),
        ];
        return moonArray[moonnumber];
}
}

function digitPhase(seconds, push){
    
  var screenHeightY = System.getDeviceSettings().screenHeight;
  //var screenWidthX = System.getDeviceSettings().screenWidth;
  var venus2X = screenHeightY/2+push;
 // var venus2Y = 15;
   var venus2Y = screenHeightY/3;

    if (screenHeightY == 390){
        venus2Y = ((venus2Y)-10);
      
    }
    if (screenHeightY == 416){
      venus2Y = ((venus2Y)-15);
      
    }
        if (screenHeightY == 454){
        venus2Y = ((venus2Y)-25);
    }


var digitArray = [
    (new WatchUi.Bitmap({
        :rezId => Rez.Drawables.digit0,
        :locX => venus2X,
        :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
        :rezId => Rez.Drawables.digit1,
        :locX => venus2X,
        :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
        :rezId => Rez.Drawables.digit2,
        :locX => venus2X,
        :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
        :rezId => Rez.Drawables.digit3,
        :locX => venus2X,
        :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
        :rezId => Rez.Drawables.digit4,
        :locX => venus2X,
        :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
        :rezId => Rez.Drawables.digit5,
        :locX => venus2X,
        :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
        :rezId => Rez.Drawables.digit6,
        :locX => venus2X,
        :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
        :rezId => Rez.Drawables.digit7,
        :locX => venus2X,
        :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
        :rezId => Rez.Drawables.digit8,
        :locX => venus2X,
        :locY => venus2Y
    })),
    (new WatchUi.Bitmap({
        :rezId => Rez.Drawables.digit9,
        :locX => venus2X,
        :locY => venus2Y
    })),
        (new WatchUi.Bitmap({
        :rezId => Rez.Drawables.colon,
        :locX => venus2X,
        :locY => venus2Y
    }))
];
return digitArray[seconds];
}
// helper function to retrieve the property for any numeric setting
   function readKeyInt(myApp, key, thisDefault) {
    var value = myApp.getProperty(key);

    if (value == null || !(value instanceof Number)) {
        if (value != null) {
            // Attempt to cast the value to a Number
            try {
                value = value as Number; // This tries to cast the value to a Number
            } catch (e) {
                value = thisDefault; // If it fails, fall back to the default
            }
        } else {
            value = thisDefault; // If value is null, use the default
        }
    }
    
    return value;
}
/* 
       Horoscope, Zodiac, and Weather Font:
        A FAR
        B capricorn
        C CELCIUS
        D Celcius
        E SAGIT
        F TAUR
        G SCORP
        H VIRGO
        I LIBRA
        J LEO
        K BULL
        L SHEEP
        M PM
        N AM
        0 :
        a rain
        b sun
        c rainsuncloud
        d dragon
        e cloud
        f whirl
        g wind
        h rat
        i snow
        j dog
        k tiger
        l sun up
        m rabbit
        n sun down
        o snake
        p horse
        q rooster
        r monkey
        s pig
        t male
        u female
        v aquarius
        w aries
        x gemini
        y leo
        z libra
        */

// questionmark=calorie *=heart [=battery ]=steps @=battery #=phone
// = is small battery ^ is small steps ~ is small calories + is small heart