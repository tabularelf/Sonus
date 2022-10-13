function __SonusAddEntry(_entry){
	static _inst = __SonusSystem();
	_inst.__soundsMap[$ _entry.__name] = _entry;
	array_push(_inst.__soundsList, _entry);
}