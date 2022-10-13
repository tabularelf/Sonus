function __SonusTick() {
	static _inst = __SonusSystem();
	var _i = 0;
	var _queue = _inst.__soundsUnloadQueue;
	repeat(array_length(_queue)) {
		var _snd = _queue[_i];
		if (!_snd.__isLoaded) {
			array_delete(_queue, _i, 1);
			--_i;
			continue;
		}
		
		if (!audio_is_playing(_snd.__sndIndex)) {
			_snd.__HandleUnload();
			_snd.__isLoaded = false;
			array_delete(_queue, _i, 1);
			--_i;
			continue;
		}
	}
	
	// Handle Async
	_i = 0;
	var _queue = _inst.__soundsAsyncQueue;
	repeat(array_length(_queue)) {
		var _snd = _queue[_i];
		if (file_exists(_snd.__snd.__asyncFilePath)) {
			_snd.__snd.__isReady = true;
			array_delete(_queue, _i, 1);
			--_i;
		}
	}
}