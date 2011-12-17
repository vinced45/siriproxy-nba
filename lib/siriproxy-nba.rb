require 'cora'
require 'siri_objects'
require 'open-uri'
require 'nokogiri'

#############
# This is a plugin for SiriProxy that will allow you to check tonight's hockey scores
# Example usage: "What's the score of the Avalanche game?"
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
      	#games = doc.xpath('div[@id = "scoreboard"]')
      	games = doc.xpath('table[@class = "match"]')
      	
      	games.each do 
      		|game|
      		@timeLeft = game.xpath('/table/tr/th/span')
      		@firstTeam = game.xpath('/table/tr/td/strong')
      		@firstTeamScore = ""
      		@secondTeam = game.xpath('/table/tr/td/strong')
      		@secondTeamScore = ""
      	end
      		
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
    if(phrase.match(/boston/i) || phrase.match(/celtics/i)) 
      return "Celtics"
    end
    if(phrase.match(/new jersy/i) || phrase.match(/nets/i))
      return "Nets"
    end
    if(phrase.match(/new york/i) || phrase.match(/knicks/i))
      return "Knicks"
    end
    if(phrase.match(/philadelphia/i) || phrase.match(/76ers/i))
      return "76ers"
    end
    if(phrase.match(/toronto/i) || phrase.match(/raptors/i))
      return "Raptors"
    end
    if(phrase.match(/chicago/i) || phrase.match(/bulls/i))
      return "Bulls"
    end
    if(phrase.match(/cleveland/i) || phrase.match(/cavaliers/i))
      return "Cavaliers"
    end
    if(phrase.match(/detroit/i) || phrase.match(/pistons/i))
      return "Pistons"
    end
    if(phrase.match(/indiana/i) || phrase.match(/pacers/i))
      return "Pacers"
    end
    if(phrase.match(/milwaukee/i) || phrase.match(/bucks/i))
      return "Bucks"
    end
    if(phrase.match(/atlanta/i) || phrase.match(/hawks/i))
      return "Hawks"
    end
    if(phrase.match(/charlotte/i) || phrase.match(/bobcats/i))
      return "Bobcats"
    end
    if(phrase.match(/miami/i) || phrase.match(/heat/i))
      return "Heat"
    end
    if(phrase.match(/orlando/i) || phrase.match(/magic/i))
      return "Magic"
    end
    if(phrase.match(/washington/i) || phrase.match(/wizards/i))
      return "Wizards"
    end
    if(phrase.match(/golden state/i) || phrase.match(/warriors/i))
      return "Warriors"
    end
    if(phrase.match(/clippers/i) || phrase.match(/clippers/i))
      return "Clippers"
    end
    if((phrase.match(/lakers/i) || phrase.match(/lakers/i))
      return "Lakers"
    end
    if(phrase.match(/phoenix/i) || phrase.match(/phoenix/i))
      return "Suns"
    end
    if(phrase.match(/sacramento/i) || phrase.match(/kings/i))
      return "Kings"
    end
    if(phrase.match(/dallas/i) || phrase.match(/mavericks/i))
      return "Mavericks"
    end
    if(phrase.match(/houston/i) || phrase.match(/rockets/i))
      return "Rockets"
    end
    if(phrase.match(/memphis/i) || phrase.match(/grizzles/i))
      return "Grizzles"
    end
    if(phrase.match(/new orleans/i) || phrase.match(/hornets/i))
      return "Hornets"
    end
    if(phrase.match(/san antonio/i) || phrase.match(/spurs/i))
      return "Spurs"
    end
    if(phrase.match(/denver/i) || phrase.match(/nuggets/i))
      return "Nuggets"
    end
    if(phrase.match(/minnesota/i) || phrase.match(/timberwolves/i))  
      return "Timberwolves"
    end
    if(phrase.match(/oklahoma/i) || phrase.match(/thunder/i))
      return "Thunder"
    end
    if(phrase.match(/portland/i) || phrase.match(/trailblazers/i))
      return "Trailblazers"
    end
    if(phrase.match(/utah/i) || phrase.match(/jazz/i))
      return "Jazz"
    end
	  
	  # The above should catch city names, team nicknames, or words which Siri would misinterpret
	  # If the person said the team name verbatim as NHL needs just return it
    
    return phrase
    
	end
end
