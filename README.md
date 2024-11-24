# BinStruct

**BinStruct** is a library that provides a rich set of tools for parsing and encoding binaries.

The goal is to write declarations that are **readable now and will remain readable for years**. Your code will closely resemble a page from protocol documentation, ensuring clarity and maintainability.

This library is particularly beneficial for use cases that require **bidirectional data flow**.

## What BinStruct is not

BinStruct is by no means a framework and does not force you to follow any specific structure.  
Each BinStruct you create is completely self-contained and can be used as you see fit. Whether you want to validate CRC, add encryption, or implement something else inside or outside—it’s entirely up to you, and the library imposes no restrictions on these choices.

## What BinStruct is primarily

I believe BinStruct is an essential tool for developers. Simply transferring declarations from your protocol documentation into BinStruct special syntax is enough to start parsing your data, decoding it, and exploring its structure. This lets you build an understanding of how to proceed next.
It is especially helpful when working with a protocol that is new to you. If you’re unsure where to start or what to focus on, just transfer what you see in the documentation into BinStruct declarations and experiment. At some point, things will start falling into place, and you might even find that the application almost writes itself before you realize it.
Even the smallest fragments you implement can already be put to use. You can parse and decode binary data to gain a better understanding of what you're dealing with without needing to fully implement every detail or dynamic callback. You'll gradually build out your protocol implementation step by step, and over time, these pieces will naturally connect as your codebase grows.
You don’t need all the advanced features like virtual fields, auto-generated fields (builders), or type conversions beyond the basic managed (human-readable) one right away. You can always add them later if you think they’ll make the process easier.

## Installation

To get started, add `BinStruct` to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:bin_struct, "~> 0.2"}
  ]
end
```

---

## Basic syntax overview

  ```elixir
  
  defmodule PngChunk do
  
    use BinStruct
  
    #all dynamic behaviour is callback
    #if we are not specifying type_conversion this is always 'managed' also known as 'human readable'
    register_callback &data_length/1, length: :field
  
    #with fields you build shape of your binary data
    field :length, :uint32_be
  
    #use expanded constructs whenever possible, this is both easier to read and will be validated at parse time
    #which will give you opportunity to be dispatched as dynamic variant later
    field :type, {
      :enum,
      %{
        type: :binary,
        values: [
          "IHDR",
          "PLTE",
          "IDAT",
          "IEND",
          "cHRM",
          "gAMA",
          "iCCP",
          "sBIT",
          "sRGB",
          "bKGD",
          "hIST",
          "tRNS",
          "pHYs",
          "sPLT",
          "tIME",
          "tEXt",
          "zTXt",
          "iTXt"
        ]
      }
    }, length: 4
  
    #consuming dynamic behaviour into length_by
    field :data, :binary, length_by: &data_length/1
  
    field :crc, :uint32_be
  
    #dynamic behaviour implementation
    #we returning always 'managed' type conversion, in this case length field will be automatically converted to elixir number
    #and we return this number as it
    defp data_length(length), do: length
  
  end
  
  ```

## Getting Started

### Explore Examples

Start by exploring the examples folder. Run the following commands to see an example in action:

```sh
mix run examples/png.exs
mix run examples/extraction_from_integer.exs
mix run examples/extraction_from_buffer.exs
mix run examples/packet_via_higher_order_macro.exs
```

### Reference Documentation

- [BinStruct Module Documentation](https://hexdocs.pm/bin_struct/BinStruct.html)

#### Type-Specific Docs

- [StaticValue](https://hexdocs.pm/bin_struct/BinStruct.Types.StaticValue.html)
- [Binary](https://hexdocs.pm/bin_struct/BinStruct.Types.Binary.html)
- [Enum](https://hexdocs.pm/bin_struct/BinStruct.Types.Enum.html)
- [Flags](https://hexdocs.pm/bin_struct/BinStruct.Types.Flags.html)
- [List](https://hexdocs.pm/bin_struct/BinStruct.Types.ListOf.html)
- [Variant](https://hexdocs.pm/bin_struct/BinStruct.Types.VariantOf.html)

### Explore Tests

For further insights, check out the `test/` folder, where you can explore the library’s future functionality through tests.

## View generated code

there is module_code/0 function for any module with applied use macro to (BinStruct, BinStructCustomType or BinStructOptionsInterface)
which will show for you all generated code.

## Configuration

You can configure `BinStruct` by adding the following to your `config.exs` file:

```elixir
config :bin_struct,
  define_receive_send_tcp: false, #default false
  define_receive_send_tls: false, #default false
  enable_log_tcp: true, #default true
  enable_log_tls: true #default true
```

### Notes on TLS

- TLS functionality is implemented using the `:ssl` application.
- If you wish to use TLS, make sure to either **disable it** or add `:ssl` to the list of `extra_applications`:

  ```elixir
  def application do
    [
      extra_applications: [:ssl]
    ]
  end
  ```

## Additional Documentation

Comprehensive documentation is available online:  
[BinStruct Docs](https://hexdocs.pm/bin_struct)

---
