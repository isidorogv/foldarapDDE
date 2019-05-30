//-----------------------------------------------------------
//  ---- Core modules for Scalable Foldarap 3D printer ----
//-----------------------------------------------------------
// (c) 2018-2019 Isidoro Gayo Vélez (isidoro.gayo@gmail.com)

// Credits:
// -- Enmanuel Gillot, for his superb fodable 3D printer

//------------------------------------------------------------------
//       Released under the terms of GNU/GPL v3.0 or higher
//------------------------------------------------------------------


module sync_bearing_holder(thick=13,bd=14){
    
// thick = maximun room for synchronic bearing + holder, in mm.
    
    // main body
    difference(){
        // base preform
        translate([-4,-4,0])
        linear_extrude(height=thick)
        offset(delta=2,chamfer=true)
            square([bd+2,8]);
        
        // room for synchronic bearing
        translate([-bd/2,-10,(thick+ease-9)/2])
            cube([bd+1,20,9+ease]);
        // M3 axis drill
        translate([0,0,-1])
            cylinder(h=thick+2,r=1.4);
        // drill for M3 belt tensioner screw (head+thread)
        #translate([bd/2,0,thick/2])
        rotate([0,90,0])
        union(){
            rotate([0,0,30])
                cylinder(h=3,r=3.3,$fn=6);
            cylinder(h=10,r=1.6);
        }
    }
    // fake synchronic bearing
    %translate([0,0,(thick-9)/2+ease])
    union(){
        cylinder(h=1,d=14);
        cylinder(h=9,d=10);
        translate([0,0,8])
            cylinder(h=1,d=14);
    }
}


module slot_clamp(profile=wslot,h=NEMA17,ssize=5){

// Auxiliar module for motor holder and idler, 
    // DO NOT print it!
    
    // angle base
    difference(){
        cube([profile+thwall,profile+thwall,h]);
        translate([thwall-ease/2,thwall-ease/2,-1])
            cube([profile+ease,profile+ease,h+2]);
    }
    // slot pieces
    translate([thwall-ease,(profile-ssize)/2+thwall+ease/2,0])
        cube([3.5,ssize-ease,h]);
    translate([(profile-ssize)/2+thwall+ease/2,thwall-ease,0])
        cube([ssize-ease,3.5,h]);
    
    // fake profile for reference
    %translate([thwall,thwall,-10])
        cube([profile,profile,100]);
}


module teardrop(radius,length,angle) {

// Parametric teardrop script
// by whosawhatsis Jun 30, 2010 

// https://www.thingiverse.com/thing:3457/files

// This script generates a teardrop shape at the 
// appropriate angle to prevent overhangs greater 
// than 45 degrees. The angle is in degrees, and is
// a rotation around the Y axis. You can then rotate 
// around Z to point it in any direction. Rotation 
// around Y or Z will cause the angle to be wrong.
  
	rotate([0,angle,0]) 
    union(){
		linear_extrude(height=length, 
                        center=true, 
                        convexity=radius, 
                        twist= 0)
			circle(r=radius,center=true);
        
		linear_extrude(height=length, 
                        center=true, 
                        convexity=radius, 
                        twist=0)
        projection(cut=false) 
        rotate([0,-angle,0]) 
        translate([0,0,radius*sin(45)*1.5]) 
            cylinder(h=radius*sin(45), 
                    r1=radius*sin(45), 
                    r2=0,center=true);
	}
}


module dim_line(l=10,d=30){
// Auxiliary module
    // Used for dimensioning POM wheels
    color([0,0,0]){
        translate([0.5,d/2,0])rotate([0,90,0])
            cylinder(h=l,r=0.1);
        translate([l-1,0,0])rotate([-90,0,0])
            cylinder(h=d/2,r=0.1);
        translate([l-1,d/2-1.5,0])rotate([-90,0,0])
            cylinder(h=1.5,r1=0.3,r2=0.1,$fn=15);
    }    
}


module dimension(sep=10,dim=10,tsize=4){
// Auxiliary module
    // Used for dimensioning POM wheels    
    dim_line(l=sep,d=dim);
    mirror([0,1,0])dim_line(l=sep,d=dim);
    color([0,0,0])
    translate([sep,0,0])
    rotate([0,0,90])
        text(str(dim),halign="center",valign="top",size=tsize);
}


module POMwheel(outd=24,axd=5,thw=10,fp=5.6,dim=false){
    // POM wheel model
    
    // outd = outer wheel diameter in mm
    // axd = axis wheel diameter in mm.
    // thw = thickness wheel in mm.
    // fp = footprint wheel in mm.
    // dim = shows dimensions
    
    // If you have any doubt, set dim variable in
    // order to show the aforementioned variables
    
    tyre=[  [0,0],
            [0,1],
            [(thw-fp)/2,1+(thw-fp)/2],
            [(thw-fp)/2+fp,1+(thw-fp)/2],
            [thw,1],
            [thw,0]
    ];
    // POM tyre
    color([0,0,0])
    rotate_extrude($fn=100)
    rotate([0,0,90])
    translate([0,(outd/2)-1-(thw-fp)/2,0])
        polygon(points=tyre);
    // bearing
    color("silver")
    difference(){
        cylinder(h=thw,d=outd-(thw-fp)-2,$fn=50);
        translate([0,0,-1])cylinder(h=thw+2,d=axd,$fn=50);
    }
    // show dimensions
    if(dim){
        dimension(sep=outd/2+5,dim=outd);
        translate([0,0,thw])rotate([0,0,-90])
            dimension(sep=outd/2+5,dim=axd);
        translate([-5,0,thw/2])rotate([-90,0,180])
            dimension(sep=outd/2+5,dim=thw);
        translate([0,5,thw/2])rotate([-90,0,90])
            dimension(sep=outd/2+5,dim=fp);
    }    
}


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


module hobbed_mk8(al=11,rd=4.5,rd2=3.5){

	//color("lightgrey")
    difference(){
		union(){
			cylinder(h=al-5, r=rd, $fn=20*rd);
			translate([0,0,al-5])
                cylinder(h=2, r1=rd, r2=rd2, $fn=20*rd);
			translate([0,0,al-3])
                cylinder(h=2, r1=rd2, r2=rd, $fn=20*rd);
			translate([0,0,al-1])
                cylinder(h=1, r=rd, $fn=20*rd);
		}
		translate([0,0,-5])cylinder(h=2*al, r=2.5, $fn=50);
	}
}


module motor_plate(thick=5,
                    stepper=stepper,
                    notch=false,
                    chamcor=true,
                    half=false){
    
// thick = plate thickness in mm
// e.g., 14 = NEMA14, 17 = NEMA17, and so...
// stp = stepper motor type; NEMA14 or NEMA17
// notch = motor plate with only 3 fixing screws
// chamcor = chamfer on corners
// half = shows only a half motor plate
    
    NEMA = stepper==14 ? [NEMA14,26,24] : [NEMA17,31,24];
    
    difference(){
        // preform base
        linear_extrude(height=thick)
        offset(delta=2,chamfer=chamcor)
            square(NEMA[0]-4,center=true);
        
        // drills for M3 fixing screws
        for(x=[NEMA[1]/2,-NEMA[1]/2]){
            for(y=[NEMA[1]/2,-NEMA[1]/2]){
                translate([x,y,-1]){
                    cylinder(h=thick+2,r=1.6);
                    translate([0,0,5])
                        cylinder(h=thick,r=3);
                }
            }
        }
        // room for Nema collar
        translate([0,0,-1])cylinder(h=thick+2,d=NEMA[2]);
        // side notch
        if(notch){
            translate([-5,-5,-1])
                cube([NEMA[0]+5,NEMA[0]+5,thick+2]);
        }
        if(half){
            translate([-5,-NEMA[0]/2-2.5,-1])
                cube([NEMA[0]+5,NEMA[0]+5,thick+2]);
        }
    }
    // rounded notch borders
    if(notch){
        translate([-5,
                    NEMA[0]/2
                    -(NEMA[0]/2-sqrt(pow(NEMA[2]/2,2)-pow(5,2)))/2,
                    0])
            cylinder(h=thick,
                r=(NEMA[0]/2-sqrt(pow(NEMA[2]/2,2)-pow(5,2)))/2);
        
        translate([NEMA[0]/2
                    -(NEMA[0]/2-sqrt(pow(NEMA[2]/2,2)-pow(5,2)))/2,
                    -5,0])
            cylinder(h=thick,
                r=(NEMA[0]/2-sqrt(pow(NEMA[2]/2,2)-pow(5,2)))/2);
    }
    if(half){
        translate([-5,
                    NEMA[0]/2
                    -(NEMA[0]/2-sqrt(pow(NEMA[2]/2,2)-pow(5,2)))/2,
                    0])
            cylinder(h=thick,
                r=(NEMA[0]/2-sqrt(pow(NEMA[2]/2,2)-pow(5,2)))/2);
        
        translate([-5,
                    -NEMA[0]/2
                    +(NEMA[0]/2-sqrt(pow(NEMA[2]/2,2)-pow(5,2)))/2,
                    ,0])
            cylinder(h=thick,
                r=(NEMA[0]/2-sqrt(pow(NEMA[2]/2,2)-pow(5,2)))/2);
        
        
    }
    // just for reference
    %cylinder(h=10,r=2.5);
}


module nema_motor(stepper=14,h=33,daxis=false,hobbed=false){

// 3D NEMA stepper model
    
// type = type of stepper motor,
// e.g., 14 = NEMA14 or 17 = NEMA17
    
// h = motor height
// daxis = dual axis
// hobbed = Shows hobbed Mk8 
    
    NEMA = stepper==14 ? [NEMA14,26,24] : [NEMA17,31,24];
    // these three values are:
    //  1st -> motor dimensions, lenght and width in mm.
    //  2nd -> screw distance in mm.
    //  3td -> collar diameter in mm.
    
    for(feat=[["lightgray",[0,0,0],5],
                ["black",[0,0,-h+13],h-13],
                ["lightgray",[0,0,-h+5],8]]){
        color(feat[0])
        translate(feat[1])
        linear_extrude(height=feat[2])
        offset(delta=2.5,chamfer=true)
            square(NEMA[0]-5,center=true);
    }
    // NEMA collar
	color("white")
    translate([0,0,5])
        cylinder(h=2, r=11, $fn=50);

	axispos = daxis ? -h-6 : 5;
	axislenth = daxis ? h+32 : 20;

	color("gray")
    translate([0,0,axispos])
		cylinder(h=axislenth,r=2.5);

    if (hobbed){
        translate([0,0,7])hobbed_mk8();
    }

	// fixing screws, for reference
	#union(){
        for(x=[NEMA[1]/2,-NEMA[1]/2]){
            for(y=[NEMA[1]/2,-NEMA[1]/2]){
                    translate([x,y,0])cylinder(h=8,r=1.5,$fn=30);
            }
        }
    }
}


module hotendhead(filament=true,bcoupling=true){
    
    union(){
        cylinder(h=20,r=8.15);

        if (bcoupling)
            translate([0,0,0])cylinder(h=17.75,r=4);
        
        // 4mm bowden hole for 1,75mm filament
        if (filament)
            translate([0,0,-10])cylinder(h=100,r=2.1);
    }
}


module hollow(rd=5,lg=35,wd=20,hg=20){

// A cube with rounded corners (radius rd) on XY plane 
// and its height on Z axis is hg. All ammounts in mm.
// rd = corner radius in mm.
// lg = length, in mm.
// wd = width in mm.
// hg = height in mm.
    
    linear_extrude(height=hg)
    offset(r=rd)
        square([lg-2*rd,wd-2*rd],center=true);
}


module beveled_hollow(rd=5,lg=35,wd=20,hg=20){

// A cube with rounded corners and edges (radius rd) 
// and its height on Z axis is hg. All ammounts in mm.
// rd = bevel radius in mm.
// lg = length, in mm.
// wd = width in mm.
// hg = height in mm.
    
    minkowski(){
        sphere(rd);
        cube([lg-2*rd,wd-2*rd,hg-2*rd],center=true);
    }
}


module wedge(ld=15,wd=15,hg=20){

// A 90 degrees triangle on XY plane
// lg = lenght in mm (X coord.)
// wd = width in mm (Y coord.)
// hg = height in mm (Z coord.)
    
    linear_extrude(height=hg,
        twist=0,
        center=true,
        //convexity=10,
        slices=30)
            polygon(points=[[0,0],
                            [ld,0],
                            [0,wd]],
                            paths=[[0,1,2]]);
}


module rounded_corner(rd=5,lg=30){

// A rounded corner on XY plane with lg height on Z axis
// rd = radius
// lg = length
    
	difference(){
		cube([rd+0.1, rd+0.1, lg]);
		translate([0,0,-2])cylinder(h=lg+4, r=rd, $fn=15*rd);
	}
}

