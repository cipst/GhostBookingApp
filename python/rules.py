import itertools
import utils as u

# add one letter to a word
def add_letter(word, letter):
    return word + letter

# remove a specific letter from a word
def remove_letter(word, index):
    return word[:index] + word[index + 1:]

# replace a specific letter in a word
def replace_letter(word, index, letter):
    return word[:index] + letter + word[index + 1:]

# swap two letters in a word
def swap_letters(word, index1, index2):
    if index1 > index2:
        index1, index2 = index2, index1
    return word[:index1] + word[index2] + word[index1 + 1:index2] + word[index1] + word[index2 + 1:]

# anagram a word and the result must be a word in the dictionary
def anagram_word(words, word):
    anagrams = []
    for word2 in itertools.permutations(word):
        word2 = ''.join(word2)
        if word2 != word and u.is_word(words, word2):
            anagrams.append(word2)
    return anagrams
