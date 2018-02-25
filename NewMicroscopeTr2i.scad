triR=40;
cornerBigR=10;
cornersmallR=8;


bandW=42;
bandD=14;
bandDia=5;

rodDia=6.3;
middleHoleDia=25;

topDia = 15;
eyeLenDia = 25;
objectLenDia = 7;
stageDia=15;
ledDia=10;
bottomDia=7;

batteryThick=3.5;
acrylicThick=2;
plugW=30;
plugH=15;
slotW=5;

echo(triR*(cos(60)+1)-rodDia);

x=(triR+cornerBigR)*(1-cos(60));
y=80;

//top and bottom
translate([0,0,0]) rotate([0,0,0]) plate(5,cornerBigR,6.3,topDia);
translate([0+x,-y,0]) rotate([0,0,180]) plate(5,cornerBigR,0,topDia);
translate([0,-y*2,0]) rotate([0,0,0]) plate(5,cornerBigR,6.3,topDia);
translate([0+x,-y*3,0]) rotate([0,0,180]) plate(5,cornerBigR,0,topDia);

//eyeLen
difference(){
    translate([100,0,0]) rotate([0,0,0]) plate(0,cornersmallR,6.3,eyeLenDia);
    translate([100+eyeLenDia/2,0,0]) rotate([0,0,0]) circle(1,$fn=100);  //make a little notch
}
translate([100+x,-y,0]) rotate([0,0,180]) plate(0,cornersmallR,6.3,eyeLenDia-1);
translate([100,-y*2,0]) rotate([0,0,0]) plate(0,cornersmallR,6.3,eyeLenDia-1);

//objectLen
translate([200,0,0]) rotate([0,0,0]) plate(0,cornersmallR,6.3,objectLenDia);
translate([200+x,-y,0]) rotate([0,0,180]) plate(0,cornersmallR,6.3,objectLenDia);

//stage
translate([300,0,0]) rotate([0,0,0]) plate(0,cornersmallR,6.3,stageDia);

//Led
difference(){
    translate([400,0,0]) rotate([0,0,0]) plate(0,cornersmallR,6.3,ledDia);
    //plug
    translate([400+(plugW/2-slotW),batteryThick/2,0])  square([slotW,acrylicThick]);
    translate([400-(plugW/2),batteryThick/2,0])  square([slotW,acrylicThick]);
    translate([400+(plugW/2-slotW),-batteryThick/2-acrylicThick,0])  square([slotW,acrylicThick]);
    translate([400-(plugW/2),-batteryThick/2-acrylicThick,0])  square([slotW,acrylicThick]);
}

translate([400,-y,0])  plug();
translate([400,-y*1.5,0]) plug();


module plug(){
    union(){
    square([plugW,plugH]);
    translate([0,-acrylicThick,0]) square([slotW,acrylicThick]);
    translate([plugW-slotW,-acrylicThick,0]) square([slotW,acrylicThick]);
    }
}

module plate(bandDia,cornerR,rodDia,middleHoleDia){
    difference(){
        minkowski() {
            circle(triR,$fn=3);
            circle(cornerR, center=true,$fn=100);
        }
        //rod
        translate([triR*cos(0),triR*sin(0),0]) circle(rodDia/2,$fn=100);
        translate([triR*cos(120),triR*sin(120),0]) circle(rodDia/2,$fn=100);
        translate([triR*cos(240),triR*sin(240),0]) circle(rodDia/2,$fn=100);
        
        //centerHole
        circle(middleHoleDia/2,$fn=100);

        //rubber band notch
        for (a =[0:2]){
            translate([bandD*cos(-60+120*a),bandD*sin(-60+120*a),0]) 
            rotate([0,0,30+120*a]) 
            union(){
                translate([bandW,0,0]) circle(bandDia/2,$fn=100);
                translate([-bandW,0,0]) circle(bandDia/2,$fn=100);
                //translate([0,0,0]) circle(1,$fn=100);
                //square([bandW*2,1],center=true);
            }
        }
    }
}