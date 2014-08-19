[![Build Status](https://travis-ci.org/yoolk/liquid_view.svg?branch=master)](https://travis-ci.org/yoolk/liquid_view)[![Coverage Status](https://coveralls.io/repos/yoolk/liquid_view/badge.png?branch=master)](https://coveralls.io/r/yoolk/liquid_view?branch=master)
# LiquidView

It allows you to render `.liquid` templates with layout and partial support.

## Installation

Add this line to your application's Gemfile:

    gem 'liquid_view'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install liquid_view

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

## Authors

* [Chamnap Chhorn](https://github.com/chamnap)
