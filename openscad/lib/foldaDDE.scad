



module bisel(){
	difference(){
		translate([0,-10,0]) cube([10,20,14]);
		rotate([90,0,0]) translate([10,7,-12]) cylinder(h=25, r=8);
	}
}


module orejas(){

	difference(){
		translate([-10,-5.5,0]) cube([10,11,13]);

		translate([-12,0,-0.5]) bisel();
		translate([-15,-3.5,-1]) cube([20,7,15]);
		rotate([90,0,0]) translate([-5,6.5,-12]) cylinder(h=25, r=2.5);
	}
}

// space = room for wires, maximun should be 11
module base_enganche(space=9)
{
	difference(){
		union(){

            // paredes laterales
            translate([0,6,0])cube([13.5,2,13]);
            translate([0,-8,0])cube([13.5,2,13]);
    
            //marcas de enganche
            rotate([90,0,0])translate([9.5,6.5,-6])cylinder(h=1, r=2);
            rotate([90,0,0])translate([9.5,6.5,5])cylinder(h=1, r=2);
		}	
        translate([14,-10,8])rotate([0,-45,0])cube([15,20,15]);
	}
    
	difference(){
		translate([0,-6,0])cube([3,12,13]);
	
		translate([-10,-3.5,(13-space)/2])cube([20,7,space]);
	}
}


module cable_chain(){

    base_enganche();
    orejas();    
}


module orejas02(){

	difference(){
		union(){	
			translate([-10,-5.5,0]) cube([10,11,13]);
			//marcas de enganche
			#rotate([90,0,0])translate([-5.5,6.5,0]){
				translate([0,0,-6.25]) cylinder(h=1.25,r=2,$fn=70);
				translate([0,0,5.25]) cylinder(h=1.25,r=2,$fn=70);
			}
		}
		translate([-12,0,-0.5]) bisel();
		translate([-15,-3.5,-1]) cube([20,7,15]);
	}
}


module base_enganche02()
{
	difference(){
		union(){
			// paredes laterales
			translate([0,6,0]) cube([13.5,3,13]);
			translate([0,-9,0]) cube([13.5,3,13]);
		}
		// taladro pasante
		rotate([90,0,0])translate([9,6.5,-12])
			cylinder(h=25, r=2.5,$fn=70);
		translate([14,-10,8.5])rotate([0,-45,0])cube([15,20,15]);
	}
	//difference(){
		translate([0,-6,0]) cube([3,12,13]);
	
		//translate([-10,-5,4]) cube([20,10,6]);
	//}
}

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
