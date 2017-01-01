@JS()
library selectize.exmple.confirm;

// Copyright (c) 2016, kaopeter. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:js/js.dart';
import 'package:selectize/selectize.dart';

main() async {
  selectize(
      '#select-beast', new SelectOptions(create: true, sortField: new SortField(field: 'text', direction: 'asc')));
}
