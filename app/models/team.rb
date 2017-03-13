class Team < ActiveRecord::Base
    validates :name, presence: true, uniqueness: true
    validates :name, presence: true

    has_many :statistics
end
