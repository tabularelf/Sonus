function __SonusGroupAddSound(_snd, _name) {
	static _inst = __SonusSystem();
	_inst.__soundsGroup[$ _name].AddEntry(_snd);
}