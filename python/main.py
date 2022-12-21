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


def is_R1_rule(word1, word2):
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


def is_R2_rule(word1, word2):
    # Controlla se due parole sono anagrammi
    return sorted(word1) == sorted(word2)


def is_R3_rule(word1, word2):
    # Controlla se una parola può essere ottenuta dall'altra
    # sostituendo una lettera
    if len(word1) != len(word2):
        return False
    else:
        diff = 0
        for c1, c2 in zip(word1, word2):
            if c1 != c2:
                diff += 1
        return diff == 1


def add_archs():

    for word1 in G.nodes:
        start_time = time.time()
        for word2 in G.nodes:
            # print(word1, word2, word2.find(word1[-1]))
            # Genera gli archi tra le parole in base alla regola R1
            if is_R1_rule(word1, word2):
                # Assegna un peso all'arco in base alla posizione
                # della lettera aggiunta o tolta
                if len(word1) < len(word2):
                    weight = word2.find(word1[-1])
                else:
                    weight = word1.find(word2[-1])
                G.add_edge(word1, word2, weight=weight)

            # Genera gli archi tra le parole in base alla regola R2
            if is_R2_rule(word1, word2):
                G.add_edge(word1, word2, weight=1)

            # Genera gli archi tra le parole in base alla regola R3     
            if is_R3_rule(word1, word2):
                G.add_edge(word1, word2, weight=1)
        end_time = time.time()

        print(f"Parola 1: {word1}\tTime taken: {(end_time-start_time)*10**3:.03f}ms")

# Per utilizzare l'algoritmo di Dijkstra in python, possiamo usare la funzione nx.dijkstra_path() della libreria NetworkX. Questa funzione prende in input il grafo, il nodo di partenza e il nodo di destinazione, e restituisce il cammino minimo tra i due nodi:

# Trova il cammino minimo tra due parole
# start_word = "parola1"
# end_word = "parola2"
# path = nx.dijkstra_path(G, start_word, end_word)

# Definiamo una funzione di stima che calcola la distanza
# tra due parole usando la funzione di distanza di Levenshtein


def word_distance(word1, word2):
    return nltk.edit_distance(word1, word2)


# main function
if __name__ == "__main__":
    # Legge il file con le parole italiane
    words = read_file("words.italian.txt")

    # # Scrive su file words.txt le parole italiane
    # with open("words.txt", "w") as f:
    #     for word in words:
    #         f.write(word + "\n")

    # Inserisce le parole come nodi nel grafo
    start_time = time.time()
    for word in words:
        G.add_node(word)
    end_time = time.time()
    print("Tempo di esecuzione AGGIUNTA NODI: ", (end_time - start_time) * 10**3, "ms")

    # Aggiunge gli archi al grafo
    start_time = time.time()
    add_archs()
    end_time = time.time()
    print("Tempo di esecuzione AGGIUNTA ARCHI: ", (end_time - start_time) * 10**3, "ms")

    # Trova il cammino minimo tra due parole usando l'algoritmo A*
    start_word = input("Inserisci la parola di partenza: ")
    end_word = input("Inserisci la parola di arrivo: ")
    path = nx.astar_path(G, start_word, end_word, word_distance)

    # Stampa il cammino minimo
    print(path)
