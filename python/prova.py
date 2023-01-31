import networkx as nx
import nltk
import time

# Crea un grafo vuoto
G = nx.Graph()

def read_file(filename):
    # Legge il file con le parole italiane
    with open(filename) as f:
        words = f.read().splitlines()
    return words

def one_char_diff(word1, word2):
    # Controlla se una parola può essere ottenuta dall'altra
    # aggiungendo o togliendo una lettera
    if len(word1) != len(word2):
        return abs(len(word1) - len(word2)) == 1
    else:
        diff = 0
        for c1, c2 in zip(word1, word2):
            if c1 != c2:
                diff += 1
        return diff == 1

def is_anagram(word1, word2):
    # Controlla se due parole sono anagrammi
    return sorted(word1) == sorted(word2)

# funzione ricorsiva che trova il cammino minimo per arrivare da una parola a un'altra
# avendo come struttura un dizionario con chiave la lunghezza delle parole e valore una lista di parole con quella lunghezza
# e il grafo inizialmente vuoto che verrà popolato con l'aggiunta di nuovi archi
def find_path(G, start, end, path=[], words={}):
    path = path + [start]
    if start == end:
        return path
    # if not start in G:
    #     return None
    shortest = None
    # se la lunghezza della parola di partenza è minore della lunghezza della parola di arrivo
    # aggiungo un arco tra la parola di partenza e tutte le parole con lunghezza uguale alla parola di partenza + 1
    if len(start) < len(end):
        for word in words[len(start) + 1]:
            if one_char_diff(start, word):
                G.add_edges_from((start, word))
    # se la lunghezza della parola di partenza è maggiore della lunghezza della parola di arrivo
    # aggiungo un arco tra la parola di partenza e tutte le parole con lunghezza uguale alla parola di partenza - 1
    elif len(start) > len(end):
        for word in words[len(start) - 1]:
            if one_char_diff([(start, word)]):
                G.add_edges_from([(start, word)])
    # se la lunghezza della parola di partenza è uguale alla lunghezza della parola di arrivo
    # aggiungo un arco tra la parola di partenza e tutte le parole con lunghezza uguale alla parola di partenza
    else:
        for word in words[len(start)]:
            if one_char_diff(start, word) or is_anagram(start, word):
                print(word)
                G.add_edges_from([(start, word)])
    # for node in G[start]:
    #     if node not in path:
    #         newpath = find_path(G, node, end, path, words)
    #         if newpath:
    #             if not shortest or len(newpath) < len(shortest):
    #                 shortest = newpath
    return shortest

# main function
if __name__ == "__main__":
    start_word = input("Inserisci la parola di partenza: ")

    # creo un dizionario vuoto
    words = {}

    # leggo il file con le parole italiane
    # inserisco le parole in un dizionario
    # la chiave è la lunghezza della parola
    # il valore è una lista di parole con quella lunghezza
    for word in read_file("words.italian.txt"):
        word = word.strip()
        if len(word) <= len(start_word):
            if len(word) in words:
                words[len(word)].append(word)
            else:
                words[len(word)] = [word]

    G.add_node(start_word)

    end_word = input("Inserisci la parola di arrivo: ")

    # iterations = input("Inserisci il numero di iterazioni massime: ")

    start_time = time.time()

    # trovo il cammino minimo tra la parola di partenza e quella di arrivo
    path = find_path(G, start_word, end_word, [], words)

    print(G.nodes())

    end_time = time.time()

    print("Tempo di esecuzione: %s secondi" % (end_time - start_time))

    # stampo il cammino minimo
    print(path)


