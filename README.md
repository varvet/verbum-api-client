# Verbum API

A simple Ruby client for the Verbum API.

## Usage

To fetch all psalms:

```ruby
psalms = Verbum::Api::Psalm.all
```

To fetch a single psalm:

```ruby
psalm = Verbum::Api::Psalm.find(1)
```

To access data on a psalm:

```ruby
psalm = Verbum::Api::Psalm.find(1)
psalm.id
psalm.title
psalm.href
psalm.verses # Triggers a request to the verse resource
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/verbum-api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
