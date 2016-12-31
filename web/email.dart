// Copyright (c) 2016, kaopeter. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:js/js.dart';
import 'package:selectize/selectize.dart';
import 'dart:html';

var REGEX_EMAIL = r"([a-z0-9!#$%&\'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&\'*+/=?^_`{|}~-]+)*@" +
    r"(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)";

main() async {
  var mailOptions = <MailBaseOption>[
    new MailBaseOption(email: 'nikola@tesla.com', name: 'Nikola Tesla', index: 2),
    new MailBaseOption(email: 'brian@thirdroute.com', name: 'Brian Reavis', index: 1),
    new MailBaseOption(email: 'someone@gmail.com'),
    new MailBaseOption(email: "c@a.com", name: "c")
  ];
  Selectize emailSelect = selectize(
      "#select-to",
      new SelectOptions(
          onInitialize: allowInterop(() {
            print("init");
          }),
          onChange: allowInterop((List value) {
            querySelector('.mail').text = value?.join(',');
            print("mail change value ${value}");
          }),
          onItemAdd: allowInterop((value, item) {
            print("item change  ${value}  , ${item}");
          }),
          valueField: "email",
          sortField: "index",
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
          createFilter: jsRegExp(REGEX_EMAIL),
          options: mailOptions));
  emailSelect.on('change', allowInterop((e) {
    print(emailSelect.items);
  }));
  emailSelect.createItem("d@a.com", false);
  emailSelect.settings.maxItems = 4;
}
