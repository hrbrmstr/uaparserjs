## Test environments
* local OS X install, R 3.3.1
* ubuntu 12.04 (on travis-ci), R 3.3.1

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

## Reverse dependencies

This is a new release, so there are no reverse dependencies.

---

win-builder gave a memory error but every other system I've 
run this on did the pkg load & tests just fine. It does
generate a large data structure using V8 in the pkg
environment but that's necessary for the actual parsing job.
