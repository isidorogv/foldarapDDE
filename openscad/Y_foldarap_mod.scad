


// e = thikness
module y_motor_holder(e=5){


	difference(){
		portamotor_17(espesor=e);
		translate([-(NEMA17/2)+5,(NEMA17/2)-5,-5])rotate([0,0,90])
			rounded_corner();
	}

	difference(){
		union(){
			translate([-NEMA17/2,-NEMA17-1,0])cube([NEMA17,24,e]);
			translate([(NEMA17/2)-11,-NEMA17-1,0])
				cube([23,22,NEMA17]);
		}
		translate([-16,-76,-5])rotate([0,0,55])cube([40,40,NEMA17+10]);
		translate([13,-NEMA17-2,-5])cube([40,NEMA17/2,NEMA17+10]);

		translate([0,-(NEMA17/2)-12,NEMA17/2])rotate([0,90,0])
			cylinder(h=20,r=2.1,$fn=80);
        //translate([0,-(NEMA17/2)-12,31])rotate([0,90,0])
		//	cylinder(h=20,r=2.1,$fn=80);
	}
    difference(){
        color("lightblue")translate([13,-(NEMA17/2)-15,0])
           cube([3,6,NEMA17]);

        translate([9,-(NEMA17/2)-12,NEMA17/2])rotate([0,90,0])union(){
            translate([0,0,0])rotate([0,0,45])
                cylinder(h=8,r1=1,r2=18,$fn=4);
            //translate([-20,0,0])rotate([0,0,45])
            //	cylinder(h=8,r1=1,r2=14,$fn=4);
        }
    }
    color("lightgray")translate([NEMA17/2+5,-(NEMA17/2)+5,0])
        rotate([0,0,180])rounded_corner(lg=5);
}



module y_belt_idler(){

	union(){
		difference(){
			hull(){
				cylinder(h=12.5, r=5, $fn=90);
				translate([-5,0,0])cube([10,10,12.5]);
			}
			translate([0,0,-10])cylinder(h=30, r=1.5, $fn=90);
			translate([-10,-12,3])cube([20,20,6.5]);
		}
		difference(){
			union(){
				translate([0,0,8.25])
                    cylinder(h=1.25, r1=2, r2=3.5, $fn=90);
				translate([0,0,3])
                    cylinder(h=1.25, r1=3.5, r2=2, $fn=90);
			}
			#translate([0,0,-10])cylinder(h=30, r=1.5, $fn=90);
		}
	
		rotate([0,0,180])translate([0,-19.8,3.25])difference(){
			translate([-5,-7,0])cube([10,18,6]);
			
			translate([0,15,3])rotate([90,0,0])
				cylinder(h=30, r=1.6, $fn=60);
			translate([-2.75,-2,-2])cube([5.5,2.5,10]);
		}
	}
}




module y_belt_tensioner(){
    
    translate([-25,0,33])rotate([-90,0,0])difference(){
		//union(){
			difference(){
				translate([0,10,0])cube([12.5,23,33]);
		
				translate([3.05,9,-0.5])cube([6.4,21,11]);
				translate([-10,9,14])cube([30,21,50]);
			}
			//translate([0,27,21.5])cube([12.5,3,5]);
		//}
	
		translate([6.25,20,24])rotate([-90,0,0])
            cylinder(h=15,r=2.1,$fn=30);
		translate([6.25,20,5])rotate([-90,0,0])
            cylinder(h=15,r=1.6,$fn=30);
		//translate([1.25,25,18])cube([10,5,12.5]);
	}
    translate([-13,0,0])orejeta();
    translate([-24,0,0])mirror()orejeta();
}



module rear_foot(){

    difference(){
        union(){
            rotate([0,90,0])import("aux/rear_foot.stl");
            color("lightblue")translate([-14,-60,-10])cube([14,20,31]);
        }
    //    union(){
        translate([-20,-50,11])rotate([0,90,0])
            cylinder(h=30,r=2.1,$fn=60);
        translate([-17,-57,0])cube([14,14,40]);
        translate([-16,-62,-8])cube([8,24,40]);
        translate([-30,-62,6])rotate([0,45,0])
            cube([8,24,40]);
    //    }
    }
    
    translate([-13,-60,-3])rotate([-90,0,0])rounded_corner(lg=20);
    
    %translate([-14,-50,11])rotate([0,90,0])spool_holder_clamp();
}



module XL_rear_foot(){
    
    union(){
        translate([20,0,0])difference(){
            
            rear_foot();
        
            translate([-15,-63,-25])cube([40,70,50]);
        }        
        difference(){
            
            rear_foot();
        
            translate([50,-63,-25])cube([40,70,50]);
        }
        // reinforcements
        difference(){
            translate([23,-40,-23])cube([20,20,3]);
        
            translate([18,-16,-25])rotate([0,0,-45])
            cube([40,40,10]);
        }
        translate([20,0,0])difference(){
            translate([37,-40,-23])cube([20,20,3]);
        
            translate([5,-16,-25])rotate([0,0,-45])
            cube([40,40,10]);
        }
    }
}



module XL_front_foot(){
    
    union(){
        translate([-20,0,0])difference(){
            import("aux/pata_delantera_izquierda.stl");
        
            translate([-38,-10,-5])cube([55,60,30]);
        }
        
        difference(){
            import("aux/pata_delantera_izquierda.stl");
        
            translate([-98,-10,-5])cube([55,60,30]);
        }
        difference(){
            translate([-62,-3,-3])cube([24,25,15]);
            #translate([-64,0,0])cube([30,30,15]);
        }
    }
}





module y_bearing(lg=20,rd=6){


	difference(){
		union(){
			cylinder(h=lg,r=rd+2.5,$fn=90);
			translate([-rd-2,0,0])cube([2*(rd+2),rd+2,lg]);
		}
		translate([0,0,-5])cylinder(h=lg+10, r=rd+0.1, $fn=90);
		#translate([-0.25,-rd-10,-5])cube([0.5,rd+10,lg+10]);
	}

	translate([0,rd+5,2])rotate([90,0,0])difference(){
		hull(){
			translate([-rd-7,0,0])cylinder(h=5,r=2,$fn=90);
			translate([rd+7,0,0])cylinder(h=5,r=2,$fn=90);
			translate([-rd-7,lg-4,0])cylinder(h=5,r=2,$fn=90);
			translate([rd+7,lg-4,0])cylinder(h=5,r=2,$fn=90);
		}
	
		union(){
			translate([-rd-5,2,2])rotate([0,0,30])
                cylinder(h=5,r=3.2,$fn=6);
			translate([-rd-5,2,-5])
                cylinder(h=15,r=1.6,$fn=60);
			translate([rd+5,2,2])rotate([0,0,30])
                cylinder(h=5,r=3.2,$fn=6);
			translate([rd+5,2,-5])
                cylinder(h=15,r=1.6,$fn=60);
			translate([-rd-5,lg-6,2])rotate([0,0,30])
                cylinder(h=5,r=3.2,$fn=6);
			translate([-rd-5,lg-6,-5])
                cylinder(h=15,r=1.6,$fn=60);
			translate([rd+5,lg-6,2])rotate([0,0,30])
                cylinder(h=5,r=3.2,$fn=6);
			translate([rd+5,lg-6,-5])
                cylinder(h=15,r=1.6,$fn=60);
		}
	}
}



module IEC_plate(){

	difference(){
		// Connection plate
		cube([60,80,2.5],center=true);

		// Hole for swtich
		//translate([-25,0,0])cube([27,22,10],center=true);
		//translate([-25,0,5])cube([30,22,10],center=true);
		#translate([-18,0,0]){
			cube([13,19,10],center=true);
			translate([0,0,5])cube([13,23,10],center=true);
		}
		// Hole for IEC connector
		/*translate([20,0,0]){
			cube([28,20,10],center=true);
			translate([-20,0,-5])cylinder(h=10,r=1.6,$fn=50);
			translate([20,0,-5])cylinder(h=10,r=1.6,$fn=50);
			translate([-20,0,-.5])cylinder(h=4,r=3.2,$fn=6);
			translate([20,0,-.5])cylinder(h=4,r=3.2,$fn=6);
		}*/
		#translate([11,0,0]){
			cube([20,27,10],center=true);
			translate([0,0,5])cube([26,27,10],center=true);
		}

		// rounded corners
		translate([25,35,-5])rounded_corner(lg=10);
		translate([-25,35,-5])rotate([0,0,90])
			rounded_corner(lg=10);
		translate([25,-35,-5])rotate([0,0,-90])
			rounded_corner(lg=10);
		translate([-25,-35,-5])rotate([0,0,180])
			rounded_corner(lg=10);
		// fixing holes
		translate([-20,30,-5])cylinder(h=10,r=2.1,$fn=60);
		translate([20,30,-5])cylinder(h=10,r=2.1,$fn=60);
		translate([-20,-30,-5])cylinder(h=10,r=2.1,$fn=60);
		translate([20,-30,-5])cylinder(h=10,r=2.1,$fn=60);
	}
}




module y_endstop(){

	difference(){
			hull(){
				cylinder(h=40,r=5,$fn=50);
				translate([0,13,0])cylinder(h=40,r=5,$fn=50);
			}

		translate([0,0,-2])cylinder(h=65,r=3,$fn=50);
		translate([-0.5,-10,-5])cube([1,10,70]);
		//#translate([-10,-15,15])cube([20,20,10]);
		translate([-10,5.1,18])cube([20,20,40]);

		translate([0,13,-2])cylinder(h=65,r=1.6,$fn=50);
		translate([-7,10,8.5])cube([14,8,3]);

		translate([-10,-27,20])rotate([0,90,0])cylinder(h=20,r=30,$fn=8);
	}
	difference(){
		translate([0,5,18])cylinder(h=25,r=5,$fn=60);

		translate([-5,0,16])cube([10,5,30]);
	}
}


