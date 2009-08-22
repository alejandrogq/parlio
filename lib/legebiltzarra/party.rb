module Legebiltzarra
  class Party
    BASE_URL = "http://www.parlamento.euskadi.net"
    attr_accessor :content

    def initialize(content)
      @content = content
    end

    def group_name
      @content.search('td')[0].content
    end
        
    def acronym
      @content.search('td')[1].content
    end
    
    def sites
      @content.search('td')[2].content
    end
    
    def name
      @content.search('td')[3].content
    end

    def url
      @content.search('td')[4].search('a/@href')[0]
    end
                
    def logo
      BASE_URL + @content.search('td')[4].search('img/@src')[0]
    end
    
    def parliamentarians
      parl_url = BASE_URL + @content.search('td')[0].search('a/@href')[0]
      parl_list ||= Nokogiri::HTML(open(parl_url).read)
      parl_list.search('table[@class="parlamentarios"]/tr/td[@class="miembro_persona"]/a/@href').map{ |p| Parliamentarian.new(p.content.match(/\d+/)[0]) }
    end
    
  end
end