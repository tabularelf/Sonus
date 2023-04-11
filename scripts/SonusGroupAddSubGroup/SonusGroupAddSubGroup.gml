function SonusGroupAddSubGroup(_groupName, _subGroup) {
	static _inst = __SonusSystem();
	if (!SonusGroupExists(_subGroup)) {
		SonusGroupAdd(_subGroup);
	}
	
	if (_inst.__soundsGroup[$ _subGroup].__parent != undefined) {
		var _i = 0;
		var _array = _inst.__soundsGroup[$ _groupName].__subGroupList;
		var _groupIndex = _inst.__soundsGroup[$ _subGroup];
		repeat(array_length(_array)) {
			if (_array[_i] == _groupIndex) {
				array_delete(_array, _i, 1);
				break;
			}
			++_i;
		}
	}
	
	array_push(_inst.__soundsGroup[$ _groupName].__subGroupList, _inst.__soundsGroup[$ _subGroup]);
	_inst.__soundsGroup[$ _subGroup].__parent = _inst.__soundsGroup[$ _groupName];
}