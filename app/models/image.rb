class Image < ActiveRecord::Base

  belongs_to :product

  has_attached_file :attachment, :styles=>{:list=>"40x40#", :small=>"100x100#", :medium=>"150x150", :medium_gift=>"150x150>", :big=>"800x800>", :middle_size=>"90x66>", :photo=>"230x190#", :small_size=>"45x37#" }
  validates_attachment_presence :attachment
  validates_attachment_content_type :attachment, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/pjpeg', 'image/x-png']
  validates_attachment_size :attachment, :less_than => 10.megabytes
  
end
