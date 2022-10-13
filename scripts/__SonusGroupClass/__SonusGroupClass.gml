function __SonusGroupClass(_name) constructor {
	__soundsMap = {};
	__soundsList = [];
	__subGroupList = [];
	__name = _name;
	__gain = 1;
	__pitch = 1;
	
	static SetGain = function(_num) {
		__gain = _num;
		var _i = 0;
		repeat(array_length(__subGroupList)) {
			__subGroupList[_i].SetGain(_num);
			++_i;
		}
		return self;	
	}
	
	static SetPitch = function(_num) {
		__pitch = _num;
		var _i = 0;
		repeat(array_length(__subGroupList)) {
			__subGroupList[_i].SetPitch(_num);
			++_i;
		}
		return self;	
	}
	
	static SetPitchRange = function(_min, _max) {
		__pitch = [_min, _max];
		var _i = 0;
		repeat(array_length(__subGroupList)) {
			__subGroupList[_i].SetPitchRange(_min, _max);
			++_i;
		}
		return self;	
	}
	
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