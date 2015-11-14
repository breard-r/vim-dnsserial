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


function! s:HasDateChanged(pattern, old_matchlist)
    let i = 0
    for matching in a:pattern.matching
        if matching.type ==? 'date'
            let old_date = a:old_matchlist[i]
            let new_date = strftime(matching.fmt)
            if old_date !=? new_date
                return 1
            endif
        endif
        let i += 1
    endfor
    return 0
endfunction

function! s:GetNewValue(matching, old_value, date_changed)
    if a:matching.type ==? 'date'
        return strftime(a:matching.fmt)
    elseif a:matching.type ==? 'integer'
        let nb = a:old_value + get(a:matching, 'offset', 1)
        if a:date_changed && get(a:matching, 'date_reset', 0)
            let nb = 0
        endif
        return printf('%0' . get(a:matching, 'padding', 1) . 'd', nb)
    endif
    return a:old_value
endfunction

function! s:GetNewSerial(pattern, old_matchlist)
    let date_changed = s:HasDateChanged(a:pattern, a:old_matchlist)
    let new_serial = []
    let i = 0
    for matching in a:pattern.matching
        let new_value = s:GetNewValue(matching, a:old_matchlist[i], date_changed)
        call add(new_serial, new_value)
        let i += 1
    endfor
    return join(new_serial, '')
endfunction

function! dnsserial#DNSSerialUpdate()
    let patterns = g:dnsserial_custom_patterns + g:dnsserial_patterns
    for pattern in patterns
        if search(pattern.regex) != 0
            let offset = len(pattern.matching)
            let old_matchlist = matchlist(getline('.'), pattern.regex)[1:offset]
            let old_serial = join(old_matchlist, '')
            let new_serial = s:GetNewSerial(pattern, old_matchlist)
            execute "s/" . old_serial . "/" . new_serial . "/"
            echom "Serial updated to " . new_serial . "."
            return 0
        endif
    endfor
    echom "No serial found."
endfunction
