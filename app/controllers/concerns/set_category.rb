module SetCategory
  extend ActiveSupport::Concern

  def set_category
    @main_category = MainCategory.all
    @service_category = ServiceCategory.all
  end

end