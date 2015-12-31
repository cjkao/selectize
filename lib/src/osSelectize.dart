library osSelectize;

import 'package:js/js.dart';
import 'dart:js';
import 'package:func/func.dart';

///e string or array
typedef EventHandler(value);

@JS("jqSelectize")
external Selectize selectize(String selector, [SelectOptions]);

@JS()
@anonymous
class SelectOptions {
  /// list of [valueField]
  external List<String> get items;

  ///The string to separate items by.
  ///  This option is only used when Selectize is instantiated
  /// from a <input type="text"> element.
  external String get delimiter;

  ///The max number of items to render at once in the dropdown list of options.
  external int get maxOptions;

  /// max selectable item
  external int get maxItems; //: 3
  external bool get persist;
  external String get valueField;
  external String get labelField;
  external List<BaseOption> get options;
  external List<String> get searchField;
  external List<String> get plugins; //: ['restore_on_backspace']
  external RenderFuns get render;
  external Func1<bool, String> get createFilter;

  /// "input" and "callback". The callback should be invoked with the final data for the option.
  external Func2<bool, String, Function> get create;
  external factory SelectOptions(
      {List items,
      String delimiter,
      int maxOptions,
      int maxItems,
      bool persist,
      String valueField,
      String labelField,
      List<BaseOption> options,
      List<String> searchField,
      List<String> plugins,
      RenderFuns render,
      Func1<bool, String> createFilter,
      Func2<bool, String, Function> create});
}

@JS("Selectize")
class Selectize {
  external Selectize();
/** for items ************************/

  ///"Selects" an item. Adds it to the list at the current caret position.
  ///  If [silent] is true, no change event will be fired on the original input.
  external addItem(String value, bool silent);

  ///Removes the selected item matching the provided value.
  ///  If [silent] is truthy, no change event will be fired on the original input.
  external removeItem(value, silent);

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
  external focus();
  external blur();
  external lock();

  ///Re-enables user input on the control.
  external unlock();

  ///Disables user input on the control completely. While disabled, it cannot receive focus.
  external disable();

  ///Enables the control so that it can respond to focus and user input.
  external enable();

  ///this return union type, array or string
  external getValue();
  external setValue(value, bool silent);

  ///Moves the caret to the specified position ("index" being the index in the list of selected items).
  external setCaret(index);

  ///Returns whether or not the user can select more items.
  external isFull();

  ///Clears the render cache. Takes an optional [template] argument
  ///  (e.g. "option", "item") to clear only that cache.
  external clearCache(String template);

  ///Adds an available option, or array of options. If it already exists, nothing will happen.
  ///Note: this does not refresh the options list dropdown (use refreshOptions() for that).
  external addOption(OptValue data);

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
  /// [event]
  ///   'initialize'
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
  ///		'type'
  ///		'load'
  ///		'focus'
  ///		'blur'
  external on(String event, EventHandler handler);

  /// remove event listener
  external off(String event, [EventHandler handler]);
  external trigger(String event);
  external render();
}

@JS('options')
@anonymous
class Options {
  external Options();
}

/// Option wrapper to access OptValue
/// not work, return null
class JOptions {
  Options _option;
  JsObject _opt;
  JOptions(this._option) {
    _opt = new JsObject.fromBrowserObject(_option);
  }
  OptValue operator [](String tag) => _opt[tag];
}

@JS("jqOptionByValue")
external OptValue optionByValue(Options options, String key);

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

/// any object extend from BaseOption is compitable
@JS()
@anonymous
class XBaseOption extends BaseOption {
  external String get email;
  external String get name;
  external factory XBaseOption({String email, String name});
}
//class OptValue
// @JS()
// @anonymous
// class Items { external String score, }
