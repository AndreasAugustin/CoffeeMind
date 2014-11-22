(function() {
  var App;

  App = App || {};


  /**
   * Method to declare new namespaces out of a string to the module.
   *
   * @method App.namespace
   * @param [String] ns_string The namespace separated as string
   * @example App.namespace('App.modules.module1') will create the namespace App.modules.module1
   */

  App.namespace = function(ns_string) {
    var parent, part, parts, _i, _len;
    parts = ns_string.split('.');
    parent = App;
    if (parts[0] === "App") {
      parts = parts.slice(1);
    }
    for (_i = 0, _len = parts.length; _i < _len; _i++) {
      part = parts[_i];
      if (typeof parent[part] === "undefined") {
        parent[part] = {};
      }
      parent = parent[part];
    }
    return parent;
  };

}).call(this);
