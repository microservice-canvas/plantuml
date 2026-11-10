#! /bin/bash -e

# Renders the PlantUML diagram on stdin to stdout: a PNG, or the format FORMAT names, such as svg.
# LEGEND names a PNG in legends/ to append below a PNG diagram.

FORMAT=${FORMAT:-png}

cat > input.txt
java -Djava.awt.headless=true -jar ./*.jar "-t$FORMAT" input.txt

if [ -z "$LEGEND" ] ; then
  cat "input.$FORMAT"
  exit 0
fi

if [ "$FORMAT" != png ] ; then
  echo "LEGEND is appended only to a png diagram; FORMAT is $FORMAT" >&2
  exit 1
fi

convert -append input.png "./legends/$LEGEND.png" out.png

cat out.png
