# Fp16Pack

A simple gem providing methods to pack floating point numbers using the half-precision IEEE 754 FP16 format
(big endian and little endian) as well as corresponding unpack methods.

The actual floating point operations are done using the [Half](https://github.com/starkat99/half-rs) Rust crate via a native extension.

## Usage

```ruby
irb(main):006>require "fp16_pack"
=> true
# Little-endian packing
irb(main):007> Fp16Pack.pack([1.000, 0.0005, Float::INFINITY])
=> "\x00<\x19\x10\x00|"
irb(main):008> Fp16Pack.unpack(_)
=> [1.0, 0.0005002021789550781, Infinity]
irb(main):009> Fp16Pack.pack_be([1.000, 0.0005, Float::INFINITY])
=> "<\x00\x10\x19|\x00"
irb(main):010> Fp16Pack.unpack_be(_)
=> [1.0, 0.0005002021789550781, Infinity]
```

## Changelog

[CHANGELOG](https://github.com/maciekd-rr/fp16_pack/blob/main/CHANGELOG.md)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/maciekd-rr/fp16_pack. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/maciekd-rr/fp16_pack/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Fp16Pack project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/maciekd-rr/fp16_pack/blob/main/CODE_OF_CONDUCT.md).
