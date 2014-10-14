[![Build Status](https://travis-ci.org/yoolk/liquid-rails.svg?branch=master)](https://travis-ci.org/yoolk/liquid-rails)[![Coverage Status](https://coveralls.io/repos/yoolk/liquid-rails/badge.png?branch=master)](https://coveralls.io/r/yoolk/liquid-rails?branch=master)
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

## Authors

* [Chamnap Chhorn](https://github.com/chamnap)