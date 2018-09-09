#!/bin/bash
read -p "Select your shape (1.rock 2.scissors 3.paper): " shape
ai=$((1+ RANDOM % 3))
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'
R="${RED}ROCK${NC}"
S="${RED}SCISSORS${NC}"
P="${RED}PAPER${NC}"
D="${BLUE}DREW${NC}"
W="${BLUE}WIN${NC}"
L="${BLUE}LOSE${NC}"
if [ "$shape" -lt 1 -o "$shape" -gt 3 ]; then
	echo "Index error"
else 
	if [ "$shape" -eq 1 ]; then
		if [ "$ai" -eq 1 ]; then
			echo -e "You are ${R} and Bot is ${R}, ${D}"
		elif [ "$ai" -eq 2 ]; then
			echo -e "You are ${R} and Bot is ${S}, You ${W}"
		else 
			echo -e "You are ${R} and Bot is ${P}, You ${L} "
		fi
	elif [ "$shape" -eq 2 ]; then
		if [ "$ai" -eq 1 ]; then
			echo -e "You are ${S} and Bot is ${R}, You ${L}"
		elif [ "$ai" -eq 2 ]; then
			echo -e "You are ${S} and Bot is ${S}, ${D}"
		else
			echo -e "You are ${S} and Bot is ${P}, You ${W}"
		fi
	else
		if [ "$ai" -eq 1 ]; then
			echo -e "You are ${P} and Bot is ${R}, You ${W}"
		elif [ "$ai" -eq 2 ]; then
			echo -e "You are ${P} and Bot is ${S}, You ${L}"
		else
			echo -e "You are ${P} and Bot is ${P}, ${D}"
		fi
	fi
fi
