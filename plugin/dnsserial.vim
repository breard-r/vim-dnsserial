" Copyright 2015 Rodolphe Breard
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"   http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.

function! s:IncrementSerial(old_date, old_nb)
    let curr_date = strftime("%Y%m%d")
    if a:old_date ==? curr_date
        let curr_nb = a:old_nb + 1
        if curr_nb < 10
            let curr_nb = "0".curr_nb
        endif
    else
        let curr_nb = "01"
    endif
    return curr_date.curr_nb
endfunction

function! s:DNSSerialUpdate()
    let pattern = '\(\d\{8}\)\(\d\+\)\s*;\s*\cserial'
    if search(pattern) == 0
        echom "No serial found."
        return 0
    endif
    let old_pattern = matchlist(getline('.'), pattern)
    let old_serial = old_pattern[1].old_pattern[2]
    let new_serial = s:IncrementSerial(old_pattern[1], old_pattern[2])
    execute "s/".old_serial."/".new_serial."/"
    echom "Serial updated to ".new_serial."."
endfunction

command! DNSSerialUpdate call s:DNSSerialUpdate()
