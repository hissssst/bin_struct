defmodule BinStruct.BuiltIn.TerminatedBinary do

  use BinStructCustomType

  def init_args(custom_type_args) do

    args = %{
      termination: custom_type_args[:termination]
    }

    case args do
      %{ termination: termination } when is_binary(termination) -> { :ok, args }
      _ -> { :error, "Termination argument required by not provided" }
    end

  end

  def parse_returning_options(bin, custom_type_args, opts) do

    %{
      termination: termination
    } = custom_type_args

    case parse_dynamic_terminated(bin, termination) do

      { :ok, parsed, rest } -> { :ok, parsed, rest, opts  }
      :not_enough_bytes -> :not_enough_bytes
    end

  end

  def size(data, custom_type_args) do

    %{
      termination: termination
    } = custom_type_args

    byte_size(data) + byte_size(termination)

  end

  def dump_binary(data, custom_type_args) do

    %{
      termination: termination
    } = custom_type_args

    <<data::binary, termination::binary>>

  end


  def known_total_size_bytes(_custom_type_args) do
    :unknown
  end

  def to_managed(unmanaged, _custom_type_args), do: unmanaged
  def to_unmanaged(managed, _custom_type_args), do: managed

  defp parse_dynamic_terminated(bin, termination, acc \\ <<>>)

  defp parse_dynamic_terminated(bin, termination, acc) do

    term_size = byte_size(termination)

    case bin do

      <<term::binary-size(^term_size), rest::binary>> when term == termination -> {:ok, acc, rest}

      <<byte::binary-size(1), rest::binary>> ->
        parse_dynamic_terminated(rest, termination, <<acc::binary, byte::binary>>)

      _ -> :not_enough_bytes

    end

  end
end