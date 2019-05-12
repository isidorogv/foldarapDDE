// Direct Extruder for Huxley i3 3D Printer/Foldarap D v3.0
// Based on https://www.thingiverse.com/thing:147705, by ffleurey
// Distributed under the terms of GNU/GPL v3.0 or higher

// Modifications by Isidoro Gayo (isidoro.gayo@wanadoo.es)
// https://github.com/isidorogv/Huxley-reloaded
// Distributed under the terms of GNU/GPL v3.0 or higher

// -----------------------------------------------------------------



module idler(){
    
    difference(){
        import("aux/idler.stl");
        
        translate([0,10,7])difference(){
            #cylinder(h=10,r=7.5,$fn=60);            
            translate([0,0,-2])cylinder(h=20,r=2.05,$fn=60);
        }
        //#translate([0,-3.5,0])rotate([0,0,45])cube([20,20,20]);
        translate([0,10,-5])cylinder(h=20,r=2.1,$fn=60); 
    }
    difference(){
        color("red")translate([0,10,5])cylinder(h=2.4,r=3,$fn=60); 
        translate([0,10,0])cylinder(h=20,r=2.1,$fn=60); 
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


// Support for an axial fan (diameter 45 mm)
// isize = inductive diameter, default for a M8 inductive
module fan_pipe(l=45,isize=8){
    
    difference(){
        union(){
            // main body
            difference(){
                difference(){
                    cube([14,19,l+5]);
                
                    translate([2,2,-5])cube([10,15,1.5*l]);
                    translate([0,16,l+25])rotate([0,90,0])
                        cylinder(h=35,r=25,$fn=90);
                }
                // fixing slot for axial fan
                translate([0,0,l-5])difference(){
                    translate([-2,-3,0])cube([20,25,12]);
                
                    translate([1,1,-2])cube([12,17,15]);
                }
            }
            // upper fixing screw
            translate([0,9.5,l-10])rotate([0,90,0])
                cylinder(h=14,r=3.5,$fn=80);
            // inductive holder
            translate([((isize+4)/2)+14,9.5,0])difference(){
                union(){
                    hull(){
                        translate([-(isize+4)/2,-(isize+4)/2,0])
                            cube([1,isize+4,10]);
                        cylinder(h=10,r=(isize+4)/2,$fn=80);
                    }
                    translate([isize/2,-2,0])difference(){
                        // inductive clamp
                        cube([8,4,10]);
                    
                        // M3 drill to get the slot tight
                        translate([5,10,5])rotate([90,0,0])
                            cylinder(h=20,r=1.6,$fn=60);
                        // rounded corners in inductive clamp
                        translate([3,6,5])rotate([90,0,0])
                            rounded_corner(lg=10);
                        translate([3,6,5])rotate([90,90,0])
                            rounded_corner(lg=10);
                    }
                }
                // internal hole for inductive sensor
                translate([0,0,-5])
                    cylinder(h=25,r=(isize/2)+0.1,$fn=60);
                // adjustement slot
                translate([0,-0.5,-5])cube([2*isize,1,25]);
            }
        }
        // taladro tornillo fijador superior
        translate([-5,9.5,l-10])rotate([0,90,0])
            cylinder(h=30,r=1.6,$fn=80);
        translate([12,9.5,l-10])rotate([0,90,0])
            cylinder(h=5,r=3.2,$fn=60);
        // taladro tornillo fijador inferior...
        translate([-5,9.5,3.5])rotate([0,90,0])
            cylinder(h=25,r=1.6,$fn=80);
        // ...contratuerca...
        translate([13.5,9.5,3.5])rotate([30,0,0])rotate([0,90,0])
            cylinder(h=5,r=3.2,$fn=6);
        // ...y cabeza del tornillo
        //translate([-2.5,9.5,3.5])rotate([0,90,0])
        //    cylinder(h=5,r=3.5,$fn=80);
        // test: plano de corte
        //color("red")translate([-20,-20,-l/2])cube([60,30,2*l]);
    }
}



module fan_nozzle(){

    difference(){
        union(){
            translate([0,0,1.9])difference(){
                cube([10,15,7]);
                translate([1,1,-2])cube([8,13,15]);
            }
        // tornillo fijador
        translate([1,7.5,5.5])rotate([0,90,0])
            cylinder(h=8,r=2.6,$fn=80);
        }
        // taladro tornillo fijador
        translate([-5,7.5,5.5])rotate([0,90,0])
            cylinder(h=30,r=1.6,$fn=80);
    }
    difference(){
        //color("grey")
        hull(){
            translate([-2,-2,0])difference(){
                cube([14,19,2]);
                translate([2,2,-2])cube([10,15,15]);
            }
            
            translate([-18,-2,-16])cube([5,19,1]);
        }
        hull(){
            translate([1,1,1])cube([8,13,1]);
                  
            translate([-16.6,1,-16])cube([1,13,1]);
        }
        translate([-18,-8,-20])rotate([0,-20,0])cube([5,30,10]);
        // test: plano de corte
        //color("crimson")translate([-40,-12,-18])cube([60,20,30]);
    }
}
