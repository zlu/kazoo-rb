module Nestful
  class ConnectionError
    attr_reader :response

    def initialize(response, message = nil)
      @body = response.body if response.respond_to?(:body)
      @response = response
      @message  = message
    end

    def to_s
      message = "Failed."
      message << "  Response code = #{response.code}." if response.respond_to?(:code)
      message << "  Response message = #{response.message}." if response.respond_to?(:message)
      message << "  Response data = #{JSON.parse(@body)['data']}"
      message
    end
  end
end