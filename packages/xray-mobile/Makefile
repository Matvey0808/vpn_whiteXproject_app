.PHONY: all android ios clean setup

ANDROID_OUT = ../../android/app/libs/xraymobile.aar
IOS_OUT = ../../ios/Xraymobile.xcframework
LDFLAGS = -ldflags="-s -w"

setup:
	go install golang.org/x/mobile/cmd/gomobile@latest
	gomobile init

android:
	gomobile bind -target=android -androidapi 21 $(LDFLAGS) -o $(ANDROID_OUT) .

ios:
	gomobile bind -target=ios $(LDFLAGS) -o $(IOS_OUT) .

all: android ios

clean:
	rm -f $(ANDROID_OUT)
	rm -f ../../android/app/libs/xraymobile-sources.jar
	rm -rf $(IOS_OUT)
