use nvim_oxi::{api, Error};

struct Opt<T> {
    name: String,
    value: T,
}

impl<T> Opt<T> {
    pub fn new(name: impl Into<String>, value: T) -> Opt<T> {
        Opt {
            name: name.into(),
            value,
        }
    }
}

pub fn init() -> Result<(), Error> {
    let opts = [
        Opt::new("fenc", "utf-8"),
        Opt::new("encoding", "utf-8"),
        Opt::new("shortmess", "aoOTIcF"),
        Opt::new("clipboard", "unnamedplus"),
        Opt::new("signcolumn", "yes"),
        Opt::new("virtualedit", "onemore"),
        Opt::new("wildmode", "list:longest"),
        Opt::new("completeopt", "menu,menuone,noselect"),
    ];
    for opt in opts {
        api::set_option(&opt.name, opt.value)?;
    }
    let opts = [
        Opt::new("writebackup", false),
        Opt::new("ignorecase", true),
        Opt::new("wildignorecase", true),
        Opt::new("hidden", true),
        Opt::new("showcmd", true),
        Opt::new("autoread", true),
        Opt::new("backup", false),
        Opt::new("showmatch", true),
        Opt::new("swapfile", false),
        Opt::new("cursorline", true),
        Opt::new("visualbell", true),
        Opt::new("splitright", true),
        Opt::new("autoindent", true),
        Opt::new("smartindent", true),
        Opt::new("cindent", true),
        Opt::new("smarttab", true),
        Opt::new("expandtab", true),
    ];

    for opt in opts {
        api::set_option(&opt.name, opt.value)?;
    }
    let opts = [
        Opt::new("cmdheight", 0),
        Opt::new("laststatus", 0),
        Opt::new("updatetime", 300),
        Opt::new("tabstop", 2),
        Opt::new("shiftwidth", 2),
        Opt::new("softtabstop", 0),
    ];
    for opt in opts {
        api::set_option(&opt.name, opt.value)?;
    }
    api::set_var("mapleader", ",")?;
    Ok(())
}
