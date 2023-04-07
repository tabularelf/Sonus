if (!SonusIsPlaying(group)) {
	var _snd = emitter.Play(snd);	
	snd.Unload();
	snd = SonusIndexGetRandom(group);
}

if (keyboard_check_released(vk_space)) {
	SonusStopAll();
}

emitter.SetPosition(mouse_x, mouse_y);