function SonusIsSonusGroup(_struct) {
	if (is_struct(_struct)) {
		return instanceof(_struct) == "__SonusGroupClass";	
	}
	return false;
}