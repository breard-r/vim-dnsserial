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


if !exists('g:dnsserial_auto_update')
    let g:dnsserial_auto_update = 1
endif

if g:dnsserial_auto_update
    augroup dnsserial
        autocmd!
        autocmd BufWritePre <buffer> DNSSerialUpdate
    augroup END
endif
