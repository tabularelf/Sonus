randomize();
show_debug_overlay(true);
Sonus.AddGroup("Master", "ui_popup");

Sonus.AddIndex([
	"ui_menu_popup_message_04.ogg",
	"ui_menu_popup_message_022.wav"
], "ui_popup");

Sonus.ui_popup.SetPitchRange(.5,1);
//Sonus.ui_popup.SetGain(.5);

emitter = SonusEmitter(0, 0, 0, 100, 512, 1);
//audio_falloff_set_model(audio_falloff_linear_distance);
//Sonus.SetListenerPos(room_width div 2, room_height div 2, 0);

Sonus.ui_popup.SetEffect(0, AudioEffectType.Reverb1, {
	size: .4,
	damp: .2,
	mix: .7
});

emitter.SetEffect(0, AudioEffectType.Bitcrusher, {
	factor: 20,
	resolution: 16,
	mix: .7
});