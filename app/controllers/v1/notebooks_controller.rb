module V1
  class NotebooksController < ApplicationController
    before_action :set_notebook, only: [:show, :update, :destroy]

    # GET /notebooks
    def index
      # page_number = params[:page].try(:[], :number)
      # per_page = params[:page].try(:[], :size)
      # @notebooks = Notebook.all.page(page_number).per(per_page)
      @notebooks = Notebook.all.page(params[:page].try(:[], :number))
      # @notebooks = Notebook.all.page(params[:page] ? params[:page][:number] : 1)
  
      render json: @notebooks
      # paginate json: @notebooks
      #, methods: :birthdate_br
      # .map { |notebook| notebook.attributes.merge( { author: "Raimundo" }) }
      # except: [:name, :email]
      # only: [:name, :email]
      # root: true
    end
  
    # GET /notebooks/1
    def show
      render json: @notebook, include: [:kind, :address, :phones]
      #, meta: { author: 'Raimundo Oliveira' }
      #, include: [:kind, :phones, :address]
      #.to_br
      # .attributes.merge( { author: "Raimundo" })
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
        # params.require(:notebook).permit(
        #   :name, :email, :birthdate, :kind_id,
        #   phones_attributes: [:id, :number, :_destroy],
        #   address_attributes: [:id, :street, :city]
        # )
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
  end
  
end