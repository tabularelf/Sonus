function __SonusIndexExists(_name) {
	static _inst = __SonusSystem();
	return variable_struct_exists(_inst.__soundsMap, _name);
}