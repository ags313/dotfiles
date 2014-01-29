#!/bin/bash

mkdir -p $opt/tools

function installSingleMaven
{
	if [ -e "$1" ]
	then 
		return 0
	fi		
	
  archiveName=apache-maven-$1-bin.tar.gz
	binaryName=apache-maven-$1
  url=$2
	
	if [[ -d $opt/tools/$binaryName ]]
	then
		echo "maven $1 already installed"
		return 0
	fi

	echo "Installing Maven $1"
	if [[ ! -f $DOWNLOADS/dev/$archiveName ]]
	then
		wget $url -O $DOWNLOADS/dev/$archiveName
	fi
	
	tar xf $DOWNLOADS/dev/$archiveName
	mv $binaryName $opt/tools/
	echo "Maven $1 installed"
}

function setDefaultMaven
{
	if [ -e "$1" ]
	then 
		return 0
	fi
	mavenVersion="$1"

	installSingleMaven $mavenVersion

	if [[ ! -L $opt/tools/apache-maven ]]; then
		ln -s "$opt/tools/apache-maven-$mavenVersion" $opt/tools/apache-maven
	fi
	
	if [[ -L ~/.m2/repository ]]; then
		return 0
	fi
	
	if [[ ! -d ~/.m2/repository ]]; then
		echo "Creating ~/.m2/repostitory as a symlink to $opt/tools/maven-repo"
		mkdir ~/.m2
		mkdir $opt/tools/maven-repo
		ln -s $opt/tools/maven-repo ~/.m2/repository
	fi
}

function installCompletion
{
	pushd /tmp
	wget -b https://raw.github.com/juven/maven-bash-completion/master/bash_completion.bash
	safeInstall bash_completion.bash ~/bash/bash-maven.completion
	popd
}

# installSingleMaven 2.0.11
# installSingleMaven 2.2.1 http://www.us.apache.org/dist/maven/maven-2/2.2.1/binaries/apache-maven-2.2.1-bin.tar.gz
installSingleMaven 3.0.5 http://www.eu.apache.org/dist/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz
installSingleMaven 3.1.1 http://www.eu.apache.org/dist/maven/maven-3/3.1.1/binaries/apache-maven-3.1.1-bin.tar.gz
setDefaultMaven 3.1.1