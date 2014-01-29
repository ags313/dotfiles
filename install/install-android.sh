#!/bin/bash

mkdir -p "$HOME/opt/sdk"
mkdir -p "$HOME/vcs/tools"

function install-android-sdk-linux
{
  arch=android-sdk_r22.3-linux.tgz
  wget -O "$DOWNLOADS/dev/${arch}" "http://dl.google.com/android/${arch}"
  tar xf "$DOWNLOADS/dev/${arch}"
  mv android-sdk-linux $opt/sdk/android-sdk-linux-r22
  ln -snf $opt/sdk/android-sdk-linux-r22 $opt/sdk/android-sdk

  sudo touch /etc/udev/rules.d/51-android.rules
  sudo chown $USER /etc/udev/rules.d/51-android.rules
  echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", MODE="0666", GROUP="plugdev"' >> /etc/udev/rules.d/51-android.rules
  echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0666", GROUP="plugdev"' >> /etc/udev/rules.d/51-android.rules
  sudo chown root /etc/udev/rules.d/51-android.rules
}

function install-android-sdk-osx
{
  arch=android-sdk_r22.3-macosx.zip
  wget -O $DOWNLOADS/dev/${arch} http://dl.google.com/android/${arch}
  unzip $DOWNLOADS/dev/${arch} -d $DOWNLOADS/dev
  mv -d $DOWNLOADS/dev/android-sdk-macosx $opt/sdk/android-sdk-macosx-r22
  ln -snf $opt/sdk/android-sdk-macosx-r22 $opt/sdk/android-sdk
}

function install-android-ndk-linux
{
  arch=android-ndk-r9c-linux-x86_64.tar.bz2
  wget -O $DOWNLOADS/dev/${arch} http://dl.google.com/android/ndk/${arch}
  tar xf $DOWNLOADS/dev/${arch}
  mv android-ndk-r9c $opt/sdk/android-ndk-linux-r9c
  ln -snf $opt/sdk/android-ndk-linux-r9c $opt/sdk/android-ndk
}

function install-android-ndk-osx
{
  arch=android-ndk-r9c-darwin-x86_64.tar.bz2
  wget -O $DOWNLOADS/dev/${arch} http://dl.google.com/android/ndk/${arch}
  tar xf $DOWNLOADS/dev/${arch}
  mv android-ndk-r9c $opt/sdk/android-ndk-r9c-macosx
  ln -snf $opt/sdk/android-ndk-linux-r8 $opt/sdk/android-ndk
}

function install-android-sdk
{
  if [[ -L "$opt/sdk/android-sdk" ]]; then
    echo "  SDK is already installed"
    return 0;
  fi

  echo "Installing Android SDK"
  case $OSTYPE in
    darwin* )
      install-android-sdk-osx
    ;;
    linux* )
      install-android-sdk-linux
    ;;
    esac

  if [[ ! -L ~/bin/android ]]; then
    ln -s $opt/sdk/android-sdk/tools/android ~/bin/android
  fi
}

function install-android-ndk
{
  if [[ -L "$opt/sdk/android-ndk" ]]; then
    echo "  NDK is already installed"
    return
  fi

  echo "Installing Android NDK"
  case $OSTYPE in
    darwin* )
      install-android-ndk-osx
    ;;
    linux* )
      install-android-ndk-linux
    ;;
  esac
}

function install-maven-android-sdk-deployer
{
  if [[ ! -d ~/vcs/misc/maven-android-sdk-deployer ]]; then
    git clone git://github.com/mosabua/maven-android-sdk-deployer.git ~/vcs/tools/maven-android-sdk-deployer
  fi
}

echo "Installing Android"
install-android-sdk
install-android-ndk
install-maven-android-sdk-deployer