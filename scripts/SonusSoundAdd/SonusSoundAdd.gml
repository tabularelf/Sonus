function SonusSoundAdd(_filePath, _preload = false) {
	static _inst = __SonusSystem();
	var _name = filename_name(_filePath);
	_name = string_delete(_name, string_pos(".", _name), 4);
	var _snd = undefined;
	switch(filename_ext(_filePath)) {
		case ".wav":
			_snd = new __SonusSoundMemoryClass(_name, -1);
		break;
		
		case ".ogg":
			_snd = new __SonusSoundStreamClass(_name, -1);
		break;
	}
	
	_snd.__isExternal = true;
	_snd.__filePath = _filePath;
	
	if (string_count("http://", _filePath) > 0) || (string_count("https://", _filePath) > 0) {
		_snd.__asyncLoading = true;
		_snd.__asyncFilePath = game_save_id + "\\.temp\\" + filename_name(_filePath);
		if (!file_exists(_snd.__asyncFilePath)) {
			_snd.__isReady = false;
			array_push(_inst.__soundsAsyncQueue, new __SonusAsyncClass(_snd));
		}
	}
	
	if (_preload) {
		_snd.Load();	
	}
	__SonusAddEntry(_snd);
	return _snd;
}