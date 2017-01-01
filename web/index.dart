// Copyright (c) 2016, kaopeter. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library cj.angular2.selective;

import 'dart:html';
import 'dart:async';
import 'package:js/js.dart';
import 'package:selectize/selectize.dart';
import 'dart:js' as js;

/// [MainApp] used!
main() async {
//  await jqSelectBootstrap();
  var iTag = selectize(
      '#select-box',
      new SelectOptions()
        ..create = true
        ..onChange = allowInterop((List _) {
          print('box change:$_');
          querySelector('.box-list').text = _?.join(',');
        }));
  iTag.addOption(new OptValue(value: '1', text: 'a'));
  iTag.addOption(new OptValue(value: "tiny", text: 'TINY'));
  iTag.createItem('x');
//  int a = iTag.getValue();

  var xx = optionList(iTag.options);
  print(xx);
//  var iTag = selectize('#select-box');
//  iTag.addOption(new OptValue(value: '1', text: 'a'));
//  print(iTag.options);
  var selState = selectize('#select-state',
      new SelectOptions(maxItems: 5, maxOptions: 3, plugins: ['restore_on_backspace', 'remove_button', 'drag_drop']));
  querySelector("#select-state");
  var seCount = selectize('#select-country')
    ..addItem('NZ')
    ..setValue('TW');

  selState.on('change', allowInterop((e) {
    print('change evt $e');
  }));
  seCount.on("change", allowInterop((e) {
    print('change evt $e');
  }));
  new Timer(new Duration(seconds: 4), () {
//  selState.off('change');
//    selState.print("is lock: ${selState.isLocked}");
    //  se.selectedOptions.forEach((o) => print(o.value));
    //print(iTag.getOption('small'));
//    iTag.addOption(new OptValue(value: "tiny", text: 'TINY'));
//    iTag.refreshOptions(true);
//    print(optionByValue(iTag.options, 'small').text);
//    print(new JOptions(iTag.options)['small'].text);
//    print(iTag.items);
    //iTag.destroy();
  });
  bookExample();
}

void bookExample() {
  var book = selectize('#select-book', new SelectOptions()..maxItems = 1);
  book.disable();
  var book2 = selectize('#select-book-2', new SelectOptions()..maxItems = 2);
  book2.addOption(new OptValue(value: '1', text: 'a'));
  book2.addOption(new OptValue(value: '21', text: 'ba'));
}
