$fn=100;

// Global
thickness=1.2;

/*********************************** Setup ***********************************/

// Exterior Dimensions
height=170;
length=109;
width=68;
bodyRadius=200;

// Interior dimensions
switchWallLength=25;
switchWallDistance=24;
supportWallHeight=10;
supportWallLength=72;
boardWallHeight=130;

// Other Variables
switchHoleRadius=10;
ledHoleRadius=1.5;
xlrHoleRadius=11.8;
xlrmHoleRadius=6;
sideHoleMargin=20;
sideHoleRadius=15;
sideHoleLength=length-2*sideHoleRadius-sideHoleMargin*2;
sideHoleHeight=height-2*sideHoleMargin-2*sideHoleRadius;
kRubinstein=8; // =)
legoHoleRadius=2.4;

// Body Exterior
module sideWall(){
    translate([0,-5,0]){
        intersection(){
            translate([-bodyRadius,-15,0]){
                difference() {
                    cylinder(h=height, r=bodyRadius, $fn=1000);
                    translate([0,0,thickness]){
                        cylinder(h=height-2*thickness, r=(bodyRadius-thickness));
                    }
                    rotate(180){
                        translate([5,0,0]){
                            cube([2*bodyRadius-width,2*bodyRadius,height*3], center=true);
                        }
                    }
                }  
            }
            translate([0,5,0]){
                cube([2*bodyRadius,length,2*height],center=true);
            }
        } 
    }
}

module hook(){
    difference(){
        cube([1.5*kRubinstein,1.5*kRubinstein,kRubinstein*2],center=true);
        translate([-kRubinstein/4,kRubinstein/4,0]){
            cube([kRubinstein,kRubinstein,kRubinstein*2],center=true);
        }
        translate([0,-kRubinstein/2,-kRubinstein*1.5]){
            rotate([45,0,0]){
                cube([kRubinstein*1.5,kRubinstein*2,kRubinstein*3],center=true);
            }
        }
    }
}

module hooks(){
    translate([-3*kRubinstein,-length/2-kRubinstein*0.75,height-switchWallLength]){
        hook();
    }
    translate([3*kRubinstein,-length/2-kRubinstein*0.75,height-switchWallLength]){
        mirror([1,0,0]){
            hook();
        }
    }
    translate([-3*kRubinstein,-length/2-kRubinstein*0.75,switchWallLength/2]){
        hook();
    }
    translate([3*kRubinstein,-length/2-kRubinstein*0.75,switchWallLength/2]){
        mirror([1,0,0]){
            hook();
        }
    }
}

module exteriorComponents(){
    translate([width/2,0,0]){
        sideWall();
    }
    translate([-width/2,0,0]){
        mirror([1,0,0]){
            sideWall();
        }
    }
    
    // Front wall
    translate([0,length/2-thickness/2,height/2]){
        cube([39,thickness,height],center=true);
    }
    
    // Back wall
    #translate([0,-length/2+thickness/2,height/2]){
        cube([61.5,thickness,height],center=true);
    }
}

module exterior(){
    
    // Back gutter cut-in
    difference(){
        exteriorComponents();
            translate([0,-length/2-kRubinstein/1.5,-kRubinstein/2]){
            cylinder(r=kRubinstein*0.9,h=height+kRubinstein);
        }
    }
    difference(){
        translate([0,-length/2-kRubinstein/1.5,-kRubinstein]){
            difference(){
                cylinder(r=kRubinstein,h=height+kRubinstein);
                cylinder(r=kRubinstein-thickness,h=height+kRubinstein);
            }
        }
        translate([0,-length/2-kRubinstein,height/2-kRubinstein/2]){
            cube([width,2*kRubinstein,height+kRubinstein],center=true);
        }
        translate([0,0,-kRubinstein/2]){
            cube([1.5*width,1.5*length,kRubinstein],center=true);
        }
    }
}

// Body Interior
module switchWall() {
    difference(){
        cube([thickness,switchWallLength,height],center=true);
        translate([0,-switchWallLength/2+3,height/2-(height-boardWallHeight)/2]){
            cube([thickness*2,6,height-boardWallHeight],center=true);
        }
    }
}

module switchWalls() {
    translate([(switchWallDistance+thickness)/-2,length/2-switchWallLength/2,height/2]){
        switchWall();
    }
    translate([(switchWallDistance+thickness)/2,length/2-switchWallLength/2,height/2]){
        switchWall();
    }
}

module supportWall() {
    cube([thickness,supportWallLength,supportWallHeight],center=true);
}

module supportWalls() {  
    translate([(switchWallDistance+thickness)/2,length/2-supportWallLength/2,supportWallHeight/2]){
        supportWall();
    }
    translate([(switchWallDistance+thickness)/-2,length/2-supportWallLength/2,supportWallHeight/2]){
        supportWall();
    }  
}

module boardWall() {
    difference(){
        translate([width/-2+thickness*0.75,length/2-supportWallLength,supportWallHeight]){
            cube([width-1.5*thickness,thickness,boardWallHeight]);
        }
        /*translate([1.8*kRubinstein,-15,height-(height-123-2*kRubinstein)]){
            cube([2*kRubinstein,thickness*10,height-120],center=true);
            /*minkowski(){
                cube([1,thickness*10,height-120-2*kRubinstein],center=true);
                rotate([90]){
                    cylinder(h=thickness*10, r=kRubinstein);
                }
            }
        }*/
        /*translate([-1.8*kRubinstein,-15,height-(height-123-2*kRubinstein)]){
            cube([2*kRubinstein,thickness*10,height-120],center=true);
            /*minkowski(){
                cube([1,thickness*10,height-120-2*kRubinstein],center=true);
                rotate([90]){
                    cylinder(h=thickness*10, r=kRubinstein);
                }
            }
        }*/
        
        // Board rigging holes
        translate([22,-8,15]){
            rotate([90]){
                cylinder(h=thickness*10, r=2.4);
            }
        }
        translate([22,-8,15+2*kRubinstein]){
            rotate([90]){
                cylinder(h=thickness*10, r=2.4);
            }
        }
        translate([22,-8,82]){
            rotate([90]){
                cylinder(h=thickness*10, r=2.4);
            }
        }
        translate([22,-8,82+2*kRubinstein]){
            rotate([90]){
                cylinder(h=thickness*10, r=2.4);
            }
        }
    }
    
    // Battery placeholders and strength'tens
    translate([-switchWallDistance/2-thickness/2,length/2-supportWallLength+thickness/2+1,supportWallHeight+45]){
        cube([thickness,thickness+2,90],center=true);
    }
    translate([switchWallDistance/2+thickness/2,length/2-supportWallLength+thickness/2+1,supportWallHeight+45]){
        cube([thickness,thickness+2,90],center=true);
    }
    
    // Temporary touch
    /*#translate([0,length/2-supportWallLength+thickness/2+1+40,height/2+supportWallHeight/2]){
        cube([55,thickness+2,height-supportWallHeight],center=true);
    }
    #translate([0,length/2-supportWallLength+thickness/2+1-25,height/2+supportWallHeight/2]){
        cube([63,thickness+2,height-supportWallHeight],center=true);
    }*/
      
}

module frontLoopCover() {   
    difference(){
        translate([0,length/2-switchWallLength/2,supportWallHeight]){
            cube([switchWallDistance,switchWallLength-12,supportWallHeight*2],center=true);
        }
        translate([-width/2,length/2-switchWallLength/2,supportWallHeight+thickness]){
            rotate([0,90]){
                cylinder(h=width, r=legoHoleRadius);
            }
        }
    } 
    translate([0,length/2-switchWallLength/2,thickness*2]){
        cube([switchWallDistance+2*thickness,switchWallLength-12,thickness*2],center=true);
    }
}

module backLoopBodyComponent() {
    translate([-2*kRubinstein,0,0]){
        cube([kRubinstein/2,switchWallLength/2,supportWallHeight*3],center=true);
    }
    translate([2*kRubinstein,0,0]){
        cube([kRubinstein/2,switchWallLength/2,supportWallHeight*3],center=true);
    }
}

module backLoopBody() {
    translate([0,-length/2+switchWallLength/4,height-1.5*supportWallHeight]){
        difference(){
            backLoopBodyComponent();
            translate([0,switchWallLength/4,-supportWallHeight-thickness*2]){
                rotate([-45,0,0]){
                    cube([width,switchWallLength,supportWallHeight*4],center=true);
                }
            }
            #translate([-width/2,0,kRubinstein]){
                rotate([0,90]){
                    cylinder(h=width, r=legoHoleRadius);
                }
            }
        }
    }
}

module backLoopCoverComponent() {    
    translate([2.5*kRubinstein,0,0]){
        cube([kRubinstein/2,switchWallLength/2,switchWallLength/2+2*thickness],center=true);
    }
    translate([-2.5*kRubinstein,0,0]){
        cube([kRubinstein/2,switchWallLength/2,switchWallLength/2+2*thickness],center=true);
    }
}
module backLoopCover() {
    translate([0,-length/2+switchWallLength/4,switchWallLength/4+2*thickness]){
        difference(){
            backLoopCoverComponent();
            #translate([-width/2,0,thickness]){
                rotate([0,90]){
                    cylinder(h=width, r=legoHoleRadius);
                }
            }
        }
    }
}

/*********************************** Output ***********************************/

module body() {
    hooks();
    difference(){
        exterior();
        
        // Switch hole cut
        translate([0,length/2-1.5*thickness,height/2]){
            rotate([0,90,90]){
                cylinder(h=thickness*10, r=switchHoleRadius);
            }
        }
        
        // LED hole cut
        translate([0,length/2-1.5*thickness,height/2-switchHoleRadius-kRubinstein]){
            rotate([0,90,90]){
                cylinder(h=thickness*10, r=ledHoleRadius);
            }
        }
        
        // Mini XLR hole cut
        translate([0,-length/2+xlrmHoleRadius+kRubinstein,-5*thickness]){
            difference(){
                rotate([0,0,90]){
                    cylinder(h=thickness*10, r=xlrmHoleRadius);
                }
                translate([-5.5-xlrmHoleRadius,-xlrmHoleRadius*1.5,0]){
                    cube([xlrmHoleRadius,3*xlrmHoleRadius,10]);
                }
            }
        }
        
        /* LEGACY */
        /* // Side walls cut     
        translate([-bodyRadius/4,-sideHoleLength/2-sideHoleMargin*0.25,sideHoleRadius+sideHoleMargin]){
            minkowski(){  
                cube([bodyRadius/2,sideHoleLength,sideHoleHeight]);
                rotate([0,90,0]){ 
                    cylinder(h=1, r=sideHoleRadius);
                }
            }
        }*/
        
        // Front loop exterior cuts
        translate([-width/2,length/2-switchWallLength/2,height-supportWallHeight]){
            rotate([0,90]){
                cylinder(h=width, r=5);
            }
        }
        // Back loop exterior cuts
        translate([0,-length/2,height-switchWallLength/4]){
            translate([2.5*kRubinstein,0,0]){
                cube([kRubinstein/2,switchWallLength/2,switchWallLength/2],center=true);
            }
            translate([-2.5*kRubinstein,0,0]){
                cube([kRubinstein/2,switchWallLength/2,switchWallLength/2],center=true);
            }
        }
    }
    
    // Front loop interior cuts
    difference(){
        switchWalls();
        #translate([-width/2,length/2-switchWallLength/2,height-supportWallHeight]){
            rotate([0,90]){
                cylinder(h=width, r=legoHoleRadius);
            }
        }
    }
    supportWalls();
    boardWall();
    backLoopBody();
}

module cover(){
    
    translate([0,0,0]){
        difference(){
            exterior();
            translate([0,0,height/2+thickness]){
                cube([width,length*1.5,height],center=true);
            }
            // XLR hole + rigging holes cut
            translate([0,-length/2+xlrHoleRadius+kRubinstein,-5*thickness]){
                rotate([0,0,90]){
                    cylinder(h=thickness*10, r=xlrHoleRadius);
                }
            }
            translate([9.5,-length/2+xlrHoleRadius+kRubinstein+12,-5*thickness]){
                rotate([0,0,90]){
                    cylinder(h=thickness*10, r=1.5);
                }
            }
            translate([-9.5,-length/2+xlrHoleRadius+kRubinstein-12,-5*thickness]){
                rotate([0,0,90]){
                    cylinder(h=thickness*10, r=1.5);
                }
            }
            
            // Topview hole cut
            /*translate([0,length/2-13-30,-5*thickness]){
                rotate([0,0,90]){
                    cylinder(h=thickness*10, r=13);
                }
            }*/
        }
    }
    frontLoopCover();
    backLoopCover();
}

/*difference(){
    body();
    
    // Cover placeholder
    translate([0,0,height]){
        cube([1.5*width,1.5*length,thickness*2],center=true);
    }
}*/
cover();