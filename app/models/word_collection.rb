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
    name_validator = Word.validators_on(:name).find { |v| v.kind == :length }
    minimum_length = name_validator.options[:minimum]

    save_params.each do |params|
      if params[:name].empty?
        message = "#{row_count}項目：ワードが入力されていません。入力してください。"
        error_message.replace(message)
        return false
      end

      if names_list.include?(params[:name])
        message = "#{row_count}項目：同じワード '#{params[:name]}' を登録しようとしています。他のワードを入力してください。"
        error_message.replace(message)
        return false
      else
        names_list << params[:name]
      end

      if Word.exists?(name: params[:name])
        message = "#{row_count}項目：同じワード '#{params[:name]}' が既に登録されています。別のワードを入力してください。"
        error_message.replace(message)
        return false
      end

      if params[:name].length < minimum_length
        message = "#{row_count}項目：ワードは#{minimum_length}文字以上、30文字以下で入力してください。"
        error_message.replace(message)
        return false
      end

      if params[:main_category_id] == MainCategory::CategorySelectId.to_s
        message = "#{row_count}項目：カテゴリを選択してください。"
        error_message.replace(message)
        return false
      end
  
      if params[:service_category_id] == ServiceCategory::CategorySelectId.to_s
        message = "#{row_count}項目：サービスを選択してください。"
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
