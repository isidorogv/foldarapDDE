// -----------------------------------------------------------------

// Direct Extruder for Huxley i3/Foldarap DDE 3D printers
// Based on https://www.thingiverse.com/thing:147705, by ffleurey
// Distributed under the terms of GNU/GPL v3.0 or higher

// (copyleft) 2016-2019 by Isidoro Gayo (isidoro.gayo@gmail.com)
// Distributed under the terms of GNU/GPL v3.0 or higher

// -----------------------------------------------------------------


module extruder_idler(thk=9){
 
    difference(){   
        union(){
            // main body
            translate([-15,18,0])
            hull(){
                for(x=[5,-5]){
                    translate([x,-x,0])
                        cube([28,1,thk]);    
                }
            }
            // arm
            translate([-27,21,0]){
                cylinder(h=thk,r=3);
                translate([0,-3,0])
                    cube([33,6,thk]);
            }
            // reinforcement piece
            translate([-10,10,0])
                cube([10,14,thk]);
            // idler axis
            translate([15.5,15.5,0])
                cylinder(h=thk,r=3.5);
            // bearing axis    
            translate([0,10,0])
                cylinder(h=2,r=6);
        }
        // M3 pivot axis
        translate([15.5,15.5,-1])
            cylinder(h=thk+2,r=1.6);
        // M4 bearing axis
        translate([0,10,-1]){
            cylinder(h=thk+2,r=1.6);
            // bearing room
            translate([0,0,3])
                cylinder(h=thk+2,d=15+ease);
        }
        // M4 pushing screw drill
        translate([-21,0,thk/2])
        rotate([-90,0,0])
            hull(){
            for(x=[-2,2]){
                translate([x,0,0])
                    cylinder(h=25,r=2.1);
            }
        }
        // internal rounded corner 
        translate([-14,10,-1])
            cylinder(h=thk+2,d=16);
    }
    // bearing bevel
    translate([0,10,0])
    difference(){
        cylinder(h=2.5,r=3);
        cylinder(h=thk+2,r=1.6,center=true);
    }
}


module extruder_holder(){
    
    difference(){
        // Preform
        union(){
            // Extruder fixing body
            translate([0,6,0])
                cube([40,45,5]);
            // Contact plane carriage-holder
            translate([0,35,0])
                cube([40,18,25]);
            // reinforcement
            translate([0,28,12])
            rotate([0,90,0])
                rounded_corner(lg=40,rd=7);
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
        for(pos=[[[5.75,45,2],[8.5,48.5,-8]],
                [[28.75,45,2],[31.5,48.5,-8]]]){
            translate(pos[0])
                cube([5.5,10,3]);
            translate(pos[1])
                cylinder(h=20,r=1.6);
        }
        // M3 nut holes for hotend
        for(pos=[[[7.5,43,15],[4.75,33.5,20]],
                [[23.5,43,15],[20.75,33.5,20]]]){
            translate(pos[0])
                cylinder(h=25,r=1.6);
            translate(pos[1])
                cube([5.5,13,3]);
        }
        // Hole for x endstop
        for(x=[5,35]){
            translate([x,22,-5])
                cylinder(h=15,r=1.2);
        }
        // upper right bevel
        translate([35,48,-2])
            rounded_corner();
        // upper left bevel
        translate([5,48,-2])rotate([0,0,90])
            rounded_corner();
        // lower bevel
        translate([-5,11,0])rotate([0,-90,180])
            rounded_corner(lg=50);
        // room for extruder motor wires
        translate([20,40,5])
            beveled_hollow(lg=7,rd=3,hg=16,wd=30);
    }
}


module extruder(thplate=5){

    difference(){
        union(){
            difference(){
                // filament pass
                color("orange")translate([7.5,55,40])
                    cube([12,45,14]);
                        // 624ZZ bearing
                translate([8.5,74,40])
                    cylinder(h=15,r=7.2);
            }
            // motor holder
            translate([(NEMA17/2)-1,74,40])
                motor_plate(stepper=17,thick=thplate);
            // hotend holder
            color("lightgrey")translate([-1,35,40])
                    cube([NEMA17,20.5,19]);
        }
        // room for hotend head
        translate([15.5,32,49])rotate([-90,0,0])
                hotendhead();
        // M3 nut holes for fixing the hotend
        translate([3,45,38])rotate([0,0,90])union(){
            translate([-2,-4.5,0])cylinder(h=25,r=1.6);    
            translate([-2,-20.5,0])cylinder(h=25,r=1.6);
        }
        // bevel on hotend holder
        translate([50,50.5,54])
        rotate([0,-90,0])
            rounded_corner(lg=60);
        // rounded corner on filament pass
        translate([10.5,83.95,45])rotate([0,0,180])
            rounded_corner(lg=10,rd=3);
        // M4 drill for spring
        translate([10,94.5,50])
        rotate([0,90,0])
        union(){ 
            cylinder(h=3,r=4.2,$fn=6);
            translate([0,0,-12])
                cylinder(h=15,r=2.1);
            translate([-10,-3.55,0])
                cube([10,7.1,3]);
        }
        // M3 fixing head screw recess
        translate([4.5,89.5,42])
            cylinder(h=20,r=3.2);
        translate([35.5,89.5,42])
            cylinder(h=20,r=3.2);
        translate([35.5,58.5,42])
            cylinder(h=20,r=3.2); 
        // fan pipe faster
        for(x=[36,1]){
            translate([x,39,50])
            rotate([0,90,0])
            union(){
                translate([0,0,-3])
                    cylinder(h=18,r=1.6,center=true);
                translate([-3,-6.5,0])
                    cube([6,10,3]);
            }
        }
        // paso del hilo por el hobbed mk8
        translate([(NEMA17/2)-1,74,30])
            cylinder(h=50,r=5);
        // collar saliente del motor
        translate([(NEMA17/2)-1,74,39.5])
            cylinder(h=3,r=12);
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
