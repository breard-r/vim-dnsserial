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


Patterns
--------

In order to be detected, the DNS serial number must match the following pattern:

* `YYYYMMDDXX ; serial`
  - `YYYY` is the year (4 digits);
  - `MM` is the month (2 digits);
  - `DD` is the day (2 digits);
  - `XX` is any non-negative number (1 or more digits);
  - the word `serial` is not case-sensitive;
  - there can be any number of blanks on each sides of the semicolon.


Configuration
-------------

You can turn off the automatic serial update by setting `let g:dnsserial_auto_update = 0` in your vimrc.
