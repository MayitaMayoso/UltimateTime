game_set_speed(120, gamespeed_fps);

Time.Register(id, function() { event_user(0); });

hspd = 0;
vspd = 0;
touchingSlowMo = false;

myStruct = new TestStruct();
//myStruct.CleanUp();