function __SonusGroupAdd(_name) {
	static _inst = __SonusSystem();
	static _container = __SonusContainer();
	if (!__SonusGroupExists(_name)) {
		var _newInst = new __SonusGroupClass(_name);
		_inst.__soundsGroup[$ _name] = _newInst;
		_container[$ _name] = _newInst;
	}
	return _inst.__soundsGroup[$ _name];
}