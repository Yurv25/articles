defmodule ArticlesTest do
  use ExUnit.Case
  doctest Articles

  test "greets the world" do
    assert Articles.hello() == :world
  end
end
