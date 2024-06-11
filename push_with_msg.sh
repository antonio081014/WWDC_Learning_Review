#!/bin/bash

touch tmp.txt

echo "---" >> tmp.txt
echo "" >> tmp.txt
echo "date: $(date '+%Y-%m-%d %H:%M')" >> tmp.txt
echo "description: WWDC Watch Log" >> tmp.txt
echo "tags: tech" >> tmp.txt
echo "title: WWDC Learning Notes" >> tmp.txt
echo "" >> tmp.txt
echo "---" >> tmp.txt
echo README.md >> tmp.txt
cat tmp.txt > ~/Tech/Resolution/Content/tech/wwdc_learning_note.md

rm tmp.txt

COMMIT_MSG='Watch ...'

if [ $# -gt 0 ]; then
    COMMIT_MSG="$1"
fi

# echo "message: ${COMMIT_MSG}"

git add .

git commit -m "${COMMIT_MSG}"

git push origin master

