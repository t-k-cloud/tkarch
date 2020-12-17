if exists("b:current_syntax")
    finish
endif
let b:current_syntax = "my_tkblog"

syn keyword tkblogTags 工作篇 生活篇 未分类
syn keyword tkblogTags 隐藏

syn match tkblogTagKey "\ttag:"

syn match tkblogElement "\[\/\?code.*\]" 
syn match tkblogElement "\[\/\?key\]" 
syn match tkblogElement "\[\/\?kbd\]" 
syn match tkblogElement "\[\/\?cmd\]" 
syn match tkblogElement "\[\/\?quote\]" 
syn match tkblogElement "\[\/\?face\]" 
syn match tkblogElement "\[cut_more\]" 
syn match tkblogElement "\[\/\?imath\]" 
syn match tkblogElement "\[\/\?dmath\]" 
syn match tkblogElement "\[\/\?photo\]" 
syn match tkblogElement "\[\/\?underline\]" 
syn match tkblogElement "\[\/\?overline\]" 
syn match tkblogElement "\[\/\?link\]" 
syn match tkblogElement "\[\/\?diagram\]" 

hi def link tkblogTags Statement
hi def link tkblogTagKey PreProc 
hi def link tkblogElement Type 
