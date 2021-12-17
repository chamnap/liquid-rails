# Overview

## Unreleased

### New Features
* Added support for Rails v6.0, v6.1 and v7.0
* Migrated to Liquid 5

### Breaking changes
* Dropped support for Rails v5.*

## 0.2.0

### Resolved Issues

* Fix `Content-Type` issue
* Support from Liquid v4, Rails v5, and Kaminari v1 and up
* Use `ActionView::Resolver` as Liquid filesystem (lowang, streppa-ent)

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
