class WordCollection
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  WORD_NUM = 3
  attr_accessor :collection

  def new_set_data
    self.collection = WORD_NUM.times.map{ Word.new }
  end

  def save_data(params)
    is_success = true
    ActiveRecord::Base.transaction do
      params.each do |result|
        is_success = false unless Word.new(result).save
      end
      raise ActiveRecord::RecordInvalid unless is_success
    end
  rescue
    p 'transaction error'
  ensure
    return is_success
  end
end