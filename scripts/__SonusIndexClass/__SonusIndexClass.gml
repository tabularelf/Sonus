function __SonusIndexClass(_name, _snd) constructor {
	static __config = __SonusContainer().Config;
    __gain = 1;
    __pitch = 1;
    __priority = 0;
    __listenerMask = -1;
    __sndIndex = _snd;
    __isExternal = false;
	__isLoaded = false;
	__isLoading = false;
    __group = undefined;
    __type = SonusIndexType.UNKNOWN;
	__name = _name;
	__falloffMax = 0;
	__falloffRef = 0;
	__falloffFactor = 0;
	__filePath = "";
	__httpFilePath = "";
	__asyncLoading = false;
	__asyncByHTTP = false;
	__isHTTPLoading = false;
	__isReady = true;
	__currentSoundInsts = 0;
	
	static GetPlayCount = function() {
		return __currentSoundInsts;	
	}
    
    static Play = function(_offset = 0, _loops = false) {
		if (__isExternal) && (!IsAvailable()) {
			Load();	
		}
		
		if (!__isReady) return undefined;
		
		var _pitch = __GetPitch();
		
        var _gain = __GetGain();
		return __SonusAudioInst({
			sndIndex: __sndIndex,
			priority: __priority,
			loops: _loops,
			gain: _gain,
			offset: _offset,
			pitch: _pitch,
			listenerMask: __listenerMask,
			type: 0
		});
    }
	
	static PlayAt = function(_x, _y, _z, _offset = 0, _loops = false, _priority = __priority, _falloffRef = __falloffRef, _falloffMax = __falloffMax, _falloffFactor = __falloffFactor) {
		if (__isExternal) && (!IsAvailable()) {
			Load();	
		}
		if (!__isReady) return undefined;
		
		var _pitch = __GetPitch();

        var _gain = __GetGain();
		//return __SonusAudioInst(audio_play_sound_at(__sndIndex, _x, _y, _z, _falloffRef, _falloffMax, _falloffFactor, _loops, __priority, _gain, _offset, _pitch, __listenerMask));
		return __SonusAudioInst({
			sndIndex: __sndIndex,
			priority: _priority,
			loops: _loops,
			gain: _gain,
			offset: _offset,
			pitch: _pitch,
			listenerMask: __listenerMask,
			x: _x,
			y: _y,
			z: _z,
			fallOffRef: _falloffRef,
			fallOffMax: _falloffMax,
			fallOffFactor: _falloffFactor,
			type: 1
		});
   }
   
   static PlayOn = function(_emitter, _offset = 0, _priority = -1, _loops = false) {
		if (__isExternal) && (!IsAvailable()) {
			Load();	
		}
		
		if (!__isReady) return undefined;
		
		var _pitch = __GetGain(_emitter.__pitch);
        var _gain = __GetGain(_emitter.__gain);
		return __SonusAudioInst({
			sndIndex: __sndIndex,
			priority: (_priority != -1 ? _priority : __priority),
			loops: _loops,
			gain: _gain,
			offset: _offset,
			pitch: _pitch,
			listenerMask: _emitter.__listenerMask,
			x: _emitter.__x,
			y: _emitter.__y,
			z: _emitter.__z,
			fallOffRef: _emitter.__fallOffRefDist,
			fallOffMax: _emitter.__fallOffMaxDist,
			fallOffFactor: _emitter.__fallOffFactor,
			type: 1
		}, self, _emitter);
   }
	
	static GetIndex = function() {
		if (__isExternal) {
			if (!__isLoaded) {
				Load();	
			}
		}
		
		return __sndIndex;
	}
	
	static GetSoundCount = function() {
		return __currentSoundInsts;
	}
		
	static GetLength = function() {
		return __isLoaded ? audio_sound_length(__sndIndex) : 0;	
	}
	
	static IsLoaded = function() {
		return __isLoaded;
	}
	
	static __HandleUnload = function() {
		__SonusError("__HandleUnload() Is not declared!");	
	}
	
	static __HandleLoad = function() {
		__SonusError("__HandleLoad() Is not declared!");	
	}
	
	static Unload = function(_force = false) {
		if (!__isExternal) || (!__isReady) || (!__isLoaded) {
			return self;
		}
		
		if (_force) {
			Stop();
			__HandleUnload();
			__isLoaded = false;
			__currentSoundInsts = 0;
			return self;
		} 
		
		var _inst = __SonusSystem();
		array_push(_inst.__soundsUnloadQueue, self);
		return self;
	}
	
	static Load = function() {
		if (!__isExternal) || (__isLoaded) || (__isLoading) || (__isHTTPLoading) {
			return self;
		}
		
		__isLoading = true;
		__HandleLoad();
		return self;
	}
    
    static Stop = function() {
        audio_stop_sound(__sndIndex);
		__currentSoundInsts = 0;
        return self;
    }
    
    static SetGain = function(_num, _time = 0) {
        __gain = _num;    
		if (__isLoaded) {
			audio_sound_gain(__sndIndex, _num, _time);	
		}
        return self;
    }
    
    static SetPitch = function(_num) {
        __pitch = _num;    
		if (__isLoaded) {
			audio_sound_pitch(__sndIndex, _num);	
		}
        return self;
    }
	
	static SetPitchRange = function(_num1, _num2) {
        __pitch = [_num1, _num2];    
		if (__isLoaded) {
			audio_sound_pitch(__sndIndex, random_range(_num1, _num2));	
		}
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
	
	static IsPlaying = function() {
		return (IsAvailable() && audio_is_playing(__sndIndex));
	}
	
	static IsAvailable = function() {
		return (__isLoaded) && (__isReady);	
	}
		
	static GetGain = function(_main = false) {
		return (_main) ? __gain : __GetGain();	
	}
	
	static GetPitch = function(_main = false) {
		return (_main) ? __pitch : __GetPitch();	
	}
	
	static __GetGain = function(_gain = 1) {
		var _newGain = _gain * __gain;
		if (__group != undefined) {
			var _currentGroup = __group;
			while(_currentGroup != undefined) {
				_newGain *= _currentGroup.__gain;
				_currentGroup = _currentGroup.__parent;
			}
		}
		return _newGain;
	}
	
	static __GetPitchArray = function(_pitch1, _pitch2) {
		var _newPitch = [0, 0];
		_newPitch[0] = (is_array(_pitch1) ? _pitch1[0] : _pitch1) * (is_array(_pitch2) ? _pitch2[0] : _pitch2);
		_newPitch[1] = (is_array(_pitch1) ? _pitch1[1] : _pitch1) * (is_array(_pitch2) ? _pitch2[1] : _pitch2);
		return _newPitch;
	}
	
	static __GetPitch = function(_pitch = 1) {
		var _newPitch;
		if (is_array(_pitch) || is_array(__pitch)) {
			_newPitch = __GetPitchArray(_pitch, __pitch);
		} else {
			_newPitch = __pitch * _pitch;	
		}
		
		if (__group != undefined) {
			var _currentGroup = __group;
			while(_currentGroup != undefined) {
				if (is_array(_newPitch) || is_array(_currentGroup.__pitch)) {
					_newPitch = __GetPitchArray(_newPitch, _currentGroup.__pitch);
				} else {
					_newPitch *= _currentGroup.__pitch;	
				}
				_currentGroup = _currentGroup.__parent;
			}
		}
		return _newPitch;
	}
	
	static toString = function() {
		return __name;	
	}
}