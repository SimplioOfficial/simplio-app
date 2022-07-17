Feature: Main Page
  Create a new account page

  Scenario: Checking Creation of New Account

    Given I tap the label that contains the text "Sign in"
    When I expect the text "Enter Simplio." to be present
    And I tap the button with the key: "sign-in-screen-create-account-button"
    And I expect the text "Create a new account" to be present
    And I expect the text "Has at least 8 characters" to be present
    And I expect the text "Must include number" to be present
    And I expect the text "Must include special character" to be present
    Then I expect the text "Must include upper case character" to be present

    When I fill the "email-input-field" field with "bob.gmail.com"
    And  I tap the label that contains the text "Create account"
    And  I expect the text "Please enter valid email address" to be present
    Then I fill the "email-input-field" field with ""

    When  I fill the "email-input-field" field with "bob@gmail"
    And  I tap the label that contains the text "Create account"
    And  I expect the text "Please enter valid email address" to be present
    Then I fill the "email-input-field" field with ""

    When  I fill the "email-input-field" field with "Bob@gmail.com"
    And  I tap the label that contains the text "Create account"
    And  I expect the text "Please enter valid email address" to be absent
    Then I fill the "email-input-field" field with ""

    When  I fill the "email-input-field" field with "bob@gmail.com"
    And  I tap the label that contains the text "Create account"
    Then I expect the text "Please enter valid email address" to be absent

    When I fill the "password-input-field" field with "pass"
    And I tap the button with the key: "show-password-button"
    And I tap the label that contains the text "Create account"
    Then I expect the text "Create a new account" to be present

    When I fill the "password-input-field" field with ""
    And I fill the "password-input-field" field with "password"
    And I tap the button with the key: "show-password-button"
    And I tap the label that contains the text "Create account"
    Then I expect the text "Create a new account" to be present

    When I fill the "password-input-field" field with ""
    And I fill the "password-input-field" field with "password1"
    And I tap the button with the key: "show-password-button"
    And I tap the label that contains the text "Create account"
    Then I expect the text "Create a new account" to be present

    When I fill the "password-input-field" field with ""
    And I fill the "password-input-field" field with "p@ssword1"
    And I tap the button with the key: "show-password-button"
    And I tap the label that contains the text "Create account"
    Then I expect the text "Create a new account" to be present

    When I fill the "password-input-field" field with ""
    And I fill the "password-input-field" field with "P@ssword1"
    And I tap the button with the key: "show-password-button"
    And I tap the label that contains the text "Create account"
    # above step have to be changed to absent when create account will work
    Then I expect the text "Create a new account" to be present







