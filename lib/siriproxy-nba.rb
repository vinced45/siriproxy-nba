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
      	
      	say "Step 1"
      	games = doc.xpath("//table")
      	games.each {
      	|game|
      	say "Step 2"
      	time = game.xpath("//tr/th/span")
      	@firstTeamName = "CHI"
  		@firstTeamScore = "97"
  		@secondTeamName = "IND"
  		@secondTeamScore = "90"
  		@timeLeft = time.content
  		}
      	
      	say "Step 3"
      	
       	
      if((@firstTeamName == "") || (@secondTeamName == ""))
        response = "No games involving the " + userTeam + " were found playing tonight"
      else 
        response = "The score for the " + userTeam + " game is: " + @firstTeamName + " (" + @firstTeamScore + "), " + @secondTeamName + " (" + @secondTeamScore + ") with" + @timeLeft + " left." 
			end  
			@firstTeamName = ""
			@secondTeamName = ""
			say response
			
			request_completed
		}
		
	  say "Checking to see if the " + userTeam + " played today."
	  
	end
	
  def pickOutTeam(phrase)
    if(phrase.match(/boston/i) || phrase.match(/celtics/i)) 
      return "Celtics"
    elsif(phrase.match(/new jersy/i) || phrase.match(/nets/i))
      return "Nets"
    elsif(phrase.match(/new york/i) || phrase.match(/knicks/i))
      return "Knicks"
    elsif(phrase.match(/philadelphia/i) || phrase.match(/76ers/i))
      return "76ers"
    elsif(phrase.match(/toronto/i) || phrase.match(/raptors/i))
      return "Raptors"
    elsif(phrase.match(/chicago/i) || phrase.match(/bulls/i))
      return "Bulls"
    elsif(phrase.match(/cleveland/i) || phrase.match(/cavaliers/i))
      return "Cavaliers"
    elsif(phrase.match(/detroit/i) || phrase.match(/pistons/i))
      return "Pistons"
    elsif(phrase.match(/indiana/i) || phrase.match(/pacers/i))
      return "Pacers"
    elsif(phrase.match(/milwaukee/i) || phrase.match(/bucks/i))
      return "Bucks"
    elsif(phrase.match(/atlanta/i) || phrase.match(/hawks/i))
      return "Hawks"
    elsif(phrase.match(/charlotte/i) || phrase.match(/bobcats/i))
      return "Bobcats"
    elsif(phrase.match(/miami/i) || phrase.match(/heat/i))
      return "Heat"
    elsif(phrase.match(/orlando/i) || phrase.match(/magic/i))
      return "Magic"
    elsif(phrase.match(/washington/i) || phrase.match(/wizards/i))
      return "Wizards"
    elsif(phrase.match(/golden state/i) || phrase.match(/warriors/i))
      return "Warriors"
    elsif(phrase.match(/clippers/i) || phrase.match(/clippers/i))
      return "Clippers"
    elsif(phrase.match(/lakers/i) || phrase.match(/lakers/i))
      return "Lakers"
    elsif(phrase.match(/phoenix/i) || phrase.match(/phoenix/i))
      return "Suns"
    elsif(phrase.match(/sacramento/i) || phrase.match(/kings/i))
      return "Kings"
    elsif(phrase.match(/dallas/i) || phrase.match(/mavericks/i))
      return "Mavericks"
    elsif(phrase.match(/houston/i) || phrase.match(/rockets/i))
      return "Rockets"
    elsif(phrase.match(/memphis/i) || phrase.match(/grizzles/i))
      return "Grizzles"
    elsif(phrase.match(/new orleans/i) || phrase.match(/hornets/i))
      return "Hornets"
    elsif(phrase.match(/san antonio/i) || phrase.match(/spurs/i))
      return "Spurs"
    elsif(phrase.match(/denver/i) || phrase.match(/nuggets/i))
      return "Nuggets"
    elsif(phrase.match(/minnesota/i) || phrase.match(/timberwolves/i))  
      return "Timberwolves"
    elsif(phrase.match(/oklahoma/i) || phrase.match(/thunder/i))
      return "Thunder"
    elsif(phrase.match(/portland/i) || phrase.match(/trailblazers/i))
      return "Trailblazers"
    elsif(phrase.match(/utah/i) || phrase.match(/jazz/i))
      return "Jazz"
	else
		return phrase
	end
	
	end
end
