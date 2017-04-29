#
require 'base64'
require 'json'
# require 'net/https'
# require 'uri'
require 'net/http'



# This method example shows how to get a token manually, but you may prefer to
# get a token using the oath2 gem. At the command line, type:
# $ gem install oauth2

module GetAccessToken
  def self.request_token(api_credentials)

    #username = api_credentials['username']
    #password = api_credentials['password']
    app_secret = api_credentials['app_secret']
    app_name = api_credentials['app_name']
    vendor_name = api_credentials['vendor_name']
    #bus_num = api_credentials['bus_num']
    scope = api_credentials['scope']

    # Create a base-64 encoded authorization token.
    # encoded_auth_token = Base64.encode64(app_name + '@' + vendor_name + ':' + bus_num)

    encoded_auth_token = Base64.encode64(app_name + '@' + vendor_name + ':' + app_secret)

    # Specify the token service URL.
    endpoint_uri = URI('https://api.incontact.com/InContactAuthorizationServer/Token')

    # Create the post data.
    # post_data = '{"grant_type": "password","username":"' + username + '","password":"' + password + '","scope":"' + scope + '"}'
    post_data = '{"grant_type": "client_credentials","scope": "' + scope + '"}'

    # Create the POST request headers.
    headers = {
      'Content-Type' => 'application/json; charset=UTF-8',
      'Authorization' => "basic #{encoded_auth_token}",
      'Accept' => 'application/json',
      # "Accept-Encoding" => "gzip, deflate, sdch, br",
      'Accept-Encoding' => 'none',
      'Connection' => 'keep-alive'
    }



#proxy_addr = 'asqproxy.vzbi.com'
#proxy_port = 80

#Net::HTTP.new('example.com', nil, proxy_addr, proxy_port).start { |http| }

    # Initialize the request with endpoint (i.e. the URL).
    request = Net::HTTP.new(endpoint_uri.host, endpoint_uri.port)




    # Make the POST request an HTTPS POST request.
    request.use_ssl = true

    # Delete this line and be sure you have a valid certificate.
    # The default Ruby library, net/https, doesn't check the validity of a
    # certificate during a handshake. Using VERIFY_NONE is a simple, and insecure,
    # hack to get around this limitation.
    request.verify_mode = OpenSSL::SSL::VERIFY_NONE

    # Make the request and store the response.
    response_json_string = request.post(endpoint_uri.path, post_data, headers)

    # The response body is in JSON, so parse it into a Ruby data structure.
    client_access_token_obj = JSON.parse(response_json_string.body)

    client_access_token_obj
  end
end
