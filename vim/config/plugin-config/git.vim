 command! -nargs=* Gpush execute 'VimuxRunCommand "git push' <q-args> '-u origin HEAD"'
 command! -nargs=* Gfetch execute 'VimuxRunCommand "git fetch' <q-args> '-u origin HEAD"'
