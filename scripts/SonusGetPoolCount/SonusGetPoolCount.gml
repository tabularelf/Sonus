function SonusGetPoolCount() {
	static _inst = __SonusSystem();
	return "SonusPlaying: " + string(ds_list_size(_inst.__soundsPlayingList)) + "\nSonusUnused: " + string(ds_list_size(_inst.__soundsUnusedList))
}