Feature: Listing
  In order to maintain system users
  As an Administrator
  I want to see a list of system users

  Scenario: Administrator views the user list
    Given I am an administrator
    And I have the address of a running usermanage server
    When I successfully run `usermanagecli list`
    Then the output should contain:
    """
+----------------+-----------------+-------+------------+-----+
| username       | name            | admin | supervisor | csr |
+----------------+-----------------+-------+------------+-----+
| seedadmin      | Seed Admin      | *     |            |     |
| seedcsr        | Seed CSR        |       |            | *   |
| seedsupervisor | Seed Supervisor |       | *          |     |
+----------------+-----------------+-------+------------+-----+
"""
