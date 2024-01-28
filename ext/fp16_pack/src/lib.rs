use magnus::{function, prelude::*, Error, RString, Ruby};

fn pack(numbers: Vec<f64>) -> RString {
    let buf = RString::buf_new(numbers.len() * 2);

    for number in numbers {
        let fp16 = half::f16::from_f64(number);
        buf.cat(fp16.to_le_bytes().as_ref());
    }

    buf
}

fn pack_be(numbers: Vec<f64>) -> RString {
    let buf = RString::buf_new(numbers.len() * 2);

    for number in numbers {
        let fp16 = half::f16::from_f64(number);
        buf.cat(fp16.to_be_bytes().as_ref());
    }

    buf
}

fn unpack(packed: RString) -> Vec<f64> {
    let mut numbers = Vec::new();
    let bytes = packed.to_bytes();

    bytes.chunks(2).for_each(|chunk| {
        if chunk.len() == 2 {
            let fp16 = half::f16::from_le_bytes([chunk[0], chunk[1]]);
            numbers.push(fp16.to_f64());
        }
    });

    numbers
}

fn unpack_be(packed: RString) -> Vec<f64> {
    let mut numbers = Vec::new();
    let bytes = packed.to_bytes();

    bytes.chunks(2).for_each(|chunk| {
        if chunk.len() == 2 {
            let fp16 = half::f16::from_be_bytes([chunk[0], chunk[1]]);
            numbers.push(fp16.to_f64());
        }
    });

    numbers
}

#[magnus::init]
fn init(ruby: &Ruby) -> Result<(), Error> {
    let module = ruby.define_module("Fp16Pack")?;
    module.define_singleton_method("pack", function!(pack, 1))?;
    module.define_singleton_method("pack_be", function!(pack_be, 1))?;
    module.define_singleton_method("unpack", function!(unpack, 1))?;
    module.define_singleton_method("unpack_be", function!(unpack_be, 1))?;
    Ok(())
}
