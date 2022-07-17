Feature: Main Page
  Forgot Password Page

  Scenario: Checking Forgot Password Page
    Given I tap the label that contains the text "Sign in"
    When I expect the text "Enter Simplio." to be present
    And I tap the button with the key: "sign-in-screen-reset-password-button"
    Then I expect the text "Forgot password" to be present
    When I fill the "email-input-field" field with "bob.gmail.com"
    And I tap the button with the key: "reset-screen-submit-button"
    Then I expect the text "Please enter valid email address" to be present
    When I fill the "email-input-field" field with ""
    When I fill the "email-input-field" field with "Bob@gmail.com"
    And I tap the button with the key: "reset-screen-submit-button"
    Then I expect the text "Please enter valid email address" to be absent
    When I fill the "email-input-field" field with ""
    And I fill the "email-input-field" field with "bob@wp.pl"
    And I tap the button with the key: "reset-screen-submit-button"
    Then I expect the text "Please enter valid email address" to be absent

