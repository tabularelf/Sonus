function __SonusGroupGet(_name) {
	static _inst = __SonusSystem();
	return _inst.__soundsGroup[$ _name];
}