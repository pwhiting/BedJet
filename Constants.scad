
screwSize=1;
screwOffset=10;   
$fn= $preview ? 0 : 100;

fit=4.3; // amount to add to size for overlapping tubes

// first section - the elbow connecting to the bedjet tube:

inletCurveRadius=10;  // curve radius
inletDiameter=82;   // radius
inletEntryLength=50;   // height before elbow
inletExitLength=50;   // length after elbow

etch=20; // distance from bottom to notch the model
depth=2; // depth of the etch


// second section - elbow plus transition to pill

circleToPillCurveRadius=5;      // curve radius
circleToPillEntryLength=30;      // height before elbow
circleToPillExitLength=30;      // length after elbow
circleToPillEntryDiameter=inletDiameter+fit;  // go on the outside of the part we connect to
circleToPillExitWidth=50;      // transition to an pill with minor dimmenson of 50
circleToPillExitHeight=130;     // transition to an pill with major dimmension of 150
            // area of new pill = w2*circleToPillExitLength-((w2/2)^2*(1-PI/4))
            
            
// third section (make 2)        

pipeLength=180;
pipeHeight=circleToPillExitWidth+4.3;
pipeWidth=circleToPillExitHeight+4.3;

// connector for two third sections (4th section)

couplerLength=50;
couplerWidth=pipeWidth+fit;
couplerHeight=pipeHeight+fit;

// pill elbow, constant size

elbowCurveRadius=5;  // curve radius
elbowWidth=circleToPillExitWidth;  // same size as part 2 output
elbowHeight=circleToPillExitHeight; 
elbowLength=30;

// connect this piece to P6 using another instance of part 3

outletExitHeight=30;
outletExitWidth=240;
outletCurveRadius=5;
outletEntryLength=50;   // height before elbow
outletExitLength=1;   // length after elbow
extrudedPillHeight=5;   // extrudedPill height

