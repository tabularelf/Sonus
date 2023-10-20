//if (!Sonus.ui_menu_popup_message_02.IsPlaying()) {
	Sonus.ui_menu_popup_message_02.PlayOn(emitter);
//}
 
if (keyboard_check_released(vk_space) == true) {
	emitter.ResetEffects();
}

var _xDir = lengthdir_x(-512, (current_time / 5000)*360);
var _yDir = lengthdir_y(256, (current_time / 5000)*360);

Sonus.Master.SetGain(.5);

emitter.SetPosition((room_width div 2) + _xDir, (room_height div 2) + _yDir, 0);

//Sonus.SetListenerPos(mouse_x, mouse_y, 0);

//emitter.SetPosition(mouse_x, mouse_y);