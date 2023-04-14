function SonusIsSonusGroup(_struct) {
	if (is_struct(_struct)) {
		return is_instanceof(_struct, __SonusGroupClass);
	}
	return false;
}