class CopyProjectsController < ApplicationController
  unloadable
  layout 'admin'
  before_filter :require_admin
  before_filter :find_user

  def copy_projects
    @user.memberships << @user_from.memberships
    redirect_to edit_user_path(@user, :tab => 'memberships')
  end

  private

  def find_user
      @user_from = User.find(params[:user_from])
      @user = User.find(params[:user_to])
    rescue ActiveRecord::RecordNotFound
      render_404
  end
end
