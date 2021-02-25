#!/bin/sh
mkdir -p deploy/PK deploy/KEK deploy/db deploy/dbx
cp PK.auth deploy/PK/
cp KEK.auth deploy/KEK/
cp db.auth deploy/db/
cp dbx.auth deploy/dbx/

sbkeysync --keystore ./deploy --verbose
