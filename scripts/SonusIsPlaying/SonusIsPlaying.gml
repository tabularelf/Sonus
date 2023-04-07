function SonusIsPlaying(_id) {
	if (SonusIsSonusGroup(_id)) {
		return __SonusGroupIsPlaying(_id);
	}
	
	if (SonusIsSonusIndex(_id)) {
		return __SonusIndexIsPlaying(_id);	
	}
	
	// Check for string
	if (SonusIndexExists(_id)) {
		return __SonusIndexIsPlaying(SonusIndexGet(_id));
	}
	
	if (SonusGroupExists(_id)) {
		return SonusIsSonusGroup(SonusGroupGet(_id));
	}
	
	return false;
}