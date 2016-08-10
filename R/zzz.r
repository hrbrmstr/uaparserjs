
.pkgenv <- new.env(parent=emptyenv())

.onAttach <- function(...) {

  ctx <- v8()
  ctx$source(system.file("js/bundle.js", package="uaparserjs"))
  ctx$eval(JS('var parser = uap(regexes)'))

  assign("ctx", ctx, envir=.pkgenv)

  cache <- list()

  assign("cache", cache, envir=.pkgenv)

}