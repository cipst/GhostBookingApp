# Creazione del dizionario di parole
words = {}
with open("elenco_parole_italiane.txt") as file:
    for line in file:
        line = line.strip()  # Rimuovi eventuali spazi vuoti
        words[line] = []  # Inizializza la lista per ogni parola

# Funzione per trovare parole vicine
def find_nearby_words(word, rules):
    queue = [word]  # Inizializza la coda con la parola corrente
    visited = set()  # Inizializza l'insieme delle parole visitate
    while queue:
        current_word = queue.pop(0)  # Prendi la parola in cima alla coda
        # Aggiungi la parola corrente all'insieme delle parole visitate
        visited.add(current_word)
        # Genera le parole vicine utilizzando le regole specificate
        for rule in rules:
            nearby_words = apply_rule(current_word, rule)
            for nearby_word in nearby_words:
                if nearby_word in words and nearby_word not in visited:
                    # Aggiungi la parola vicina alla coda
                    queue.append(nearby_word)
    return visited

# Funzione per calcolare la distanza minima tra due parole
def calculate_distance(word1, word2, rules):
    # Utilizzare l'algoritmo di ricerca in larghezza per trovare tutte le parole vicine a word1 e word2
    visited1 = find_nearby_words(word1, rules)
    visited2 = find_nearby_words(word2, rules)
    # Trovare l'intersezione tra le parole visitate per calcolare la distanza minima
    intersection = visited1.intersection(visited2)
    # Calcolare la distanza utilizzando le regole specificate con un peso diverso
    distance = 0
    for word in intersection:
        # Calcolare la distanza utilizzando le regole specificate con un peso diverso
        distance += calculate_distance_using_rules(word1, word, rules)
    return distance

# Funzione per applicare una regola
def apply_rule(word, rule):
    # Implementare la logica per applicare la regola specificata (R1, R2, R3, etc.)
    # utilizzando la parola corrente
    return []

# Funzione per calcolare la distanza utilizzando le regole specificate con un peso diverso
def calculate_distance_using_rules(word1, word2, rules):
    distance = 0
    # Implementare la logica per calcolare la distanza utilizz
