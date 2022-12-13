# algorithm start with a word and end with a new word by changing letters
# one at a time. Each new word must be a valid word in the dictionary.
# The algorithm must find the shortest path from the start word to the end word.
# For example, the shortest path from 'cat' to 'dog' is:
# cat -> cot -> cog -> dog
# The algorithm must find the shortest path from the start word to the end word.
# The algorithm must be able to find the shortest path between any two words in the dictionary.
# The algorithm must accept words of any length.

import rules as r

# global variables
# dictionary of words
words = {}

# read the dictionary of words
def read_words(filename):
    global words
    with open(filename, 'r') as f:
        for line in f:
            words[line.strip()] = True

# using dijkstra's algorithm to find the shortest path
def find_shortest_path(start, end):
    # create a queue of paths
    queue = []
    # enqueue the first path
    queue.append([start])
    # create a set to store visited words
    visited = set()
    # mark the start word as visited
    visited.add(start)
    # loop until the queue is empty
    while queue:
        # dequeue the first path
        path = queue.pop(0)
        # get the last word from the path
        word = path[-1]
        # if the word is the end word, return the path
        if word == end:
            return path
        # get the new words by changing one letter
        new_words = get_new_words(word)
        # loop through each new word
        for new_word in new_words:
            # if the new word has not been visited
            if new_word not in visited:
                # mark the new word as visited
                visited.add(new_word)
                # create a new path
                new_path = list(path)
                new_path.append(new_word)
                # enqueue the new path
                queue.append(new_path)

# find all the paths from the start word to the end word
def find_all_paths(start, end):
    # create a queue of paths
    queue = []
    # enqueue the first path
    queue.append([start])
    # create a set to store visited words
    visited = set()
    # mark the start word as visited
    visited.add(start)
    # create a list to store all the paths
    all_paths = []
    # loop until the queue is empty
    while queue:
        # dequeue the first path
        path = queue.pop(0)
        # get the last word from the path
        word = path[-1]
        # if the word is the end word, add the path to the list
        if word == end:
            all_paths.append(path)
        # get the new words by changing one letter
        new_words = get_new_words(word)
        # loop through each new word
        for new_word in new_words:
            # if the new word has not been visited
            if new_word not in visited:
                # mark the new word as visited
                visited.add(new_word)
                # create a new path
                new_path = list(path)
                new_path.append(new_word)
                # enqueue the new path
                queue.append(new_path)
    return all_paths

def get_new_words(word):
    new_words = []

    # add one letter
    for letter in 'abcdefghijklmnopqrstuvwxyz':
        new_word = r.add_letter(word, letter)
        if new_word in words:
            new_words.append(new_word)
    # remove one letter
    for i in range(len(word)):
        new_word = r.remove_letter(word, i)
        if new_word in words:
            new_words.append(new_word)
    # replace one letter
    for i in range(len(word)):
        for letter in 'abcdefghijklmnopqrstuvwxyz':
            new_word = r.replace_letter(word, i, letter)
            if new_word in words:
                new_words.append(new_word)
    # swap two letters
    for i in range(len(word) - 1):
        for j in range(i + 1, len(word)):
            new_word = r.swap_letters(word, i, j)
            if new_word in words:
                new_words.append(new_word)
    # anagram the word
    for new_word in r.anagram_word(words, word):
        if new_word in words:
            new_words.append(new_word)
    return new_words

# minimum distance less expensive rules first
def get_new_words(word):
    new_words = []

    # add one letter
    for letter in 'abcdefghijklmnopqrstuvwxyz':
        new_word = r.add_letter(word, letter)
        if new_word in words:
            new_words.append(new_word)
    # remove one letter
    for i in range(len(word)):
        new_word = r.remove_letter(word, i)
        if new_word in words:
            new_words.append(new_word)
    # replace one letter
    for i in range(len(word)):
        for letter in 'abcdefghijklmnopqrstuvwxyz':
            new_word = r.replace_letter(word, i, letter)
            if new_word in words:
                new_words.append(new_word)
    # swap two letters
    for i in range(len(word) - 1):
        for j in range(i + 1, len(word)):
            new_word = r.swap_letters(word, i, j)
            if new_word in words:
                new_words.append(new_word)
    # anagram the word
    for new_word in r.anagram_word(words, word):
        if new_word in words:
            new_words.append(new_word)

    print(new_words)
    return new_words


# main function
def main():
    # read the dictionary of words
    read_words('words.italian.txt')
    
    # get the start and end words
    start = input('Enter the start word: ')
    end = input('Enter the end word: ')

    # find the shortest path
    path = find_shortest_path(start, end)
    if path:
        print('The shortest path is:')
        print(path)
    else:
        print('There is no path from ' + start + ' to ' + end)

    # find all the paths
    # paths = find_all_paths(start, end)
    # if paths:
    #     print('All the paths are:')
    #     for path in paths:
    #         print(path)
    # else:
    #     print('There is no path from ' + start + ' to ' + end)

if __name__ == '__main__':
    main()

# Output:
# Enter the start word: cat
# Enter the end word: dog
# The shortest path is:
# ['cat', 'cot', 'cog', 'dog']
