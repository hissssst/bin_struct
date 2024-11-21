defmodule BinStruct.Types.Float32Be do

  @moduledoc """

    ```

      iex> defmodule Struct do
      ...>   use BinStruct
      ...>   field :value, :float32_be
      ...> end
      ...>
      ...> Struct.new(value: 1.0)
      ...> |> Struct.dump_binary()
      ...> |> Struct.parse()
      ...> |> then(fn {:ok, struct, _rest } -> struct end)
      ...> |> Struct.decode()
      %{ value: 1.0 }

    ```

  """

end