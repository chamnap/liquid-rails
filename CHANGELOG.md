# Overview

## 0.1.4

### Resolved Issues

* Fix Filter overrides registered public methods as non public: h
* Support Liquid v3.0.6, Rails belows 5, and Kaminari below v1.0.0

## 0.1.2

### New Features

* Use google analytics universal (Chamnap Chhorn)

* Render liquid template as html_safe by default (Dan Kubb)

## 0.1.1

### New Features

* Add `bootstrap_pagination` filter. (Radin Reth)

* Allow `translate` filter with interpolation. (Tomasz Stachewicz, Chamnap Chhorn)

* Support `rails` 4.2 and `ruby` 2.2. (Chamnap Chhorn)

* Support `scope` on collection drop. (Radin Reth)


### Resolved Issues

* Add `rel="prev"` and `rel="next"` to `default_pagination` filter. (Radin Reth)

* Fix `content_for` and `yield` tag on `rails` 3.2. (Chamnap Chhorn)

* \#4 Makes partial template work in namespaced controller. (Tomasz Stachewicz)

* `truncate` filter now forwards to the standard filters. (Radin Reth)

## 0.1.0

* Initial Release
