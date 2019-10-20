#!/bin/bash
OPENHABPATH=/etc/openhab2
cp $OPENHABPATH/items/*.items ./openhab2/items
cp $OPENHABPATH/things/*.things ./openhab2/things
cp $OPENHABPATH/rules/*.rules ./openhab2/rules
