require_dependency 'solidus_content/entry_type'

class Spree::SolidusContentController < Spree::StoreController
  def show
    slug = params[:id] || :default
    type = params[:type]

    @entry = ::SolidusContent::Entry.by_type(type).by_slug(slug)
    render action: type
  end
end
