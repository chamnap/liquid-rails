[![Build Status](https://travis-ci.org/yoolk/liquid-rails.svg?branch=master)](https://travis-ci.org/yoolk/liquid-rails)[![Coverage Status](https://coveralls.io/repos/yoolk/liquid-rails/badge.png?branch=master)](https://coveralls.io/r/yoolk/liquid-rails?branch=master)
# Liquid::Rails

Liquid support in Rails. It allows you to render `.liquid` templates with layout and partial support.

## Installation

Add this line to your application's Gemfile:

    gem 'liquid-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install liquid-rails

## Usage

In order to render with layout, in your layout file `app/views/layouts/application.liquid`, put this:

```ruby
{{ content_for_layout }}
```

```ruby
# It will render app/views/home/_partial.liquid when the current controller is `HomeController`.
{% include 'partial' %}

# It will render app/views/shared/_partial.liquid.
{% include 'shared/partial' %}
```

## Authors

* [Chamnap Chhorn](https://github.com/chamnap)
