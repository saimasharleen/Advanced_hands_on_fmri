# Lookalike-Objects Dataset Analysis

This repository contains the analysis scripts for two assignments using the lookalike-objects dataset. The first assignment involves multiclass decoding to characterize the representational profiles of three ROIs. The second assignment employs Representational Similarity Analysis (RSA) to compare neural, behavioral, and DNN data.

## Assignment 1: Multiclass Decoding

### General Goal
Using the lookalike-objects dataset, characterize the representational profile of the inferotemporal regions (V1, VTC_post, and VTC_ant) with regard to specific animal and tool identities.

### Question
Do the activation patterns associated with the 9 lookalike objects generalize to their corresponding animal (e.g., whether cow-shaped mug is represented similarly to a real cow) and/or to their corresponding object identity (e.g., cow-shaped mug to the mug)?

### Tasks
1. Use a multiclass (9-way) decoding approach to test whether the patterns of activity for the lookalike objects generalize to their corresponding animals and/or objects (in all subjects, in the 3 ROIs).
2. Visualize the results for the 3 ROIs (bar plot with mean decoding accuracies, error bars with standard error of mean).
3. Summarize the results and statistics in a table (mean accuracies, t and p values).
4. Describe and interpret the results.

## Assignment 2: Representational Similarity Analysis (RSA)
### General Goal
Employ RSA to describe similarities/differences of representational spaces in different data types (neural data, behavioural ratings, and deep neural networks).
### Question
Does the representational space for each data type reflect object visual appearance (appearance model) or object animacy properties (animacy model)?
### Tasks
• Use RSA to test how well the two models (appearance and animacy) explain the representational space in three data types:
brain data: 1 ROI (V1, post VTC, ant VTC)
behavioural data (single subject ratings: “SimJudgments” mat file) DNNs (Alexnet all layers)*
• Visualize the results for the 3 data types (RSA results and models)
• Summarize the results and statistics (you can also add a table to give an overview)
• Results section (describe rationale for the analyse and report results)
• General discussion of results
• Upload scripts can you make this GitHub readme code. Make it easier to understand and make it GitHub standard
