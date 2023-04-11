function SonusPrefillPool(_size = undefined) {
	var _inst = __SonusSystem();
	repeat(_size ?? _inst.__channelNum) {
		ds_list_add(_inst.__soundsUnusedList, new __SonusAudioInstClass(undefined, undefined));
	}
}