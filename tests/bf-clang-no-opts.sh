#! /bin/sh

############################################
# Try compiling a simple program with      #
# bf-clang and no special Byfl options     #
#                                          #
# By Scott Pakin <pakin@lanl.gov>          #
############################################

# Define some helper variables.  The ":-" ones will normally be
# provided by the Makefile.
PERL=${PERL:-perl}
srcdir=${srcdir:-../../tests}
top_srcdir=${top_srcdir:-../..}
top_builddir=${top_builddir:-..}
clang=${BF_CLANG:-clang}
bf_clang="$top_builddir/tools/wrappers/bf-clang"

# Log everything we do.
set -x

# Test 1: Do the C compiler and linker work at all?
"$clang" -g -o simple "$srcdir/simple.c"

# Test 2: Do the C compiler and linker work when invoked from the Byfl
# wrapper script?
env BF_DISABLE=byfl \
  "$PERL" -I"$top_srcdir/tools/wrappers" \
    "$bf_clang" -bf-plugin="$top_builddir/lib/bytesflops/.libs/bytesflops.so" \
                -bf-verbose -g -o simple "$srcdir/simple.c" \
                -L"$top_builddir/lib/byfl/.libs"

# Test 3: Can the Byfl wrapper script compile, instrument, and link a program?
"$PERL" -I"$top_srcdir/tools/wrappers" \
  "$bf_clang" -bf-plugin="$top_builddir/lib/bytesflops/.libs/bytesflops.so" \
              -bf-verbose -g -o simple "$srcdir/simple.c" \
              -L"$top_builddir/lib/byfl/.libs"

# Test 4: Does the Byfl-instrumented program run without error?
env LD_LIBRARY_PATH="$top_builddir/lib/byfl/.libs:$LD_LIBRARY_PATH" \
  ./simple