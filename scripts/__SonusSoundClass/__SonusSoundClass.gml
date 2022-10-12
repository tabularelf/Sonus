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
    
    static Play = function(_offset = 0, _loops = false) {
        return audio_play_sound(__sndIndex, __priority, _loops, __gain, _offset, __pitch, __listenerMask);
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
}