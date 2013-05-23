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
+----+----------------+-----------------+-------+------------+-----+
| id | username       | name            | admin | supervisor | csr |
+----+----------------+-----------------+-------+------------+-----+
| 1  | seedadmin      | Seed Admin      | *     |            |     |
| 2  | seedcsr        | Seed CSR        |       |            | *   |
| 3  | seedsupervisor | Seed Supervisor |       | *          |     |
+----+----------------+-----------------+-------+------------+-----+
"""
