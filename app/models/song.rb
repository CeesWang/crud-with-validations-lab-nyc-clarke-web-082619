class Song < ApplicationRecord
     validates :title, presence: true
    validates :artist_name, presence: true
    validates_inclusion_of :released, :in => [true, false]
    # validate :is_released_with_valid_release_year
    # validate :is_released_in_future_year

    validates :title, uniqueness: {
        scope: %i[release_year artist_name],
        message: 'cannot be repeated by the same artist in the same year'
      }
    with_options if: :released do |song|
        song.validates :release_year, presence: true
        song.validates :release_year, numericality: {
          less_than_or_equal_to: Date.today.year
        }
    end
    # def is_released_with_valid_release_year
    #     if released && release_year.blank?
    #         errors.add(:released, "invalid without release year when released is true")
    #     end
    # end
    
    # def is_released_in_future_year
    #     if Time.new.year < release_year
    #         errors.add(:release_year, "invalid when the release year is in the future")
    #     end
    # end

end
