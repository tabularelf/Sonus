function __SonusIndexClass(_name, _snd) constructor {
    __gain = 1;
    __pitch = 1;
    __priority = 0;
    __listenerMask = -1;
    __sndIndex = _snd;
    __isExternal = false;
	__isLoaded = false;
    __group = undefined;
    __type = SonusIndexType.UNKNOWN;
	__name = _name;
	__falloffMax = 0;
	__falloffRef = 0;
	__falloffFactor = 0;
	__filePath = "";
	__asyncLoading = false;
	__asyncFilePath = "";
	__isReady = true;
    
    static Play = function(_offset = 0, _loops = false) {
		if (!__isReady) {
			return -1;
		}	
		
		if (__isExternal) && (!__isLoaded) {
			Load();	
		}
		
		var _pitch = (is_array(__pitch) ? random_range(__pitch[0], __pitch[1]) : __pitch) * (!is_undefined(__group) ? 
		(is_array(__group.__pitch) ? random_range(__group.__pitch[0], __group.__pitch[1]) : __group.__pitch) : 1);
		
        var _gain = __gain * (!is_undefined(__group) ? __group.__gain : 1);
		return audio_play_sound(__sndIndex, __priority, _loops, _gain, _offset, _pitch, __listenerMask);
    }
	
	static PlayAt = function(_x, _y, _z, _offset = 0, _loops = false, _falloffRef = __falloffRef, _falloffMax = __falloffMax, _falloffFactor = __falloffFactor) {
		if (!__isReady) return -1;
		
		if (__isExternal) && (!__isLoaded) {
			Load();	
		}

		var _pitch = (is_array(__pitch) ? random_range(__pitch[0], __pitch[1]) : __pitch) * (!is_undefined(__group) ? 
		(is_array(__group.__pitch) ? random_range(__group.__pitch[0], __group.__pitch[1]) : __group.__pitch) : 1);
		
        var _gain = __gain * (!is_undefined(__group) ? __group.__gain : 1);
		return audio_play_sound_at(__sndIndex, _x, _y, _z, _falloffRef, _falloffMax, _falloffFactor, _loops, __priority, _gain, _offset, _pitch, __listenerMask);
    }
	
	static GetIndex = function() {
		if (__isExternal) {
			if (!__isLoaded) {
				Load();	
			}
		}
		
		return __sndIndex;
	}
	
	static IsLoaded = function() {
		return __isLoaded();
	}
	
	static __HandleUnload = function() {
		__SonusError("__HandleUnload() Is not declared!");	
	}
	
	static __HandleLoad = function() {
		__SonusError("__HandleLoad() Is not declared!");	
	}
	
	static Unload = function(_force = false) {
		if (!__isExternal) {
			__SonusError(__name + " is not an external sound!", true);
			return self;
		}
		
		if (_force) {
			audio_stop_sound(__sndIndex);
			__HandleUnload();
			__isLoaded = false;
		} else {
			var _inst = __SonusSystem();
			array_push(_inst.__soundsUnloadQueue, self);
		}
		return self;
	}
	
	static Load = function() {
		if (!__isExternal) {
			__SonusError(__name + " is not an external sound!", true);
			return self;
		}
		
		__HandleLoad();
		return self;
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
	
	static __IsPlaying = function() {
		return audio_is_playing(__sndIndex);
	}
	
	static toString = function() {
		return __name;	
	}
}