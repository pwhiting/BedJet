
// we need to calculate the distance from origin each pill (stadium) 
// will be at.
// if you hold the center point of the pill constant you get some weird
// shapes as it move around the elbow. Instead, you calculate the distance
// from the center to the edge facing the origin and then use that to figure
// out how to keep the inside edge constant distance from the origin.


// polar form for the radius of an intermediatePill
// we want the inner edge of the pills to track the path of
// an intermediatePill which starts at y1 and ends at y2 (which will
// be rotated by 90 degrees so it will be on the y axis at the
// end...
// https://en.wikipedia.org/wiki/intermediatePill#Polar_form_relative_to_focus
function radius(a,b,angle) = (a*b)/sqrt(b^2*cos(angle)^2+a^2*sin(angle)^2);

// area in the pill is both halfs of the cirle plus the box
// made by removing the diameter of the circle from the long axis
function area2(x,y) = (min(x,y)/2)^2*PI+(max(x,y)-min(x,y))*min(x,y);
// area of the big rectangle (x*y) minus the 2 circle cutouts which 
// is the minor axis square (min*min) minus circle (min*min)PI/4
function area(x,y) = x*y-(min(x,y)^2*(1-PI/4));
//function area2(x,y) = 2*x*y + PI*min(x,y)^2;

// this is the difference in the area between two pills
function delta_area(x1,y1,x2,y2) = area(x2,y2)-area(x1,y1);

// draw a pill, height .001.
// x is the width of the pill - its projection on the x-axis
// y is the height of the pill - projection on the y-axis
// pill is created by taking two half cicles and putting 
// a rectangle between them
// I use x,y to be the full extent of the pill.
module pill(x,y) {
 r=min(x,y); // w is now the minor dimmension
 a=max(x,y)-r; // l is now the major dimmension
 rotate([0,0,(x>y)?0:90]) // reorient if needed
 union() {
  translate([a/2,0,0]) scale([r/100,r/100,1]) cylinder(.001,d=100);
  translate([-a/2,0,0]) scale([r/100,r/100,1]) cylinder(.001,d=100);
  translate([0,0,.0005]) cube([a,r,.001],center=true);
 }
}

// length, width, and height should be thought about
// as if looking at the end of the pipe on normal 2D
// graph with the pill facing you - width is the extent
// alone the x-axis and height the y-axis. The length
// of the pipe is how far it extrudes in the unseen 
// z-axis
// put a screw hole diameter holeD and holeOffset from the xy plane
module extrudedPill(width,height,length,thickness=4,holeSize=0,holeOffset=0,reflectHoles=0) {
 difference() {
  linear_extrude(length) {
   projection() difference() {
    pill(width,height);
    pill(width-thickness,height-thickness);
   }
  }
  copy_translate([0,0,(length-2*holeOffset)*reflectHoles])
  translate([0,0,holeOffset]) union(){
   rotate([90,0,0]) cylinder(h=height,r=holeSize,center=true);
   rotate([0,90,0]) cylinder(h=width,r=holeSize,center=true);
  }
 }
}

module copy_translate(vec){
    children();
    if(vec[0]||vec[1]||vec[2]) {
     translate(vec)
     children();
    }
}

// Don't rotate it by angle, but figure out the size
// assume the elbow is 90 degrees - add an argument later
// if this isn't a good assumption.
// x1,y1 are the starting width,height and
// x2,y2 are the ending width,height
// angle is how much it will be rotated eventually
// align indicates if the pills will be aligned on
// the right side
// below could be adjusted to calculate y or x based
// on the required dimmensions to make each elipse 
// have the same area. could approximate this as
// PI*width*height
// a1=pi*x1*y1
// a2=pi*x2*y2
// at angle we should be angle/90 % done
// a=a1+(a2-a1)*angle/90
// y=a/x
// this overestimates needed y dimemsion slightly
// because the area of an intermediatePill is slightly 
// less than the area of a rectangle with two
// half circles attached to the end...
module intermediatePill(x1,y1,x2,y2,angle,align=0) {
 y=radius(y1,y2,angle);
 a1=PI*x1*y1;
 a2=PI*x2*y2;
 a=a1+(a2-a1)*angle/90;
 x=a/(y*PI);
 echo("segment crossesction area: ",area(x,y));
 translate([(x1-x)/2*align,y/2,0]) pill(x,y);
}


// x1,y1,x2,y2,align as above. 
// cr is the curve radius
module solid_elbow(x1,y1,x2,y2,cr,align=0) {
echo("curve radius:",cr,x1,y1,x2,y2);
sides=(($fn>0)?$fn:9);
rotate([0,0,180])
translate([0,-y1/2-cr,0]) 
 for(i=[0:sides-1]) {
 angle=i*90/sides; 
 rotate([angle,0,0])
  hull(){
   translate([0,cr,0]) intermediatePill(x1,y1,x2,y2,angle,align);
   rotate([90/sides,0,0])
     translate([0,cr,0]) 
       intermediatePill(x1,y1,x2,y2,(i+1)*90/sides,align);
  }
 } 
}

// x1,y1,x2,y2,cr,align as above
// t = thickness
module elbow(x1,y1,x2,y2,cr,align=0, t=4) {
echo("curve radius:",cr,x1,y1,x2,y2)
 difference() {
  solid_elbow(x1,y1,x2,y2,cr,align);
  solid_elbow(x1-t,y1-t,x2-t,y2-t,cr+t/2,align);
 }
}

// raise is the height of the pipe on the bottom
// extend with the amount the final piece goes toward you
module extendedElbow(x1,y1,x2,y2,cr,align=0,t=4,entry=0,exit=0,holeSize=0,holeOffset=0)
{
 translate([0,0,entry*0])
 union(){
  elbow(x1,y1,x2,y2,cr,align,t);
  translate([0,0,-entry])extrudedPill(x1,y1,entry,holeSize=holeSize,holeOffset=holeOffset);
  translate([(x2-x1)/2*align,y1/2+cr+exit,y2/2+cr])
  rotate([90,0,0])
  extrudedPill(x2,y2,exit,holeSize=holeSize,holeOffset=holeOffset);
 }
}


