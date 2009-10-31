class PublicKeysController < ApplicationController
  
  before_filter :require_user
  
  def edit
    @public_key = @current_user.public_keys.find_by_id(params[:id])
  end
  
  def create
    @public_key = PublicKey.new(params[:public_key])
    @public_key.key.gsub!(/[\r\n,\n]/, '') if @public_key.key.match(/\n/)
    
    respond_to do |format|
      if @public_key.valid? && insert_key_to_file(@public_key) && @public_key.save
        flash[:notice] = 'PublicKey was successfully created.'
      else
        flash[:notice] = 'Cannot create PublicKey'
      end
      format.html { redirect_to account_url }
    end
  end

  def update
    @public_key = PublicKey.find(params[:id])

    respond_to do |format|
      if @public_key.update_attributes(params[:public_key])
        flash[:notice] = 'PublicKey was successfully updated.'
        format.html { redirect_to(account_url) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @public_key = PublicKey.find(params[:id])
    remove_key_from_file(@public_key.key)
    
    respond_to do |format|
      if @public_key.destroy
        flash[:notice] = 'PublicKey was successfully removed.'
      else
        flash[:notice] = 'PublicKey cannot be removed.'
      end
      format.html { redirect_to(account_url) }
    end
  end
  
  private
    
    # TODO Take off hack and solve problem with key gsub
    def insert_key_to_file(public_key)
      begin
        file = File.open("#{RAILS_ROOT}/home/git/repositories/gitosis-admin.git/keydir/#{@current_user.login}.pub", "a+")
        file.puts(public_key.key)
        file.close
        public_key.filename = "#{@current_user.login}.pub"
        return true
      rescue
        return false
      end
    end
    
    def remove_key_from_file(key)
      begin
        lines = []
        file = File.open("#{RAILS_ROOT}/home/git/repositories/gitosis-admin.git/keydir/#{@current_user.login}.pub", "r+")
        file.each do |line|
          lines << line
        end
        
        index = 0
        lines.each do |line|
          if line.match(key)
            lines.delete_at(index)
          end
          index = index + 1
        end
        file.close
        
        file = File.open("#{RAILS_ROOT}/home/git/repositories/gitosis-admin.git/keydir/#{@current_user.login}.pub", "w")
        lines.each do |line|
          file.puts(line)
        end
        file.close
      end
    end
end