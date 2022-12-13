import re
import string
from functools import lru_cache

# dictionary of words
words = {}

# Find all permutations by removing one letter
def delete_letter(word):
    delete_l = set()
    for i in range(len(word)):
        cur_word = word[:i] + word[i+1:]
        delete_l.add(cur_word)
    return delete_l

# Find all permutations by replacing one letter with a-z
def replace_letter(word):
    replace_l = set()
    for i in range(len(word)):
        cur_word = word[:i]
        for c in string.ascii_lowercase:
            replace_l.add(cur_word + c + word[i+1:])
    return replace_l

# Find all permutations by inserting one letter between a-z
def insert_letter(word):
    insert_l = set()
    for i in range(len(word)+1):
        cur_word = word[:i]
        for c in string.ascii_lowercase:
            insert_l.add(cur_word + c + word[i:])
    return insert_l

# Find all related word to our given word by apply one of the top functions
def edit_one_letter(word):
    edit_one_set = set()
    edit_one_set.update(delete_letter(word))
    edit_one_set.update(replace_letter(word))
    edit_one_set.update(insert_letter(word))
    return edit_one_set

# Find all related word to our given word by apply twice of the top functions (nested)
def edit_two_letters(word):
    edit_one_set = edit_one_letter(word)
    edit_two_set = set()
    for w in edit_one_set:
        edit_two_set.update(delete_letter(w))
        edit_two_set.update(replace_letter(w))
        edit_two_set.update(insert_letter(w))
    return edit_two_set


# The cost of converting `w1` to `w2` by caching Minium Edit Distance algorithm
@lru_cache(None)
def min_edit_dist(w1, w2, s1, s2):
    if s1 == 0:
        return s2
    if s2 == 0:
        return s1

    if w1[s1 - 1] == w2[s2 - 1]:
        return min_edit_dist(w1, w2, s1 - 1, s2 - 1)

    replace_cost = 2 + min_edit_dist(w1, w2, s1 - 1, s2 - 1)  # Replace costs 2
    delete_cost = 1 + min_edit_dist(w1, w2, s1 - 1, s2)  # Delete costs 1
    insert_cost = 1 + min_edit_dist(w1, w2, s1, s2 - 1)  # Insert costs 1

    return min(replace_cost, delete_cost, insert_cost)


# What is the propability `word` appears in shakespear dataset
def happen_prob(word, text, all_word):
    our_word = all_word.count(word)
    return our_word / len(all_word)


# Find the most similar word in shakespear to our given word by Minium Edit Distance and Probability of Appearing
def autoCorrect():
    # with open('words.italian.txt') as file:
    #     data = file.read()
    # data = data.lower()
    # word = word.lower()
    # all_shakes_word = re.findall(r'\w+', data)
    # unique_shakes_word = set(all_shakes_word)
    # unique_shakes_word = set(data)

    # print(len(data))
    # print(len(unique_shakes_word))

    # return

    # all_words = edit_one_letter(word) | edit_two_letters(word)
    all_words = words

    for cur_filter_word in all_words:
        distance = min_edit_dist(word, cur_filter_word, len(word), len(cur_filter_word))
        prob_words.append([
            cur_filter_word,
            distance,
            # happen_prob(cur_filter_word, data, all_shakes_word)
        ])

    return min(prob_words, key=lambda item: (item[1], -item[2]))[0]

# read the dictionary of words


def read_words(filename):
    global words
    with open(filename, 'r') as f:
        for line in f:
            words[line.strip()] = True


def main():
    read_words('words.italian.txt')
    
    start = input('Enter the start word: ')
    end = input('Enter the end word: ')
    
    # autoCorrect()


if __name__ == '__main__':
    main()
