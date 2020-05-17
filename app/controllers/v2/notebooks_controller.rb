module V2
  class NotebooksController < ApplicationController
    before_action :set_notebook, only: [:show, :update, :destroy]
  
    # GET /notebooks
    def index
      @notebooks = Notebook.last(10)
      render json: @notebooks
    end
  
    # GET /notebooks/1
    def show
      render json: @notebook, include: [:kind, :address, :phones]
    end
  
    # POST /notebooks
    def create
      @notebook = Notebook.new(notebook_params)
  
      if @notebook.save
        render json: @notebook, include: [:kind, :phones, :address], status: :created, location: @notebook
      else
        render json: @notebook.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /notebooks/1
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
      # Use callbacks to share common setup or constraints between actions.
      def set_notebook
        @notebook = Notebook.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def notebook_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
  end
end