class InvoiceController < ApplicationController
  def show
    @invoice = Invoice.find_by(token: params[:id])
    @company = @invoice.company
    @customer = @invoice.customer
    @items = @invoice.items
  end
end
