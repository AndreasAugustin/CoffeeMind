# @copyright Copyright (c) 2014 andy
#               All rights reserved.
# @file attach.module
# @company none
# @licence MIT licence.
# @author andy
# @email andy.augustin@t-online.de

# Define the namespace as global variable
App = exports ? window

###*
# Method to declare new namespaces out of a string to the module.
#
# @method App.namespace
# @param [String] ns_string The namespace separated as string
# @example App.namespace('App.modules.module1') will create the
#                   namespace App.modules.module1
###
App.namespace = (ns_string) ->
  parts = ns_string.split '.'
  parent = App

  # strip redundant leading global
  if parts[0] is "App"
    parts = parts.slice 1

  for part in parts
    # create a property if it doesn't exist
    if typeof parent[part] is "undefined"
      parent[part] = {}

    parent = parent[part]

  return parent
