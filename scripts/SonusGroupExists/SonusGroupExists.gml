function SonusGroupExists(_name) {
	static _inst = __SonusSystem();
	return variable_struct_exists(_inst.__soundsGroup, _name);
}