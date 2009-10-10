class PropertyType < ActiveRecord::Base

  FIELD_TYPES = ['string', 'boolean', 'text']

  validates_presence_of :name
  validates_uniqueness_of :identifier
  validates_inclusion_of :field_type, :allow_nil=>false, :in=>PropertyType::FIELD_TYPES

  before_validation :fill_in_identifier

  attr_accessible :name, :identifier, :field_type


  def fill_in_identifier
    if self.identifier.blank?
      self.identifier = self.name.parameterize unless self.name.blank?
    end
  end

end
