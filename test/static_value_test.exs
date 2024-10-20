defmodule BinStructTest.StaticValueTest do

  use ExUnit.Case

  defmodule BinStructWithStaticValue do


    use BinStruct

    @val <<3, 2, 1>>

    field :static_value_binary, <<1, 2, 3>>
    field :static_value_string, "123"
    field :static_value_ext, { :static, @val }
    field :static_value_ext2, { :static, BinStructStaticValue.uint32_be(1) }

  end


  test "struct with binary values works" do

    struct = BinStructWithStaticValue.new()

    dump = BinStructWithStaticValue.dump_binary(struct)

    { :ok, parsed_struct } = BinStructWithStaticValue.parse_exact(dump)

    values = BinStructWithStaticValue.decode(parsed_struct)

    %{
      static_value_binary: <<1, 2, 3>>,
      static_value_string: "123",
      static_value_ext: <<3, 2, 1>>,
      static_value_ext2: <<0, 0, 0, 1>>
    } = values

  end

end
