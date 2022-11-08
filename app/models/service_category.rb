class ServiceCategory < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'YouTube' },
    { id: 3, name: 'Twitter' },
    { id: 4, name: 'Facebook' },
    { id: 5, name: 'Amazon' },
  ]

  include ActiveHash::Associations
  has_many :words
end