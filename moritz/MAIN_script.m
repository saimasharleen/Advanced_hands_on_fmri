clear;
close all;

% Add CoSMoMVPA to the path
addpath(genpath(load_path('CoSMoMVPA')));

% Define paths
subs_fMRI = load_path('subs_fMRI');
ROIs = load_path('ROIs');
results_path = load_path('results_OVO_multiclass');
figures_path = load_path('figures');
workingDir = load_path('workingDir');

%% PART 1:
% Use a multiclass decoding approach to test whether the pattern of activity for the lookalike
% objects generalises to their corresponding animals;

multiclass_decoding('lookalike-animal', subs_fMRI, ROIs, results_path);

%% PART 2:
% Use a multiclass decoding approach to test whether the pattern of activity for the lookalike
% objects generalises to their corresponding objects;

multiclass_decoding('lookalike-object', subs_fMRI, ROIs, results_path);

% Bonus:
multiclass_decoding('animal-object', subs_fMRI, ROIs, results_path);

%% PART 3:
% Visualize the results for all three ROIs;

figure;
visualize_results('lookalike-animal', results_path, figures_path);
figure;
visualize_results('lookalike-object', results_path, figures_path);

% Bonus:
figure;
visualize_results('animal-object', results_path, figures_path);

%% PART 4:
% Statistical analysis for all three ROIs;
% one-tailed one sample t test

test_significance(0.05, 'lookalike-animal', results_path, true, workingDir);
test_significance(0.001, 'lookalike-object', results_path, true, workingDir);

% Bonus:
test_significance(0.001, 'animal-object', results_path, false, workingDir);