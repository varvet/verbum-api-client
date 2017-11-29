# Verbum API client

A simple Ruby client for the Verbum API.

### Usage

All resources are queried in the same fashion. For instance, to fetch all psalms:

```ruby
psalms = Verbum::Api::Psalm.all
```

To fetch a single psalm:

```ruby
psalm = Verbum::Api::Psalm.find(1)
```

To fetch multiple psalms:

```ruby
psalms = Verbum::Api::Psalm.find([1,2,3]) # or
psalms = Verbum::Api::Psalm.find("1,2,3")
```

To fetch psalms with additional parameters:

```ruby
psalm = Verbum::Api::Psalm.all(q: "foobar", sort: "title")
```

To access data on a psalm:

```ruby
psalm = Verbum::Api::Psalm.find(1)
psalm.id
psalm.title
psalm.href
```

To access associated data on a psalm:

```ruby
psalm = Verbum::Api::Psalm.find(1)
psalm.verses
psalm.theme
```

This will trigger additional queries to the verse and theme resources.

Psalms have some additional helper methods:

```ruby
psalm = Verbum::Api::Psalm.find(1)
psalm.composers # fetches authorships of type composer
psalm.lyricists # fetches authorships of type lyricist
psalm.refrainists # fetches authorships of type refrainist (Omkväde)
```

### Request caching

Configure a ActiveSupport::Cache compatible store to cache requests.

```ruby
  Verbum::Api.cache = ActiveSupport::Cache.lookup_store(:memory_store)
```

If you're user Rails you can user Rails cache for connivance

```ruby
  Verbum::Api.cache = Rails.cache
```

To define cache expiry

```ruby
  Verbum::Api.cache_expires_in = 45.minutes
```

Optionally you can set an expiry padding, in order to no have
every resource time out at once.

```ruby
  Verbum::Api.cache_expiry_padding = 15.minutes
```

Using the two examples above, each cached request will expire randomly in
between 45 minutes and 1 hour.
