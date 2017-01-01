@JS()
library selectize.exmple.api;

// Copyright (c) 2016, kaopeter. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:js/js.dart';
import 'package:selectize/selectize.dart';
import 'dart:html';

@JS()
@anonymous
class MyOpt extends BaseOption {
  String title, url;
  int id;
  external factory MyOpt({int id, String title, String url});
}

main() async {
  var control = selectize(
      '#select-tools',
      new SelectOptions(
          maxItems: null,
          valueField: 'id',
          labelField: 'title',
          searchField: 'title',
          options: [
            new MyOpt(id: 1, title: 'Spectrometer', url: 'http://en.wikipedia.org/wiki/Spectrometers'),
            new MyOpt(id: 2, title: 'Star Chart', url: 'http://en.wikipedia.org/wiki/Star_chart'),
            new MyOpt(id: 3, title: 'Electrical Tape', url: 'http://en.wikipedia.org/wiki/Electrical_tape')
          ],
          create: false));

  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  querySelector('#button-clear').onClick.listen((_) {
    control.clear();
  });

  querySelector('#button-clearoptions').onClick.listen((_) {
    control.clearOptions();
  });

  querySelector('#button-addoption').onClick.listen((_) {
    control.addOption(new MyOpt(id: 4, title: 'Something New', url: 'http://google.com'));
  });

  querySelector('#button-additem').onClick.listen((_) {
    control.addItem(2);
  });

  querySelector('#button-setvalue').onClick.listen((_) {
    control.setValue([2, 3], true);
  });
}
