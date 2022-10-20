function __SonusAudioInstClass(_snd, _index = other) constructor {
	static _inst = __SonusSystem();
	__sndIndex = _snd;
	__gain = audio_sound_get_gain(_snd);
	__pitch = audio_sound_get_pitch(_snd);
	__listenerMask = audio_sound_get_listener_mask(_snd);
	__parent = _index;
	
	static Rebind = function(_snd, _index = other) {
		__sndIndex = _snd;
		__gain = audio_sound_get_gain(_snd);
		__pitch = audio_sound_get_pitch(_snd);
		__listenerMask = audio_sound_get_listener_mask(_snd);
		__parent = _index;	
		return self;
	}
	
	static Stop = function() {
		audio_stop_sound(__sndIndex);
		return self;
	}
	
	static Pause = function() {
		audio_pause_sound(__sndIndex);	
		return self;
	}
	
	static Resume = function() {
		audio_resume_sound(__sndIndex);	
		return self;
	}
	
	static SetGain = function(_num, _time = 0) {
		__gain = _num;
		audio_sound_gain(__sndIndex, _num, _time);
		return self;
	}
	
	static SetPitch = function(_num) {
		__pitch = _num;
		audio_sound_pitch(__sndIndex, _num);
		return self;
	}
}