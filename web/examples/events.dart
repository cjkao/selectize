// Copyright (c) 2016, kaopeter. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:js/js.dart';
import 'package:selectize/selectize.dart';
import 'dart:html';

main() async {
  var eventHandler = (name) {
    return allowInterop(([_, __]) {
      print('$name, $_ $__');
      querySelector('#log').appendHtml('<div><span class="name">' + name + '</span></div>');
    });
  };
  selectize(
      '#select-state',
      new SelectOptions(
        create: true,
        onChange: eventHandler('onChange'),
        onItemAdd: eventHandler('onItemAdd'),
        onItemRemove: eventHandler('onItemRemove'),
        onOptionAdd: eventHandler('onOptionAdd'),
        onOptionRemove: eventHandler('onOptionRemove'),
        onDropdownOpen: eventHandler('onDropdownOpen'),
        onDropdownClose: eventHandler('onDropdownClose'),
        onFocus: eventHandler('onFocus'),
        onBlur: eventHandler('onBlur'),
        onInitialize: eventHandler('onInitialize'),
      ));
}
