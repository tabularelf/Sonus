function __SonusAddEntry(_entry){
	static _inst = __SonusSystem();
	static _container = __SonusContainer();
	var _name = _entry.__name;
	
	if (SonusIndexExists(_name)) {
		__SonusError("Name alredy exists!");	
	}
	
	if (SonusGroupExists(_name)) {
		__SonusError("Name already exists!");	
	}
	
	if (variable_struct_exists(_container, _name)) {
		if (is_method(_container[$ _name])) {
			__SonusError("Cannot overwrite Sonus methods!");	
		}
	}
	
	_inst.__soundsMap[$ _name] = _entry;
	_container[$ _name] = _entry;
	array_push(_inst.__soundsList, _entry);
}