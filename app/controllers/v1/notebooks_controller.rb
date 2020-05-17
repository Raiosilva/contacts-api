module V1
  class NotebooksController < ApplicationController
    include ErrorSerializer

    before_action :set_notebook, only: [:show, :update, :destroy]

    def index
      page_number = params[:page].try(:[], :number)
      per_page = params[:page].try(:[], :size)
      @notebooks = Notebook.all.page(page_number).per(per_page)

      if stale?(last_modified: @notebooks)
        render json: @notebooks
      end
    end
  
    def show
      render json: @notebook, include: [:kind, :address, :phones]
    end
  
    def create
      @notebook = Notebook.new(notebook_params)
  
      if @notebook.save
        render json: @notebook, include: [:kind, :phones, :address], status: :created, location: @notebook
      else
        render json: ErrorSerializer.serializer(@notebook.errors)
      end
    end

    def update
      if @notebook.update(notebook_params)
        render json: @notebook, include: [:kind, :phones, :address]
      else
        render json: @notebook.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /notebooks/1
    def destroy
      @notebook.destroy
    end
  
    private
      def set_notebook
        @notebook = Notebook.find(params[:id])
      end
  
      def notebook_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
  end
  
end