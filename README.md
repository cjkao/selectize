Selectize wrapper
======================================

# Setup
include snippets after dart script
```javascript
<script src='jquery214.js'></script>
<script src='jqueryui.min.js'></script> // only for drag and drop
<script src='packages/selectize/selectize.js'></script>
<link rel="stylesheet" href="packages/selectize/selectize.css">
<script>
function jqSelectize(selector, option){
  return $(selector).selectize(option)[0].selectize;
}
function jqOptionByValue(obj,key){
  return obj[key];
}
</script>
```
# Example
see web/index.html

# Note
* allowInterop is necessary for callback
* angular2 select item change should wrap into zone
