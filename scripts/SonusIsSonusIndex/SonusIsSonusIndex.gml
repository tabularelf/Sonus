function SonusIsSonusIndex(_struct) {
	if (is_struct(_struct)) {
		return instanceof(_struct) == "__SonusIndexClass";	
	}
	return false;
}