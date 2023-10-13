class StaticController < ApplicationController

	def terms
		set_meta_tags(
			title: "Terms",
			description: "Terms and Conditions and Privacy Policy"
		)
	end

	def coming_soon
		set_meta_tags(
			title: "Coming Soon",
			description: "Bliss-finder is under construction... Please check back on 10/24!"
		)
	end

	def home
		set_meta_tags(
			title: "",
			description: "Here at Bliss-Finder™️, our mission is simple. Unite the world in harmony through meaningful connections. So go ahead, make a profile today and watch how quickly your life can change."
		)
	end

end
