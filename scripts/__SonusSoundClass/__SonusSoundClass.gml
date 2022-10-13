function __SonusSoundClass(_name, _snd) constructor {
    __gain = 1;
    __pitch = 1;
    __priority = 0;
    __listenerMask = -1;
    __sndIndex = _snd;
    __isExternal = false;
    __group = undefined;
    __type = SonusSoundType.UNKNOWN;
	__name = _name;
	__falloffMax = 0;
	__falloffRef = 0;
	__falloffFactor = 0;
    
    static Play = function(_offset = 0, _loops = false) {
		var _pitch = is_array(__pitch) ? random_range(__pitch[0], __pitch[1]) : __pitch;
        return audio_play_sound(__sndIndex, __priority, _loops, __gain, _offset, _pitch, __listenerMask);
    }
	
	static PlayAt = function(_x, _y, _z, _falloffRef = __falloffRef, _falloffMax = __falloffMax, _falloffFactor = __falloffFactor, ___offset = 0, _loops = false) {
		var _pitch = is_array(__pitch) ? random_range(__pitch[0], __pitch[1]) : __pitch;
		return audio_play_sound_at(__sndIndex, _x, _y, _z, _falloffRef, _falloffMax, _falloffFactor, _loops, __priority, __gain, _offset, _pitch, __listenerMask);
    }
    
    static Stop = function() {
        audio_stop_sound(__sndIndex);
        return self;
    }
    
    static SetGain = function(_num) {
        __gain = _num;    
        return self;
    }
    
    static SetPitch = function(_num) {
        __pitch = _num;    
        return self;
    }
	
	static SetPitchRange = function(_num1, _num2) {
        __pitch = [_num1, _num2];    
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
	
	static __isPlaying = function() {
		return audio_is_playing(__sndIndex);
	}
}