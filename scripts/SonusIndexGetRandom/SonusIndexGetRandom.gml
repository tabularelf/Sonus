function SonusIndexGetRandom(_groupName) {
	static _inst = __SonusSystem();
	var _group = _inst.__soundsGroup[$ _groupName];
	var _len = array_length(_group.__soundsList);
	if (_len == 0) {
		return undefined;
	}
	
	return _group.__soundsList[irandom(array_length(_group.__soundsList)-1)];
}