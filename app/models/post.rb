class Post < ActiveRecord::Base
  extend FriendlyId
  
  friendly_id :title, use: [:slugged, :history]
  
  #validates :name, :presence => true
  validates :title, :presence => true, :length => { :minimum => 2}

  belongs_to :user  
  has_many :comments, dependent: :destroy, :autosave => true
  has_and_belongs_to_many :tags, :autosave => true
  
  accepts_nested_attributes_for :tags, allow_destroy: :true, 
    reject_if: proc{ |attrs| attrs.all?{|k,v| v.blank? } }
end
