function __SonusGroupIsPlaying(_name) {
	static _inst = __SonusSystem();
	var _group = (is_struct(_name)) ? _name : _inst.__soundsGroup[$ _name];
	var _i = 0;
	var _array = _group.__soundsList;
	repeat(array_length(_array)) {
		if (__SonusIndexIsPlaying(_array[_i])) {
			return true;
		}
		++_i;
	}
	
	_i = 0;
	_array = _group.__subGroupList;
	repeat(array_length(_array)) {
		if (__SonusGroupIsPlaying(_array[_i])) {
			return true;
		}
		++_i;
	}
	
	return false;
}