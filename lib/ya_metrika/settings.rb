module YaMetrika
  class Settings
    @config = {
        format: :json,
        oauth_token: nil
    }

    class << self
      def [](key)
        @config[key.to_sym]
      end

      def []=(key, value)
        @config[key.to_sym] = value
      end

      def to_hash
        @config
      end
    end
  end
end
