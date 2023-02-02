import time
import networkx as nx

from utils import addWord

global g
global dict_path

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
    # DA ELIMINARE
    # start_time = time.time()
    # result = str()
    path = nx.shortest_path(g, source=start, target=end)
    return g, path
    # DA ELIMINARE
    # elapsedTime = str((time.time() - start_time))
    # betterElapseTime = elapsedTime.split(".")[0] + "." + elapsedTime.split(".")[1][0:8]
    # result += str(path) + "\n#" + "--- " + "path found in: " + betterElapseTime + " seconds ---"
    # nx.draw_networkx(nx.subgraph(g, path))
    # print(result)
    # return result
