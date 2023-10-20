if (mouse_check_button_released(mb_left)) {
	//Sonus.sndBleep11_external.Play();	
	show_debug_message(Sonus.sndBleep11_external.Play());
}

if (mouse_check_button_released(mb_right)) {
	show_debug_message(Sonus.sndBleep11_internal.Play());
}