function __SonusHTTPClass(_snd) constructor {
	__id = http_get_file(_snd.__httpFilePath, _snd.__filePath);
	__snd = _snd;
}