function __SonusTick() {
	static _inst = __SonusSystem();
	static _config = __SonusContainer().Config;
	static _cachedMaxChannelAudioInsts = _config.maxChannelAudioInsts;
	var _i = 0;
	var _queue = _inst.__soundsUnloadQueue;
	
	if (_config.maxChannelAudioInsts != _cachedMaxChannelAudioInsts) {
		_cachedMaxChannelAudioInsts = _config.maxChannelAudioInsts;
		audio_channel_num(_cachedMaxChannelAudioInsts);
	}
	
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
		++_i;
	}
	
	// Handle Async
	_i = 0;
	_queue = _inst.__soundsAsyncQueue;
	repeat(array_length(_queue)) {
		var _entry = _queue[_i];
		if (buffer_get_size(_entry.__buffer) > 1) {
			_entry.__snd.__HandleWav(_entry.__buffer);
			_entry.__snd.__sndIndex = __SonusBufferWavToAudio(_entry.__snd.__buffer);
			_entry.__snd.__isReady = true;
			_entry.__snd.__isLoaded = true;
			_entry.__snd.__isLoading = false;
			array_delete(_queue, _i, 1);
			--_i;
		} else if (!_entry.__snd.__asyncByHTTP) {
			__SonusError("File wasn't loaded!", true);
			array_delete(_queue, _i, 1);
			buffer_delete(_entry._snd.__buffer);
			--_i;
		}	
		++_i;
	}
	
	// Handle garbage collection
	
	// Emitter
	static _j = 0;
	_queue = _inst.__emitterList;
	var _maxTime = get_timer() + 50;
	var _size = ds_list_size(_queue);
	if (_size != 0) {
		_j = _j % _size;
		repeat(_size) {
			var _emitter = _queue[| _j];
			if (!weak_ref_alive(_emitter[0])) {
				if (ds_exists(_emitter[1], ds_type_list)) {
					ds_list_destroy(_emitter[1]);
				}
				ds_list_delete(_queue, _j);
				--_size;
			}
			_j = (_j + 1) % _size;
			if (get_timer() > _maxTime) break;
		}
	}
}