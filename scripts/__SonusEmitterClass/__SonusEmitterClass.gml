// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function __SonusEmitterClass(_x, _y, _z, _fallOffRefDist, _fallOffMaxDist, _fallOffFactor) constructor {
	static _inst = __SonusSystem();
	__emitterList = [];
	__listenerMask = 1;
	__gain = 1;
	__pitch = 1;
	__fallOffRefDist = _fallOffRefDist;
	__fallOffMaxDist = _fallOffMaxDist;
	__fallOffFactor = _fallOffFactor;
	__x = _x;
	__y = _y;
	__z = _z;
	__vx = 0;
	__vy = 0;
	__vz = 0;
	__bus = undefined;

	//static Play = function(_snd, _loops = false, _priority = -1, _offset = 0, _listenerMask = __listenerMask) {
	//	var _sndIndex;
	//	var _sndInst = is_string(_snd) ? Sonus.Get(_snd) : _snd;
	//	if (SonusIsSonusIndex(_sndInst)) {
	//				if (_sndInst.__isExternal) && (!_sndInst.IsAvailable()) {
	//					_sndInst.Load();	
	//				}
	//			
	//				if (!_sndInst.__isReady) return undefined;
	//				_sndIndex = _sndInst.GetIndex();
	//	} else {
	//		return undefined;	
	//	}
	//	
	//	var _group = _sndInst.__group;
	//	var _pitch = (is_array(__pitch) ? random_range(__pitch[0], __pitch[1]) : __pitch) * (is_array(_sndInst.__pitch) ? random_range(_sndInst.__pitch[0], _sndInst.__pitch[1]) : _sndInst.__pitch) * (!is_undefined(_group) ? 
	//	(is_array(_group.__pitch) ? random_range(_group.__pitch[0], _group.__pitch[1]) : _group.__pitch) : 1);
	//	
    //    var _gain = __gain * _sndInst.__gain * (!is_undefined(_group) ? _group.__gain : 1);
	//	
	//	//return __SonusAudioInst(audio_play_sound_on(__emitter, _sndIndex, _loops, _priority ?? _snd.__priority, _gain, _offset, _pitch, _listenerMask), _snd);
	//	return __SonusAudioInst({
	//		sndIndex: _sndIndex,
	//		priority: (_priority != -1 ? _priority : _sndInst.__priority),
	//		loops: _loops,
	//		gain: _gain,
	//		offset: _offset,
	//		pitch: _pitch,
	//		listenerMask: _listenerMask,
	//		x: __x,
	//		y: __y,
	//		z: __z,
	//		fallOffRef: __fallOffRefDist,
	//		fallOffMax: __fallOffMaxDist,
	//		fallOffFactor: __fallOffFactor,
	//		type: 1
	//	}, _sndInst, self);
	//}
	
	static SetPosition = function(_x = __x, _y = __y, _z = __z) {
		__x = _x;
		__y = _y;
		__z = _z;
		if (array_length(__emitterList) > 0) {
			var _i = 0;
			repeat(array_length(__emitterList)) {
				audio_emitter_position(__emitterList[_i].__emitter, _x, _y, _z);
				++_i;
			}
		}
		return self;
	}
	
	static SetFallOff = function(_fallOffRefDist, _fallOffMaxDist, _fallOffFactor) {
		audio_emitter_falloff(__emitter, _fallOffRefDist, _fallOffMaxDist, _fallOffFactor);
		return self;
	}
	
	static SetVelocity = function(_vx = __vx, _vy = __vy, _vz = __vz) {
		__vx = _vx;
		__vy = _vy;
		__vz = _vz;
		if (array_length(__emitterList) > 0) {
			var _i = 0;
			repeat(array_length(__emitterList)) {
				audio_emitter_velocity(__emitterList[_i].__emitter, _vx, _vy, _vz);
				++_i;
			}
		}
		return self;
	}
	
	static SetPitch = function(_num) {
		__pitch = _num;
		if (array_length(__emitterList) > 0) {
			var _i = 0;
			repeat(array_length(__emitterList)) {
				audio_emitter_pitch(__emitterList[_i].__emitter, _num);
				++_i;
			}
		}
		return self;
	}
	
	static SetPitchRange = function(_num1, _num2) {
		__pitch = [_num1, _num2];
		if (array_length(__emitterList) > 0) {
			var _i = 0;
			repeat(array_length(__emitterList)) {
				audio_emitter_pitch(__emitterList[_i].__emitter, random_range(_num1, _num2));
				++_i;
			}
		}
		return self;
	}
	
	static SetGain = function(_num) {
		__gain = _num;
		if (array_length(__emitterList) > 0) {
			var _i = 0;
			repeat(array_length(__emitterList)) {
				audio_emitter_gain(__emitterList[_i].__emitter, __emitterList[_i].__parent.__GetGain(_num));
				++_i;
			}
		}
		return self;
	}
	
	static StopAll = function() {
		if (array_length(__emitterList) > 0) {
			var _i = 0;
			repeat(array_length(__emitterList)) {
				__emitterList[_i].Stop();
				++_i;
			}
		}
	}
	
	static SetEffect = function(_pos, _effectType, _params = undefined) {
		if (__bus == undefined) __bus = audio_bus_create();
		var _effect = (_effectType != undefined) ? audio_effect_create(_effectType, _params != undefined ? _params : {}) : _effectType;
		__bus.effects[_pos] = _effect;	
	}
	
	static ResetEffects = function() {
		__bus = undefined;
	}
}