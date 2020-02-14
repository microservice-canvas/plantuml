#! /bin/bash -e

cat > foo.txt && java -jar *.jar  -Djava.awt.headless=true foo.txt

if [ -z "$LEGEND" ] ; then
  cat foo.png
  exit 0
fi

convert -append foo.png ./legends/$LEGEND.png out.png

cat out.png
