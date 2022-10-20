function SonusIsSonusAudioInst(_struct) {
	if (is_struct(_struct)) {
		return instanceof(_struct) == "__SonusAudioInstClass";	
	}
	return false;
}