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
		var _entry = _queue[_i];
		if (buffer_get_size(_entry.__buffer) > 1) {
			_entry.__snd.__HandleWav(_entry.__buffer);
			_entry.__snd.__sndIndex = __SonusBufferToAudio(_entry.__snd.__buffer);
			_entry.__snd.__isReady = true;
			_entry.__snd.__isLoaded = true;
			array_delete(_queue, _i, 1);
			--_i;
		} else {
			__SonusError("File wasn't loaded!", true);
			array_delete(_queue, _i, 1);
			buffer_delete(_snd.__buffer);
			--_i;
		}	
	}
}