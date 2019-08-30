class Questions < ActiveRecord::Base
	def catz
		["General", "Entertainment", "History", "Programming", "Science", "Education", "Music", "Photography", "Technology", "Mobile Phones", "Software", "Android", "Windows", "Apple", "Ruby", "HTML", "Internet", "Economy", "Relationship"].sort
	end
end