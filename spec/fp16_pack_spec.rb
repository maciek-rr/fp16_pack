# frozen_string_literal: true

TEST_CASES_BE = [
  [[-Float::INFINITY], "\xfc\x00".b],
  [[-22.67], "\xCD\xAB".b],
  [[-4.0], "\xC4\x00".b],
  [[-2.3], "\xc0\x9a".b],
  [[-1.0e-10], "\x80\x00".b],
  [[0.0], "\x00\x00".b],
  [[1.0e-10], "\x00\x00".b],
  [[1.0e-7], "\x00\x02".b],
  [[6.10352e-5], "\x04\x00".b],
  [[0.00001], "\x00\xa8".b],
  [[0.1], "\x2e\x66".b],
  [[0.125], "\x30\x00".b],
  [[0.333251953125], "\x35\x55".b],
  [[1.0], "\x3c\x00".b],
  [[2.0], "\x40\x00".b],
  [[65_504], "\x7b\xff".b],
  [[Float::INFINITY], "\x7c\x00".b],
  [[Float::NAN], "\x7e\x00".b]
].freeze

RSpec.describe Fp16Pack do
  shared_examples "input corner cases" do
    context "when given an empty array" do
      let(:input_array) { [] }

      it { is_expected.to eq("") }
    end

    context "when given an array including non-floats" do
      let(:input_array) { [0.1, "a"] }

      it "raises an error" do
        expect { subject }.to raise_error(TypeError)
      end
    end
  end

  describe ".pack_be" do
    subject { Fp16Pack.pack_be(input_array) }

    TEST_CASES_BE.each do |input, expected|
      context "when given #{input}" do
        let(:input_array) { input }

        it { is_expected.to eq(expected) }
      end
    end

    context "when given all values" do
      let(:input_array) { TEST_CASES_BE.flat_map(&:first) }

      it { is_expected.to eq(TEST_CASES_BE.flat_map(&:last).join) }
    end

    include_examples "input corner cases"
  end

  describe ".pack" do
    subject { Fp16Pack.pack(input_array) }

    TEST_CASES_BE.each do |input, expected|
      context "when given #{input}" do
        let(:input_array) { input }

        it { is_expected.to eq(expected.reverse) }
      end
    end

    context "when given all values" do
      let(:input_array) { TEST_CASES_BE.flat_map(&:first) }

      it { is_expected.to eq(TEST_CASES_BE.flat_map(&:last).map(&:reverse).join) }
    end

    include_examples "input corner cases"
  end

  describe ".unpack" do
  end
end
