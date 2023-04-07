function SonusGetPoolCount() {
	static _inst = __SonusSystem();
	return [ds_list_size(_inst.__soundsPlayingList), ds_list_size(_inst.__soundsUnusedList)];
}