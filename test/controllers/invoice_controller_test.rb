require "test_helper"

class InvoiceControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get invoice_show_url
    assert_response :success
  end
end
