require "application_system_test_case"

class VonagesTest < ApplicationSystemTestCase
  setup do
    @vonage = vonages(:one)
  end

  test "visiting the index" do
    visit vonages_url
    assert_selector "h1", text: "Vonages"
  end

  test "creating a Vonage" do
    visit vonages_url
    click_on "New Vonage"

    click_on "Create Vonage"

    assert_text "Vonage was successfully created"
    click_on "Back"
  end

  test "updating a Vonage" do
    visit vonages_url
    click_on "Edit", match: :first

    click_on "Update Vonage"

    assert_text "Vonage was successfully updated"
    click_on "Back"
  end

  test "destroying a Vonage" do
    visit vonages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vonage was successfully destroyed"
  end
end
