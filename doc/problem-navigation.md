# Finding and navigating code problems

`<leader>` is **Space**. Shortcuts below use Normal mode unless another mode or
panel is specified. Custom mappings come from this configuration; defaults were
checked against the installed Neovim 0.12 help and plugin sources. Some defaults
require Neovim 0.11 or newer. Use `:help diagnostic-defaults`, `:help lsp-defaults`
and `:help quickfix` for the built-in reference.

## Start here

1. Press `<leader>sd` to search reported diagnostics, or `<leader>xx` for Trouble.
2. Select a problem and press Enter to jump to its source.
3. Use `]d` / `[d` to move between diagnostics in that file.
4. Use `<leader>dd` or `<C-w>d` to read the message; `gd` / `grr` help trace it.
5. Use `<C-o>` to return to your previous location.

Diagnostics only include problems already reported by an LSP or linter. An
all-buffer view does not run a full project analysis. In particular, Pyright is
configured with `diagnosticMode = "openFilesOnly"`. Linters run on buffer entry,
save and leaving Insert mode when their tools are available.

## Diagnostic jumps and messages

| Shortcut | Origin | Action |
| --- | --- | --- |
| `]d` / `[d` | Neovim default | Next / previous diagnostic in the current buffer; accepts a count such as `3]d` on Neovim 0.11+. |
| `[D` / `]D` | Neovim default (0.11+) | First / last diagnostic in the current buffer. |
| `<C-w>d` / `<C-w><C-d>` | Neovim default | Show diagnostics in a floating window. |
| `<leader>dd` | Custom, on LSP attach | Show diagnostics in a floating window. |

Commands without a custom shortcut:

| Command | Action |
| --- | --- |
| `:lua vim.diagnostic.open_float()` | Read diagnostics at the current line. |
| `:lua vim.diagnostic.jump({count=1, float=true})` | Next diagnostic and its message (Neovim 0.11+). |
| `:lua vim.diagnostic.jump({count=-1, float=true})` | Previous diagnostic and its message. |
| `:lua vim.diagnostic.jump({count=1, severity=vim.diagnostic.severity.ERROR, float=true})` | Next error only; use `count=-1` for the previous error or `WARN` for warnings. |
| `:lua vim.diagnostic.setqflist()` | Put all reported diagnostics in quickfix and open it. |
| `:lua vim.diagnostic.setloclist()` | Put current-buffer diagnostics in the window's location list and open it. |
| `:lua vim.diagnostic.setqflist({severity=vim.diagnostic.severity.ERROR})` | Populate quickfix with errors only. |

## Problem lists: Telescope and Trouble

Defined in `lua/plugins/telescope.lua` and `lua/plugins/navigation.lua`.

| Custom shortcut | Equivalent command | Scope |
| --- | --- | --- |
| `<leader>sd` | `:Telescope diagnostics` | Search diagnostics from all buffers. |
| — | `:Telescope diagnostics bufnr=0` | Search current-buffer diagnostics. |
| `<leader>xx` | `:Trouble diagnostics toggle` | Toggle all reported diagnostics. |
| `<leader>xX` | `:Trouble diagnostics toggle filter.buf=0` | Toggle current-buffer diagnostics. |
| — | `:Trouble quickfix toggle` | View quickfix entries in Trouble. |
| — | `:Trouble loclist toggle` | View location-list entries in Trouble. |
| `<leader>sr` | `:Telescope resume` | Reopen the last picker. |

Inside Telescope:

| Mode | Shortcut | Action |
| --- | --- | --- |
| Insert / Normal | `<CR>` | Open the selected result. |
| Insert | `<C-n>` / `<C-p>` | Next / previous result (plugin defaults). |
| Normal | `j` / `k` | Next / previous result (plugin defaults). |
| Insert | `<C-j>` / `<C-k>` / `<C-t>` | Open in vertical split / horizontal split / tab (custom). |
| Normal | `H` / `J` / `K` / `L` | Open normally / vertical split / horizontal split / tab (custom). |
| Insert / Normal | `<C-q>` | Send results to **Trouble** (custom override of Telescope's quickfix action). |
| Normal | `q` | Close the picker (custom); Escape first leaves Insert mode. |

Inside Trouble, plugin defaults apply: `<CR>` jumps, `o` jumps and closes,
`<C-s>` / `<C-v>` open a split / vertical split, `}` or `]]` moves to the next
item, `{` or `[[` moves to the previous item, `p` previews, `P` toggles preview,
`q` closes, and `?` shows all mappings. Preview is automatic and the panel takes
focus in this configuration.

## Quickfix and location lists

Quickfix is shared across windows; a location list belongs to a window. Populate
one with diagnostics, search results, compiler output or test results first.
The custom toggles below only open a nonempty list; they do not collect problems.

| Shortcut or command | Action |
| --- | --- |
| `<leader>xq` / `<leader>xl` | Custom quickfix / location-list toggle. |
| `:copen` / `:cclose` | Open / close quickfix. |
| `:lopen` / `:lclose` | Open / close the location list. |
| `:cnext` / `:cprevious` | Next / previous quickfix entry. |
| `:lnext` / `:lprevious` | Next / previous location-list entry. |
| `:cfirst` / `:clast` | First / last quickfix entry. |
| `:lfirst` / `:llast` | First / last location-list entry. |
| `]q` / `[q`, `]Q` / `[Q` | Default next / previous, last / first quickfix entry (0.11+). |
| `]l` / `[l`, `]L` / `[L` | Default next / previous, last / first location-list entry (0.11+). |
| `:cc 3` / `:ll 3` | Jump to entry 3 in the corresponding list. |
| `:colder` / `:cnewer` | Restore an older / newer quickfix list. |
| `:lolder` / `:lnewer` | Restore an older / newer location list. |
| `<CR>` in a list | Open the selected entry. |
| `:Telescope quickfix` / `:Telescope loclist` | Search the corresponding list. |
| `:make` | Run the configured `makeprg` and parse compiler output with `errorformat`. |
| `:cfile build.log` | Load an existing compiler log using `errorformat`. |
| `:vimgrep /pattern/j **/*.go` | Collect matching lines in Go files into quickfix; adapt pattern and file glob. |
| `:lvimgrep /pattern/j **/*.go` | Collect matches into the location list. |

`nvim-bqf` enhances quickfix automatically. Built-in list commands still work.

## Trace the code behind a problem

LSP actions need an attached server that supports the requested operation.
Custom LSP mappings are in `lua/plugins/lsp.lua`.

| Shortcut or command | Origin | Action |
| --- | --- | --- |
| `gd` | Custom, on LSP attach | Go to definition. |
| `K` | Custom, on LSP attach; also an LSP default | Show hover documentation. |
| `grr` | Neovim default (0.11+) | Find references. |
| `gri` | Neovim default (0.11+) | Go to implementation. |
| `grt` | Neovim default in installed 0.12 | Go to type definition. |
| `gO` | Neovim default (0.11+) | List document symbols. |
| `gra` | Neovim default (0.11+), Normal / Visual | Request code actions for the problem or selection. |
| `grn` | Neovim default (0.11+) | Rename a symbol and its references. |
| `:lua vim.lsp.buf.declaration()` | Built-in API | Go to declaration. |
| `:Telescope lsp_references` | Plugin command | Search references. |
| `:Telescope lsp_definitions` / `:Telescope lsp_implementations` | Plugin commands | Search definitions / implementations. |
| `:Telescope lsp_type_definitions` | Plugin command | Search type definitions. |
| `:Telescope lsp_document_symbols` / `:Telescope lsp_dynamic_workspace_symbols` | Plugin commands | Search file / workspace symbols. |
| `<F2>` / `:Outline` | Custom | Toggle the symbol outline. |

`gr`, `gi`, `<leader>rn` and `<leader>ca` are commented out in the LSP config;
use the active mappings above.

## Find a message, file or known location

| Shortcut or command | Origin | Action |
| --- | --- | --- |
| `<leader>sg` / `:Telescope live_grep` | Custom / plugin | Search project text with ripgrep. |
| `<leader>sl` | Custom | Search a literal string rather than a regex. |
| `<leader>sw` / `:Telescope grep_string` | Custom / plugin | Search the word under the cursor. |
| `<leader>sf` or `<Home>` / `:Telescope find_files` | Custom / plugin | Find a file by name. |
| `<leader>/` | Custom | Fuzzy-search lines in the current buffer. |
| `<leader><leader>` / `<leader>s.` | Custom | Find open buffers / recent files. |
| `/pattern` / `?pattern`, `n` / `N` | Neovim default | Search forward / backward, then repeat / reverse the search. |
| `*` / `#` | Neovim default | Search the current word forward / backward. |
| `:123` or `123G`, `10` followed by `\|` | Neovim default | Go to line 123, or screen column 10. |
| `gf` / `gF` | Neovim default | Open the filename under the cursor; `gF` also uses a following line number. |
| `<C-o>` / `<C-i>`, `:jumps` | Neovim default | Older / newer jump location; inspect jump history. |
| `g;` / `g,`, `:changes` | Neovim default | Previous / next edit location; inspect change history. |
| `s` / `S` / `gs` | Custom Flash | Jump to a match / line / match across windows. |
| `<leader>+`, `<leader>=`, `<leader>1` … `<leader>9` | Custom Harpoon | Bookmark a file, open the menu, jump to a bookmarked file. |

Telescope grep excludes lockfiles, minified JS/CSS, `dist`, `node_modules`,
`vendor` and `.git`; ripgrep's usual ignore rules also apply. Search starts from
the working directory (`:pwd`). Flash overrides native `s`, `S`, `f`, `F` and
`t`; Arrow uses `m` and `;`, so native mark-setting and repeat-find keys differ
from an unconfigured Neovim.

## TODOs, failing tests and debugging

| Shortcut or command | Action |
| --- | --- |
| `:TodoTelescope` / `:TodoTrouble` | Find tagged comments, including TODO, FIXME, BUG and ISSUE. |
| `:TodoQuickFix` / `:TodoLocList` | Put tagged comments in quickfix / location list. |
| `:lua require('todo-comments').jump_next()` / `:lua require('todo-comments').jump_prev()` | Next / previous tagged comment; no custom jump shortcut is defined. |
| `<leader>tr` / `<leader>tf` / `<leader>tl` | Run nearest test / current test file / last test run. |
| `<leader>ts` | Toggle test summary; Enter expands, Tab jumps to the test source (custom panel keys). |
| `<leader>to` / `<leader>tp` | Open test output / toggle the output panel. |
| `:lua require('neotest').jump.next({status='failed'})` | Jump to the next failed test; use `.prev` for the previous one. |
| `<leader>td` | Debug the nearest test. |
| `<leader>db` / `<leader>dB` | Toggle a breakpoint / set a conditional breakpoint. |
| `<leader>dc` | Start or continue debugging. |
| `<leader>do` / `<leader>di` / `<leader>dO` | Step over / into / out. |
| `<leader>du` / `<leader>de` | Toggle debugger UI / evaluate an expression (evaluation also works in Visual mode). |
| `<leader>dr` / `<leader>dl` / `<leader>dt` | Toggle debug REPL / rerun last debug session / terminate. |
| `]c` / `[c` | Next / previous Git hunk; useful for locating a regression. |
| `<leader>hp` / `<leader>hb` | Preview the current hunk / blame the line. |
| `]x` / `[x` inside Diffview | Next / previous merge conflict. |

Neotest populates quickfix without opening it automatically. Test and debug
actions need the relevant runner or adapter. `<leader>tD` is assigned both to
debugging a test file and to Gitsigns' inline deleted-line preview, so it is not a
reliable test shortcut; use `:lua require('neotest').run.run({vim.fn.expand('%'), strategy='dap'})`.
See [Git commands](git-commands.md) for the full Git reference.

## Control diagnostic visibility and discover mappings

Defined in `lua/plugins/diagnostics-focus.lua`; these change presentation, not
which diagnostics exist or where jumps go. The initial mode is Minimal.

| Custom shortcut | Action |
| --- | --- |
| `<leader>df` | Cycle Minimal → Current Line → Diagflow → Float on Hover → Full. |
| `<leader>d1` | Minimal: disable virtual text and automatic floats. |
| `<leader>d2` | Show virtual text on the current line. |
| `<leader>d3` | Show current-line diagnostics using Diagflow. |
| `<leader>d4` | Show a diagnostic float when the cursor rests. |
| `<leader>d5` | Show virtual text for all diagnostics. |
| `<leader>dh` | Toggle diagnostic virtual text. |
| `<leader>sk` / `:Telescope keymaps` | Search active mappings. |
| `<leader>sh` / `:Telescope help_tags` | Search help. |

Use `:verbose nmap ]d` (replace `]d` with any shortcut) to see its current mapping
and where it was defined. This is useful for buffer-local overrides or differences
between Neovim versions. Neo-tree diagnostics are disabled in this configuration;
use Telescope or Trouble to inspect problems across buffers.
