 command! -nargs=* Gpush execute 'VimuxRunCommand "git push' <q-args> '"'
 command! Gpu execute 'VimuxRunCommand "git push -u origin HEAD"'
 command! Gpf execute 'VimuxRunCommand "git push -f origin HEAD"'
 command! -nargs=* Gfetch execute 'VimuxRunCommand "git fetch' <q-args> '"'
