Selectize wrapper
======================================

# Setup
* include snippets after dart script
```javascript
<script src='jquery214.js'></script>
<script src='jqueryui.min.js'></script> // only for drag and drop
<script src='packages/selectize/selectize.js'></script>
<link rel="stylesheet" href="packages/selectize/selectize.css">
```
* In `main()`, call `jqSelectBootstrap()` to inject bridge to jquery and selectize
# Example
see web/index.html

# Note
* allowInterop is necessary for callback
* angular2 select item change should wrap into zone
* dart script must defer loading to wait javascript library ready
```javascript
     <script defer type="application/dart" src="index.dart"></script>
```
* Utils.isArray is changed in  `selectize.js` for chormium  
