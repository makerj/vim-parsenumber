if exists( "g:loaded_vim_parsenumber" )
  finish
endif
let g:loaded_vim_parsenumber = 1

if !has( 'python' ) && !has( 'python3' )
  echohl WarningMsg |
    \ echomsg "Vim should be compiled with python support to use vim-parsenumber" |
    \ echohl None
  finish
endif

function! s:ParseNumber()
python << EOF
import vim

def parsenumber(s):
	try:
		print("Converting '%s'" % s)
		print('----------')
		n = int(s, 0)
		print('Dec         %d' % n)
		print('Hex         %X' % n)
		print('Bytes       %d' % n)
		print('KBytes      %d' % (n // 1024))
		print('MBytes      %d' % (n // 1024 // 1024))
		print('GBytes      %d' % (n // 1024 // 1024 // 1024))
		GB = (n // (1024 * 1024 * 1024))
		n  = (n % (1024 * 1024 * 1024))
		MB = (n // (1024 * 1024))
		n  = (n % (1024 * 1024))
		KB = (n // (1024))
		n  = (n % (1024))
		B  = (n)
		print('Mixed Bytes %dGb %dMb %dKb %db' % (GB, MB, KB, B))
	except:
		print('Invalid literal %s were given' % s)
		return

parsenumber(vim.eval("expand('<cword>')"))
EOF
endfunction

command! ParseNumber call <SID>ParseNumber()

