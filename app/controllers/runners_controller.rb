class RunnersController < ApplicationController
  protect_from_forgery with: :exception
  http_basic_authenticate_with name: ENV['ADMIN_LOGIN'], password: ENV['ADMIN_PASSWORD']

  def index
    @runners = Runner.all
  end

  private
  def set_runner
    @runner = Runner.find(params[:id])
  end

  def runners_params
    params.require(:runners).permit(
        :id,
        :first_name,
        :last_name,
        :dob,
        :department,
        :sex
    )
  end
end
