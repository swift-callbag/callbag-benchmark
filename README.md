<h1 style="font-size: 4em;">Callbag<i>Benchmark</i> ⏱️</h1>

> The following results were ran on a linux machine with `Intel Core i7 CPU 3.7GHz`,
> and `Swift 5.0`. These are **micro**benchmarks, except for the `dataflow` benchmark
> which more realistically reflects an application with streams.

## Performance results

<table>
  <thead>
    <tr>
      <td style="text-align: center" colspan="5"><a href="./Sources/main/DataFlow.swift">DataFlow</a></td>
    </tr>
    <tr>
      <td rowspan="2"><strong>library</strong></td>
      <td style="text-align: center" colspan="2"><strong>Cold - Observable</strong></td>
      <td style="text-align: center" colspan="2"><strong>Hot - Observable</strong></td>
    </tr>
    <tr>
      <td><strong>time</strong></td>
      <td><strong>std</strong></td>
      <td><strong>time</strong></td>
      <td><strong>std</strong></td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Callbag</b>Kit</td>
      <td style="text-align: right">7.929 secs</td>
      <td>±   0.27 %</td>
      <td style="text-align: right">14.784 secs</td>
      <td>±   0.25 %</td>
    </tr>
    <tr>
      <td><b>Reactive</b>Swift</td>
      <td style="text-align: right">10.143 secs</td>
      <td>±   0.21 %</td>
      <td style="text-align: right">15.816 secs</td>
      <td>±   0.18 %</td>
    </tr>
    <tr>
      <td><b>Rx</b>Swift</td>
      <td style="text-align: right">50.330 secs</td>
      <td>±   0.09 %</td>
      <td style="text-align: right">29.014 secs</td>
      <td>±   0.14 %</td>
    </tr>
  </tbody>
</table>
<br>

<table>
  <thead>
    <tr>
      <td style="text-align: center" colspan="5"><a href="./Sources/main/Fold.swift">Fold</a></td>
    </tr>
    <tr>
      <td rowspan="2"><strong>library</strong></td>
      <td style="text-align: center" colspan="2"><strong>Cold - Observable</strong></td>
      <td style="text-align: center" colspan="2"><strong>Hot - Observable</strong></td>
    </tr>
    <tr>
      <td><strong>time</strong></td>
      <td><strong>std</strong></td>
      <td><strong>time</strong></td>
      <td><strong>std</strong></td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Callbag</b>Kit</td>
      <td style="text-align: right">1.302 secs</td>
      <td>±   0.27 %</td>
      <td style="text-align: right">1.922 secs</td>
      <td>±   0.23 %</td>
    </tr>
    <tr>
      <td><b>Reactive</b>Swift</td>
      <td style="text-align: right">1.306 secs</td>
      <td>±   0.21 %</td>
      <td style="text-align: right">3.231 secs</td>
      <td>±   0.45 %</td>
    </tr>
    <tr>
      <td><b>Rx</b>Swift</td>
      <td style="text-align: right">22.424 secs</td>
      <td>±   0.11 %</td>
      <td style="text-align: right">7.963 secs</td>
      <td>±   0.13 %</td>
    </tr>
  </tbody>
</table>
<br>

<table>
  <thead>
    <tr>
      <td style="text-align: center" colspan="5"><a href="./Sources/main/FilterMapReduce.swift">FilterMapReduce</a></td>
    </tr>
    <tr>
      <td rowspan="2"><strong>library</strong></td>
      <td style="text-align: center" colspan="2"><strong>Cold - Observable</strong></td>
      <td style="text-align: center" colspan="2"><strong>Hot - Observable</strong></td>
    </tr>
    <tr>
      <td><strong>time</strong></td>
      <td><strong>std</strong></td>
      <td><strong>time</strong></td>
      <td><strong>std</strong></td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Callbag</b>Kit</td>
      <td style="text-align: right">1.088 secs</td>
      <td>±   0.41 %</td>
      <td style="text-align: right">1.854 secs</td>
      <td>±   0.95 %</td>
    </tr>
    <tr>
      <td><b>Reactive</b>Swift</td>
      <td style="text-align: right">1.083 secs</td>
      <td>±   0.51 %</td>
      <td style="text-align: right">2.697 secs</td>
      <td>±   0.23 %</td>
    </tr>
    <tr>
      <td><b>Rx</b>Swift</td>
      <td style="text-align: right">20.699 secs</td>
      <td>±   0.10 %</td>
      <td style="text-align: right">6.192 secs</td>
      <td>±   0.08 %</td>
    </tr>
  </tbody>
</table>
<br>

<table>
  <thead>
    <tr>
      <td style="text-align: center" colspan="5"><a href="./Sources/main/FilterMapFusion.swift">FilterMapFusion</a></td>
    </tr>
    <tr>
      <td rowspan="2"><strong>library</strong></td>
      <td style="text-align: center" colspan="2"><strong>Cold - Observable</strong></td>
      <td style="text-align: center" colspan="2"><strong>Hot - Observable</strong></td>
    </tr>
    <tr>
      <td><strong>time</strong></td>
      <td><strong>std</strong></td>
      <td><strong>time</strong></td>
      <td><strong>std</strong></td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Callbag</b>Kit</td>
      <td style="text-align: right">1.797 secs</td>
      <td>±   0.16 %</td>
      <td style="text-align: right">2.574 secs</td>
      <td>±   0.21 %</td>
    </tr>
    <tr>
      <td><b>Reactive</b>Swift</td>
      <td style="text-align: right">1.196 secs</td>
      <td>±   0.37 %</td>
      <td style="text-align: right">3.706 secs</td>
      <td>±   0.35 %</td>
    </tr>
    <tr>
      <td><b>Rx</b>Swift</td>
      <td style="text-align: right">21.458 secs</td>
      <td>±   0.08 %</td>
      <td style="text-align: right">7.130 secs</td>
      <td>±   0.11 %</td>
    </tr>
  </tbody>
</table>
<br>

<table>
  <thead>
    <tr>
      <td style="text-align: center" colspan="5"><a href="./Sources/main/Combine.swift">Combine</a></td>
    </tr>
    <tr>
      <td rowspan="2"><strong>library</strong></td>
      <td style="text-align: center" colspan="2"><strong>Cold - Observable</strong></td>
      <td style="text-align: center" colspan="2"><strong>Hot - Observable</strong></td>
    </tr>
    <tr>
      <td><strong>time</strong></td>
      <td><strong>std</strong></td>
      <td><strong>time</strong></td>
      <td><strong>std</strong></td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Callbag</b>Kit</td>
      <td style="text-align: right">6.091 secs</td>
      <td>±   0.14 %</td>
      <td style="text-align: right">1.496 secs</td>
      <td>±   0.33 %</td>
    </tr>
    <tr>
      <td><b>Reactive</b>Swift</td>
      <td style="text-align: right">8.020 secs</td>
      <td>±   0.16 %</td>
      <td style="text-align: right">10.048 secs</td>
      <td>±   0.18 %</td>
    </tr>
    <tr>
      <td><b>Rx</b>Swift</td>
      <td style="text-align: right">50.308 secs</td>
      <td>±   0.06 %</td>
      <td style="text-align: right">19.731 secs</td>
      <td>±   0.09 %</td>
    </tr>
  </tbody>
</table>
<br>

<table>
  <thead>
    <tr>
      <td style="text-align: center" colspan="5"><a href="./Sources/main/Zip.swift">Zip</a></td>
    </tr>
    <tr>
      <td rowspan="2"><strong>library</strong></td>
      <td style="text-align: center" colspan="2"><strong>Cold - Observable</strong></td>
      <td style="text-align: center" colspan="2"><strong>Hot - Observable</strong></td>
    </tr>
    <tr>
      <td><strong>time</strong></td>
      <td><strong>std</strong></td>
      <td><strong>time</strong></td>
      <td><strong>std</strong></td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Callbag</b>Kit</td>
      <td style="text-align: right">7.659 secs</td>
      <td>±   0.23 %</td>
      <td style="text-align: right">9.173 secs</td>
      <td>±   0.16 %</td>
    </tr>
    <tr>
      <td><b>Reactive</b>Swift</td>
      <td style="text-align: right">1235.180 secs</td>
      <td>±   0.08 %</td>
      <td style="text-align: right">9.578 secs</td>
      <td>±   0.15 %</td>
    </tr>
    <tr>
      <td><b>Rx</b>Swift</td>
      <td style="text-align: right">42.935 secs</td>
      <td>±   0.24 %</td>
      <td style="text-align: right">13.068 secs</td>
      <td>±   0.26 %</td>
    </tr>
  </tbody>
</table>
<br>

<table>
  <thead>
    <tr>
      <td style="text-align: center" colspan="5"><a href="./Sources/main/Merge.swift">Merge</a></td>
    </tr>
    <tr>
      <td rowspan="2"><strong>library</strong></td>
      <td style="text-align: center" colspan="2"><strong>Cold - Observable</strong></td>
      <td style="text-align: center" colspan="2"><strong>Hot - Observable</strong></td>
    </tr>
    <tr>
      <td><strong>time</strong></td>
      <td><strong>std</strong></td>
      <td><strong>time</strong></td>
      <td><strong>std</strong></td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>Callbag</b>Kit</td>
      <td style="text-align: right">3.964 secs</td>
      <td>±   0.20 %</td>
      <td style="text-align: right">5.672 secs</td>
      <td>±   0.29 %</td>
    </tr>
    <tr>
      <td><b>Reactive</b>Swift</td>
      <td style="text-align: right">6.910 secs</td>
      <td>±   0.08 %</td>
      <td style="text-align: right">9.429 secs</td>
      <td>±   0.63 %</td>
    </tr>
    <tr>
      <td><b>Rx</b>Swift</td>
      <td style="text-align: right">46.241 secs</td>
      <td>±   0.23 %</td>
      <td style="text-align: right">16.621 secs</td>
      <td>±   0.06 %</td>
    </tr>
  </tbody>
</table>
<br>

