function TestStruct() constructor {
	
	x = 0;
	y = 0;
	angle = 0;
	
	static FixedStep = function() {
		x = room_width/2 + lengthdir_x(50, angle);
		y = room_height/2 + lengthdir_y(50, angle);
		angle += 2;
	};
	
	static Draw = function() {
		draw_circle(x, y, 10, false);	
	}
	
	static CleanUp = function() {
		Time.Unregister(self);
	}
	
	Time.Register(self, FixedStep);
}