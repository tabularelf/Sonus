function __SonusEmitterClass(_x, _y, _z, _fallOffRefDist, _fallOffMaxDist, _fallOffFactor) constructor {
	static _inst = __SonusSystem();
	__audioInstList = ds_list_create();
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
	ds_list_add(_inst.__emitterList, [
		weak_ref_create(self),
		__audioInstList
	]);
	
	static GetPlayCount = function() {
		return ds_list_size(__audioInstList);	
	}

	
	static SetPosition = function(_x = __x, _y = __y, _z = __z) {
		__x = _x;
		__y = _y;
		__z = _z;
		var _i = 0;
		repeat(ds_list_size(__audioInstList)) {
			audio_emitter_position(__audioInstList[| _i].__emitter, _x, _y, _z);
			++_i;
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
		var _i = 0;
		repeat(ds_list_size(__audioInstList)) {
			audio_emitter_velocity(__audioInstList[| _i].__emitter, _vx, _vy, _vz);
			++_i;
		}
		return self;
	}
	
	static SetPitch = function(_num) {
		__pitch = _num;
		var _i = 0;
		repeat(ds_list_size(__audioInstList)) {
			audio_emitter_pitch(__audioInstList[| _i].__emitter, _num);
			++_i;
		}
		return self;
	}
	
	static SetPitchRange = function(_num1, _num2) {
		__pitch = [_num1, _num2];
		var _i = 0;
		repeat(ds_list_size(__audioInstList)) {
			audio_emitter_pitch(__audioInstList[| _i].__emitter, mean(_num1, _num2));
			++_i;
		}
		return self;
	}
	
	static SetGain = function(_num) {
		__gain = _num;
		var _i = 0;
		repeat(ds_list_size(__audioInstList)) {
			audio_emitter_gain(__audioInstList[| _i].__emitter, __audioInstList[_i].__parent.__GetGain(_num));
			++_i;
		}
		return self;
	}
	
	static StopAll = function() {
		if (ds_list_size(__audioInstList) > 0) {
			var _i = 0;
			repeat(ds_list_size(__audioInstList)) {
				__audioInstList[| _i].Stop();
				++_i;
			}
		}
	}
	
	static SetEffect = function(_pos, _effectType, _params = undefined) {
		if (__bus == undefined) __bus = audio_bus_create();
		var _effect = (_effectType != undefined) ? audio_effect_create(_effectType, _params != undefined ? _params : {}) : _effectType;
		__bus.effects[_pos] = _effect;	
		var _i = 0;
		repeat(ds_list_size(__audioInstList)) {
			__audioInstList[| _i].__ApplyEffectBus(__audioInstList[| _i].__parent, self);
			++_i;
		}
	}
	
	static ApplyEffect = function(_pos, _effect) {
		if (__bus == undefined) __bus = audio_bus_create();
		__bus.effects[_pos] = _effect;	
		var _i = 0;
		repeat(ds_list_size(__currentPlayingSoundsList)) {
			__audioInstList[| _i].__ApplyEffectBus(__currentPlayingSoundsList[| _i].__parent, self);
			++_i;
		}		
	}
	
	static GetEffect = function(_pos) {
		return __bus != undefined ? __bus.effects[_pos] : undefined;
	}
	
	static ResetEffects = function() {
		__bus = undefined;
		var _i = 0;
		repeat(ds_list_size(__audioInstList)) {
			__audioInstList[| _i].__ApplyEffectBus(__audioInstList[| _i].__parent, self);
			++_i;
		}
	}
}