// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
library osSelectize;

import 'package:js/js.dart';
//import 'dart:js';
import 'package:func/func.dart';
import 'dart:html';

/// [value] string or array
typedef EventHandler(value);

/// link jQuery and Selectize with helper function
/// global object __DartJsSelect will inject to document head
jqSelectBootstrap() {
  if (querySelector('#__DartJqSelect') == null) {
    var scr = new ScriptElement();
    scr.id = '__DartJqSelect';

    scr.appendText(r"""
  var __DartJqSelect = __DartJqSelect || {
    create:function (selector, option){
      return $(selector).selectize(option)[0].selectize;
    },
    getOptionByValue:function (obj,key){
      return obj[key];
    }
  };
  """);
    //var selectizeJs = new ScriptElement();
    //selectizeJs.src = 'packages/selectize/selectize.js';
    //querySelector('head').append(selectizeJs);
    querySelector('head').append(scr);
  }
}

@JS("__DartJqSelect.create")
external Selectize selectize(String selector, [SelectOptions]);

/// access option value by it's dynamic key
@JS("__DartJqSelect.getOptionByValue")
external OptValue optionByValue(Options options, String key);

/// Selectize Configuration
@JS()
@anonymous
class SelectOptions {
  /// list of [valueField], read only in Dartium, work in Chrome
  external List<String> get items;

  ///The string to separate items by.
  ///  This option is only used when Selectize is instantiated
  /// from a <input type="text"> element.
  external String get delimiter;

  ///The max number of items to render at once in the dropdown list of options.
  /// default: 1000
  external int get maxOptions;

  /// max selectable item
  external int get maxItems; //: 3
  external String get valueField;
  external String get labelField;

  /// String or Array
  ///A single field or an array of fields to sort by. Each item in the array should be an object containing
  ///  at least a "field" property.
  /// Optionally, "direction" can be set to "asc" or "desc". The order of the array defines the sort precedence.
  external String get sortField;

  external List<BaseOption> get options;
  external List<String> get searchField;
  external List<String> get plugins; //: ['restore_on_backspace']
  external RenderFuns get render;

  ///If true, when user exits the field (clicks outside of input or presses ESC)
  /// new option is created and selected (if `create`-option is enabled).
  external bool get createOnBlur;

  ///Specifies a RegExp or String containing a regular expression that the current search filter must match to be
  /// allowed to be created. May also be a predicate function that takes the filter text and returns whether it is allowed.
  external Func1<bool, String> get createFilter;

  /// "input" and "callback". The callback should be invoked with the final data for the option.
  external Func2<bool, String, Function> get create;

  ///Toggles match highlighting within the dropdown menu.
  /// default: true
  external bool get highlight;

  ///If false, items created by the user will not show up as available options once they are unselected.
  ///default: true
  external bool get persist;

  ///Show the dropdown immediately when the control receives focus.
  /// default true
  external bool get openOnFocus;

  ///If true, the items that are currently selected will not be shown in the dropdown list of available options.
  /// default true
  external bool get hideSelected;

  ///  If true, the dropdown will be closed after a selection is made.
  /// default: false
  external bool get closeAfterSelect;
  //************** CALLBACK ***********************//
  ///Invoked once the control is completely initialized.
  external VoidFunc0 get onInitialize;

  /// nvoked when the control gains focus.
  external VoidFunc0 get onFocus;

  ///Invoked when the control loses focus.
  external VoidFunc0 get onBlur;

  ///invoked when the value of the control changes.
  external VoidFunc1 get onChange;

  ///Invoked when an item is selected.
  /// value, $item
  external VoidFunc2 get onItemAdd;

  ///Invoked when an item is selected.
  /// value, $item
  external VoidFunc1 get onItemRemove;

  ///  Invoked when the control is manually cleared via the clear() method.
  external VoidFunc0 get onClear;

  /// Invoked when the user attempts to delete the current selection.
  external VoidFunc1 get onDelete;

  ///Invoked when a new option is added to the available options list.
  /// value, data
  external VoidFunc2 get onOptionAdd;

  ///	Invoked when an option is removed from the available options.
  external VoidFunc1 get onOptionRemove;

  ///Invoked when the dropdown open.
  external VoidFunc1 get onDropdownOpen;

  ///Invoked when the dropdown closes.
  external VoidFunc1 get onDropdownClose;

  ///nvoked when the user types while filtering options.
  external VoidFunc1<String> get onType;

  external factory SelectOptions(
      {List items,
      String delimiter,
      int maxOptions,
      int maxItems,
      String valueField,
      String labelField,
      String sortField,
      List<BaseOption> options,
      List<String> searchField,
      List<String> plugins,
      RenderFuns render,
      bool createOnBlur,
      Func1<bool, String> createFilter,
      Func2<bool, String, Function> create,
      bool highlight,
      bool persist,
      bool openOnFocus,
      bool hideSelected,
      bool closeAfterSelec,
      VoidFunc0 onInitialize,
      VoidFunc0 onFocus,
      VoidFunc0 onBlur,
      VoidFunc1 onChange,
      VoidFunc2 onItemAdd,
      VoidFunc1 onItemRemove,
      VoidFunc1 onDelete,
      VoidFunc2 onOptionAdd,
      VoidFunc1 onOptionRemove});
}

@JS("Selectize")
class Selectize {
  external Selectize();
/** for items ************************/

  ///"Selects" an item. Adds it to the list at the current caret position.
  ///  If [silent] is true, no change event will be fired on the original input.
  external void addItem(String value, bool silent);

  ///Removes the selected item matching the provided value.
  ///  If [silent] is truthy, no change event will be fired on the original input.
  external void removeItem(value, silent);

  ///Invokes the "create" method provided in the selectize options that should provide the data for the new item,
  ///  given the user input. Once this completes, it will be added to the item list.
  //external createItem(value, callback);
  external createItem(value);

  /// Re-renders the selected item lists.
  external refreshItems();

  ///Resets or clears all selected items from the control. If [silent] is truthy,
  ///j no change event will be fired on the original input.
  external clear(bool silent);

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

  external void setValue(value, bool silent);

  ///Moves the caret to the specified position ("index" being the index in the list of selected items).
  external void setCaret(index);

  ///Returns whether or not the user can select more items.
  external bool isFull();

  ///Clears the render cache. Takes an optional [template] argument
  ///  (e.g. "option", "item") to clear only that cache.
  external void clearCache(String template);

  ///Adds an available option, or array of options. If it already exists, nothing will happen.
  ///Note: this does not refresh the options list dropdown (use refreshOptions() for that).
  external addOption(OptValue data);

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
  ///A list of matched results.
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

@JS('options')
@anonymous
class Options {
  external Options();
}

//TODO base object can be $order
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
  external Func2<String, BaseOption, Func1<String, String>> get item;

  /// customized option list
  external Func2<String, BaseOption, Func1<String, String>> get option;
  external factory RenderFuns({Func2 item, Func2 option});
}

/// for program to dynamic create option list
@JS()
@anonymous
class BaseOption {}

/// require two fields, one for
/// any object extend from BaseOption is compitable
@JS()
@anonymous
class MailBaseOption extends BaseOption {
  external String get email;
  external String get name;
  external factory MailBaseOption({String email, String name});
}
