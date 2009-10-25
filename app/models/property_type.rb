class PropertyType < ActiveRecord::Base

  FIELD_TYPES = ['string', 'boolean', 'text']

  has_many :properties
  has_many :products, :through => :properties
  
  default_scope :order=>['position ASC']
  
  has_attached_file :icon, :styles=>{:icon=>"24x24#", :small=>"100x100#", :medium=>"250x250#"}
  validates_presence_of :name
  validates_uniqueness_of :identifier
  validates_inclusion_of :field_type, :allow_nil=>false, :in=>PropertyType::FIELD_TYPES
  validates_attachment_content_type :icon, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/pjpeg', 'image/x-png']

  before_validation :fill_in_identifier

  attr_accessible :name, :identifier, :field_type, :icon, :description, :short_description


  def fill_in_identifier
    if self.identifier.blank?
      self.identifier = self.name.parameterize unless self.name.blank?
    end
  end
  
  def to_param
    unless self.identifier.blank?
      "#{self.id}-#{self.identifier.parameterize}"
    else
      self.id.to_s
    end
  end

end
