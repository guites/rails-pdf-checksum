class Article < ActiveRecord::Base
    has_one :checksum
    validates :title, presence: true
    validates :body, presence: true, length: {minimum: 10}
end
