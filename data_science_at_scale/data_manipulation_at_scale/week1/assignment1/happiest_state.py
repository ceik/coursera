import sys
import json
import string
import operator

states_list = ['AK','AL','AR','AS','AZ','CA','CO','CT','DC','DE','FL','GA','GU',
    'HI','IA','ID','IL','IN','KS','KY','LA','MA','MD','ME','MI','MN','MO','MP',
    'MS','MT','NA','NC','ND','NE','NH','NJ','NM','NV','NY','OH','OK','OR','PA',
    'PR','RI','SC','SD','TN','TX','UT','VA','VI','VT','WA','WI','WV','WY']

states_dict = {
        'AK': 0,
        'AL': 0,
        'AR': 0,
        'AS': 0,
        'AZ': 0,
        'CA': 0,
        'CO': 0,
        'CT': 0,
        'DC': 0,
        'DE': 0,
        'FL': 0,
        'GA': 0,
        'GU': 0,
        'HI': 0,
        'IA': 0,
        'ID': 0,
        'IL': 0,
        'IN': 0,
        'KS': 0,
        'KY': 0,
        'LA': 0,
        'MA': 0,
        'MD': 0,
        'ME': 0,
        'MI': 0,
        'MN': 0,
        'MO': 0,
        'MP': 0,
        'MS': 0,
        'MT': 0,
        'NA': 0,
        'NC': 0,
        'ND': 0,
        'NE': 0,
        'NH': 0,
        'NJ': 0,
        'NM': 0,
        'NV': 0,
        'NY': 0,
        'OH': 0,
        'OK': 0,
        'OR': 0,
        'PA': 0,
        'PR': 0,
        'RI': 0,
        'SC': 0,
        'SD': 0,
        'TN': 0,
        'TX': 0,
        'UT': 0,
        'VA': 0,
        'VI': 0,
        'VT': 0,
        'WA': 0,
        'WI': 0,
        'WV': 0,
        'WY': 0,
}

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

def analyze_tweets(tweet_file, sent_dict):
    """Score each tweet according to a sentiment dictionary, check if the
    state in which the tweet was made can be determined, and return  """
    # tweets_by_state = []
    for line in tweet_file:
        tweet = json.loads(line)
        if 'text' in tweet:
            text = tweet['text'].encode('utf-8').split()
            text_clean = [s.translate(None, string.punctuation) for s in text]
            tweet_score = analyze_tweet(text_clean, sent_dict)
            if 'place' in tweet and tweet['place'] is not None:
                if tweet['place']['country_code'] == 'US':
                    full_name = tweet['place']['full_name'].split(', ')
                    if len(full_name) == 2:
                        if full_name[1] in states_list:
                            states_dict[full_name[1]] += tweet_score
    return max(states_dict.iterkeys(), key = (lambda key: states_dict[key]))

def main():
    sent_file = open(sys.argv[1])
    tweet_file = open(sys.argv[2])
    sent_dict = read_sent_file(sent_file)
    # tweets_by_state = analyze_tweets(tweet_file, sent_dict)
    # for state in tweets_by_state:
    #     print state
    happiest_state = analyze_tweets(tweet_file, sent_dict)
    print happiest_state

if __name__ == '__main__':
    main()
