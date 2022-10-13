function __SonusAsyncClass(_snd) constructor {
	__buffer = buffer_create(1, buffer_grow, 1);
	__id = buffer_load_async(__buffer, _snd.__filePath, 0, -1);
	__snd = _snd;
}