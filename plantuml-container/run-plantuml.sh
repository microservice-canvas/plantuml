#! /bin/bash -e

cat > input.txt && java -Djava.awt.headless=true  -jar *.jar input.txt

if [ -z "$LEGEND" ] ; then
  cat input.png
  exit 0
fi

convert -append input.png ./legends/$LEGEND.png out.png

cat out.png
