class ClientsController < ApplicationController
  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to clients_path, notice: "Client créé !"
    else
      render :new
    end
  end

  def show
    @client = Client.find(params[:id])
  end

  def index
    @clients = Client.all
  end

  private
  def client_params
    params.require(:client).permit(
        :id,
        :name,
        :results_widget
    )
  end
end
