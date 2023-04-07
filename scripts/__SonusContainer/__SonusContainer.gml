#macro Sonus (__SonusContainer())

function __SonusContainer() {
	static _container = new __SonusContainerClass();
	return _container;
}

function __SonusContainerClass() constructor {
	static _inst = __SonusSystem();
	// Store sound asset names
	var _keys = variable_struct_get_names(_inst.__soundsMap);
	var _i = 0;
	repeat(array_length(_keys)) {
		self[$ _keys[_i]] = _inst.__soundsMap[$ _keys[_i]];	
		++_i;
	}
	
	static Get = function(_name) {
		return self[$ _name];
	}
	
	static GetRandomIndex = function(_group) {
		return SonusIndexGetRandom(_group);
	}
	
	static Exists = function(_name) {
		return SonusIsSonusIndex(_name);
	}
}