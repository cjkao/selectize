// Copyright (c) 2016, kaopeter. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library cj.angular2.selective;

import 'dart:html';
import 'dart:async';
import 'package:js/js.dart';
import 'package:selectize/selectize.dart';
import 'package:angular2/angular2.dart';
import 'package:angular2/bootstrap.dart';
import 'dart:math' as math;

@Component(
    selector: 'my-app',
    template: '''<h1>Angular 2 Selectize </h1>
    <jq-selective></jq-selective>
    <jq-selective-min></jq-selective-min>''',
    directives: const [NgSelectize, NgSelectize2])
class AppComponent {}

@Component(selector: 'jq-selective')
@View(
    template: r'''
<div> {{selectedValue}}</div>
<select  [ngClass]="classes"    placeholder="Pick some people..."></select>
            ''',
    directives: const [NgClass])
class NgSelectize implements AfterViewInit, OnDestroy, OnInit {
  ElementRef elelemtRef;
  NgZone zone;
  String selectedValue = 'c@a.com';
  List<String> classes;
  int uniqueNs;
  Selectize _select;
  ngOnDestroy() {
    _select.destroy();
  }

  ngOnInit() {
    uniqueNs = new math.Random().nextInt(1000000000);
    classes = ["select-ag$uniqueNs"];
  }

  ngAfterViewInit() {
    //var el = elelemtRef.nativeElement.children[0];
    //print("ng selective $el");
    _select = selectize(
        ".select-ag$uniqueNs",
        new SelectOptions(
            items: [selectedValue],
            onChange: allowInterop((value) {
              print("ng change value ${value}");
              zone.run(() => this.selectedValue = value);
            }),
            maxItems: 3,
            valueField: "email",
            sortField: "email",
            labelField: "name",
            searchField: ['name', 'email'],
            persist: true,
            create: allowInterop((String input, Function cb) {
              var reg = new RegExp(REGEX_EMAIL);
              if (reg.hasMatch(input)) {
                return new MailBaseOption(email: input);
              }
            }),
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
            options: [
              new MailBaseOption(email: 'nikola@tesla.com', name: 'Nikola Tesla'),
              new MailBaseOption(email: 'brian@thirdroute.com', name: 'Brian Reavis'),
              new MailBaseOption(email: 'c@a.com')
            ]));
  }

  NgSelectize(this.elelemtRef, this.zone) {
    print("construct");
  }
}

@Component(selector: 'jq-selective-min')
@View(
    template: r'''<div> {{selectedValue}}</div>
    <select [ngClass]="classes"  multiple class="demo-default" style="width:70%" placeholder="Select a box...">
      <option value="">Select a box...</option>
      <option value="big">big</option>
      <option value="small">small</option>
    </select>
            ''',
    directives: const [NgClass])
class NgSelectize2 implements AfterViewInit, OnDestroy, OnInit {
  NgZone zone;
  String selectedValue = '[]';
  List<String> classes;
  int _uniqueNs;
  Selectize _select;
  ngOnDestroy() {
    _select.destroy();
  }

  ngOnInit() {
    _uniqueNs = new math.Random().nextInt(1000000000);
    classes = ["select-ag$_uniqueNs"];
  }

  ngAfterViewInit() {
    _select = selectize(".select-ag$_uniqueNs");

    _select.on('change', allowInterop((e) {
      zone.run(() => selectedValue = _select.items.toString());
    }));
  }

  NgSelectize2(this.zone);
}

var REGEX_EMAIL = r"([a-z0-9!#$%&\'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&\'*+/=?^_`{|}~-]+)*@" +
    r"(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)";

/// [MainApp] used!
main() async {
  await jqSelectBootstrap();
  bootstrap(AppComponent);
  var iTag = selectize('#select-box');
  print(iTag.options);
  var selState = selectize('#select-state',
      new SelectOptions(maxItems: 5, maxOptions: 3, plugins: ['restore_on_backspace', 'remove_button', 'drag_drop']));
  var se = querySelector("#select-state");
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
          hideSelected: false,
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
  emailSelect.on('change', (e) {
    print(emailSelect.items);
  });
  var seCount = selectize('#select-country');
  //emailSelect.createItem("d@a.com", () {});
  emailSelect.createItem("d@a.com");
  selState.on('change', allowInterop((e) {
    print('change evt $e');
  }));
  seCount.on("change", allowInterop((e) {
    print('change evt $e');
  }));
//  new Timer.periodic(new Duration(seconds: 2), (timer) {
  new Timer(new Duration(seconds: 1), () {
//  selState.off('change');
//    selState.print("is lock: ${selState.isLocked}");
    se.selectedOptions.forEach((o) => print(o.value));
    //print(iTag.getOption('small'));
    iTag.addOption(new OptValue(value: "tiny", text: 'TINY'));
    iTag.refreshOptions(true);
    print(optionByValue(iTag.options, 'small').text);
//    print(new JOptions(iTag.options)['small'].text);
//    print(iTag.items);
    //iTag.destroy();
  });
}
