// Copyright (c) 2016, kaopeter. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library cj.angular2.selective;

import 'dart:html';
import 'dart:async';
import 'package:js/js.dart';
import 'package:selectize/selectize.dart';
import 'dart:js' as js;

var REGEX_EMAIL = r"([a-z0-9!#$%&\'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&\'*+/=?^_`{|}~-]+)*@" +
    r"(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)";
_toDartSimpleObject(thing) {
  if (thing is js.JsArray) {
    List res = new List();
    js.JsArray a = thing as js.JsArray;
    a.forEach((otherthing) {
      res.add(_toDartSimpleObject(otherthing));
    });
    return res;
  } else if (thing is js.JsObject) {
    Map res = new Map();
    js.JsObject o = thing as js.JsObject;
    Iterable<String> k = js.context['Object'].callMethod('keys', [o]);
    k.forEach((String k) {
      res[k] = _toDartSimpleObject(o[k]);
    });
    return res;
  } else {
    return thing;
  }
}

/// [MainApp] used!
main() async {
//  await jqSelectBootstrap();
  var iTag = selectize('#select-box');
  iTag.addOption(new OptValue(value: '1', text: 'a'));
  iTag.addOption(new OptValue(value: "tiny", text: 'TINY'));
  iTag.createItem('x');
//  var xx = _toDartSimpleObject(iTag.options);
  var zz = js.context['Object'].callMethod('keys', [iTag.options]);
  var xx = optionList(iTag.options);
  print(xx);
//  tt.addItem('big');
//  var iTag = selectize('#select-box');
//  iTag.addOption(new OptValue(value: '1', text: 'a'));
//  print(iTag.options);
  var selState = selectize('#select-state',
      new SelectOptions(maxItems: 5, maxOptions: 3, plugins: ['restore_on_backspace', 'remove_button', 'drag_drop']));
  querySelector("#select-state");
  var mailOptions = [
    new MailBaseOption(email: 'nikola@tesla.com', name: 'Nikola Tesla'),
    new MailBaseOption(email: 'brian@thirdroute.com', name: 'Brian Reavis'),
    new MailBaseOption(email: 'someone@gmail.com'),
    new MailBaseOption(email: "c@a.com", name: "c")
  ];
  Selectize emailSelect = selectize(
      "#select-to",
      new SelectOptions(
          onInitialize: allowInterop(() {
            print("init");
          }),
          onChange: allowInterop((value) {
            print("change value ${value}");
          }),
          onItemAdd: allowInterop((value, item) {
            print("item change  ${value}  , ${item}");
          }),
          valueField: "email",
          sortField: "email",
          labelField: "name",
          searchField: ['name', 'email'],
          maxItems: null,
          persist: true,
          hideSelected: true,
          render: new RenderFuns(item: allowInterop((MailBaseOption item, escape) {
            return '<div>' +
                (item.name != null ? '<span class="name"> ${item.name} </span>' : '') +
                (item.email != null ? '<span class="email"> ${item.email} </span>' : '') +
                '</div>';
          }), option: allowInterop((item, escape) {
            return '<div>'
                '<span class="label"> ${item.name ?? item.email}'
                '</span>'
                '</div>';
          })),
          create: allowInterop((String input, Function cb) {
            var reg = new RegExp(REGEX_EMAIL);
            if (reg.hasMatch(input)) {
              return new MailBaseOption(email: input);
            }
          }),
          options: mailOptions));
  emailSelect.on('change', allowInterop((e) {
    print(emailSelect.items);
  }));
  var seCount = selectize('#select-country')
    ..addItem('NZ')
    ..setValue('TW');
  //emailSelect.createItem("d@a.com", () {});
  emailSelect.createItem("d@a.com", false);

  emailSelect.settings.maxItems = 4;
  //emailSelect.settings.options = [new OptValue(value: 'a@a', text: 'a')];
  selState.on('change', allowInterop((e) {
    print('change evt $e');
  }));
  seCount.on("change", allowInterop((e) {
    print('change evt $e');
  }));
//  new Timer.periodic(new Duration(seconds: 2), (timer) {
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
  //book.disable();
  var book2 = selectize('#select-book-2', new SelectOptions()..maxItems = 2);
  book2.addOption(new OptValue(value: '1', text: 'a'));
  book2.addOption(new OptValue(value: '21', text: 'ba'));
}
