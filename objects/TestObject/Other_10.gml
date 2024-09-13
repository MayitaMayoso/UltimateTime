// Movement variables
var spd = 2;
var grav = 0.1;
var acc = 0.1;
var jump = 5;

// Get the inputs
var hdir = keyboard_check(ord("D")) - keyboard_check(ord("A"));
if (keyboard_check_pressed(ord("W")) && place_meeting(x, y+1, Ground)) {
	vspd = -jump;
}

var toSpd = hdir * spd;
if(hspd < toSpd){
	hspd = min(hspd + 0.1, toSpd); 
}else{
	hspd =  max(hspd - 0.1, toSpd);
}


if (!place_meeting(x, y+1, Ground)) {
	vspd += grav;	
}

// Reset if we fall
if (y > room_height) {
	x = xstart;
	y = ystart;
}

if (place_meeting(x + hspd, y, Ground)) {
	while(!place_meeting(x + sign(hspd), y, Ground)) {
		x += sign(hspd);	
	}
	hspd = 0;
}

if (place_meeting(x, y + vspd, Ground)) {
	while(!place_meeting(x, y + sign(vspd), Ground)) {
		y += sign(vspd);	
	}
	vspd = 0;
}

x += hspd;
y += vspd;






