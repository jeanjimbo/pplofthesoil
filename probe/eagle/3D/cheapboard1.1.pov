//POVRay-File created by 3d41.ulp v1.05
//C:/Users/ben/Dropbox/eagle/peopleofthesoil/cheapboard1.1.brd
//23/04/2013 23:27:23

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = off;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = off;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

#declare global_show_screws = on;
#declare global_show_washers = on;
#declare global_show_nuts = on;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 2;
#declare pin_short = on;

#declare environment = on;

#local cam_x = 100;
#local cam_y = 207;
#local cam_z = -78;
#local cam_a = 40;
#local cam_look_x = 0;
#local cam_look_y = -3;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
#local pcb_rotate_y = 0;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 40;
#local lgt1_pos_y = 60;
#local lgt1_pos_z = 18;
#local lgt1_intense = 0.751636;
#local lgt2_pos_x = -40;
#local lgt2_pos_y = 60;
#local lgt2_pos_z = 18;
#local lgt2_intense = 0.751636;
#local lgt3_pos_x = 40;
#local lgt3_pos_y = 60;
#local lgt3_pos_z = -12;
#local lgt3_intense = 0.751636;
#local lgt4_pos_x = -40;
#local lgt4_pos_y = 60;
#local lgt4_pos_z = -12;
#local lgt4_intense = 0.751636;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 105.410000;
#declare pcb_y_size = 34.290000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 0;
#declare inc_testmode = off;
#declare global_seed=seed(830);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "tools.inc"
#include "user.inc"

global_settings{charset utf8}

#if(environment=off)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Animation data
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "No/not enough Animation Data available (min. 3 points) (Flight path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "No/not enough Animation Data available (min. 3 points) (View path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//translates the camera that <0,0,0> is over the Eagle <0,0>
	//translate<-52.705000,0,-17.145000>
}
#end

background{col_bgr}


//Axis uncomment to activate
//object{TOOLS_AXIS_XYZ(100,100,100 //texture{ pigment{rgb<1,0,0>} finish{diffuse 0.8 phong 1}}, //texture{ pigment{rgb<1,1,1>} finish{diffuse 0.8 phong 1}})}

light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro CHEAPBOARD1_1(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,24
<8.890000,0.000000><102.870000,0.000000>
<102.870000,0.000000><78.740000,11.430000>
<78.740000,11.430000><68.580000,11.430000>
<68.580000,11.430000><68.580000,22.860000>
<68.580000,22.860000><80.010000,22.860000>
<80.010000,22.860000><102.870000,34.290000>
<102.870000,34.290000><8.890000,34.290000>
<8.890000,34.290000><8.890000,24.130000>
<8.890000,24.130000><-2.540000,24.130000>
<-2.540000,24.130000><-2.540000,11.430000>
<-2.540000,11.430000><8.890000,11.430000>
<8.890000,11.430000><8.890000,0.000000>
texture{col_brd}}
}//End union(Platine)
//Holes(real)/Parts
//Holes(real)/Board
//Holes(real)/Vias
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_SMD_CHIP_0805(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<11.430000,0.000000,21.844000>translate<0,0.035000,0> }#end		//SMD Capacitor 0805 C1  0805
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_SMD_CHIP_0805(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<11.430000,0.000000,13.716000>translate<0,0.035000,0> }#end		//SMD Capacitor 0805 C2  0805
#ifndef(pack_C3) #declare global_pack_C3=yes; object {CAP_SMD_CHIP_0805(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<21.590000,0.000000,11.430000>translate<0,0.035000,0> }#end		//SMD Capacitor 0805 C3  0805
#ifndef(pack_C4) #declare global_pack_C4=yes; object {CAP_SMD_CHIP_0805(DarkWood)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<11.430000,0.000000,10.668000>translate<0,0.035000,0> }#end		//SMD Capacitor 0805 C4  0805
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_SMD_CHIP_0805("0R0",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<48.260000,0.000000,12.700000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R1  M0805
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_SMD_CHIP_0805("0R0",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<48.260000,0.000000,22.860000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R2  M0805
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_SMD_CHIP_0805("0R0",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<53.086000,0.000000,17.399000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R3  M0805
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_SMD_CHIP_0805("0R0",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<11.430000,0.000000,16.510000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R4  M0805
#ifndef(pack_R5) #declare global_pack_R5=yes; object {RES_SMD_CHIP_0805("0R0",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<11.430000,0.000000,19.050000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R5  M0805
#ifndef(pack_R6) #declare global_pack_R6=yes; object {RES_SMD_CHIP_0805("0R0",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<16.510000,0.000000,24.130000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R6  M0805
#ifndef(pack_R7) #declare global_pack_R7=yes; object {RES_SMD_CHIP_0805("0R0",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<12.192000,0.000000,24.130000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R7  M0805
#ifndef(pack_T1) #declare global_pack_T1=yes; object {TR_TO92_G("BC547",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<46.990000,0.000000,17.780000>}#end		//TO92 bend vertical T1 BC547 TO92
}//End union
#end     
#macro IC_SMD_PLCC32(value)  
union{
object{IC_SMD_PLCC_GRND(11.45,14,7,9,1.5)}  
}
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
#ifndef(global_pack_BAT1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<22.225000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_BAT1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<22.225000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_BAT1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<37.465000,0,19.050000> texture{col_thl}}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<10.530000,0.000000,21.844000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<12.330000,0.000000,21.844000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<12.330000,0.000000,13.716000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<10.530000,0.000000,13.716000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<20.690000,0.000000,11.430000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<22.490000,0.000000,11.430000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<12.330000,0.000000,10.668000>}
object{TOOLS_PCB_SMD(0.800000,1.200000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<10.530000,0.000000,10.668000>}
#ifndef(global_pack_J1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.117600,1,16,4+global_tmp,100) rotate<0,-0.000000,0>translate<16.256000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_J1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.117600,1,16,4+global_tmp,100) rotate<0,-180.000000,0>translate<13.716000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_J1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.117600,1,16,4+global_tmp,100) rotate<0,-0.000000,0>translate<16.256000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_J1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.117600,1,16,4+global_tmp,100) rotate<0,-180.000000,0>translate<13.716000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_J1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.117600,1,16,4+global_tmp,100) rotate<0,-0.000000,0>translate<16.256000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_J1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.879600,1.117600,1,16,4+global_tmp,100) rotate<0,-180.000000,0>translate<13.716000,0,31.750000> texture{col_thl}}
object{TOOLS_PCB_SMD(7.500000,1.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<2.340000,0.000000,14.280000>}
object{TOOLS_PCB_SMD(7.500000,1.500000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<2.340000,0.000000,21.280000>}
object{TOOLS_PCB_SMD(6.500000,1.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<2.840000,0.000000,16.780000>}
object{TOOLS_PCB_SMD(6.500000,1.000000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<2.840000,0.000000,18.780000>}
object{TOOLS_PCB_SMD(2.540000,5.080000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<67.310000,0.000000,27.940000>}
object{TOOLS_PCB_SMD(2.540000,5.080000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<67.310000,0.000000,5.080000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<47.310000,0.000000,12.700000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<49.210000,0.000000,12.700000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<49.210000,0.000000,22.860000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<47.310000,0.000000,22.860000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<53.086000,0.000000,16.449000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<53.086000,0.000000,18.349000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<12.380000,0.000000,16.510000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<10.480000,0.000000,16.510000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<12.380000,0.000000,19.050000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-180.000000,0> texture{col_pds} translate<10.480000,0.000000,19.050000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<15.560000,0.000000,24.130000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<17.460000,0.000000,24.130000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<11.242000,0.000000,24.130000>}
object{TOOLS_PCB_SMD(1.300000,1.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<13.142000,0.000000,24.130000>}
#ifndef(global_pack_T1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<46.990000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_T1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<45.085000,0,17.780000> texture{col_thl}}
#ifndef(global_pack_T1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<46.990000,0,16.510000> texture{col_thl}}
object{TOOLS_PCB_SMD(0.609600,2.209800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<57.073800,0.000000,15.875000>}
object{TOOLS_PCB_SMD(0.609600,2.209800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<62.306200,0.000000,15.875000>}
object{TOOLS_PCB_SMD(0.609600,2.209800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<57.073800,0.000000,19.685000>}
object{TOOLS_PCB_SMD(0.609600,2.209800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<57.073800,0.000000,18.415000>}
object{TOOLS_PCB_SMD(0.609600,2.209800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<62.306200,0.000000,19.685000>}
object{TOOLS_PCB_SMD(0.609600,2.209800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<62.306200,0.000000,18.415000>}
object{TOOLS_PCB_SMD(0.609600,2.209800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<62.306200,0.000000,17.145000>}
object{TOOLS_PCB_SMD(0.609600,2.209800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<57.073800,0.000000,17.145000>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<16.027400,0.000000,15.316200>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<16.535400,0.000000,15.316200>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<17.018000,0.000000,15.316200>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<17.526000,0.000000,15.316200>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<18.034000,0.000000,15.316200>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<18.542000,0.000000,15.316200>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<19.024600,0.000000,15.316200>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<19.532600,0.000000,15.316200>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<20.243800,0.000000,16.027400>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<20.243800,0.000000,16.535400>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<20.243800,0.000000,17.018000>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<20.243800,0.000000,17.526000>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<20.243800,0.000000,18.034000>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<20.243800,0.000000,18.542000>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<20.243800,0.000000,19.024600>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<20.243800,0.000000,19.532600>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<19.532600,0.000000,20.243800>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<19.024600,0.000000,20.243800>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<18.542000,0.000000,20.243800>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<18.034000,0.000000,20.243800>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<17.526000,0.000000,20.243800>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<17.018000,0.000000,20.243800>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<16.535400,0.000000,20.243800>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<16.027400,0.000000,20.243800>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<15.316200,0.000000,19.532600>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<15.316200,0.000000,19.024600>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<15.316200,0.000000,18.542000>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<15.316200,0.000000,18.034000>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<15.316200,0.000000,17.526000>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<15.316200,0.000000,17.018000>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<15.316200,0.000000,16.535400>}
object{TOOLS_PCB_SMD(0.304800,0.812800,0.037000,0) rotate<0,-270.000000,0> texture{col_pds} translate<15.316200,0.000000,16.027400>}
object{TOOLS_PCB_SMD(3.251200,3.251200,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<17.780000,0.000000,17.780000>}
object{TOOLS_PCB_SMD(1.900000,1.100000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<14.660000,0.000000,10.534000>}
object{TOOLS_PCB_SMD(1.900000,1.100000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<18.360000,0.000000,10.534000>}
object{TOOLS_PCB_SMD(1.900000,1.100000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<18.360000,0.000000,12.834000>}
object{TOOLS_PCB_SMD(1.900000,1.100000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<14.660000,0.000000,12.834000>}
//Pads/Vias
#end
#if(pcb_wires=on)
union{
//Signals
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.340000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.340000,0.000000,14.280000>}
box{<0,0,-0.127000><0.452000,0.035000,0.127000> rotate<0,-90.000000,0> translate<2.340000,0.000000,14.280000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.340000,0.000000,21.280000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.642000,0.000000,21.336000>}
box{<0,0,-0.127000><3.302475,0.035000,0.127000> rotate<0,-0.971546,0> translate<2.340000,0.000000,21.280000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<5.642000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.912000,0.000000,20.066000>}
box{<0,0,-0.127000><1.796051,0.035000,0.127000> rotate<0,44.997030,0> translate<5.642000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.398000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.398000,0.000000,20.574000>}
box{<0,0,-0.127000><12.700000,0.035000,0.127000> rotate<0,-90.000000,0> translate<9.398000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.652000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.652000,0.000000,9.398000>}
box{<0,0,-0.127000><4.318000,0.035000,0.127000> rotate<0,-90.000000,0> translate<9.652000,0.000000,9.398000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,30.480000>}
box{<0,0,-0.127000><8.636000,0.035000,0.127000> rotate<0,90.000000,0> translate<10.160000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,30.480000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,-90.000000,0> translate<10.160000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.480000,0.000000,16.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.480000,0.000000,16.510000>}
box{<0,0,-0.203200><0.270000,0.035000,0.203200> rotate<0,-90.000000,0> translate<10.480000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.840000,0.000000,16.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.480000,0.000000,16.780000>}
box{<0,0,-0.203200><7.640000,0.035000,0.203200> rotate<0,0.000000,0> translate<2.840000,0.000000,16.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<2.840000,0.000000,18.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.480000,0.000000,18.780000>}
box{<0,0,-0.203200><7.640000,0.035000,0.203200> rotate<0,0.000000,0> translate<2.840000,0.000000,18.780000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.480000,0.000000,18.780000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<10.480000,0.000000,19.050000>}
box{<0,0,-0.203200><0.270000,0.035000,0.203200> rotate<0,90.000000,0> translate<10.480000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.652000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.530000,0.000000,13.716000>}
box{<0,0,-0.127000><0.878000,0.035000,0.127000> rotate<0,0.000000,0> translate<9.652000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.530000,0.000000,10.668000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.530000,0.000000,13.716000>}
box{<0,0,-0.127000><3.048000,0.035000,0.127000> rotate<0,90.000000,0> translate<10.530000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.530000,0.000000,21.844000>}
box{<0,0,-0.127000><0.370000,0.035000,0.127000> rotate<0,0.000000,0> translate<10.160000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.176000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.176000,0.000000,24.384000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,90.000000,0> translate<11.176000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.176000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.242000,0.000000,24.130000>}
box{<0,0,-0.127000><0.066000,0.035000,0.127000> rotate<0,0.000000,0> translate<11.176000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,15.240000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,-90.000000,0> translate<11.430000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.398000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,20.574000>}
box{<0,0,-0.127000><2.032000,0.035000,0.127000> rotate<0,0.000000,0> translate<9.398000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,22.860000>}
box{<0,0,-0.127000><2.286000,0.035000,0.127000> rotate<0,90.000000,0> translate<11.430000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.330000,0.000000,10.534000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.330000,0.000000,10.668000>}
box{<0,0,-0.127000><0.134000,0.035000,0.127000> rotate<0,90.000000,0> translate<12.330000,0.000000,10.668000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.380000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.380000,0.000000,16.510000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,-90.000000,0> translate<12.380000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.380000,0.000000,19.050000>}
box{<0,0,-0.127000><0.950000,0.035000,0.127000> rotate<0,0.000000,0> translate<11.430000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.142000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.142000,0.000000,24.130000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,-90.000000,0> translate<13.142000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.330000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.208000,0.000000,13.716000>}
box{<0,0,-0.127000><0.878000,0.035000,0.127000> rotate<0,0.000000,0> translate<12.330000,0.000000,13.716000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.208000,0.000000,13.716000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.208000,0.000000,13.970000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,90.000000,0> translate<13.208000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<6.912000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.462000,0.000000,20.066000>}
box{<0,0,-0.127000><6.550000,0.035000,0.127000> rotate<0,0.000000,0> translate<6.912000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.462000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.462000,0.000000,20.066000>}
box{<0,0,-0.127000><2.032000,0.035000,0.127000> rotate<0,90.000000,0> translate<13.462000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.716000,0.000000,15.240000>}
box{<0,0,-0.127000><2.286000,0.035000,0.127000> rotate<0,0.000000,0> translate<11.430000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.716000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.716000,0.000000,17.018000>}
box{<0,0,-0.127000><1.778000,0.035000,0.127000> rotate<0,90.000000,0> translate<13.716000,0.000000,17.018000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.142000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.716000,0.000000,26.670000>}
box{<0,0,-0.127000><0.574000,0.035000,0.127000> rotate<0,0.000000,0> translate<13.142000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.716000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.716000,0.000000,29.210000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,90.000000,0> translate<13.716000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.716000,0.000000,31.750000>}
box{<0,0,-0.127000><3.556000,0.035000,0.127000> rotate<0,0.000000,0> translate<10.160000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.330000,0.000000,21.844000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,0.000000,21.844000>}
box{<0,0,-0.127000><1.640000,0.035000,0.127000> rotate<0,0.000000,0> translate<12.330000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,0.000000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,0.000000,21.844000>}
box{<0,0,-0.127000><3.302000,0.035000,0.127000> rotate<0,90.000000,0> translate<13.970000,0.000000,21.844000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<2.340000,0.000000,14.732000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.224000,0.000000,14.732000>}
box{<0,0,-0.127000><11.884000,0.035000,0.127000> rotate<0,0.000000,0> translate<2.340000,0.000000,14.732000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.224000,0.000000,16.535400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.224000,0.000000,14.732000>}
box{<0,0,-0.127000><1.803400,0.035000,0.127000> rotate<0,-90.000000,0> translate<14.224000,0.000000,14.732000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.330000,0.000000,10.534000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.660000,0.000000,10.534000>}
box{<0,0,-0.127000><2.330000,0.035000,0.127000> rotate<0,0.000000,0> translate<12.330000,0.000000,10.534000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.208000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.316200,0.000000,13.970000>}
box{<0,0,-0.127000><2.108200,0.035000,0.127000> rotate<0,0.000000,0> translate<13.208000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.316200,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.316200,0.000000,16.027400>}
box{<0,0,-0.127000><2.057400,0.035000,0.127000> rotate<0,90.000000,0> translate<15.316200,0.000000,16.027400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.224000,0.000000,16.535400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.316200,0.000000,16.535400>}
box{<0,0,-0.127000><1.092200,0.035000,0.127000> rotate<0,0.000000,0> translate<14.224000,0.000000,16.535400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.716000,0.000000,17.018000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.316200,0.000000,17.018000>}
box{<0,0,-0.127000><1.600200,0.035000,0.127000> rotate<0,0.000000,0> translate<13.716000,0.000000,17.018000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<12.380000,0.000000,17.526000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.316200,0.000000,17.526000>}
box{<0,0,-0.127000><2.936200,0.035000,0.127000> rotate<0,0.000000,0> translate<12.380000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.462000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.316200,0.000000,18.034000>}
box{<0,0,-0.127000><1.854200,0.035000,0.127000> rotate<0,0.000000,0> translate<13.462000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.970000,0.000000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.316200,0.000000,18.542000>}
box{<0,0,-0.127000><1.346200,0.035000,0.127000> rotate<0,0.000000,0> translate<13.970000,0.000000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.142000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<15.560000,0.000000,24.130000>}
box{<0,0,-0.127000><2.418000,0.035000,0.127000> rotate<0,0.000000,0> translate<13.142000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<14.660000,0.000000,10.534000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.027400,0.000000,10.534000>}
box{<0,0,-0.127000><1.367400,0.035000,0.127000> rotate<0,0.000000,0> translate<14.660000,0.000000,10.534000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.027400,0.000000,10.534000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.027400,0.000000,15.316200>}
box{<0,0,-0.127000><4.782200,0.035000,0.127000> rotate<0,90.000000,0> translate<16.027400,0.000000,15.316200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.027400,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.027400,0.000000,20.243800>}
box{<0,0,-0.127000><2.616200,0.035000,0.127000> rotate<0,-90.000000,0> translate<16.027400,0.000000,20.243800> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<11.430000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.027400,0.000000,22.860000>}
box{<0,0,-0.127000><4.597400,0.035000,0.127000> rotate<0,0.000000,0> translate<11.430000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.398000,0.000000,33.274000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.256000,0.000000,33.274000>}
box{<0,0,-0.127000><6.858000,0.035000,0.127000> rotate<0,0.000000,0> translate<9.398000,0.000000,33.274000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.256000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.256000,0.000000,33.274000>}
box{<0,0,-0.127000><1.524000,0.035000,0.127000> rotate<0,90.000000,0> translate<16.256000,0.000000,33.274000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.535400,0.000000,12.834000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.535400,0.000000,15.316200>}
box{<0,0,-0.127000><2.482200,0.035000,0.127000> rotate<0,90.000000,0> translate<16.535400,0.000000,15.316200> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.018000,0.000000,15.316200>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.018000,0.000000,14.478000>}
box{<0,0,-0.127000><0.838200,0.035000,0.127000> rotate<0,-90.000000,0> translate<17.018000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.027400,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.526000,0.000000,22.860000>}
box{<0,0,-0.127000><1.498600,0.035000,0.127000> rotate<0,0.000000,0> translate<16.027400,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.526000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.526000,0.000000,22.860000>}
box{<0,0,-0.127000><1.270000,0.035000,0.127000> rotate<0,-90.000000,0> translate<17.526000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.460000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.526000,0.000000,24.130000>}
box{<0,0,-0.127000><0.066000,0.035000,0.127000> rotate<0,0.000000,0> translate<17.460000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.535400,0.000000,12.834000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.360000,0.000000,12.834000>}
box{<0,0,-0.127000><1.824600,0.035000,0.127000> rotate<0,0.000000,0> translate<16.535400,0.000000,12.834000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.360000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.360000,0.000000,12.834000>}
box{<0,0,-0.127000><1.136000,0.035000,0.127000> rotate<0,-90.000000,0> translate<18.360000,0.000000,12.834000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.532600,0.000000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.532600,0.000000,20.243800>}
box{<0,0,-0.127000><6.426200,0.035000,0.127000> rotate<0,-90.000000,0> translate<19.532600,0.000000,20.243800> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.256000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.532600,0.000000,26.670000>}
box{<0,0,-0.127000><3.276600,0.035000,0.127000> rotate<0,0.000000,0> translate<16.256000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<18.360000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.812000,0.000000,13.970000>}
box{<0,0,-0.127000><1.452000,0.035000,0.127000> rotate<0,0.000000,0> translate<18.360000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.812000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.812000,0.000000,13.970000>}
box{<0,0,-0.127000><2.540000,0.035000,0.127000> rotate<0,90.000000,0> translate<19.812000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<13.716000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.066000,0.000000,27.940000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,0.000000,0> translate<13.716000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.066000,0.000000,19.532600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.066000,0.000000,27.940000>}
box{<0,0,-0.127000><8.407400,0.035000,0.127000> rotate<0,90.000000,0> translate<20.066000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.243800,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.243800,0.000000,19.024600>}
box{<0,0,-0.127000><0.025400,0.035000,0.127000> rotate<0,-90.000000,0> translate<20.243800,0.000000,19.024600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.066000,0.000000,19.532600>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.243800,0.000000,19.532600>}
box{<0,0,-0.127000><0.177800,0.035000,0.127000> rotate<0,0.000000,0> translate<20.066000,0.000000,19.532600> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,0.000000,12.446000>}
box{<0,0,-0.127000><2.032000,0.035000,0.127000> rotate<0,-90.000000,0> translate<20.320000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<17.018000,0.000000,14.478000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,0.000000,14.478000>}
box{<0,0,-0.127000><3.302000,0.035000,0.127000> rotate<0,0.000000,0> translate<17.018000,0.000000,14.478000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<19.812000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.690000,0.000000,11.430000>}
box{<0,0,-0.127000><0.878000,0.035000,0.127000> rotate<0,0.000000,0> translate<19.812000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<9.652000,0.000000,9.398000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.490000,0.000000,9.398000>}
box{<0,0,-0.127000><12.838000,0.035000,0.127000> rotate<0,0.000000,0> translate<9.652000,0.000000,9.398000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.490000,0.000000,9.398000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.490000,0.000000,11.430000>}
box{<0,0,-0.127000><2.032000,0.035000,0.127000> rotate<0,90.000000,0> translate<22.490000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.490000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.490000,0.000000,11.430000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,-90.000000,0> translate<22.490000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.320000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<22.490000,0.000000,12.446000>}
box{<0,0,-0.127000><2.170000,0.035000,0.127000> rotate<0,0.000000,0> translate<20.320000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.243800,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.146000,0.000000,19.050000>}
box{<0,0,-0.127000><4.902200,0.035000,0.127000> rotate<0,0.000000,0> translate<20.243800,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.146000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.146000,0.000000,19.050000>}
box{<0,0,-0.127000><10.160000,0.035000,0.127000> rotate<0,-90.000000,0> translate<25.146000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<16.256000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<25.146000,0.000000,29.210000>}
box{<0,0,-0.127000><8.890000,0.035000,0.127000> rotate<0,0.000000,0> translate<16.256000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.243800,0.000000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.162000,0.000000,18.034000>}
box{<0,0,-0.127000><5.918200,0.035000,0.127000> rotate<0,0.000000,0> translate<20.243800,0.000000,18.034000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.162000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.162000,0.000000,26.416000>}
box{<0,0,-0.127000><8.382000,0.035000,0.127000> rotate<0,90.000000,0> translate<26.162000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.243800,0.000000,17.526000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,0.000000,17.526000>}
box{<0,0,-0.127000><6.426200,0.035000,0.127000> rotate<0,0.000000,0> translate<20.243800,0.000000,17.526000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,0.000000,25.908000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,0.000000,17.526000>}
box{<0,0,-0.127000><8.382000,0.035000,0.127000> rotate<0,-90.000000,0> translate<26.670000,0.000000,17.526000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.243800,0.000000,16.535400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.544000,0.000000,16.535400>}
box{<0,0,-0.127000><14.300200,0.035000,0.127000> rotate<0,0.000000,0> translate<20.243800,0.000000,16.535400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.544000,0.000000,16.535400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.544000,0.000000,21.082000>}
box{<0,0,-0.127000><4.546600,0.035000,0.127000> rotate<0,90.000000,0> translate<34.544000,0.000000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<20.243800,0.000000,16.027400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.052000,0.000000,16.027400>}
box{<0,0,-0.127000><14.808200,0.035000,0.127000> rotate<0,0.000000,0> translate<20.243800,0.000000,16.027400> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.052000,0.000000,16.027400>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.052000,0.000000,20.574000>}
box{<0,0,-0.127000><4.546600,0.035000,0.127000> rotate<0,90.000000,0> translate<35.052000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<22.490000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<37.465000,0.000000,12.446000>}
box{<0,0,-0.508000><14.975000,0.035000,0.508000> rotate<0,0.000000,0> translate<22.490000,0.000000,12.446000> }
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<37.465000,0.000000,12.446000>}
cylinder{<0,0,0><0,0.035000,0>0.508000 translate<37.465000,0.000000,19.050000>}
box{<0,0,-0.508000><6.604000,0.035000,0.508000> rotate<0,90.000000,0> translate<37.465000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.894000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.894000,0.000000,16.256000>}
box{<0,0,-0.127000><4.318000,0.035000,0.127000> rotate<0,-90.000000,0> translate<40.894000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<35.052000,0.000000,20.574000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.894000,0.000000,20.574000>}
box{<0,0,-0.127000><5.842000,0.035000,0.127000> rotate<0,0.000000,0> translate<35.052000,0.000000,20.574000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.085000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.085000,0.000000,17.780000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,-90.000000,0> translate<45.085000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<40.894000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,0.000000,16.256000>}
box{<0,0,-0.127000><6.096000,0.035000,0.127000> rotate<0,0.000000,0> translate<40.894000,0.000000,16.256000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,0.000000,16.510000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,90.000000,0> translate<46.990000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,0.000000,16.256000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,0.000000,16.510000>}
box{<0,0,-0.127000><0.254000,0.035000,0.127000> rotate<0,90.000000,0> translate<46.990000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,0.000000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,0.000000,19.050000>}
box{<0,0,-0.127000><2.032000,0.035000,0.127000> rotate<0,-90.000000,0> translate<46.990000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,0.000000,20.066000>}
box{<0,0,-0.127000><1.016000,0.035000,0.127000> rotate<0,90.000000,0> translate<46.990000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<34.544000,0.000000,21.082000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,0.000000,21.082000>}
box{<0,0,-0.127000><12.446000,0.035000,0.127000> rotate<0,0.000000,0> translate<34.544000,0.000000,21.082000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.310000,0.000000,12.700000>}
box{<0,0,-0.127000><0.320000,0.035000,0.127000> rotate<0,0.000000,0> translate<46.990000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<46.990000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.310000,0.000000,20.066000>}
box{<0,0,-0.127000><0.320000,0.035000,0.127000> rotate<0,0.000000,0> translate<46.990000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.310000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<47.310000,0.000000,22.860000>}
box{<0,0,-0.127000><2.794000,0.035000,0.127000> rotate<0,90.000000,0> translate<47.310000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<45.085000,0.000000,18.034000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.006000,0.000000,18.034000>}
box{<0,0,-0.127000><2.921000,0.035000,0.127000> rotate<0,0.000000,0> translate<45.085000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.006000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.006000,0.000000,18.034000>}
box{<0,0,-0.127000><3.810000,0.035000,0.127000> rotate<0,90.000000,0> translate<48.006000,0.000000,18.034000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.670000,0.000000,25.908000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,0.000000,25.908000>}
box{<0,0,-0.127000><21.590000,0.035000,0.127000> rotate<0,0.000000,0> translate<26.670000,0.000000,25.908000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,0.000000,25.908000>}
box{<0,0,-0.127000><5.842000,0.035000,0.127000> rotate<0,90.000000,0> translate<48.260000,0.000000,25.908000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.260000,0.000000,20.066000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.038000,0.000000,18.288000>}
box{<0,0,-0.127000><2.514472,0.035000,0.127000> rotate<0,44.997030,0> translate<48.260000,0.000000,20.066000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.038000,0.000000,16.449000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.038000,0.000000,18.288000>}
box{<0,0,-0.127000><1.839000,0.035000,0.127000> rotate<0,90.000000,0> translate<50.038000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<50.038000,0.000000,16.449000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.086000,0.000000,16.449000>}
box{<0,0,-0.127000><3.048000,0.035000,0.127000> rotate<0,0.000000,0> translate<50.038000,0.000000,16.449000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.086000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.086000,0.000000,16.449000>}
box{<0,0,-0.127000><0.574000,0.035000,0.127000> rotate<0,90.000000,0> translate<53.086000,0.000000,16.449000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.086000,0.000000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.086000,0.000000,18.349000>}
box{<0,0,-0.127000><0.193000,0.035000,0.127000> rotate<0,-90.000000,0> translate<53.086000,0.000000,18.349000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.086000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.086000,0.000000,23.368000>}
box{<0,0,-0.127000><3.048000,0.035000,0.127000> rotate<0,-90.000000,0> translate<53.086000,0.000000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<26.162000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.086000,0.000000,26.416000>}
box{<0,0,-0.127000><26.924000,0.035000,0.127000> rotate<0,0.000000,0> translate<26.162000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.102000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.102000,0.000000,24.130000>}
box{<0,0,-0.127000><6.350000,0.035000,0.127000> rotate<0,-90.000000,0> translate<54.102000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<10.160000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.102000,0.000000,30.480000>}
box{<0,0,-0.127000><43.942000,0.035000,0.127000> rotate<0,0.000000,0> translate<10.160000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.086000,0.000000,18.542000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,0.000000,18.542000>}
box{<0,0,-0.127000><1.524000,0.035000,0.127000> rotate<0,0.000000,0> translate<53.086000,0.000000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,0.000000,18.542000>}
box{<0,0,-0.127000><1.397000,0.035000,0.127000> rotate<0,90.000000,0> translate<54.610000,0.000000,18.542000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.086000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.073800,0.000000,15.875000>}
box{<0,0,-0.127000><3.987800,0.035000,0.127000> rotate<0,0.000000,0> translate<53.086000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<54.610000,0.000000,17.145000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.073800,0.000000,17.145000>}
box{<0,0,-0.127000><2.463800,0.035000,0.127000> rotate<0,0.000000,0> translate<54.610000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.073800,0.000000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.073800,0.000000,17.145000>}
box{<0,0,-0.127000><0.127000,0.035000,0.127000> rotate<0,-90.000000,0> translate<57.073800,0.000000,17.145000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<57.073800,0.000000,17.272000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.436000,0.000000,17.272000>}
box{<0,0,-0.127000><2.362200,0.035000,0.127000> rotate<0,0.000000,0> translate<57.073800,0.000000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.436000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.436000,0.000000,17.272000>}
box{<0,0,-0.127000><2.286000,0.035000,0.127000> rotate<0,90.000000,0> translate<59.436000,0.000000,17.272000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.198000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.198000,0.000000,15.748000>}
box{<0,0,-0.127000><7.112000,0.035000,0.127000> rotate<0,-90.000000,0> translate<60.198000,0.000000,15.748000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<49.210000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.198000,0.000000,22.860000>}
box{<0,0,-0.127000><10.988000,0.035000,0.127000> rotate<0,0.000000,0> translate<49.210000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<60.198000,0.000000,15.748000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.306200,0.000000,15.748000>}
box{<0,0,-0.127000><2.108200,0.035000,0.127000> rotate<0,0.000000,0> translate<60.198000,0.000000,15.748000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.306200,0.000000,15.748000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<62.306200,0.000000,15.875000>}
box{<0,0,-0.127000><0.127000,0.035000,0.127000> rotate<0,90.000000,0> translate<62.306200,0.000000,15.875000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<59.436000,0.000000,14.986000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.294000,0.000000,14.986000>}
box{<0,0,-0.127000><6.858000,0.035000,0.127000> rotate<0,0.000000,0> translate<59.436000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.294000,0.000000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.294000,0.000000,14.986000>}
box{<0,0,-0.127000><8.382000,0.035000,0.127000> rotate<0,-90.000000,0> translate<66.294000,0.000000,14.986000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<53.086000,0.000000,23.368000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<66.294000,0.000000,23.368000>}
box{<0,0,-0.127000><13.208000,0.035000,0.127000> rotate<0,0.000000,0> translate<53.086000,0.000000,23.368000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.310000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.310000,0.000000,5.080000>}
box{<0,0,-0.127000><7.620000,0.035000,0.127000> rotate<0,-90.000000,0> translate<67.310000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<49.210000,0.000000,12.700000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.310000,0.000000,12.700000>}
box{<0,0,-0.127000><18.100000,0.035000,0.127000> rotate<0,0.000000,0> translate<49.210000,0.000000,12.700000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<48.006000,0.000000,14.224000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.310000,0.000000,14.224000>}
box{<0,0,-0.127000><19.304000,0.035000,0.127000> rotate<0,0.000000,0> translate<48.006000,0.000000,14.224000> }
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.310000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.127000 translate<67.310000,0.000000,14.224000>}
box{<0,0,-0.127000><13.716000,0.035000,0.127000> rotate<0,-90.000000,0> translate<67.310000,0.000000,14.224000> }
//Text
//Rect
union{
texture{col_pds}
}
texture{col_wrs}
}
#end
#if(pcb_polygons=on)
union{
//Polygons
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,1.422397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,10.160000>}
box{<0,0,-0.203200><8.737603,0.035000,0.203200> rotate<0,90.000000,0> translate<54.610000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,1.422397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<96.544472,0.000000,1.422397>}
box{<0,0,-0.203200><41.934472,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,1.422397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,1.625600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<96.115484,0.000000,1.625600>}
box{<0,0,-0.203200><41.505484,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,1.625600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,2.032000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<95.257531,0.000000,2.032000>}
box{<0,0,-0.203200><40.647531,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,2.032000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,2.438400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<94.399575,0.000000,2.438400>}
box{<0,0,-0.203200><39.789575,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,2.438400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,2.844800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<93.541619,0.000000,2.844800>}
box{<0,0,-0.203200><38.931619,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,2.844800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,3.251200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<92.683663,0.000000,3.251200>}
box{<0,0,-0.203200><38.073663,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,3.251200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.337503,0.000000,3.657600>}
box{<0,0,-0.203200><9.727503,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,4.064000>}
box{<0,0,-0.203200><9.702800,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,4.470400>}
box{<0,0,-0.203200><9.702800,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,4.876800>}
box{<0,0,-0.203200><9.702800,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,5.283200>}
box{<0,0,-0.203200><9.702800,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,5.689600>}
box{<0,0,-0.203200><9.702800,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,6.096000>}
box{<0,0,-0.203200><9.702800,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.337509,0.000000,6.502400>}
box{<0,0,-0.203200><9.727509,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,6.908800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<84.962063,0.000000,6.908800>}
box{<0,0,-0.203200><30.352063,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,6.908800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,7.315200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<84.104106,0.000000,7.315200>}
box{<0,0,-0.203200><29.494106,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,7.315200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,7.721600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<83.246150,0.000000,7.721600>}
box{<0,0,-0.203200><28.636150,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,7.721600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,8.128000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<82.388194,0.000000,8.128000>}
box{<0,0,-0.203200><27.778194,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,8.128000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,8.534400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<81.530237,0.000000,8.534400>}
box{<0,0,-0.203200><26.920237,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,8.534400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,8.940800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<80.672281,0.000000,8.940800>}
box{<0,0,-0.203200><26.062281,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,8.940800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,9.347200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<79.814325,0.000000,9.347200>}
box{<0,0,-0.203200><25.204325,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,9.347200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,9.753600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<78.956372,0.000000,9.753600>}
box{<0,0,-0.203200><24.346372,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,9.753600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<54.610000,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.929147,0.000000,10.160000>}
box{<0,0,-0.203200><13.319147,0.035000,0.203200> rotate<0,0.000000,0> translate<54.610000,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,32.867600>}
box{<0,0,-0.203200><8.737600,0.035000,0.203200> rotate<0,90.000000,0> translate<55.880000,0.000000,32.867600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.929147,0.000000,24.130000>}
box{<0,0,-0.203200><12.049147,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<79.877422,0.000000,24.384000>}
box{<0,0,-0.203200><23.997422,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,24.790400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<80.690222,0.000000,24.790400>}
box{<0,0,-0.203200><24.810222,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,24.790400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,25.196800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<81.503022,0.000000,25.196800>}
box{<0,0,-0.203200><25.623022,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,25.196800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<82.315822,0.000000,25.603200>}
box{<0,0,-0.203200><26.435822,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,26.009600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<83.128622,0.000000,26.009600>}
box{<0,0,-0.203200><27.248622,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,26.009600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.388712,0.000000,26.416000>}
box{<0,0,-0.203200><8.508712,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,26.822400>}
box{<0,0,-0.203200><8.432800,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,27.228800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,27.228800>}
box{<0,0,-0.203200><8.432800,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,27.228800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,27.635200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,27.635200>}
box{<0,0,-0.203200><8.432800,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,27.635200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106788,0.000000,28.041600>}
box{<0,0,-0.203200><11.226788,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,28.448000>}
box{<0,0,-0.203200><8.432800,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,28.448000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,28.854400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,28.854400>}
box{<0,0,-0.203200><8.432800,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,28.854400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,29.260800>}
box{<0,0,-0.203200><8.432800,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,29.667200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<90.443825,0.000000,29.667200>}
box{<0,0,-0.203200><34.563825,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,29.667200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,30.073600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<91.256625,0.000000,30.073600>}
box{<0,0,-0.203200><35.376625,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,30.073600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<92.069425,0.000000,30.480000>}
box{<0,0,-0.203200><36.189425,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,30.886400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<92.882225,0.000000,30.886400>}
box{<0,0,-0.203200><37.002225,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,30.886400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,31.292800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<93.695025,0.000000,31.292800>}
box{<0,0,-0.203200><37.815025,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,31.292800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<94.507825,0.000000,31.699200>}
box{<0,0,-0.203200><38.627825,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,31.699200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,32.105600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<95.320625,0.000000,32.105600>}
box{<0,0,-0.203200><39.440625,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,32.105600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,32.512000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<96.133425,0.000000,32.512000>}
box{<0,0,-0.203200><40.253425,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,32.512000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<55.880000,0.000000,32.867600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<96.844625,0.000000,32.867600>}
box{<0,0,-0.203200><40.964625,0.035000,0.203200> rotate<0,0.000000,0> translate<55.880000,0.000000,32.867600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,3.749806>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.343956,0.000000,3.633525>}
box{<0,0,-0.203200><0.120383,0.035000,0.203200> rotate<0,74.995610,0> translate<64.312800,0.000000,3.749806> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,4.876803>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,3.749806>}
box{<0,0,-0.203200><1.126997,0.035000,0.203200> rotate<0,-90.000000,0> translate<64.312800,0.000000,3.749806> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,4.876803>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106788,0.000000,4.876803>}
box{<0,0,-0.203200><2.793988,0.035000,0.203200> rotate<0,0.000000,0> translate<64.312800,0.000000,4.876803> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,5.283191>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106788,0.000000,5.283191>}
box{<0,0,-0.203200><2.793988,0.035000,0.203200> rotate<0,0.000000,0> translate<64.312800,0.000000,5.283191> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,6.410191>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,5.283191>}
box{<0,0,-0.203200><1.127000,0.035000,0.203200> rotate<0,-90.000000,0> translate<64.312800,0.000000,5.283191> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,6.410191>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.343956,0.000000,6.526472>}
box{<0,0,-0.203200><0.120383,0.035000,0.203200> rotate<0,-74.995610,0> translate<64.312800,0.000000,6.410191> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,26.609806>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.343956,0.000000,26.493525>}
box{<0,0,-0.203200><0.120383,0.035000,0.203200> rotate<0,74.995610,0> translate<64.312800,0.000000,26.609806> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,27.736803>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,26.609806>}
box{<0,0,-0.203200><1.126997,0.035000,0.203200> rotate<0,-90.000000,0> translate<64.312800,0.000000,26.609806> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,27.736803>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106788,0.000000,27.736803>}
box{<0,0,-0.203200><2.793988,0.035000,0.203200> rotate<0,0.000000,0> translate<64.312800,0.000000,27.736803> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,28.143191>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106788,0.000000,28.143191>}
box{<0,0,-0.203200><2.793988,0.035000,0.203200> rotate<0,0.000000,0> translate<64.312800,0.000000,28.143191> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,29.270191>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,28.143191>}
box{<0,0,-0.203200><1.127000,0.035000,0.203200> rotate<0,-90.000000,0> translate<64.312800,0.000000,28.143191> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.312800,0.000000,29.270191>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.343956,0.000000,29.386472>}
box{<0,0,-0.203200><0.120383,0.035000,0.203200> rotate<0,-74.995610,0> translate<64.312800,0.000000,29.270191> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.343956,0.000000,3.633525>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.404147,0.000000,3.529272>}
box{<0,0,-0.203200><0.120381,0.035000,0.203200> rotate<0,59.996017,0> translate<64.343956,0.000000,3.633525> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.343956,0.000000,6.526472>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.404147,0.000000,6.630725>}
box{<0,0,-0.203200><0.120381,0.035000,0.203200> rotate<0,-59.996017,0> translate<64.343956,0.000000,6.526472> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.343956,0.000000,26.493525>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.404147,0.000000,26.389272>}
box{<0,0,-0.203200><0.120381,0.035000,0.203200> rotate<0,59.996017,0> translate<64.343956,0.000000,26.493525> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.343956,0.000000,29.386472>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.404147,0.000000,29.490725>}
box{<0,0,-0.203200><0.120381,0.035000,0.203200> rotate<0,-59.996017,0> translate<64.343956,0.000000,29.386472> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.404147,0.000000,3.529272>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.489272,0.000000,3.444147>}
box{<0,0,-0.203200><0.120385,0.035000,0.203200> rotate<0,44.997030,0> translate<64.404147,0.000000,3.529272> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.404147,0.000000,6.630725>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.489272,0.000000,6.715850>}
box{<0,0,-0.203200><0.120385,0.035000,0.203200> rotate<0,-44.997030,0> translate<64.404147,0.000000,6.630725> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.404147,0.000000,26.389272>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.489272,0.000000,26.304147>}
box{<0,0,-0.203200><0.120385,0.035000,0.203200> rotate<0,44.997030,0> translate<64.404147,0.000000,26.389272> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.404147,0.000000,29.490725>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.489272,0.000000,29.575850>}
box{<0,0,-0.203200><0.120385,0.035000,0.203200> rotate<0,-44.997030,0> translate<64.404147,0.000000,29.490725> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.489272,0.000000,3.444147>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.593525,0.000000,3.383956>}
box{<0,0,-0.203200><0.120381,0.035000,0.203200> rotate<0,29.998043,0> translate<64.489272,0.000000,3.444147> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.489272,0.000000,6.715850>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.593525,0.000000,6.776041>}
box{<0,0,-0.203200><0.120381,0.035000,0.203200> rotate<0,-29.998043,0> translate<64.489272,0.000000,6.715850> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.489272,0.000000,26.304147>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.593525,0.000000,26.243956>}
box{<0,0,-0.203200><0.120381,0.035000,0.203200> rotate<0,29.998043,0> translate<64.489272,0.000000,26.304147> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.489272,0.000000,29.575850>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.593525,0.000000,29.636041>}
box{<0,0,-0.203200><0.120381,0.035000,0.203200> rotate<0,-29.998043,0> translate<64.489272,0.000000,29.575850> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.593525,0.000000,3.383956>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.709806,0.000000,3.352800>}
box{<0,0,-0.203200><0.120383,0.035000,0.203200> rotate<0,14.998451,0> translate<64.593525,0.000000,3.383956> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.593525,0.000000,6.776041>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.709806,0.000000,6.807197>}
box{<0,0,-0.203200><0.120383,0.035000,0.203200> rotate<0,-14.998451,0> translate<64.593525,0.000000,6.776041> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.593525,0.000000,26.243956>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.709806,0.000000,26.212800>}
box{<0,0,-0.203200><0.120383,0.035000,0.203200> rotate<0,14.998451,0> translate<64.593525,0.000000,26.243956> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.593525,0.000000,29.636041>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.709806,0.000000,29.667197>}
box{<0,0,-0.203200><0.120383,0.035000,0.203200> rotate<0,-14.998451,0> translate<64.593525,0.000000,29.636041> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.709806,0.000000,3.352800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,3.352800>}
box{<0,0,-0.203200><2.396997,0.035000,0.203200> rotate<0,0.000000,0> translate<64.709806,0.000000,3.352800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.709806,0.000000,6.807197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,6.807197>}
box{<0,0,-0.203200><2.396997,0.035000,0.203200> rotate<0,0.000000,0> translate<64.709806,0.000000,6.807197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.709806,0.000000,26.212800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,26.212800>}
box{<0,0,-0.203200><2.396997,0.035000,0.203200> rotate<0,0.000000,0> translate<64.709806,0.000000,26.212800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<64.709806,0.000000,29.667197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,29.667197>}
box{<0,0,-0.203200><2.396997,0.035000,0.203200> rotate<0,0.000000,0> translate<64.709806,0.000000,29.667197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106788,0.000000,5.283191>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106788,0.000000,4.876803>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,-90.000000,0> translate<67.106788,0.000000,4.876803> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106788,0.000000,28.143191>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106788,0.000000,27.736803>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,-90.000000,0> translate<67.106788,0.000000,27.736803> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,3.352800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,4.876787>}
box{<0,0,-0.203200><1.523987,0.035000,0.203200> rotate<0,90.000000,0> translate<67.106803,0.000000,4.876787> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,3.657600>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,0.000000,0> translate<67.106803,0.000000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,4.064000>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,0.000000,0> translate<67.106803,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,4.470400>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,0.000000,0> translate<67.106803,0.000000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,4.876787>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,4.876787>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,0.000000,0> translate<67.106803,0.000000,4.876787> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,5.283209>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,6.807197>}
box{<0,0,-0.203200><1.523988,0.035000,0.203200> rotate<0,90.000000,0> translate<67.106803,0.000000,6.807197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,5.283209>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,5.283209>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,0.000000,0> translate<67.106803,0.000000,5.283209> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,5.689600>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,0.000000,0> translate<67.106803,0.000000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,6.096000>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,0.000000,0> translate<67.106803,0.000000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,6.502400>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,0.000000,0> translate<67.106803,0.000000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,26.212800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,27.736788>}
box{<0,0,-0.203200><1.523988,0.035000,0.203200> rotate<0,90.000000,0> translate<67.106803,0.000000,27.736788> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,26.416000>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,0.000000,0> translate<67.106803,0.000000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,26.822400>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,0.000000,0> translate<67.106803,0.000000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,27.228800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,27.228800>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,0.000000,0> translate<67.106803,0.000000,27.228800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,27.635200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,27.635200>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,0.000000,0> translate<67.106803,0.000000,27.635200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,27.736788>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,27.736788>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,0.000000,0> translate<67.106803,0.000000,27.736788> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,28.143209>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,29.667197>}
box{<0,0,-0.203200><1.523988,0.035000,0.203200> rotate<0,90.000000,0> translate<67.106803,0.000000,29.667197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,28.143209>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,28.143209>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,0.000000,0> translate<67.106803,0.000000,28.143209> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,28.448000>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,0.000000,0> translate<67.106803,0.000000,28.448000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,28.854400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,28.854400>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,0.000000,0> translate<67.106803,0.000000,28.854400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.106803,0.000000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,29.260800>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,0.000000,0> translate<67.106803,0.000000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,3.352800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<69.910191,0.000000,3.352800>}
box{<0,0,-0.203200><2.397000,0.035000,0.203200> rotate<0,0.000000,0> translate<67.513191,0.000000,3.352800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,4.876787>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,3.352800>}
box{<0,0,-0.203200><1.523987,0.035000,0.203200> rotate<0,-90.000000,0> translate<67.513191,0.000000,3.352800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,6.807197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,5.283209>}
box{<0,0,-0.203200><1.523988,0.035000,0.203200> rotate<0,-90.000000,0> translate<67.513191,0.000000,5.283209> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,6.807197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<69.910191,0.000000,6.807197>}
box{<0,0,-0.203200><2.397000,0.035000,0.203200> rotate<0,0.000000,0> translate<67.513191,0.000000,6.807197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,26.212800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<69.910191,0.000000,26.212800>}
box{<0,0,-0.203200><2.397000,0.035000,0.203200> rotate<0,0.000000,0> translate<67.513191,0.000000,26.212800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,27.736788>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,26.212800>}
box{<0,0,-0.203200><1.523988,0.035000,0.203200> rotate<0,-90.000000,0> translate<67.513191,0.000000,26.212800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,29.667197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,28.143209>}
box{<0,0,-0.203200><1.523988,0.035000,0.203200> rotate<0,-90.000000,0> translate<67.513191,0.000000,28.143209> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513191,0.000000,29.667197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<69.910191,0.000000,29.667197>}
box{<0,0,-0.203200><2.397000,0.035000,0.203200> rotate<0,0.000000,0> translate<67.513191,0.000000,29.667197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513209,0.000000,4.876803>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513209,0.000000,5.283191>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,90.000000,0> translate<67.513209,0.000000,5.283191> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513209,0.000000,4.876803>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307194,0.000000,4.876803>}
box{<0,0,-0.203200><2.793984,0.035000,0.203200> rotate<0,0.000000,0> translate<67.513209,0.000000,4.876803> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513209,0.000000,5.283191>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,5.283191>}
box{<0,0,-0.203200><2.793988,0.035000,0.203200> rotate<0,0.000000,0> translate<67.513209,0.000000,5.283191> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513209,0.000000,27.736803>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513209,0.000000,28.143191>}
box{<0,0,-0.203200><0.406388,0.035000,0.203200> rotate<0,90.000000,0> translate<67.513209,0.000000,28.143191> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513209,0.000000,27.736803>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307194,0.000000,27.736803>}
box{<0,0,-0.203200><2.793984,0.035000,0.203200> rotate<0,0.000000,0> translate<67.513209,0.000000,27.736803> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513209,0.000000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<87.192622,0.000000,28.041600>}
box{<0,0,-0.203200><19.679412,0.035000,0.203200> rotate<0,0.000000,0> translate<67.513209,0.000000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.513209,0.000000,28.143191>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,28.143191>}
box{<0,0,-0.203200><2.793988,0.035000,0.203200> rotate<0,0.000000,0> translate<67.513209,0.000000,28.143191> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.929147,0.000000,10.160000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<68.297066,0.000000,10.007600>}
box{<0,0,-0.203200><0.398234,0.035000,0.203200> rotate<0,22.498922,0> translate<67.929147,0.000000,10.160000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<67.929147,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<68.297066,0.000000,24.282397>}
box{<0,0,-0.203200><0.398232,0.035000,0.203200> rotate<0,-22.498507,0> translate<67.929147,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<68.297066,0.000000,10.007600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<78.420150,0.000000,10.007600>}
box{<0,0,-0.203200><10.123084,0.035000,0.203200> rotate<0,0.000000,0> translate<68.297066,0.000000,10.007600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<68.297066,0.000000,24.282397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<79.674213,0.000000,24.282397>}
box{<0,0,-0.203200><11.377147,0.035000,0.203200> rotate<0,0.000000,0> translate<68.297066,0.000000,24.282397> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<69.910191,0.000000,3.352800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.026472,0.000000,3.383956>}
box{<0,0,-0.203200><0.120383,0.035000,0.203200> rotate<0,-14.998451,0> translate<69.910191,0.000000,3.352800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<69.910191,0.000000,6.807197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.026472,0.000000,6.776041>}
box{<0,0,-0.203200><0.120383,0.035000,0.203200> rotate<0,14.998451,0> translate<69.910191,0.000000,6.807197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<69.910191,0.000000,26.212800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.026472,0.000000,26.243956>}
box{<0,0,-0.203200><0.120383,0.035000,0.203200> rotate<0,-14.998451,0> translate<69.910191,0.000000,26.212800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<69.910191,0.000000,29.667197>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.026472,0.000000,29.636041>}
box{<0,0,-0.203200><0.120383,0.035000,0.203200> rotate<0,14.998451,0> translate<69.910191,0.000000,29.667197> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.026472,0.000000,3.383956>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.130725,0.000000,3.444147>}
box{<0,0,-0.203200><0.120381,0.035000,0.203200> rotate<0,-29.998043,0> translate<70.026472,0.000000,3.383956> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.026472,0.000000,6.776041>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.130725,0.000000,6.715850>}
box{<0,0,-0.203200><0.120381,0.035000,0.203200> rotate<0,29.998043,0> translate<70.026472,0.000000,6.776041> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.026472,0.000000,26.243956>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.130725,0.000000,26.304147>}
box{<0,0,-0.203200><0.120381,0.035000,0.203200> rotate<0,-29.998043,0> translate<70.026472,0.000000,26.243956> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.026472,0.000000,29.636041>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.130725,0.000000,29.575850>}
box{<0,0,-0.203200><0.120381,0.035000,0.203200> rotate<0,29.998043,0> translate<70.026472,0.000000,29.636041> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.130725,0.000000,3.444147>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.215850,0.000000,3.529272>}
box{<0,0,-0.203200><0.120385,0.035000,0.203200> rotate<0,-44.997030,0> translate<70.130725,0.000000,3.444147> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.130725,0.000000,6.715850>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.215850,0.000000,6.630725>}
box{<0,0,-0.203200><0.120385,0.035000,0.203200> rotate<0,44.997030,0> translate<70.130725,0.000000,6.715850> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.130725,0.000000,26.304147>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.215850,0.000000,26.389272>}
box{<0,0,-0.203200><0.120385,0.035000,0.203200> rotate<0,-44.997030,0> translate<70.130725,0.000000,26.304147> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.130725,0.000000,29.575850>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.215850,0.000000,29.490725>}
box{<0,0,-0.203200><0.120385,0.035000,0.203200> rotate<0,44.997030,0> translate<70.130725,0.000000,29.575850> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.215850,0.000000,3.529272>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.276041,0.000000,3.633525>}
box{<0,0,-0.203200><0.120381,0.035000,0.203200> rotate<0,-59.996017,0> translate<70.215850,0.000000,3.529272> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.215850,0.000000,6.630725>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.276041,0.000000,6.526472>}
box{<0,0,-0.203200><0.120381,0.035000,0.203200> rotate<0,59.996017,0> translate<70.215850,0.000000,6.630725> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.215850,0.000000,26.389272>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.276041,0.000000,26.493525>}
box{<0,0,-0.203200><0.120381,0.035000,0.203200> rotate<0,-59.996017,0> translate<70.215850,0.000000,26.389272> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.215850,0.000000,29.490725>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.276041,0.000000,29.386472>}
box{<0,0,-0.203200><0.120381,0.035000,0.203200> rotate<0,59.996017,0> translate<70.215850,0.000000,29.490725> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.231281,0.000000,26.416000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<83.941422,0.000000,26.416000>}
box{<0,0,-0.203200><13.710141,0.035000,0.203200> rotate<0,0.000000,0> translate<70.231281,0.000000,26.416000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.276041,0.000000,3.633525>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,3.749806>}
box{<0,0,-0.203200><0.120383,0.035000,0.203200> rotate<0,-74.995610,0> translate<70.276041,0.000000,3.633525> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.276041,0.000000,6.526472>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,6.410191>}
box{<0,0,-0.203200><0.120383,0.035000,0.203200> rotate<0,74.995610,0> translate<70.276041,0.000000,6.526472> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.276041,0.000000,26.493525>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,26.609806>}
box{<0,0,-0.203200><0.120383,0.035000,0.203200> rotate<0,-74.995610,0> translate<70.276041,0.000000,26.493525> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.276041,0.000000,29.386472>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,29.270191>}
box{<0,0,-0.203200><0.120383,0.035000,0.203200> rotate<0,74.995610,0> translate<70.276041,0.000000,29.386472> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.282491,0.000000,3.657600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<91.825706,0.000000,3.657600>}
box{<0,0,-0.203200><21.543216,0.035000,0.203200> rotate<0,0.000000,0> translate<70.282491,0.000000,3.657600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.282491,0.000000,6.502400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<85.820016,0.000000,6.502400>}
box{<0,0,-0.203200><15.537525,0.035000,0.203200> rotate<0,0.000000,0> translate<70.282491,0.000000,6.502400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307194,0.000000,4.876803>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,3.749806>}
box{<0,0,-0.203200><1.126997,0.035000,0.203200> rotate<0,89.993901,0> translate<70.307194,0.000000,4.876803> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307194,0.000000,27.736803>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,26.609806>}
box{<0,0,-0.203200><1.126997,0.035000,0.203200> rotate<0,89.993901,0> translate<70.307194,0.000000,27.736803> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,4.064000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<90.967750,0.000000,4.064000>}
box{<0,0,-0.203200><20.660553,0.035000,0.203200> rotate<0,0.000000,0> translate<70.307197,0.000000,4.064000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,4.470400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<90.109797,0.000000,4.470400>}
box{<0,0,-0.203200><19.802600,0.035000,0.203200> rotate<0,0.000000,0> translate<70.307197,0.000000,4.470400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,4.876800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<89.251841,0.000000,4.876800>}
box{<0,0,-0.203200><18.944644,0.035000,0.203200> rotate<0,0.000000,0> translate<70.307197,0.000000,4.876800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,5.283191>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,6.410191>}
box{<0,0,-0.203200><1.127000,0.035000,0.203200> rotate<0,90.000000,0> translate<70.307197,0.000000,6.410191> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,5.283200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<88.393884,0.000000,5.283200>}
box{<0,0,-0.203200><18.086687,0.035000,0.203200> rotate<0,0.000000,0> translate<70.307197,0.000000,5.283200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,5.689600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<87.535928,0.000000,5.689600>}
box{<0,0,-0.203200><17.228731,0.035000,0.203200> rotate<0,0.000000,0> translate<70.307197,0.000000,5.689600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,6.096000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<86.677972,0.000000,6.096000>}
box{<0,0,-0.203200><16.370775,0.035000,0.203200> rotate<0,0.000000,0> translate<70.307197,0.000000,6.096000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<84.754222,0.000000,26.822400>}
box{<0,0,-0.203200><14.447025,0.035000,0.203200> rotate<0,0.000000,0> translate<70.307197,0.000000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,27.228800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<85.567022,0.000000,27.228800>}
box{<0,0,-0.203200><15.259825,0.035000,0.203200> rotate<0,0.000000,0> translate<70.307197,0.000000,27.228800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,27.635200>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<86.379822,0.000000,27.635200>}
box{<0,0,-0.203200><16.072625,0.035000,0.203200> rotate<0,0.000000,0> translate<70.307197,0.000000,27.635200> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,28.143191>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,29.270191>}
box{<0,0,-0.203200><1.127000,0.035000,0.203200> rotate<0,90.000000,0> translate<70.307197,0.000000,29.270191> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,28.448000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<88.005422,0.000000,28.448000>}
box{<0,0,-0.203200><17.698225,0.035000,0.203200> rotate<0,0.000000,0> translate<70.307197,0.000000,28.448000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,28.854400>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<88.818225,0.000000,28.854400>}
box{<0,0,-0.203200><18.511028,0.035000,0.203200> rotate<0,0.000000,0> translate<70.307197,0.000000,28.854400> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<70.307197,0.000000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<89.631025,0.000000,29.260800>}
box{<0,0,-0.203200><19.323828,0.035000,0.203200> rotate<0,0.000000,0> translate<70.307197,0.000000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<78.420150,0.000000,10.007600>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<96.544472,0.000000,1.422397>}
box{<0,0,-0.203200><20.054844,0.035000,0.203200> rotate<0,25.344498,0> translate<78.420150,0.000000,10.007600> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<79.674213,0.000000,24.282397>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<96.844625,0.000000,32.867600>}
box{<0,0,-0.203200><19.197103,0.035000,0.203200> rotate<0,-26.563290,0> translate<79.674213,0.000000,24.282397> }
texture{col_pol}
}
#end
union{
cylinder{<22.225000,0.038000,24.130000><22.225000,-1.538000,24.130000>0.508000}
cylinder{<22.225000,0.038000,13.970000><22.225000,-1.538000,13.970000>0.508000}
cylinder{<37.465000,0.038000,19.050000><37.465000,-1.538000,19.050000>0.508000}
cylinder{<16.256000,0.038000,26.670000><16.256000,-1.538000,26.670000>0.558800}
cylinder{<13.716000,0.038000,26.670000><13.716000,-1.538000,26.670000>0.558800}
cylinder{<16.256000,0.038000,29.210000><16.256000,-1.538000,29.210000>0.558800}
cylinder{<13.716000,0.038000,29.210000><13.716000,-1.538000,29.210000>0.558800}
cylinder{<16.256000,0.038000,31.750000><16.256000,-1.538000,31.750000>0.558800}
cylinder{<13.716000,0.038000,31.750000><13.716000,-1.538000,31.750000>0.558800}
cylinder{<46.990000,0.038000,19.050000><46.990000,-1.538000,19.050000>0.406400}
cylinder{<45.085000,0.038000,17.780000><45.085000,-1.538000,17.780000>0.406400}
cylinder{<46.990000,0.038000,16.510000><46.990000,-1.538000,16.510000>0.406400}
//Holes(fast)/Vias
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
//BAT1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,19.050000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.115000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.290000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.385000,0.000000,19.050000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<32.385000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,19.050000>}
box{<0,0,-0.076200><1.905000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.210000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.115000,0.000000,21.590000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<31.115000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.480000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.210000,0.000000,22.225000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<29.210000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.845000,0.000000,22.860000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<29.845000,0.000000,22.860000> }
difference{
cylinder{<31.750000,0,19.050000><31.750000,0.036000,19.050000>11.506200 translate<0,0.000000,0>}
cylinder{<31.750000,-0.1,19.050000><31.750000,0.135000,19.050000>11.353800 translate<0,0.000000,0>}}
difference{
cylinder{<31.750000,0,19.050000><31.750000,0.036000,19.050000>10.312400 translate<0,0.000000,0>}
cylinder{<31.750000,-0.1,19.050000><31.750000,0.135000,19.050000>10.160000 translate<0,0.000000,0>}}
box{<-0.317500,0,-1.270000><0.317500,0.036000,1.270000> rotate<0,-180.000000,0> translate<32.067500,0.000000,19.050000>}
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.130000,0.000000,22.444000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.730000,0.000000,22.444000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.130000,0.000000,22.444000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.130000,0.000000,21.244000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.730000,0.000000,21.244000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.130000,0.000000,21.244000> }
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.730000,0.000000,13.116000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.130000,0.000000,13.116000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.130000,0.000000,13.116000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.730000,0.000000,14.316000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.130000,0.000000,14.316000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.130000,0.000000,14.316000> }
//C3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.290000,0.000000,12.030000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.890000,0.000000,12.030000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.290000,0.000000,12.030000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.290000,0.000000,10.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.890000,0.000000,10.830000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<21.290000,0.000000,10.830000> }
//C4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.730000,0.000000,10.068000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.130000,0.000000,10.068000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.130000,0.000000,10.068000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.730000,0.000000,11.268000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.130000,0.000000,11.268000>}
box{<0,0,-0.076200><0.600000,0.036000,0.076200> rotate<0,0.000000,0> translate<11.130000,0.000000,11.268000> }
//J1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<16.891000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.081000,0.000000,25.400000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<13.081000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.081000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<16.891000,0.000000,27.940000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<13.081000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.081000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<16.891000,0.000000,30.480000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<13.081000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<13.081000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<16.891000,0.000000,33.020000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,0.000000,0> translate<13.081000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.766000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.766000,0.000000,26.035000>}
box{<0,0,-0.101600><1.270000,0.036000,0.101600> rotate<0,-90.000000,0> translate<19.766000,0.000000,26.035000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<16.256000,0.000000,26.670000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<13.716000,0.000000,26.670000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<13.716000,0.000000,29.210000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<16.256000,0.000000,29.210000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<13.716000,0.000000,31.750000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<16.256000,0.000000,31.750000>}
//JP1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<-2.460000,0.000000,23.780000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.240000,0.000000,23.780000>}
box{<0,0,-0.063500><8.700000,0.036000,0.063500> rotate<0,0.000000,0> translate<-2.460000,0.000000,23.780000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.240000,0.000000,23.780000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.240000,0.000000,11.780000>}
box{<0,0,-0.063500><12.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<6.240000,0.000000,11.780000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.240000,0.000000,11.780000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<-2.460000,0.000000,11.780000>}
box{<0,0,-0.063500><8.700000,0.036000,0.063500> rotate<0,0.000000,0> translate<-2.460000,0.000000,11.780000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<-2.460000,0.000000,11.780000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<-2.460000,0.000000,23.780000>}
box{<0,0,-0.063500><12.000000,0.036000,0.063500> rotate<0,90.000000,0> translate<-2.460000,0.000000,23.780000> }
//PAD1 silk screen
//PAD2 silk screen
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.971200,0.000000,13.335000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.548800,0.000000,13.335000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<47.548800,0.000000,13.335000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.971200,0.000000,12.065000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.548800,0.000000,12.065000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<47.548800,0.000000,12.065000> }
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-0.000000,0> translate<47.396400,0.000000,12.700000>}
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-0.000000,0> translate<49.123600,0.000000,12.700000>}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.548800,0.000000,22.225000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.971200,0.000000,22.225000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<47.548800,0.000000,22.225000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<47.548800,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<48.971200,0.000000,23.495000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<47.548800,0.000000,23.495000> }
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-180.000000,0> translate<49.123600,0.000000,22.860000>}
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-180.000000,0> translate<47.396400,0.000000,22.860000>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.451000,0.000000,18.110200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<52.451000,0.000000,16.687800>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,-90.000000,0> translate<52.451000,0.000000,16.687800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.721000,0.000000,18.110200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<53.721000,0.000000,16.687800>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,-90.000000,0> translate<53.721000,0.000000,16.687800> }
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-90.000000,0> translate<53.086000,0.000000,16.535400>}
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-90.000000,0> translate<53.086000,0.000000,18.262600>}
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.718800,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.141200,0.000000,15.875000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<10.718800,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.718800,0.000000,17.145000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.141200,0.000000,17.145000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<10.718800,0.000000,17.145000> }
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-180.000000,0> translate<12.293600,0.000000,16.510000>}
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-180.000000,0> translate<10.566400,0.000000,16.510000>}
//R5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.718800,0.000000,18.415000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.141200,0.000000,18.415000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<10.718800,0.000000,18.415000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<10.718800,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.141200,0.000000,19.685000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<10.718800,0.000000,19.685000> }
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-180.000000,0> translate<12.293600,0.000000,19.050000>}
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-180.000000,0> translate<10.566400,0.000000,19.050000>}
//R6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.221200,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.798800,0.000000,24.765000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<15.798800,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<17.221200,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.798800,0.000000,23.495000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<15.798800,0.000000,23.495000> }
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-0.000000,0> translate<15.646400,0.000000,24.130000>}
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-0.000000,0> translate<17.373600,0.000000,24.130000>}
//R7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.903200,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.480800,0.000000,24.765000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<11.480800,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<12.903200,0.000000,23.495000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<11.480800,0.000000,23.495000>}
box{<0,0,-0.076200><1.422400,0.036000,0.076200> rotate<0,0.000000,0> translate<11.480800,0.000000,23.495000> }
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-0.000000,0> translate<11.328400,0.000000,24.130000>}
box{<-0.177800,0,-0.711200><0.177800,0.036000,0.711200> rotate<0,-0.000000,0> translate<13.055600,0.000000,24.130000>}
//T1 silk screen
object{ARC(2.667022,0.127000,275.463924,308.244924,0.036000) translate<46.990050,0.000000,17.780003>}
object{ARC(2.667025,0.127000,197.146908,275.465408,0.036000) translate<46.989981,0.000000,17.780000>}
object{ARC(2.666953,0.127000,51.752892,162.852892,0.036000) translate<46.990009,0.000000,17.780013>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<48.641000,0.000000,15.685500>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<48.641000,0.000000,19.874500>}
box{<0,0,-0.063500><4.189000,0.036000,0.063500> rotate<0,90.000000,0> translate<48.641000,0.000000,19.874500> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<47.244000,0.000000,15.526300>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<47.244000,0.000000,17.493700>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,90.000000,0> translate<47.244000,0.000000,17.493700> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<47.244000,0.000000,15.125100>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<47.244000,0.000000,15.526300>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,90.000000,0> translate<47.244000,0.000000,15.526300> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<47.244000,0.000000,17.493700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<47.244000,0.000000,18.066300>}
box{<0,0,-0.063500><0.572600,0.036000,0.063500> rotate<0,90.000000,0> translate<47.244000,0.000000,18.066300> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<47.244000,0.000000,20.033700>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<47.244000,0.000000,20.434900>}
box{<0,0,-0.063500><0.401200,0.036000,0.063500> rotate<0,90.000000,0> translate<47.244000,0.000000,20.434900> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<47.244000,0.000000,18.066300>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<47.244000,0.000000,20.033700>}
box{<0,0,-0.063500><1.967400,0.036000,0.063500> rotate<0,90.000000,0> translate<47.244000,0.000000,20.033700> }
object{ARC(2.667044,0.127000,162.853200,197.146800,0.036000) translate<46.990000,0.000000,17.780000>}
//U$1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.887000,0.000000,15.418000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.493000,0.000000,15.418000>}
box{<0,0,-0.076200><3.606000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.887000,0.000000,15.418000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<61.493000,0.000000,20.142000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.887000,0.000000,20.142000>}
box{<0,0,-0.076200><3.606000,0.036000,0.076200> rotate<0,0.000000,0> translate<57.887000,0.000000,20.142000> }
difference{
cylinder{<58.699400,0,19.583400><58.699400,0.036000,19.583400>0.245200 translate<0,0.000000,0>}
cylinder{<58.699400,-0.1,19.583400><58.699400,0.135000,19.583400>0.042000 translate<0,0.000000,0>}}
//U2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.034000,0.000000,21.996400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<18.034000,0.000000,20.980400>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<18.034000,0.000000,20.980400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<13.563600,0.000000,17.043400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.579600,0.000000,17.043400>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<13.563600,0.000000,17.043400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<21.996400,0.000000,16.535400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.980400,0.000000,16.535400>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.980400,0.000000,16.535400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.544800,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,20.320000>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,0.000000,0> translate<15.240000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,20.015200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,20.320000>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,90.000000,0> translate<20.320000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.015200,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,15.240000>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,0.000000,0> translate<20.015200,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,15.544800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,15.240000>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.240000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,15.544800>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,90.000000,0> translate<20.320000,0.000000,15.544800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.015200,0.000000,20.320000>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,0.000000,0> translate<20.015200,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,20.015200>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,-90.000000,0> translate<15.240000,0.000000,20.015200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.544800,0.000000,15.240000>}
box{<0,0,-0.076200><0.304800,0.036000,0.076200> rotate<0,0.000000,0> translate<15.240000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<16.510000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,16.510000>}
box{<0,0,0.000000><1.796051,0.036000,0.000000> rotate<0,44.997030,0> translate<15.240000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,19.380200>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,-90.000000,0> translate<15.240000,0.000000,19.380200> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,19.177000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,18.872200>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,-90.000000,0> translate<15.240000,0.000000,18.872200> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,18.669000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,18.389600>}
box{<0,0,0.000000><0.279400,0.036000,0.000000> rotate<0,-90.000000,0> translate<15.240000,0.000000,18.389600> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,18.186400>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,17.881600>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,-90.000000,0> translate<15.240000,0.000000,17.881600> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,17.678400>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,17.373600>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,-90.000000,0> translate<15.240000,0.000000,17.373600> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,17.170400>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,16.891000>}
box{<0,0,0.000000><0.279400,0.036000,0.000000> rotate<0,-90.000000,0> translate<15.240000,0.000000,16.891000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,16.687800>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,16.383000>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,-90.000000,0> translate<15.240000,0.000000,16.383000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,16.179800>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,15.875000>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,-90.000000,0> translate<15.240000,0.000000,15.875000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.875000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<16.179800,0.000000,15.240000>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,0.000000,0> translate<15.875000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<16.383000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<16.687800,0.000000,15.240000>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,0.000000,0> translate<16.383000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<16.891000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<17.170400,0.000000,15.240000>}
box{<0,0,0.000000><0.279400,0.036000,0.000000> rotate<0,0.000000,0> translate<16.891000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<17.373600,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<17.678400,0.000000,15.240000>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,0.000000,0> translate<17.373600,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<17.881600,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<18.186400,0.000000,15.240000>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,0.000000,0> translate<17.881600,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<18.389600,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<18.669000,0.000000,15.240000>}
box{<0,0,0.000000><0.279400,0.036000,0.000000> rotate<0,0.000000,0> translate<18.389600,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<18.872200,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<19.177000,0.000000,15.240000>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,0.000000,0> translate<18.872200,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<19.380200,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<19.685000,0.000000,15.240000>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,0.000000,0> translate<19.380200,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,15.875000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,16.179800>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,90.000000,0> translate<20.320000,0.000000,16.179800> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,16.383000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,16.687800>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,90.000000,0> translate<20.320000,0.000000,16.687800> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,16.891000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,17.170400>}
box{<0,0,0.000000><0.279400,0.036000,0.000000> rotate<0,90.000000,0> translate<20.320000,0.000000,17.170400> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,17.373600>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,17.678400>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,90.000000,0> translate<20.320000,0.000000,17.678400> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,17.881600>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,18.186400>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,90.000000,0> translate<20.320000,0.000000,18.186400> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,18.389600>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,18.669000>}
box{<0,0,0.000000><0.279400,0.036000,0.000000> rotate<0,90.000000,0> translate<20.320000,0.000000,18.669000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,18.872200>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,19.177000>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,90.000000,0> translate<20.320000,0.000000,19.177000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,19.380200>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,19.685000>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,90.000000,0> translate<20.320000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<19.685000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<19.380200,0.000000,20.320000>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,0.000000,0> translate<19.380200,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<19.177000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<18.872200,0.000000,20.320000>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,0.000000,0> translate<18.872200,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<18.669000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<18.389600,0.000000,20.320000>}
box{<0,0,0.000000><0.279400,0.036000,0.000000> rotate<0,0.000000,0> translate<18.389600,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<18.186400,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<17.881600,0.000000,20.320000>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,0.000000,0> translate<17.881600,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<17.678400,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<17.373600,0.000000,20.320000>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,0.000000,0> translate<17.373600,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<17.170400,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<16.891000,0.000000,20.320000>}
box{<0,0,0.000000><0.279400,0.036000,0.000000> rotate<0,0.000000,0> translate<16.891000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<16.687800,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<16.383000,0.000000,20.320000>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,0.000000,0> translate<16.383000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<16.179800,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.875000,0.000000,20.320000>}
box{<0,0,0.000000><0.304800,0.036000,0.000000> rotate<0,0.000000,0> translate<15.875000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,20.320000>}
box{<0,0,0.000000><5.080000,0.036000,0.000000> rotate<0,90.000000,0> translate<20.320000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,20.320000>}
box{<0,0,0.000000><5.080000,0.036000,0.000000> rotate<0,0.000000,0> translate<15.240000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,15.240000>}
box{<0,0,0.000000><5.080000,0.036000,0.000000> rotate<0,-90.000000,0> translate<15.240000,0.000000,15.240000> }
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<15.240000,0.000000,15.240000>}
cylinder{<0,0,0><0,0.036000,0>0.000000 translate<20.320000,0.000000,15.240000>}
box{<0,0,0.000000><5.080000,0.036000,0.000000> rotate<0,0.000000,0> translate<15.240000,0.000000,15.240000> }
//Y1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.910000,0.000000,13.284000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.110000,0.000000,13.284000>}
box{<0,0,-0.101600><1.200000,0.036000,0.101600> rotate<0,0.000000,0> translate<15.910000,0.000000,13.284000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.010000,0.000000,11.984000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<19.010000,0.000000,11.384000>}
box{<0,0,-0.101600><0.600000,0.036000,0.101600> rotate<0,-90.000000,0> translate<19.010000,0.000000,11.384000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.110000,0.000000,10.084000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<15.910000,0.000000,10.084000>}
box{<0,0,-0.101600><1.200000,0.036000,0.101600> rotate<0,0.000000,0> translate<15.910000,0.000000,10.084000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<14.010000,0.000000,11.984000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<14.010000,0.000000,11.384000>}
box{<0,0,-0.101600><0.600000,0.036000,0.101600> rotate<0,-90.000000,0> translate<14.010000,0.000000,11.384000> }
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  CHEAPBOARD1_1(-50.165000,0,-17.145000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//BAT1		BATTERY
//J1	AVR_SPI_PRG_6OFFSET_PADS	2X3_OFFSET
//JP1	USBPCB	USB-A-PCB
//PAD1		SMD2,54-5,08
//PAD2		SMD2,54-5,08
//U$1	DS1820SOIC	DS18B20_SOIC
//U2	ATMEGA8U2-MU	QFN50P500X500X100-33N
//Y1		CRYSTAL-SMD-5X3
