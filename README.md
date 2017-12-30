[![Build Status](https://travis-ci.org/chamnap/liquid-rails.svg?branch=master)](https://travis-ci.org/yoolk/liquid-rails)[![Coverage Status](https://coveralls.io/repos/yoolk/liquid-rails/badge.png?branch=master)](https://coveralls.io/r/yoolk/liquid-rails?branch=master)[![Gem Version](https://badge.fury.io/rb/liquid-rails.svg)](http://badge.fury.io/rb/liquid-rails)
# Liquid-Rails

It allows you to render `.liquid` templates with layout and partial support. It also provides filters, tags, drops class to be used inside your liquid template.

## Installation

Add this line to your application's Gemfile:

    gem 'liquid-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install liquid-rails

## Usage

In order to render with layout, in your layout file `app/views/layouts/application.liquid`, put this:

```html
{{ content_for_layout }}
```

```html
# It will render app/views/home/_partial.liquid when the current controller is `HomeController`.
{% include 'partial' %}

# It will render app/views/shared/_partial.liquid.
{% include 'shared/partial' %}
```

### Template Rendering

By default, **Liquid-Rails** makes all instance variables from controller available to liquid template. To limit only some instance variables, do this inside your controller:

```ruby
def liquid_assigns
  { 'listing' => current_listing, 'content_for_header' => content_for_header, 'current_account' => current_account }
end
```

By default, **Liquid-Rails** makes all your helper methods inside your rails app available to liquid template. To limit only some helpers, do this inside your controller:

```ruby
def liquid_filters
  []
end
```

You can render liquid templates from other template engines, eg. `erb`, `haml`, ...

```ruby
= render 'shared/partial.liquid'
```

### Filter

> Filters are simple methods that modify the output of numbers, strings, variables and objects. They are placed within an output tag `{{` `}}` and are separated with a pipe character `|`.

Currently, **Liquid-Rails** adds only the followings:

1. [AssetTagFilter](https://github.com/yoolk/liquid-rails/blob/master/lib/liquid-rails/filters/asset_tag_filter.rb)
2. [AssetUrlFilter](https://github.com/yoolk/liquid-rails/blob/master/lib/liquid-rails/filters/asset_url_filter.rb)
3. [DateFilter](https://github.com/yoolk/liquid-rails/blob/master/lib/liquid-rails/filters/date_filter.rb)
4. [NumberFilter](https://github.com/yoolk/liquid-rails/blob/master/lib/liquid-rails/filters/number_filter.rb)
5. [SanitizeFilter](https://github.com/yoolk/liquid-rails/blob/master/lib/liquid-rails/filters/sanitize_filter.rb)
6. [TextFilter](https://github.com/yoolk/liquid-rails/blob/master/lib/liquid-rails/filters/text_filter.rb)
7. [TranslateFilter](https://github.com/yoolk/liquid-rails/blob/master/lib/liquid-rails/filters/translate_filter.rb)
8. [UrlFilter](https://github.com/yoolk/liquid-rails/blob/master/lib/liquid-rails/filters/url_filter.rb)
9. [MiscFilter](https://github.com/yoolk/liquid-rails/blob/master/lib/liquid-rails/filters/misc_filter.rb)

### Tag

> Liquid tags are the programming logic that tells templates what to do. Tags are wrapped in: `{%` `%}`.

Currently, **Liquid-Rails** adds only the followings:

1. [csrf_meta_tags](https://github.com/yoolk/liquid-rails/blob/master/lib/liquid-rails/tags/csrf_meta_tags.rb)
2. [google_analytics_tag](https://github.com/yoolk/liquid-rails/blob/master/lib/liquid-rails/tags/google_analytics_tag.rb)
3. [javascript_tag](https://github.com/yoolk/liquid-rails/blob/master/lib/liquid-rails/tags/javascript_tag.rb)
4. [paginate](https://github.com/yoolk/liquid-rails/blob/master/lib/liquid-rails/tags/paginate_tag.rb)
4. [content_for](https://github.com/yoolk/liquid-rails/blob/master/lib/liquid-rails/tags/content_for.rb)

### Drop Class

> Drops let you provide the user with custom functionality. They are very much like a standard Ruby class, but have all unused and potentially dangerous methods removed. From the user's perspective a drop acts very much like a Hash, though methods are accessed with dot-notation as well as element selection. A drop method cannot be invoked with arguments. Drops are called just-in-time, thus allowing you to lazily load objects.

Given two models, a Post(title: string, body: text) and a Comment(name:string, body:text, post_id:integer), you will have two drops:

```ruby
class PostDrop < Liquid::Rails::Drop
  attributes :id, :title, :body

  has_many :comments
end
```

and

```ruby
class CommentDrop < Liquid::Rails::Drop
  attributes :id, :name, :body

  belongs_to :post
end
```

Check out more [examples](https://github.com/yoolk/liquid-rails/blob/master/spec/fixtures/poro.rb).

It works for any ORMs. The PORO should include `Liquid::Rails::Droppable`. That's all you need to do to have your POROs supported.

### RSpec

In spec_helper.rb, you'll need to require the matchers:

```ruby
require 'liquid-rails/matchers'
```

Example:

```ruby
describe PostDrop do
  it { should have_attribute(:id) }
  it { should have_attribute(:title) }
  it { should have_attribute(:body) }
  it { should have_many(:comments) }
end
```

```ruby
describe CommentDrop do
  it { should have_attribute(:id) }
  it { should have_attribute(:name) }
  it { should have_attribute(:body) }
  it { should belongs_to(:post) }
end
```

## Contributors

* [Radin Reth](https://github.com/radin-reth/)

## Authors

* [Chamnap Chhorn](https://github.com/chamnap)
