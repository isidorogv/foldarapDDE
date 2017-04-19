NEMA14 = 34;
NEMA17 = 42;


module hobbed_mk7(){

	difference(){
		union(){
			cylinder(h=9, r=6.7, $fn=50);
			translate([0,0,9])cylinder(h=1.5, r1=6.7, r2=5.2, $fn=50);
			translate([0,0,10.5])cylinder(h=1.5, r1=5.2, r2=6.7, $fn=50);
			translate([0,0,12])cylinder(h=2, r=6.7, $fn=50);
		}
		translate([0,0,-5])cylinder(h=20, r=2.5, $fn=50);
	}
}


// l = motor length
// daxis = dual axis
module NEMA14(l=33, daxis=false){

	//color("black")
    cube([34,34,l], center=true);
	//color("white")
    translate([0,0,l/2])cylinder(h=2, r=11, $fn=90);

	axispos = daxis ? -(l/2)-10 : (l/2)+2;
	axislenth = daxis ? l+32 : 20;

	color("gray")translate([0,0,axispos])
		cylinder(h=axislenth, r=2.5, $fn=50);

	//translate([0,0,21])hobbed_mk7();

	// fixing screws
	union(){
		translate([-13,13,0])cylinder(h=NEMA14,r=1.5,$fn=50);
		translate([13,13,0])cylinder(h=NEMA14,r=1.5,$fn=50);
		translate([13,-13,0])cylinder(h=NEMA14,r=1.5,$fn=50);
		translate([-13,-13,0])cylinder(h=NEMA14,r=1.5,$fn=50);
	}
}

// l = motor length
// daxis = dual axis
module NEMA17(l=39, daxis=false){

	//color("black")
    cube([42,42,l], center=true);
	//color("white")
    translate([0,0,l/2])cylinder(h=2, r=11, $fn=90);

	axispos = daxis ? -(l/2)-10 : (l/2)+2;
	axislenth = daxis ? l+32 : 20;

	color("gray")translate([0,0,axispos])
		cylinder(h=axislenth, r=2.5, $fn=50);

	// fixing screws
	union(){
		translate([-15.5,15.5,0])cylinder(h=NEMA17,r=1.5,$fn=50);
		translate([15.5,15.5,0])cylinder(h=NEMA17,r=1.5,$fn=50);
		translate([15.5,-15.5,0])cylinder(h=NEMA17,r=1.5,$fn=50);
		translate([-15.5,-15.5,0])cylinder(h=NEMA17,r=1.5,$fn=50);
	}
}


module portamotor_14(espesor=5){
	difference(){
		union(){
			difference(){
				// proforma
				translate([-4,-4,0])cube([NEMA14,NEMA14,espesor]);
		
				union(){
					// taladros para tornillos
					translate([0,0,-3])
						cylinder(h=espesor+5, r=1.6, $fn=30);
					translate([26,0,-3])
						cylinder(h=espesor+5, r=1.6, $fn=30);
					translate([0,26,-3])
						cylinder(h=espesor+5, r=1.6, $fn=30);
					//translate([26,26,-3])
						cylinder(h=espesor+5, r=1.6, $fn=30);
					// muesca lateral
					translate([6,6,-3])cube([30,50,espesor+5]);
					//translate([6,-6,-5])cube([30,50,15]);
				}
			}
			// extremos redondeados
			translate([5.5,26.36,0])cylinder(h=espesor, r=3.65, $fn=50);
			translate([26.36,5.5,0])cylinder(h=espesor, r=3.65, $fn=50);
			//translate([5.9,-0.358,0])cylinder(h=espesor, r=3.65, $fn=50);
		}
			// hueco central

			translate([13,13,-2])
                cylinder(h=espesor+5, r=12, $fn=60);		 
            %translate([13,13,-2])
                cylinder(h=espesor+5, r=2.6, $fn=50);
			%translate([-2.5,13,-2])
                cylinder(h=espesor+5, r=3.2, $fn=50);
			%translate([13,-2.5,-2])
                cylinder(h=espesor+5, r=3.2, $fn=50);
	}
	// porta barra lisa
	//translate([-4,-17.1,0])cube([NEMA14,13.1,espesor]);
	//translate([13,13,-2])cylinder(h=10, r=2.5, $fn=60);*/
}


module portamotor_17(espesor=5){

	difference(){
		union(){
			difference(){
				// proforma
				translate([-NEMA17/2,-NEMA17/2,0])
					cube([NEMA17,NEMA17,espesor]);
		
				union(){
					// taladros para tornillos
					translate([-15.5,15.5,-3])
						cylinder(h=espesor+5, r=1.6, $fn=30);
					translate([-15.5,-15.5,-3])
						cylinder(h=espesor+5, r=1.6, $fn=30);
					//#translate([15.5,15.5,-3])
						cylinder(h=espesor+5, r=1.6, $fn=30);
					translate([15.5,-15.5,-3])
						cylinder(h=espesor+5, r=1.6, $fn=30);
					// muesca lateral
					translate([0,0,-3])cube([30,50,espesor+5]);
				}
			}
			// extremos redondeados
			translate([-1,16.5,0])
                cylinder(h=espesor, r=4.5, $fn=90);
			translate([16.5,-1,0])
                cylinder(h=espesor, r=4.5, $fn=90);
			//translate([5.9,-0.358,0])
            //    cylinder(h=espesor, r=3.65, $fn=50);
		}
			// hueco central
			translate([0,0,-2])cylinder(h=espesor+5, r=12, $fn=60);
			// referencias para el eje y la varilla lisa
			%translate([0,0,-2])
                cylinder(h=espesor+5, r=2.6, $fn=50);
			%translate([-16,0,-2])
                cylinder(h=espesor+5, r=4.1, $fn=80);
			%translate([0,-16,-2])
                cylinder(h=espesor+5, r=4.1, $fn=80);
	}
}


// rd = radius
// lg = length
module rounded_corner(rd=5, lg=30){

	difference(){
		cube([rd+0.1, rd+0.1, lg]);
		translate([0,0,-2])cylinder(h=lg+4, r=rd, $fn=15*rd);
	}
}



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


module E3D_V6_head(){

	// E3D V6 slotted head
	translate([(NEMA17/2)-16.5,0,-12.4])
		cylinder(h=3.9,r=8.1,$fn=90);
	translate([(NEMA17/2)-16.5,0,-21.4])
		cylinder(h=12.5,r=6.1,$fn=90);
	translate([(NEMA17/2)-16.5,0,-21.4])
		cylinder(h=3.1,r=8.1,$fn=90);
	// pneufit
	translate([(NEMA17/2)-16.5,0,-21.4])
		cylinder(h=14.5,r=3.55,$fn=60);
	// filament
	translate([(NEMA17/2)-16.5,0,-20])
		cylinder(h=80,r=2.05,$fn=50);
}


