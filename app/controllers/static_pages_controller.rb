class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!

  def terms
  end

  def privacy_policy
  end

  def top
  end
end
