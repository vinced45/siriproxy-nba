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
  @teamInt = ""	
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
      	
      	#say "Step 1"
      	#games = doc.xpath("//*[@class=\"match\"]")
      	games = doc.css(".match")
      	games.each {
      	|game|
      	#say "Step 2"
      	@timeLeft = game.css(".snap-5").first.content.strip
      	#say "Step 2.5"
      	firstTeam = game.css(".competitor").first
      	secondTeam = game.css(".competitor").last
      	@firstTeamName = firstTeam.css("strong").first.content.strip
      	@firstTeamScore = firstTeam.css("td").last.content.strip
      	@secondTeamName = secondTeam.css("strong").first.content.strip
      	@secondTeamScore = secondTeam.css("td").last.content.strip
      	}
      	
      	if (@firstTeamName != @teamInt)
      		if  (@secondTeamName != @teamInt)
      			@firstTeamName = ""
      			@secondTeamName = ""
      		end
      	end
      	
      	if (@secondTeamName != @teamInt)
      		if  (@firstTeamName != @teamInt)
      			@firstTeamName = ""
      			@secondTeamName = ""
      		end
      	end
      		 
      	#firstTeamName = game.xpath("/table/tbody/tr[3]/td/strong").first
  		#firstTeamScore = game.xpath("/table/tbody/tr[3]/td[2]").first
  		#secondTeamName = game.xpath("/table/tbody/tr[4]/td/strong").first
  		#secondTeamScore = game.xpath("/table/tbody/tr[4]/td[2]").first
  		#say "Step 2.75"
  		#@firstTeamName = firstTeamName.text
  		#@firstTeamScore = firstTeamScore.text
  		#@secondTeamName = secondTeamName.text
  		#@secondTeamScore = secondTeamScore.text
  		#@timeLeft = time.text
  		
  		#say "The score for the " + userTeam + " game is: " + @firstTeamName + " (" + @firstTeamScore + "), " + @secondTeamName + " (" + @secondTeamScore + ") with" + @timeLeft + " left."
  		
      	
      	#say "Step 3"
      	
       	
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
    	@teamInt = "BOS"
      return "Celtics"
      end
    if(phrase.match(/new jersy/i) || phrase.match(/nets/i))
    @teamInt = "NJN"
      return "Nets"
      end
    if(phrase.match(/new york/i) || phrase.match(/knicks/i))
    @teamInt = "NYK"
      return "Knicks"
      end
    if(phrase.match(/philadelphia/i) || phrase.match(/76ers/i))
    @teamInt = "PHI"
      return "76ers"
      end
    if(phrase.match(/toronto/i) || phrase.match(/raptors/i))
    @teamInt = "TOR"
      return "Raptors"
      end
    if(phrase.match(/chicago/i) || phrase.match(/bulls/i))
    @teamInt = "CHI"
      return "Bulls"
      end
    if(phrase.match(/cleveland/i) || phrase.match(/cavaliers/i))
    @teamInt = "CLE"
      return "Cavaliers"
      end
    if(phrase.match(/detroit/i) || phrase.match(/pistons/i))
    @teamInt = "DET"
      return "Pistons"
      end
    if(phrase.match(/indiana/i) || phrase.match(/pacers/i))
    @teamInt = "IND"
      return "Pacers"
      end
    if(phrase.match(/milwaukee/i) || phrase.match(/bucks/i))
    @teamInt = "MIL"
      return "Bucks"
      end
    if(phrase.match(/atlanta/i) || phrase.match(/hawks/i))
    @teamInt = "ATL"
      return "Hawks"
      end
    if(phrase.match(/charlotte/i) || phrase.match(/bobcats/i))
    @teamInt = "CHA"
      return "Bobcats"
      end
    if(phrase.match(/miami/i) || phrase.match(/heat/i))
    @teamInt = "MIA"
      return "Heat"
      end
    if(phrase.match(/orlando/i) || phrase.match(/magic/i))
    @teamInt = "ORL"
      return "Magic"
      end
    if(phrase.match(/washington/i) || phrase.match(/wizards/i))
    @teamInt = "WAS"
      return "Wizards"
      end
    if(phrase.match(/golden state/i) || phrase.match(/warriors/i))
    @teamInt = "GSW"
      return "Warriors"
      end
    if(phrase.match(/clippers/i) || phrase.match(/clippers/i))
    @teamInt = "LAC"
      return "Clippers"
      end
    if(phrase.match(/lakers/i) || phrase.match(/lakers/i))
    @teamInt = "LAL"
      return "Lakers"
      end
    if(phrase.match(/phoenix/i) || phrase.match(/phoenix/i))
    @teamInt = "PHX"
      return "Suns"
      end
    if(phrase.match(/sacramento/i) || phrase.match(/kings/i))
    @teamInt = "SAC"
      return "Kings"
      end
    if(phrase.match(/dallas/i) || phrase.match(/mavericks/i))
    @teamInt = "DAL"
      return "Mavericks"
      end
    if(phrase.match(/houston/i) || phrase.match(/rockets/i))
    @teamInt = "HOU"
      return "Rockets"
      end
    if(phrase.match(/memphis/i) || phrase.match(/grizzles/i))
    @teamInt = "MEM"
    return "Grizzles"
    end
    if(phrase.match(/new orleans/i) || phrase.match(/hornets/i))
    @teamInt = "NOR"
      return "Hornets"
      end
    if(phrase.match(/san antonio/i) || phrase.match(/spurs/i))
    @teamInt = "SAN"
      return "Spurs"
      end
    if(phrase.match(/denver/i) || phrase.match(/nuggets/i))
    @teamInt = "DEN"
      return "Nuggets"
      end
    if(phrase.match(/minnesota/i) || phrase.match(/timberwolves/i))
    @teamInt = "MIN"
      return "Timberwolves"
      end
    if(phrase.match(/oklahoma/i) || phrase.match(/thunder/i))
    @teamInt = "OKC"
      return "Thunder"
      end
    if(phrase.match(/portland/i) || phrase.match(/trailblazers/i))
    @teamInt = "POR"
      return "Trailblazers"
      end
    if(phrase.match(/utah/i) || phrase.match(/jazz/i))
    @teamInt = "UTH"
      return "Jazz"
      end
	
		return phrase
	end
	
	end
end
