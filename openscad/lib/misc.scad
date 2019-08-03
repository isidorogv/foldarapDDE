//------------------------------------------------------------
//      3D printed pieces for Foldarap 3D printer
//------------------------------------------------------------
// (c) 2018-2019 Isidoro Gayo Vélez (isidoro.gayo@gmail.com)
// Credits:
//--> Enmanuel Gillot

//------------------------------------------------------------
//  Released under the terms of GNU/GPL v3.0 or higher
//------------------------------------------------------------


module screw_drills(nr=3.2,sr=1.6,nt=2,dd=10){
    // Auxiliar module for knob module, Do NOT print!
    
    // Makes drills in knob in order to pass the clamping screw 
    // (knob axis) through and a nut if needed. An screw
    // with hexagonal head can also be used.
    
    // nr = nut radius in mm, for a given metric
    // sr = screw radius in mm
    // nt = nut thickness in mm
    // dd = drill depth in mm
    
    translate([0,0,-1])union(){
        cylinder(h=2*dd+2,r=sr);
        cylinder(h=nt+1,r=nr,$fn=6);
    }
    // nut hole in spacer, if needed
    translate([0,0,2*dd-nt])
        cylinder(h=nt+1,r=nr,$fn=6);
}


module knob(thk=5,dia=24,mt=3,spc=true,knurl=true,nk=20,dk=5,f=40){

    // This is a knob in order to use in endstops,
    // belt tensioners and leveler thumb wheels, 
    // among other applications.
        
    // by default, M3 metric is set.
    
    // thk = knob thickness in mm
    // dia = knob diameter in mm
    // spc = spacer, suitable for belt tensioners
    // knurl = knob has or not knurl around its perimeter?
    // nk = number of knurls used on the perimeter
    // dk = knurl diameter in mm
    // mt = screw metric used on the knob axis (3 = M3, 4 = M4,
    //      5 = M5, and so...
    // f = number of knurl faces (shape)

    $fn = 50;   // default faces for all cylinders/cones
    
    difference(){
        union(){
            cylinder(h=thk,d=dia);
            // do we want knurl on our knob?
            if(knurl){
                for(i=[0:360/nk:359]){
                    rotate([0,0,i])
                    translate([dia/2,0,0])
                        cylinder(h=thk,r=dk,$fn=f);    
                }
            }
            // do we need an spacer on our knob?
            if (spc){
                translate([0,0,thk])
                    cylinder(h=thk,d1=dia,d2=dia-3);
            }
        }
        // drill for nuts and screw depending on the metric
        if(mt==3){
            screw_drills(nr=3.2,sr=1.6,nt=2.5,dd=thk);
        }
        else if(mt==4){
            screw_drills(nr=4,sr=2.1,nt=3,dd=thk);
        }
        else if(mt==5){
            screw_drills(nr=4.6,sr=2.6,nt=3,dd=thk);
        }
        else if(mt==6){
            screw_drills(nr=5.6,sr=3.1,nt=5,dd=thk);
        }
        else if(mt==8){
            screw_drills(nr=7.6,sr=4.1,nt=6.5,dd=thk);
        }
        else if(mt==10){
            screw_drills(nr=9.6,sr=5.1,nt=8,dd=thk);
        }
        else if(mt==12){
            screw_drills(nr=10.9,sr=6.1,nt=8,dd=thk);
        }
    }
}


module spool_knob(rd=20,hg=11){

// Prints a piece which has an embebed nut (M8)
// It's useful for keeping the spool holder pieces tight
    difference(){        
        union(){
            hull(){
                cylinder(h=hg-3,d=20);
                cylinder(h=hg,d=10);
            }
            for(z=[0:72:359]){
                rotate([0,0,z])
                hull(){
                    translate([0,-4,0])
                        cube([1,8,10.5]);
                    translate([rd,0,0])
                        cylinder(h=4,d=8);
                }
            }
        }
        
        // M8 nut for fixing
        translate([0,0,-1])
            cylinder(h=8,r=7.6,$fn=6);
        // M8 bolt drill
        translate([0,0,7.3])
            cylinder(h=25,r=4.1);
    }
}



module minihotbed(){
// This is an auxiliar module, DO NOT print!!
// Mini Heatbed by F. Malpartida
    %cube([100,100,2],center=true);
    
    // fixing screws for mini heatbed
    #for(x=[-bhole,bhole]){
        for(y=[bhole,-bhole]){
            translate([x,y,-3])
                cylinder(h=10,r=1.6);
        }        
    }    
}


module spool_clamp(m=8,ht=40,perfil=20,slot=6){
// It holds a M8 threaded rod firmly as a rotation axis for spool
// Two pieces like this one are needed to hold the spool
	difference(){
	union(){
		difference(){
			hull(){
				cylinder(h=5,r=(m/2)+2.5,$fn=90);
				translate([ht-(m/2)+2,-(perfil/2)-0.5,0])
                    cube([1,perfil+1,20]);
			}
			translate([-m,-perfil,5.5])
                cube([ht+4,2*perfil,1.5*perfil]);
		}
		cylinder(h=15,r=(m/2)+2.5,$fn=90);
		// base
		//translate([ht-(m/2),-perfil/2,0])
            //cube([3,perfil,20]);
		// slot profile retainer
		translate([ht-(m/2)+3,-slot/2,0])
            cube([3,slot,7]);
		// reinforcements
		translate([4,-1.5,5])
        rotate([0,14,0])
            cube([20,3,5]);
		translate([23,-8.9,0.5])
        rotate([0,-20,-5.5])
            cube([16,3,5]);
		translate([23,5.9,0.5])
        rotate([0,-20,5.5])
            cube([16,3,5]);
	}
	// M8 drill
	translate([0,0,-5])
        cylinder(h=50,r=(m/2)+0.2,$fn=90);
	// M4 fixing screw drill
	translate([20,0,14])
    rotate([0,90,0])
        cylinder(h=30,r=2.2,$fn=70);
	}

}


module knob_clamp(altura=11, radio=12, paso=14, metrica=4){
// It fixes the spool clamp pieces to the aluminium profile
	difference(){
		union(){
			cylinder(h=altura/2, r=radio, $fn=radio*10);
			translate([0,0,altura/2])
				cylinder(h=altura/2,r1=0.75*radio,r2=0.55*radio);
        
            // Moleteado
            for (ang=[0:paso:360]){
                rotate([0,0,ang])translate([radio+0.5,0,0])
                    cylinder(h=altura/2, r=1.5, $fn=60);
            }
            
        }
		translate([0,0,-1])
            cylinder(h=4, r=4.1, $fn=6);
		translate([0,0,-3])
            cylinder(h=altura+10, r=metrica/2, $fn=100);
	}
}


module IEC_plate(profile=wslot,wd=60){

// profile = profile dimensions; 20 = 20x20, 22 = 22x22 and so...
// wd = plate width in mm

	difference(){
		// Connection plate
        linear_extrude(height=thwall)
        offset(r=3)
            square([wd-6,span+2*profile-6],center=true);
       
		// swtich hole
		translate([-18,0,0]){
			cube([13,19,thwall+2],center=true);
			translate([0,0,3])
                cube([13,23,thwall],center=true);
		}
        // power connector hole
		translate([11,0,0]){
			cube([20,27,thwall+2],center=true);
			translate([0,0,3])
                cube([26,27,thwall],center=true);
		}
		// fixing screw drills
        for(x=[-20,20]){
            for(y=[-(span+profile)/2,(span+profile)/2]){
                translate([x,y,-5])
                    cylinder(h=10,r=2.1);
            }
        }
	}
}


module psu_holder(wd=30){
        
    // wd = holder width in mm
    
    difference(){
        union(){
            linear_extrude(height=thwall)
            offset(r=3,chamfer=false)
                square([wd-6,70+wslot-6]);
            
            linear_extrude(height=2*thwall)
            offset(r=3,chamfer=false)
                square([24,wslot-6]);
        }
        // M3 fixing screws
        for(x=[3,21]){
            translate([x,wslot/2-3,-1])
                cylinder(h=2*thwall+2,d=4+ease);
        }
        //translate([-4,wslot-3,thwall])
          //  cube([32,92-wslot,thwall+1]);
    }
}


module spool_holder(){
    
    // Original design by rowokii (published Apr 11, 2015)
    // https://www.thingiverse.com/thing:767317
    // Minor improvements by Isidoro Gayo (Mar 2019)
    
    // bearing dimensions
    bearing_d = 22;
    bearing_h = 7;
    
    // max and min size of the spool holder diameter
    max_d = 70;
    min_d = 25;
    
    // height of the holder
    cone_h = 30;
    
    // rod diameter
    rod_d = 8;
    
    // circle control
    $fa = 1;
    $fs = 1;
    
    difference(){
        // base
        translate([0,0,cone_h/2])
            cylinder(d1=max_d,d2=min_d,h=cone_h,center=true);
        
        // cutout for the bearing and center rod
        for(a=[[[0,0,bearing_h/2-0.1],
                bearing_d+ease,
                bearing_h],
        
                [[0,0,max_d/2+bearing_h+0.1],
                rod_d+ease,
                max_d]]){
                    
            translate(a[0])
                cylinder(d=a[1],h=a[2],center=true);
        }
        // material saving cutout
        for(z=[0:90:359]){
            rotate([0,0,z])
            translate([max_d/1.9, 0,0]) 
                cylinder(r=max_d/4,h=max_d,center=true);
        }  
    }
}


module quarter_handle(lg=50){
// Auxliliar module. DO NOT use it directly!!
    difference(){
        union(){
            linear_extrude(height=10){
                translate([-lg/2,20,0])
                    square([lg/2,15]);
                polygon(points=[[0,0],[0,35],[5,35],[20,0]]);
            }
            translate([-20,0,0])
                rounded_corner(rd=20,lg=10);
        }
        // circular bevel
        translate([-20,0,-1])
            cylinder(h=10,r1=23,r2=13,$fn=100);
        // bisel tangencial al arco inferior
        translate([-18,0,0])
        rotate([0,-90,0])
            cylinder(h=lg,r=22,$fn=4);
        // bisel superior
        translate([10,54,0])
        rotate([0,-90,0])
            cylinder(h=2*lg,r=21,$fn=4);
        // bisel en angulo lateral
        translate([41,0,0])
        rotate([-90,0,23.5])
            cylinder(h=3*lg,r=21,$fn=4);
    }
}


module half_handle(profile=wslot,lg=50,mt=4){
// Auxliliar module, Do NOT print!!
    
// profile = profile dimensions; 20 = 20x20, 22 = 22x22 and so...
// lg = handle lenght in mm
// mt = fixing screw metric; e.g., 4 = M4, and so...
    
    difference(){
        union(){
            quarter_handle(lg=lg);
            translate([0,0,profile])
            mirror([0,0,1])
                quarter_handle(lg=lg);
        }
        // fixing screw drill
        translate([10,-5,profile/2])
        rotate([-90,0,0])
            cylinder(h=30,d=mt+ease);
        // head screw recess
        translate([10,2*thwall,profile/2])
        rotate([-90,0,0])
            cylinder(h=30,d=8+ease);
    }
}


module handle(lg=90,mt=4){
    
// lg = handle lenght in mm
// mt = fixing screw metric; e.g., 4 = M4, and so...
    
    lenght = lg<40 ? 40 : lg;
    
    translate([lenght/2,0,0])
        half_handle(lg=lenght,mt=mt);
    translate([-lenght/2,0,0])
    mirror([1,0,0])
        half_handle(lg=lenght,mt=mt);
}


module full_model_extruder(){
    // Just as reference
    rotate([90,0,0])
    union(){
        %translate([(NEMA17/2)-1,74,57])
        rotate([0,180,0])
            hobbed_mk8();
        %translate([(NEMA17/2)-1,74,35])
            nema_motor(stepper=17,h=36);
        
        x_carriage(dejes=30);
        
        color("lightblue")
        translate([0,0,15])
            extruder_holder(erods=true);
        
        translate([18.5,75,54])
        rotate([180,0,-85])
            extruder_idler();
        
        color("lightgreen"){
            extruder();
        }
        
        color("maroon")
        translate([39,9,59.5])
        rotate([-90,0,0])
        union(){    
            translate([2,0,0])fan_pipe(l=40,isize=8);
            translate([4,2,-2])fan_nozzle();
        }
        translate([16,30,49])
        import("aux/mylite6.stl");
    }
}
