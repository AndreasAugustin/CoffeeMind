Feature: Attach module to namespace
  In order to have better control over the workflow
  As a developer
  I want to have various namespaces

  Scenario: A developer wants to attach a new namespace
    Given The App.namespace method
    When A developer calls App.namespace with "App.modules.module1"
    Then He should get an object App.modules.module1