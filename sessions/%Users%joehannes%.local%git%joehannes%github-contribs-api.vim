let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.local/git/joehannes/github-contribs-api
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
$argadd ~/.config/nvim/lua/keymappings.lua
tabnew
tabrewind
edit ~/.local/git/joehannes/joehannes.github.io/src/pages/Welcome.tsx
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 159 + 160) / 320)
exe 'vert 2resize ' . ((&columns * 160 + 160) / 320)
argglobal
balt ~/.local/git/joehannes/joehannes.github.io/src/pages/WorkExperience.tsx
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=5
setlocal fml=1
setlocal fdn=20
setlocal fen
11
normal! zo
let s:l = 8 - ((0 * winheight(0) + 38) / 77)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 8
normal! 015|
wincmd w
argglobal
if bufexists("~/.local/git/joehannes/joehannes.github.io/src/db/model/WorkExperience.model.ts") | buffer ~/.local/git/joehannes/joehannes.github.io/src/db/model/WorkExperience.model.ts | else | edit ~/.local/git/joehannes/joehannes.github.io/src/db/model/WorkExperience.model.ts | endif
if &buftype ==# 'terminal'
  silent file ~/.local/git/joehannes/joehannes.github.io/src/db/model/WorkExperience.model.ts
endif
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=1
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 15 - ((14 * winheight(0) + 38) / 77)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 15
normal! 018|
lcd ~/.local/git/joehannes/joehannes.github.io
wincmd w
exe 'vert 1resize ' . ((&columns * 159 + 160) / 320)
exe 'vert 2resize ' . ((&columns * 160 + 160) / 320)
tabnext
edit ~/.local/git/joehannes/github-contribs-api/index.js
argglobal
setlocal fdm=expr
setlocal fde=nvim_treesitter#foldexpr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 54 - ((49 * winheight(0) + 38) / 77)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 54
normal! 0
tabnext 2
badd +8 ~/.local/git/joehannes/joehannes.github.io/src/pages/Welcome.tsx
badd +0 ~/.config/nvim/lua/keymappings.lua
badd +45 ~/.local/git/joehannes/joehannes.github.io/src/pages/Welcome.module.scss
badd +106 ~/.local/git/joehannes/joehannes.github.io/src/App.scss
badd +36 ~/.local/git/joehannes/joehannes.github.io/src/assets/data/work_experience.json
badd +123 ~/.local/git/joehannes/joehannes.github.io/src/pages/WorkExperience.tsx
badd +54 ~/.local/git/joehannes/github-contribs-api/index.js
badd +15 ~/.local/git/joehannes/joehannes.github.io/src/db/model/WorkExperience.model.ts
badd +24 ~/.local/git/joehannes/joehannes.github.io/src/db/schema/WorkExperience.schema.ts
badd +24 ~/.local/git/joehannes/joehannes.github.io/src/db/index.ts
badd +19 ~/.local/git/joehannes/joehannes.github.io/src/App.tsx
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=aoO
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :