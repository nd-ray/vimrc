"============================================================================
"File:        splint.vim
"Description: Syntax checking plugin for syntastic
"Maintainer:  LCD 47 <lcd047 at gmail dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"============================================================================

if exists('g:loaded_syntastic_c_splint_checker')
    finish
endif
let g:loaded_syntastic_c_splint_checker = 1

if !exists('g:syntastic_splint_config_file')
    let g:syntastic_splint_config_file = '.syntastic_splint_config'
endif

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_c_splint_GetLocList() dict
    let makeprg = self.makeprgBuild({
        \ 'args': syntastic#c#ReadConfig(g:syntastic_splint_config_file),
        \ 'args_after': '-showfunc -hints +quiet' })

    let errorformat =
        \ '%-G%f:%l:%v: %[%#]%[%#]%[%#] Internal Bug %.%#,' .
        \ '%-G%f(%l\,%v): %[%#]%[%#]%[%#] Internal Bug %.%#,' .
        \ '%W%f:%l:%v: %m,' .
        \ '%W%f(%l\,%v): %m,' .
        \ '%W%f:%l: %m,' .
        \ '%W%f(%l): %m,' .
        \ '%-C %\+In file included from %.%#,' .
        \ '%-C %\+from %.%#,' .
        \ '%+C %.%#'

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'subtype': 'Style',
        \ 'postprocess': ['compressWhitespace'],
        \ 'defaults': {'type': 'W'} })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'c',
    \ 'name': 'splint'})

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:
