module Kazoo
  class Conference
    attr_reader :auth

    def initialize(auth)
      instance_variable_set :@auth, auth
      @base_uri = 'http://' + @auth.host + ":" + @auth.port + '/' + @auth.version + '/' + 'accounts/' + @auth.account_id
    end

    def create_callflow(phone_numbers)
      callflow_url = @base_uri  + '/callflows?auth_token=' + @auth.token
      payload = {'data' => {'numbers' => phone_numbers, 'flow' => {'module' => "conference", 'data' => {}, 'children' => {}}}}
      Nestful.json_put(callflow_url, {:params => payload})
    end

    def create_room(name, conference_numbers)
      room_url = @base_uri + '/conferences?auth_token=' + @auth.token
      payload = {'data' => {'name' => name, 'conference_numbers' => conference_numbers}}
      Nestful.json_put(room_url, {:params => payload})
    end
  end
end
