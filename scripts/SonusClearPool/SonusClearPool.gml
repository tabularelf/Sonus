function SonusClearPool() {
	var _inst = __SonusSystem();
	ds_list_clear(_inst.__soundsUnusedList);
}