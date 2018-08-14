# Trie

A comprehensive Trie implementation in Dart, for Dart developers. Optimized for autocomplete. Made by Christopher Gong and Ankush Vangari.

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

Full API docs are linked 
[here](https://pub.dartlang.org/documentation/trie/latest/trie/Trie-class.html).

## Usage

A simple usage example:

    import 'package:trie/trie.dart';

    main() {
        List<String> names = []; //your list goes here
        Trie trie = new Trie.list(names);
        trie.addWord("TURING");
        print("All names are: " + trie.getAllWords().toString());
        print("All names that begin with T are: " + trie.getAllWordsWithPrefix("T").toString());
    }

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/dark-mode/Trie/issues
