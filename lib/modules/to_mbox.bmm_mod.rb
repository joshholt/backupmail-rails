# to_mbox.bmm_mod.rb
#     
#	@Author Josh Holt
# @Date 02.09.2009
#
# @purpose --> The purpose of this module is to squash email
#            into the associated mbox archive.
#***********************************************************************

module Backup
	module Mail
		module ToMbox
		  
		  class CurrentEmail
		    attr_accessor :lines
		    
		    def initialize(lines)
		      @lines = lines if lines
		    end
		    
		    def make_header()
  				from_header = @lines.detect { |line| line =~ /^From: / }
  				date_header = @lines.detect { |line| line =~ /^Date: / }
  				
  				if /<(.*)>/.match(from_header)
  					sender = $1
  				else
  					sender = /From: (.*)/.match(from_header)[1]
  				end
  				
  				place_holder, weekday, day, month, year, time = /^Date: (...), ([0-9]*) (...) (....) (........)/.match(date_header).to_a
  				if day.length == 1 
  				  day = " " + day 
  				end
  				
  				# Although You don't have to use return I like 
  				# to be able to look at the code and see it right away
  				return "From " + sender + " " + weekday + " " + month + " " + day + " " + time + " " + year
  			end
  			
  			def escape()
  				result = []
  				
  				@lines.each do |line|
  					if line =~ /^>*From / then line = ">" + line end
  					result.push(line)
  				end
  				
  				return result
  			end
  			
  			def write_archive(backupDir)
  			  begin
  			    mbox_file = File.open("#{backupDir}/inbox.mbox", 'a')  do |archive|
    			    archive.write(make_header())
    			    archive.write(escape())
    			    archive.write("")
  			    end
  			  rescue Exception => e
  			   raise
  			  end
  			  
			  end  			
		  end
		  
		end
	end
end