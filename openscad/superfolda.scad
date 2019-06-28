//------------------------------------------------------------
//---- 3D printed pieces for Scalable Foldarap 3D printer ----
//------------------------------------------------------------
// (c) 2019 Isidoro Gayo Vélez (isidoro.gayo@gmail.com)

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
include <lib/libsuperfolda.scad>


// Parameters to modify. 
// Try to NOT modify variables in other places.
NEMA14=34;      // NEMA14 width in mm
NEMA17=42;      // NEMA17 width in mm
wslot=20;		// aluminium slot width in mm
lslot=wslot;	// aluminium slot lenght in mm
thwall=3.5;     // wall thickness
span=50;        // span between horizontal profiles on Y axis
footl=2.5*wslot;// foot lenght
ease=0.2;       // clearance to fit the aluminum profile easier
stepper=17;     // type of stepper motor;e.g. 14 = NEMA14, and so...

lbearing=24;    // bearing lenght in mm for a 8mm smooth rod
rbearing=7.5;   // M8 bearing radius in mm
rrod=4;         // smooth rod radius in mm
drod=130;       // distance between Y rods in mm
bhole=100;      // M3 hole distance from bed center
                


$fn = 50;



// ----------------
//      X axis
// ----------------

x_motor_holder(hg=NEMA17,thick=6.5);

//x_motor_idler();

//x_bearing_holder(span=13);




// ----------------
//      Y axis
// ----------------

//translate([0,10,0])
  //  foot();

//mirror([0,1,0])
  //  foot();
    
//y_bearing_clamp();

//y_endstop_adj();

//y_motor_idler();

//y_motor_holder(stepper=17,thick=10);

//y_rod_holder(mt=4);

/*
difference(){

y_belt_clamp(cs=2*lbearing+3,ch=23);
translate([0,-7,-1])
        hollow(rd=3,lg=25,wd=12);
}
*/


// ----------------
//      Z axis
// ----------------

//translate([0,10,0])
  //z_motor_holder(mt=4);
//mirror([0,1,0])
  //z_motor_holder(mt=4);
  
//translate([0,10,44.5])
//rotate([-90,0,0])
  //  z_hinge_outter(bsd=9,ssd=8);
//z_hinge_inner(mt=4);

//z_upper_joint(mt=4);




// -----------------
//      Extruder
// -----------------

//extruder_idler();

//extruder();




// ----------------------
//      Miscelaneous
// ----------------------


//spool_holder();
//spool_clamp();
//knob_clamp(altura=10, radio=5, paso=30);
//spool_knob(hg=14);

//handle(lg=100);


