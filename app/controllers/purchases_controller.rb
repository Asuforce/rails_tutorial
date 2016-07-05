class PurchasesController < ApplicationController

  def create
    webpay = WebPay.new('test_secret_dzcbBLaFX0618cq6oa6dV6yL')
    webpay.charge.create(amount: 400, currency: "jpy", card: params['webpay-token'])
    flash[:success] = 'まいど！'
    redirect_to root_path
  end
end
