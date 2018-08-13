import 'dart:math';

class Trie {
  _TrieNode _head;
  bool _isCaseSensitive = false;
  List<String> _words;

  bool get isCaseSensitive => _isCaseSensitive;
  set isCaseSensitive(bool caseSensitivity) =>
      _isCaseSensitive = caseSensitivity;

  Trie() {
    _head = new _TrieNode(null);
  }

  addWord(String word) {
    _addWordNode(word, _head);
  }

  Trie.list(this._words) {
    _head = new _TrieNode(null);
    for (String word in _words) {
      addWord(word);
    }
  }

  List<String> getAllWords() {
    return getAllWordsWithPrefix('');
  }

  _addWordNode(String word, _TrieNode node) {
    if (word == null || word.length == 0) {
      node.endOfWord = true;
      return;
    }
    for (_TrieNode child in node.children) {
      if ((child.char == word.substring(0, 1)) ||
          (!_isCaseSensitive &&
              child.char.substring(0, child.char.length).toLowerCase() ==
                  word.substring(0, 1).toLowerCase())) {
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
      if ((child.char == prefix.substring(0, 1)) ||
          (!_isCaseSensitive &&
              child.char.substring(0, child.char.length).toLowerCase() ==
                  prefix.substring(0, 1).toLowerCase())) {
        fullPrefix.write(child.char);
        return _getAllWordsWithPrefixHelper(
            prefix.substring(1), child, fullPrefix);
      }
    }

    return [];
  }
}

class _TrieNode {
  String _char;
  List<_TrieNode> _children;
  bool _endOfWord = false;

  _TrieNode(String _char) {
    this._char = _char;
    this._children = [];
  }

  set endOfWord(bool end) {
    _endOfWord = end;
  }

  _addWord(String word) {
    _TrieNode curr = this;
    for (int i = 0; i < word.length; i++) {
      _TrieNode child = new _TrieNode(word.substring(i, i + 1));
      curr._children.add(child);
      curr = child;
    }
    curr._endOfWord = true;
  }

  bool get endOfWord => _endOfWord;
  String get char => _char;
  List<_TrieNode> get children => _children;
}
