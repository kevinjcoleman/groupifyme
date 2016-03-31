Nation.switch_to 'chathamgop'
​
ActiveRecord::Base.logger = nil
​
author = Signup.find_with_like_by_email('help@nationbuilder.com')
i = CSV.open('/home/kevinjcoleman/chathamgop_results.csv', headers: true).count
​
CSV.open('/home/kevinjcoleman/chathamgop_merge_errors.csv', 'wb') do |error_csv|
  #error_csv << CSV.open('/home/kevinjcoleman/chathamgop_results.csv').first
​
  CSV.foreach('/home/kevinjcoleman/chathamgop_results.csv', headers: true) do |row|
      i -= 1; puts i if i % 100 == 0
      begin
        # Find the people to merge
        first_person = Signup.find(row['t1'].strip.to_i)
        second_person = Signup.find(row['t2'].strip.to_i)
        next unless first_person && second_person
​
        # Start a new SignupMerger
        merger = SignupMerger.new(first_person, author)
     
        # Determine who wins in case of conflicts
        # In this case, the person with the more recent signup updated_at will win.
        
        first_person.updated_at >= second_person.updated_at ? conflict_winner = first_person : conflict_winner = second_person
        
        merger.resolve_name_with = conflict_winner
        merger.resolve_phone_number_with = conflict_winner
        merger.resolve_mobile_number_with = conflict_winner
        merger.resolve_work_phone_number_with = conflict_winner
        merger.resolve_twitter_with = conflict_winner
        merger.resolve_facebook_with = conflict_winner
        merger.resolve_recruiter_with = conflict_winner
        
        if first_person.mailing_address && second_person.mailing_address
          merger.resolve_mailing_address_with = conflict_winner
        end
        
        if first_person.registered_address && second_person.registered_address
          merger.resolve_registered_address_with = conflict_winner
        end
        
        if first_person.home_address && second_person.home_address
          merger.resolve_home_address_with = conflict_winner
        end
     
        if first_person.work_address && second_person.work_address
          merger.resolve_work_address_with = conflict_winner
        end
​
        if first_person.billing_address && second_person.billing_address
          merger.resolve_billing_address_with = conflict_winner
        end
​
        # Merge in the second person (this generates an activity)
        merger.merge_in(second_person)
     
      rescue => e
        # Output an error to the console and log it in the error csv
        puts "Error: #{e.message}"
        error_csv << row.to_hash.values.push(e.message)
      end
  end
end


CSV.open('/home/kevinjcoleman/chathamgop_merge_errors.csv', 'wb') do |error_csv|
  error_csv << CSV.open('/home/kevinjcoleman/chathamgop_results.csv').first

  CSV.foreach('/home/kevinjcoleman/chathamgop_results.csv', headers: true) do |row|
      i -= 1; puts i if i % 100 == 0
      begin
        # Find the people to merge
        first_person = Signup.find(row['t1'].strip.to_i)
        second_person = Signup.find(row['t2'].strip.to_i)
        next unless first_person && second_person

        # Start a new SignupMerger
        merger = SignupMerger.new(first_person, author)
     
        # Determine who wins in case of conflicts
        # In this case, the person with the more recent signup updated_at will win.
        
        first_person.updated_at >= second_person.updated_at ? conflict_winner = first_person : conflict_winner = second_person
        
        merger.resolve_name_with = conflict_winner
        merger.resolve_phone_number_with = conflict_winner
        merger.resolve_mobile_number_with = conflict_winner
        merger.resolve_work_phone_number_with = conflict_winner
        merger.resolve_twitter_with = conflict_winner
        merger.resolve_facebook_with = conflict_winner
        merger.resolve_recruiter_with = conflict_winner
        
        if first_person.mailing_address && second_person.mailing_address
          merger.resolve_mailing_address_with = conflict_winner
        end
        
        if first_person.registered_address && second_person.registered_address
          merger.resolve_registered_address_with = conflict_winner
        end
        
        if first_person.home_address && second_person.home_address
          merger.resolve_home_address_with = conflict_winner
        end
     
        if first_person.work_address && second_person.work_address
          merger.resolve_work_address_with = conflict_winner
        end

        if first_person.billing_address && second_person.billing_address
          merger.resolve_billing_address_with = conflict_winner
        end

        if first_person.twitter_address && second_person.twitter_address
          merger.resolve_twitter_address_with = conflict_winner
        end

        # Merge in the second person (this generates an activity)
        merger.merge_in(second_person)
     
      rescue => e
        # Output an error to the console and log it in the error csv
        puts "Error: #{e.message}"
        error_csv << row.to_hash.values.push(e.message)
      end
  end
end