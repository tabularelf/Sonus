function __SonusAudioInst(_snd, _index = self, _otherEmitter = undefined) {
	static _inst = __SonusSystem();
	if (ds_list_size(_inst.__soundsUnusedList) > 0) {
		var _result = _inst.__soundsUnusedList[| 0];
		ds_list_delete(_inst.__soundsUnusedList, 0);
		ds_list_add(_inst.__soundsPlayingList, _result);
		_result.__Rebind(_snd, _index, _otherEmitter);
		++_index.__currentSoundInsts;
		return _result;
	}
	
	var _newInst = new __SonusAudioInstClass(_snd, _index, _otherEmitter);
	ds_list_add(_inst.__soundsPlayingList, _newInst);
	++_index.__currentSoundInsts;
	return _newInst;
}