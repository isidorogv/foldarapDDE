

module XL_Z_motor_holder(){
    
    difference(){
        union(){
            import("aux/z_motor_left_holder.stl");
            // hole patches
            translate([-5,7,12])cube([4,6,10]);
            translate([16,26,20])cube([4,6,10]);
            translate([-(NEMA17/2)-3.2,-NEMA17-8.5,0])
                cube([NEMA17,NEMA17,5]);
            translate([-24,-10,0])cube([20,17,5]);
            
            // extra height
            translate([0,0,20])difference(){
                import("aux/z_motor_left_holder.stl");
        
                translate([-(NEMA17/2),-NEMA17-4,-5])
                    cube([NEMA17,NEMA17,55]);
                translate([-15,-10,-5])cube([40,50,14]);
            }
        }
        
        translate([-3.2,-(NEMA17/2)-8.5,-NEMA17/2])union(){
            // M3 fixing screws
            translate([-15.5,15.5,0])cylinder(h=NEMA17,r=1.5,$fn=50);
            translate([15.5,15.5,0])cylinder(h=NEMA17,r=1.5,$fn=50);
            translate([15.5,-15.5,0])cylinder(h=NEMA17,r=1.5,$fn=50);
            translate([-15.5,-15.5,0])cylinder(h=NEMA17,r=1.5,$fn=50);
            // collar
            translate([0,0,19.5])cylinder(h=20, r=11, $fn=90);
        }
    
        translate([-61.6,7,-5])rotate([0,0,-45])cube([40,40,20]);
        translate([-26.3,-50.5,-5])rotate([0,0,-45])cube([3,3,15]);
        translate([15.7,-50.5,-5])rotate([0,0,-45])cube([3,3,15]);
    }

}




module z_fixing_chain(){

	translate([0,0,0])base_enganche02();

	translate([-NEMA14/2,NEMA14/2,2.25])difference(){
		cube([NEMA14,NEMA14,4.5],center=true);
		// stepper collar
		#translate([0,0,-4])cylinder(h=10,r=11,$fn=120);

		translate([-0.7*NEMA14,0,-3])cube([NEMA14,NEMA14,10]);
		translate([-NEMA14,-0.3*NEMA14,-3])cube([NEMA14,NEMA14,10]);
		// some rounded corners
		translate([21,11,-5])rotate([0,0,45])cube([20,20,20]);
		translate([-21,-39,-5])rotate([0,0,45])cube([20,20,20]);
		/*translate([(NEMA14/2)-5,(NEMA14/2)-5,-10])
			rounded_corner();
		translate([-(NEMA14/2)+5,-(NEMA14/2)+5,-10])rotate([0,0,180])
			rounded_corner();*/
		// screw drills
		translate([(NEMA14/2)-4,(NEMA14/2)-4,-3])
			cylinder(h=10,r=1.6,$fn=60);
		translate([-(NEMA14/2)+4,-(NEMA14/2)+4,-3])
			cylinder(h=10,r=1.6,$fn=60);
		#translate([(NEMA14/2)-4,-(NEMA14/2)+4,-3])
			cylinder(h=10,r=1.6,$fn=60);
	}
	translate([-8,-8,0])rounded_corner(rd=8,lg=4.5);
	translate([8,16,0])rotate([0,0,180])rounded_corner(rd=8,lg=4.5);
}

