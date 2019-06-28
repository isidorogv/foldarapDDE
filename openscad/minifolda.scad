//------------------------------------------------------------
//---- 3D printed pieces for Scalable Foldarap 3D printer ----
//------------------------------------------------------------
// (c) 2018-2019 Isidoro Gayo Vélez (isidoro.gayo@gmail.com)

// Credits:
// -- Enmanuel Gillot, for his superb fodable 3D printer

//------------------------------------------------------------
//      Released under the terms of GNU/GPL v3.0 or higher
//------------------------------------------------------------

include <lib/core.scad>
include <lib/misc.scad>
include <lib/X_axis.scad>
include <lib/Y_axis.scad>
include <lib/Z_axis.scad>
include <lib/extruder.scad>
include <lib/libminifolda.scad>


// Parameters to modify. 
// Try to NOT modify variables in other places.
NEMA14=34;      // NEMA14 width in mm
NEMA17=42;      // NEMA17 width in mm
wslot=15;		// aluminium slot width
lslot=wslot;     // aluminium slot height in mm
thwall=3.5;     // wall thickness
span=NEMA17;    // span between horizontal profiles on Y axis
footl=2.5*wslot;// foot lenght
ease=0.2;       // clearance to fit the aluminum profile easier
stepper=14;     // NEMA stepper type to be used

lbearing=19;    // bearing lenght in mm
rbearing=6;     // bearing radius in mm
rrod=3;         // smooth rod radius in mm
drod=87;        // distance between Y rods in mm
bhole=100/2;  // M3 hole distance from bed center


$fn=50;



  
// --------- MiniFolda parts --------


// ========
//  X axis
// ========

//mirror([0,1,0])
//translate([-3*thwall-wslot,2*thwall+wslot,0])
    //x_motor_idler(ssize=3,bowden=true);

//mirror([0,1,0])
    //x_motor_holder(hg=NEMA17,ssize=3,daxis=32,thick=6.5);

//x_carriage(daxis=32);

//extruder_wire_fastener();

//rotate([0,180,0])
  //  x_wire_fastener();

//x_endstop_holder();
//knob(thk=4,dia=12,nk=8,dk=3);

//rotate([-90,0,0])
    //sync_bearing_holder();
//knob(thk=8,dia=10,nk=8,dk=2);




// ========
//  Y axis
// ========

//mirror([0,1,0])
  //  foot();

//mini_board_holder();

//mirror()
  //  y_motor_holder(thick=10,mt=3);
/*
%translate([-50,(span+2*wslot-6)/2-wslot/2+3-wslot/2,5])
cube([100,wslot,wslot]);*/
//y_motor_idler(mt=3);
//knob(thk=8,dia=12,nk=8,dk=2.5);

//rotate([-90,0,0])
  //  sync_bearing_holder();

//y_rod_holder(bl=24,mt=3);

//y_bearing_clamp(h=18);

//translate([0,0,6])
    //frog();

//PSU_switch_plate();

//y_endstop_adj(hg=35,mt=3);
//knob(thk=4,dia=12,nk=8,dk=3);

/*
difference(){
y_belt_clamp(cs=2*lbearing+4,ch=22,bthk=0.9);
translate([0,-5,-1])
    hollow(lg=16,wd=10,rd=2,hg=14);
}
*/




// ========
//  Z axis
// ========

//mirror([0,1,0])
  //  z_motor_holder(mt=3);

//z_upper_joint(mt=3);

//rotate([-90,0,0])
  //  z_hinge_outter(bsd=6,ssd=5,mt=3);
//z_hinge_inner(lg=50,sw=3,mt=3);




// ==============
//  Miscelaneous
// ==============

//handle(lg=70,mt=3);




// ==========
//  Extruder
// ==========

hotend_holder();    
//hotend_holder_collar();





// --------- EoMF parts --------




// -------- Models --------

/*
// Y motor idler full
translate([80,0,10])
rotate([0,-90,0]){
    translate([-6.5,13,20])
    rotate([0,90,0])
        sync_bearing_holder();
    y_motor_idler(mt=3);
}
*/

/*
// Extruder Bowden Holder
translate([-20,20,-39])
rotate([90,0,0])
    hotend_holder();    
hotend_holder_collar();

%translate([0,0,-7.8])
    rotate([-90,180,0])
    import("aux/mylite6.stl");
*/


/* 
// Frog + Bearing clamps
translate([0,0,6])
    frog();

for(x=[[0,-drod/2],[180,-drod/2]]){
    rotate([0,0,x[0]])
    translate([x[1],lbearing,-2.8])
    rotate([90,0,0])
        y_bearing_clamp();
} 
*/

/*
// Y motor holder + stepper
y_motor_holder(thick=10,mt=3);
translate([0,0,-5])
nema_motor(stepper=14);

y_motor_pulley();

translate([40,20,0])
y_belt_clamp();

translate([-2,28,-5])
rotate([0,90,0])
y_rod_holder();
*/


// ------- EoM ---------


