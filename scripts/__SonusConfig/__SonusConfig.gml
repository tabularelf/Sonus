/*
	Whether Sonus should auto compress wav files in memory whenever unloaded.
*/
#macro __SONUS_AUTO_COMPRESS_WAV true

/*
    Minimum size Sonus should auto compress wav files whenever they're unloaded (anything less than set here, will not compress).
    By default, that's 2MB or more.
*/

#macro __SONUS_AUTO_COMPRESS_SIZE 2097152