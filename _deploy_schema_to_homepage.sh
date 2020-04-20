#!/bin/bash

# git config
git config --global user.email "clemens@nevrome.de"
git config --global user.name "Clemens Schmid"

# clone homepage repo
cd ..
git clone https://${GITHUB_PAT}@github.com/poseidon-framework/poseidon-framework.github.io.git

# copy files
cp poseidon-schema/terms.rdf.json poseidon-framework.github.io
cp poseidon-schema/components/*.json poseidon-framework.github.io

# push changes to homepage repo
cd poseidon-framework.github.io
git add --all *
git commit -m "Update the schemas"
git push -q origin master

