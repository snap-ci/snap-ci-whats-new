#!/bin/bash

RELEASE_NOTES="changelog/$(date '+%Y_%m_%d_release.md')"
touch $RELEASE_NOTES
git add -- $RELEASE_NOTES
