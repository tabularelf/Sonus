#macro Sonus (__SonusContainer())

function __SonusContainer() {
	static _container = new __SonusContainerClass();
	return _container;
}

function __SonusContainerClass() constructor {
	static __system = __SonusSystem();
	
	#region Methods
	static GetNames = function() {
		return variable_struct_get_names(__system.__soundsMap);	
	}
	
	static AddIndex = function(_filePath, _group = undefined, _preload = false, _async = false) {
		if (is_array(_filePath)) {
			//var _array = array_create(array_length(_filePath));
			var _i = 0;
			repeat(array_length(_filePath)) {
				__SonusIndexAdd(_filePath[_i], _group, _preload, _async);	
				++_i;
			}
			return self;
		}
		
		__SonusIndexAdd(_filePath, _group, _preload, _async);
		return self;
	}
	
	static AddGroup = function(_groupName) {
		var _group = __SonusGroupAdd(_groupName);
		
		if (argument_count > 1) {
			var _i = 1;
			repeat(argument_count-1) {
				__SonusGroupAddSubGroup(_group.__name, argument[_i]);
				++_i;
			}
		}
	}
		
	static AddSubGroup = function(_groupName) {
		if (argument_count >= 2) {
			var _i = 1;
			repeat(argument_count-1) {
				__SonusGroupAddSubGroup(_groupName, argument[_i]);
				++_i;
			}
		}
	}
	
	static Get = function(_name) {
		if (!Exists(_name)) {
			__SonusError("Not a valid name!");
		}

		return self[$ _name];
	}
	
	static GetRandomIndex = function(_group) {
		return SonusIndexGetRandom(_group);
	}
	
	static Exists = function(_name) {
		return SonusIndexExists(_name) || SonusGroupExists(_name);
	}
	
	static SetEffect = function(_pos, _effectType, _params = undefined) {
		var _effect = _effectType != undefined ? audio_effect_create(_effectType, _params != undefined ? _params : {}) : _effectType;
		audio_bus_main.effects[_pos] = _effect;
	}
	
	static ResetEffects = function() {
		var _i = 0;
		repeat(array_length(audio_bus_main.effects)) {
			audio_bus_main.effects[_i] = undefined;	
			++_i;
		}
	}
	
	static SetListenerPos = function(_x, _y, _z, _pos = 0) {
		static _listener = __system.__listener;
		if (_listener.x == _x) &&
		   (_listener.y == _y) &&
		   (_listener.z == _z) return self;
		_listener.x = _x;
		_listener.y = _y;
		_listener.z = _z;
		audio_listener_set_position(_pos, _x, _y, _z);	
		var _i = 0;
		var _list = _listener.__soundsPlayingList;
		repeat(ds_list_size(_list)) {
			if (_list[| _i].__followListener)
			audio_emitter_position(_list[| _i].__emitter, _x, _y, _z);	
			++_i;
		}
		return self;
	}
	
	static GetPoolCount = function() {
		return [ds_list_size(__system.__soundsPlayingList), ds_list_size(__system.__soundsUnusedList)];	
	}
	
	static Config = {
		autoCompressWav: true,
		autoCompressSize: 2097152,
		playingMaxCleanupTime: 10000,
		maxChannelAudioInsts: 128
	}
	#endregion
}