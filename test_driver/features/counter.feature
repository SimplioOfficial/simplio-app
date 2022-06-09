Feature: Main Page
  Main Page should contain Generated Seed

  Scenario: Generated seed visible on app main page
    Given I see 'Generated Seed' text
    When I tap the button that contains the text "Next"
    Then I expect the text "Logout" to be present