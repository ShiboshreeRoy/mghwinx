class Api::V1::DepositsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      if current_user.admin?
        deposits = Deposit.all
      else
        deposits = current_user.deposits
      end
      render json: deposits.map { |d| deposit_json(d) }
    end
  
    def create
      deposit = current_user.deposits.build(deposit_params)
      if deposit.save
        render json: { message: 'Deposit request sent', deposit: deposit_json(deposit) }, status: :created
      else
        render json: { error: deposit.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      unless current_user.admin?
        return render json: { error: 'Unauthorized' }, status: :unauthorized
      end
  
      deposit = Deposit.find(params[:id])
      if deposit.update(status: 'approved')
        render json: { message: 'Deposit approved' }
      else
        render json: { error: deposit.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def deposit_params
      params.require(:deposit).permit(:transaction_id, :amount, :image)
    end
  
    def deposit_json(deposit)
      {
        id: deposit.id,
        transaction_id: deposit.transaction_id,
        amount: deposit.amount,
        status: deposit.status,
        image_url: deposit.image.attached? ? url_for(deposit.image) : nil
      }
    end
end
  