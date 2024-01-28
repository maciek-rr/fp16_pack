# frozen_string_literal: true

require "benchmark"
require "fp16_pack"
Benchmark.bm do |x|
  n = 100_000
  # arrs = n.times.map { 100.times.map { rand } }
  # int_arrs = n.times.map { arrs[_1].map { |f| (f * 100).to_i } }
  arr = 100.times.map { rand }
  int_arr = arr.map { |f| (f * 100).to_i }

  x.report("Fp16Pack.pack") { n.times { Fp16Pack.pack(arr) } }
  x.report("Array#pack") { n.times { int_arr.pack("S*") } }
end
