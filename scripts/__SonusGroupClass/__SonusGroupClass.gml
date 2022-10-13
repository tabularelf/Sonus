function __SonusGroupClass(_name) constructor {
	__soundsMap = {};
	__soundsList = [];
	__name = _name;
	
	static AddEntry = function(_snd) {
		__soundsMap[$ _snd.__name] = _snd;
		array_push(__soundsList, _snd);
		if (!is_undefined(_snd.__group)) {
			_snd.__group.RemoveEntry(_snd);	
		}
		_snd.__group = self;
		return self;
	}
	
	static RemoveEntry = function(_snd) {
		variable_struct_remove(__soundsMap, _snd.__name);
		var _i = 0;
		repeat(array_length(__soundsList)) {
			if (__soundsList[_i] == _snd) {
				array_delete(__soundsList, _i, 1);
				break;	
			}
			++_i;
		}
	}
}