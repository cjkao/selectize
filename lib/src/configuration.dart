// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
@JS()
library selectize.configuration;

import 'base.dart';
import 'package:js/js.dart';
import 'package:func/func.dart';
import 'base.dart';

/// Selectize Configuration
@JS()
@anonymous
class SelectOptions {
  /// list of [valueField], read only in Dartium, work in Chrome
  external List<String> get items;
  external void set items(_);

  ///The string to separate items by.
  ///  This option is only used when Selectize is instantiated
  /// from a <input type="text"> element.
  external String get delimiter;
  external void set delimiter(String delimiter);

  ///The max number of items to render at once in the dropdown list of options.
  /// default: 1000
  external int get maxOptions;
  external void set maxOptions(int _);

  /// The max number of items the user can select.
  /// Default: Infinity
  external num get maxItems;
  external set maxItems(num v);

  //external List<BaseOption> get options;

  external RenderFuns get render;

  /// If true, when user exits the field (clicks outside of input or presses ESC) new option is created and
  /// selected (if `create`-option is enabled).
  /// Default: false
  external bool get createOnBlur;
  external set createOnBlur(bool v);

  /// Specifies a RegExp or String containing a regular expression that the current search filter must match to
  /// be allowed to be created. May also be a predicate function that takes the filter text and returns whether
  /// it is allowed.
  /// Default: null
  external dynamic get createFilter;
  external set createFilter(dynamic v);

  /// Allows the user to create a new items that aren't in the list of options.
  /// This option can be any of the following: "true", "false" (disabled), or a function that accepts two
  /// arguments: "input" and "callback". The callback should be invoked with the final data for the option.
  /// Default: false
  external dynamic get create;
  external set create(dynamic v);

  /// Toggles match highlighting within the dropdown menu.
  /// Default: true
  external bool get highlight;
  external set highlight(bool v);

  /// If false, items created by the user will not show up as available options once they are unselected.
  /// Default: true
  external bool get persist;
  external set persist(bool v);

  /// Show the dropdown immediately when the control receives focus.
  /// Default: true
  external bool get openOnFocus;
  external set openOnFocus(bool v);

  /// If true, the items that are currently selected will not be shown in the dropdown list of available options.
  /// Default: false
  external bool get hideSelected;
  external set hideSelected(bool v);

  ///  If true, the dropdown will be closed after a selection is made.
  /// default: false
  external bool get closeAfterSelect;
  external set closeAfterSelect(bool v);

  /// If true, Selectize will treat any options with a "" value like normal. This defaults to false to
  /// accomodate the common <select> practice of having the first empty option act as a placeholder.
  /// Default: false
  external bool get allowEmptyOption;
  external set allowEmptyOption(bool v);

  /// The animation duration (in milliseconds) of the scroll animation triggered when going [up] and [down] in
  /// the options dropdown.
  /// Default: 60
  external num get scrollDuration;
  external set scrollDuration(num v);

  /// The number of milliseconds to wait before requesting options from the server or null.
  /// If null, throttling is disabled.
  /// Default: 300
  external num get loadThrottle;
  external set loadThrottle(num v);

  /// If true, the "load" function will be called upon control initialization (with an empty search).
  /// Alternatively it can be set to "focus" to call the "load" function when control receives focus.
  /// Default: false
  external dynamic get preload;
  external set preload(dynamic v);

  /// The element the dropdown menu is appended to. This should be "body" or null.
  /// If null, the dropdown will be appended as a child of the selectize control.
  /// Default: null
  external String get dropdownParent;
  external set dropdownParent(String v);

  /// Sets if the "Add..." option should be the default selection in the dropdown.
  /// Default: false
  external bool get addPrecedence;
  external set addPrecedence(bool v);

  /// If true, the tab key will choose the currently selected item.
  /// Default: false
  external bool get selectOnTab;
  external set selectOnTab(bool v);

  /// An array of plugins to use
  /// Default: null
  external List<String> get plugins;
  external set plugins(List<String> v);

  /// Data / Searching
  /// ------------------------------------------------------------------------------------------------------------
  /// Options available to select; array of objects. If your element is <select> with <option>s specified this
  /// property gets populated accordingly. Setting this property is convenient if you have your data as an
  /// array and want to automatically generate the <option>s.
  /// Default: []
  external List<BaseOption> get options;
  external set options(List<BaseOption> v);

  /// The <option> attribute from which to read JSON data about the option.
  /// Default: "data-data"
  external String get dataAttr;
  external set dataAttr(String v);

  /// The name of the property to use as the "value" when an item is selected.
  /// Default: "value"
  external String get valueField;
  external set valueField(String v);

  /// Option groups that options will be bucketed into.
  /// If your element is a <select> with <optgroup>s this property gets populated automatically.
  /// Make sure each object in the array has a property named whatever "optgroupValueField" is set to.
  external List<BaseOption> get optgroups;
  external set optgroups(List<BaseOption> v);

  /// The name of the option group property that serves as its unique identifier.
  /// Default: "value"
  external String get optgroupValueField;
  external set optgroupValueField(String v);

  /// The name of the property to render as an option / item label (not needed when custom rendering
  /// functions are defined).
  /// Default: "text"
  external String get labelField;
  external set labelField(String v);

  /// The name of the property to render as an option group label (not needed when custom rendering
  /// functions are defined).
  /// Default: "label"
  external String get optgroupLabelField;
  external set optgroupLabelField(String v);

  /// The name of the property to group items by.
  /// Default: "optgroup"
  external String get optgroupField;
  external set optgroupField(String v);

  /// A single field or an array of fields to sort by. Each item in the array should be an object containing at
  /// least a "field" property. Optionally, "direction" can be set to "asc" or "desc". The order of the array
  /// defines the sort precedence.
  /// Unless present, a special "$score" field will be automatically added to the beginning of the sort list.
  /// This will make results sorted primarily by match quality (descending).
  /// Default: "$order"
  external dynamic get sortField;
  external set sortField(dynamic v);

  /// An array of property names to analyze when filtering options.
  /// Default: ["text"]
  external dynamic get searchField;
  external set searchField(dynamic v);

  /// When searching for multiple terms (separated by a space), this is the operator used. Can be "and" or "or".
  /// Default: "and"
  external String get searchConjunction;
  external set searchConjunction(String v);

  /// An array of optgroup values that indicates the order they should be listed in in the dropdown.
  /// If not provided, groups will be ordered by the ranking of the options within them.
  /// Default: null
  external List<String> get optgroupOrder;
  external set optgroupOrder(List<String> v);

  /// Copy the original input classes to the Dropdown element.
  /// Default: true
  external bool get copyClassesToDropdown;
  external set copyClassesToDropdown(bool v);

  //************** CALLBACK ***********************//
  /// Callbacks
  /// ------------------------------------------------------------------------------------------------------------
  /// Invoked when new options should be loaded from the server.
  external dynamic load(String query, Function callback);

  /// Overrides the scoring function used to sort available options. The provided function should return a
  /// function that returns a number greater than or equal to zero to represent the "score" of an item
  /// (the function's first argument). If 0, the option is declared not a match.
  external Func1<dynamic, num> score(search);

  ///Invoked once the control is completely initialized.
  external VoidFunc0 get onInitialize;

  /// nvoked when the control gains focus.
  external VoidFunc0 get onFocus;

  ///Invoked when the control loses focus.
  external VoidFunc0 get onBlur;

  ///invoked when the value of the control changes.
  /// list of value fields
  external VoidFunc1<List> get onChange;

  external set onChange(VoidFunc1<List> _);

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

  external factory SelectOptions({
    List items,
    String delimiter,
    int maxOptions,
    int maxItems,
    String valueField,
    List<BaseOption> optgroups,
    String labelField,
    String sortField,
    List<BaseOption> options,
    dynamic searchField,
    String searchConjunction,
    List<String> plugins,
    RenderFuns render,
    bool createOnBlur,

    /// regex [string] or [RegExp] or [Func1<String,bool>]
    dynamic createFilter,
    /*  bool or function*/
    dynamic create,
    bool highlight,
    bool persist,
    bool openOnFocus,
    bool hideSelected,
    bool closeAfterSelect,
    bool allowEmptyOption,
    num scrollDuration,
    num loadThrottle,
    dynamic preload,
    String dropdownParent,
    bool addPrecedence,
    bool selectOnTab,
    VoidFunc0 onInitialize,
    VoidFunc1<List> onChange,
    VoidFunc2 onItemAdd,
    VoidFunc1 onItemRemove,
    VoidFunc0 onClear,
    VoidFunc2 onOptionAdd,
    VoidFunc1 onOptionRemove,
    VoidFunc1 onOptionClear,
    VoidFunc2 onOptionGroupAdd,
    VoidFunc1 onOptionGroupRemove,
    VoidFunc0 onOptionGroupClear,
    VoidFunc1 onDropdownOpen,
    VoidFunc1 onDropdownClose,
    VoidFunc1 onType,
    VoidFunc1 onLoad,
    VoidFunc0 onFocus,
    VoidFunc0 onBlur,
  });
}
