import time
import networkx as nx
from utils import read_file, r3, r1, r2, MAX_LENGTH

def buildGraph(name):
    dict_path = "./" + name + ".txt"
    words = set(read_file(dict_path))
    dictionary = list(read_file(dict_path))
    
    g = nx.Graph()
    start_time = time.time()
    for p in dictionary:
        g.add_node(p)
        node_list = r1(p, words) + r3(p, words)
        if len(p) < MAX_LENGTH:
            node_list += r2(p, words)
        for n in node_list:
            g.add_edge(p, n)
    print("---building graph time: %s seconds ---" % (time.time() - start_time))
    nx.write_adjlist(g, "./" + "adj_" + name)
