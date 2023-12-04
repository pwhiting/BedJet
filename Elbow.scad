use <Library.scad>
include <Constants.scad>

// this single line below does the same as the rest of the file, but it does
// it in a less computationally efficient way.
// extendedElbow(elbowWidth,elbowHeight,elbowWidth,elbowHeight,elbowCurveRadius,entry=elbowLength,exit=elbowLength,holeOffset=screwOffset,holeSize=screwSize);

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
