// -------------------------------------------------------------
// Custom Foldarap 3D printer
// Based on Original Foldarap v.1.0, by EnmanuelG
// http://reprap.org/wiki/FoldaRap1_Build_Manual
// Distributed under the terms of GNU/GPL v3.0 or higher

// Modifications by Isidoro Gayo (isidoro.gayo@gmail.com)
// https://github.com/isidorogv/foldarap_mod
// Modified parts are distributed under the terms of 
// GNU/GPL v3.0 or higher
// -------------------------------------------------------------

include <lib/modules.scad>
include <lib/misc.scad>
include <lib/X_axis.scad>
include <lib/Y_axis.scad>
include <lib/Z_axis.scad>
include <lib/extruder.scad>


// Parameters to modify. 
// Try to NOT modify variables in other places.
NEMA14=34;      // NEMA14 width in mm
NEMA17=42;      // NEMA17 width in mm
wslot=20;		// aluminium slot width in mm
lslot=wslot;	// aluminium slot lenght in mm
thwall=3.5;     // wall thickness
span=NEMA17;    // span between horizontal profiles on Y axis
footl=2.5*wslot;// foot lenght
ease=0.2;       // clearance to fit the aluminum profile easier
stepper=14;     // type of stepper motor;e.g. 14 = NEMA14, and so...

lbearing=24;    // bearing lenght in mm for a 8mm smooth rod
rbearing=7.5;   // M8 bearing radius in mm
rrod=3;         // smooth rod radius in mm
drod=130;       // distance between Y rods in mm
bhole=95.25/2;  // M3 hole distance from bed center
                // for Miniheatbed, by F. Malpartida

$fn = 50;


// ******** ---- FoldaRap DDE ----- *********

// ----- X axis -----

//translate([wslot+2*thwall+1,-30,-2])
//rotate([90,0,90])
    x_carriage();
    
//x_motor_holder(hg=NEMA17,stepper=17,thick=6.5);

//x_motor_idler(hg=NEMA14+2*thwall);

/*
translate([20,5,0])
rotate([90,0,0])
    x_bearing_holder(span=13);
*/



// ----- Y axis -----

//y_endstop_adj();

//translate([0,30,4])
//rotate([180,0,0])
  //  knob(thk=4,dia=16,spc=false,mt=3,nk=12,dk=2);

//y_motor_idler();

//IEC_plate();

//y_motor_holder(stepper=17,thick=10);

//y_rod_holder(mt=4);
/*
difference(){

y_belt_clamp(cs=2*lbearing+3,ch=23);
translate([0,-7,-1])
        hollow(rd=3,lg=25,wd=12);
}
*/

//frog();
// you have to print two of these
//y_bearing_clamp();

//translate([0,10,0])
    //foot(lg=footl,mt=4);
//mirror([0,1,0])
  //  foot(lg=footl,mt=4);



// ----- Z axis -----

//translate([0,10,0])
  //z_motor_holder(mt=4,center=true);
//mirror([0,1,0])
  //  z_motor_holder(mt=4);

//translate([0,10,44.5])
//rotate([-90,0,0])
  //  z_hinge_outter(bsd=9,ssd=8);
//z_hinge_inner(mt=4);

//z_upper_joint(mt=4);



// ----- Extruder -----

//mirror()
    //idler();

//fan_pipe(l=40,isize=8);
//rotate([90,0,0])
    //fan_nozzle();

//rotate([180,0,0])
    //knob(thk=5,dia=7,nk=8,dk=2,spc=false);

//extruder();

//extruder_holder();

//extruder_wire_fastener();

//rotate([0,180,0])
  //  x_wire_fastener();



// ----- Miscelaneous -----

//spool_holder();
//spool_clamp();
//knob_clamp(altura=10, radio=5, paso=30);
//spool_knob(hg=14);

//psu_holder();

//handle();


// ******** ---- EoFRDDE ----- *********


