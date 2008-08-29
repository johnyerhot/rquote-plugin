# Rquote
require 'net/http'
require 'csv'

class Rquote

@@service_uri = "http://download.finance.yahoo.com/d/quotes.csv"

  def init
  end
  
  def find(*args)
    output = Array.new
    i = 0
    String.new(send_request(*args)).each do |line|
      a = line.chomp.split(",")
      output << { :symbol => args[i].to_s, 
                  :price => a[0],
                  :change => a[1], 
                  :volume => a[2]
                }
      i += 1
    end
    return output
  end
  
  def send_request(*args)
    completed_path = @@service_uri + construct_args(args)
    uri = URI.parse(completed_path)
    response = Net::HTTP.start(uri.host, uri.port) do |http|
      http.get completed_path
    end
    return response.body
  end
  
  def construct_args(*args)
    path = "?f=l1c1v&s=" + args.join(",")
  end

end