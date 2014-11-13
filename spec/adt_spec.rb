require 'rspec'
require 'adt'

Shape = ADT do
  Void() |
  Square(width: Fixnum) |
  Rectangle(width: Numeric, height: Numeric) |
  Circle(radius: Fixnum) {
    def area
      Math::PI * radius * radius
    end
  }
end

describe ADT do
  it 'allows for a nullary constructor' do
    expect(Shape::Void()).to be_kind_of(Shape::Void)
  end

  it 'typechecks the non-nullary constructors'do
    expect { Shape::Square(23) }.to_not raise_exception
    expect { Shape::Square("foo") }.to raise_exception(TypeError)
  end

  it 'allows inherited types' do
    expect { Shape::Rectangle(23, 45.1) }.to_not raise_exception
    expect { Shape::Rectangle("foo", "bar") }.to raise_exception(TypeError)
  end

  it 'implements equality by type and value' do
    expect(Shape::Square(23)).to eq(Shape::Square(23))
    expect(Shape::Circle(23)).to_not eq(Shape::Square(23))
    expect(Shape::Square(23)).to_not eq(Shape::Square(55))
  end

  it 'exposes readers for the constructor parameters' do
    expect(Shape::Square(23).width).to eq(23)
  end

  it 'allows for custom methods on type constructors' do
    expect(Shape::Circle(1).area).to eq(Math::PI)
  end

  it 'uses subtyping' do
    expect(Shape::Circle(1)).to be_kind_of(Shape)
  end
end