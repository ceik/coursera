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

def analyze_tweet(text_clean, sent_dict):
    """Score each tweet in a given file according to a sentiment dictionary.
    Return score."""
    score = 0
    for word in text_clean:
        lword = word.lower()
        if lword in sent_dict:
            score = score + sent_dict[lword]
    return score

def analyze_tweet_terms(tweet_file, sent_dict):
    """Score each term in a tweet according to a sentiment dictionary and the
    tweets overall score."""
    for line in tweet_file:
        tweet = json.loads(line)
        if 'text' in tweet:
            text = tweet['text'].encode('utf-8').split()
            text_clean = [s.translate(None, string.punctuation) for s in text]
            tweet_score = analyze_tweet(text_clean, sent_dict)
            for word in text_clean:
                lword = word.lower()
                word_score = 0
                if lword in sent_dict:
                    word_score = sent_dict[lword]
                else:
                    word_score = tweet_score
                print word, str(word_score)

def main():
    sent_file = open(sys.argv[1])
    tweet_file = open(sys.argv[2])
    sent_dict = read_sent_file(sent_file)
    analyze_tweet_terms(tweet_file, sent_dict)

if __name__ == '__main__':
    main()
