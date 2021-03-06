require 'json'

module SmsAero2
  class Request
    class HttpError < SmsAero2::Error
      attr_accessor :status
    end
    class InvalidResponse < SmsAero2::Error; end

    attr_reader :client, :logger

    def initialize(client)
      @client = client
      @logger = client.logger
    end

    def call(url, **params)
      uri = URI(url)
      uri.query = URI.encode_www_form(params)

      response = send_request(uri)
      logger&.info(
          "Send http request to GET #{url} with params: #{params}"
      )
      response_body(response)

    rescue SmsAero2::Error => e
      logger&.error("http request to #{url} with params: #{params} is failed message: #{e.message}")
      raise e
    end

    private

    def send_request(uri)
      request = Net::HTTP::Get.new(uri)
      request.basic_auth(client.login, client.token)
      request['Content-Type'] = 'application/json'
      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request(request)
      end
    end

    def response_body(response)
      body = response.read_body
      if response.code.to_s.match?(/2|4[0-9]{2}/)
        JSON.parse(body)
      else
        error = HttpError.new("server return error code: #{response.code} response: #{body}")
        error.status = response.code
        raise error
      end
    rescue JSON::ParserError
      raise InvalidResponse, "server return invalid response: #{body}"
    end
  end
end
