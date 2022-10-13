if (!SonusGroupIsPlaying("ui_popup")) {
	snd.Play();	
	snd.Unload();
	snd = SonusIndexGetRandom("ui_popup");
}

if (keyboard_check_released(vk_space)) {
	audio_stop_all();	
}