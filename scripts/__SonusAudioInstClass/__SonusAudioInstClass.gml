function __SonusAudioInstClass(_snd, _index, _otherEmitter = undefined) constructor {
	static _inst = __SonusSystem();
	static _listener = _inst.__listener;
	__emitter = audio_emitter_create();	
	audio_emitter_velocity(__emitter, 0, 0, 0);
	audio_emitter_position(__emitter, 0, 0, 0);
	audio_emitter_falloff(__emitter, 0, 100, 1);
	__parentEmitter = undefined;
	__parent = undefined;
	__gain = 1;
	__pitch = 1;
	__tempBus = undefined;
	__listenerMask = -1;
	__hasAudioBus = false;
	__followListener = false;
	__length = -1;
	__Rebound(_snd, _index, _otherEmitter);
	
	static __Rebound = function(_snd, _index, _otherEmitter = undefined) {
		if (_snd != undefined) {
			__gain = _snd.gain;
			__pitch = _snd.pitch;
			__listenerMask = _snd.listenerMask;
			
			// Enable Syncing
			if (_otherEmitter != undefined) {
				ds_list_add(_otherEmitter.__audioInstList, self);
				__parentEmitter = _otherEmitter	
			}
			
			__ApplyEffectBus(_index, _otherEmitter);
			
			if (_snd.type == 0) {
				if (__hasAudioBus) {
					__sndIndex = audio_play_sound_on(__emitter, _snd.sndIndex, _snd.loops, _snd.priority, _snd.gain, _snd.offset, _snd.pitch, _snd.listenerMask);
					__followListener = true;
					ds_list_add(_listener.__soundsPlayingList, self);
				} else {
					__sndIndex = audio_play_sound(_snd.sndIndex, _snd.priority, _snd.loops,	_snd.gain, _snd.offset, _snd.pitch, _snd.listenerMask);
				}
			}
			
			if (_snd.type == 1) {
				audio_emitter_position(__emitter, _snd.x, _snd.y, _snd.z);
				audio_emitter_falloff(__emitter, _snd.fallOffRef, _snd.fallOffMax, _snd.fallOffFactor);
				__sndIndex = audio_play_sound_on(__emitter, _snd.sndIndex, _snd.loops, _snd.priority, _snd.gain, _snd.offset, _snd.pitch, _snd.listenerMask);
			}
			
			__parent = _index;	
			if (!is_undefined(_index)) {
				if (!is_undefined(_index.__group)) {
					ds_list_add(_index.__group.__currentPlayingSoundsList, self);	
				}
			}	
		}
		__length = __parent != undefined ? __parent.GetLength() : -1;
		return self;
	}
	
	static __ApplyEffectBus = function(_index, _otherEmitter) {
		if (_index.__group != undefined) {
			audio_emitter_bus(__emitter, _index.__group.__bus);
			__hasAudioBus = true;
		}
				
		if (_otherEmitter != undefined) {
			// Apply audio buses
			if (_otherEmitter.__bus != undefined && (_index.__group != undefined)) {
				// Create temp bus
				var _bus = audio_bus_create();
				__tempBus = _bus;
				__hasAudioBus = true;
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
				__hasAudioBus = true;
			} 
		}	
	}
	
	static Stop = function() {
		audio_stop_sound(__sndIndex);
		return self;
	}
	
	static IsPlaying = function() {
		return audio_is_playing(__sndIndex);	
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
		audio_emitter_gain(__emitter, _num);
		audio_sound_gain(__sndIndex, _num, _time);
		return self;
	}
	
	static GetGain = function() {
		return __gain;	
	}
	
	static SetPitch = function(_num) {
		__pitch = _num;
		audio_sound_pitch(__sndIndex, _num);
		return self;
	}
	
	static SetPitchArray = function(_min, _max) {
		__pitch = mean(_min, _max);
		audio_sound_pitch(__sndIndex, __pitch);
		return self;
	}
	
	static GetLength = function() {
		return __length;	
	}
}