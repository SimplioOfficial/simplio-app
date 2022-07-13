Feature: Main Page
  Login Page

  Scenario: Checking Login Page
    Given I tap the label that contains the text "Sign in"
    When I expect the text "Enter Simplio." to be present
    And I expect the text "It's good to see you back." to be present
    And I tap the label that contains the text "Sign in"
    And I expect the text "Please enter valid email address" to be present
    Then I expect the text "Please enter valid password" to be present
    #checking proper handling email validation
    When I fill the "create_account_email" field with "bob.gmail.com"
    And  I tap the label that contains the text "Sign in"
    And  I expect the text "Please enter valid email" to be present
    Then I tap the button with tooltip "Back"

    When I tap the label that contains the text "Sign in"
    And  I fill the "create_account_email" field with "bob@gmail"
    And  I tap the label that contains the text "Sign in"
    And  I expect the text "Please enter valid email" to be present
    Then I tap "Back" label

    When I fill the "create_account_email" field with "Bob@gmail.com"
    And  I tap the label that contains the text "Sign in"
    Then I expect the text "Please enter valid email" to be present

    When I fill the "create_account_email" field with "bob@gmail.com"
    And  I tap the label that contains the text "Sign in"
    Then I expect the text "Please enter valid email" to be absent
    # Checking proper validation of password
    When I fill the "create_account_password" field with "pass"
    And  I tap the label that contains the text "Sign in"
    Then I expect the text "Please enter valid password" to be present

    When I fill the "create_account_password" field with "Pass"
    And  I tap the label that contains the text "Sign in"
    Then I expect the text "Please enter valid password" to be present

    When I fill the "create_account_password" field with "Password"
    And  I tap the label that contains the text "Sign in"
    Then I expect the text "Please enter valid password" to be present

    When I fill the "create_account_password" field with "Password1"
    And  I tap the label that contains the text "Sign in"
    Then I expect the text "Please enter valid password" to be present

    When I fill the "create_account_password" field with "Password1@"
    And  I tap the label that contains the text "Sign in"
    And  I expect the text "Please enter valid password" to be absent
    And  I expect the text "Please enter valid email" to be absent
    Then I expect the text "Games" to be present



