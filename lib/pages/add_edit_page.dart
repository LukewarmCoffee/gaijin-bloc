import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/kado.dart';
import '../utils/keys.dart';


typedef OnSaveKadoCallback = Function(String task, String note);

class AddEditPage extends StatefulWidget {
  final bool isEditing;
  final OnSaveKadoCallback onSave;
  final TitleKado kado;

  AddEditPage({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.kado,
  }): super(key: key ?? Keys.addKadoScreen);

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title;
  String _subtitle;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Kado' : 'Add Kado',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? widget.kado.title : '',
                autofocus: !isEditing,
                style: textTheme.headline,
                decoration: InputDecoration(
                  hintText: 'title..',
                ),
                validator: (val) {
                  return val.trim().isEmpty
                      ? 'empty title'
                      : null;
                },
                onSaved: (value) => _title = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.kado.subtitle : '',
                maxLines: 10,
                style: textTheme.subhead,
                decoration: InputDecoration(
                  hintText: 'subtitle',
                ),
                onSaved: (value) => _subtitle = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        
        tooltip: isEditing ? 'save changes' : 'add kado',
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(_title, _subtitle);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}