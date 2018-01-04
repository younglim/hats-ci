#!/bin/bash

echo "Browser Version Check"
echo

export CHROME_VERSION=$(defaults read /Applications/Google\ Chrome.app/Contents/Info.plist KSVersion)

export FIREFOX_VERSION=$(defaults read /Applications/Firefox.app/Contents/Info.plist CFBundleShortVersionString)

export SAFARI_VERSION=$(defaults read /Applications/Safari.app/Contents/Info.plist CFBundleShortVersionString)

echo "CHROME_VERSION=$CHROME_VERSION"
echo "FIREFOX_VERSION=$FIREFOX_VERSION"
echo "SAFARI_VERSION=$SAFARI_VERSION"
