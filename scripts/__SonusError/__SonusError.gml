function __SonusError(_str, _logOnly = false) {
	if (!_logOnly) {
		show_error("Sonus Error: " + _str, true);	
	} else {
		show_debug_message("Sonus Error: " + _str);
	}
}