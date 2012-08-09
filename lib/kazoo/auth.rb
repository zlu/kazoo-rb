require 'open-uri'

module Kazoo
  class Auth
    attr_reader :api_key, :host, :port, :version, :token, :account_id

    def initialize(kazoo_config)
      @api_key = kazoo_config['api_key']
      @host = kazoo_config['host']
      @port = kazoo_config['port']
      @version = kazoo_config['version']
      @account_id = kazoo_config['account_id']
      get_token
    end

    def get_token
      unless token
        base_uri = 'http://' + host + ":" + port + '/' + version + '/'
        auth_url = base_uri + 'api_auth'
        payload = {'data' => {'api_key' => api_key}}
        response = Nestful.json_put(auth_url, {:params => payload})
        @token = response['auth_token']
      end

      @token
    end
  end
end