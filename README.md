# Verbum API client

[![Codeship Status for varvet/verbum-api-client](http://img.shields.io/codeship/8f6cdbb0-40e6-0132-61d2-361b888cab07.svg)](https://codeship.io/projects/44012)
![Coverage](http://varvet-badger.herokuapp.com/badges/varvet-verbum-api-client/coverage)

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
