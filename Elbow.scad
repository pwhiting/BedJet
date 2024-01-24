
use <Library.scad>
include <Constants.scad>

x=10;

module triangle() {
 translate([0,-(elbowWidth-x)/2,0]) {
 difference(){
  cube([elbowHeight+elbowCurveRadius,elbowWidth-x,elbowHeight+elbowCurveRadius]);
  translate([-20,0,20]) rotate([0,-45,0])color("red")cube([2*(elbowHeight),elbowWidth-x,elbowHeight]);
  }
  }
 }
  
support();
myElbow();
module support() {
difference(){
triangle();
solidElbow();
}
translate([elbowHeight+25,0,1.5])
difference(){
cube([50,elbowWidth-x,3],center=true);
cylinder(h=10,r=3,center=true);
}
}

// this single line below does the same as the rest of the file, but it does
// it in a less computationally efficient way.
// extendedElbow(elbowWidth,elbowHeight,elbowWidth,elbowHeight,elbowCurveRadius,entry=elbowLength,exit=elbowLength,holeOffset=screwOffset,holeSize=screwSize);

module myElbow() {
translate([0,0,elbowHeight+elbowCurveRadius])
rotate([90,0,90])
union(){
rotate([90,0,-90])
 rotate_extrude(angle=90)
  translate([elbowHeight/2+elbowCurveRadius,0,0]) 
   rotate([0,0,90]) 
    projection() extrudedPill(elbowWidth,elbowHeight,1);

translate([0,-elbowHeight/2-elbowCurveRadius,-elbowLength])
extrudedPill(elbowWidth,elbowHeight,elbowLength,holeSize=screwSize,holeOffset=screwOffset); 

color("green")translate([0,elbowLength,(elbowHeight/2+elbowCurveRadius)])
rotate([90,0,0])
extrudedPill(elbowWidth,elbowHeight,elbowLength,holeSize=screwSize,holeOffset=screwOffset); 
}
}







module solidElbow() {
translate([0,0,elbowHeight+elbowCurveRadius])
rotate([90,0,90])
union(){
rotate([90,0,-90])
 rotate_extrude(angle=90)
  translate([elbowHeight/2+elbowCurveRadius,0,0]) 
   rotate([0,0,90]) 
    projection() pill(elbowWidth,elbowHeight);
translate([0,-elbowHeight/2-elbowCurveRadius,-elbowLength])
linear_extrude(elbowLength) projection() pill(elbowWidth,elbowHeight);
translate([0,elbowLength,(elbowHeight/2+elbowCurveRadius)])
rotate([90,0,0])
linear_extrude(elbowLength) projection() pill(elbowWidth,elbowHeight);
}
}


