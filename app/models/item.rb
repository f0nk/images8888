class Item < ActiveRecord::Base
	has_many :pictures
	attr_accessible :tag_list
	acts_as_taggable
	acts_as_taggable_on :categorys, :sources

end
