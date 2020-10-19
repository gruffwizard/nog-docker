#!/bin/bash
echo "Nog Runner"
echo "Current Dir :$PWD"
echo "Maven       :$M2_HOME"

case "$1" in

edit)
  cd /home/nog/tools/theia && yarn start /home/nog/src  &
  ;;
dev)
  mvn compile quarkus:dev
  ;;
quickstart)
  echo "quickstart" $2
  ;;
esac
