# ADTs [![Build Status](https://secure.travis-ci.org/txus/adts.png)](http://travis-ci.org/txus/adts)

[Algebraic Data Types][adts] for Ruby.

## Usage

Let's define a Shape data type:

```ruby
require 'adts'

Shape = ADT do
  Void() |
  Square(width: Fixnum) |
  Rectangle(width: Fixnum, height: Fixnum) |
  Circle(radius: Fixnum) {
    def area
      Math::PI * radius * radius
    end
  }
end
```

Let's try an instantiate a Shape with our nullary constructor Void:

```ruby
Shape::Void()
# => #<Shape::Void ...>
```

What about a square?

```ruby
Shape::Square(23)
# => #<Shape::Square @width=23>
```

Our type constructors are even **type-checked**:

```ruby
Shape::Square("foo")
# raises a TypeError
```

Our ADT implements equality by type and value:

```ruby
Shape::Square(23) == Shape::Square(23)
# => true
Shape::Circle(23) == Shape::Square(23)
# => false
Shape::Square(23) == Shape::Square(99)
# => false
```

All its instances expose (read-only) their respective parameters:

```ruby
Shape::Square(23).width
# => 23
```

All instances are a kind of `Shape`:

```ruby
Shape::Square(23).is_a?(Shape)
# => true
```

And finally, our constructors can have their own special methods, just like we
defined `area` on `Circle`:

```ruby
Shape::Circle(1).area
# => 3.141592653589793
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'adts'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install adts

## Who's this

This was made by [Josep M. Bach (Txus)](http://blog.txus.io) under the MIT
license. I am [@txustice][twitter] on twitter (where you should probably follow
me!).

[twitter]: https://twitter.com/txustice
[adts]: http://en.wikipedia.org/wiki/Algebraic_data_type

