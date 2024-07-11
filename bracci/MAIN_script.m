% main_script.m

% Add the path where the scripts are located
addpath('/Volumes/Mac Online/final_project/scripts');

% Load the data
[behavioral_data, brain_data, subjects, nConditions, nRuns, ROI] = load_data();

% Process brain data
[dsm_all, dsm_mat_all] = process_brain_data(subjects, nConditions, nRuns, brain_data, ROI);

% Process DNN data
process_dnn_data();

% Prepare models (animacy and appearance)
prepare_models();

% Perform RSA analysis
rsa_analysis();