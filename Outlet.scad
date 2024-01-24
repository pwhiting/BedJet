use <Library.scad>
include <Constants.scad>

elbow(outletWidth,outletHeight,outletWidth,outletHeight,outletCurveRadius);

translate([0,0,-outletEntryLength]) 
 extrudedPill(outletWidth,outletHeight,outletEntryLength,holeSize=screwSize,holeOffset=screwOffset);
 
 module half(w,r) {
  rotate_extrude(angle=180) {
   translate([w/2-r,0,0]) circle(r=r);
  }
}
   
module line(w,r,h) {
    linear_extrude(height=h) {
    translate([w/2-r,0,0])circle(r=r);     
    }
}
     
module bump(w,l){
{
 a=1;
 translate([0,l-w/2,0]) half(w,a);
 translate([0,w/2,]) mirror([0,1,0]) half(w,a);
 translate([0,l-w/2,0]) rotate([90,0,0]) line(w,a,l-w);
 translate([0,w/2,0]) rotate([90,0,180]) line(w,a,l-w);
}
}

color("red") 
 translate([
  outletWidth/2,
  outletCurveRadius+outletHeight/2,
  outletHeight/2+outletCurveRadius])
  rotate([0,90,90])
   bump(outletHeight,outletWidth);
