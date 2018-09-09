#!/bin/bash
read -p "Enter your score: " score
if [ "$score" -lt 60 ]; then
	echo "Your score is $score and your grade is C"
fi
if [ "$score" -ge 60 -a "$score" -lt 80 ]; then
	echo "Your score is $score and your grade is B"
fi
if [ "$score" -ge 80 ]; then
	echo "Your score is $score and your grade is A"
fi
