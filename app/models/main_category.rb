class MainCategory < ActiveHash::Base
  self.data = [
    { id: 1, name: '-カテゴリを選択必須-' },
    { id: 2, name: '映画とアニメ' },
    { id: 3, name: '自動車や乗り物' },
    { id: 4, name: '音楽' },
    { id: 5, name: 'ペットと動物' },
    { id: 6, name: 'スポーツ' },
    { id: 7, name: '旅行とイベント' },
    { id: 8, name: 'ゲーム' },
    { id: 9, name: 'ブログ' },
    { id: 10, name: 'コメディ' },
    { id: 11, name: 'エンターテイメント' },
    { id: 12, name: 'ニュースと政治' },
    { id: 13, name: 'ハウツーとスタイル' },
    { id: 14, name: '教育' },
    { id: 15, name: '科学と技術' },
    { id: 16, name: '非営利団体と社会活動' }
  ]

  include ActiveHash::Associations
  has_many :words
end
