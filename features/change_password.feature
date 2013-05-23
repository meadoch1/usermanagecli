Feature: Change Password
  In order to allow access to the system for a user who has lost his password
  As an Administrator
  I want to change the user's password

  Scenario: Administrator changes a user password
    Given I am an administrator
    And I have the address of a running usermanage server
    When I successfully run `usermanagecli password -i 1 'newpass' 'newpass'`
    Then the output should contain "success"

  Scenario: Administrator changes a user password with bad confirmation password
    Given I am an administrator
    And I have the address of a running usermanage server
    When I run `usermanagecli password -i 1 'newpass' 'badpass'`
    Then the exit status should be 1
    And the output should contain "Error: The password and confirmation password did not match"

  Scenario: Administrator changes a user password without the confirmation password
    Given I am an administrator
    And I have the address of a running usermanage server
    When I run `usermanagecli password -i 1 'newpass'`
    Then the exit status should be 1
    And the output should contain "Error: You must supply both a password and a confirmation password which match"
