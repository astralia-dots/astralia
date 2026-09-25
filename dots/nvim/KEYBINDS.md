# VSCode → LazyVim keybinds

Leader is `Space`. Press it and wait for which-key to list everything.

| VSCode | LazyVim | Action |
|---|---|---|
| `Ctrl+P` | `Space Space` / `Space f f` | Find file |
| `Ctrl+Shift+F` | `Space /` / `Space s g` | Search text in project |
| `Ctrl+F` | `/` | Search in file |
| `Ctrl+Shift+H` | `Space s r` | Search & replace across files |
| `Ctrl+B` | `Space e` | Toggle file explorer |
| `Alt+Left` (custom) | `Alt+Left` / `h` | Collapse directory (in explorer) |
| `Ctrl+Shift+P` | `Space s c` / `:` | Command history / command line |
| ``Ctrl+` `` | `Ctrl+/` | Toggle terminal |
| `Ctrl+Tab` | `Space ,` / `Shift+H` / `Shift+L` | Switch buffers / prev / next |
| `Ctrl+W` | `Space b d` | Close buffer |
| Close all editors | `Space b a` (custom) | Close all buffers, show dashboard |
| Close others | `Space b o` | Close all other buffers |
| `Ctrl+S` | `Ctrl+S` | Save |
| `Ctrl+/` | `gcc` / `gc` (visual) | Toggle comment |
| `F12` | `gd` | Go to definition |
| `Shift+F12` | `gr` | Find references |
| Hover | `K` | Hover docs |
| `F2` | `Space c r` | Rename symbol |
| `Ctrl+.` | `Space c a` | Code action |
| `Shift+Alt+F` | `Space c f` | Format |
| Problems panel | `Space x x` | Diagnostics (Trouble) |
| `F8` / `Shift+F8` | `]d` / `[d` | Next / prev diagnostic |
| `Ctrl+Shift+O` | `Space s s` | Go to symbol |
| Split editor | `Space \|` / `Space -` | Split vertical / horizontal |
| Focus pane | `Ctrl+h/j/k/l` | Move between splits |
| Resize pane | `Ctrl+Left` / `Ctrl+Right` | Move the focused pane's border left / right (flips for right-edge panels like Claude; works on the explorer too) |
| Resize pane | `Ctrl+Up` / `Ctrl+Down` | Taller / shorter |
| Source control | `Space g g` | Lazygit |
| `Alt+↑` / `Alt+↓` | `Alt+k` / `Alt+j` | Move line / selection |
| Undo / Redo | `u` / `Ctrl+R` | Undo / redo |
| Reopen workspace | `Space q s` | Restore session |

## Vim essentials (no VSCode equivalent)

### Modes

| Keys | Action |
|---|---|
| `i` / `a` | Insert before / after cursor |
| `I` / `A` | Insert at line start / end |
| `o` / `O` | New line below / above |
| `Esc` | Back to normal mode |
| `v` / `V` / `Ctrl+V` | Visual char / line / block select |

### Moving

| Keys | Action |
|---|---|
| `w` / `b` / `e` | Next word / prev word / end of word |
| `0` / `^` / `$` | Line start / first char / line end |
| `gg` / `G` | File top / bottom |
| `{` / `}` | Prev / next paragraph (blank line) |
| `%` | Jump to matching bracket |
| `f<c>` / `t<c>` | Jump to / before char on line (`;` repeats) |
| `s` | Flash jump: type 2 chars, then the label |
| `Ctrl+D` / `Ctrl+U` | Half page down / up |
| `Ctrl+O` / `Ctrl+I` | Jump back / forward (like VSCode's Alt+←/→ history) |
| `*` / `n` / `N` | Search word under cursor / next / prev |

### Editing (verb + target)

Operators `d` delete, `c` change, `y` yank (copy) combine with any motion or text object: `i` = inside, `a` = around.

| Keys | Action |
|---|---|
| `ciw` / `diw` | Change / delete word |
| `ci"` / `ci(` / `cit` | Change inside quotes / parens / HTML tag |
| `daf` / `dac` | Delete function / class (treesitter) |
| `dd` / `cc` / `yy` | Delete / change / yank line |
| `D` / `C` | Delete / change to end of line |
| `x` | Delete char |
| `p` / `P` | Paste after / before |
| `u` / `Ctrl+R` | Undo / redo |
| `.` | Repeat last edit |
| `>>` / `<<` | Indent / dedent line (`>` / `<` in visual) |
| `J` | Join line below |
| `~` | Toggle case |

### Power moves

| Keys | Action |
|---|---|
| `q<r>` … `q`, then `@<r>` | Record macro into register r, replay (`@@` repeats) |
| `m<a>` / `` `<a> `` | Set mark / jump to mark |
| `"+y` / `"+p` | Yank / paste via system clipboard (LazyVim syncs by default) |
| `:%s/old/new/g` | Replace in file |
| `Ctrl+A` / `Ctrl+X` | Increment / decrement number |
| `za` / `zR` / `zM` | Toggle fold / open all / close all |
| `Space u` | UI toggles menu (wrap, spell, numbers, …) |
| `Space l` | Lazy plugin manager |
| `Space c m` | Mason (LSP / formatter installer) |
| `:checkhealth` | Diagnose setup problems |

## Claude Code (claudecode.nvim)

| Keys | Action |
|---|---|
| `Space a c` | Toggle Claude |
| `Space a f` | Focus Claude |
| `Space a b` | Add current buffer to context |
| `Space a s` (visual) | Send selection |
| `Space a a` | Accept diff |
| `Space a d` | Deny diff |
| `Ctrl+Left/Right/Up/Down` | Resize the panel while typing in it (Left widens it, since it sits on the right) |
| `Ctrl+\ Ctrl+N` | Leave the input (terminal → normal mode); `i` to type again |
