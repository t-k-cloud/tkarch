"设置自定义前缀
let mapleader=" "

"设置颜色主题
colorscheme desert
" blue       delek      evening    morning    peachpuff  slate
" darkblue   desert     industry   murphy     ron        torte
" default    elflord    koehler    pablo      shine      zellner

"在tmux里如果要开启mouse的全部效果（比如拖动），
"就需要设置ttymouse=xterm2
if &term =~ '^screen'
	set ttymouse=xterm2
endif

"开启mouse效果
"set mouse=a
"关闭mouse效果
set mouse=

"为了使snippet识别更多后缀文件
"使用 `:set filetype?' 得到当前使用的filetype变量值。
au BufNewFile,BufRead *.blog set filetype=tkblog
au BufNewFile,BufRead *.y set filetype=yacc
au BufNewFile,BufRead *.l set filetype=lex
au BufNewFile,BufRead *.mojo,*.🔥 setf mojo

au BufNewFile,BufRead *.wxml set filetype=html
au BufNewFile,BufRead *.wxss set filetype=css

"包含有关ctags
"set tags+=~/systags

"拼写检查的高亮
:highlight clear SpellBad
:highlight SpellBad gui=undercurl ctermfg=red cterm=underline

"包含cscope
if has("cscope")
set csprg=/usr/bin/cscope
set csto=0
set cst
set nocsverb
if filereadable("cscope.out")
cs add cscope.out
endif
set csverb
endif

"设置识别编码
set fileencodings=utf-8

"保证智能补全可以使用
filetype plugin on

"设置undo树，保证有足够undo
set undolevels=1000

"设置其他尝试识别的文本格式
set fileformats=unix,dos

"Toggle函数
function! ToggleCallbk(var, cmd0, cmd1)
	execute "let g:tmp=".a:var
	if g:tmp == 0
		execute a:cmd0
	else
		execute a:cmd1
	endif
	
	execute "let ".a:var."=!".a:var
endfunc

"行号toggle
let g:toggle_flag_setnu=0
nnoremap <Leader>nu :call ToggleCallbk("g:toggle_flag_setnu", ":set nu", ":set nonu")<cr><cr>

"光标列尺toggle
highlight ColorColumn ctermbg=235 guibg=#2c2d27
let g:toggle_flag_cursorcolumn=0
nnoremap <Leader>cl :call ToggleCallbk("g:toggle_flag_cursorcolumn", ":let &colorcolumn=virtcol('.')", ":set colorcolumn=")<cr><cr>

"C 语言环境toggle
let g:toggle_flag_c_environment=0
nnoremap <Leader>ci :call ToggleCallbk("g:toggle_flag_c_environment", ":set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab autoindent \|set nu\|syntax on\|syntax sync fromstart", ":set nonu\|set nocindent\|syntax off")<cr><cr>

"python 语言环境toggle
let g:toggle_flag_py_env=0
nnoremap <Leader>pi :call ToggleCallbk("g:toggle_flag_py_env", ":set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent \|set nu\|syntax on\|syntax sync fromstart", ":set nonu\|set nocindent\|syntax off")<cr><cr>

"HTML/WEB 语言环境toggle
let g:toggle_flag_html_env=0
nnoremap <Leader>wi :call ToggleCallbk("g:toggle_flag_html_env", ":set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent \|set nu\|syntax on\|syntax sync fromstart", ":set nonu\|set nocindent\|syntax off")<cr><cr>

"搜索高亮toggle
let g:toggle_flag_hl_search=0
nnoremap <Leader><S-s> :call ToggleCallbk("g:toggle_flag_hl_search", ":set hlsearch", ":set hlsearch!")<cr><cr>

"语法高亮toggle
let g:toggle_flag_hl_syntax=0
nnoremap <Leader>sy :call ToggleCallbk("g:toggle_flag_hl_syntax", ":syntax on\|syntax sync fromstart", ":syntax off")<cr><cr>

"自动匹配插入toggle
let g:toggle_flag_insert_pair_auto=0
nnoremap <Leader>pa :call ToggleCallbk("g:toggle_flag_insert_pair_auto", ":inoremap \( \(\)\<esc\>i\| inoremap \' \'\'\<esc\>i\| inoremap \" \"\"\<esc\>i\| inoremap \[ \[\]\<esc\>i\| inoremap \{ \{\}\<esc\>i", ":iunmap \(\|iunmap \'\|iunmap \"\|iunmap \[\|iunmap \{")<cr><cr>

"tab & trailing spaces 可见toggle
set listchars=tab:>\ ,trail:-
let g:toggle_flag_viewtab=0
nnoremap <Leader>ta :call ToggleCallbk("g:toggle_flag_viewtab", ":set list", ":set nolist")<cr><cr>

"spell check toggle
let g:toggle_flag_spell_check=0
nnoremap <Leader>sp :call ToggleCallbk("g:toggle_flag_spell_check", ":set spell", ":set nospell")<cr><cr>

"复制以后的连续替换
nnoremap <Leader>y "ay
nnoremap <Leader>p viw"ap
vnoremap <Leader>y "ay
vnoremap <Leader>p "ap

"加速移动
nnoremap <Leader>j 15j
nnoremap <Leader>k 15k

"此行追加
nnoremap <Leader><tab> ea<Space>

"代码注释快捷键
vnoremap <Leader>c/ <esc>:'<,'>s-^-//-g<cr>
vnoremap <Leader>u/ <esc>:'<,'>s-^//--g<cr>
vnoremap <Leader>c# <esc>:'<,'>s-^-#-g<cr>
vnoremap <Leader>u# <esc>:'<,'>s-^#--g<cr>
vnoremap <Leader>c" <esc>:'<,'>s-^-"-g<cr>
vnoremap <Leader>u" <esc>:'<,'>s-^"--g<cr>
vnoremap <Leader>c; <esc>:'<,'>s-^-;-g<cr>
vnoremap <Leader>u; <esc>:'<,'>s-^;--g<cr>

"upload 博客草稿 
nnoremap <Leader>up <esc>:!tk-blog-upload.sh % &<cr>
"publish 博客 
nnoremap <Leader>pu <esc>:!tk-blog-upload.sh % publish<cr>

"c语言hello world快速插入
nnoremap <Leader>wo <esc>i#include <stdio.h><cr>#include <stdlib.h><cr>int main()<cr>{<cr>	printf("hello world!\n");<cr>	return 0;<cr>}<esc>

"c语言函数折叠
nnoremap <Leader>z zfa{

"toggle 'foldenable':
" zfa{

"c函数定义到声明的转化
vnoremap <Leader>td <esc>:'<,'>s/[\ ]*\(\*\\|\)[a-zA-Z_1-9]*\(,\\|)\)/\1\2/g<cr><esc>:'<,'>s/)/);/g<cr>

"去除行尾空格/制表符 (strip trailing spaces)
"
vnoremap <Leader>ts <esc>:'<,'>s/\s\+$//gc<cr>

"session快捷保存
nnoremap <Leader>se :mksession! vim.session<cr>:w<cr>

"替换当前词快捷键
nnoremap <Leader>ss :%s/<c-r><c-w>/

"在Chrome中打开本行连接
nnoremap <Leader>www :call system('google-chrome `cat '.expand('%').'\|head -'.line('.').'\|tail -1` &')<cr>

"多词高亮
"------------------这里列出一些可以选择的颜色示例--------------------------
"hi MarkWord1  ctermbg=Cyan     ctermfg=Black  guibg=#8CCBEA    guifg=Black
"hi MarkWord2  ctermbg=Green    ctermfg=Black  guibg=#A4E57E    guifg=Black
"hi MarkWord3  ctermbg=Yellow   ctermfg=Black  guibg=#FFDB72    guifg=Black
"hi MarkWord4  ctermbg=Red      ctermfg=Black  guibg=#FF7272    guifg=Black
"hi MarkWord5  ctermbg=Magenta  ctermfg=Black  guibg=#FFB3FF    guifg=Black
"hi MarkWord6  ctermbg=Blue     ctermfg=Black  guibg=#9999FF    guifg=Black
"--------------------------------------------------------------------------

let g:hl_words = []
nnoremap <Leader>* :call MutiHighliht(expand("<cword>"))<cr>
nnoremap <Leader>0 :call CleanMutiHighlihtList()<cr>

function! CleanMutiHighlihtList()
	let g:hl_words = []
	execute "match Search2 '' " 
endfunc

function! Mk_or_words_in_qoutes(words)
	let ret_str = ""
	let i = 0
	for word in a:words
		let wrap_word = "\\<".word."\\>"
		if i == len(a:words) - 1
			let ret_str = ret_str.wrap_word
		else
			let ret_str = ret_str.wrap_word.'\|'
		endif

		let i = i + 1
	endfor

	return '"'.ret_str.'"'
endfunc

function! Hlwords_list_toggle(word)
	let find_idx = index(g:hl_words, a:word)
	if find_idx == -1
		call add(g:hl_words, a:word)
	else
		call remove(g:hl_words, find_idx)
	endif
endfunc

function! MutiHighliht(word)
	call Hlwords_list_toggle(a:word)
	let tmp_words = Mk_or_words_in_qoutes(g:hl_words)
	echo tmp_words
	execute "match Search2 ".tmp_words 
	" using the `Search2' highlight group color
endfunc

"cscope相关键位绑定
"查找调用函数
nnoremap <Leader>sc :cs find c <cword><cr>
"查找文件
nnoremap <Leader>sf :cs find f <cfile><cr>
"查找定义
nnoremap <Leader>sg :cs find g <cfile><cr>
"查找包含该文件的文件
nnoremap <Leader>si :cs find i <cfile><cr>
"查找 C 符号
" nnoremap <Leader>ss :cs find s <cfile><cr>
"查找字符串（正则表达可以使用命令 :cs find e some_regex）
nnoremap <Leader>st :cs find t <cword><cr>

"查看局部变量类型的定义
"Beta版：不能查看定义处的，不能查看定义了多个的。
nnoremap <Leader>me gdgE:let tt=expand('<cword>')<cr>``:exec "tag ".tt<cr>
"查看全局变量类型的定义
nnoremap <Leader>mE gDgE:let tt=expand('<cword>')<cr>``:exec "tag ".tt<cr>

"netrw相关
"使用netrw 打开当前目录
nmap <silent> <leader>e. :Explore .<cr> 
"隐藏 dot开头的、~结尾的 隐藏文件
let g:netrw_list_hide= '^\.[^/]\+,\~$'
"设置默认x键打开方式
let g:netrw_browsex_viewer= "xdg-open"
"设置默认liststyle 为 short listing
let g:netrw_liststyle = 0
"不保持current directory和netrw browsing directory相同
let g:netrw_keepdir = 1
"默认显示not-hidden files
let g:netrw_hide = 1
"默认删除目录的命令
let g:netrw_localrmdir="rm -r"
" when browsing, <cr> will open file by re-using the same window
let g:netrw_browse_split = 0

"设置x键打开方式 为只针对.tkfd文件
"let g:netrw_browsex_viewer="-"
"function! NFH_tkfd(filename)
"	execute "!google-chrome $(cat \"".a:filename."\" | head -1)"
"endfun

" in newer versions of vim (7.3+)
if has("persistent_undo")
	set undodir=~/.vim/undodir
	set undofile
endif

"自定义括号匹配高亮颜色
:highlight MatchParen cterm=bold ctermfg=yellow ctermbg=None

"自定义搜索高亮颜色
:highlight Search  cterm=NONE ctermfg=black ctermbg=yellow
:highlight Search2 cterm=NONE ctermfg=white ctermbg=blue

"自定义 vimdiff 颜色
highlight DiffAdd cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

"self-define Visual model highlight colors
:highlight Visual ctermbg=LightBlue cterm=bold gui=none

"======== AIRLINE =======
"airline theme 
let g:airline_theme='raven'
"show buffer number in tabs: N: filename 
let g:airline#extensions#tabline#buffer_nr_show = 1
"rename label for buffers (default: 'buffers') 
let g:airline#extensions#tabline#buffers_label = 'buf'
"Enable buffer tab
let g:airline#extensions#tabline#enabled = 1
"set hidden so that we can create new buffer 
"even if the current buffer is not saved yet.
set hidden
"Move to the next/previous buffer
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprevious<CR>
"toggle between two recent buffers.  
nnoremap <leader><leader> :e #<CR>
"Close the current buffer and move to the previous one
"This replicates the idea of closing a tab
"<BAR> is is the code for the pipe character '|'
nnoremap <leader>x :bp <BAR> bd #<CR>
" show function name of current cursor position
function Showfunname()
    return ''
	let lnum = line(".")
	let lcol = col(".")
	if g:toggle_flag_c_environment
		let funname = getline(search('^\w\+\s\+.*(.*)[^;]*$', 'bW'))
		call search("\\%" . lnum . "l" . "\\%" . lcol . "c")
		return ">> ".funname[0:60]
	elseif g:toggle_flag_py_env
		let funname = getline(search('^\s*def\ ', 'bW'))
		call search("\\%" . lnum . "l" . "\\%" . lcol . "c")
		" strip leading and tailing spaces
		let funname = substitute(funname, '^\s*\(.\{-}\)\s*$', '\1', '')
		return ">> ".funname[0:60]
	else
		return ''
	endif
endfunc
"specify which extensions to load (status bar string)
let g:airline_section_a = airline#section#create(['mode'])
let g:airline_section_b = ''
let g:airline_section_c = '%f %l,%v --%p%%-- %{Showfunname()}' " refer to Vim statusline.
let g:airline_section_x = '' 
let g:airline_section_y = airline#section#create(['ffenc'])
let g:airline_section_z = airline#section#create(['spell', 'readonly'])
let g:airline_section_error = ''
let g:airline_section_warning = ''
"to make status line really show on the screen.
set laststatus=2
"map buffer by number
nnoremap <leader>1 :b1<CR>
nnoremap <leader>2 :b2<CR>
nnoremap <leader>3 :b3<CR>
nnoremap <leader>4 :b4<CR>
nnoremap <leader>5 :b5<CR>
nnoremap <leader>6 :b6<CR>
nnoremap <leader>7 :b7<CR>
nnoremap <leader>8 :b8<CR>
nnoremap <leader>9 :b9<CR>

"不检查开头字母大写
set spellcapcheck= 

"""
" Bookmarks
"""
let g:bookmark_no_default_key_mappings = 1
let g:bookmark_auto_close = 0

let g:bookmark_annotation_sign = 'A '
let g:bookmark_sign = 'B '
highlight BookmarkSign           ctermbg=None ctermfg=Yellow
highlight BookmarkAnnotationSign ctermbg=None ctermfg=Yellow
"书签列不要颜色
highlight clear SignColumn

nmap mm <Plug>BookmarkToggle
nmap mj <Plug>BookmarkAnnotate
nmap ml <Plug>BookmarkShowAll
nmap mn <Plug>BookmarkNext
nmap mN <Plug>BookmarkPrev
"Clear bookmarks in current buffer only
nmap md <Plug>BookmarkClear
"Clear bookmarks in all buffers
nmap mD <Plug>BookmarkClearAll
"Save/Load into file
nnoremap <Leader>ms :BookmarkSave bookmarks.vim<cr>
nnoremap <Leader>ml :BookmarkLoad bookmarks.vim<cr>

" For the most accurate but slowest result, set the syntax synchronization
" method to fromstart. 
autocmd BufEnter * :syntax sync fromstart

" 强制关闭自动换行
set textwidth=0 wrapmargin=0
