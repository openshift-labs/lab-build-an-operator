#!/bin/bash

echo
echo "### Delete global definitions."
echo

if [ -d .workshop/resources/ ]; then
    oc delete -f .workshop/resources/ --recursive
fi
