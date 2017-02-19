module Admin
  class CategoriesController < ApplicationController
    before_action :set_category, only: [:update]

    def create
      @category = Category.new(category_params)

      respond_to do |format|
        if @category.save
          format.js
          format.json
        else
          format.html { render partial: 'admin/categories/category', object: @category }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      @category.update(category_params)
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
