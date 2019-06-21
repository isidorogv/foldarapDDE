//--------------------------------------------------------
//  ---- Custom modules for Foldarap DDE 3D printer ----
//--------------------------------------------------------
// (c) 2018-2019 Isidoro Gayo Vélez 
// <isidoro.gayo@gmail.com>

// Credits:
// -- Enmanuel Gillot, for his superb fodable 3D printer

//---------------------------------------------------------
// Released under the terms of GNU/GPL v3.0 or higher
//---------------------------------------------------------


module board_holder(){

// OVM20Lite holder
    
    difference(){
        
        union(){
            translate([0,wslot/2+5,0]){
                cylinder(h=wslot,d=10);
                translate([-5,-5,0])
                    cube([10,5,wslot]);
            }
            
            translate([0,5,wslot])
            hull(){
                for(y=[-wslot/2,wslot/2]){
                    translate([0,y,0])
                        cylinder(h=thwall,d=10);
                }
            }
        }
        
        for(y=[[0,2.1],[wslot/2+5,1.4]]){
            translate([0,y[0],wslot-1])
                cylinder(h=thwall+2,r=y[1]);
        }
        
        translate([0,wslot/2-1,wslot/2])
        rotate([-90,0,0])
            cylinder(h=10,d=4);

        translate([-6,wslot/2+thwall,-1])
            cube([12,12,wslot]);
        
        translate([0,wslot/2+5,wslot-thwall-0.5])
        union(){
        rotate([0,0,30])
            cylinder(h=3,r=3.2,$fn=6);
            sphere(r=3.2);
        }
    }
}


module ovm20lite(){

// fake OVM20Lite card, just for reference

    difference(){    
        translate([-50,-30,0])
        union(){
            difference(){
                linear_extrude(height=1.6)
                    square([100,60]);
        
                for(pos=[[14,9.4,-1],
                        [15,60-2.54,-1],
                        [96.5,9.4,-1],
                        [90,60-2.54,-1]]){
                    translate(pos)
                        cylinder(h=4,r=1.6);
                }
            }
        }
        for(pos=[[[50-3,30-3,-1],[0,0,0]],
                [[-50+3,30-3,-1],[0,0,90]],
                [[-50+3,-30+3,-1],[0,0,180]],
                [[50-3,-30+3,-1],[0,0,270]]]){
            translate(pos[0])
            rotate(pos[1])
                rounded_corner(lg=5,rd=3);
        }
    }
}


module board_holder_model(){
    
// Auxiliar module
    
    // fake control board
    color("lightgreen")
    translate([0,42.5,1.2*wslot])
    rotate([0,0,180])
        ovm20lite();
    
    // fake aluminium profile
    %translate([0,10,6.5])
    rotate([0,90,0])
    linear_extrude(height=150,center=true)
        import("aux/MP20x20T_I.dxf");
    
    //rotate([0,180,0])
    translate([35,0,0])
        board_holder();
}


module fan_pipe(l=45,isize=8){

// Support for an axial fan (diameter 45 mm)
// isize = inductive diameter, default for a M8 inductive
    
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
