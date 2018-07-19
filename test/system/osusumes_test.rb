require "application_system_test_case"

class OsusumesTest < ApplicationSystemTestCase
  setup do
    @osusume = osusumes(:one)
  end

  test "visiting the index" do
    visit osusumes_url
    assert_selector "h1", text: "Osusumes"
  end

  test "creating a Osusume" do
    visit osusumes_url
    click_on "New Osusume"

    fill_in "Short Title", with: @osusume.short-title
    fill_in "Title", with: @osusume.title
    click_on "Create Osusume"

    assert_text "Osusume was successfully created"
    click_on "Back"
  end

  test "updating a Osusume" do
    visit osusumes_url
    click_on "Edit", match: :first

    fill_in "Short Title", with: @osusume.short-title
    fill_in "Title", with: @osusume.title
    click_on "Update Osusume"

    assert_text "Osusume was successfully updated"
    click_on "Back"
  end

  test "destroying a Osusume" do
    visit osusumes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Osusume was successfully destroyed"
  end
end
