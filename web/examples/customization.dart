@JS()
library selectize.exmple.customize;

// Copyright (c) 2016, kaopeter. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:js/js.dart';
import 'package:selectize/selectize.dart';

@JS()
@anonymous
class MyOpt extends BaseOption {
  external String get title;
  external String get url;
  external int get id;
  external factory MyOpt({int id, String title, String url});
}

main() async {
  selectize(
      '#select-links',
      new SelectOptions(
          maxItems: null,
          valueField: 'id',
          searchField: 'title',
          options: [
            new MyOpt(id: 1, title: 'DIY', url: 'https://diy.org'),
            new MyOpt(id: 2, title: 'Google', url: 'http://google.com'),
            new MyOpt(id: 3, title: 'Yahoo', url: 'http://yahoo.com'),
          ],
          render: new RenderFuns(option: allowInterop((MyOpt data, escape) {
            return '<div class="option">' +
                '<span class="title">' +
                escape(data.title) +
                '</span>' +
                '<span class="url">' +
                escape(data.url) +
                '</span>' +
                '</div>';
          }), item: allowInterop((MyOpt data, escape) {
            return '<div class="item"><a href="${escape(data.url)}">${escape(data.title)}</a></div>';
          })),
          create: allowInterop((input) {
            return new MyOpt(id: 0, title: input, url: '#');
          })));
}
