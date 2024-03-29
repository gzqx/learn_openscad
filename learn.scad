$eps=0.001;

$lr_height=8;
$lr_width=5;
$kt_height=3;
$kt_width=3;
$br_width=5;
$br_height_A=4;
$br_height_B=5;
$btr_width=3;
$btr_height=2;
$bathroom_bedroom_overlap=1;
$balcony_height=1;
$balcony_width=$lr_width;

$living_room_size=[$lr_width,$lr_height];
$kitchen_size=[$kt_width,$kt_height];
$bedroom_A_size=[$br_width,$br_height_A];
$bedroom_B_size=[$br_width,$br_height_B];
$bathroom_size=[$btr_width,$btr_height];
$bathroom_lower_poz=$living_room_size[1]-$bedroom_B_size[1]+$bathroom_bedroom_overlap-$bathroom_size[1];
$balcony_size=[$balcony_width,$balcony_height];

module living_room(){
	square($living_room_size);
}
module kitchen($epsesmd=[0,0]) {
	translate($epsesmd) translate([$living_room_size[0]-$kitchen_size[0],$living_room_size[1]-$kitchen_size[1]]) 
		square([$kt_width-$epsesmd[0],$kt_height-$epsesmd[1]]);
}

module bedroom_B(){
	translate([$living_room_size[0],$living_room_size[1]-$bedroom_B_size[1]]) square($bedroom_B_size);
}
module bathroom($epsesmd=[0,0]){
	translate($epsesmd) translate([$living_room_size[0]+$bedroom_B_size[0]-$bathroom_size[0],$bathroom_lower_poz]) 
		square([$bathroom_size[0]-$epsesmd[0],$bathroom_size[1]-$epsesmd[1]]);
}
module bedroom_A(){
	translate([$living_room_size[0]+$eps,$bathroom_lower_poz-$bedroom_A_size[1]]) square($bedroom_A_size);
}

module balcony($epsesmd=[0,0]){
	translate($epsesmd) translate([0,-$balcony_height]) 
		square([$balcony_size[0],$balcony_size[1]]);
}

difference(){
	living_room();
	kitchen([-$eps,-$eps]);
}
kitchen();

translate([$eps,$eps]) difference() {
	bedroom_B();
	bathroom([-$eps,$eps]);
}

bathroom();
bedroom_A();
balcony([0,-$eps]);

