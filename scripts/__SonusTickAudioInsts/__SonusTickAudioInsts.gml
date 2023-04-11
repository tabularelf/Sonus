function __SonusTickAudioInsts() {
	static _inst = __SonusSystem();
	var _i = 0;
	var _listPlaying = _inst.__soundsPlayingList;
	var _listUnused = _inst.__soundsUnusedList;
	var _timeStamp = get_timer() + __SONUS_MAX_TIME_CLEANUP_MS;
	repeat(ds_list_size(_listPlaying)) {
		if (get_timer() > _timeStamp) break;
		if (!audio_is_playing(_listPlaying[| _i].__sndIndex)) {
			var _index = _listPlaying[| _i];
			if (_index.__parent.__currentSoundInsts > 0) {--_listPlaying[| _i].__parent.__currentSoundInsts};
			if (!is_undefined(_index.__parent.__group)) {
				var _j = 0;
				var _currentlyPlaying = _index.__parent.__group.__currentPlayingSoundsList;
				repeat(array_length(_currentlyPlaying)) {
					if (_index == _currentlyPlaying[_j]) {
						array_delete(_currentlyPlaying, _j, 1);
						--_j;
					}
					++_j;
				}
			}
			_index.__parent = undefined; // Null the parent so we don't accidentally hold onto references
			var _emitter = _index.__emitter;
			if (_index.__parentEmitter != undefined) {
				var _k = 0;
				var _array = _index.__parentEmitter.__emitterList;
				repeat(array_length(_array)) {
					if (_array[_k] == _index) {
						array_delete(_array, _k, 1);
						break;
					}
					++_k
				}
				
				_index.__parentEmitter = undefined;
			}
			// Clear the temp bus
			_index.__tempBus = undefined;
			audio_emitter_bus(_emitter, audio_bus_main);
			ds_list_add(_listUnused, _index);
			ds_list_delete(_listPlaying, _i);
			--_i;	
		}
		++_i;
	}
}