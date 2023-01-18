# frozen_string_literal: true

module Rest
  class RestController
    # this controller is used to serve the generic REST API METHODS
    # other controllers can inherit from this one to get the basic REST methods
    # for example, the TwitterClient inherits from this class

    # the following methods are available to the inheriting classes
    # get(path)
    # post(path, body)
    # put(path, body)
    # delete(path)
    # request(method, path, body)
    # headers

    def get(path)
      request(:get, path)
    end

    def post(path, body)
      request(:post, path, body)
    end

    def put(path, body)
      request(:put, path, body)
    end

    def delete(path)
      request(:delete, path)
    end

    def request(method, path, body: {})
      params = {
        method:,
        url: "#{set_base_url}#{path}",
        payload: body,
        headers:
      }

      if %i[put post].include?(method)
        params[:payload] = body.to_json
        params[:headers][:content_type] = 'application/json'
      end

      begin
        response = RestClient::Request.execute(params)
        JSON.parse(response.body, symbolize_names: true)
      rescue StandardError => e
        Rails.logger.error e
        JSON.parse(e.response.body, symbolize_names: true)
      end
    end

    # this method needs to be overriden in the inheriting class
    def set_base_url
      raise NotImplementedError, 'You need to override this method in the inheriting class'
    end

    # this method needs to be overriden in the inheriting class
    def headers
      raise NotImplementedError, 'You need to override this method in the inheriting class'
    end
  end
end
