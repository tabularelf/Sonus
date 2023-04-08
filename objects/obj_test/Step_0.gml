if (!Sonus.ui_popup.IsPlaying()) {
	Sonus.ui_popup.GetRandomIndex().Play();
}

if (keyboard_check_released(vk_space)) {
	audio_stop_all();
	SonusClearPool();
}