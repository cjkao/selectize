// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
@JS()
library osSelectize;

import 'package:js/js_util.dart';
import 'package:js/js.dart';
import 'dart:js' as js;
import 'package:func/func.dart';
import 'base.dart';
import 'configuration.dart';

/// [value] string or array
typedef EventHandler(value);

@deprecated
jqSelectBootstrap() {}

@JS("\$")
external JQuery _jquery(String selector);

@anonymous
@JS()
abstract class JQuery {
  external JQuery selectize([options]);
}

@JS('RegExp')
external jsRegExp(String value);

/// access option value by it's dynamic key
OptValue optionByValue(Options options, String key) {
  return getProperty(options, key);
}

///
///
/// return OptValue list in Dart
List<OptValue> optionList(Options options) {
  var keys = js.context['Object'].callMethod('keys', [options]);
  List<OptValue> ops = [];
  keys.forEach((_) => ops.add(getProperty(options, _)));
  return ops;
}

@JS("Selectize")
abstract class Selectize {
  external Selectize();
/** for items ************************/
  external SelectOptions get settings;

  ///"Selects" an item. Adds it to the list at the current caret position.
  ///  If [silent] is true, no change event will be fired on the original input.
  external void addItem(String value, [bool silent = false]);

  ///Removes the selected item matching the provided value.
  ///  If [silent] is truthy, no change event will be fired on the original input.
  external void removeItem(value, [bool silent = false]);

  ///Invokes the [create] method provided in the selectize options that should provide the data for the new item,
  ///  given the user input. Once this completes, it will be added to the item list.
  //external createItem(value, callback);
  external createItem(value, [bool triggerDropDwon = false]);

  /// Re-renders the selected item lists.
  external refreshItems();

  ///Resets or clears all selected items from the control. If [silent] is truthy,
  ///j no change event will be fired on the original input.
  external clear([bool silent = false]);

/*  Other      ******** *****/
  ///Destroys the control and unbinds event listeners so that it can be garbage collected.
  external destroy();

  external load(Function fn);

  ///  Brings the control into focus.
  external void focus();
  external void blur();
  external void lock();

  ///Re-enables user input on the control.
  external unlock();

  ///Disables user input on the control completely. While disabled, it cannot receive focus.
  external disable();

  ///Enables the control so that it can respond to focus and user input.
  external enable();

  ///return union type, array or string
  ///Returns the value of the control. If multiple items can be selected (e.g. <select multiple>,
  /// this returns an array. If only one item can be selected, this returns a string.
  external getValue();

  ///
  ///  Resets the selected items to the given value.
  ///  @param {mixed} value
  ///
  external void setValue(value, [bool silent = false]);

  ///Moves the caret to the specified position ("index" being the index in the list of selected items).
  external void setCaret(index);

  ///Returns whether or not the user can select more items.
  external bool isFull();

  ///Clears the render cache. Takes an optional [template] argument
  ///  (e.g. "option", "item") to clear only that cache.
  external void clearCache(String template);

  ///Adds an available option, or array of options. If it already exists, nothing will happen.
  ///Note: this does not refresh the options list dropdown (use refreshOptions() for that).
  external addOption(dynamic /*List or OptValue*/ data);

  //addOptions(List<OptValue> list) => list.forEach(addOption);

  ///Updates an option available for selection. If it is visible in the selected items or options dropdown,
  ///it will be re-rendered automatically.
  external void updateOption(value, OptValue data);

  ///Removes the option identified by the given value.
  external void removeOption(value);

  ///Removes all options from the control.
  external void clearOptions();
  //external List<Element> getOption(String value);

  /// Re-renders the selected item lists.
  external void refreshOptions(bool triggerDropdown);

/*  for DropDown **********************************/
  ///Shows the autocomplete dropdown containing the available options.
  external void open();

  /// Closes the autocomplete dropdown menu.
  external void close();

  /// Calculates and applies the appropriate position of the dropdown.
  external void positionDropdown();

  /** Properties  *******************************************************/
  /// A list of matched results. [items] selected options
  external List<String> get items;

  /// An object containing the entire pool of options. The object is keyed by each object's value.
  external Options get options;

/*  for EVENT **********************************/
  /// [event] including following
  /// initialize, Invoked once the control is completely initialized.
  ///		'change'
  ///   'item_add'
  ///		'item_remove'
  ///		'clear'
  ///		'option_add'
  ///		'option_remove'
  ///		'option_clear'
  ///		'optgroup_add'
  ///		'optgroup_remove' ,
  ///		'optgroup_clear'
  ///		'dropdown_open'
  ///		'dropdown_close'
  ///		'type'   Invoked when the user types while filtering options.
  ///		'load'
  ///		'focus'
  ///		'blur'
  /// [handler] must call allowInterOp, trigger from jquery
  /// see [https://github.com/selectize/selectize.js/blob/master/docs/events.md]
  external on(String event, EventHandler handler);

  /// remove event listener
  /// [handler] must call allowInterOp, trigger from jquery
  external off(String event, [EventHandler handler]);
  external trigger(String event);
  external render();

/******* properties *************************/
  external bool get isOpen;
  external bool get isDisabled;
  external bool get isRequired;
  external bool get isInvalid;
  external bool get isLocked;
  external bool get isFocused;
  external bool get isInputHidden;
  external bool get isSetup;
  external bool get isShiftDown;
  external bool get isCmdDown;
  external bool get isCtrlDown;
  external bool get ignoreFocus;
  external bool get ignoreBlur;
  external bool get ignoreHover;
  external bool get hasOptions;
  external int get caretPos;

  /// Input or Select
  external String get tagType;

  external static Function getScoreFunction(val);
}

/// require two fields, one for
/// any object extend from BaseOption is compitable
@JS()
@anonymous
class MailBaseOption extends BaseOption {
  external String get email;
  external String get name;
  external int get index;
  external factory MailBaseOption({String email, String name, int index});
}

Selectize selectize(String selector, [SelectOptions opt]) {
  if (opt == null) {
    opt = new SelectOptions();
  }
  if (opt.create == null) {
    opt.create = true;
  }
  var j0 = _jquery(selector);
  var j1 = j0.selectize(opt);
  print('hasp   ${hasProperty(j1,"0")}');
  var x1 = getProperty(j1, '0');
  var x2 = getProperty(x1, 'selectize');
  return x2;
}
