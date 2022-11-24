/*
	Whether Sonus should auto compress wav files in memory whenever unloaded.
*/
#macro __SONUS_AUTO_COMPRESS_WAV true

/*
    Minimum size Sonus should auto compress wav files whenever they're unloaded (anything less than set here, will not compress).
    By default, that's 2MB or more.
*/

#macro __SONUS_AUTO_COMPRESS_SIZE 2097152

/*
	How long before the next cleanup time should start (In Frames)
*/

#macro __SONUS_PLAYING_CLEANUP_TIME 1

/*
	Max time allowed before the next cleanup time.
*/

#macro __SONUS_MAX_TIME_CLEANUP_MS 10000

/*
	Sets audio_channel_num() for you.
*/

#macro __SONUS_DEFAULT_MAX_CHANNEL_AUDIO_INSTS 128

/*
	Whether to auto prefill the pool or not.
*/

#macro __SONUS_AUTO_PREFILL_POOL true

/*
	How many to prefill the pool if set automatically. By default, this is set to 128.
*/

#macro __SONUS_AUTO_PREFILL_POOL_VALUE 128