class ProductsController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]
  #before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    #require 'byebug'
    #byebug 
    if params[:q]
      if Rails.env.production?
        search_term = params[:q]
        @products = Product.where("name iLIKE ? OR description iLIKE ?", "%#{search_term}%", "%#{search_term}%")
        if @products.empty?
          respond_to do |format|
            format.html{redirect_to products_url, notice: "Sorry, no matching products was found"}
          end
        end
      end

      if Rails.env.development?
        search_term = params[:q]
        @products = Product.where("name LIKE ? OR description LIKE ?", "%#{search_term}%", "%#{search_term}%")
        if @products.empty?
          respond_to do |format|
            format.html{redirect_to products_url, notice: "Sorry, no matching products was found"}
          end
        end
      end
        
    else
      @products = Product.all
    end
  end
  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    
    @comments = @product.comments.order('created_at DESC').page(params[:page]).per_page(5)
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @product = Product.find(params[:id])
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:image_url, :name, :description, :color, :price, :link)
    end
end
