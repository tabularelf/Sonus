function SonusGroupAdd(_name) {
	static _inst = __SonusSystem();
	if (!SonusGroupExists(_name)) {
		_inst.__soundsGroup[$ _name] = new __SonusGroupClass(_name);
	}
}