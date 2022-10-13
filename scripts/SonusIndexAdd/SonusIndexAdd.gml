function SonusIndexAdd(_filePath, _preload = false, _async = false) {
	static _inst = __SonusSystem();
	var _name = filename_name(_filePath);
	_name = string_delete(_name, string_pos(".", _name), 4);
	var _snd = undefined;
	switch(filename_ext(_filePath)) {
		case ".wav":
			_snd = new __SonusIndexMemoryClass(_name, -1);
		break;
		
		case ".ogg":
			_snd = new __SonusIndexStreamClass(_name, -1);
		break;
	}
	
	_snd.__isExternal = true;
	_snd.__filePath = _filePath;
	
	if (string_count("http://", _filePath) > 0) || (string_count("https://", _filePath) > 0) {
		var _newFilePath = game_save_id + "\\.temp\\" + filename_name(_filePath);
		_snd.__httpFilePath = _filePath;
		if (_snd.__type == SonusIndexType.MEMORY) {
			_snd.__asyncLoading = true;
		}
		_snd.__asyncByHTTP = true;
		_snd.__filePath = _newFilePath;
		if (!file_exists(_snd.__filePath)) {
			_snd.__isReady = false;
			array_push(_inst.__soundsHTTPQueue, new __SonusHTTPClass(_snd));
		}
	}
	
	if (_async) {
		if (!_snd.__asyncByHTTP) {
			if (_snd.__type == SonusIndexType.MEMORY) {
				_snd.__asyncLoading = true;
			}
		}
	}
	
	if (_preload) {
		_snd.Load();	
	}
	__SonusAddEntry(_snd);
	return _snd;
}