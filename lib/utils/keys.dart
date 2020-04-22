import 'package:flutter/foundation.dart';

class Keys {
  static final kadoItem = (String id) => Key('KadoItem__$id');
  static final lessonItem = (String id) => Key('LessonItem__$id');
  static final wordItem = (String id) => Key('WordItem__$id');
  static const addKadoScreen = Key('__addKadoScreen__');
}
