
include <lib/folda_modules.scad>;



module x_motor_holder(){
	difference(){
		
		import("aux/x-motor_m5_MOD.stl");
	
		color("red")translate([0,-4,23])rotate([0,90,0]){
			hull(){
				translate([0,-10,-10])	cylinder(h=20,r=11.5,$fn=90);
				translate([0,-16,-10])	cylinder(h=20,r=11.5,$fn=90);
			}
			hull(){
				translate([-15.5,0,-10])cylinder(h=20,r=1.6,$fn=90);
				translate([-15.5,4,-10])cylinder(h=20,r=1.6,$fn=90);
			}
			hull(){
				translate([15.5,0,-10])cylinder(h=20,r=1.6,$fn=90);
				translate([15.5,4,-10])cylinder(h=20,r=1.6,$fn=90);
			}
			hull(){
				translate([-15.5,-25,-10])cylinder(h=20,r=1.6,$fn=90);
				translate([-15.5,-29,-10])cylinder(h=20,r=1.6,$fn=90);
			}
			hull(){
				translate([15.5,-25,-10])cylinder(h=20,r=1.6,$fn=90);
				translate([15.5,-29,-10])cylinder(h=20,r=1.6,$fn=90);
			}
		}
		%translate([22.5,-16,23])rotate([0,-90,0])NEMA17(l=33);
		//%translate([22.5,-16,23])rotate([0,-90,0])NEMA14();
	}
}




// pitch = distance between theeth; T2.5 = 2.5, GT2 = 2
// wbelt = belt thickness
// dejes = distance between smooth rods
module x_carriage(pitch = 2.5, wbelt = 0.8, dejes=32){

	// LM6UU bearing and smooth rod (lower)
	%translate([0,8,9])rotate([0,90,0])cylinder(h=40, r=6.1, $fn=90);
	%translate([-20,8,9])rotate([0,90,0])cylinder(h=80, r=3, $fn=90);
	// LM6UU bearing and smooth rod (upper)
	//%translate([0,38,9])rotate([0,90,0])cylinder(h=40, r=6.1, $fn=90);
	//%translate([-20,38,9])rotate([0,90,0])cylinder(h=80, r=3, $fn=90);

	difference(){
		union(){
			difference(){
				// old huxley carriage, by ReprapPRO team
				import("aux/x-carriage-1off.stl");
			
				translate([-10,16.7-wbelt,4])cube([60,2,15]);
				translate([-10,dejes+2,-5])cube([60,60,35]);
			}
			color("pink")for (i=[0:19]) {
		    	translate([0+pitch*i, 16.7, 3]) cube([1, 1.5, 12]);  
			}
			translate([40,dejes+16,0])rotate([0,0,180])
				carriage_bearing_holder();
			color("orange")translate([0,dejes+14.1,0])cube([40,5,15]);
		}
		translate([0,dejes-32,0]){
			// upper M3 screw holes
			// screw holes
			translate([7.5,48.5,-5])cylinder(h=25, r=1.6, $fn=60);
			translate([32.5,48.5,-5])cylinder(h=25, r=1.6, $fn=60);
			// holes for screw heads
			translate([7.5,48.5,-3])cylinder(h=5, r=3.2, $fn=90);
			translate([32.5,48.5,-3])cylinder(h=5, r=3.2, $fn=90);
			// Some rounded corners
			translate([35,46.1,-10])rounded_corner();
			translate([5,46.1,-10])rotate([0,0,90])rounded_corner();
			}
		// lower M3 screw drills
		// screw holes
		translate([7.5,22,-5])cylinder(h=25, r=1.6, $fn=60);
		translate([32.5,22,-5])cylinder(h=25, r=1.6, $fn=60);
		// holes for screw heads
		translate([7.5,22,-3])cylinder(h=5, r=3.2, $fn=90);
		translate([32.5,22,-3])cylinder(h=5, r=3.2, $fn=90);
	}
}








module hotend_holder_proform(h=9,hotend_footprint=true){

	difference(){
		translate([-NEMA17/2,0,-NEMA17/2])cube([NEMA17,h,NEMA17/2]);
	
		if (hotend_footprint)
			translate([0,0.5,0])E3D_V6_head();
		// fake Mk8 slotted piece
		translate([-0.5,0,0.5])union(){
			translate([0,14,0])rotate([90,0,0])
				cylinder(h=15,r=5.05,$fn=70);
			translate([-(NEMA17/2)-1,-1,-5.05])cube([(NEMA17/2)+1,15,6]);
		}
		// fake 623ZZ bearing, diameter=10mm
		translate([9,0,0.5])union(){
			translate([0,14,0])rotate([90,0,0])
				cylinder(h=15,r=5.05,$fn=70);
			translate([0,-1,-5.05])cube([(NEMA17/2)+1,15,6]);
		}
		// fixing screw drills
		translate([-15.5,15,-15.5])rotate([90,0,0])
			cylinder(h=30,r=1.6,$fn=50);
		translate([15.5,15,-15.5])rotate([90,0,0])
			cylinder(h=30,r=1.6,$fn=50);
		// rounded corners
		translate([(NEMA17/2)-5,20,-16])rotate([90,90,0])rounded_corner();
		translate([-(NEMA17/2)+5,20,-16])rotate([90,180,0])rounded_corner();
	}
}


// tk = thikness in mm
module hotend_holder(tk=9){

	difference(){
		hotend_holder_proform(h=tk);

		// stepper collar
		translate([0,14,0])rotate([90,0,0])
			cylinder(h=5,r=11.2,$fn=50);
	}
}


// tk = thikness in mm
module hotend_clamp(tk=9){

	difference(){
		hotend_holder_proform(h=tk);

		// fixing screw heads
		translate([-15.5,10,-15.5])rotate([90,0,0])
			cylinder(h=6,r=3.1,$fn=50);
		translate([15.5,10,-15.5])rotate([90,0,0])
			cylinder(h=6,r=3.1,$fn=50);
	}
}



module hotend_holder_base(){

	difference(){
		hotend_holder_proform(h=2,hotend_footprint=false);

		// stepper collar
		translate([0,5,0])rotate([90,0,0])
			cylinder(h=10,r=11.2,$fn=50);
	}
}



module x_motor_idler(){

	difference(){
		union(){
			import("aux/x-idler_m5_MOD_v10.stl");
			translate([-31,8,0])cube([5,2,12]);
			#translate([-31,8,34])cube([5,2,12]);
		}
		translate([-33,30.5,-10])cube([10,20,70]);
	}


}




module x_fixing_chain(){

	difference(){
		union(){
			translate([0,7,0])orejas02();
			translate([5.5,0.5,0])rotate([0,0,90])orejas02();
			cube([11,12.5,13]);
		}

		translate([-11,3.5,-3.5])cube([20,7,15]);
		translate([2,-11,-3.5])cube([7,20,15]);
		translate([5,3,0])rotate([0,90,0])cylinder(h=20,r=5,$fn=70);
	}
	// fixing side
	translate([5.5,14.5,0])difference(){
		hull(){
			cylinder(h=13,r=3.5,$fn=60);
			translate([-5.5,-3,0])cube([11,1,13]);
		}
		// drill for fixing M3 screw
		translate([0,0,-5])cylinder(h=20,r=1.6,$fn=70);
	}
}



// s = room for the bearing - bearing thikness
module x_bearing_coupler(s=3.5){

	difference(){
		union(){
			cylinder(h=(s/2)-0.6,r=4.8,$fn=60);	
			cylinder(h=(s/2)-0.3,r=3.1,$fn=60);	
		}
		translate([0,0,-5])cylinder(h=10*s,r=1.6,$fn=60);
	}
}




module x_endstop(){

	difference(){
		hull(){
			translate([0,-5,0])cube([25,10,4]);
			translate([-10,0,4])union(){
				translate([0,-5,0])cube([10,10,3]);
				cylinder(h=3,r=5,$fn=60);
			}
		}
		translate([-20,-10,0])cube([20,20,4]);
		translate([-11,0,0])hull(){
			cylinder(h=15,r=1.6,$fn=50);
			translate([6,0,0])cylinder(h=15,r=1.6,$fn=50);			
		}
	}
}


