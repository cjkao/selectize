@JS()
library selectize.exmple.perf;

// Copyright (c) 2016, kaopeter. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:js/js.dart';
import 'package:selectize/selectize.dart';
import 'dart:math' as Math;

@JS()
@anonymous
class MyOpt extends BaseOption {
  external String get title;
  external String get url;
  external int get id;
  external factory MyOpt({int id, String title, String url});
}

main() async {
  var letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUV';
  var options = [];
  for (var i = 0; i < 25000; i++) {
    var title = [];
    for (var j = 0; j < 8; j++) {
      title.add(letters.codeUnitAt(((letters.length - 1) * new Math.Random().nextDouble()).toInt()).toString());
    }
    options.add(new MyOpt(id: i, title: title.join('')));
  }

  selectize(
      '#select-junk',
      new SelectOptions(
          maxItems: null,
          maxOptions: 100,
          valueField: 'id',
          labelField: 'title',
          searchField: 'title',
          sortField: 'title',
          options: options,
          create: false));
}
