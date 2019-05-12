//------------------------------------------------------------
//      3D printed pieces for Baby Foldarap 3D printer
//------------------------------------------------------------
// (c) 2018 Isidoro Gayo Vélez (isidoro.gayo@wanadoo.es)
// Credits:
//-- Enmanuel Gillot, for his superb fodable 3D printer

//------------------------------------------------------------
//  Released under the terms of GNU/GPL v3.0 or higher
//------------------------------------------------------------


module z_motor_holder(profile=wslot,
                      thick=5,
                      mt=4,
                      center=true){
    
// profile = profile dimensions; 20 = 20x20, 22 = 22x22 and so...
// lprofile = profile lenght when it is not square-shape, in mm
// thick = thickness of NEMA motor fixing plate/collar
// mt = screw metric; e.g. 3 = M3, 4 = M4, and so...
// center = if motor plate should be centered or not

    NEMA = stepper==14 ? NEMA14 : NEMA17;
    
    difference(){
        union(){
            // base
            cube([profile+2*thwall,profile+2*thwall,profile]);
            // NEMA motor fastener
            union(){
                translate([NEMA/2+profile+3*thwall,NEMA/2+thwall,0])
                        motor_plate(ht=thick,
                        notch=true,
                        chamcor=false);
                // vertical side reinforcement
                translate([0,thwall,0])
                rotate([90,0,0])
                linear_extrude(height=thwall)
                    polygon(points=[[0,0],
                                    [0,profile],
                                    [2*thwall+profile,profile],
                                    [NEMA+3*thwall+profile,thick],
                                    [NEMA+3*thwall+profile,0]]);
                // second side reinforcement
                translate([2*thwall+profile,0,0])
                rotate([0,-90,0])  
                linear_extrude(height=thwall)
                    polygon(points=[[0,0],
                                    [0,NEMA+thwall],
                                    [thick,NEMA+thwall],
                                    [profile,2*thwall+profile],
                                    [profile,0]]);
                // needed for avoiding x carriage 
                // colission against upper joints
                translate([thwall+profile,0,0])
                    cube([2*thwall,NEMA+thwall,thick]);
            }
        }
        // room for aluminium profile
        translate([thwall-(ease/2),thwall-(ease/2),-1])
            cube([profile+ease,profile+ease,profile+2]);
        // fixings M3 screws
        translate([-1,(profile/2)+thwall,profile/2])
        rotate([0,90,0])
            cylinder(h=2*thwall,d=mt+ease,$fn=30);
    }
    
}


module z_upper_joint(profile=wslot,l=2.8*wslot,reinf=false,mt=4){

// profile = slot dimensions; 20 = 20x20, 22 = 22x22 and so...
// l = joint lenght in mm
// reinf = vertical reinforcement
// mt = fixing screw metric; 3 = M3, 4 = M4, and so...
    // body base
    union(){
        profile_joint(contactp=false,l=l,mt=mt);
        
        translate([thwall-ease/2,thwall+profile+ease,thwall])
            cube([profile+ease,3*thwall+ease,profile]);
    }
    if (reinf){
        // extra reinforcement
        difference(){
            translate([0,0,thwall+profile])
                cube([2*thwall+profile,
                thwall+profile,
                2*thwall+profile]);
            // room for profile
            translate([thwall,thwall,thwall+profile-1])
                cube([profile+ease,profile+1,2*thwall+profile+2]);
            // second M3 drill
            translate([thwall+profile/2,-1,thwall+1.8*profile])
            rotate([-90,0,0])cylinder(h=thwall+2,d=mt+ease,$fn=30);
            // cosmetic bevel
            translate([-profile/2,2*profile/3,3*profile])
            rotate([-45,0,0])
                cube([2*profile,
                    2*thwall+profile,
                    2*thwall+profile]);
        }
    }
}


module z_hinge_drills(profile=wslot,db=6,ds=5.2,pthk=2){

// Auxiliar module
    
    // profile = aluminium profile size, 20 = 20x20 and so...
    // db = biggest diameter on plunger in mm
    // ds = plunger body diameter in mm
    // pthk = collar plunger thikness in mm
    
    // Maximun height for outter hinge
    hm=2*profile+span;
    
    for(x=[-(hm-profile)/2,(hm-profile)/2]){
        for(y=[-(hm-profile)/2,(hm-profile)/2]){
            translate([x,y,-1]){
                cylinder(h=2*thwall+2,d=ds,$fn=30);
                cylinder(h=pthk,d=db,$fn=30);
            }
        }
    }
}


module z_hinge_outter(profile=wslot,mt=4,bsd=8,ssd=7){
    
// profile = profile dimensions in mm;
// e.g., 20 = 20x20, 15 = 15x15, and so...
// mt = fixing screw metric; e.g., 3 = M3, 4 = M4 and so...
// bsd = big splunger diameter in mm
// ssd = small splunger diameter in mm
// ct = collar splunger diameter in mm
    
    // Maximun height of this piece
    hm=2*profile+span;
    
    difference(){
        union(){
            // base
            difference(){
                linear_extrude(height=2*thwall)
                offset(r=3)
                    square(hm-6,center=true);

                // spring ball plunger holes
                z_hinge_drills(db=bsd,ds=ssd);
                // side teardrop-shape notches for looking good
                for(x=[-hm/2,hm/2]){
                    translate([x,0,-1])
                    rotate([0,-90,90])
                        teardrop(radius=span/2,
                                lenght=2*thwall+2,
                                angle=90);    
                }
            }
            // profile clamp
            translate([-thwall-profile/2,-hm/2+1.5*profile,2*thwall])
            difference(){
                translate([0,0,0])
                    cube([2*thwall+profile,
                        hm-1.5*profile,
                        2*thwall+profile]);
            // profile room
            translate([thwall,-1,thwall])
                cube([profile+ease,hm+2,profile+ease]);
            // teardrop-shape notch to make printing easier
            translate([profile/2,profile/2+span,2*thwall+profile])
            rotate([90,0,0])
                teardrop(radius=profile,
                                lenght=2*thwall+2,
                                angle=90); 
            }
        }    
        // fixing screws
        translate([-(2*thwall+profile+2)/2,
                    0,
                    3*thwall+profile/2])
        rotate([0,90,0])
            cylinder(h=2*thwall+profile+2,d=mt+ease);
        // M5 pivot head recess
        translate([0,0,thwall-0.5])
            cylinder(h=3*thwall+profile+2,r=4.6);
        // M5 axis pivot drill
        translate([0,0,-1])
            cylinder(h=4*thwall+profile+2,r=2.6);

    }
}


module z_hinge_inner(profile=wslot,lg=80,sw=6,mt=4){

// profile = slot dimensions; 20 = 20x20, 22 = 22x22 and so...
// lg = lenght of printed piece in mm
// sw = Slot width in mm 
// mt = fixing screw metric; e.g., 3 = M3, 4 = M4 and so...
    
    // fake aluminium slots for reference
    %translate([thwall+ease/2,0,-10])
        cube([profile,profile,lg+20]);
    %translate([profile+span+thwall+ease/2,0,-10])
        cube([profile,profile,lg+20]);
    
    // profile clamp
    difference(){
        // base
        translate([0,-3,0])
            cube([2*thwall+profile,2*thwall+profile,lg]);
        // profile room
        translate([thwall,0,-1])
            cube([profile+ease,profile+ease,lg+2]);
        translate([-1,-2*thwall,-1])
            cube([profile+2*thwall+2,2*thwall,lg+2]);
        // fixing screw
        translate([-1,profile/2,lg/2])
        rotate([0,90,0])
            cylinder(h=thwall+2,d=mt+ease);
    }
    // slot reinforcement
    translate([thwall+profile-3,(profile-sw)/2,0])
        cube([3.5,sw,lg]);
    // pivot holder part
    translate([2*thwall+profile,profile/2-ease+sw/2,0])
    rotate([90,0,0])
    difference(){
        for(feat=[[profile/2-ease+sw/2,span-thwall],[sw,span-thwall+3]]){
            linear_extrude(height=feat[0])
                polygon(points=[[0,0],
                                [0,lg],
                                [6,lg],
                                [feat[1],lg/2+6],
                                [feat[1],lg/2-6],
                                [6,0]]);
        }
        // M5 pivot drill
        translate([(span-ease)/2-4,lg/2,-1])
            cylinder(h=14,d=5+ease);
    }
    // internal corner reinforcement
    translate([2*thwall+profile,(profile+sw)/2-ease,lg/2])
        wedge(ld=6,wd=6,hg=lg);
}

