class Article < ApplicationRecord
  validates :title, presence: true,
                    length: {minimum: 3}
  validates :text, presence: true,
                    length: {in: 3..140}
end
