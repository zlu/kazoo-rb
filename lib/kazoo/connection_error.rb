class ConnectionError < Nestful::ConnectionError
  def to_s
    p 'herereeeeeeeee+++++++'
    response['data'] ? "#{super} => #{response['data']}" : super
    #if response.body
    #  message << "  Response data = #{JSON.parse(response.body)['data']}."
    #end
  end
end