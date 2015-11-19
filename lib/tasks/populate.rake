namespace :db do
	desc "Erase and fill database"
	task :populate => :environment do
		require 'populator'
		require 'faker'

		[Product].each(&:delete_all)

		Product.populate 15 do | product |
			product.name = Populator.words(1..3).titleize
			product.image_id = "#{product.id}.jpg"
			product.sku = rand(00000..99999)
			product.permalink = product.name
			product.description = Populator.sentences(2..10)
			product.short_description = product.description.first(99)
			product.price = rand(23.99..129.99)
			product.created_at = 1.years.ago..Time.now
		end
	end
end