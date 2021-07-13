import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _RandomWordsState(); 
  }
}

class _RandomWordsState extends State<RandomWords>{
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont =  TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i){
        if(i.isOdd){
          return const Divider();
        }

        final index = i ~/2;
        if(index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }

  Widget _buildRow(WordPair pair){
    var alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){
        setState(() {
          if(alreadySaved){
            _saved.remove(pair);
          }else{
            _saved.add(pair);
          }
        });
      }
    );
  }

  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context){
          final tiles = _saved.map(
            (WordPair pair){
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            }
          );

          final divided = tiles.isNotEmpty ? ListTile.divideTiles(context: context, tiles: tiles).toList() : <Widget> [];

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided,)
          );
        },
      ),
    );
  }
}

/**
 * Basic widgets:
 * 
 * Text:
 *       Text widget lets you create a run of styled text within your application.
 * 
 * Row, Column:
 *       Let you create flexible layouts in both the horizontal and vertical directions.
 *       The design of these objects is based on the web's flexbox layout model.
 * 
 * Stack:
 *       Stack widget lets you place widgets on top of each other in paint order.
 *       You can then use the Positioned widget on children of a Stack to position them.
 * 
 * Container:
 *       Create a rectangular visual element. A contain can be decorated with BoxDecoration,
 *       seach as a background, a border, or a shadow.
 * 
 *       A Container can also have margins, padding, and constraints applied to its size.
 *       In addition, a Container can be transformed in three dimensional space using a matrix.
 * 
 * ** Be sure the using material design.
 * 
 *       **Stateful Widget:
 *          - Widgets are temporary objects, used to construct a presentation of the application
 *          in its current state.
 *          - State objects are persistent between calls to build(), allowing them a remember information.
 * 
 */

/**
 * LAYOUT:
 * 
 * Container: is a widget class that allows you to customize its child widget.
 * -- can: Add padding, margins, borders, background colors.
 * 
 * Layout a widget:
 * 
 * 1. Alignment:
 * 2. AspectRatio:   ratial between the width/height
 *    becarefull, don't put in underneath "expanded."
 *    To add AspectRatio in an Expandex, you should add Alignment (1) with it.
 * 3. Aligning widget:
 * 
 * ... They have mainAxisAlignment and crossAxisAlignment
 * 
 * 
 */
