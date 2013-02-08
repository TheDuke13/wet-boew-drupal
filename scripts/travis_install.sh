#!/bin/sh
# Travis Install Script for CI Testing

# MySQL Create Database
mysql -e 'create database wetkit_db;'

# Install Drush
pear channel-discover pear.drush.org
pear install drush/drush-5.8.0
phpenv rehash

# Install WetKit Distribution
workspace=`pwd`
git_commit=`git show --pretty=%P HEAD | head -1 | cut -d\  -f 2`
cat $TRAVIS_BUILD_DIR/build-wetkit.make | sed "s/master/$TRAVIS_COMMIT/g" | drush make --prepare-install php://stdin $TRAVIS_BUILD_DIR/build
