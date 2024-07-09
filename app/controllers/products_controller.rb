class ProductsController < ApplicationController
  before_action :set_product, only: %i(show edit update destroy)

  def index
    @products = Product.newest_first
  end

  def show; end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html do
          redirect_to product_url(@product),
                      notice: t("products.create.success")
        end
        format.json{render :show, status: :created, location: @product}
      else
        format.html{render :new, status: :unprocessable_entity}
        format.json do
          render json: @product.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html do
          redirect_to product_url(@product),
                      notice: t("products.update.success")
        end
        format.json{render :show, status: :ok, location: @product}
      else
        format.html{render :edit, status: :unprocessable_entity}
        format.json do
          render json: @product.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @product.destroy

    respond_to do |format|
      format.html do
        redirect_to products_url,
                    notice: t("products.destroy.success")
      end
      format.json{head :no_content}
    end
  end

  private

  def set_product
    @product = Product.find_by(id: params[:id])
    return if @product

    flash[:alert] = t("products.not_found")
    redirect_to products_path
  end

  def product_params
    params.require(:product).permit(:name)
  end
end
