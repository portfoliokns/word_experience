class ServiceCategory < ActiveHash::Base
  self.data = [
    { id: 1, name: '--サービスを選択必須--' },
    { id: 101, name: 'Google', url: 'https://www.google.com/', link: true },
    { id: 102, name: 'Google Maps', url: 'https://www.google.co.jp/maps/', link: true },
    { id: 103, name: 'Google トレンド', url: 'https://trends.google.co.jp/', link: true },
    { id: 104, name: 'Youtube', url: 'https://www.youtube.com/', link: true },

    { id: 201, name: 'Amazon', url: 'https://www.amazon.co.jp/', link: true },
    { id: 202, name: 'prime video', url: 'https://www.amazon.co.jp/Prime-Video/b?node=3535604051', link: true },
    { id: 203, name: 'Kindle', url: 'https://www.amazon.co.jp/Kindle-%E3%82%AD%E3%83%B3%E3%83%89%E3%83%AB-%E9%9B%BB%E5%AD%90%E6%9B%B8%E7%B1%8D/b?ie=UTF8&node=2250738051', link: true },
    { id: 204, name: 'AWS', url: 'https://aws.amazon.com/', link: true },

    { id: 301, name: 'Twitter', url: 'https://twitter.com/', link: true },
    { id: 302, name: 'Twitter(マーケティング)', url: 'https://marketing.twitter.com/', link: true },


    { id: 401, name: 'LINE', url: '#', link: false },
    { id: 402, name: 'LINEスタンプ', url: '#', link: false },

    { id: 501, name: 'Facebook', url: 'https://www.facebook.com/', link: true },

    { id: 601, name: 'Netflix', url: 'https://www.netflix.com/', link: true },

    { id: 701, name: 'メルカリ', url: 'https://jp.mercari.com/', link: true },

    { id: 801, name: 'Yahoo!', url: 'https://www.yahoo.co.jp/', link: true },
    { id: 802, name: 'Yahoo!ショッピング', url: 'https://shopping.yahoo.co.jp/?sc_e=ytmh', link: true },

    { id: 99999, name: 'その他', url: '#', link: false }
  ]

  include ActiveHash::Associations
  has_many :words
end
