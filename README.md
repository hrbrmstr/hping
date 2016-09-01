
`hping` : Utilities to work with `hping` output in R

The following functions are implemented:

-   `extract_uptime`: Extract uptime from an `hping3` output dump

### Installation

``` r
devtools::install_github("hrbrmstr/hping")
```

### Usage

``` r
library(hping)

# current verison
packageVersion("hping")
```

    ## [1] '0.1.0'

### Test Results

``` r
library(hping)
library(testthat)

date()
```

    ## [1] "Thu Sep  1 10:21:10 2016"

``` r
extract_uptime(system.file("extdata", "sample.hping3.output.txt.gz", package="hping"))
```

    ## # A tibble: 33 × 5
    ##                 ip  days hours minutes seconds
    ##              <chr> <dbl> <dbl>   <dbl>   <dbl>
    ## 1      143.55.4.20    47     5      39       3
    ## 2     64.5.113.114    NA    NA      NA      NA
    ## 3    192.210.13.16    35    15      27      22
    ## 4     74.7.217.202    NA    NA      NA      NA
    ## 5     199.30.204.9     6     2      31       9
    ## 6     64.73.59.200    27     3      54      54
    ## 7   12.218.157.234     6     2      46      14
    ## 8    198.187.3.122    42    20      19      46
    ## 9  198.135.207.175     5    18      40      15
    ## 10   72.84.237.250    NA    NA      NA      NA
    ## # ... with 23 more rows

``` r
test_dir("tests/")
```

    ## testthat results ========================================================================================================
    ## OK: 2 SKIPPED: 0 FAILED: 0
    ## 
    ## DONE ===================================================================================================================
