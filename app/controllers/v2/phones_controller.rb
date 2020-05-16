module V1
  class PhonesController < ApplicationController
    before_action :set_notebook
  
    # GET /kinds
    def index
      render json: @notebook.phones
    end
  
    # GET /kinds/1
    def show
      render json: @kind
    end
  
    # POST /kinds
    def create
      @notebook.phones << Phone.new(phone_params)
  
      if @Notebook.save
        render json: @notebook, status: :created, location: @notebook
      else
        render json: @notebook.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /kinds/1
    def update
      phone = Phone.find(phone_params[:id])
  
      if @phone.update(phone_params)
        render json: @notebook.phones
      else
        render json: @notebook.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /kinds/1
    def destroy
      phone = Phone.find(phone_params[:id])
      phone.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_notebook
        @notebook = Notebook.find(params[:notebook_id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def phone_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
  end

end