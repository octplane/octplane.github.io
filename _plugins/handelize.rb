module Jekyll
  module HandleFilter

    def handleize(content)
      content.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end

    MAP = {
    	"code" => "code",
    	"AWS" => "cloud",
    	"gaming" => "gamepad",
    	"jeu" => "gamepad",
    	"ios" => "mobile"
    }
    def tagelize(content)
    	content.map do|t|
    		if MAP.has_key?(t)
    			%Q|<i class="fa fa-#{MAP[t]}" alt="#{t}"></i>|
    		else
    			t
    		end
	    end
    end

  end
end

Liquid::Template.register_filter(Jekyll::HandleFilter)
