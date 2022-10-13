function __SonusSoundStreamClass(_name, _snd) : __SonusSoundClass(_name, _snd) constructor {
	__type = SonusSoundType.STREAMED;
	 
	static __HandleUnload = function() {
		audio_destroy_stream(__sndIndex);
	}
	
	static __HandleLoad = function() {
		__sndIndex = audio_create_stream(__filePath);
	}
}