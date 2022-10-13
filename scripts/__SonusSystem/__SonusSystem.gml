enum SonusSoundType {
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
			__soundsGroup: {}
		}
		
		var _i = 0;
		while(audio_exists(_i)) {
			var _name = audio_get_name(_i);
			var _snd = (audio_get_type(_i) == 1) ? new __SonusSoundStreamClass(_name, _i) : new __SonusSoundMemoryClass(_name, _i);
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
	}
	return _inst;
}

__SonusSystem();

show_debug_message(__SonusSystem());