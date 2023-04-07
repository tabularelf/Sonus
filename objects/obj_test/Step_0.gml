if (!SonusIsPlaying(group)) {
	snd.Play();		
	snd.Unload();
	snd = SonusIndexGetRandom(group);
}

if (keyboard_check_released(vk_space)) {
	audio_stop_all();
	SonusClearPool();
}