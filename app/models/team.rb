class Team < ActiveRecord::Base
    validates :name, presence: true, uniqueness: true
    validates :name, presence: true
end
