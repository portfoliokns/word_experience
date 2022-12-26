class ServiceCategory < ActiveHash::Base
  self.data = [
    { id: 1, name: '--サービスを選択必須--' },
    { id: 101, name: 'Googole', link: 'https://www.google.com/' },
    { id: 102, name: 'Googole Maps', link: 'https://www.google.co.jp/maps/' },
    { id: 103, name: 'Googole トレンド', link: 'https://trends.google.co.jp/' },
    { id: 104, name: 'Youtube', link: 'https://www.youtube.com/' },

    { id: 201, name: 'Amazon', link: 'https://www.amazon.co.jp/' },
    { id: 202, name: 'prime video', link: 'https://www.amazon.co.jp/Prime-Video/b?node=3535604051' },
    { id: 203, name: 'Kindle', link: 'https://www.amazon.co.jp/Kindle-%E3%82%AD%E3%83%B3%E3%83%89%E3%83%AB-%E9%9B%BB%E5%AD%90%E6%9B%B8%E7%B1%8D/b?ie=UTF8&node=2250738051' },
    { id: 204, name: 'AWS', link: 'https://aws.amazon.com/' },

    { id: 301, name: 'Twitter', link: 'https://twitter.com/' },
    { id: 302, name: 'Twitter(マーケティング)', link: 'https://marketing.twitter.com/' },


    { id: 401, name: 'LINE' },
    { id: 402, name: 'LINEスタンプ' },

    { id: 501, name: 'Facebook', link: 'https://www.facebook.com/' },

    { id: 601, name: 'Netflix', link: 'https://www.netflix.com/' },

    { id: 701, name: 'メルカリ', link: 'https://jp.mercari.com/' },

    { id: 801, name: 'Yahoo!', link: 'https://www.yahoo.co.jp/' },
    { id: 802, name: 'Yahoo!ショッピング', link: 'https://shopping.yahoo.co.jp/?sc_e=ytmh' },

    { id: 99999, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :words
end
