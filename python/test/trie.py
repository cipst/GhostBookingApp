import trie_node as tn


class Trie:
    def __init__(self):
        self.root = tn.TrieNode()

    def insert(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                node.insert(char)
            node = node.children[char]
        node.is_end_of_word = True

    def search(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                return False
            node = node.children[char]
        return node.is_end_of_word

    def find_similar_words(self, word, max_diff, max_distance):
        similar_words = []

        def dfs(node, word, index, diff, distance):
            if diff > max_diff:
                return
            if (len(word) == len(word)) and (diff <= max_diff) and (distance <= max_distance):
                similar_words.append(word)
            for char, child in node.children.items():
                if index < len(word):
                    if word[index] != char:
                        dfs(child, word+char, index + 1, diff+1, distance+1)
                    else:
                        dfs(child, word+char, index + 1, diff, distance)
                else:
                    dfs(child, word+char, index + 1, diff, distance+1)
            
        dfs(self.root, '', 0, 0, 0)
        return similar_words

