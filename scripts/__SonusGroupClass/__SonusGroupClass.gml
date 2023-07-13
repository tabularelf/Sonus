function __SonusGroupClass(_name) constructor {
	static _inst = __SonusSystem();
	__soundsMap = {};
	__soundsList = [];
	__subGroupList = [];
	__currentPlayingSoundsList = ds_list_create();
	__name = _name;
	__gain = 1;
	__pitch = 1;
	__bus = audio_bus_create();
	__hasEffects = false;
	__readOnly = false;
	__parent = undefined;
	
	static GetPlayCount = function() {
		return ds_list_size(__currentPlayingSoundsList);	
	}
		
	static SetMaxPlays = function(_num) {
		var _i = 0;
		repeat(array_length(__soundsList)) {
			__soundsList[_i].SetMaxPlays(_num);
			++_i;
		}
		return self;
	}

	static IsPlaying = function() {
		return __SonusGroupIsPlaying(self);	
	}
	
	static Stop = function() {
		var _i = 0;
		repeat(array_length(__soundsList)) {
			__soundsList[_i].Stop();
			++_i;
		}
		
		_i = 0;
		repeat(array_length(__subGroupList)) {
			__subGroupList[_i].Stop();
			++_i;
		}
		return self;
	}
	
	static SetGain = function(_num) {
		if (__gain == _num) return self;
		__gain = _num;
		var _i = 0;
		repeat(array_length(__subGroupList)) {
			__subGroupList[_i].__UpdatePlayingGain(_num);
			++_i;
		}
		
		__UpdatePlayingGain(_num);
		return self;	
	}
	
	static SetPitch = function(_num) {
		if (__pitch == _num) return self;
		__pitch = _num;
		var _i = 0;
		repeat(array_length(__subGroupList)) {
			__subGroupList[_i].__UpdatePlayingPitch(_num);
			++_i;
		}
		
		__UpdatePlayingPitch(_num);
		return self;	
	}
	
	static SetPitchRange = function(_min, _max) {
		if (is_array(__pitch) && __pitch[0] == _min && __pitch[1] == _max) return self;
		__pitch = [_min, _max];
		var _i = 0;
		repeat(array_length(__subGroupList)) {
			__subGroupList[_i].__UpdatePlayingPitchArray(_min, _max);
			++_i;
		}
		
		__UpdatePlayingPitchArray(_min, _max);
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
	
	static GetRandomIndex = function() {
		if (array_length(__soundsList) == 0) {
			return undefined;
		}
		
		return __soundsList[irandom(array_length(__soundsList)-1)]	
	}
	
	static SetEffect = function(_pos, _effectType, _params = undefined) {
		static _emptyParams = {};
		var _effect = (_effectType != undefined) ? audio_effect_create(_effectType, _params != undefined ? _params : _emptyParams) : _effectType;
		__bus.effects[_pos] = _effect;	
		var _i = 0;
		repeat(ds_list_size(__currentPlayingSoundsList)) {
			__currentPlayingSoundsList[| _i].__ApplyEffectBus(__currentPlayingSoundsList[| _i].__parent, self);
			++_i;
		}
	}
	
	static ApplyEffect = function(_pos, _effect) {
		__bus.effects[_pos] = _effect;	
		var _i = 0;
		repeat(ds_list_size(__currentPlayingSoundsList)) {
			__currentPlayingSoundsList[| _i].__ApplyEffectBus(__currentPlayingSoundsList[| _i].__parent, self);
			++_i;
		}		
	}
	
	static GetEffect = function(_pos) {
		return __bus.effects[_pos];	
	}
	
	static ResetEffects = function() {
		var _i = 0;
		repeat(array_length(__bus.effects)) {
			__bus.effects[_i] = undefined;	
			++_i;
		}
		
		_i = 0;
		repeat(ds_list_size(__currentPlayingSoundsList)) {
			__currentPlayingSoundsList[| _i].__ApplyEffectBus(__currentPlayingSoundsList[| _i].__parent, __currentPlayingSoundsList[| _i].__parentEmitter);
			++_i;
		}
	}
		
	static __UpdatePlayingPitch = function(_num) {
		var _i = 0;
		repeat(ds_list_size(__currentPlayingSoundsList)) {
			if (!audio_is_playing(__currentPlayingSoundsList[| _i].__sndIndex)) {
				ds_list_delete(__currentPlayingSoundsList, _i);
				--_i;
			} else {
				__currentPlayingSoundsList[| _i].SetPitch(_num);
			}
			++_i;
		}	
	}
	
	static __UpdatePlayingPitchArray = function(_min, _max) {
		var _i = 0;
		repeat(ds_list_size(__currentPlayingSoundsList)) {
			if (!audio_is_playing(__currentPlayingSoundsList[| _i].__sndIndex)) {
				ds_list_delete(__currentPlayingSoundsList, _i);
				--_i;
			} else {
				__currentPlayingSoundsList[| _i].SetPitchArray(_min, _max);
			}
			++_i;
		}	
	}
	
	static __UpdatePlayingGain = function(_num) {
		var _i = 0;
		repeat(ds_list_size(__currentPlayingSoundsList)) {
			if (!audio_is_playing(__currentPlayingSoundsList[| _i].__sndIndex)) {
				ds_list_delete(__currentPlayingSoundsList, _i);
				--_i;
			} else {
				__currentPlayingSoundsList[| _i].SetGain(_num);
			}
			++_i;
		}	
	}
}