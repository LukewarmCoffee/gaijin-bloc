import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../utils/keys.dart';


typedef OnSaveCallback = Function(String japanese, String kana, String english, String definition);

class AddEditWordPage extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Word word;

  AddEditWordPage({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.word,
  }): super(key: key ?? Keys.addKadoScreen);

  @override
  _AddEditWordPageState createState() => _AddEditWordPageState();
}

class _AddEditWordPageState extends State<AddEditWordPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _japanese;
  String _kana;
  String _english;
  String _definition;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Word' : 'Add Word',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? widget.word.japanese : '',
                autofocus: !isEditing,
                style: textTheme.headline,
                decoration: InputDecoration(
                  hintText: 'japanese..',
                ),
                validator: (val) {
                  return val.trim().isEmpty
                      ? 'empty'
                      : null;
                },
                onSaved: (value) => _japanese = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.word.kana : '',
                style: textTheme.subhead,
                decoration: InputDecoration(
                  hintText: 'kana..',
                ),
                onSaved: (value) => _kana = value,
              ),
            
              TextFormField(
                initialValue: isEditing ? widget.word.english : '',
                style: textTheme.subhead,
                decoration: InputDecoration(
                  hintText: 'english..',
                ),
                onSaved: (value) => _english = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.word.definition : '',

                style: textTheme.subhead,
                decoration: InputDecoration(
                  hintText: 'definition..',
                ),
                onSaved: (value) => _definition = value,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(        
        tooltip: isEditing ? 'save changes' : 'add word',
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(_japanese, _kana, _english, _definition);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}