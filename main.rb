require 'socket'
require 'uri'
require 'net/http'
require 'json'

server = TCPServer.new 5678
 
while session = server.accept
  request = session.gets

  uri = URI('http://api.open-notify.org/iss-now.json')
  res = Net::HTTP.get_response(uri)
  res_hash = JSON.parse(res.body)
 
  session.print "HTTP/1.1 200\r\n" # 1
  session.print "Content-Type: text/html\r\n" # 2
  session.print "\r\n" # 3
  session.print res_hash["iss_position"]
 
  session.close
end