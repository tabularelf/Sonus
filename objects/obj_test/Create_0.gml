randomize();
show_debug_overlay(true);
//snd = SonusIndexAdd("fanfare60.wav", false, true);

/*SonusGroupAddSound(snd, "ui_popup");
snd = SonusIndexAdd("ui_menu_popup_message_04.ogg");
SonusGroupAddSound("ui_menu_popup_message_04", "ui_popup");
snd = SonusIndexAdd("ui_menu_popup_message_022.wav");
SonusGroupAddSound("ui_menu_popup_message_022", "ui_popup");
group = SonusGroupGet("ui_popup").SetPitchRange(1,2);
snd = SonusIndexGetRandom("ui_popup");*/

Sonus.AddIndex([
	"ui_menu_popup_message_04.ogg",
	"ui_menu_popup_message_022.wav"
], "ui_popup");

//Sonus.ui_popup.SetPitchRange(.5,1);

Sonus.ui_popup.SetEffect(0, AudioEffectType.Reverb1, {
	size: .2,
	damp: .2,
	mix: .7
});