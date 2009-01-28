Feature: Schedule a dojo session
  In order to inform participants when will be the next session
  As an editor
  I want to be able to create a session
  And choose an hour
  And choose a date

  Scenario: Create first dojo
    Given I am on the root page
    And I am logged in
    When I follow "New"
    And I select 1 days from now as the date and time
    And I fill in "comment" with "A comment"
    And I press "Create"
    Then the next dojo should be in 1 days
    And the next dojo comment should be "A comment"
    And I should see an empty presence list
    And I should see "Successfully created"

  Scenario: Create next dojos
    Given I am on the root page
    And I am logged in
    And there are 1 dojos scheduled starting in 1 days
    When I follow "New"
    And I select 2 days from now as the date and time
    And I press "Create"
    Then the next dojo should be in 1 days
    And I should see a dojo in 2 days inside the schedule tag
    And I should see "Successfully created"

  Scenario: No dojo created
    Given there is no scheduled dojo
    When I am on the root page
    Then I should see "No scheduled dojos"

  Scenario: Create dojo before today
    Given there is no scheduled dojo
    And I am logged in
    When I am on the new dojo page
    And I select -1 days from now as the date and time
    And I press "Create"
    Then I should see "No scheduled dojos"
    
  Scenario: Create dojo with no date
    Given I am on the new dojo page
    And I am logged in
    When I create a dojo with no date
    Then I should see "Date can't be blank"

  Scenario: Create dojo using default date when there is no dojo yet
    Given I am logged in
    And I am on the new dojo page
    And there is no scheduled dojo
    When I press "Create"
    Then the next dojo should be in 7 days
    And I should see "Successfully created"

  Scenario: Create dojo using default date when there is a dojo created last week
    Given there are 1 dojos scheduled starting in 1 days
    And I am logged in
    And I am on the new dojo page
    When I press "Create"
    Then I should see a dojo in 8 days inside the schedule tag
    And I should see "Successfully created"

  Scenario: Can't create a dojo when not authenticated
    Given I am not logged in
    And I am on the root page
    When I follow "New"
    Then I should see "You must be logged in to do this"
    And I should see "No scheduled dojos"

