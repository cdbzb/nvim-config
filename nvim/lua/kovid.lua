

set termguicolors
hi clear

if exists("syntax_on")
  syntax reset
endif

set background=dark
let g:colors_name = "kovid"

if has('nvim') 
    " nvim does not require ctermul and fails if it is present
    function! s:h(group, style)
    execute "highlight" a:group 
        \ "guifg="   .(has_key(a:style, "fg")    ? a:style.fg       : "NONE")
        \ "guibg="   .(has_key(a:style, "bg")    ? a:style.bg       : "NONE")
        \ "gui="     .(has_key(a:style, "styles")? a:style.styles   : "NONE")
        \ "cterm="   .(has_key(a:style, "styles")? a:style.styles   : "NONE")
        \ "guisp="   .(has_key(a:style, "ul")    ? a:style.ul       : "fg")
        \ "ctermbg=NONE"
    endfunction
else
    function! s:h(group, style)
    execute "highlight" a:group 
        \ "guifg="   .(has_key(a:style, "fg")    ? a:style.fg       : "NONE")
        \ "guibg="   .(has_key(a:style, "bg")    ? a:style.bg       : "NONE")
        \ "gui="     .(has_key(a:style, "styles")? a:style.styles   : "NONE")
        \ "cterm="   .(has_key(a:style, "styles")? a:style.styles   : "NONE")
        \ "guisp="   .(has_key(a:style, "ul")    ? a:style.ul       : "fg")
        \ "ctermul=" .(has_key(a:style, "ul")    ? a:style.ul       : "NONE")
        \ "ctermbg=NONE"
    endfunction
endif


" Color definitions
let s:bg = "#242424"
let s:bg_shaded = "#2d2d2d"
let s:bg_intense = "#000000"
let s:bg_highlight = "#ffff66"
let s:bg_fold = "#384048"
let s:cursor = "#656565"
let s:menu = "#444444"
let s:error_color = "darkred"  " cant use a hex code for this as it wont work with ctermul
let s:fg = "#e0e0e0"
let s:fg_dull = "#99968b"
let s:fg_inverted = "#000000"
let s:fg_fold = "#a0a8b0"

" General colors
if has('gui_running') 
    call s:h("Normal", {"bg": s:bg, "fg": s:fg})
else
    hi Normal NONE
    " Clear the terminal default background and foreground colors, thereby
    " improving performance by not needing to set these colors on empty cells.
    if has('nvim') 
        " nvim has no t_ti 
        call writefile(["\033]10;" . s:fg . "\007\033]11;" . s:bg . "\007"], "/dev/tty", "b")
        autocmd VimLeave * call writefile(["\033]110\007\033]111\007"], "/dev/tty", "b")
    else
        let &t_ti = &t_ti . "\033]10;" . s:fg . "\007\033]11;" . s:bg . "\007"
        let &t_te = &t_te . "\033]110\007\033]111\007"
    endif
endif
call s:h("Cursor", {"bg": s:cursor})
call s:h("CursorLine", {"bg": s:bg_shaded})
call s:h("CursorColumn", {"bg": s:bg_shaded})
call s:h("ColorColumn", {"bg": s:bg_shaded})
call s:h("NonText", {"fg": s:fg_dull, "bg": s:bg_shaded})
call s:h("StatusLine", {"fg": s:fg, "bg": s:menu})
call s:h("StatusLineNC", {"fg": s:fg_dull, "bg": s:menu})
call s:h("VertSplit", {"bg": s:menu, "fg": s:fg_dull})
call s:h("Folded", {"bg": s:bg_fold, "fg": s:fg_fold})
call s:h("Title", {"fg": s:fg, "styles": "bold"})
call s:h("Visual", {"fg": s:fg, "bg": s:menu})
call s:h("SpecialKey", {"fg": s:fg_dull, "bg": s:menu})
call s:h("MatchParen", {"fg": s:fg, "bg": s:fg_dull, "styles": "bold"})
call s:h("Pmenu", {"fg": s:fg, "bg": s:menu})
call s:h("PmenuSel", {"styles": "reverse"})
call s:h("SpellBad", {"ul": s:error_color, "styles": "undercurl"})
call s:h("Question", {'fg': '#cae682'})
call s:h("LineNr", {"fg": s:fg_dull, "bg": s:bg_intense})
call s:h("CursorLineNr", {"fg": s:fg_inverted, "bg": s:bg_highlight, "styles": "bold"})

" Plugins
call s:h("ALEErrorSign", {"bg": s:bg_intense, "fg": s:fg})
call s:h("ALEWarningSign", {"bg": s:bg_intense, "fg": s:fg})
call s:h("ALEInfoSign", {"bg": s:bg_intense, "fg": s:fg})
call s:h("ALEStyleErrorSign", {"bg": s:bg_intense, "fg": s:fg})
call s:h("ALEStyleWarningSign", {"bg": s:bg_intense, "fg": s:fg})
call s:h("ALEError", {"ul": s:error_color, "styles": "undercurl"})
call s:h("ALEWarning", {"ul": "yellow", "styles": "undercurl"})
call s:h("ALEStyleError", {"ul": "magenta", "styles": "undercurl"})
call s:h("CtrlPLinePre", {"bg": s:bg_highlight})

" Syntax highlighting
call s:h("Todo", {"fg": "orange", 'styles': "italic"})
call s:h("Constant", {"fg": "#e5786d"})
call s:h("String", {"fg": "#95e454"})
call s:h("Identifier", {"fg": "#cae682"})
call s:h("Function", {"fg": "#cae682"})
call s:h("Entity", {"fg": "#cae682"})
call s:h("Type", {"fg": "#cae682"})
call s:h("Statement", {"fg": "#8ac6f2"})
call s:h("Keyword", {"fg": "#8ac6f2"})
call s:h("PreProc", {"fg": "#e5786d"})
call s:h("Number", {"fg": "#e5786d"})
call s:h("Special", {"fg": "#e7f6da"})
call s:h("Include", {"fg": "#facf81"})
call s:h("Comment", {"fg": s:fg_dull, 'styles': "italic"})
