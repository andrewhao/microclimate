[![Code
Climate](https://codeclimate.com/github/andrewhao/microclimate.png)](https://codeclimate.com/github/andrewhao/microclimate)
[![Build
Status](https://travis-ci.org/andrewhao/microclimate.svg)](https://travis-ci.org/andrewhao/microclimate)

# Microclimate

A Ruby wrapper to the [Code Climate
API](https://codeclimate.com/docs/api). Note that it, as documented, is
"at the moment, extremely rudimentary, unsupported, and subject to
change."

## Installation

Add this line to your application's Gemfile:

    gem 'microclimate'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install microclimate

## Usage

### Initializing the client & connecting to the repo.

```ruby
client = Microclimate::Client.new :api_token =>
"321786539ec44cb4ae96b86e09209828416542fe"
repo = client.repository_for "533329e76956801171001e7e" # #<Microclimate::Repository:0x007f9764730548
```

### Updating the repository

```ruby
repo.refresh!
```

### Getting the GPA

```ruby
repo.id # => "533329e76956801171001e7e"
repo.last_snapshot # => {"gpa" => 2.31}
repo.previous_snapshot # => {"gpa" => 2.25}
```

### Branches

```ruby
repo.branch_for("my_test_branch").last_snapshot # => {"gpa" => 2.40}
repo.branch_for("master").last_snapshot # => {"gpa" => 2.25}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
