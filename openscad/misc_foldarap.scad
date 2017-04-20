

// Auxiliar module, not directly used.
module carriage_bearing_holder(){

	difference(){
		// old huxley carriage, by ReprapPRO team
		import("aux/x-carriage-1off.stl");
	
		translate([-10,16.2,-4]) cube([60,60,25]);
	}
	// LM6UU bearing and smooth rod
	%translate([0,8,9])rotate([0,90,0])cylinder(h=40, r=6.1, $fn=90);
	%translate([-20,8,9])rotate([0,90,0])cylinder(h=80, r=3, $fn=90);
}



module orejeta(){
	
	hull(){
		translate([8,31,0])cylinder(h=3,r=2,$fn=40);
		cube([1,33,3]);
	}
	translate([0,21.25,3])cube([7,5.5,2.5]);
}




module reten(lg=30){

	difference(){
		hull(){
	
			translate([-10,lg/2,0])cylinder(h=3,r=3,$fn=50);
			translate([10,lg/2,0])cylinder(h=3,r=3,$fn=50);
			translate([-5,-lg/2,0])cylinder(h=3,r=3,$fn=50);
			translate([5,-lg/2,0])cylinder(h=3,r=3,$fn=50);
		}
	
		translate([0,(lg/2)+6-10,-2])cylinder(h=10,r=2.1,$fn=50);
		//translate([0,12,1.5])cylinder(h=10,r=4.1,$fn=80);
	}
}



module spool_holder_clamp(altura=11, radio=10, paso=18, metrica=4){

	difference(){
		union(){
			cylinder(h=altura/2, r=radio, $fn=radio*10);
			translate([0,0,altura/2])
				cylinder(h=altura/2, r=0.75*radio, $fn=90);
            // Moleteado
            for (ang=[0:paso:360]){
                rotate([0,0,ang])translate([radio,0,0])
                    cylinder(h=altura/2, r=1.5, $fn=60);
            }
        }
		translate([0,0,-1])cylinder(h=4, r=4.1, $fn=6);
		translate([0,0,-3])cylinder(h=altura+10, r=metrica/2, $fn=100);
	}
}




/*
module asa_mod(){
    
    union(){
        translate([25,0,0])difference(){
            import("aux/addon-handle.stl");
        
            translate([-70,-25,-5])cube([40,30,60]);
        }
        translate([-25,0,0])difference(){
            import("aux/addon-handle.stl");
        
            translate([30,-25,-5])cube([40,30,60]);
        }
    }
}
*/



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




module SAV_holder(){


	color("lightblue")difference(){
		cylinder(h=20,r1=5,r2=3,$fn=60);

		translate([0,0,5])cylinder(h=20,r=1.2,$fn=60);
	}
}




module spool_holder_02(m=8,ht=40,perfil=20,slot=6){
	difference(){
	union(){
		difference(){
			hull(){
				cylinder(h=5,r=(m/2)+2.5,$fn=90);
				translate([ht-(m/2)+2,-(perfil/2)-0.5,0])cube([1,perfil+1,20]);
			}
			translate([-m,-perfil,5.5])cube([ht+4,2*perfil,1.5*perfil]);
		}
		cylinder(h=15,r=(m/2)+2.5,$fn=90);
		// base
		//translate([ht-(m/2),-perfil/2,0])cube([3,perfil,20]);
		// slot profile retainer
		translate([ht-(m/2)+3,-slot/2,0])cube([3,slot,7]);
		// reinforcements
		translate([4,-1.5,5])rotate([0,14,0])cube([20,3,5]);
		translate([23,-8.9,0.5])rotate([0,-20,-5.5])cube([16,3,5]);
		translate([23,5.9,0.5])rotate([0,-20,5.5])cube([16,3,5]);
	}
	// M8 drill
	translate([0,0,-5])cylinder(h=50,r=(m/2)+0.2,$fn=90);
	// M4 fixing screw drill
	translate([20,0,14])rotate([0,90,0])cylinder(h=30,r=2.2,$fn=70);
	}

}




module knob_clamp(altura=11, radio=12, paso=14, metrica=4){

	difference(){
		union(){
			cylinder(h=altura/2, r=radio, $fn=radio*10);
			translate([0,0,altura/2])
				cylinder(h=altura/2, r=0.55*radio, $fn=90);
            // Moleteado
            for (ang=[0:paso:360]){
                rotate([0,0,ang])translate([radio,0,0])
                    cylinder(h=altura/2, r=1.5, $fn=60);
            }
        }
		translate([0,0,-1])cylinder(h=4, r=4.1, $fn=6);
		translate([0,0,-3])cylinder(h=altura+10, r=metrica/2, $fn=100);
	}
}




module gantry_clamp(altura=25, radio=6, radio2=3, paso=30, metrica=4){

	difference(){
		union(){
			cylinder(h=5, r=radio, $fn=radio*10);
			translate([0,0,0])
				cylinder(h=altura, r=0.8*radio, $fn=90);
            	// Moleteado
            for (ang=[0:paso:360]){
                rotate([0,0,ang])translate([radio,0,0])
                    cylinder(h=5, r=radio2, $fn=60);
            }
        }
		translate([0,0,-1])cylinder(h=18, r=4.1, $fn=6);
		translate([0,0,-3])cylinder(h=altura+10, r=metrica/2, $fn=100);
	}
}





module knob(altura=10, radio=10, paso=10, metrica=4){

	difference(){
		union(){
			cylinder(h=altura, r=radio, $fn=10*radio);
           	// Moleteado
            for (ang=[0:paso:360]){
                rotate([0,0,ang])translate([radio,0,0])
                    cylinder(h=altura, r=10*1/radio, $fn=60);
            }
        }
		translate([0,0,altura-3])cylinder(h=5, r=4.1, $fn=6);
		translate([0,0,-3])cylinder(h=altura+10, r=metrica/2, $fn=100);
	}
}



