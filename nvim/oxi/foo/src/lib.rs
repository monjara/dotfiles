use nvim_oxi::Error;

#[nvim_oxi::module]
fn foo() -> Result<i32, Error> {
    Ok(32)
}
