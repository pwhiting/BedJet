use <Library.scad>
include <Constants.scad>

elbow(elbowHeight,elbowWidth,outletExitWidth,outletExitHeight,outletCurveRadius);

translate([0,0,-outletEntryLength]) 
 extrudedPill(elbowHeight,elbowWidth,outletEntryLength,holeSize=screwSize,holeOffset=screwOffset);
 
 module half(w,t1,t2) {
  rotate_extrude(angle=180) {
   translate([w/2,0,0]) circle(r=t1);
  }
}
   
module line(w,t1,t2,h) {
    linear_extrude(height=h) {
    translate([w/2,0,0])circle(r=t1);     
    }
}
     
module bump(w,l){
{
 a=1.5;
 translate([0,l-w/2,0]) half(w,a,4);
 translate([0,w/2,]) mirror([0,1,0]) half(w,a,4);
 translate([0,l-w/2,0]) rotate([90,0,0]) line(w,a,4,l-w);
 translate([0,w/2,0]) rotate([90,0,180]) line(w,a,4,l-w);
}
}

color("red") 
 translate([
  outletExitWidth/2,
  outletCurveRadius+elbowWidth/2,
  outletExitHeight/2+outletCurveRadius])
  rotate([0,90,90])
   bump(outletExitHeight,outletExitWidth);
