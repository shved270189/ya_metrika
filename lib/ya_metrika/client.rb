require 'ya_metrika/settings'
require 'net/http'

module YaMetrika
  class Client
    HOST         = 'http://api-metrika.yandex.ru'
    REST_METHODS = [:get, :post, :put, :delete]

    def initialize(options = {})
      options      = YaMetrika::Settings.to_hash.merge(options)
      @format      = options[:format]
      @oauth_token = options[:oauth_token]

      @spells = Array.new
    end

    def method_missing(meth, *args, &block)
      if YaMetrika::Client::REST_METHODS.include?(meth.to_sym)
        rest(meth, *args, &block)
      else
        @spells << meth.to_s
        @spells << args.first.to_s if args.first
        self
      end
    end

    private

    def request_path(options)
      [@spells.inject('') { |r, spell| r + '/' + spell }, '.', @format.to_s, request_params(options)].join
    end

    def request_url(options)
      YaMetrika::Client::HOST + request_path(options)
    end

    def request_params(options)
      options.inject("?oauth_token=#{@oauth_token}") { |res, option| res + "&#{option.to_a.first.join('=')}" }
    end

    def rest(meth, *args, &block)
      url     = request_url(args)
      uri     = URI(url)
      @spells = Array.new

      request = case meth
                when :get
                  Net::HTTP::Get.new(uri)
                when :post
                  Net::HTTP::Post.new(uri)
                when :put
                  Net::HTTP::Put.new(uri)
                when :delete
                  Net::HTTP::Delete.new(uri)
                end

      result = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(request)
      end
      result
    end
  end
end
