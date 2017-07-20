#!/bin/sh

if [ $1 ] && [ $1 = '-f' ]; then
  FORCE=true
  shift
fi

SOURCE=${1:-index.md}
DIR=`dirname $SOURCE`
TARGET=$DIR/`basename $SOURCE .md`.html

if [ -f $TARGET ] && ! [ $FORCE ]; then
  echo $TARGET already exists\; please remove or add -f
  exit
fi

cat header.html > $TARGET
TITLE=`Markdown.pl $SOURCE | grep h1 | head -1 | sed -e 's/<[^>]*>//g'`

if [ "$TITLE" ]; then
  sed -i '' -e "s/<title>.*<\/title>/<title>$TITLE<\/title>/i" $TARGET
fi
