#!/bin/bash

mongoimport --uri="$SOURCE_URI" --db="$SOURCE_DB" --collection="$SOURCE_COLL" --file=nested_dict_diff_source.json
mongoimport --uri="$TARGET_URI" --db="$TARGET_DB" --collection="$TARGET_COLL" --file=nested_dict_diff_target.json

python3 ../data-differ.py --source-uri "$SOURCE_URI" --target-uri "$TARGET_URI" --source-db "$SOURCE_DB" --source-coll "$SOURCE_COLL" --target-db "$TARGET_DB" --target-coll "$TARGET_COLL" --batch-size 100 --output-file nested_dict_diff_result.txt

mongosh "$SOURCE_URI" --eval "use $SOURCE_DB; db.$SOURCE_COLL.drop()"
mongosh "$TARGET_URI" --eval "use $TARGET_DB; db.$TARGET_COLL.drop()"