class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def new
    @form = Form::ProductCollection.new
  end

  def create
    @form = Form::ProductCollection.new(product_collection_params)
    if @form.save
      redirect_to products_path, notice: "商品を登録しました"
    else
      flash.now[:alert] = "商品登録に失敗しました"
      render :new
    end

  end

  private

  def product_collection_params
    params.require(:form_product_collection)
          .permit(products_attributes: [:code, :name, :price, :availability])
  end

end