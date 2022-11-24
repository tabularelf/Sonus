// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function __SonusEmitterClass(_x, _y, _z, _fallOffRefDist, _fallOffMaxDist, _fallOffFactor) constructor {
	static _inst = __SonusSystem();
	__emitter = audio_emitter_create();
	__listenerMask = 1;
	__gain = 1;
	__pitch = 1;
	__fallOffResDist = _fallOffRefDist;
	__fallOffMaxDist = _fallOffMaxDist;
	__fallOffFactor = _fallOffFactor;
	__x = _x;
	__y = _y;
	__z = _z;
	__vx = 0;
	__vy = 0;
	__vz = 0;
	__bus = undefined;
	ds_list_add(_inst.__emitterList, [weak_ref_create(self), __emitter]);

	static Play = function(_snd, _loops = false, _priority = undefined, _offset = 0, _listenerMask = __listenerMask) {
		var _sndIndex;
		if (SonusIsSonusIndex(_snd)) {
					if (_snd.__isExternal) && (!_snd.IsAvailable()) {
						_snd.Load();	
					}
				
					if (!_snd.__isReady) return undefined;
					_sndIndex = _snd.GetIndex();
		} else {
			return;	
		}
		
		var _group = _snd.__group;
		var _pitch = (is_array(__pitch) ? random_range(__pitch[0], __pitch[1]) : __pitch) * (is_array(_snd.__pitch) ? random_range(_snd.__pitch[0], _snd.__pitch[1]) : _snd.__pitch) * (!is_undefined(_group) ? 
		(is_array(_group.__pitch) ? random_range(_group.__pitch[0], _group.__pitch[1]) : _group.__pitch) : 1);
		
        var _gain = __gain * _snd.__gain * (!is_undefined(_group) ? _group.__gain : 1);
		
		return __SonusAudioInst(audio_play_sound_on(__emitter, _sndIndex, _loops, _priority ?? _snd.__priority, _gain, _offset, _pitch, _listenerMask), _snd);	
	}
	
	static SetPosition = function(_x = __x, _y = __y, _z = __z) {
		__x = _x;
		__y = _y;
		__z = _z;
		audio_emitter_position(__emitter, _x, _y, _z);
		return self;
	}
	
	static SetFallOff = function(_fallOffRefDist, _fallOffMaxDist, _fallOffFactor) {
		audio_emitter_falloff(__emitter, _fallOffRefDist, _fallOffMaxDist, _fallOffFactor);
		return self;
	}
	
	static SetBus = function(_bus) {
		static _inst = __SonusSystem();
		if (_inst.__audioEffectsExist) {
			__bus = _bus;
			audio_emitter_bus(__emitter, _bus);
		}
		return self;	
	}
	
	static SetVelocity = function(_vx = __vx, _vy = __vy, _vz = __vz) {
		__vx = _vx;
		__vy = _vy;
		__vz = _vz;
		audio_emitter_velocity(__emitter, _vx, _vy, _vz);	
		return self;
	}
	
	static SetPitch = function(_num) {
		__pitch = _num;
		audio_emitter_pitch(__emitter, _num);
		return self;
	}
	
	static SetPitchRange = function(_num1, _num2) {
		__pitch = [_num1, _num2];
		audio_emitter_pitch(__emitter, random_range(_num1, _num2));
		return self;
	}
	
	static SetGain = function(_num) {
		__gain = _num;
		audio_emitter_gain(__emitter, _num);
		return self;
	}
	
	static GetIndex = function() {
		return __emitter;	
	}
	
	static Destroy = function() {
		audio_emitter_free(__emitter);
		__emitter = -1;
	}
}