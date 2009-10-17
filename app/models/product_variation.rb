class ProductVariation < ActiveRecord::Base

  has_and_belongs_to_many :options
  belongs_to :product


  validates_numericality_of :price, :only_integer=>false, :greater_than_or_equal_to=>0, :allow_nil=>false

  def to_s
    s = self.options.map{|o| "#{o.option_group.name}: #{o.name}"}
    s.join ", "
  end

end
