draw_text(8, 8, SonusGetPoolCount());

var _xDir = lengthdir_x(512, (current_time / 5000)*360);
var _yDir = lengthdir_y(256, (current_time / 5000)*360);

draw_circle((room_width div 2) + _xDir, (room_height div 2) + _yDir, 32, false);