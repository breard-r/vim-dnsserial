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


Status
------

This project is passively maintained. If there is no recent commits it is because:

- I did not encountered a bug and nobody reported any.
- I am happy with the functionalities and nobody asked for new ones.
- It works on both vim and neovim.

If you need anything, please open an issue.


Usage
-----

By default, each time you save a `bindzone` file, the script will look for the DNS serial number and update it. You can also update it without saving the file by invoking the `:DNSSerialUpdate` function.


Patterns
--------

In order to be detected, the DNS serial number must match one the following pattern:

* `YYYYMMDDXX ; serial`
  - `YYYY` is the year (4 digits, must start by either `19` or `2`);
  - `MM` is the month (2 digits);
  - `DD` is the day (2 digits);
  - `XX` is any non-negative number (1 or more digits);
  - the word `serial` is not case-sensitive;
  - there can be any number of blanks on each sides of the semicolon.

* `SSSSSSSSSS ; serial`
  - `SSSSSSSSSS` is the UNIX timestamp (10 digits, must start by `1`);
  - the word `serial` is not case-sensitive;
  - there can be any number of blanks on each sides of the semicolon.

* `XX ; serial`
  - `XX` is any non-negative number (1 or more digits);
  - the word `serial` is not case-sensitive;
  - there can be any number of blanks on each sides of the semicolon.

According to those patterns, only dates between 1900 and 2999 will be detected; however this should not be a problem at all. Most importantly, only timestamps between September 9 2001 and March 17 2030 will be detected.


Configuration
-------------

You can set several configuration variables in your vimrc:

* `g:dnsserial_auto_update`: Defines whether or not the serial is updated when the zone file is saved (default is 1, set it to 0 to disable).
* `g:dnsserial_custom_patterns`: List of customs patterns that will be added to the default ones. Order matters, the first matching patters will be used. Customs patterns will be tested before the default ones.
* `g:dnsserial_patterns`: List of default patterns. It is not advised to change it.


Custom patterns
---------------

A pattern is defined by a dictionary with two keys: `regex` and `matching`.

**regex**

Contains the regular expression that will be used to search the document for the serial number. All the components of the serial number must be captured with parenthesis.

**matching**

This is a list of every components of the serial number. Each component is defined by a dictionary. The `type` key must be present and contain one of the allowed types. Depending on the type, several additional keys might be defined. Authorized types and their options are:

* `raw`: Raw string.
* `integer`: An integer that will be incremented.
- `offset` (int): set the offset by which the integer is incremented. Default is 1.
- `padding` (int): Force the integer to be 0-padded on the associated number of digits.
- `date_reset` (bool): If set to 1 and a the serial contains a `date`, the integer will be reseted to 0 if the date is updated. Default is 0.
* `date`: A formated date that will be updated to the current one.
- `fmt` (string, mandatory) : the date format according to the `strftime()` specifications. See `:help strftime` for more details.

**examples**

A simple pattern matching a serial defined as an integer and followed by a comment starting by the word `serial` is:

```js
{
  'regex': '\(\d\+\)\s*;\s*\cserial',
  'matching': [
    {'type': 'integer'}
  ]
}
```

The same example, but having the serial number starting by the current date (YYYYMMDD) and the integer padded on two digits:


```js
{
  'regex': '\(\d\{8}\)\(\d\+\)\s*;\s*\cserial',
  'matching': [
    {'type': 'date', 'fmt': '%Y%m%d'},
    {'type': 'integer', 'padding': 2, 'date_reset': 1}
  ]
}
```
