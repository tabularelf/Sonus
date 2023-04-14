function SonusIsSonusIndex(_struct) {
	if (is_struct(_struct)) {
		return (is_instanceof(_struct, __SonusIndexClass)) || (is_instanceof(_struct, SonusIsSonusAudioInst));
	}
	return false;
}