// This connects to part 1 at the base of the bed
// and not only changes direction, but shifts to 
// an pill from a circle.

use <Library.scad>
include <Constants.scad>


extendedElbow(circleToPillEntryDiameter,circleToPillEntryDiameter,circleToPillExitWidth,circleToPillExitHeight,circleToPillCurveRadius,align=1,
    entry=circleToPillEntryLength,
    exit=circleToPillEntryLength,
    holeSize=screwSize,
holeOffset=screwOffset
);
