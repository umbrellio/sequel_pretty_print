# sequel_pretty_print   [![Gem Version](https://badge.fury.io/rb/sequel_pretty_print.svg)](https://badge.fury.io/rb/sequel_pretty_print) ![Build Status](https://github.com/umbrellio/sequel_pretty_print/actions/workflows/ci.yml/badge.svg) [![Coverage Status](https://coveralls.io/repos/github/umbrellio/sequel_pretty_print/badge.svg?branch=master)](https://coveralls.io/github/umbrellio/sequel_pretty_print?branch=master)

## Installation
Just add `gem "sequel_pretty_print"` to your Gemfile.

## Usage

```ruby
# Make all model subclasses use pretty_print (called before loading subclasses)
Sequel::Model.plugin :pretty_print

# Make the Artist class use pretty_print
Artist.plugin :pretty_print
```

The pretty_print plugin provides models with a `pretty_print` implementation (see [Ruby PrettyPrint module](http://ruby-doc.org/stdlib/libdoc/prettyprint/rdoc/PrettyPrint.html)) that can be used by tools like Pry. Assuming that we have class `Album` with columns `id` and `name` this provides the following functionality in Pry:

```ruby
# Before:
Artist.new
# => #<Artist @values={}>

# After:
Artist.new
# => #<Artist:0x00007f8d1967f8b0 id: nil, name: nil>
Artist.new(name: "Elvis")
# => #<Artist:0x00007f8d1b413ef8 id: nil, name: "Elvis">
```

For unsaved model instances, all column values are rendered. For retrieved instances, only the ones that were selected are shown. If there are some extra values (that are not represented in model columns) they are rendered after column values.

The display format is borrowed from ActiveRecord because I find it convenient.

## License
Released under MIT License.

## Authors
Created by Yuri Smirnov.

<a href="https://github.com/umbrellio/">
<img style="float: left;" src="https://umbrellio.github.io/Umbrellio/supported_by_umbrellio.svg" alt="Supported by Umbrellio" width="439" height="72">
</a>
