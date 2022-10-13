function SonusSoundAdd(_fileName, _preload = false) {
	static _inst = __SonusSystem();
	var _name = filename_name(_fileName);
	_name = string_delete(_name, string_pos(".", _name), 4);
	var _snd = undefined;
	switch(filename_ext(_fileName)) {
		case ".wav":
			_snd = new __SonusSoundMemoryClass(_name, -1);
		break;
		
		case ".ogg":
			_snd = new __SonusSoundStreamClass(_name, -1);
		break;
	}
	
	_snd.__isExternal = true;
	__SonusAddEntry(_snd);
}