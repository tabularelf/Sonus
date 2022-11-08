function __SonusTickAudioInsts() {
	static _inst = __SonusSystem();
	var _i = 0;
	var _listPlaying = _inst.__soundsPlayingList;
	var _listUnused = _inst.__soundsUnusedList;
	var _timeStamp = get_timer() + __SONUS_MAX_TIME_CLEANUP_MS;
	repeat(ds_list_size(_listPlaying)) {
		if (get_timer() > _timeStamp) break;
		if (!audio_is_playing(_listPlaying[| _i].__sndIndex)) {
			if (_listPlaying[| _i].__parent.__currentSoundInsts > 0) {--_listPlaying[| _i].__parent.__currentSoundInsts};
			if (!is_undefined(_listPlaying[| _i].__parent.__group)) {
				var _j = 0;
				var _index = _listPlaying[| _i];
				var _currentlyPlaying = _listPlaying[| _i].__parent.__group.__currentPlayingSoundsList;
				repeat(array_length(_currentlyPlaying)) {
					if (_index == _currentlyPlaying[_j]) {
						array_delete(_currentlyPlaying, _j, 1);
						--_j;
					}
					++_j;
				}
			}
			_listPlaying[| _i].__parent = undefined; // Null the parent so we don't accidentally hold onto references
			ds_list_add(_listUnused, _listPlaying[| _i]);
			ds_list_delete(_listPlaying, _i);
			--_i;	
		}
		++_i;
	}
	//show_debug_message([ds_list_size(_listPlaying), ds_list_size(_listUnused)]);
}