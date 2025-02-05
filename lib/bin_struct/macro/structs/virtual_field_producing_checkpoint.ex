defmodule BinStruct.Macro.Structs.VirtualFieldProducingCheckpoint do

  @moduledoc false

  alias BinStruct.Macro.Structs.VirtualFieldProducingCheckpoint
  alias BinStruct.Macro.Structs.VirtualField

  @type t :: %VirtualFieldProducingCheckpoint {
               virtual_fields: list(
                 VirtualField.t()
               )
             }

  defstruct [
    :virtual_fields
  ]

end
