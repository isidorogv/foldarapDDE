//------------------------------------------------------------
//      3D printed pieces for Baby Foldarap 3D printer
//------------------------------------------------------------
// (c) 2018 Isidoro Gayo Vélez (isidoro.gayo@gmail.com)
// Credits:
//--> Enmanuel Gillot

//------------------------------------------------------------
//  Released under the terms of GNU/GPL v3.0 or higher
//------------------------------------------------------------


// Auxiliar module for knob module
module screw_drills(nr=3.2,sr=1.6,nt=2,dd=10){
    
    // Makes drills in knob in order to the screw
    // (knob axis) and a nut if needed. An screw
    // with hexagonal head can also be used.
        
    // by default, M3 is set.
    
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


// This is an auxiliar module, DO NOT print!!
module minihotbed(){

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


module spool_clamp(m=8,ht=40,perfil=20,slot=6){
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

// para la babyfolda, NO BORRAR!!!
module board_holder(rd=3){
    
    difference(){
        hull(){
            cylinder(h=wslot,r=rd,$fn=10*rd);
            translate([0,-rd,0])cube([9,2*rd,wslot]);
        }
        translate([0,0,-1])cylinder(h=wslot+2,r=1.3,$fn=30);
    }
    
    translate([0,0,-thwall])difference(){
        hull(){
            cylinder(h=thwall,r=rd,$fn=10*rd);
            
            translate([1.4*wslot,0,0])
                cylinder(h=thwall,r=rd,$fn=10*rd);
        }
        translate([9+wslot/2,0,-1])
            cylinder(h=thwall+2,r=1.6,$fn=10*rd);
    }
}


// para la babyfolda, NO BORRAR!!!
module PSU_switch_plate(hg=span+2*wslot+2*thwall,wd=60){
    
// hg = plate size from top to bottom in mm
// wd = plate size from left to right in mm
    ws=13;  // switch widht in mm
    ls=19;  // switch lenght in mm
    rp=4; // power plug radius in mm
    
    difference(){
        // base plate
        linear_extrude(height=thwall)
        offset(delta=3,chamfer=true)
            square([wd-6,hg-6],center=true);
        // room for power switch
        translate([-1.5*ws,-ls/2-3,-1])union(){
            translate([0,3,0])
            linear_extrude(height=thwall+2)
                square([ws+ease,ls+ease]);            
            translate([0,0,2])cube([ws+ease,ease+ls+6,thwall]);
        }
        // drill for power plug
        translate([2.5*rp,0,-1])
        linear_extrude(height=thwall+2)
            // plug radius plus 0.1 mm
            circle(r=rp+0.1,$fn=30);
        translate([2.5*rp,0,1])
        linear_extrude(height=thwall+2)
            circle(r=rp+1.6,$fn=30);
        // M3 fixing screws
        for(x=[23,-23]){
            for(y=[(hg-wslot)/2,-(hg-wslot)/2]){
                translate([x,y,-1])cylinder(h=thwall+2,r=1.6,$fn=30);
            }
        }
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
// Auxliliar module
    
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
