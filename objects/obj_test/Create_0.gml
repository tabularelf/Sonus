randomize();
snd = SonusIndexAdd("ui_menu_popup_message_04.ogg");
SonusGroupAddSound(snd, "ui_popup");
group = SonusGroupGet("ui_popup").SetPitchRange(.5,1);
snd = SonusIndexGetRandom("ui_popup");