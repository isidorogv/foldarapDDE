// Direct Extruder for Huxley i3 v3.0/Foldarap MOD v.1.2 3D printers
// Based on https://www.thingiverse.com/thing:147705, by ffleurey
// Distributed under the terms of GNU/GPL v3.0 or higher

// Modifications by Isidoro Gayo (isidoro.gayo@wanadoo.es)
// https://github.com/isidorogv/Huxley-reloaded
// https://github.com/isidorogv/foldarap_mod
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


// erods = extended rods, true for foldarap only.
module extruder_holder(erods=false){
    
    // if (erods) -> smooth rods distance = 30 + offset, else 30
    offset=erods?2:0;
    
    difference(){
        union(){
            translate([0,11,0])cube([40,40,5]);
            translate([0,35,0])cube([40,18,25]);
        }
        // M3 drill fixing holes
        translate([7.5,24-offset,-5])cylinder(h=25,r=1.6,$fn=60);
        translate([32.5,24-offset,-5])cylinder(h=25,r=1.6,$fn=60);
        translate([7.5,48.5,-5])cylinder(h=25,r=1.6,$fn=60);
        translate([32.5,48.5,-5])cylinder(h=25,r=1.6,$fn=60);
        // M3 nut holes for fixing the motor holder to the carriage
        translate([7.5,24-offset,2])rotate([0,0,30])
            cylinder(h=5,r=3.2,$fn=6);
        translate([32.5,24-offset,2])rotate([0,0,30])
            cylinder(h=5,r=3.2,$fn=6);
        translate([7.5,48.5,2])rotate([0,0,30])
            cylinder(h=3,r=3.2,$fn=6);
        translate([32.5,48.5,2])rotate([0,0,30])
            cylinder(h=3,r=3.2,$fn=6);
        translate([4.8,48,2])cube([5.5,10,3]);
        translate([29.8,48,2])cube([5.5,10,3]);
        // M3 nut holes for hotend
        translate([3,40,20])rotate([0,0,90])union(){
            translate([0,0,-5])cylinder(h=25,r=1.6,$fn=60);
            translate([])rotate([0,0,30])
                cylinder(h=3,r=3.2,$fn=6);
            translate([-2.75,0,0])cube([5.5,20,3]);
        }
        translate([36,40,20])rotate([0,0,-90])union(){        
            translate([0,0,-5])cylinder(h=25,r=1.6,$fn=60);
            translate([])rotate([0,0,30])
                cylinder(h=3,r=3.2,$fn=6);
            translate([-2.75,0,0])cube([5.5,20,3]);
        }
        // some rounded corners
        translate([35,48,-2])rounded_corner();
        translate([5,48,-2])rotate([0,0,90])rounded_corner();
        translate([-5,16,0])rotate([0,-90,180])rounded_corner(lg=50);
    }
    //translate([25,28,12])rotate([0,90,0])rounded_corner(lg=15,rd=7);
    translate([0,28,12])rotate([0,90,0])rounded_corner(lg=40,rd=7);
}




module extruder(showmount=false){
    difference(){
        union(){
            difference(){
                union(){
                    // porta-fusor
                    if(showmount){
                    // tapa-fusor
                    color("lightgreen")translate([-1,35,49])
                        cube([NEMA17+2,24,9]);
                    }
                    else{
                    color("pink")translate([-1,35,40])
                        cube([NEMA17+2,24,9]);
                    // paso para el hilo através del hobbed
                    color("orange")translate([9.5,59,40])
                        cube([10,15,14]);
                    color("lightblue")translate([7.5,70,40])
                        cube([12,30,14]);
                    }
                }
                // rounded corner on filament pass
                translate([10.5,83.95,35])rotate([0,0,180])
                    rounded_corner(rd=3);
                translate([15.5,29.5,49])rotate([-90,180,0])
                    hotendhead();
                translate([(NEMA17/2)-1,74,40])nema17drills();
                translate([(NEMA17/2)-1,74,50])nema17drills(hg=3,dia=7);
                // M3 nut holes for hotend
                #translate([3,42,35])rotate([0,0,90])union(){
                    translate([-2,0,0])
                        cylinder(h=25,r=1.6,$fn=60);    
                    translate([-2,-33,0])
                        cylinder(h=25,r=1.6,$fn=60);
                }
                // M4 drill for spring
                translate([10,94.5,50])rotate([0,90,0])union(){ 
                    cylinder(h=3,r=4.2,$fn=6);
                    translate([0,0,-12])cylinder(h=15,r=2.1,$fn=50);
                    translate([-10,-3.55,0])cube([10,7.1,3]);
                }
            }
        }
        // biseles laterales en porta-fusor
        translate([-5,49,45])rotate([0,0,45])cube([20,20,20]);
        translate([45,51,45])rotate([0,0,50])cube([20,20,20]);
        translate([41,54.3,38])cube([2.5,5,20]);
        translate([43,52.65,38])rotate([0,0,50])cube([1.5,2.65,20]);
        // fijacion de tobera ventilador
        translate([39,48,50])rotate([0,90,0])union(){ 
            cylinder(h=3,r=3.2,$fn=6);
            translate([0,0,-5])cylinder(h=15,r=1.6,$fn=50);
            translate([0,-2.75,0])cube([15,5.5,3]);
        }
        // paso del hilo por el hobbed mk8
        translate([(NEMA17/2)-1.5,73.5,30])cylinder(h=50,r=5.25,$fn=50);
        // 624ZZ bearing
        translate([9,74.5,20])cylinder(h=50,r=7.2,$fn=70);
        // collar saliente del motor
        translate([(NEMA17/2)-1,73.5,39.5])cylinder(h=3,r=12.5,$fn=90);
    }
    // soporte para el motor
    if(!showmount){
        difference(){
            translate([(NEMA17/2)-1,74,40])nema17collar();
        
            translate([4.5,89.5,43])cylinder(h=10,r=3.2,$fn=70);
            //translate([35.5,89.5,43])cylinder(h=10,r=3.2,$fn=70);
            //translate([35.5,58.5,43])cylinder(h=10,r=3.6,$fn=70);    
        }
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



module e_fixing_chain_02(){

    difference(){
        union(){
            translate([-13.5,1,3])base_enganche02();
    
            translate([-60,-5,0])cube([47,12,3]);
            translate([-13.5,-8,0])cube([13.5,18,3]);
            translate([-60,-2,0])cube([10,NEMA17-6,3]);    
            
            difference(){    
                hull(){
                    translate([-60,34,-5])cube([10,5,8]);
                    translate([-55,34,-5])rotate([-90,0,0])
                        cylinder(h=5,r=5,$fn=50);
                }
                union(){
                    // M3 fixing screw
                    translate([-55,25,-5])rotate([-90,0,0])
                        cylinder(h=15,r=1.6,$fn=50);
                    // screw head
                    translate([-55,37,-5])rotate([-90,0,0])
                        cylinder(h=5,r=3.2,$fn=50);
                }
            }
            // some rounded corners
            translate([-45,12,0])rotate([0,0,180])
                rounded_corner(lg=3);
            translate([-16.5,10,0])rotate([0,0,-90])
                rounded_corner(lg=3,rd=3);
            translate([-16.5,-8,0])rotate([0,0,0])
                rounded_corner(lg=3,rd=3);
        }
        translate([-20,-5,3])cube([30,12,20]);
        // some rounded corners
        translate([-40,34,-2])rotate([0,-90,0])rounded_corner();
        translate([-55,0,-15])rotate([0,0,180])rounded_corner();
        // zip-tie slots
        translate([-40,1,4.5])difference(){
            rotate([0,90,0])difference(){
                cylinder(h=20,r=5,$fn=50);
                translate([0,0,-5])cylinder(h=30,r=3.5,$fn=50);
            }
            translate([3,-15,-15])cube([14,30,30]);
        }
    }
}