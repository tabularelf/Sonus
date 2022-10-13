function __SonusAsyncClass(_snd) constructor {
	__id = http_get_file(_snd.__filePath, _snd.__asyncFilePath);
	__snd = _snd;
}