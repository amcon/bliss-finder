class ExceptionsController < ApplicationController

	def page_not_found
		set_meta_tags(
			title: "404 Not Found",
		)
		respond_to do |format|
			format.html { render template: 'exceptions/page_not_found', layout: 'layouts/application', status: 404 }
			format.all { render nothing: true, status: 404 }
		end
	end

	def unprocessable
		set_meta_tags(
			title: "422 Unprocessable",
		)
		respond_to do |format|
			format.html { render template: 'exceptions/unprocessable', layout: 'layouts/application', status: 422 }
			format.all { render nothing: true, status: 422 }
		end
	end

	def server_error
		set_meta_tags(
			title: "500 Server Error",
		)
		respond_to do |format|
			format.html { render template: 'exceptions/server_error', layout: 'layouts/application', status: 500 }
			format.all { render nothing: true, status: 500 }
		end
	end

end
