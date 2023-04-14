function __SonusIndexGet(_name) {
	static _inst = __SonusSystem();
	return _inst.__soundsMap[$ _name];
}