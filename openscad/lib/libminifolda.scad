//------------------------------------------------------------
//--    3D printed pieces for Mini Foldarap 3D printer
//------------------------------------------------------------
// (copyleft) 2018-2019 Isidoro Gayo Vélez 
// <isidoro.gayo@gmail.com>

// Credits:
//-- Enmanuel Gillot

//------------------------------------------------------------
//-- Released under the terms of GNU/GPL v3.0 or higher
//------------------------------------------------------------


module mini_board_holder(profile=wslot,rd=4){
    
    difference(){
        hull(){
            for(x=[5,-11]){
                translate([x,0,0])
                    cylinder(h=profile+2*thwall,r=rd);
            }
        }
        // M3 fixing slot screw
        translate([-profile/2,0,-1])
            cylinder(h=profile+thwall+2,r=1.6);
        // M3 fixing board screw
        #translate([0,0,1.4*profile])
        rotate([0,15,0]){
            translate([-0.5*profile,-profile/2,0])
                cube([2*profile,profile,profile]);
            translate([5,0,-5.5])
                cylinder(h=6,r=1.3);
        }
        // room for slot
        translate([-profile-1,-rd,thwall])
            cube([profile+1,2*rd,profile+thwall+2]);
    }
    // fake aluminium profile
    %translate([-profile,-25,thwall])
        cube([profile,50,profile]);
    // fake board
    %translate([0,-50,profile+3])
    rotate([0,15,0])
        cube([70,100,2]);
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

