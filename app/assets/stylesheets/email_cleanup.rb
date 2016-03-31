import_date = Date.new(2016,3,3)
tag = SignupTag.find_by_name "VoterFileUpdate_20160229"
tag.signups.find_each do |signup|
	if !signup.is_supporter?
		signup.email1 = nil
		signup.email2 = nil
		signup.email3 = nil
		signup.email4 = nil
		signup.save
	elsif signup.is_supporter? && signup.first_supporter_at
		if signup.first_supporter_at > import_date
			signup.email1 = nil
			signup.email2 = nil
			signup.email3 = nil
			signup.email4 = nil
			signup.is_supporter = false
			signup.save
		end
	elsif signup.emails.any?
		signup.email1 = nil if signup.email1_is_bad == true
		signup.email2 = nil if signup.email2_is_bad == true
		signup.email3 = nil if signup.email3_is_bad == true
		signup.email4 = nil if signup.email4_is_bad == true
		signup.save
	end
end
