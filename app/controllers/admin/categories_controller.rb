module Admin
  class CategoriesController < ApplicationController
    before_action :set_category, only: [:update, :destroy]

    def create
      @category = Category.create(category_params)

      respond_to do |format|
        format.js
      end
    end

    def update
      @category = Category.find(params[:id])
      @category.update(category_params)
    end

    def destroy
      @category = Category.find(params[:id])
      @category.destroy
    end

    private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:title)
    end
  end
end
