class ServiceCategory < ActiveHash::Base
  self.data = [
    { id: 1, name: '--サービスを選択必須--' },
    { id: 101, name: 'Googole', link: 'https://www.google.com/' },
    { id: 102, name: 'Googole Maps', link: 'https://www.google.co.jp/maps/' },
    { id: 103, name: 'Googole トレンド', link: 'https://trends.google.co.jp/' },
    { id: 104, name: 'Youtube', link: 'https://www.youtube.com/' },

    { id: 201, name: 'Amazon' },
    { id: 202, name: 'prime video' },
    { id: 203, name: 'Kindle' },
    { id: 204, name: 'AWS' },

    { id: 301, name: 'Twitter' },
    { id: 302, name: 'Twitter(マーケティング)' },


    { id: 401, name: 'LINE' },
    { id: 402, name: 'LINEスタンプ' },

    { id: 501, name: 'Facebook' },

    { id: 601, name: 'Netflix' },

    { id: 701, name: 'メルカリ' },

    { id: 801, name: 'Yahoo!' },
    { id: 802, name: 'Yahoo!ショッピング' },

    { id: 99999, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :words
end
