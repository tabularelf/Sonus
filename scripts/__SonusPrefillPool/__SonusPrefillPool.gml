function __SonusPrefillPool(_size = undefined) {
	static _inst = __SonusSystem();
	static _config = __SonusContainer().Config;
	repeat(_size ?? _config.maxChannelAudioInsts) {
		ds_list_add(_inst.__soundsUnusedList, new __SonusAudioInstClass(undefined, undefined));
	}
}