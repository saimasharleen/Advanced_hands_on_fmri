function path = load_path(directory)

    % Define your paths here
    CoSMoMVPA = '/Volumes/Mac Online/CoSMoMVPA-master';
    finalProject = '/Volumes/Mac Online/final_project/';
    workingDir = '/Volumes/Mac Online/final_project/workingDir/';

    if strcmp(directory, 'CoSMoMVPA')
        path = CoSMoMVPA;
    elseif strcmp(directory, 'subs_fMRI')
        path = [finalProject 'Data/'];
    elseif strcmp(directory, 'ROIs')
        path = [finalProject 'ROI/'];
    elseif strcmp(directory, 'results_OVO_multiclass')
        path = [workingDir 'filesSaved/results_OVO_multiclass/'];
    elseif strcmp(directory, 'figures')
        path = [workingDir 'figures/'];
    elseif strcmp(directory, 'workingDir')
        path = workingDir;
    else
        error('Unknown directory: %s', directory);
    end

end