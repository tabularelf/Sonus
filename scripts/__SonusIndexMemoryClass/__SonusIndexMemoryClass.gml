function __SonusIndexMemoryClass(_name, _snd) : __SonusIndexClass(_name, _snd) constructor {
	__type = SonusIndexType.MEMORY;
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
		var _filePath = __filePath;
		if (!file_exists(_filePath)) {
			__SonusTrace("File " + _filePath + " doesn't exist!");
			exit;	
		}
		
		if (__compression) {
			__buffer = buffer_decompress(__compressedBuffer);
			buffer_delete(__compressedBuffer);
		} else {
			if (__asyncLoading) {
				var _inst = __SonusSystem();
				array_push(_inst.__soundsAsyncQueue, new __SonusAsyncClass(self));
				__isReady = false;
				return undefined;
			} else {
				var _buff = buffer_load(_filePath);
				__HandleWav(_buff);
			}
		}
		
		__sndIndex = __SonusBufferToAudio(__buffer);
		__isReady = true;
		__isLoaded = true;
	}
	
	static __HandleWav = function(_buff) {
		__buffer = buffer_create(buffer_get_size(_buff), buffer_fixed, 1);
		buffer_copy(_buff, 0, buffer_get_size(_buff), __buffer, 0);
		buffer_delete(_buff);
		
		if (__SONUS_AUTO_COMPRESS_WAV) && (buffer_get_size(__buffer) > __SONUS_AUTO_COMPRESS_SIZE) {
			__compression = true;	
		}	
	}
}