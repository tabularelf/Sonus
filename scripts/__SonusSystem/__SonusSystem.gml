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
		}
		
		var _i = 0;
		while(audio_exists(_i)) {
			var _name = audio_get_name(_i);
			var _snd = (audio_get_type(_i) == 1) ? new __SonusSoundStreamClass(_name, _i) : new __SonusSoundMemoryClass(_name, _i);
			_inst.__soundsMap[$ _name] = _snd;
			array_push(_inst.__soundsList, _snd);
			++_i;
		}
	}
	return _inst;
}

__SonusSystem();

show_debug_message(__SonusSystem());