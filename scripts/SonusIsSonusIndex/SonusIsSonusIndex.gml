function SonusIsSonusIndex(_struct) {
	if (is_struct(_struct)) {
		var _type = instanceof(_struct);
		return (_type == "__SonusIndexMemoryClass") || (_type == "__SonusIndexStreamClass");	
	}
	return false;
}