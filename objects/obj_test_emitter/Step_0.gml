if (!SonusGroupIsPlaying(group)) {
	var _snd = emitter.Play(snd);	
	snd.Unload();
	snd = SonusIndexGetRandom(group);
}

if (keyboard_check_released(vk_space)) {
	audio_stop_all();
	SonusClearPool();
}

emitter.SetPosition(mouse_x, mouse_y);