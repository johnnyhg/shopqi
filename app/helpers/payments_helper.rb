module PaymentsHelper
  def safe_pay(price)
    production? ? price : 0.01
  end
end
