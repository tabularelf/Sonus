function SonusGetMaxAudioInsts() {
	static _inst = __SonusSystem();
	return _inst.__channelNum;
}