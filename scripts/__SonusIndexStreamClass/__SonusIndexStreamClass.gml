function __SonusIndexStreamClass(_name, _snd) : __SonusIndexClass(_name, _snd) constructor {
	__type = SonusIndexType.STREAMED;
	 
	static __HandleUnload = function() {
		audio_destroy_stream(__sndIndex);
	}
	
	static __HandleLoad = function() {
		var _filePath = (__asyncLoading) ? __asyncFilePath : __filePath;
		if (!file_exists(_filePath)) {
			__SonusTrace("File " + _filePath + " doesn't exist!");
			exit;	
		}
		__sndIndex = audio_create_stream(_filePath);
	}
}