import 'dart:math';

class Trie {
  _TrieNode _head;
  bool _isCaseSensitive = false;

  bool get isCaseSensitive => _isCaseSensitive;

  set isCaseSensitive(bool caseSensitivity) =>
      _isCaseSensitive = caseSensitivity;

  Trie() : _head = new _TrieNode(null);

  Trie.list(List<String> words) : _head = new _TrieNode(null) {
    words.forEach(addWord);
  }

  void addWord(String word) {
    _addWordNode(word, _head);
  }

  List<String> getAllWords() {
    return getAllWordsWithPrefix('');
  }

  void _addWordNode(String? word, _TrieNode node) {
    if (word == null || word.length == 0) {
      node.endOfWord = true;
      return;
    }
    for (_TrieNode child in node.children) {
      final childChar = child.char;
      if (childChar != null &&
          ((childChar == word.substring(0, 1)) ||
              (!_isCaseSensitive &&
                  childChar.substring(0, childChar.length).toLowerCase() ==
                      word.substring(0, 1).toLowerCase()))) {
        _addWordNode(word.substring(1), child);
        return;
      }
    }

    node._addWord(word);
  }

  List<String> _collect(
      StringBuffer prefix, _TrieNode node, List<String> words) {
    if (node != _head) {
      prefix.write(node.char);
    }

    if (node.endOfWord) {
      words.add(prefix.toString());
    }

    node.children.forEach((child) {
      _collect(new StringBuffer(prefix.toString()), child, words);
    });

    return words;
  }

  List<String> getAllWordsWithPrefix(String prefix) {
    StringBuffer fullPrefix = new StringBuffer();
    return _getAllWordsWithPrefixHelper(prefix, _head, fullPrefix);
  }

  List<String> _getAllWordsWithPrefixHelper(
      String prefix, _TrieNode node, StringBuffer fullPrefix) {
    if (prefix.length == 0) {
      String pre = fullPrefix.toString();
      return _collect(
          new StringBuffer(pre.substring(0, max(pre.length - 1, 0))), node, []);
    }

    for (_TrieNode child in node.children) {
      final childChar = child.char;
      if (childChar != null &&
          ((childChar == prefix.substring(0, 1)) ||
              (!_isCaseSensitive &&
                  childChar.substring(0, childChar.length).toLowerCase() ==
                      prefix.substring(0, 1).toLowerCase()))) {
        fullPrefix.write(child.char);
        return _getAllWordsWithPrefixHelper(
            prefix.substring(1), child, fullPrefix);
      }
    }

    return [];
  }
}

class _TrieNode {
  String? _char;
  List<_TrieNode> _children;
  bool _endOfWord = false;

  _TrieNode(String? char)
      : _char = char,
        _children = [];

  bool get endOfWord => _endOfWord;

  String? get char => _char;

  List<_TrieNode> get children => _children;

  set endOfWord(bool end) {
    _endOfWord = end;
  }

  void _addWord(String word) {
    _TrieNode curr = this;
    for (int i = 0; i < word.length; i++) {
      _TrieNode child = new _TrieNode(word.substring(i, i + 1));
      curr._children.add(child);
      curr = child;
    }
    curr._endOfWord = true;
  }
}
