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

class TreeController < ApplicationController
  
  before_filter :require_user
  
  def tree
    @repository = Repository.find_by_name(params[:repo])
    
    if @repository && fetch_repo
      fetch_data
      @contents = @file.contents
    else
      redirect_to repositories_path
    end
  end
  
  def blob
    @repository = Repository.find_by_name(params[:repo])
    
    if @repository && fetch_repo
      fetch_data
      @data = @file.data
      @code = CodeRay.scan("\t" + @data, :ruby).div
    else
      redirect_to repositories_path
    end
  end
  
  def commits
    @repository = Repository.find_by_name(params[:repo])
    
    if @repository && fetch_repo
      @branches = @repo.heads
      @commits = @repo.commits(params[:branch])
    else
      redirect_to repositories_path
    end
  end
  
  private
  
    def fetch_repo
      begin
        @repo = Grit::Repo.new("#{RAILS_ROOT}/home/git/repositories/#{params[:login]}/#{params[:repo]}.git")
      rescue
        return false
      end
    end
    
    def fetch_data
      @branches = @repo.heads
      @commit = @repo.commit(params[:branch])
      @path = !params[:path].blank? ? params[:path].join("/") : "/"
      @file = @commit.tree / @path
    end
end
