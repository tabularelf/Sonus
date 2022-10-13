function SonusGroupAdd(_name) {
	static _inst = __SonusSystem();
	_inst.__soundsGroup[$ _name] = new __SonusGroupClass(_name);
}