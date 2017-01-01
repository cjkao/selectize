@JS()
library selectize.exmple.github;

// Copyright (c) 2016, kaopeter. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:js/js.dart';
import 'package:selectize/selectize.dart';
import 'dart:html';
import 'dart:js_util';
import 'dart:math' as math;

///
/// $order: 2
/// created: "2012-03-30T09:21:10Z"
/// created_at: "2012-03-30T09:21:10Z"
/// description: ""
/// followers: 6
/// fork: false
/// forks: 5
/// has_downloads: true
/// has_issues: true
/// has_wiki: true
/// homepage: ""
/// language: "JavaScript"
/// name: "A"
/// open_issues: 0
/// owner: "isepg1b"
/// private: false
/// pushed: "2012-06-04T14:12:27Z"
/// pushed_at: "2012-06-04T14:12:27Z"
/// score: 36.82729
/// size: 5228
/// type: "repo"
/// url: "https://github.com/isepg1b/A"
/// username: "isepg1b"
/// watchers: 6
///
@JS()
@anonymous
class MyOpt extends BaseOption {
  external bool get fork;
  external int get forks;
  external String get name;
  external String get username;
  external String get description;
  external String get language;
  external int get watchers;
  external String get url;

  external factory MyOpt(
      {bool fork, int forks, String name, String description, String language, int watchers, String url});
}

@JS('JSON.parse')
external jsonParse(String str);

main() async {
  Selectize selectHub = selectize(
      '#select-repo',
      new SelectOptions(
          valueField: 'url',
          labelField: 'name',
          searchField: 'name',
          options: [],
          create: false,
          render: new RenderFuns(option: allowInterop((MyOpt item, escape) {
            return '<div>' +
                '<span class="title">' +
                '<span class="name"><i class="icon ' +
                (item.fork ? 'fork' : 'source') +
                '"></i>' +
                escape(item.name) +
                '</span>' +
                '<span class="by">' +
                escape(item.username) +
                '</span>' +
                '</span>' +
                '<span class="description">' +
                escape(item.description) +
                '</span>' +
                '<ul class="meta">' +
                (item.language != null ? '<li class="language">' + escape(item.language) + '</li>' : '') +
                '<li class="watchers"><span>' +
                escape(item.watchers) +
                '</span> watchers</li>' +
                '<li class="forks"><span>' +
                escape(item.forks) +
                '</span> forks</li>' +
                '</ul>' +
                '</div>';
          })),
          load: allowInterop((String query, callback) async {
            if (query.length == 0) return callback();
            try {
              var res = await HttpRequest
                  .getString('https://api.github.com/legacy/repos/search/' + Uri.encodeComponent(query));
//              var resobj = jsify(JSON.decode(res)['repositories']); //low perf
              var jsobj = jsonParse(res);
              var resobj = getProperty(jsobj, 'repositories');
              callback(resobj);
            } catch (exception) {
              callback();
            }
          })));
  selectHub.settings.score = allowInterop((search) {
    var scoreFun = selectHub.getScoreFunction(search);
    return allowInterop((MyOpt item) {
      return scoreFun(item) * (1 + math.min(item.watchers / 100, 1));
    });
  });
}
