class TrieNode:
    def __init__(self):
        self.children = {}
        self.is_end_of_word = False

    def insert(self, char):
        self.children[char] = TrieNode()

    def suffixes(self, suffix = ''):
        # Recursive function that collects the suffix for 
        # all complete words below this point
        suffixes = []
        for char, node in self.children.items():
            if node.is_end_of_word:
                suffixes.append(suffix + char)
            suffixes.extend(node.suffixes(suffix + char))
        return suffixes