Selectize wrapper
======================================

# Setup
* include snippets after dart script
```javascript
<script src='jquery220.js'></script>
<script src='jqueryui.min.js'></script> // only for drag and drop
<script src='packages/selectize/selectize.js'></script>
<link rel="stylesheet" href="packages/selectize/selectize.css">
```

---

# Example
see web/index.html

## Simple case
* dart

```dart
  selectize('#select-state',
      new SelectOptions(maxItems: 5, maxOptions: 3, plugins: ['restore_on_backspace', 'remove_button', 'drag_drop']));
```      

* HTML

```html
<section class="demo">
  <div class="header">
    Max Items
  </div>
  <div class="sandbox">
    <select id="select-state" name="state[]" multiple class="demo-default" style="width:70%" placeholder="Select a state...">
      <option value="">Select a state...</option>
      <option value="AL">Alabama</option>
      <option value="AK">Alaska</option>
      <option value="WY" selected>Wyoming</option>
    </select>
  </div>
  <div class="description">
    This example only allows 3 items. Select one more item and the control will be disabled
    until one or more are deleted.
  </div>
</section>
```

## Complex customize

* create your own new option class from `BaseOption`

```dart

var REGEX_EMAIL = r"([a-z0-9!#$%&\'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&\'*+/=?^_`{|}~-]+)*@" +
    r"(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)";

var mailOptions = [
  new MailBaseOption(email: 'nikola@tesla.com', name: 'Nikola Tesla'),
  new MailBaseOption(email: 'brian@thirdroute.com', name: 'Brian Reavis'),
  new MailBaseOption(email: 'someone@gmail.com'),
  new MailBaseOption(email: "c@a.com", name: "c")
];
var emailSelect = selectize(
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
```
* html

```html
<section class="demo">
  <div class="header">
    Email Contacts
  </div>
  <div class="sandbox">
    <label for="select-to">Email:</label>
    <select id="select-to" class="contacts" placeholder="Pick some people..."></select>
  </div>
  <div class="description">
    This demonstrates two main things: (1) custom item and option rendering, and (2) item creation on-the-fly.
    Try typing a valid and invalid email address.
  </div>

</section>
```

---

## Angular2 Entry
* Dart
```dart
@Component(
    selector: 'my-app',
    template: '''<h1>Angular 2 Selectize </h1>
    <jq-selective></jq-selective>
    <jq-selective-min></jq-selective-min>''',
    directives: const [NgSelectize, NgSelectize2])
class AppComponent {}
```
* HTML
```
<section class="demo">
  <my-app>Loading...</my-app>
</section>
```

## Angular2 Simple

```dart
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
```

## Angular2 Complex

```dart
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

```
#Utility
* `jsRegExp(String regStr)` create JS regexp
* `optionByValue(item_value)` return OptValue by given value
* `List<OptValue> optionList(Options options)` return list of OptValue

# Note
* allowInterop is necessary for callback
* angular2 select item change should wrap into zone
* dart script must defer loading to wait javascript library ready
```javascript
     <script defer type="application/dart" src="index.dart"></script>
```
* Utils.isArray is changed in  `selectize.js` for chormium  


# test
`pub run test test/testCommon.dart -p dartium`
