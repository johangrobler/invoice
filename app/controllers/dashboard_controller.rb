class DashboardController < ApplicationController

  before_action :authenticate_user!

  def index

    @company_count = current_user.companies.count
    @customer_count = current_user.customers.count
    @invoice_count = current_user.invoices.count

    @revenue = current_user.invoices.sum(:amount)
  end
end
