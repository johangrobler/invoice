class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_invoice, only: %i[ show edit update destroy  download_pdf]

  # GET /invoices or /invoices.json
  def index
    @invoices = current_user.invoices.order("created_at DESC")
  end

  # GET /invoices/1 or /invoices/1.json
  def show

    @item = Item.new
    @item.invoice  =  @invoice
  end

  def download_pdf
    pdf = generate_pdf

    # Send the generated PDF to the browser as a download
    send_data pdf.render, filename: "document.pdf", type: "application/pdf", disposition: "attachment"
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices or /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.user = current_user
    @invoice.status = "new"

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: "Invoice was successfully created." }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1 or /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: "Invoice was successfully updated." }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1 or /invoices/1.json
  def destroy
    @invoice.destroy!

    respond_to do |format|
      format.html { redirect_to invoices_path, status: :see_other, notice: "Invoice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def invoice_params
      params.expect(invoice: [ :company_id, :customer_id, :invoice_date, :invoice_no, :amount, :notes, :status ])
    end

    def generate_pdf
      invoice = @invoice
  # Create a new PDF document
  Prawn::Document.new(page_size: 'A4') do |pdf|
    # Title and Invoice Details
    pdf.text "Invoice ", size: 24, style: :bold
    pdf.move_down 20
    pdf.text "Date: #{invoice.created_at.strftime('%B %d, %Y')}", size: 12
    pdf.move_down 10
    pdf.text "Invoice #: #{invoice.id}", size: 12

    pdf.move_down 20
    pdf.text "From ", size: 14, style: :bold
    pdf.move_down 5
    pdf.text "#{invoice.company.name}", size: 12   , style: :bold
    pdf.text "#{invoice.company.address}", size: 12   
    pdf.text "Phone: #{invoice.company.phone}", size: 12   
    pdf.text "Email: #{invoice.company.email}", size: 12  

    pdf.move_down 20
    
    pdf.text "To ", size: 14, style: :bold
    pdf.move_down 5
    pdf.text "#{invoice.customer.name}", size: 12   , style: :bold
    pdf.text "#{invoice.customer.address}", size: 12 
    
    pdf.text "Email: #{invoice.customer.email}", size: 12  
    pdf.text "Phone: #{invoice.customer.phone}", size: 12  
    pdf.move_down 20

    # Table Headers
    pdf.text "Invoice Items", size: 16, style: :bold
    pdf.move_down 10

    # Table Content
    items_data = [["Item",  "Price","Quantity", "Total"]]
    invoice.items.each do |item|
      items_data << [item.description,"R#{'%.2f' % item.price}", item.quantity,  "R #{'%.2f' % item.total_price}"]
    end

    # Add the table to the PDF
    pdf.table(items_data, header: true, row_colors: ["F0F0F0", "FFFFFF"],width: pdf.bounds.width) do |table|
      table.row(0).font_style = :bold
      table.position = :center
      table.column(1..3).align = :right
    end

    # Total Amount
    total_amount = invoice.items.sum(&:total_price)
    pdf.move_down 40
    pdf.text "Total Amount: R #{'%.2f' % total_amount}", size: 14, style: :bold, align: :right
  
    pdf.move_down 40
    pdf.text "Bank details: ", size: 14, style: :bold
    pdf.move_down 10
    pdf.text "Bank: #{invoice.company.bank.name}", size: 12  
    pdf.move_down 5
    pdf.text "Account holder: #{invoice.company.name}", size: 12  
    pdf.move_down 5
    pdf.text "Account number: #{invoice.company.account_number}", size: 12  
    pdf.move_down 5
    pdf.text "Branch code: #{invoice.company.bank.branch_code}", size: 12  
    pdf.move_down 5
    pdf.text "Payment Reference: #{invoice.company.reference}", size: 12  
    pdf.move_down 5
  end
end
end
