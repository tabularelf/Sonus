function SonusSetMaxAudioInsts(_size) {
	static _inst = __SonusSystem();
	_inst.__channelNum = _size;
	audio_channel_num(_size);
}