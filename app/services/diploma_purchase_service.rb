class DiplomaPurchaseService
  attr_accessor :result, :flash
  attr_reader :params

  def initialize(result, params)
    @result = result
    @params = params
    @flash = {}
    @send_diploma_by_email = params[:sending_type] == 'email'
  end

  def perform
    result.stripe_charge_id = stripe_charge.id
    result.purchased_at = Time.current
    result.save!

    if @send_diploma_by_email
      ResultMailer.mail_original_diploma(result.id).deliver_later
    else
      ToTeamResultMailer.mail_original_diploma(result.id, params[:address], params[:postal_code], params[:city], params[:country]).deliver_later
    end

    flash[:notice] = 'Commande validée !'
  rescue Stripe::CardError, Stripe::StripeError => e
    flash[:error] = e.message
  end

  private

  def stripe_charge
    stripe_charge = Stripe::Charge.create(
      amount: stripe_charge_amount,
      description: "Diplôme #{result.id} - #{result.first_name} #{result.last_name}",
      currency: 'EUR',
      receipt_email: params[:stripeEmail],
      source: params[:stripeToken],
      metadata: {
        result_id: result.id,
        first_name: result.first_name,
        last_name: result.last_name,
        email: params[:stripeEmail],
        phone_number: result.phone,
        address: params[:address],
        postal_code: params[:postal_code],
        city: params[:city],
        country: params[:country]
      }
    )
  end

  def stripe_charge_amount
    (diploma_price.to_f * 100).to_i
  end

  def diploma_price
    @send_diploma_by_email ? ENV['DIPLOMA_PRICE'] : ENV['DIPLOMA_PRICE_EMAIL']
  end
end
