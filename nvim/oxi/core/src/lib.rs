use nvim_oxi::Error;

mod key_map;
mod lastline;
mod opts;

#[nvim_oxi::module]
fn core() -> Result<(), Error> {
    opts::init()?;
    key_map::init()?;
    lastline::init()?;
    Ok(())
}
