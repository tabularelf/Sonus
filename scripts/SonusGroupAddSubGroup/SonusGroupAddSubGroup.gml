function SonusGroupAddSubGroup(_groupName, _subGroup) {
	static _inst = __SonusSystem();
	if (!SonusGroupExists(_subGroup)) {
		_inst.__soundsGroup[$ _subGroup] = new __SonusGroupClass(_subGroup);
	}
	
	array_push(_inst.__soundsGroup[$ _groupName].__subGroupList, _subGroup);
}