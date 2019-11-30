require "application_system_test_case"

class MarketsTest < ApplicationSystemTestCase
  setup do
    @market = markets(:one)
  end

  test "visiting the index" do
    visit markets_url
    assert_selector "h1", text: "Markets"
  end

  test "creating a Market" do
    visit markets_url
    click_on "New Market"

    fill_in "Description", with: @market.description
    fill_in "Logo", with: @market.logo
    fill_in "Name", with: @market.name
    fill_in "Name en", with: @market.name_en
    click_on "Create Market"

    assert_text "Market was successfully created"
    click_on "Back"
  end

  test "updating a Market" do
    visit markets_url
    click_on "Edit", match: :first

    fill_in "Description", with: @market.description
    fill_in "Logo", with: @market.logo
    fill_in "Name", with: @market.name
    fill_in "Name en", with: @market.name_en
    click_on "Update Market"

    assert_text "Market was successfully updated"
    click_on "Back"
  end

  test "destroying a Market" do
    visit markets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Market was successfully destroyed"
  end
end
