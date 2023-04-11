function __SonusBufferRawToAudio(_buff, _bits_per_sample, _rate, _offset = 0, _length = buffer_get_size(_buff), _channel = 0) {		
	return audio_create_buffer_sound(_buff, _bits_per_sample, _rate, _offset, _length, _channel);
}