class CopyProjectsController < ApplicationController
  unloadable
  layout 'admin'
  before_filter :require_admin
  before_filter :find_user, only: :run
  before_filter :find_user_from_id, only: :clear_all

  def run
    Member.transaction do
      @user_from.memberships.each do |m|
        member = Member.new(:principal => @user, :project => m.project)
        member.roles << m.roles
        member.save
      end
    end
    redirect_to action: 'edit', controller: @user.class.to_s.underscore.pluralize, id: @user, tab: 'memberships'
  end

  def clear_all
    groups = @user.groups.clone
    @user.groups.clear
    @user.memberships.clear
    @user.groups = groups

    redirect_to action: 'edit', controller: @user.class.to_s.underscore.pluralize, id: @user, tab: 'memberships'
  end

  private

  def find_user
      @user_from = Principal.find(params[:user_from])
      @user = Principal.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
  end

  def find_user_from_id
      @user = Principal.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
  end
end
