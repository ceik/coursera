#####    Regular Expressions I & II   #####
#######################################

### Regular Expressions Basics

# Regular expressions are a combination of literals and metacharacters. A
# literal could for example be the word "Bush" in the following sentence:
# "His name is Bush."
# When trying to match a literal to a line of text every line that contains
# the word in any position would be returned.
#
# Regular Expressions provide a way to search through text in a more advanced
# way. It does so by using metacharacters to express things other than just the
# word you're looking for.
#
# They are used in many different languages and are not unique to R.
#
# Mostly they are used for processing text, especially if it is not formatted.
#
# In R they can be used with the grep(), grepl(), sub(), gsub() and other text
# search functions.






### Start and End of Line

# The ^ character indicated that a word should be at the beginning of the line.
# E.g. "^i think" looks for "i think" at the beginning of the line:
# "i think he is going for a walk."
# 
# The $ character indicates the end of the line. E.g. "morning$" looks for the
# word morning at the end of each line:
# "He goes for a walk in the morning"


### Character Classes

# A list of characters that will be accepted at any given point in the match 
# can be specified with []. E.g. [Bb] [Uu] [Ss] [Hh] will find a match in the
# following three sentences:
# "His name is Bush."
# "He was hiding in a bush today."
# "BUSH he screamed."

# A range of numbers and letters can also be specified in a character class. For
# example "[0-9] [a-zA-Z]" looks for a combination of a number and either a
# upper or lower case letter. E.g.:
# "3am in the morning."
# "2nd half beginning soon."


### Combining Metacharacters

# Metacharacters can be combined. E.g. "^[Ii] am" will look for the phrase
# "I am" or "i am" at the beginning of the line.

# When used in a character class the ^ metacharacter means NOT. E.g. "[^.?]$"
# will look for any line that does not end with a period or question mark.


### Wildcard

# "." is the wildcard character. E.g. "9.11" will macth the following:
# "9:11 am"
# "post 9-11 rules"


### OR Character

# "|" is the OR character. E.g. "flood|fire" machtes any sentence containing
# flood or fire. E.g.
# "There is a fire."
# "The town was flooded."
# Multiple alternatives can be linked together by multiple pipes: flood|fire|car
# Other combinations are possible: [Gg]ood|^[Bb]ad machtes the following:
# "I feel good."
# "Bad day."
# If both alternatives must be at the beginning of the line brackets must be 
# used: ^([Gg]ood|[Bb]ad)


### Excape Character

# "\" is the escape character. E.g. in the next example the period will be 
# treated as an actual period, not a metacharacter.


### Optional Character

# "?" indicates something to be optional. E.g. "[Gg]eorge( [Ww]\.)? [Bb]ush"
# machtes the following:
# "His name was George Bush"
# "His son's name was George W. Bush"


### Repetition Characters

# The "*" character means any number or repitions, including none at all. E.g.
# (.*) will match any sentence with brackets:
# "I don't like (fried) fish"
# "function() call"

# The "+" character means at least one repitions. E.g. [0-9]+ (.*)[0-9]+ matches:
# "Its time 4 me 2 go 2 bed"


### Interval Qualifiers

# The {} character lets you qualify the minimun and maximun number of matches.
# E.g. "[Bb]ush( +[^ ]+ +){1,5} debate" This means find the word bush, then 
# between one and five occurances of space, something-not-a-space, and space, 
# and the word debate. E.g.:
# "Bush has historically won all major debates."
# "Bush doesn't need these debates."
#
# In the curly brackets {m,n} means at least m but not more than n occurances,
# {m} means exaclty m matches, while {m,} means at least m matches.


### Repetition of Expressions

# The brackets can be used to "remember" a match and look for a repetition. 
# The repetitions are indicated by espaced numbers, e.g. \1 and \2.
# " +([a-zA-Z]+) +\1 +" will look for at least one space, at least one combination
# of letters, at least one space, exactly the match for the pervious combination
# of letters, at least one space. E.g.
# "Good night night."
# "blah blah blah blah"


### The Greedy Star

# The star character will always match the longest possible combination. E.g.
# "^s(.*)s" will match the following:
# "sitting at starbucks."
# It does not close the match at the s at the beginning of starbucks because 
# another s is following.
#
# The greediness can be disables with an ?. E.g. "^s(.*?)s" will match:
# "sitting at s"