defmodule BinStruct.Macro.IsArbitraryType do

  alias BinStruct.Macro.FieldSize

  def is_arbitrary_type(type) do

    case type do
      {:module, _module_info} -> false
      {:variant_of, _module_info} -> false
      {:list_of, _module_info} -> false
      {:asn1, _asn1_info} -> false

      type ->

        bits_size = FieldSize.type_size_bits(type, [])

        case bits_size do

          :unknown -> true

          bits_size when is_integer(bits_size) ->

            case Integer.mod(bits_size, 8) do
              0 -> true
              _ -> false
            end

          _ -> false
        end

    end

  end


end