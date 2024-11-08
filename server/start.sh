#!/bin/bash

json-server --watch tedTalks.json --port 3000 &
json-server --watch tedLists.json --port 4000 &
