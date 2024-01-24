// This is the part that attaches to the BedJet hose

include <Constants.scad>

// use <Library.scad>
// could use extrudedPill from the above, but it is more
// general purpose and this one can be more simple
// by just doing a circle instead of an pill.

module extrudedPill(d,h=10,t=4) {
 linear_extrude(h) {
  projection() { 
   difference() {
    scale([d/100,d/100,1]) cylinder(.001,d=100);
    scale([(d-t)/100,(d-t)/100,1]) cylinder(.001,d=100);
   }
  }
 }
}

module donut(d,w) {
  rotate_extrude() 
    translate([d/2,0,0])
      circle(w);
}

difference() {
translate([inletDiameter/2+inletCurveRadius,0,-inletEntryLength]) extrudedPill(inletDiameter,inletEntryLength);
color("red") translate([inletDiameter/2+inletCurveRadius,0,etch-inletEntryLength]) donut(inletDiameter+depth*1.5,depth);
}

translate([0,0,inletCurveRadius+inletDiameter/2]) 
 difference() {
  rotate([0,-90,0]) extrudedPill(inletDiameter,inletExitLength);
  translate([screwOffset-inletExitLength,0,0]) cylinder(100,screwSize);
}

rotate([90,0,0]) {
  difference(){
   rotate_extrude(angle=90) translate([inletCurveRadius+inletDiameter/2,0,0]) circle(d=inletDiameter);
   rotate_extrude(angle=90) translate([inletCurveRadius+inletDiameter/2,0,0]) circle(d=inletDiameter-4);
   }
}
