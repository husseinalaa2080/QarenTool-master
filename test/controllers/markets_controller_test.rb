require 'test_helper'

class MarketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @market = markets(:one)
  end

  test "should get index" do
    get markets_url
    assert_response :success
  end

  test "should get new" do
    get new_market_url
    assert_response :success
  end

  test "should create market" do
    assert_difference('Market.count') do
      post markets_url, params: { market: { description: @market.description, logo: @market.logo, name: @market.name, name_en: @market.name_en } }
    end

    assert_redirected_to market_url(Market.last)
  end

  test "should show market" do
    get market_url(@market)
    assert_response :success
  end

  test "should get edit" do
    get edit_market_url(@market)
    assert_response :success
  end

  test "should update market" do
    patch market_url(@market), params: { market: { description: @market.description, logo: @market.logo, name: @market.name, name_en: @market.name_en } }
    assert_redirected_to market_url(@market)
  end

  test "should destroy market" do
    assert_difference('Market.count', -1) do
      delete market_url(@market)
    end

    assert_redirected_to markets_url
  end
end
