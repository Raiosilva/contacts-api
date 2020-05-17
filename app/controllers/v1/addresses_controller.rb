module V1
  class AddressesController < ApplicationController
    before_action :set_notebook
  
    def destroy
      @notebook.address.destroy
    end    
  
    def create
      @notebook.address = Address.new(address_params)
  
      if @notebook.save
        render json: @notebook.address, status: :created, location: notebook_address_url(@notebook)
      else
        render json: @notebook.errors, status: :unprocessable_entity
      end
    end

    def update
      if @notebook.address.update(address_params)
        render json: @notebook.address
      else
        render json: @notebook.errors, status: :unprocessable_entity
      end
    end

    def show
      render json: @notebook.address
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_notebook
        @notebok = Notebook.find(params[:notebook_id])
      end
  
      def address_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
  
  end

end