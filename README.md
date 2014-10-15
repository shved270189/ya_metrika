# YaMetrika

Ruby gem for [API Yandex Metrika](https://api.yandex.ru/metrika/)

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'ya_metrika'
```
And then execute:
```console
$ bundle
```
Or install it yourself as:
```console
$ gem install ya_metrika
```

## Usage
```ruby
require 'ya_metrika'

# Set config params or set its as a hash of options in constructor of YaMetrika::Client
# YaMetrika::Client.new(oauth_token: '05dd3dd84ff948fdae2bc4fb91f13e22')
# Default format is json
YaMetrika::Settings[:format] = :json # or :xml
YaMetrika::Settings[:oauth_token] = '05dd3dd84ff948fdae2bc4fb91f13e22'

client = YaMetrika::Client.new

response = client.counter(2215573).goal(334423).get

response = client.stat.traffic.summary.get(id: 2138128)

# OR
client.stat
client.traffic
client.summary
response = client.get(id: 2138128)
```

## Contributing

1. Fork it ( https://github.com/shved270189/ya_metrika )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
