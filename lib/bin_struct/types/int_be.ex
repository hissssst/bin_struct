defmodule BinStruct.Types.IntBe do

  @moduledoc """

  ## Variable bit size

    ```

      iex> defmodule Struct do
      ...>   use BinStruct
      ...>   field :value, :int_be, bits: 24
      ...> end
      ...>
      ...> Struct.new(value: -1)
      ...> |> Struct.dump_binary()
      ...> |> Struct.parse()
      ...> |> then(fn {:ok, struct, _rest } -> struct end)
      ...> |> Struct.decode()
      %{ value: -1 }

    ```

  """

end