// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
@JS()
library selectize.base;

import 'package:js/js.dart';
import 'typedef.dart';
// import 'package:func/func.dart';

@JS('options')
@anonymous
class Options {
  external Options();
}

@JS()
@anonymous
class OptValue {
  external String get value;
  external String get text;
  external num get $order;
  external factory OptValue({String value, String text});
}
/// Provide customized render function
/// both item and option  must use allowInterOp
@JS()
@anonymous
class RenderFuns {
  /// selected item in select box
  external Func2<String, BaseOption, StrFunc1 > get item;

  /// customized option list
  //external VoidFunc2<String, BaseOption, Func1<String, String>> get option;
  external Func2<BaseOption, Function, dynamic> get option;
  external Func2<BaseOption, Function, dynamic> get optgroup_header;
  external factory RenderFuns({Function item, Function option, Function optgroup_header});
}

/// for program to dynamic create option list
@JS()
@anonymous
class BaseOption {}

///
/// for sort field
///
@JS()
@anonymous
class SortField {
  external factory SortField({String field, String direction, String conjunction});
}
