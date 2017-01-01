// Copyright (c) 2016, kaopeter. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:selectize/selectize.dart';

main() async {
  selectize('select', new SelectOptions(create: true));
  selectize('#select-locked-empty').lock();
  selectize('#select-locked-single').lock();
  selectize('#select-locked').lock();
}
