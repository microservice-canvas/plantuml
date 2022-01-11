#! /bin/bash -e

cat > input.txt && java -jar *.jar  -Djava.awt.headless=true input.txt

if [ -z "$LEGEND" ] ; then
  cat output.png
  exit 0
fi

convert -append output.png ./legends/$LEGEND.png out.png

cat out.png
