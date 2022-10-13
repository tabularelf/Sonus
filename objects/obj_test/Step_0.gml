if (!SonusGroupIsPlaying("ui_popup")) {
	snd.Play();	
	snd = SonusIndexGetRandom("ui_popup");
}