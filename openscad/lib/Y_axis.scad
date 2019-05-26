//------------------------------------------------------------
//      3D printed pieces for Baby Foldarap 3D printer
//------------------------------------------------------------
// (c) 2018-2019 Isidoro Gayo Vélez (isidoro.gayo@gmail.com)

// Credits:
//--> Enmanuel Gillot

//------------------------------------------------------------
//  Released under the terms of GNU/GPL v3.0 or higher
//------------------------------------------------------------


module profile_joint(profile=wslot,l=2.5*wslot,mt=3,contactp=true){

// profile = slot dimensions; 20 = 20x20, 22 = 22x22 and so...
// l = lenght
// mt = metric for fixing screws; e.g. 3 = M3, 4 = M4, and so...
// contactp = foot contact point with table plane
    
    difference(){
        // preform base
        translate([2*thwall+profile,0,0])
        rotate([0,-90,0])
        linear_extrude(height=2*thwall+profile)
            polygon(points=[[0,0],
                            [0,l+thwall],
                            [profile+thwall-5,l+thwall],
                            [profile+thwall,l+thwall-5],
                            [profile+thwall,0]]);
        // profile room
        translate([thwall-ease/2,thwall,thwall])
            cube([profile+ease,l+profile,profile+2]);
        
        // M3 fixing screws on XY plane...
        translate([thwall+(profile-ease)/2,l-2*thwall,-1])
            cylinder(h=thwall+2,d=mt+0.2,$fn=30);
        // ... and on XZ plane
        translate([thwall+(profile-ease)/2,-1,thwall+profile/2])
        rotate([-90,0,0])
            cylinder(h=thwall+2,d=mt+0.2,$fn=30);
    }
    if(contactp){
        // part on XY plane
        translate([2*thwall+profile,0,0])
        linear_extrude(height=thwall)
        polygon(points=[[0,0],
                        [0,l+thwall],
                        [4,l+thwall],
                        [10,l+thwall-6],
                        [10,0]]);
        // part on XZ plane
        translate([2*thwall+profile,thwall,0])
        rotate([90,0,0])
        linear_extrude(height=thwall)
        polygon(points=[[0,0],
                        [0,profile+thwall],
                        [5,profile+thwall],
                        [10,profile+thwall-5],
                        [10,0]]);
        // reinforcement between XY and XZ planes
        translate([2*thwall+profile,thwall,thwall])
        rotate([90,0,90])
        linear_extrude(height=10)
        polygon(points=[[0,0],
                        [0,(profile/2)+2],
                        [2,profile/2],
                        [6,profile/2],
                        [8,(profile/2)-2],
                        [8,2],
                        [10,0]]);
    }
}


module foot(profile=wslot,lg=40,mt=3,d=span){

// profile = profile dimensions in mm, e.g., 20 = 20x20
// lg = foot lenght in mm
// mt = fixing screw metric
// d = span or distance between profile joints, in mm
    
    profile_joint(profile=profile,l=lg,mt=mt);
    translate([-profile-d,0,0])
        profile_joint(profile=profile,l=lg,mt=mt,contactp=false);
    // central joint
    translate([-d+2*thwall,0,0])union(){
        linear_extrude(height=thwall)
        polygon(points=[[0,0],
                        [0,3*lg/4],
                        [(d-2*thwall)/2,lg/2],
                        [d-2*thwall,3*lg/4],
                        [d-2*thwall,0]]);
        
        translate([0,thwall,0])
        rotate([90,0,0])
        linear_extrude(height=thwall)
        polygon(points=[[0,0],
                        [0,thwall+profile],
                        [(d-2*thwall)/4,2*profile/3],
                        [3*(d-2*thwall)/4,2*profile/3],
                        [d-2*thwall,thwall+profile],
                        [d-2*thwall,0]]);
    }
}


module y_belt_clamp(cs=2*lbearing,ch=8,bthk=0.8,pitch=2){

// cs = clamp size (lenght) in mm
// ch = clamp height in mm, it includes the fixing part
// bthk = belt thickness in mm
// pitch = belt pitch in mm; e.g. 2 -> GT2, 2.5 -> T2.5,...
    
    // fixing part
    translate([0,0,6])
    rotate([-90,0,0])
    difference(){
        // fixing base
        linear_extrude(height=5)
        offset(delta=3,chamfer=true)
            square([cs-6,6],center=true);
        // M3 fixing screw drills
        for(x=[-cs/2+5,cs/2-5]){
            translate([x,0,-1])
            rotate([0,0,30])
            for(feat=[[7,1.6,50],[4,3.2,6]]){
                cylinder(h=feat[0],r=feat[1],$fn=feat[2]);         
            }
        }
    }
    // belt clamp
    translate([0,-(ch/2+6)+5,0])
    difference(){
        // body base
        linear_extrude(height=12)
        offset(delta=3,chamfer=true)
            square([(cs-6)-20,ch],center=true);
        // clamp
        for(y=[-ch/2+1,-ch/2+6]){
            translate([-cs/2,y,thwall])
            union(){
                // belt base
                cube([60,bthk,12]);
                // bevel for an easy belt placement
                translate([0,bthk/2,6.5])
                rotate([45,0,0])
                    cube([60,10,10]);
                // belt teeth
                for(i=[0:cs]){
                    translate([pitch*i,-0.75,0])
                        cube([1,1.5,12]); 
                }
            }
        }
    }
}


module y_motor_holder(profile=wslot,stepper=14,thick=5,mt=4){
    
    NEMA = stepper==14 ? [NEMA14,26,24] : [NEMA17,31,24];
    
    // base
    motor_plate(thick=thick,
                stepper=stepper,
                chamcor=false,
                half=true);

    // fixing plate
    translate([-NEMA[0]/2,0,thick/2])
    rotate([0,-90,0])
        difference(){
            // main body
            linear_extrude(height=thwall)
            offset(delta=2,chamfer=true)
                square([thick-4,span+2*profile-4],center=true);
            // fixing drills
            for(y=[(span+profile)/2,-(span+profile)/2]){
                translate([0,y,-1])
                    cylinder(h=thwall+2,d=mt+ease);
                echo((span+profile)/2);
            }
        }
}


module y_motor_idler(profile=wslot,
                        thick=5,
                        mt=4,
                        bthick=13,
                        bd=11){

// thick = base thickness in mm.
// mt = metric for fixing screws
// bthick = bearing thickness in mm
// bd = bearing diameter in mm
    
    vpos = span+2*profile-6;    // auxiliar variable for drills
    
    // fixing base for the idler
    difference(){
        // fixing base
        linear_extrude(height=thick)
        offset(r=3,chamfer=false)
            square([bthick+2*thwall-6,vpos],center=true);

        // fixing screw drills
        for(y=[vpos/2-profile/2+3,vpos/2-20,-vpos/2+profile/2-3]){
            translate([0,y,-1])
                cylinder(h=thick+2,d=mt+ease);
        }
        // screw heads
        for(y=[vpos/2-profile/2+3,-vpos/2+profile/2-3]){
            translate([0,y,thwall])
                cylinder(h=thick+2,r=3.5);
        }
        // hollow for saving filament/printing time
        translate([0,-8,-1])
            hollow(wd=30,lg=bthick-thwall,rd=2,hg=thick+2);
    }
    // side walls
    for(x=[-thwall-9.5+3,9.5-3+ease]){
        translate([x,vpos/2-20,3*thwall+thick])
        rotate([0,90,0])
        hull(){
            translate([0,bd/2-3,0])
                cylinder(h=thwall-ease,r=3);
            translate([0,-bd/2+3,0])
                cylinder(h=thwall-ease,r=3);
            translate([3*thwall,-bthick,0])
                cube([thwall,2*bthick,thwall-ease]);
        }
    }
}


module y_bearing_clamp(h=14,wd=2*rbearing+6,th=2*lbearing,cham=2){
    
// h = clamp height in mm
// wd = clamp width in mm
// th = clamp thickness in mm
// cham = chamfer in upper bearing clamp border in mm
    
    difference(){
        union(){
            // clamp base
            translate([0,th,0])
            rotate([90,0,0])
            linear_extrude(height=th)
                polygon(points=[[0,0],
                                [0,h-cham],
                                [cham,h],
                                [wd-cham,h],
                                [wd,h-cham],
                                [wd,0]]);
            // fixing base
            cube([wd+9,th,6]);
        }
        // clamp room
        translate([wd/2,-1,h-3])
        rotate([-90,0,0])
            cylinder(h=th+2,r=rbearing);
        // fixing screws
        for(y=[6,th-6]){
            translate([wd+4,y,-1]){
                cylinder(h=8,r=1.6);
                translate([0,0,4])
                rotate([0,0,30])
                    cylinder(h=4,r=3.2,$fn=6);
            }
        }
    }
}


module frog(btk=thwall,ad=27){

// btk = base thickness in mm
// ad = lower arm distance in mm
    
    difference(){
        frog_base(btk=btk,dist=ad);
        
        // endstop drills
            for(y=[((2*lbearing+2)/2)-4,-((2*lbearing+2)/2)+4]){
                translate([12,y,0])
                for(a=[-9.2/2,9.2/2]){
                    translate([a,0,-1])
                        cylinder(h=btk+2,r=1.4);
                }
            }
        // hole for fixing screws
        for(x=[bhole,-bhole]){
            for(y=[-bhole,bhole]){
                translate([x,y,-1])
                    cylinder(h=btk+2,r=1.6);
            }
        }
        // M3 drills for belt holder
        translate([-5,0,-2])
        for(y=[lbearing-3,-lbearing+3]){
            translate([0,y,0])
                cylinder(h=10,r=1.6);
        }
    }
}


module frog_arm(btk=thwall,dist=27){

// Auxiliar module, NOT for printing!!
    
// btk = base thickness in mm
// dist = lower arm distance in mm
    
    d = dist > bhole-10 ? bhole-10 : dist;    

    // we build right arm, middle support
    // and left arm all in one time
    for(i=[[[-bhole,bhole,5],thwall,4,[-d,lbearing-4,5],thwall,6],
            
            [[bhole,bhole,5],thwall,4,[d,lbearing-4,5],thwall,6]]){
        hull(){
            translate(i[0])
                cylinder(h=i[1],r=i[2]);
            translate(i[3])
                cylinder(h=i[4],r=i[5]);
        }
    }
}


module frog_base(rad=3,btk=thwall,dist=27){

// Auxiliar module, NOT for printing!!
    
    // btk = base thickness in mm
    // rad = roundness radio on corners in mm
    
    // frog base width in mm    
    lx = ((drod-2*(rbearing+3))-2*rad)/2;
    // frog base height
    ly = ((2*lbearing+2)-2*rad)/2;
    
    difference(){
        // base
        union(){
            linear_extrude(height=btk)
            offset(r=rad)
                square([2*lx,2*ly],center=true);
            translate([0,0,-5]){
                frog_arm(btk=btk,dist=dist);
            mirror([0,1,0])
                frog_arm(btk=btk,dist=dist);
            }
        }
        // M3 fixing side slots
        for(x=[lx+1,-lx-1]){
            for(y=[-(2*lbearing-12)/2,(2*lbearing-12)/2]){
                translate([x,y,0])
                hull(){
                    translate([-2,0,-2])
                        cylinder(h=10,r=1.6);
                    translate([2,0,-2])
                        cylinder(h=10,r=1.6);
                }
            }
        }        
        // holes for saving filament
        for(x=[-lx/2,lx/2]){
            translate([x,0,-5])
                hollow(lg=3*lx/5);
        }
    }
}


module y_rod_holder(bl=2.5*(rrod+9),bw=wslot,bthick=3,mt=4){

    // bthick = base thickness in mm.
    // bl = base lenght in mm.
    // bw = base width in mm.
    // mt = metric of fixing holes, e.g. 3 = M3, 4 = M4, and so...
    
    // fixing base on the slot
    difference(){
        // base
        linear_extrude(height=bthick)
        offset(r=2,$fn=30)
            square([bl-4,bw-4],center=true);

        // M3 fixing screw drills
        for(x=[-bl/2+mt,bl/2-mt]){
            translate([x,0,-1])
                cylinder(h=bthick+2,d=mt+ease);
        }
    }

    translate([0,-rrod+2,bthick])
    difference(){
        // rod clamp base
        linear_extrude(height=wslot)
        offset(r=3,$fn=30)
            square([rrod+3,rrod+3],center=true);
        // rod clamp room
        #translate([0,0,-1])
            cylinder(h=wslot+2,r=rrod);
        translate([-1.5*(rrod+3),rrod/2,-1])
            cube([3*(rrod+3),3*bw,wslot+2]);
    }
}


module y_belt_clamp02(){
    
// PRUSA iteration3 Y belt holder
// Original idea by Josef Průša <iam@josefprusa.cz> 
// and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org
// Released under the terms of GNU-GPL v3 or higher
// -------------------------------------------------------
// Modified by Isidoro Gayo <isidoro.gayo@gmail.com>
// for Huxley i3/Foldarap 3D printers (oct 2018/apr 2019)
// -------------------------------------------------------
    
    difference(){
        // main body
        union(){
            // upper part (screws)...
            linear_extrude(height=15)
            offset(chamfer=true)
                square([28,25]);
            // ... and lower part (belt)
            translate([-10,26,1])
            rotate([90,0,0])
            linear_extrude(height=8)
            offset(chamfer=true)
                square([48.5,13]);
        }
        // belt space cutaway around belt pivots
        for(pos=[[16,18,2],[12,5,2]]){
            translate(pos) 
                cylinder(h=16,r=7.2);  
        }
    
        // belt clamp notches and bevels
        for(p=[[[10,7,2],[0,0,0],[32,2.1,16]],
            [[16,8,12],[45,0,0],[15,5,5]],
            [[-20,9,2],[0,0,0],[28,2.1,16]],
            [[-2,10,12],[45,0,0],[10,5,5]]]){     
            
            translate(p[0]) 
            rotate(p[1])
                cube(p[2]);
        }        
        // drills for all screws
        translate([-2,0,0])
        // left and right screw holes
        for(pos=[[-4,17,7.5],[36,17,7.5]]){
            translate(pos)
            rotate([-90,0,0])
            union(){
                // drill for one screw
                hull(){
                    for(c=[[-1.5,0,0],[1.5,0,0]]){
                        // screw drill
                        translate(c)
                            cylinder(h=10,r=1.6);
                        }
                }            
                hull(){
                    for(c=[[-1.5,0,0],[1.5,0,0]]){
                        // head screw recess
                        translate(c)
                            cylinder(h=5,r=3);
                    }
                }
            }
        }        
        // removing minor details for cosmetic improvement
        rotate([0,0,40]) 
        translate([11,1,2]) 
            cube([10,4,16]);        
    }
    // placing the belt pivots on main body
    for(xy=[[16,18,0],[12,5,0]]){
        translate(xy)
        // belt pivot
        for(p=[[[0,0,0],11,3.5,3.5],
                [[0,0,11],3,3.5,2.5]]){
            // lower and upper part
            translate(p[0])
                cylinder(h=p[1],r1=p[2],r2=p[3]);
        }
    }
}


module y_endstop_adj(profile=wslot,hg=50,mt=4){

    difference(){
        // base
        hull(){
            for(x=[profile/2+5,-profile/2-5]){
                translate([x,0,0])
                    cylinder(h=hg,d=10);
            }
            linear_extrude(height=hg)
            square(profile,center=true);
        }
        // M4 fixing screw drills
        for(x=[profile/2+5,-profile/2-5]){
            translate([x,0,-1])
                cylinder(h=hg+2,d=mt+ease);
            translate([x,0,3])
                    cylinder(h=hg,d=8.2);
        }
        // M3 drill for adjustement head
        translate([0,0,-1])
            cylinder(h=hg+2,r=1.4);
        // cosmetics and for saving filament/printing time
        hull(){
            translate([0,0,profile])
                beveled_hollow(lg=0.8*profile,
                                wd=profile+2,
                                hg=profile,rd=3);
            
            translate([0,0,1.5*profile])
            rotate([-90,0,0])
                cylinder(h=50,d=0.8*profile,$fn=4,center=true);
        }
        for(x=[profile/2+20,-profile/2-20]){
            translate([x,0,-1])
            rotate([0,0,45])
                cylinder(h=hg+2,d1=30,d2=60,$fn=4);
        }
    }
}
