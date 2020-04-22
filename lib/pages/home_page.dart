import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import '../utils/utils.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lessons'),
      ),
      body: LessonsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addKado);
        },
        child: Icon(Icons.add),
      ),
      drawer: MainDrawer(),
    );
  }
}
