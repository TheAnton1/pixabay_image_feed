import 'dart:io';

String readFile(String name) => File('test/common/$name').readAsStringSync();