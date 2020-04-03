# require 'solidus_content/engine'
require_dependency 'solidus_content/entry_type'

class Spree::SolidusContentController < Spree::StoreController
  def show
    @entry_type = ::SolidusContent::EntryType.find_by!(name: params[:type])
    @entry = @entry_type.entries.find_by!(slug: params[:id] || :default)
    @data = @entry.data
    
    render action: @entry_type.name
  end
end
