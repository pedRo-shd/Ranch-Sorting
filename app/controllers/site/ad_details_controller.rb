class Site::AdDetailsController < SiteController
  before_action :set_id, only: [:show]

  def show
    @categories = Category.order_by_description
  end

  private

  def set_id
    @ad = Ad.find(params[:id])
  end
end
