//------------------------------------------------------------
//---- 3D printed pieces for Scalable Foldarap 3D printer ----
//------------------------------------------------------------
// (c) 2018-2019 Isidoro Gayo Vélez (isidoro.gayo@gmail.com)

// Credits:
//-- Enmanuel Gillot

//------------------------------------------------------------
//-- Released under the terms of GNU/GPL v3.0 or higher
//------------------------------------------------------------


module x_motor_holder(profile=wslot,
                        thick=5,
                        hg=40,
                        daxis=32,
                        stepper=stepper,
                        ssize=6){

// profile = profile dimensions; 20 = 20x20, 22 = 22x22 and so...
// thick = thickness of motor holder plate
// hg = holder height in mm
// stepper = type of stepper motor; NEMA14 or NEMA17

        
    // NEMA motor fastener
    NEMA = stepper==14 ? NEMA14 : NEMA17;
    zoffset = stepper==14 ? +(NEMA17-NEMA14)/2 : 0;
                        
    difference(){
        union(){
            //main body
            mirror([0,1,0])
            translate([-2*thwall-profile-3.5,-28,0])
                x_motor_idler(hg=hg,
                                daxis=daxis,
                                ssize=ssize,
                                idler=false);

            translate([-thick+thwall-0.5-ease/2,
                        -NEMA/2,
                        NEMA/2+zoffset])
            rotate([0,-90,180])
                motor_plate(stepper=stepper,
                            thick=thick+ease/2,
                            notch=true,
                            chamcor=false);
            // extra piece down the motor plate only for NEMA14
            if(stepper==14){
                translate([-thick+thwall-0.5-ease/2,-NEMA14,0])
                    cube([thick+ease/2,NEMA14+ease,(NEMA17-NEMA14)/2]);
                // uncoment the following three lines if are 
                // obtaining extrange behaviour with your slicer
                color("orange")
                translate([-thick+thwall-0.5-ease/2,
                            -1,(NEMA17-NEMA14)/2])
                    cube([thick+ease/2,2,NEMA]);
            }
        }
        // room for belt
        translate([6.25,-1.2*profile,hg/2])
        rotate([-90,0,0])    
        hull(){
            for(p=[5.5,-5.5]){
                translate([0,p,0])
                    cylinder(h=3*profile+2,r=6.6,$fn=4);
            }
        }  
        // fixing nuts recess for wire fastener
        #translate([-thick/2+thwall-0.5,-NEMA/2,-1])
        for(y=[-8,8]){
            translate([0,y,4]){
                cylinder(h=10,r=1.6,center=true);
                cube([thick+2,5.2,3.2],center=true);
            }
        }
    }
}


module x_motor_idler(profile=wslot,
                    lprofile=lslot,
                    ssize=6,
                    hg=NEMA17,
                    daxis=32,
                    idler=true,
                    bowden=false){

// profile = profile dimensions; 20 = 20x20, 22 = 22x22 and so...
// lprofile = profile lenght when is not square-shape, in mm
// hg = idler height in mm.
// daxis = distance between smooth rods, in mm.
// ssize = size of aluminium slot; e.g., for 20x20 type I
        // profiles this value is 6mm, 15x15 openbeam is only 3mm.
// idler = if this piece is going to be and idler motor or not
// bowden = if it needs a bowden extruder or not. 
        // Bowden is for NEMA17 motors only.
                        
    yoffset = idler ? profile : 0;
    NEMA = stepper == 14 ? NEMA14 : NEMA17;
    
    union(){
        // main body
        // slot clamp
        translate([profile+2*thwall,profile+2*thwall,0])
        rotate([0,0,180])
            slot_clamp(h=hg,ssize=ssize);

        // middle body
        difference(){
            translate([3*thwall+profile+NEMA/2,NEMA/2+thwall,0])
            hull(){
                cylinder(h=hg,r=7.5);
                translate([-NEMA/2-thwall-ease/2,-7.5,0])
                    cube([1,15,hg]);
            }
           
            // belt and smooth rods drills
            // when idler true, through hole
            #translate([4*thwall+profile+3,-profile+yoffset,0])
            union(){
                // room for belt
                translate([0,0,hg/2])
                rotate([-90,0,0])    
                hull(){
                    for(p=[5.5,-5.5]){
                        translate([0,p,0])
                            cylinder(h=3*profile+2,r=6.6,$fn=4);
                    }
                }
                // smooth rod drills
                translate([0,0,(hg-daxis)/2])
                rotate([-90,0,0])
                for(y=[0,-daxis]){
                    translate([0,y,0])
                        cylinder(h=2*thwall+profile+16,r=rrod);
                }
            }
            // M5 nut clamp
            translate([NEMA/2+3*thwall+profile,
                        (NEMA+2*thwall)/2,-1])
            union(){
                cylinder(h=hg+2,r=2.5);
                translate([-5,-4-ease,hg-10])
                linear_extrude(height=5+ease)
                    square([profile,8+2*ease]);
            }
        }
    }
    // belt tensioner holder
    if(idler){
        difference(){
            translate([2*thwall+profile+2,NEMA/2+thwall+7.5,0])
            linear_extrude(height=hg)    
            offset(delta=2,chamfer=true)
                square([NEMA/2-2,thwall-2]);
            // M3 fixing screw
            translate([NEMA/2+profile,NEMA/2+thwall,hg/2])
            rotate([-90,0,0])
                cylinder(h=profile,r=1.6);
        }
    }
    // bowden support
    if(bowden){
        translate([thwall,NEMA+2*thwall+12,NEMA17/2])
        rotate([0,90,0])
            motor_plate(stepper=17,thick=thwall);
        // extra reinforcement
        translate([thwall,2*thwall+profile,0])
            cube([thwall+profile+1.5,9.5,hg]);
        translate([thwall,2*thwall+profile+9.5,0])
            cube([thwall,2,hg]);
    }
}


module x_endstop_holder(daxis=32){

//  daxis = distance between smooth rods
    
	difference(){
		union(){
			hull(){
				// union bridge between clamps
				translate([10,0,0])
                    cube([5,daxis,10]);
				// smooth rod clamps
				for(y=[0,daxis]){
					translate([0,y,0])
                        cylinder(h=10,r=5);
				}
                // endstop holder
                translate([14,daxis/2,0])
                    cylinder(h=10,r=5);
			}
			
		}
		// room for smooth rods
		translate([0,0,-5])
        for(y=[0,daxis]){
			translate([0,y,0])
                cylinder(h=20,r=3.05);
		}
	// room for belt
	translate([-11.5,-10,-5])
        cube([10,50,20]);
	translate([-12,5,-5])
        cube([20,daxis-10,20]);
	// M3 drill for screw holder
	translate([14,daxis/2,-5])
            cylinder(h=20,r=1.2);
	}
}



module x_belt_clamp(wb=1.1){
// Auxiliar module, not directly used.
// wb = belt thickness
    
    // main body
    union(){
        hull(){
            cylinder(h=15,r=4,$fn=30);
            translate([-5,-3,0])
                cylinder(h=15,r=1,$fn=30);
        }
        translate([-20,-4,0])
            cube([20,2.5*wb,15]);
    }
    // screw drill
    translate([0,0,-6])
        cylinder(h=30,r=1.6,$fn=30);
    // bevel for ease belt placement
    translate([0,-3,11])
    rotate([0,-90,0])
        cylinder(h=16,r=2,$fn=4);
    
    translate([0,0,6.5])
        cylinder(h=6,r1=2,r2=6);
    
}


module x_carriage(wbelt=0.8,daxis=32,wd=40,th=15){

// wbelt = belt thickness
// daxis = distance between smooth rods in mm
// wd = carriage lenght form left to right in mm
// th = carriage thickness in mm
    
    // fake bearings and rods, just for reference
    %union(){
        // LM6UU bearing and smooth rod (upper)
        translate([0,8,9])
        rotate([0,90,0])
            cylinder(h=wd,r=6.1);
        translate([-20,8,9])
        rotate([0,90,0])
            cylinder(h=2*wd,r=3);
        // LM6UU bearing and smooth rod (lower)
        translate([0,daxis+8,9])
        rotate([0,90,0])
            cylinder(h=wd,r=6.1);
        translate([-20,daxis+8,9])
        rotate([0,90,0])
            cylinder(h=2*wd,r=3);
	}
    
    difference(){
        // base
        cube([wd,daxis+21,th]);
        
        // bearing clamps
        for(offset=[0,daxis]){
            translate([-1,offset+8,9])
            rotate([0,90,0])
                cylinder(h=wd+2,r=6.1);
            translate([-1,offset-2,9])
                cube([wd+2,14,rbearing+1]);
        }
        // belt room
        translate([-1,25.5,4])
            cube([wd+2,5,th+2]);
        // belt clamps
        for(feat=[[0,0],[12,1]]){
            translate([feat[0]+14,20,4])
            mirror([feat[1],0,0])
                x_belt_clamp(wb=wbelt);
        }
        // screw drill and screw head hole
        // upper M3 drills
        for(pos=[[8.5,48.5,-3],[31.5,48.5,-3]]){
            translate(pos){
                cylinder(h=25,r=1.6);
                cylinder(h=5,r=3.4);
            }
        }
        // x endstop drills
        for(x=[5,35]){
            translate([x,22,12])
                cylinder(h=15,r=1.2);
        }
        // upper central slot for motor wires
        translate([wd/2,daxis+23.5,-1])
            cylinder(h=th+2,d=10);
        // Some rounded corners
        translate([35,daxis+16.1,-10])
            rounded_corner();
        translate([5,daxis+16.1,-10])
        rotate([0,0,90])
            rounded_corner();
    }
    // these parts are for avoiding loose LM bearings
    for(x=[15,24]){
        for(y=[0,30]){
            translate([x,y,0])
                cube([1,2*rbearing,3.5]);
        }
    }
}


module extruder_wire_fastener(){

// collects all wires coming from extruder
    
    difference(){
        union(){
            hull(){
                cube([40,31,thwall]);
                translate([10,0,0])
                rotate([-20,0,0])
                    cube([20,5,25]);
            }
            hull(){
                translate([0,31,4])
                rotate([0,90,0])
                    cylinder(h=40,d=8);
                translate([0,27,0])
                    cube([40,8,thwall]);
            }
        }    
        // M3 fixing screws
        for(z=[[[14,20,-2],10,1.6],
                [[14,20,2],5,3.2],
                [[26,20,-2],10,1.6],
                [[26,20,2],5,3.2]]){
            translate(z[0])
                cylinder(h=z[1],r=z[2]);
        }
        // endstop adjustement drill
        translate([-1,31,4])
        rotate([0,90,0])
            cylinder(h=42,r=1.46);
        // wires recess
        translate([20,-8,-1])
        rotate([-20,0,0])
            cylinder(h=40,r=10);
        // room for zip-ties
        translate([20,-2,15])
        rotate([-20,0,0])
        difference(){
            cylinder(h=20,r=13,center=true);
            cylinder(h=27,r=11,center=true);
            cylinder(h=10,r=15,center=true);
        }
        // for cosmetics and saving filament/printing time
        for(feat=[[[20,35,5],40,3],
                    [[20,44,-1],40,5]]){
            translate(feat[0])
                hollow(lg=20,hg=50,wd=feat[1],rd=feat[2]);
        }
        for(x=[0,40]){
            translate([x,10,0])
            rotate([0,90,90])
                teardrop(radius=8,angle=-90);
            
            translate([x,0,-5])
                beveled_hollow(lg=16,wd=25,hg=60,rd=3);
        }
        // flat soil contact point
        translate([-5,-5,-10])
            cube([50,50,10]);
    }
}


module x_wire_fastener(){

// collects all wires comming from
// extruder, x motor and endstop
    
    difference(){
        // base
        linear_extrude(height=5)
        offset(delta=3,chamfer=true)
            square([20,35],center=true);
        // M3 fixing screw drills
        for(x=[-8,8]){
            for(feat=[[7,1.6],[4,3.2]]){
                translate([x,0,-1])
                    cylinder(h=feat[0],r=feat[1]);
            }
        }
        // wire recess
        translate([0,0,-8])
        rotate([-90,0,0])
            cylinder(h=50,d=20,center=true);
        // room for zip-ties
        for(y=[-14,14]){
            translate([0,y,-7])
            rotate([-90,0,0])
            difference(){
                cylinder(h=5,r=13,center=true);
                cylinder(h=7,r=11,center=true);
            }
        }
    }
}
