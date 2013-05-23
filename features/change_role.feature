Feature: Change User Role
  In order to allow user's to access to change over time
  As an Administrator
  I want to change the user's role

  Scenario: Administrator changes a user's role
    Given I am an administrator
    And I have the address of a running usermanage server
    When I successfully run `usermanagecli role -i 1  csr:true admin:false`
    Then the output should contain "success"
    When I successfully run `usermanagecli list`
    Then the output should contain "Seed Admin      |       |            | *   |"
    When I successfully run `usermanagecli role -i 1  csr:false admin:true`
    Then the output should contain "success"
    When I successfully run `usermanagecli list`
    Then the output should contain "Seed Admin      | *     |            |     |"
