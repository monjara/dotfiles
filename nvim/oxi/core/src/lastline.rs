use std::usize;

use nvim_oxi::{
    api::{self, opts::SetHighlightOpts},
    Error,
};

pub fn init() -> Result<(), Error> {
    api::set_option("laststatus", 0)?;
    let opt = SetHighlightOpts::builder().link("Normal").build();
    api::set_hl(0, "StatusLine", &opt)?;
    api::set_hl(0, "StatusLineNC", &opt)?;
    let width = api::get_current_win().get_width()? as usize;
    let line = "─".repeat(width);
    api::set_option("statusline", line)?;
    Ok(())
}
