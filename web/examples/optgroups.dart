@JS()
library selectize.exmple.group;

// Copyright (c) 2016, kaopeter. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:js/js.dart';
import 'package:selectize/selectize.dart';

@JS()
@anonymous
class CarOpt extends BaseOption {
  external String get model;
  external String get make;
  external String get id;
  external factory CarOpt({String id, String make, String model});
}

@JS()
@anonymous
class CarGroup extends BaseOption {
  external int get $order;
  external String get id;
  external String get name;
  external factory CarGroup({int $order, String id, String name});
}

@JS()
@anonymous
class AnimalOpt extends BaseOption {
  external String get clz;
  external String get value;
  external String get name;
  external factory AnimalOpt({String clz, String value, String name});
}

@JS()
@anonymous
class AnimalGroup extends BaseOption {
  external String get value;
  external String get label;
  external String get label_scientific;
  external factory AnimalGroup({String value, String label, String label_scientific});
}

main() async {
  selectize('#select-gear-disabled', new SelectOptions(sortField: 'text'));
  selectize('#select-gear', new SelectOptions(sortField: 'text'));
  selectize('#select-repeated-options', new SelectOptions(sortField: 'text'));
  selectize(
      "#select-car",
      new SelectOptions(
          options: [
            new CarOpt(id: 'avenger', make: 'dodge', model: 'Avenger'),
            new CarOpt(id: 'caliber', make: 'dodge', model: 'Caliber'),
            new CarOpt(id: 'caravan-grand-passenger', make: 'dodge', model: 'Caravan Grand Passenger'),
            new CarOpt(id: 'challenger', make: 'dodge', model: 'Challenger'),
            new CarOpt(id: 'ram-1500', make: 'dodge', model: 'Ram 1500'),
            new CarOpt(id: 'viper', make: 'dodge', model: 'Viper'),
            new CarOpt(id: 'a3', make: 'audi', model: 'A3'),
            new CarOpt(id: 'a6', make: 'audi', model: 'A6'),
            new CarOpt(id: 'r8', make: 'audi', model: 'R8'),
            new CarOpt(id: 'rs-4', make: 'audi', model: 'RS 4'),
            new CarOpt(id: 's4', make: 'audi', model: 'S4'),
            new CarOpt(id: 's8', make: 'audi', model: 'S8'),
            new CarOpt(id: 'tt', make: 'audi', model: 'TT'),
            new CarOpt(id: 'avalanche', make: 'chevrolet', model: 'Avalanche'),
            new CarOpt(id: 'aveo', make: 'chevrolet', model: 'Aveo'),
            new CarOpt(id: 'cobalt', make: 'chevrolet', model: 'Cobalt'),
            new CarOpt(id: 'silverado', make: 'chevrolet', model: 'Silverado'),
            new CarOpt(id: 'suburban', make: 'chevrolet', model: 'Suburban'),
            new CarOpt(id: 'tahoe', make: 'chevrolet', model: 'Tahoe'),
            new CarOpt(id: 'trail-blazer', make: 'chevrolet', model: 'TrailBlazer'),
          ],
          optgroups: [
            new CarGroup($order: 3, id: 'dodge', name: 'Dodge'),
            new CarGroup($order: 2, id: 'audi', name: 'Audi'),
            new CarGroup($order: 1, id: 'chevrolet', name: 'Chevrolet')
          ],
          labelField: 'model',
          valueField: 'id',
          optgroupField: 'make',
          optgroupLabelField: 'name',
          optgroupValueField: 'id',
          lockOptgroupOrder: true,
          searchField: ['model'],
          plugins: ['optgroup_columns'],
          openOnFocus: false));

  selectize(
      '#select-animal',
      new SelectOptions(
          options: [
            new AnimalOpt(clz: 'mammal', value: "dog", name: "Dog"),
            new AnimalOpt(clz: 'mammal', value: "cat", name: "Cat"),
            new AnimalOpt(clz: 'mammal', value: "horse", name: "Horse"),
            new AnimalOpt(clz: 'mammal', value: "kangaroo", name: "Kangaroo"),
            new AnimalOpt(clz: 'bird', value: 'duck', name: 'Duck'),
            new AnimalOpt(clz: 'bird', value: 'chicken', name: 'Chicken'),
            new AnimalOpt(clz: 'bird', value: 'ostrich', name: 'Ostrich'),
            new AnimalOpt(clz: 'bird', value: 'seagull', name: 'Seagull'),
            new AnimalOpt(clz: 'reptile', value: 'snake', name: 'Snake'),
            new AnimalOpt(clz: 'reptile', value: 'lizard', name: 'Lizard'),
            new AnimalOpt(clz: 'reptile', value: 'alligator', name: 'Alligator'),
            new AnimalOpt(clz: 'reptile', value: 'turtle', name: 'Turtle')
          ],
          optgroups: [
            new AnimalGroup(value: 'mammal', label: 'Mammal', label_scientific: 'Mammalia'),
            new AnimalGroup(value: 'bird', label: 'Bird', label_scientific: 'Aves'),
            new AnimalGroup(value: 'reptile', label: 'Reptile', label_scientific: 'Reptilia')
          ],
          optgroupField: 'clz',
          labelField: 'name',
          searchField: ['name'],
          render: new RenderFuns(optgroup_header: allowInterop((data, escape) {
            return '<div class="optgroup-header">' +
                escape(data.label) +
                ' <span class="scientific">' +
                escape(data.label_scientific) +
                '</span></div>';
          }))));
}
