include <Constants.scad>
use <Library.scad>

translate([0,0,-couplerLength]) extrudedPill(couplerWidth,couplerHeight,couplerLength,
 holeSize=screwSize,holeOffset=screwOffset,reflectHoles=1); 
