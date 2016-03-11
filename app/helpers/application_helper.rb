module ApplicationHelper
	SITE_NAME = "Groupify.me"

	def title_helper
		@title ? "#{@title} | #{SITE_NAME}" : SITE_NAME
	end
end
