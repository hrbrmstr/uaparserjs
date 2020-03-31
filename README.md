
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Signed
by](https://img.shields.io/badge/Keybase-Verified-brightgreen.svg)](https://keybase.io/hrbrmstr)
![Signed commit
%](https://img.shields.io/badge/Signed_Commits-0%25-lightgrey.svg)
[![Linux build
Status](https://travis-ci.org/hrbrmstr/uaparserjs.svg?branch=master)](https://travis-ci.org/hrbrmstr/uaparserjs)
[![Coverage
Status](https://codecov.io/gh/hrbrmstr/uaparserjs/branch/master/graph/badge.svg)](https://codecov.io/gh/hrbrmstr/uaparserjs)
[![cran
checks](https://cranchecks.info/badges/worst/uaparserjs)](https://cranchecks.info/pkgs/uaparserjs)
[![CRAN
status](https://www.r-pkg.org/badges/version/uaparserjs)](https://www.r-pkg.org/pkg/uaparserjs)
![Minimal R
Version](https://img.shields.io/badge/R%3E%3D-3.0.0-blue.svg)
![License](https://img.shields.io/badge/License-Apache-blue.svg)

# uaparserjs

Parse Browser ‘User-Agent’ Strings into Data Frames

## Description

Despite there being a section in RFC 7231
<https://tools.ietf.org/html/rfc7231#section-5.5.3> defining a suggested
structure for ‘User-Agent’ headers this data is notoriously difficult to
parse consistently. A function is provided that will take in user agent
strings and return structured R objects. This is a ‘V8’-backed package
based on the ‘ua-parser’ project <https://github.com/ua-parser>.

NOTE: there is a [C++-backed R
package](https://github.com/ua-parser/uap-r) but it has
[issues](https://github.com/ua-parser/uap-r/issues) compiling on a few
platforms and is dependent upon Boost regex. This version is definitely
slower but it works on all platforms.

This was *briefly* on CRAN but the i386 Windows build of it has issues
due to the limitations of the v8 engine (not the V8 package) in that
environment. So, you’re stuck with a github install until Oliver (and/or
I) figure out how to get the C++-backed one working on all platforms.

## What’s Inside The Tin

The following functions are implemented:

  - `ua_parse`: Parse a vector of user agents into a data frame

## Installation

``` r
remotes::install_gitlab("hrbrmstr/uaparserjs")
# or
remotes::install_github("hrbrmstr/uaparserjs")
```

NOTE: To use the ‘remotes’ install options you will need to have the
[{remotes} package](https://github.com/r-lib/remotes) installed.

### Usage

``` r
library(uaparserjs)

# current verison
packageVersion("uaparserjs")
## [1] '0.3.0'

dplyr::glimpse(ua_parse("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.2 (KHTML, like Gecko) Ubuntu/11.10 Chromium/15.0.874.106 Chrome/15.0.874.106 Safari/535.2"))
## Observations: 1
## Variables: 9
## $ userAgent     <chr> "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.2 (KHTML, like Gecko) Ubuntu/11.10 Chromium/15…
## $ ua.family     <chr> "Chromium"
## $ ua.major      <chr> "15"
## $ ua.minor      <chr> "0"
## $ ua.patch      <chr> "874"
## $ os.family     <chr> "Ubuntu"
## $ os.major      <chr> "11"
## $ os.minor      <chr> "10"
## $ device.family <chr> "Other"

dplyr::glimpse(ua_parse(readLines("tests/agents.txt")))
## Observations: 1,091
## Variables: 13
## $ userAgent     <chr> "Mozilla/5.0 (Windows; U; en-US) AppleWebKit/531.9 (KHTML, like Gecko) AdobeAIR/2.5.1", "Mozill…
## $ ua.family     <chr> "AdobeAIR", "Amazon Silk", "Amazon Silk", "Amazon Silk", "Amazon Silk", "Amazon Silk", "Android…
## $ ua.major      <chr> "2", "1", "2", "2", "2", "3", "2", "2", "2", "2", "3", "4", "4", "4", "4", "1", "1", "6", "7", …
## $ ua.minor      <chr> "5", "1", "0", "1", "2", "25", "2", "3", "3", "3", "0", "0", "0", "0", "0", NA, NA, "13", "6", …
## $ ua.patch      <chr> "1", "0-80", NA, NA, NA, NA, "2", "3", "4", "5", "1", "3", "3", "3", "4", NA, NA, "13719", "214…
## $ os.family     <chr> "Windows", "Android", "Android", "Android", "Android", "Android", "Android", "Android", "Androi…
## $ device.family <chr> "Other", "Kindle", "Kindle Fire HD", "Kindle Fire", "Kindle Fire HD", "Kindle Fire HD", "HTC De…
## $ device.brand  <chr> NA, "Amazon", "Amazon", "Amazon", "Amazon", "Amazon", "HTC", "HTC", "Amazon", "Tecno", "Samsung…
## $ device.model  <chr> NA, "Kindle", "Kindle Fire HD 7\"", "Kindle Fire", "Kindle Fire HD 7\"", "Kindle Fire HD 7\"", …
## $ os.major      <chr> NA, NA, NA, NA, NA, "4", "2", "2", "2", "2", "3", "4", "4", "4", "4", "7", "7", "XP", "8", "4",…
## $ os.minor      <chr> NA, NA, NA, NA, NA, "0", "2", "3", "3", "3", "0", "0", "0", "0", "0", NA, NA, NA, NA, "1", "0",…
## $ os.patch      <chr> NA, NA, NA, NA, NA, "3", "2", "3", "4", "5", "1", "3", "3", "3", "4", NA, NA, NA, NA, "1", "6",…
## $ os.patchMinor <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
```

## uaparserjs Metrics

| Lang | \# Files |  (%) | LoC |  (%) | Blank lines |  (%) | \# Lines |  (%) |
| :--- | -------: | ---: | --: | ---: | ----------: | ---: | -------: | ---: |
| R    |        5 | 0.83 |  35 | 0.78 |          13 | 0.39 |       26 | 0.46 |
| Rmd  |        1 | 0.17 |  10 | 0.22 |          20 | 0.61 |       30 | 0.54 |

## Code of Conduct

Please note that this project is released with a Contributor Code of
Conduct. By participating in this project you agree to abide by its
terms.
