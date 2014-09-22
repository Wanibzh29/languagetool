#!/bin/sh

CURRENT_DIR=`pwd`
CURRENT_BASE=`basename $CURRENT_DIR`
if [ "$(basename $CURRENT_DIR)" != 'scripts' ]; then
    echo "Error: Please start this script from inside the 'scripts' directory";
    exit 1;
fi

BASE_NAME=LanguageTool-wikipedia-2.7-SNAPSHOT
TARGET_FILE=$BASE_NAME.zip

cd ../..
mvn clean package -DskipTests
scp -i ~/.ssh/wikipedia/toollabs languagetool-wikipedia/target/$TARGET_FILE tools-login.wmflabs.org:

echo "Now log on to the server and execute:"
echo "  mv $TARGET_FILE /data/project/languagetool/"
echo "  become languagetool"
echo "  cd feedchecker && rm -r LanguageTool-wikipedia_bak && mv LanguageTool-wikipedia LanguageTool-wikipedia_bak && unzip ../$TARGET_FILE && mv $BASE_NAME LanguageTool-wikipedia"
echo "  ./stop-all.sh"
echo "Wait a bit until the processes are gone (see 'qstat')..."
echo "  ./start-all.sh"
