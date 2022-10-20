enum SonusIndexType {
	STREAMED,
	MEMORY,
	UNKNOWN
}

function __SonusSystem() {
	static _inst = undefined;
	if (is_undefined(_inst)) {
		_inst = {
			__soundsMap: {},
			__soundsList: [],
			__soundsGroup: {},
			__timerAsync: undefined,
			__timerAudioInsts: undefined,
			__soundsUnloadQueue: [],
			__soundsAsyncQueue: [],
			__soundsHTTPQueue: [],
			__channelNum: 128,
			__soundsPlayingList: ds_list_create(),
			__soundsUnusedList: ds_list_create()
		}
		
		_inst.__timerAsync = time_source_create(time_source_global, 1, time_source_units_frames, __SonusTick, [], -1);
		_inst.__timerAudioInsts = time_source_create(time_source_global, __SONUS_PLAYING_CLEANUP_TIME, time_source_units_frames, __SonusTickAudioInsts, [], -1);
		
		time_source_start(_inst.__timerAsync);
		time_source_start(_inst.__timerAudioInsts);
		
		var _i = 0;
		while(audio_exists(_i)) {
			var _name = audio_get_name(_i);
			var _snd = (audio_get_type(_i) == 1) ? new __SonusIndexStreamClass(_name, _i) : new __SonusIndexMemoryClass(_name, _i);
			__SonusAddEntry(_snd);
			var _tags = asset_get_tags(_name, asset_sound);
			var _j = 0;
			repeat(array_length(_tags)) {
				var _tag = _tags[_j];
				if (string_copy(_tag, 1, 10) == "SonusGroup") {
					_tag = string_delete(_tag, 1, 11);
					if (!SonusGroupExists(_tag)) {
						SonusGroupAdd(_tag);	
					}
					SonusGroupAddSound(_snd, _tag);
				}
				++_j;
			}
			
			++_i;
		}
		
		if (__SONUS_AUTO_PREFILL_POOL) {
			SonusPrefillPool(__SONUS_AUTO_PREFILL_POOL_VALUE);	
		}
	}
	return _inst;
}

__SonusSystem();