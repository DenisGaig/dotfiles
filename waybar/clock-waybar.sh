#!/bin/bash
TIME=$(TZ="Europe/Paris" date "+%H:%M")
DAY=$(date +%-d)  # jour sans zéro devant (ex: 8)

CAL=$(cal | sed ':a;N;$!ba;s/\n/\\n/g' | \
  sed "s/\b${DAY}\b/<span color='#BF00FF'><b>${DAY}<\/b><\/span>/")

echo "{\"text\": \"$TIME\", \"tooltip\": \"<tt>$CAL</tt>\"}"
