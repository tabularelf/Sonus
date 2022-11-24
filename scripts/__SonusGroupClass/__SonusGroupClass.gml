function __SonusGroupClass(_name) constructor {
	static _inst = __SonusSystem();
	__soundsMap = {};
	__soundsList = [];
	__subGroupList = [];
	__currentPlayingSoundsList = [];
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
		
		_i = 0;
		repeat(array_length(__currentPlayingSoundsList)) {
			if (!audio_is_playing(__currentPlayingSoundsList[_i].__sndIndex)) {
				array_delete(__currentPlayingSoundsList, _i, 1);
				--_i;
			} else {
				__currentPlayingSoundsList[_i].SetGain(_num);
			}
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
		
		_i = 0;
		repeat(array_length(__currentPlayingSoundsList)) {
			if (!audio_is_playing(__currentPlayingSoundsList[_i].__sndIndex)) {
				array_delete(__currentPlayingSoundsList, _i, 1);
				--_i;
			} else {
				__currentPlayingSoundsList[_i].SetPitch(_num);
			}
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
		
		_i = 0;
		repeat(array_length(__currentPlayingSoundsList)) {
			if (!audio_is_playing(__currentPlayingSoundsList[_i].__sndIndex)) {
				array_delete(__currentPlayingSoundsList, _i, 1);
				--_i;
			} else {
				__currentPlayingSoundsList[_i].SetPitchRange(_min, _max);
			}
			++_i;
		}
		return self;	
	}
	
	static AddEntry = function(_snd) {
		var _sndIndex = is_string(_snd) ? _inst.__soundsMap[$ _snd] : _snd;
		__soundsMap[$ _sndIndex.__name] = _sndIndex;
		array_push(__soundsList, _sndIndex);
		if (!is_undefined(_sndIndex.__group)) {
			_sndIndex.__group.RemoveEntry(_sndIndex);	
		}
		_sndIndex.__group = self;
		return self;
	}
	
	static RemoveEntry = function(_snd) {
		var _sndIndex = is_string(_snd) ? __soundsMap[$ _snd] : _snd;
		variable_struct_remove(__soundsMap, _sndIndex.__name);
		var _i = 0;
		repeat(array_length(__soundsList)) {
			if (__soundsList[_i] == _sndIndex) {
				array_delete(__soundsList, _i, 1);
				break;	
			}
			++_i;
		}
	}
}