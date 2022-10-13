function __SonusGroupClass(_name) constructor {
	__soundsMap = {};
	__soundsList = [];
	__name = _name;
	
	static AddEntry = function(_snd) {
		__soundsMap[$ _snd.__name] = _snd;
		array_push(__soundsList, _snd);
		_snd.__group = self;
		return self;
	}
}