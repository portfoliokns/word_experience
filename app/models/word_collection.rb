class WordCollection
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  WORD_NUM = 4
  attr_accessor :collection

  def new_set_data
    self.collection = WORD_NUM.times.map { Word.new }
  end

  def set_data(params)
    self.collection = WORD_NUM.times.map do |n|
      Word.new(params[n])
    end
  end

  def input_valid?(save_params, error_message)

    word_names = save_params.map { |params| params[:name] }

    if word_names.length != word_names.uniq.length
      error_message.replace("同じ名前の単語が2つ以上存在します")
      return false
    end

    save_params.each do |params|
      if params[:name].empty?
        error_message.replace("ワードを入力してください")
        return false
      end
  
      if Word.exists?(name: params[:name])
        error_message.replace("同じ名前の単語が既に存在します")
        return false
      end

      word = Word.new(params)
      if word.invalid?
        error_message.replace("ワードは4文字以上、30文字以下で入力してください")
        return false
      end
  
      if params[:main_category_id] == "1"
        error_message.replace("カテゴリを選択してください")
        return false
      end
  
      if params[:service_category_id] == "1"
        error_message.replace("サービスを選択してください")
        return false
      end
    end
    return true
  end

  def save_data(params)
    is_success = true
    ActiveRecord::Base.transaction do
      params.each do |result|
        is_success = false unless Word.new(result).save
      end
      raise ActiveRecord::RecordInvalid unless is_success
    end
  rescue StandardError
    p 'transaction error'
  ensure
    return is_success
  end
end
