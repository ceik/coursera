import sys
import json
import string
from collections import Counter


def get_hashtag_list(tweet_file):
    hashtag_list = []
    for line in tweet_file:
        tweet = json.loads(line)
        if 'entities' in tweet:
            hastags = tweet['entities']['hashtags']
            for hashtag in hastags:
                hashtag_list.append(hashtag['text'].encode('utf-8'))
    return hashtag_list

def main():
    tweet_file = open(sys.argv[1])
    hashtag_list = get_hashtag_list(tweet_file)
    counts = Counter(hashtag_list)
    top_ten_hashtags = counts.most_common(10)
    for tag in top_ten_hashtags:
        print tag[0], tag[1]

if __name__ == '__main__':
    main()
