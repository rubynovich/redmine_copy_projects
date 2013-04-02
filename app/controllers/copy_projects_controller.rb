class CopyProjectsController < ApplicationController
  unloadable
  layout 'admin'
  before_filter :require_admin
  before_filter :find_user

  def run
    Member.transaction do
      @user_from.memberships.each do |m|
        member = Member.new(:user => @user, :project => m.project)
        member.roles << m.roles
        member.save
      end
    end
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
