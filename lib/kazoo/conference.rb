module Kazoo
  class Conference
    attr_reader :auth

    def initialize(auth)
      instance_variable_set :@auth, auth
    end

    def create_callflow(phone_numbers)
      base_uri = 'http://' + @auth.host + ":" + @auth.port + '/' + @auth.version + '/'
      auth_url = base_uri + 'accounts/' + @auth.account_id + '/callflows?auth_token=' + @auth.token
      payload = {'data' => {'numbers' => phone_numbers, 'flow' => {'module' => "conference", 'data' => {}, 'children' => {}}}}
      response = Nestful.json_put(auth_url, {:params => payload})
      p response['data']
      response
    end
  end
end
