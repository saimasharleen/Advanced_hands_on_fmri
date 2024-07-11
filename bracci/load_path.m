% load_data.m

function [behavioral_data, brain_data, subjects, nConditions, nRuns, ROI] = load_data()
    % Load behavioral data
    load('/Volumes/Mac Online/final_project/models/SimJudgments.mat', 'SimJudgments');
    behavioral_data = SimJudgments;

    % Define subjects and other parameters
    subjects = {'SUB01','SUB02','SUB03','SUB04','SUB05','SUB06','SUB07','SUB08','SUB09','SUB10','SUB11','SUB12'};
    nConditions = 27;
    nRuns = 12;
    ROI = {'VTC_ant'};  % Specify the ROI to use
    
    % Load brain data paths
    study_path = fullfile('/Volumes/Mac Online/final_project/Data/');
    mask_path = fullfile('/Volumes/Mac Online/final_project/ROI/VTC_ant.nii');
    brain_data.study_path = study_path;
    brain_data.mask_path = mask_path;
    brain_data.results_path = fullfile('/Volumes/Mac Online/final_project/workingDir/filesSaved/results_OVO_multiclass/');
end