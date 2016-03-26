install:
	./configure 2> /dev/null
silent:
	./configure 2>&1>/dev/null
verbose:
	bash -x ./configure
sadiq:
	SETTINGS_FILE="settings.mine.sh" ./configure
