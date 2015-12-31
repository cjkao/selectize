// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library my_project.web.index;

import 'dart:html';
import 'dart:async';
import 'package:js/js.dart';
import 'package:selectize/selectize.dart';

/// [MainApp] used!
main() async {
  var iTag = selectize('#select-box');
  print(iTag.options);
  var selState = selectize('#select-state',
      new SelectOptions(maxItems: 5, maxOptions: 3, plugins: ['restore_on_backspace', 'remove_button', 'drag_drop']));
  var se = querySelector("#select-state");
  var REGEX_EMAIL = r"([a-z0-9!#$%&\'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&\'*+/=?^_`{|}~-]+)*@" +
      r"(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)";
  var mailOptions = [
    new XBaseOption(email: 'brian@thirdroute.com', name: 'Brian Reavis'),
    new XBaseOption(email: 'nikola@tesla.com', name: 'Nikola Tesla'),
    new XBaseOption(email: 'someone@gmail.com'),
    new XBaseOption(email: "c@a.com", name: "c")
  ];
  var emailSelect = selectize(
      "#select-to",
      new SelectOptions(
          items: ["c@a.com"],
          valueField: "email",
          labelField: "name",
          searchField: ['name', 'email'],
          maxItems: null,
          render: new RenderFuns(item: allowInterop((XBaseOption item, escape) {
            return '<div>' +
                (item.name != null ? '<span class="name"> ${item.name} </span>' : '') +
                (item.email != null ? '<span class="email"> ${item.email} </span>' : '') +
                '</div>';
          }), option: allowInterop((item, escape) {
            return '<div>'
                '<span class="label"> ${item.name ?? item.email}'
                '</span>'
                '</div>';
          })), create: allowInterop((String input, Function cb) {
        var reg = new RegExp(REGEX_EMAIL);
        if (reg.hasMatch(input)) {
          return new XBaseOption(email: input);
        }
      }), options: mailOptions));
  emailSelect.on('change', (e) {
    //print(emailSelect.items);
  });
  //emailSelect.createItem("d@a.com", () {});
  emailSelect.createItem("d@a.com");
  //Element e;
  //e.onChange.listen()
  selState.on('change', (e) {
    print('change evt $e');
  });
  var seCount = selectize('#select-country');
  seCount.on("change", (e) {
    print('change evt $e');
  });
//  new Timer.periodic(new Duration(seconds: 2), (timer) {
  new Timer(new Duration(seconds: 1), () {
    selState.off('change');
    se.selectedOptions.forEach((o) => print(o.value));
    //print(iTag.getOption('small'));
    iTag.addOption(new OptValue(value: "tiny", text: 'TINY'));
    iTag.refreshOptions(true);
    print(optionByValue(iTag.options, 'small').text);
    print(new JOptions(iTag.options)['small']);
    print(iTag.items);
    //iTag.destroy();
  });
}
