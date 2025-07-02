require "net/http"
require "uri"
require "json"

uri = URI("http://localhost:5000/api/v1/manga/One%20Piece")
req = Net::HTTP::Get.new(uri)
# req["Authorization"] = "Bearer #{your_token}"

res = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }

puts res.body
