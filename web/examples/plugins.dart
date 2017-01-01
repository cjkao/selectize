// Copyright (c) 2016, kaopeter. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
@JS()
library selectize.example.plugin;

import 'package:selectize/selectize.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'dart:html';

main() async {
  selectize(
      '.input-tags',
      new SelectOptions(
          plugins: ['remove_button'],
          persist: false,
          create: true,
          render: new RenderFuns(item: allowInterop((data, escape) {
            return '<div>"' + escape(data.text) + '"</div>';
          })),
          onDelete: allowInterop((values) {
            return window.confirm(values.length > 1
                ? 'Are you sure you want to remove these ' + values.length + ' items?'
                : 'Are you sure you want to remove "' + values[0] + '"?');
          })));
  var plugs = {
    'dropdown_header': {'title': 'Language'}
  };

  selectize('.demo-code-language', new SelectOptions(sortField: 'text', hideSelected: false, plugins: jsify(plugs)));
}
