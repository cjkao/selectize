library selectize.exmple.confirm;

// Copyright (c) 2016, kaopeter. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:js/js.dart';
import 'package:selectize/selectize.dart';
import 'dart:html';

main() async {
  selectize(
      '#input-tags',
      new SelectOptions(
          delimiter: ',',
          persist: false,
          onDelete: allowInterop((values) {
            var msg = values.length > 1
                ? 'Are you sure you want to remove these ' + values.length + ' items?'
                : 'Are you sure you want to remove "${values[0]}" ?';
            return window.confirm(msg);
          })));
}
