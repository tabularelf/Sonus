function __SonusTickAudioInsts() {
	static _inst = __SonusSystem();
	static _listener = _inst.__listener;
	static _config = __SonusContainer().Config;
	var _i = 0;
	var _listPlaying = _inst.__soundsPlayingList;
	var _listUnused = _inst.__soundsUnusedList;
	var _listListenerPlaying = _listener.__soundsPlayingList;
	var _timeStamp = get_timer() + _config.playingMaxCleanupTime;
	var _listenerX = _listener.x;
	var _listenerY = _listener.y;
	var _listenerZ = _listener.z;
	repeat(ds_list_size(_listPlaying)) {
		if (get_timer() > _timeStamp) break;
		if (!audio_is_playing(_listPlaying[| _i].__sndIndex)) {
			var _index = _listPlaying[| _i];
			if (_index.__parent.__currentSoundInsts > 0) {--_listPlaying[| _i].__parent.__currentSoundInsts};
			if (!is_undefined(_index.__parent.__group)) {
				var _j = 0;
				var _currentlyPlaying = _index.__parent.__group.__currentPlayingSoundsList;
				repeat(ds_list_size(_currentlyPlaying)) {
					if (_index == _currentlyPlaying[| _j]) {
						ds_list_delete(_currentlyPlaying, _j);
						--_j;
					}
					++_j;
				}
			}
			_index.__parent = undefined; // Null the parent so we don't accidentally hold onto references
			var _emitter = _index.__emitter;
			if (_index.__parentEmitter != undefined) {
				var _k = 0;
				var _array = _index.__parentEmitter.__audioInstList;
				repeat(ds_list_size(_array)) {
					if (_array[| _k] == _index) {
						ds_list_delete(_array, _k);
						break;
					}
					++_k
				}
				
				_index.__parentEmitter = undefined;
			}
			// Clear the temp bus
			_index.__tempBus = undefined;
			audio_emitter_velocity(_emitter, 0, 0, 0);
			audio_emitter_position(_emitter, 0, 0, 0);
			audio_emitter_falloff(_emitter, 0, 100, 1);
			audio_emitter_bus(_emitter, audio_bus_main);
			_index.__hasAudioBus = false;
			_index.__followListener = false;
			ds_list_add(_listUnused, _index);
			ds_list_delete(_listPlaying, _i);
			--_i;	
		} 
		++_i;
	}
	
	_i = 0;
	repeat(ds_list_size(_listListenerPlaying)) {
		if (!_listListenerPlaying[| _i].__followListener) {
			ds_list_delete(_listListenerPlaying, _i);
			--_i;
		}
		++_i;
	}
}