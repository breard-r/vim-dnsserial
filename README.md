vim-dnsserial
=============

[![Apache License 2.0](https://img.shields.io/github/license/breard-r/vim-dnsserial.svg "Apache License 2.0")](https://www.apache.org/licenses/LICENSE-2.0.html)

Another DNS-zone serial number updater.


Why?
----

I know this not the first vim plugin available to update a DNS-zone serial number. Here is a few reasons why I chose not to use the canonical one:

* there is no license and therefore it is not free;
* it is unmaintained;
* it is bugged;
* it lacks functionalities.

It chose not to fork the original plugin but to write a new one from scratch mainly for legal purposes, but also because I did not found the code as simple as I expected.


Usage
-----

By default, each time you save a `bindzone` file, the script will look for the DNS serial number and update it. You can also update it without saving the file by invoking the `:DNSSerialUpdate` function.


Configuration
-------------

You can turn off the automatic serial update by setting `let g:dnsserial_auto_update = 0` in your vimrc.
