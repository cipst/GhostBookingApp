from itertools import permutations
import networkx as nx
from tkinter import ttk, END
import tkinter as tk
import matplotlib.pyplot as plt

global g
global dict_path

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
        if len(word) <= MAX_LENGTH:
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

def impGraph(dictionary):
    global g
    global dict_path
    dict_path = "./" + dictionary + ".txt"
    g = nx.read_adjlist("./adj_" + dictionary)

def tempAddWord(word):
    global g
    global dict_path
    g = addWord(g, word, dict_path)

def compute(start, end):
    global g
    global dict_path
    g = addWord(g, start, dict_path)
    g = addWord(g, end, dict_path)
    path = nx.shortest_path(g, source=start, target=end)
    return g, path

def onClick(start, end):
    try:
        g, path = compute(start.strip(), end.strip())
        plt.clf()
        nx.draw_networkx(nx.subgraph(g, path))
        plt.show()
    except nx.NetworkXException:
        plt.clf()
        e = nx.Graph()
        e.add_node(start)
        e.add_node(end)
        nx.draw_networkx(e)
        plt.show()

def addWordToGraph(text):
    tempAddWord(text.get("1.0", "end-1c"))
    text.delete('1.0', END)

def main(window):
    global dictionary
    window.title("Word Finder")
    window.geometry("800x150")
    tabControl = ttk.Notebook(window)
    tab1 = ttk.Frame(tabControl)
    tabControl.add(tab1, text="Path")
    tabControl.pack(expand=1, fill="both")

    startLabel = tk.Label(tab1, text="Start:", font=("Arial", 15))
    startLabel.place(x=5 + 10, y=10)
    startInput = tk.Text(tab1, width=20, height=1.2, font=("Helvetica", 15))
    startInput.place(x=60 + 10, y=10)

    endLabel = tk.Label(tab1, text="End:", font=("Arial", 15))
    endLabel.place(x=5 + 330, y=10)
    endInput = tk.Text(tab1, width=20, height=1.2, font=("Helvetica", 15))
    endInput.place(x=60 + 330, y=10)

    button = tk.Button(tab1, text="Show!", font=("Arial", 15),
                       command=lambda: onClick(startInput.get("1.0", "end-1c"), endInput.get("1.0", "end-1c")))
    button.place(x=670, y=4)

    wordLabel = tk.Label(tab1, text="Add word: ", font=("Arial", 15))
    wordLabel.place(x=5+10, y=70)
    wordInput = tk.Text(tab1, width=20, height=1.2, font=("Helvetica", 15))
    wordInput.place(x=60+60, y=70)
    button3 = tk.Button(tab1, text="Add!", font=("Arial", 15),
                        command=lambda: addWordToGraph(wordInput))
    button3.place(x=60+330, y=62)

dictionary = "words_italian"
if __name__ == "__main__":
    root = tk.Tk()
    main(root)
    impGraph(dictionary)
    root.mainloop()
