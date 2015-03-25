# Class: MapString
#
# Models a map string.
#
# Attributes:
# @marker_strings - Array: initially empty.
# @url            - String: url to send to Google Static Maps API.
#
# Public Methods:
# #add_type_marker
# #add_prob_marker
# #add_accum_marker
# #generate_map_url
#
# Private Methods:
# #label_and_location

class MapString
  
  # include Marker
  
  attr_accessor :marker_strings
  attr_reader :url
  
  def initialize
    @marker_strings  = []
  end

  # Public: #add_type_marker
  # Generates a marker string to represent resort precipitation type.
  #
  # Parameters:
  # @dpreciptype - String: contains precipitation type.
  # @resort      - Object: Resort.
  #
  # Returns:
  # @marker_strings.
  #
  # State Changes:
  # Adds string to @marker_strings.

  def add_type_marker(dpreciptype,resort)
    #eg: color:0xFFFF00%7Clabel:B%7C62.107733,-145.541936
    color = get_pcp_type_description(dpreciptype)
    #color = Marker.get_pcp_type_description(dpreciptype)
    @marker_strings << "color:0x" + color + label_and_location(resort)
  end
  
  # Public: #add_prob_marker
  # Generates a marker string to represent resort precipitation probability.
  #
  # Parameters:
  # @dprecipprob - Number: precipitation probability.
  # @resort      - Object: Resort.
  #
  # Returns:
  # @marker_strings.
  #
  # State Changes:
  # Adds string to @marker_strings.
  
  def add_prob_marker(dprecipprob,resort)
    color = get_pcp_prob_description(dprecipprob)
    #color = Marker.get_pcp_prob_description(dprecipprob)
    @marker_strings << "color:0x" + color + label_and_location(resort)
  end
  
  # Public: #add_accum_marker
  # Generates a marker string to represent resort precipitation accumulation.
  #
  # Parameters:
  # @dprecipprob - Number: precipitation accumulation.
  # @resort      - Object: Resort.
  #
  # Returns:
  # @marker_strings.
  #
  # State Changes:
  # Adds string to @marker_strings.
  
  def add_accum_marker(dprecipaccum,resort)
    color = get_pcp_accum_description(dprecipaccum)
    #color = Marker.get_pcp_accum_description(dprecipaccum)
    @marker_strings << "color:0x" + color + label_and_location(resort)
  end
  
  # Public: #generate_map_url
  # Combines current values in @marker_strings to a url string for submission
  #  to Google Static Maps API.
  #
  # Parameters:
  # none.
  #
  # Returns:
  # @url
  #
  # State Changes:
  # none.
  
  def generate_map_url
    string_base = "https://maps.googleapis.com/maps/api/staticmap?"
    size_type = "size=225x150&maptype=terrain&markers="
    m_string = @marker_strings.join("&markers=")
    @url = string_base + size_type + m_string
  end
  
  private
    
  # Private: #label_and_location
  # Generates resort dependent portion of marker string.
  #
  # Parameters:
  # resort
  #
  # Returns:
  # string
  #
  # State Changes:
  # none.
    
  def label_and_location(resort)
    r_lat = resort.latitude.to_s
    r_lon = resort.longitude.to_s
    "%7Clabel:#{resort.name[0..0]}%7C"+r_lat+","+r_lon
  end
  
  # Public: .
  # Gets a list of users with the given name.
  #
  # Parameters:
  # x - String: The name to search for.
  #
  # Returns: Array containing objects for matching user records.
  
  def get_pcp_type_description(x) #self.
    if x == "snow"
      m_hex = "0066CC" #Marker.find(1).description
    elsif x == "rain"
      m_hex = "00CC00" #Marker.find(2).description
    elsif x == "sleet"
      m_hex = "FF66FF" #Marker.find(12).description
    else
      m_hex = "A0A0A0" #Marker.find(3).description
    end
    m_hex
  end
  
  
  def get_pcp_accum_description(x) #self.
    if x == nil
      m_hex = "A0A0A0" #Marker.find(4).description
    elsif x > 0 && x < 2
      m_hex = "66B2FF" #Marker.find(5).description
    elsif x >= 2 && x < 6
      m_hex = "0080FF" #Marker.find(6).description
    elsif x >= 6
      m_hex = "004C99" #Marker.find(7).description
    end
    m_hex
  end
  
  
  def get_pcp_prob_description(x) #self.
    if x==0
      m_hex = "C0C0C0" #Marker.find(8).description
    elsif x > 0 && x < 0.5
      m_hex = "99FF99" #Marker.find(9).description
    elsif x >= 0.5 && x < 0.75
      m_hex = "00FF00" #Marker.find(10).description
    elsif x >= 0.75 && x <= 1.0
      m_hex = "009900" #Marker.find(11).description
    end
    m_hex
  end
  
end

# id   condition     description
# ---  ------------  ------------
# 1    snow          0066CC
# 2    rain          00CC00
# 3    nil           A0A0A0
# 4    accum0        A0A0A0
# 5    accum0t2      66B2FF
# 6    accum2t6      0080FF
# 7    accumgt6      004C99
# 8    pprob0        C0C0C0
# 9    pproblt50     99FF99
# 10   pproblt75     00FF00
# 11   pproblt1      009900
# 12   sleet         FF66FF
  