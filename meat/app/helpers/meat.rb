require 'net/http'
require 'json'

module MeatHelper
    def push_meat(endpoint, body)
        url = Setting.plugin_meat_url['url']
        if not url.length
            return false
        end

        url += endpoint
        uri = URI(url)

        req = Net::HTTP::Post.new(endpoint, initheader ={ 'Content-Type' => 'application/json' })
        req.body = body.to_json
        response = Net::HTTP.new(uri.host, uri.port).start do |http|
            http.request(req)
        end

        return true
    end
end