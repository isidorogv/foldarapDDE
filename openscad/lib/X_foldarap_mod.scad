// Modules for for foldarap X axis 

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
module x_carriage(pitch = 2, wbelt = 0.8, dejes=32){

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
			color("pink")for (i=[0:15]) {
		    	translate([0+pitch*i, 16.7, 3]) cube([1, 1.5, 12]);  
			}
			translate([40,dejes+16,0])rotate([0,0,180])
				carriage_bearing_holder();
			color("orange")translate([0,dejes+14.1,0])cube([40,7,15]);
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
			translate([35,48.1,-10])rounded_corner();
			translate([5,48.1,-10])rotate([0,0,90])rounded_corner();
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


