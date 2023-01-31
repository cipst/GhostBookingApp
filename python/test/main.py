import queue


def add_letter_end(word):
    for i in 'abcdefghijklmnopqrstuvwxyz':
        yield word + i

def add_letter_start(word):
    for i in 'abcdefghijklmnopqrstuvwxyz':
        yield i + word

def add_letter_middle(word):
    for i in range(len(word)):
        for j in 'abcdefghijklmnopqrstuvwxyz':
            yield word[:i] + j + word[i:]

def replace_letter(word):
    for i in range(len(word)):
        for j in 'abcdefghijklmnopqrstuvwxyz':
            yield word[:i] + j + word[i+1:]

def remove_letter_start(word):
    for i in range(len(word)):
        yield word[i:]

def remove_letter_end(word):
    for i in range(len(word)):
        yield word[:i]

def remove_letter_middle(word):
    for i in range(len(word)):
        for j in range(len(word)):
            if i != j:
                yield word[:i] + word[j:]

def anagrams(word):
    if len(word) < 2:
        yield word
    else:
        for i, letter in enumerate(word):
            if not letter in word[:i]:  # avoid duplicating earlier words
                for j in anagrams(word[:i]+word[i+1:]):
                    yield j+letter

def word_ladder(start, end, words):
    words = set(words)
    q = queue.Queue()
    q.put(start)
    visited = set()
    parent = {start: None}
    distance = {start: 0}
    while not q.empty():
        word = q.get()
        if word == end:
            return distance[word], construct_path(parent, start, end)

        check_rule(words, q, visited, parent, distance, word, replace_letter(word))
        check_rule(words, q, visited, parent, distance, word, anagrams(word))
        check_rule(words, q, visited, parent, distance, word, add_letter_end(word))
        check_rule(words, q, visited, parent, distance, word, add_letter_start(word))
        check_rule(words, q, visited, parent, distance, word, add_letter_middle(word))
        check_rule(words, q, visited, parent, distance, word, remove_letter_end(word))
        check_rule(words, q, visited, parent, distance, word, remove_letter_start(word))
        check_rule(words, q, visited, parent, distance, word, remove_letter_middle(word))

    return -1

def check_rule(words, q, visited, parent, distance, word, rule):
    for next_word in rule:
        if next_word in words and next_word not in visited:
            q.put(next_word)
            visited.add(next_word)
            parent[next_word] = word
            distance[next_word] = distance[word] + 1

def construct_path(parent, start, end):
    path = [end]
    while path[-1] != start:
        path.append(parent[path[-1]])
    return path[::-1]

def main():
    # word_list = set(["hot", "dot", "dog", "lot", "log", "cog"])
    word_list = set()

    print("Loading dictonary...")
    with open('words.italian.txt', 'r') as file:
        for line in file:
            word = line.strip()
            word_list.add(word)
    print("Dictionary loaded")

    start = input("Insert start word: ")
    
    if (start not in word_list):
        print("Start word not in dictionary")
        return

    end = input("Insert end word: ")

    if (end not in word_list):
        print("End word not in dictionary")
        return

    print(word_ladder(start, end, word_list))
    
# main function
if __name__ == "__main__":
    main()