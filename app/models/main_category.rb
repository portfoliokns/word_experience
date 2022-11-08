class MainCategory < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'ゲーム' },
    { id: 3, name: 'コメディー' },
    { id: 4, name: 'スポーツ' },
    { id: 5, name: '教育' },
  ]

  include ActiveHash::Associations
  has_many :words
end
