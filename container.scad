height=40;
$fn=90;
r=12; // container radius
sr=50/2; // spool hole radius
wall=2;
slot=2;
gap=.2;
hole_size=1.5;
holes=12;
 
module container(radius,height=height,button=true) {
 difference(){
  cylinder(h=height,r=radius,center=true);
  cylinder(h=height+10,r=radius-wall,center=true);
  mir([0,0,1])
   for(j=[0:hole_size:height/2.1])
    translate([0,0,j])
    for(i=[0:180/holes:180-1])
     rotate([90,0,i+180/(holes*2)*(j/hole_size%2)])
      cylinder(h=r*2,r=hole_size/2,center=true,$fn=30);
  }
//
//  rotate([0,0,45])difference(){
//   for(i=[0:18:360])
//    rotate([0,0,i])
//    cube([2,100,height-wall*4],center=true);
//   for(i=[0:.25:1])
//    translate([0,0,(height-wall)*(i-.5)])
//     cube([100,100,2],center=true);
//   }
//  }
  if(button && 0)
  for(i=[0:90:360])
   rotate([0,0,i])
    translate([radius-.5,0,height/2-wall]) sphere(1,$fn=40);
 }
 
 module bottom(){
 difference(){
  union(){
   container(r,button=false);
   vwall();
   translate([0,0,-height/2+1]) {
     cube([wall,2*(sr+5),2],center=true);
     cube([2*(sr+5),wall,2],center=true);
     }
  }
  cylinder(h=100,r=r-wall,center=true);
  }
  translate([0,0,-height/2]) base(sr+5);
 }
 
 
 
 module mir(p) {
  mirror(p) children();
  children();
 }
 
 
 module vwall() {
  mir([1,1,0])
   difference(){
   cube([wall,sr*2,height],center=true);
   for(j=[0:sr/7.8:sr-1]){
    mir([0,1,0]) translate([0,j,0])
     difference(){
     cube([sr,slot,height-wall*4],center=true);
     for(i=[0,.475]){
      mir([0,0,1]) 
       translate([0,0,height*i/2]) 
        cube([sr,slot,2],center=true);
     }
    }
   }
  }
 }
   
//        for(i=[0:.25:1])
//      translate([0,0,(height-wall)*(i-.5)])
//       cube([100,100,2],center=true);
//     
 
 
 module top(){
  container(r-(wall+gap));
  translate([0,0,-height/2])
   base(sr+5);
  translate([0,0,-height/2+1]) {
    difference(){
     union(){
      cube([wall,2*(sr+5),2],center=true);
      cube([2*(sr+5),wall,2],center=true);
     }
     cylinder(h=100,r=r-(wall+gap),center=true);
    }
   }
 }
 
module cap2(){
 rotate([180,0,0]){
  container(r-2*(wall+gap),8);
  translate([0,0,-8/2]){
   base(r-(wall+gap/2));
   knob(r-2*(wall+gap/2));
  }
 }
}


module cap(){
 container(r-2*(wall+gap),8);
 translate([0,0,-8/2]) base(r-(wall+gap/2));
}

module base(radius) {
 difference(){
  cylinder(h=wall,r=radius,center=true);
  intersection(){
   cylinder(h=wall+1,r=radius-wall,center=true);
   for(i=[-radius:hole_size*1.5:radius])
    for(j=[-radius:hole_size*1.5:radius])
     translate([i,j,0])
     cylinder(wall+1,r=hole_size/2,center=true,$fn=30);
  }
  
//  
//  difference(){
//   cylinder(h=wall*2,r=radius-wall*2,center=true);
//   for(i=[0:slot*2:radius]) {
//    translate([0,i,0]) cube([radius*2,slot,slot*2],center=true);
//    translate([0,-i,0]) cube([radius*2,slot,slot*2],center=true);
//    translate([i,0,0]) cube([slot,radius*2,slot*2],center=true);
//    translate([-i,0,0]) cube([slot,radius*2,slot*2],center=true);
//    }
//  }
 }
}

translate([(sr+5.5)*2,0,height/2]) top();
translate([sr*1.2,sr*1.3,4-wall/2]) cap();
translate([0,0,height/2]) bottom();


module knob(radius) {
 scale([1,1,.65])
 rotate([-90,0,0])
 rotate_extrude(angle=180){
  translate([radius/2,0,0])square([radius,wall*1.5],center=true);
  translate([radius,0,0])circle(wall);
 }
}

