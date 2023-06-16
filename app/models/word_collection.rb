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
    row_count = 1
    names_list = []

    save_params.each do |params|
      if params[:name].empty?
        message = "#{row_count}行目：ワードを入力してください。"
        error_message.replace(message)
        return false
      end

      if names_list.include?(params[:name])
        message = "#{row_count}行目の'#{params[:name]}'：同じワードを登録することはできません。"
        error_message.replace(message)
        return false
      else
        names_list << params[:name]
      end

      if Word.exists?(name: params[:name])
        message = "#{row_count}行目：同じ名前の単語が既に登録されています。"
        error_message.replace(message)
        return false
      end

      if params[:name].length <= 3
        message = "#{row_count}行目：ワードは4文字以上、30文字以下で入力してください。"
        error_message.replace(message)
        return false
      end

      if params[:main_category_id] == "1"
        message = "#{row_count}行目：カテゴリを選択してください。"
        error_message.replace(message)
        return false
      end
  
      if params[:service_category_id] == "1"
        message = "#{row_count}行目：サービスを選択してください。"
        error_message.replace(message)
        return false
      end

      row_count += 1
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
