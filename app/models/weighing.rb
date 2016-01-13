class Weighing < ActiveRecord::Base
  attr_accessible :user_id, :date, :weight, :abdominal_girth, :adipose

	belongs_to :user

	validates_presence_of :user_id, :weight, :date
	validates_uniqueness_of :date, :scope => [:user_id]
	accepts_nested_attributes_for :user

  attr_accessor :timespan

end