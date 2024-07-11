% process_brain_data.m

function [dsm_all, dsm_mat_all] = process_brain_data(subjects, nConditions, nRuns, brain_data, ROI)
    numSubjs = length(subjects);
    resROIs = length(ROI);

    for s = 1:numSubjs
        data_path = fullfile([brain_data.study_path, subjects{s}]);
        mask_fn = brain_data.mask_path;
        data_fn = fullfile(data_path, 'SPM.mat');

        % Create dataset structure with different ROI masks
        ds = cosmo_fmri_dataset(data_fn, 'mask', mask_fn);
        ds = cosmo_remove_useless_data(ds);

        % Define targets and chunks
        targets = repmat((1:nConditions)', nRuns, 1);
        chunks = reshape(repmat((1:nRuns), nConditions, 1), [], 1);

        % Assign targets and chunks to ds.sa
        ds.sa.targets = targets;
        ds.sa.chunks = chunks;

        % Simple sanity check to ensure all attributes are set properly
        cosmo_check_dataset(ds);

        % Compute average across runs
        f_ds = cosmo_fx(ds, @(x) mean(x, 1), 'targets');

        % Compute RDM
        ds_dsm = cosmo_dissimilarity_matrix_measure(f_ds, 'metric', 'correlation', 'center_data', true);
        [samples, labels, values] = cosmo_unflatten(ds_dsm, 1, 'set_missing_to', NaN);

        % Store results
        temp_dsm = ds_dsm.samples;
        dsm_all(:, s) = temp_dsm;

        temp_dsm_mat = samples;
        dsm_mat_all(:, :, s) = temp_dsm_mat;

        % Save RDM
        RDM = struct;
        RDM.data = ds_dsm.samples;
        RDM.labels = ds.sa.targets;
        RDM.subject = subjects{s};
        RDM.ROI = ROI;

        save_filename = fullfile(brain_data.results_path, sprintf('RDM_%s.mat', subjects{s}));
        save(save_filename, 'RDM');
    end
end