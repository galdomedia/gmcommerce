class PropertyType < ActiveRecord::Base

  FIELD_TYPES = {
          :string => 1,
          :boolean_select => 2,
          :text => 3 
          }

  validates_presence_of :name
  validates_uniqueness_of :identifier
  validates_numericality_of :field_type, :allow_nil=>false, :only_integer=>true, :greater_than_or_equal_to=>PropertyType::FIELD_TYPES.values.min, :less_than_or_equal_to=>PropertyType::FIELD_TYPES.values.max

  before_validation :fill_in_identifier

  attr_accessible :name, :identifier, :field_type


  def fill_in_identifier
    if self.identifier.blank?
      self.identifier = self.name.parameterize unless self.name.blank?
    end
  end

end
