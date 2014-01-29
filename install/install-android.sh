#!/bin/bash

mkdir -p ~/opt/sdk

function install-android-sdk-linux
{
  arch=android-sdk_r22.3-linux.tgz
  download $DOWNLOADS/${arch} http://dl.google.com/android/${arch}
  tar xf $DOWNLOADS/${arch}
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
  download $DOWNLOADS/${arch} http://dl.google.com/android/${arch}
  unzip $DOWNLOADS/${arch} -d $DOWNLOADS/dev
  mv -d $DOWNLOADS/dev/android-sdk-macosx $opt/sdk/android-sdk-macosx-r22
  ln -snf $opt/sdk/android-sdk-macosx-r22 $opt/sdk/android-sdk
}

function install-android-ndk-linux
{
  download $DOWNLOADS/android-ndk-r9c-linux-x86.tar.bz2 http://dl.google.com/android/ndk/android-ndk-r9c-linux-x86_64.tar.bz2
  tar xjf $DOWNLOADS/android-ndk-r9c-linux-x86.tar.bz2
  mv android-ndk-r9c $opt/sdk/android-ndk-linux-r9c
  ln -snf $opt/sdk/android-ndk-linux-r9c $opt/sdk/android-ndk
}

function install-android-ndk-osx
{
  download $DOWNLOADS/android-ndk-r8-darwin-x86.tar.bz2 http://dl.google.com/android/ndk/android-ndk-r8-darwin-x86.tar.bz2
  tar xjf $DOWNLOADS/android-ndk-r8-darwin-x86.tar.bz2
  mv android-ndk-r8 $opt/sdk/android-ndk-r8-macosx
  ln -snf $opt/sdk/android-ndk-linux-r8 $opt/sdk/android-ndk
}

function install-android-sdk
{
  echo 'export ANDROID_HOME=~/opt/sdk/android-sdk' >> ~/.bashrc
  echo "" >> ~/.bashrc
  
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
  
  for (( i = 0; i < 50; i++ )); do
    echo "" >> /tmp/input
  done

# $opt/sdk/android-sdk/tools/android -s update sdk --no-ui --obsolete --force < /tmp/input
}

function install-android-ndk
{
  echo 'export ANDROID_NDK_HOME=~/opt/sdk/android-sdk' >> ~/.bashrc
  echo "" >> ~/.bashrc 

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
  md ~/vcs/misc
  if [[ ! -d ~/vcs/misc/maven-android-sdk-deployer ]]; then
    git clone git://github.com/mosabua/maven-android-sdk-deployer.git ~/vcs/misc/maven-android-sdk-deployer
  fi
}

echo "Installing Android"
install-android-sdk
install-android-ndk
install-maven-android-sdk-deployer