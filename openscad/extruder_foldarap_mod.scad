


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