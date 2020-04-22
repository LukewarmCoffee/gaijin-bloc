import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import '../utils/utils.dart';

class WordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Words'),
      ),
      body: WordsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addWord);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
