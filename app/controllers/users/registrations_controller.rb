class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: %i[update destroy]

  def ensure_normal_user
    return unless resource.guest_user?

    redirect_to root_path, alert: 'ゲストユーザーの更新・削除はできません。'
  end
end
