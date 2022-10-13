function SonusAsync() {
	static _inst = __SonusSystem();
	var _id = async_load[? "id"];
	var _status = async_load[? "status"];
	var _httpCode = async_load[? "http_status"];
	
	var _queue = _inst.__soundsAsyncQueue;
	var _i = 0;
	repeat(array_length(_queue)) {
		var _entry = _queue[_i];
		if (_entry.__id == _id) {
			if (_status == 0)  {
				if (_httpCode == 200) {
					_entry.__snd.__isReady = true;
				} else {
					__SonusTrace("File download failed from " + _entry.__snd.__filePath + ". Got HTTP Status Code " + string(_httpCode));	
					file_delete(_entry.__snd.__asyncFilePath);
				}
				
				array_delete(_queue, _i, 1);
				--_i;		
			}
		}
	}
}