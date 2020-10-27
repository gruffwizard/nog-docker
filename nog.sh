#!/bin/bash

verbose=false
ide=false

src="/home/nog/src"

echo -e "\e[97mNog Runner\e[39m"

if [[ ! -z "${NOG_VERBOSE}" ]]; then
  verbose=true
fi

if $verbose; then
    printenv
    git --version
fi


if [[ ! -z "${NOG_QUICKSTART}" ]]; then
  quickstart=${NOG_QUICKSTART}

  if [ ! -d /home/nog/quarkus-quickstarts ]; then
    echo -e "\e[31mmain quickstart directory not present\e[0m"
    exit -1
  fi

  # check to see if there is a .git repo present
  # if not shallow clone the quick starts

  if [ ! -d /home/nog/quarkus-quickstarts/.git ]; then
     cd ~/quarkus-quickstarts/ && git clone --depth 1 https://github.com/quarkusio/quarkus-quickstarts .
  fi

  if [ ! -d /home/nog/quarkus-quickstarts/$quickstart ]; then
    echo -e "\e[31mquickstart sample $quickstart is not present\e[0m"
    exit -1
  fi

  # copy over the specified quickstart into a subdir of src

  cp -r /home/nog/quarkus-quickstarts/$quickstart $src/$quickstart
  src=$src/$quickstart

fi

if [[ -z "${NOG_QUICKSTART_ONLY}" ]]; then

  if [[ ! -z "${NOG_START_IDE}" ]]; then
    cd /home/nog/tools/theia && yarn start $src  &
  fi

  cd $src

  if [ ! -f "./pom.xml" ]; then
    echo  -e "\e[31mno pom.xml file present\e[0m"
    exit -1
  fi

  mvn compile quarkus:dev

fi
