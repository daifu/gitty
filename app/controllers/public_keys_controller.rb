class PublicKeysController < ApplicationController

  before_filter :require_user

  def edit
    @public_key = @current_user.public_keys.find_by_id(params[:id])
  end

  def create
    @public_key = PublicKey.new(params[:public_key])

    respond_to do |format|
      if @public_key.save
        flash[:notice] = 'Public Key was successfully created'
        format.html { redirect_to account_url }
      else
        flash[:notice] = 'Cannot add Public Key'
        format.html { redirect_to account_url } #TODO change redirect to render if possible
      end
    end
  end

  def update
    @public_key = @current_user.public_keys.find(params[:id])

    respond_to do |format|
      if @public_key.update_attributes(params[:public_key])
        flash[:notice] = 'Public Key was successfully updated.'
        format.html { redirect_to(account_url) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @public_key = @current_user.public_keys.find(params[:id])

    respond_to do |format|
      if @public_key.destroy
        flash[:notice] = 'Public Key was successfully removed.'
      else
        flash[:notice] = 'Public Key cannot be removed.'
      end
      format.html { redirect_to(account_url) }
    end
  end
end