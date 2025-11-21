# **[Process Capability Analysis Cp, Cpk, Pp, Ppk - A Guide](https://www.1factory.com/quality-academy/guide-process-capability.html)**

**[Python Process Capability Analysis (Cp & Cpk) | Normal Data](https://www.youtube.com/watch?v=YLn3YaMs4CQ)**

**[Python programs in process capability Cp, Cpk, PPM, sigma level](https://www.youtube.com/watch?v=-HFs7Sd73o4)**

## 01. What is Process Capability Analysis?

A process capability study uses data from an initial run of parts to predict whether a manufacturing process can repeatably produce parts that meet specifications.

Think of it as being similar to a forecast. You will take some historical data, and extrapolate out to the future to answer the question "can I rely on this process to deliver good parts?".

Your customers may require a process capability study as part of a PPAP. They will do this to ensure that your manufacturing processes are capable of consistently producing good parts.

PPAP most commonly refers to the Production Part Approval Process, a standardized system in the automotive and aerospace industries for verifying that a supplier can consistently produce parts that meet all customer specifications.

![i](https://www.1factory.com/assets/img/the-objective-of-process-capability-analysis-1factory.png)

## 02. The Basic Concept

When the manufacturing process is being defined, your goal is to ensure that the parts produced fall within the Upper and Lower Specification Limits (USL, LSL). Process Capability measures how consistently a manufacturing process can produce parts within specifications.

The basic idea is very simple. You want your manufacturing process to:

- (1) be centered over the Nominal desired by the design engineer, and
- (2) with a spread narrower than the specification width.

**Cp** measures whether the process spread is narrower than the specification width

**Cpk** measures both the centering of the process as well as the spread of the process relative to the specification width

![i](https://www.1factory.com/assets/img/visual-cp-cpk-1factory.png)

## 03. The Basic Calculations

Before we get into the detailed statistical calculations, let's review the high-level steps:

**1: Plot the Data:** Record the measurement data, and plot this data on a run-chart and on a histogram as shown in the picture on the right.

**2: Calculate the Spec Width:** Plot the Upper Spec Limit (USL) and Lower Spec Limit (LSL) on the histogram, and calculate the Spec Width as shown below.

Spec Width = USL — LSL

3: Calculate the Process Width: Similarly, we will also calculate the Process Width. The simplest way to think about the process width is "the difference between the largest value and the smallest value this process could create".

Process Width = UCL — LCL

4: Calculate Cp: Calculate the capability index as the ratio of the spec width to the process width.

Cp = Spec Width / Process Width

![i](https://www.1factory.com/assets/img/plot-the-data-histogram-run-chart-1factory.png)
