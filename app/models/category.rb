class Category < ActiveRecord::Base
  acts_as_category

  has_and_belongs_to_many :products

  has_attached_file :icon, :styles=>{:icon=>"24x24#", :small=>"100x100#", :medium=>"250x250#"}
  validates_presence_of :name
  validates_attachment_content_type :icon, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/pjpeg', 'image/x-png']

  attr_accessible :name, :parent_id, :icon, :description, :short_description




  def to_s
    self.name
  end

  def to_param
    "#{self.id}-#{self.name ? self.name.parameterize : ''}"
  end


end
