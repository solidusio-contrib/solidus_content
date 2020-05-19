require_dependency 'solidus_content/entry_type'

class Spree::SolidusContentController < Spree::StoreController
  def show
    slug = params[:id] || :default
    entry_type_name = params[:type]

    @entry = ::SolidusContent::Entry.get(entry_type_name, slug)
    render action: entry_type_name
  end
end
