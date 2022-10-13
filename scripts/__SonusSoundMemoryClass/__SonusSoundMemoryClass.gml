function __SonusSoundMemoryClass(_name, _snd) : __SonusSoundClass(_name, _snd) constructor {
	__type = SonusSoundType.MEMORY;
	__compressedBuffer = -1;
	__buffer = -1;
	__compression = false;
	
	static __HandleUnload = function() {
		if (__compression) {
			__compressedBuffer = buffer_compress(__buffer, 0, buffer_get_size(__buffer));
		}
		
		audio_free_buffer_sound(__sndIndex);
		buffer_delete(__buffer);
	}
	
	static __HandleLoad = function() {
		if (__compression) {
			__buffer = buffer_decompress(__compressedBuffer);
			buffer_delete(__compressedBuffer);
		} else {
			__buffer = buffer_load(__filePath);
		}
		
		__sndIndex = __SonusBufferToAudio(__buffer);
	}
}