require "test_helper"

class BanksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bank = banks(:one)
  end

  test "should get index" do
    get banks_url
    assert_response :success
  end

  test "should get new" do
    get new_bank_url
    assert_response :success
  end

  test "should create bank" do
    assert_difference("Bank.count") do
      post banks_url, params: { bank: { branch_code: @bank.branch_code, name: @bank.name } }
    end

    assert_redirected_to bank_url(Bank.last)
  end

  test "should show bank" do
    get bank_url(@bank)
    assert_response :success
  end

  test "should get edit" do
    get edit_bank_url(@bank)
    assert_response :success
  end

  test "should update bank" do
    patch bank_url(@bank), params: { bank: { branch_code: @bank.branch_code, name: @bank.name } }
    assert_redirected_to bank_url(@bank)
  end

  test "should destroy bank" do
    assert_difference("Bank.count", -1) do
      delete bank_url(@bank)
    end

    assert_redirected_to banks_url
  end
end
