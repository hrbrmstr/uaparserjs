
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Signed
by](https://img.shields.io/badge/Keybase-Verified-brightgreen.svg)](https://keybase.io/hrbrmstr)
![Signed commit
%](https://img.shields.io/badge/Signed_Commits-100%25-lightgrey.svg)
[![Linux build
Status](https://travis-ci.org/hrbrmstr/uaparserjs.svg?branch=master)](https://travis-ci.org/hrbrmstr/uaparserjs)
[![Coverage
Status](https://codecov.io/gh/hrbrmstr/uaparserjs/branch/master/graph/badge.svg)](https://codecov.io/gh/hrbrmstr/uaparserjs)
[![cran
checks](https://cranchecks.info/badges/worst/uaparserjs)](https://cranchecks.info/pkgs/uaparserjs)
[![CRAN
status](https://www.r-pkg.org/badges/version/uaparserjs)](https://www.r-pkg.org/pkg/uaparserjs)
![Minimal R
Version](https://img.shields.io/badge/R%3E%3D-3.2.0-blue.svg)
![License](https://img.shields.io/badge/License-Apache-blue.svg)

# uaparserjs

Parse ‘User-Agent’ Strings

## Description

Despite there being a section in RFC 7231
<https://tools.ietf.org/html/rfc7231#section-5.5.3> defining a suggested
structure for ‘User-Agent’ headers this data is notoriously difficult to
parse consistently. Tools are provided that will take in user agent
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
remotes::install_git("https://git.rud.is/hrbrmstr/uaparserjs.git")
# or
remotes::install_git("https://git.sr.ht/~hrbrmstr/uaparserjs")
# or
remotes::install_gitlab("hrbrmstr/uaparserjs")
# or
remotes::install_bitbucket("hrbrmstr/uaparserjs")
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
## [1] '0.3.1'

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

agents <- readLines("tests/agents.txt")

dplyr::glimpse(ua_parse(agents))
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

set.seed(100)
batch_100 <- sample(agents, 100)
microbenchmark::microbenchmark(
  ua_parse(batch_100)
)
## Unit: milliseconds
##                 expr      min      lq     mean   median       uq      max neval
##  ua_parse(batch_100) 19.44652 20.2158 21.42222 20.66315 22.56606 31.78299   100
```

## uaparserjs Metrics

| Lang | \# Files |  (%) | LoC |  (%) | Blank lines |  (%) | \# Lines |  (%) |
| :--- | -------: | ---: | --: | ---: | ----------: | ---: | -------: | ---: |
| R    |        6 | 0.86 | 202 | 0.93 |          94 | 0.81 |      125 | 0.81 |
| Rmd  |        1 | 0.14 |  16 | 0.07 |          22 | 0.19 |       30 | 0.19 |

## Code of Conduct

Please note that this project is released with a Contributor Code of
Conduct. By participating in this project you agree to abide by its
terms.
