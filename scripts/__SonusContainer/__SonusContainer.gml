#macro Sonus (__SonusContainer())

function __SonusContainer() {
	static _container = new __SonusContainerClass();
	return _container;
}

function __SonusContainerClass() constructor {
	#region Init
	static _inst = __SonusSystem();
	// Store sound asset names
	var _keys = variable_struct_get_names(_inst.__soundsMap);
	var _i = 0;
	repeat(array_length(_keys)) {
		self[$ _keys[_i]] = _inst.__soundsMap[$ _keys[_i]];	
		++_i;
	}
	
	_i = 0;
	var _keys = variable_struct_get_names(_inst.__soundsGroup);
	repeat(array_length(_keys)) {
		self[$ _keys[_i]] = _inst.__soundsGroup[$ _keys[_i]];	
		++_i;
	}
	#endregion
	
	#region Methods
	static AddIndex = function(_filePath, _group = undefined, _preload = false, _async = false) {
		if (is_array(_filePath)) {
			//var _array = array_create(array_length(_filePath));
			var _i = 0;
			repeat(array_length(_filePath)) {
				SonusIndexAdd(_filePath[_i], _group, _preload, _async);	
				++_i;
			}
			return self;
		}
		
		SonusIndexAdd(_filePath, _group, _preload, _async);
		return self;
	}
	
	static AddGroup = function(_groupName) {
		var _group = SonusGroupAdd(_groupName);
		
		if (argument_count > 1) {
			var _i = 1;
			repeat(argument_count) {
				SonusGroupAddSubGroup(_group.__name, argument[_i]);
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
		audio_listener_set_position(_pos, _x, _y, _z);	
	}
	#endregion
}