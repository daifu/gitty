# encoding: utf-8
#--
#   Copyright (C) 2009 William Estoque <william.estoque@gmail.com>
#   Copyright (C) 2009 Daifu Ye <daifu.ye@gmail.com>
#   Copyright (C) 2009 Daihua Ye <daihua.ye@gmail.com>
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU Affero General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU Affero General Public License for more details.
#
#   You should have received a copy of the GNU Affero General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#++

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