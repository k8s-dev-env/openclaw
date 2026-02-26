#!/bin/bash

# 同步 obsidian 資料夾到 git
cd ./obsidian

git add .
git commit -m "openclaw: sync obsidian"
git push