require File.dirname(__FILE__) + '/../spec_helper'

describe "An Array node" do
  relates '[1, :b, "c"]' do
    parse do
      [:array, [:lit, 1], [:lit, :b], [:str, "c"]]
    end

    compile do |g|
      g.push 1
      g.push_unique_literal :b
      g.push_literal "c"
      g.string_dup
      g.make_array 3
    end
  end

  relates "%w[a b c]" do
    parse do
      [:array, [:str, "a"], [:str, "b"], [:str, "c"]]
    end

    compile do |g|
      g.push_literal "a"
      g.string_dup
      g.push_literal "b"
      g.string_dup
      g.push_literal "c"
      g.string_dup
      g.make_array 3
    end
  end

  relates '%w[a #{@b} c]' do
    parse do
      [:array, [:str, "a"], [:str, "\#{@b}"], [:str, "c"]]
    end

    compile do |g|
      g.push_literal "a"
      g.string_dup

      g.push_literal "\#{@b}"
      g.string_dup

      g.push_literal "c"
      g.string_dup
      g.make_array 3
    end
  end

  relates "%W[a b c]" do
    parse do
      [:array,
        [:str, "a"], [:str, "b"], [:str, "c"]]
    end

    compile do |g|
      g.push_literal "a"
      g.string_dup
      g.push_literal "b"
      g.string_dup
      g.push_literal "c"
      g.string_dup
      g.make_array 3
    end
  end

  relates '%W[a #{@b} c]' do
    parse do
      [:array,
        [:str, "a"],
        [:dstr, "", [:evstr, [:ivar, :@b]]],
        [:str, "c"]]
    end

    compile do |g|
      g.push_literal "a"
      g.string_dup

      g.push_ivar :@b
      g.send :to_s, 0, true
      g.push_literal ""
      g.string_dup
      g.string_append

      g.push_literal "c"
      g.string_dup
      g.make_array 3
    end
  end

  relates "[*[1]]" do
    parse do
      [:array, [:splat, [:array, [:lit, 1]]]]
    end

    compile do |g|
      g.array_of_splatted_array
    end
  end

  relates "[*1]" do
    parse do
      [:array, [:splat, [:lit, 1]]]
    end

    compile do |g|
      g.make_array 0
      g.push 1
      g.cast_array
      g.send :+, 1
    end
  end

  relates "[[*1]]" do
    parse do
      [:array, [:array, [:splat, [:lit, 1]]]]
    end

    compile do |g|
      g.make_array 0
      g.push 1
      g.cast_array
      g.send :+, 1
      g.make_array 1
    end
  end

  relates "[1, *2]" do
    parse do
      [:array, [:lit, 1], [:splat, [:lit, 2]]]
    end

    compile do |g|
      g.push 1
      g.make_array 1

      g.push 2
      g.cast_array

      g.send :+, 1
    end
  end

  relates "[1, *c()]" do
    parse do
      [:array, [:lit, 1], [:splat, [:call, nil, :c, [:arglist]]]]
    end

    # TODO
  end

  relates <<-ruby do
      x = [2]
      [1, *x]
    ruby

    parse do
      [:block,
       [:lasgn, :x, [:array, [:lit, 2]]],
       [:array, [:lit, 1], [:splat, [:lvar, :x]]]]
    end

    # TODO
  end
end
