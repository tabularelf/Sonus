function __SonusTick() {
	static _inst = __SonusSystem();
	var _i = 0;
	var _queue = _inst.__soundsUnloadQueue;
	
	repeat(array_length(_queue)) {
		var _snd = _queue[_i];
		if (!_snd.__isLoaded) {
			array_delete(_queue, _i, 1);
			--_i;
		}
		
		if (!audio_is_playing(_snd.__sndIndex)) && (_snd.__isLoaded) {
			_snd.__HandleUnload();
			_snd.__isLoaded = false;
			_snd.__currentSoundInsts = 0;
			array_delete(_queue, _i, 1);
			--_i;
		}
		_i = (_i+1) % _size;
	}
	
	// Handle Async
	_i = 0;
	_queue = _inst.__soundsAsyncQueue;
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
			buffer_delete(_entry._snd.__buffer);
			--_i;
		}	
	}
	
	// Handle garbage collection
	
	// Emitter
	_i = 0;
	_queue = _inst.__emitterList;
	repeat(ds_list_size(_queue)) {
		var _emitter = _queue[| _i];
		if (!weak_ref_alive(_emitter[0])) {
			if (audio_emitter_exists(_emitter[1])) {
				audio_emitter_free(_emitter[1]);
			}
			ds_list_delete(_queue, _i);
			--_i;
		}
		++_i;
	}
}