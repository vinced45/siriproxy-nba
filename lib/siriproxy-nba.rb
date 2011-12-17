require 'cora'
require 'siri_objects'
require 'open-uri'
require 'nokogiri'

#############
# This is a plugin for SiriProxy that will allow you to check tonight's NBA scores
# Example usage: "What's the score of the Bulls game?"
#############

class SiriProxy::Plugin::NBA < SiriProxy::Plugin

  @firstTeamName = ""
  @firstTeamScore = ""
  @secondTeamName = ""
  @secondTeamScore = ""
  @timeLeft = ""
	
	def initialize(config)
    #if you have custom configuration options, process them here!
    end
  
  listen_for /score of the (.*) game/i do |phrase|
	  team = pickOutTeam(phrase)
	  score(team) #in the function, request_completed will be called when the thread is finished
	end
	
	def score(userTeam)
	  Thread.new {
	    doc = Nokogiri::HTML(open("http://m.espn.go.com/nba/scoreboard"))
      	
      	games = doc.xpath("/table")
      	
      	
      	
       	
      if((@firstTeamName == "") || (@secondTeamName == ""))
        response = "No games involving the " + userTeam + " were found playing tonight"
        end
      else 
        response = "The score for the " + userTeam + " game is: " + @firstTeamName + " (" + @firstTeamScore + "), " + @secondTeamName + " (" + @secondTeamScore + ")"
			end  
			@firstTeamName = ""
			@secondTeamName = ""
			say response
			
			request_completed
		}
		
	  say "Checking to see if the" + userTeam + "played today."
	  
	end
	
  def pickOutTeam(phrase)
    	if(phrase.match(/boston/i) || phrase.match(/celtics/i)) 
      		return "Celtics"
		end
    	if(phrase.match(/new jersy/i) || phrase.match(/nets/i))
      		return "Nets"
    	end
    	if(phrase.match(/new york/i) || phrase.match(/knicks/i))
      		return "Knicks"
    end
    
    
	end
end
