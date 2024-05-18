use nvim_oxi::{
    api::{self, opts::SetKeymapOpts, types::Mode},
    Error,
};

struct Keymap {
    mode: Mode,
    lhs: String,
    rhs: String,
    opts: SetKeymapOpts,
}

impl Keymap {
    fn new(mode: Mode, lhs: impl Into<String>, rhs: impl Into<String>) -> Keymap {
        let opts = SetKeymapOpts::builder().noremap(true).silent(true).build();
        Keymap {
            mode,
            lhs: lhs.into(),
            rhs: rhs.into(),
            opts,
        }
    }
}

pub fn init() -> Result<(), Error> {
    let maps = [
        Keymap::new(Mode::Normal, "<space>", ""),
        Keymap::new(Mode::Visual, "<space>", ""),
        Keymap::new(Mode::Normal, "<space>w", "<cmd>silent w!<cr>"),
        Keymap::new(Mode::Normal, "<space>q", "<cmd>q!<cr>"),
        Keymap::new(Mode::Normal, "<space>wq", "<cmd>wq<cr>"),
        Keymap::new(Mode::Normal, r"\", ","),
        Keymap::new(Mode::Normal, "j", "gj"),
        Keymap::new(Mode::Normal, "k", "gk"),
        Keymap::new(Mode::Normal, "gj", "j"),
        Keymap::new(Mode::Normal, "gk", "k"),
        Keymap::new(Mode::Normal, "ZZ", ""),
        Keymap::new(Mode::Normal, "ZQ", ""),
        Keymap::new(Mode::Normal, "<space>tt", "<cmd>terminal<CR>"),
        Keymap::new(Mode::Normal, "<space>si", r#"<cmd>%s/"/'/g<CR>"#),
        Keymap::new(Mode::Insert, "jj", "<esc>"),
        Keymap::new(Mode::Insert, "<C-l>", "<esc>"),
        Keymap::new(Mode::InsertCmdLine, "<C-l>", "<esc>"),
        Keymap::new(Mode::Terminal, "<M-i>", "<C-\\><C-n>"),
        Keymap::new(
            Mode::Normal,
            "<leader>fp",
            r#"vim.api.nvim_command('let @" = expand("%:.")')"#,
        ),
        Keymap::new(
            Mode::Normal,
            "<leader>fd",
            r#"vim.api.nvim_command('let @" = expand("%:p:h")')"#,
        ),
        Keymap::new(
            Mode::Normal,
            "<leader>fe",
            r#"vim.api.nvim_command('echo expand("%:p")')"#,
        ),
        Keymap::new(
            Mode::Normal,
            "<leader>nn",
            r#"vim.api.nvim_command('set number!')"#,
        ),
        Keymap::new(Mode::Normal, "<leader>hl", "<cmd>nohl<cr>"),
        Keymap::new(Mode::Normal, "<leader>o", "<cmd>only<cr>"),
    ];

    for map in maps {
        api::set_keymap(map.mode, &map.lhs, &map.rhs, &map.opts)?;
    }

    Ok(())
}
