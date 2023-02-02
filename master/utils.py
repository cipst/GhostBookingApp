# COMPLETED

from itertools import permutations

MAX_LENGTH = 8
ALPHABET = "abcdefghijklmnopqrstuvwxyz"

def read_file(path):
    with open(path, "r") as f:
        lines = f.read().split()
    return lines

# restituisce una lista 
# di parole che differiscono da `start` di una lettera
def r1(start, words):
    words_r1 = list()
    # pos --> posizione dei caratteri nella parola `start` (eg. ciao --> 0,1,2,3)
    for pos in range(len(start)):

        # start_list --> lista di caratteri della parola `start` (eg. ciao --> ['c','i','a','o'])
        start_list = list(start)

        # letter --> lettera dell'alfabeto
        for letter in ALPHABET:
            # sostituisce la lettera nella posizione `pos` con la lettera dell'alfabeto
            start_list[pos] = letter
            # ricosstruisce la parola
            temp = "".join(start_list)
            # se la parola è presente nel dizionario e non è uguale alla parola di partenza
            if (temp in words) & (temp != start):
                # se la parola non è già presente nella lista
                if temp not in words_r1:
                    # aggiunge la parola alla lista
                    words_r1.append(temp)
    return words_r1

# restituisce una lista
# di anagrammi della parola `start`
def r2(start, words):
    words_r2 = list()
    # permutazioni della parola `start`
    for perm in permutations(start):
        # ricosstruisce la parola
        temp = "".join(perm)
        # se la parola è presente nel dizionario e non è uguale alla parola di partenza
        if (temp in words) & (temp != start):
            # se la parola non è già presente nella lista
            if temp not in words_r2:
                # aggiunge la parola alla lista
                words_r2.append(temp)
    return words_r2

# restituisce una lista
# di parole con una lettera in più e una lettera in meno rispetto a `start`
def r3(start, words):
    words_add_one = list()
    words_remove_one = list()

    for pos in range(len(start) + 1):
        start_list = list(start)
        for letter in ALPHABET:
            start_list.insert(pos, letter)
            temp = "".join(start_list)
            if (temp in words) & (temp != start):
                if temp not in words_add_one:
                    words_add_one.append(temp)
            start_list.pop(pos)

    for pos in range(len(start)):
        start_list = list(start)
        letter = start_list.pop(pos)
        temp = "".join(start_list)
        if (temp in words) & (temp != start):
            if temp not in words_remove_one:
                words_remove_one.append(temp)
        start_list.insert(pos, letter)
    
    return words_add_one + words_remove_one

# restituisce una lista di possibili parole applicando le regole r1, r3 
# e r2 se la lunghezza della parola è minore di MAX_LENGTH
def computeNode(word, dict_path):
    # legge le parole dal dizionario e le mette in un set
    words = set(read_file(dict_path))
    node_list = []

    # se la parola non è nel dizionario
    if word not in words:
        # applica le regole r1 e r3
        node_list = r1(word, words) + r3(word, words)
        if len(word) < MAX_LENGTH:
            # applica la regola r2
            node_list += r2(word, words)
    return node_list

# aggiunge un nodo al grafo
# se la parola non è già presente
def addWord(g, word, dict_path):
    # se la parola non è già presente nel grafo
    if word not in g:
        # per ogni nodo restituito da computeNode aggiunge un arco
        for node in computeNode(word, dict_path):
            g.add_edge(word, node)
    return g