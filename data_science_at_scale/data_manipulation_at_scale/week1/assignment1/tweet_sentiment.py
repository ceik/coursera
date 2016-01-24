import sys
import json
import string

def read_sent_file(sent_file):
    """Read the sentiments file and turn it into a dictionary."""
    scores = {}
    for line in sent_file:
        term, score  = line.split("\t")  # The file is tab-delimited. "\t" means "tab character"
        scores[term] = int(score)  # Convert the score to an integer.
    # print scores.items() # Print every (term, score) pair in the dictionary
    return scores

def analyze_tweets(tweet_file, sent_dict):
    """Score each tweet in a given file according to a sentiment dictionary.
    Print each score to console."""
    for line in tweet_file:
        tweet = json.loads(line)
        if 'text' in tweet:
            score = 0
            text = tweet['text'].encode('utf-8').split()
            text_clean = [s.translate(None, string.punctuation) for s in text]
            for word in text_clean:
                lword = word.lower()
                if lword in sent_dict:
                    score = score + sent_dict[lword]
            print score

def main():
    sent_file = open(sys.argv[1])
    tweet_file = open(sys.argv[2])
    sent_dict = read_sent_file(sent_file)
    analyze_tweets(tweet_file, sent_dict)

if __name__ == '__main__':
    main()
