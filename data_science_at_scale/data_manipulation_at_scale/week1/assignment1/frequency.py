import sys
import json
import string
from collections import Counter

def tweet_file_to_list(tweet_file):
    word_list = []
    for line in tweet_file:
        tweet = json.loads(line)
        if 'text' in tweet:
            text = tweet['text'].encode('utf-8').split()
            text_clean = [s.translate(None, string.punctuation) for s in text]
            for word in text_clean:
                word_list.append(word.lower())
    return word_list

def main():
    tweet_file = open(sys.argv[1])
    word_list = tweet_file_to_list(tweet_file)
    counts = Counter(word_list)
    word_count = len(word_list)
    for key, value in counts.iteritems():
        print key, float(value) / word_count

if __name__ == '__main__':
    main()
