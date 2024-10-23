defmodule BinStruct.Macro.TypeConverterToManaged do

  alias BinStruct.Macro.TypeConverters.FlagsTypeConverter
  alias BinStruct.Macro.TypeConverters.EnumTypeConverter
  alias BinStruct.Macro.TypeConverters.ListOfTypeConverter
  alias BinStruct.Macro.TypeConverters.StaticValueTypeConverter
  alias BinStruct.Macro.TypeConverters.VariantOfTypeConverter
  alias BinStruct.Macro.TypeConverters.ModuleTypeConverter

  #todo implement new primitive type conversion

  def convert_unmanaged_value_to_managed({:static_value, _value} = static_value_type, _quoted) do
    StaticValueTypeConverter.from_unmanaged_to_managed_static_value(static_value_type)
  end

  def convert_unmanaged_value_to_managed({:bool, %{ bit_size: bit_size }}, quoted) do

    quote do
      from_unmanaged_to_managed_bool(unquote(quoted), unquote(bit_size))
    end

  end


  def convert_unmanaged_value_to_managed({:uint, %{ bit_size: bit_size, endianness: endianness} }, quoted) do


    case endianness do
      :big ->
        quote do
          from_unmanaged_to_managed_uint_variable_bit_size_be(unquote(quoted), unquote(bit_size))
        end

      :little ->
        quote do
          from_unmanaged_to_managed_uint_variable_bit_size_little(unquote(quoted), unquote(bit_size))
        end

      :none ->
        quote do
          from_unmanaged_to_managed_uint_variable_bit_size_none(unquote(quoted), unquote(bit_size))
        end
    end

  end

  def convert_unmanaged_value_to_managed({:int, %{ bit_size: bit_size, endianness: endianness} }, quoted) do


    case endianness do
      :big ->
        quote do
          from_unmanaged_to_managed_int_variable_bit_size_be(unquote(quoted), unquote(bit_size))
        end

      :little ->
        quote do
          from_unmanaged_to_managed_int_variable_bit_size_little(unquote(quoted), unquote(bit_size))
        end

      :none ->
        quote do
          from_unmanaged_to_managed_int_variable_bit_size_none(unquote(quoted), unquote(bit_size))
        end
    end

  end

  def convert_unmanaged_value_to_managed(:uint8, quoted) do

    quote do
      from_unmanaged_to_managed_uint8(unquote(quoted))
    end

  end

  def convert_unmanaged_value_to_managed(:int8, quoted) do

    quote do
      from_unmanaged_to_managed_int8(unquote(quoted))
    end

  end

  def convert_unmanaged_value_to_managed(:uint16_be, quoted) do

    quote do
      from_unmanaged_to_managed_uint16_be(unquote(quoted))
    end

  end

  def convert_unmanaged_value_to_managed(:uint32_be, quoted) do

    quote do
      from_unmanaged_to_managed_uint32_be(unquote(quoted))
    end

  end

  def convert_unmanaged_value_to_managed(:uint64_be, quoted) do

    quote do
      from_unmanaged_to_managed_uint64_be(unquote(quoted))
    end

  end


  def convert_unmanaged_value_to_managed(:int16_be, quoted) do

    quote do
      from_unmanaged_to_managed_int16_be(unquote(quoted))
    end

  end

  def convert_unmanaged_value_to_managed(:int32_be, quoted) do

    quote do
      from_unmanaged_to_managed_int32_be(unquote(quoted))
    end

  end

  def convert_unmanaged_value_to_managed(:int64_be, quoted) do

    quote do
      from_unmanaged_to_managed_int64_be(unquote(quoted))
    end

  end

  def convert_unmanaged_value_to_managed(:float32_be, quoted) do

    quote do
      from_unmanaged_to_managed_float32_be(unquote(quoted))
    end

  end

  def convert_unmanaged_value_to_managed(:float64_be, quoted) do

    quote do
      from_unmanaged_to_managed_float64_be(unquote(quoted))
    end

  end


  def convert_unmanaged_value_to_managed(:uint16_le, quoted) do

    quote do
      from_unmanaged_to_managed_uint16_le(unquote(quoted))
    end

  end

  def convert_unmanaged_value_to_managed(:uint32_le, quoted) do

    quote do
      from_unmanaged_to_managed_uint32_le(unquote(quoted))
    end

  end

  def convert_unmanaged_value_to_managed(:uint64_le, quoted) do

    quote do
      from_unmanaged_to_managed_uint64_le(unquote(quoted))
    end

  end

  def convert_unmanaged_value_to_managed(:int16_le, quoted) do

    quote do
      from_unmanaged_to_managed_int16_le(unquote(quoted))
    end

  end

  def convert_unmanaged_value_to_managed(:int32_le, quoted) do

    quote do
      from_unmanaged_to_managed_int32_le(unquote(quoted))
    end

  end

  def convert_unmanaged_value_to_managed(:int64_le, quoted) do

    quote do
      from_unmanaged_to_managed_int64_le(unquote(quoted))
    end

  end

  def convert_unmanaged_value_to_managed(:float32_le, quoted) do

    quote do
      from_unmanaged_to_managed_float32_le(unquote(quoted))
    end

  end

  def convert_unmanaged_value_to_managed(:float64_le, quoted) do

    quote do
      from_unmanaged_to_managed_float64_le(unquote(quoted))
    end

  end

  def convert_unmanaged_value_to_managed(:binary, quoted), do: quoted

  def convert_unmanaged_value_to_managed({:module, _module_info} = module_type, quoted) do
    ModuleTypeConverter.from_unmanaged_to_managed_module(module_type, quoted)
  end

  def convert_unmanaged_value_to_managed({:flags, %{} = _flags_info} = flags_type, quoted) do
    FlagsTypeConverter.from_unmanaged_to_managed_flags(flags_type, quoted)
  end

  def convert_unmanaged_value_to_managed({:enum, %{} = _enum_info} = enum_type, quoted) do
    EnumTypeConverter.from_unmanaged_to_managed_enum(enum_type, quoted)
  end

  def convert_unmanaged_value_to_managed({:variant_of, _variants} = variant_of_type, quoted) do
    VariantOfTypeConverter.from_unmanaged_to_managed_variant_of(variant_of_type, quoted)
  end

  def convert_unmanaged_value_to_managed({:list_of, _list_of_info} = list_of_type , quoted) do
    ListOfTypeConverter.from_unmanaged_to_managed_list_of(list_of_type, quoted)
  end

  def convert_unmanaged_value_to_managed(:unspecified, quoted), do: quoted

end