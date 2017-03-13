module Admin
  class CategoriesController < ApplicationController
    before_action :authenticate_user!
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
      respond_to do |format|
        if @category.update(category_params)
          format.js
        else
          format.html { render partial: 'admin/categories/category', object: @category }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
