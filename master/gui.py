import os
from tkinter import ttk, END
import tkinter as tk

import matplotlib.pyplot as plt

import networkx as nx

from calcoloPercorso import compute, impGraph, tempAddWord
from preprocessingDictionary import buildGraph


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
