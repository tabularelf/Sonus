function __SonusAudioInstClass(_snd, _index, _otherEmitter = undefined) constructor {
	static _inst = __SonusSystem();
	__emitter = audio_emitter_create();	
	__parentEmitter = undefined;
	__parent = undefined;
	__gain = 1;
	__pitch = 1;
	__tempBus = undefined;
	__Rebind(_snd, _index, _otherEmitter);
	
	static __Rebind = function(_snd, _index, _otherEmitter = undefined) {
		if (_snd != undefined) {
			__gain = _snd.gain;
			__pitch = _snd.pitch;
			__listenerMask = _snd.listenerMask;
			if (_index.__group != undefined) audio_emitter_bus(__emitter, _index.__group.__bus);
				
			if (_otherEmitter != undefined) {
				// Enable Syncing
				array_push(_otherEmitter.__emitterList, self);
				__parentEmitter = _otherEmitter;
				
				// Apply audio buses
				if (_otherEmitter.__bus != undefined && (_index.__group != undefined)) {
					// Create temp bus
					var _bus = audio_bus_create();
					__tempBus = _bus;
					audio_emitter_bus(__emitter, _bus);	
					
					// Copy data over
					var _i = 0;
					repeat(array_length(_bus.effects)) {
						_bus.effects[_i] = _otherEmitter.__bus.effects[_i];
						++_i;
					}
					
					_i = 0;
					var _lastEffectPos = 0;
					repeat(array_length(_bus.effects)) {
						if (_bus.effects[_i] == undefined) _bus.effects[_i] = _index.__group.__bus.effects[_lastEffectPos++];
						++_i;
					}	
				} else if (_otherEmitter.__bus != undefined) {
					audio_emitter_bus(__emitter, _otherEmitter.__bus);	
				} 
			}
			
			if (_snd.type == 0) {
				//if (_index.__group.__bus != undefined) {
				__sndIndex = audio_play_sound_on(__emitter, _snd.sndIndex, _snd.loops, _snd.priority, _snd.gain, _snd.offset, _snd.pitch, _snd.listenerMask);
				/*} else {
					__sndIndex = audio_play_sound(_snd.sndIndex, _snd.priority, _snd.loops, _snd.gain, _snd.offset, _snd.pitch, _snd.listenerMask);	
				}*/
			}
			
			if (_snd.type == 1) {
				//if (__emitter != undefined) {
				audio_emitter_position(__emitter, _snd.x, _snd.y, _snd.z);
				audio_emitter_falloff(__emitter, _snd.fallOffRef, _snd.fallOffMax, _snd.fallOffFactor);
				__sndIndex = audio_play_sound_on(__emitter, _snd.sndIndex, _snd.loops, _snd.priority, _snd.gain, _snd.offset, _snd.pitch, _snd.listenerMask);
				/*} else {
					__sndIndex = audio_play_sound_at(_snd.sndIndex, _snd.x, _snd.y, _snd.z, _snd.falloffRef, _snd.falloffMax, _snd.falloffFactor, _snd.priority, _snd.loops, _snd.gain, _snd.offset, _snd.pitch, _snd.listenerMask);	
				}*/
			}
			
			__parent = _index;	
			if (!is_undefined(_index)) {
				if (!is_undefined(_index.__group)) {
					array_push(_index.__group.__currentPlayingSoundsList, self);	
				}
			}	
		}
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
		var _gain = __parent.__GetGain(_num);
		audio_sound_gain(__sndIndex, _gain, _time);
		return self;
	}
	
	static SetPitch = function(_num) {
		__pitch = _num;
		audio_sound_pitch(__sndIndex, _num);
		return self;
	}
}