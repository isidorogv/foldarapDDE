//------------------------------------------------------------
//--    3D printed pieces for Mini Foldarap 3D printer
//------------------------------------------------------------
// (c) 2018-2019 Isidoro Gayo Vélez (isidoro.gayo@gmail.com)

// Credits:
//-- Enmanuel Gillot

//------------------------------------------------------------
//-- Released under the terms of GNU/GPL v3.0 or higher
//------------------------------------------------------------


module y_motor_pulley_holder(thick=5,stepper=14){
    
    NEMA = stepper==14 ? [NEMA14,26,24] : [NEMA17,31,24];
    
    difference(){
        union(){
            // support base for first pulley
            translate([0,0,0])
            rotate([0,0,180])
            motor_plate(thick=thick,
                        stepper=stepper,
                        half=true,
                        chamcor=false);    
            // support for second pulley
            translate([NEMA[1]/2+10,0,0])
            hull(){
                translate([4,3,0])
                    cylinder(h=thick,d=15);
                translate([-7,-NEMA[0]/2,0])
                    cube([1,NEMA[0],thick]);
            }
        }
        // drills for fixing pulley screw
        translate([NEMA[1]/2+14,3,-1]){
            cylinder(h=thick+2,r=1.6);
            cylinder(h=4,r=3.2,$fn=6);
        }
    }
    
    // fake synchronic bearing
        for(pos=[[NEMA[1]/2,NEMA[1]/2,5],
                [NEMA[1]/2+14,3,5]]){
            %translate(pos)
            union(){
                cylinder(h=1,d=14);
                cylinder(h=9,d=10);
                translate([0,0,8])
                    cylinder(h=1,d=14);
            }
        }
}


module hotend_holder(){

        difference(){
        // Preform
        union(){
            // Extruder fixing body
            translate([0,6,0])
                cube([40,46,5]);
            // Contact plane carriage-holder
            translate([0,39,0])
                cube([40,13,20]);
            // reinforcement
            translate([0,34,10])
            rotate([0,90,0])
                rounded_corner(lg=40,rd=5);
        }
        // hotend head room
        translate([20,39,20])
        rotate([-90,0,0])
        union(){
            translate([0,0,9])
                cylinder(h=5,d=16+ease);
            translate([0,0,-1.5])
                cylinder(h=5,d=16+ease);
            cylinder(h=13,d=12.5+ease);
        }
        // M3 nut holes for hotend
        translate([20,45.5,16])
        for(x=[-15,15]){
            translate([x,0,0])
            union(){
                cylinder(h=15,r=1.6,center=true);
                cube([5.5,15,3],center=true);
            }
        }
        // Fixing holes for M3 screw + nut...
        for(feat=[[[14,20,-1],10,1.6,60],
                    [[14,20,2],5,3.2,6],
                    [[26,20,-1],10,1.6,60],
                    [[26,20,2],5,3.2,6]]){
            translate(feat[0])
                cylinder(h=feat[1],r=feat[2],$fn=feat[3]);
                        
        }
        // ... and upper ones
        // left and right
        for(pos=[[[5.75,45,2],[8.5,48.5,-4]],
                [[28.75,45,2],[31.5,48.5,-4]]]){
            translate(pos[0])
                cube([5.5,10,3]);
            translate(pos[1])
                cylinder(h=12,r=1.6);
        }
        // Hole for x endstop
        for(x=[5,35]){
            translate([x,22,-5])
                cylinder(h=15,r=1.2);
        }
        // bevel upper corners
        translate([20,47,-5])
        for(pos=[[[15,0,0],[0,0,0]],
                [[-15,0,0],[0,0,90]]]){
            translate(pos[0])
            rotate(pos[1])
                rounded_corner(lg=30);
        }
        // lower bevel
        translate([-5,11,0])rotate([0,-90,180])
            rounded_corner(lg=50);
    }
}


module hotend_holder_collar(){
    
    difference(){
        union(){
            cylinder(h=13,r=12);
            translate([-18,-5,0])
            linear_extrude(height=13)
            offset(delta=2,chamfer=true)
                square([36,6]);
        }
        // hotend head room
        union(){
            translate([0,0,9])
                cylinder(h=5,d=16+ease);
            translate([0,0,-1.5])
                cylinder(h=5,d=16+ease);
            cylinder(h=13,d=12.5+ease);
        }
        // M3 fixing screw
        translate([0,0,6.5])
        rotate([90,0,0])
        for(x=[-15,15]){
            translate([x,0,-1])
                cylinder(h=10,r=1.6);
        }
        // bevel upper corners
        for(pos=[[[15,1,8],[90,0,0]],
                [[-15,1,8],[90,-90,0]]]){
            translate(pos[0])
            rotate(pos[1])
                rounded_corner(lg=10);
        }
        // remove unused part
        translate([-30,0,-2])
            cube([60,20,20]);
    }
}


module mini_board_holder(profile=wslot,rd=4){
    
    difference(){
        hull(){
            for(x=[11,-11]){
                translate([x,0,0])
                    cylinder(h=profile+thwall,r=rd);
            }
        }
        // M3 fixing slot screw
        translate([-profile/2,0,-1])
            cylinder(h=profile+thwall+2,r=1.6);
        // M3 fixing board screw
        #translate([11,0,-1])
            cylinder(h=profile+thwall+2,r=1.3);
        // room for slot
        translate([-profile-1,-rd,thwall])
            cube([profile+1,2*rd,profile+thwall+2]);
    }
    // fake aluminium profile
    %translate([-profile,-25,thwall])
        cube([profile,50,profile]);
}


module PSU_switch_plate(hg=span+2*wslot,wd=50){
    
// hg = plate size from top to bottom in mm
// wd = plate size from left to right in mm
    ws=13;  // switch widht in mm
    ls=19;  // switch lenght in mm
    rp=4; // power plug radius in mm
    
    difference(){
        // base plate
        linear_extrude(height=thwall)
        offset(delta=3,chamfer=true)
            square([wd-6,hg-6],center=true);
        // room for power switch
        translate([-1.5*ws,-ls/2-3,-1])union(){
            translate([0,3,0])
            linear_extrude(height=thwall+2)
                square([ws+ease,ls+ease]);            
            translate([0,0,2])cube([ws+ease,ease+ls+6,thwall]);
        }
        // drill for power plug
        translate([2.5*rp,0,-1])
        linear_extrude(height=thwall+2)
            // plug radius plus 0.1 mm
            circle(r=rp+0.1,$fn=30);
        translate([2.5*rp,0,1])
        linear_extrude(height=thwall+2)
            circle(r=rp+1.6,$fn=30);
        // M3 fixing screws
        for(x=[wd/2-8,-wd/2+8]){
            for(y=[(hg-wslot)/2,-(hg-wslot)/2]){
                translate([x,y,-1])cylinder(h=thwall+2,r=1.6,$fn=30);
            }
        }
    }
}

