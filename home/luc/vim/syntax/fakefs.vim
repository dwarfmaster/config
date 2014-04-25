" Vim syntax file
" Language: Praject Warrior Fake-FS save
" Maintainer: Luc Chabassier <MAIL1>
" Latest Revision: 12 november 2013

if exists("b:current_syntax")
    finish
endif
setlocal iskeyword+=:
syn case ignore

syn match key '^".\{-}"' display
syn keyword Keys nextgroup=key skipwhite

syn match value ':\s*".\{-}"' display
syn keyword Values nextgroup=value skipwhite

hi def link Keys   Type
hi def link Values Constant

