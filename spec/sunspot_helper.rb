require "net/http"
 
class CukeSunspot
 
  def initialize
    @server = Sunspot::Rails::Server.new
  end
 
  def start
    @started = Time.now
    @server.start
    up
  end
  
  def self.stop
    puts "Sunspot server is stoping..."
    Sunspot::Rails::Server.new.stop
  end
 
private
  def port
    @server.port
  end
 
  def uri
    "http://0.0.0.0:#{port}/solr/"
  end
 
  def up
    while starting
      puts "Sunspot server is starting..."
    end
    puts "Sunspot server took #{'%.2f' % (Time.now - @started)} sec. to get up and running. Let's cuke!"
  end
 
  def starting
    begin
      sleep(1)
      request = Net::HTTP.get_response(URI.parse(uri))
      false
    rescue Errno::ECONNREFUSED
      true
    end
  end
 
end