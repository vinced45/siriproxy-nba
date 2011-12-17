require 'cora'
require 'siri_objects'
require 'open-uri'
require 'nokogiri'

#############
# This is a plugin for SiriProxy that will allow you to check tonight's NBA scores
# Example usage: "What's the score of the Bulls game?"
#############

class SiriProxy::Plugin::nba < SiriProxy::Plugin

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
      else 
        response = "The score for the " + userTeam + " game is: " + @firstTeamName + " (" + @firstTeamScore + "), " + @secondTeamName + " (" + @secondTeamScore + ")"
			end  
			@firstTeamName = ""
			@secondTeamName = ""
			say response
			
			request_completed
		}
		
	  say "Checking on tonight's NBA games"
	end
	
  def pickOutTeam(phrase)
      return "Celtics"
    
	  
	  # The above should catch city names, team nicknames, or words which Siri would misinterpret
	  # If the person said the team name verbatim as NHL needs just return it
    
   
    
	end
end
