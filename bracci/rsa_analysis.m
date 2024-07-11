% rsa_analysis.m

function rsa_analysis()
    % Load data
    load('/Volumes/Mac Online/final_project/models/lower_appearance_vector.mat', 'lower_appearance_vec');
    load('/Volumes/Mac Online/final_project/models/lower_animacy_vector.mat', 'lower_animacy_vec');
    load('/Volumes/Mac Online/final_project/models/SimJudgments.mat', 'SimJudgments');

    % Prepare behavioral data
    prepare_behavioral_data(SimJudgments);

    % RSA for neural data
    rsa_neural_data(lower_appearance_vec, lower_animacy_vec);

    % RSA for behavioral data
    rsa_behavioral_data(lower_appearance_vec, lower_animacy_vec);

    % RSA for DNN layers
    rsa_dnn_layers(lower_appearance_vec, lower_animacy_vec);
end

function prepare_behavioral_data(SimJudgments)
    for s = 1:12
        dissimilarity_matrix = SimJudgments(:, :, s);
        lower = nan(size(dissimilarity_matrix));
        for row = 1:size(dissimilarity_matrix, 1)
            for col = 1:row-1
                lower(row, col) = dissimilarity_matrix(row, col);
            end
        end
        lower_vector = lower(~isnan(lower));
        file_path = sprintf('/Volumes/Mac Online/final_project/models/behavioralData_vector_subject_%d.mat', s);
        save(file_path, 'lower_vector');
    end
end

function rsa_neural_data(lower_appearance_vec, lower_animacy_vec)
    for s = 1:12
        fileName = fullfile('/Volumes/Mac Online/final_project/workingDir/filesSaved/results_OVO_multiclass/', sprintf('RDM_SUB%02d.mat', s));
        load(fileName, 'RDM');
        neural_vect = RDM.data;
        all_neural_vect(s, :) = neural_vect;

        % Correlation with animacy model
        tempRSA_corr_animacy_neural = corr(neural_vect(:), lower_animacy_vec, 'Type', 'Pearson');
        RSA_corr_animacy_neural(s) = tempRSA_corr_animacy_neural;

        % Partial correlation
        [tempRSA_parcorr_animacy, p_animacy_neural] = partialcorri(neural_vect(:), lower_animacy_vec, 'Type', 'Pearson');
        RSA_parcorr_animacy(s) = tempRSA_parcorr_animacy;
        p_values_animacy_neural(s) = p_animacy_neural;

        % Fisher transformation
        fisher_tempRSA_parcorr_animacy = atanh(tempRSA_parcorr_animacy);
        RSA_fisher_parcorr_animacy(s) = fisher_tempRSA_parcorr_animacy;
    end

    % Calculate mean and SEM
    meanRSA_animacy_neuraldata = mean(RSA_fisher_parcorr_animacy);
    semRSA_animacy_neuraldata = std(RSA_fisher_parcorr_animacy) / sqrt(12);

    % Plot results
    figure;
    bar(meanRSA_animacy_neuraldata, 'FaceColor', [0.2 0.2 0.5]);
    hold on;
    errorbar(meanRSA_animacy_neuraldata, semRSA_animacy_neuraldata, 'k', 'linestyle', 'none', 'LineWidth', 2);
    set(gca, 'XTickLabel', {'Animacy Model'}, 'XTick', 1);
    ylabel('RSA Correlation');
    title('RSA between Neural Data and Animacy Model');
    ylim([0 1]);
    hold off;
end

function rsa_behavioral_data(lower_appearance_vec, lower_animacy_vec)
    for s = 1:12
        fileName = fullfile('/Volumes/Mac Online/final_project/models/', sprintf('behavioralData_vector_subject_%d.mat', s));
        load(fileName, 'lower_vector');
        behavioral_vect = lower_vector;
        all_behavioral_vect(s, :) = behavioral_vect;

        % Correlation with animacy model
        tempRSA_corr_animacy_behavioral = corr(behavioral_vect, lower_animacy_vec, 'Type', 'Pearson');
        RSA_corr_animacy_behavioral(s) = tempRSA_corr_animacy_behavioral;

        % Partial correlation
        [tempRSA_parcorr_animacy_behavioral, p_animacy_behavioral] = partialcorri(behavioral_vect, lower_animacy_vec, 'Type', 'Pearson');
        RSA_parcorr_animacy_behavioral(s) = tempRSA_parcorr_animacy_behavioral;
        p_values_animacy_behavioral(s) = p_animacy_behavioral;

        % Fisher transformation
        fisher_tempRSA_parcorr_animacy_behavioral = atanh(tempRSA_parcorr_animacy_behavioral);
        RSA_fisher_parcorr_animacy_behavioral(s) = fisher_tempRSA_parcorr_animacy_behavioral;
    end

    % Calculate mean and SEM
    meanRSA_animacy_behavioral = mean(RSA_fisher_parcorr_animacy_behavioral);
    semRSA_animacy_behavioral = std(RSA_fisher_parcorr_animacy_behavioral) / sqrt(12);

    % Plot results
    figure;
    bar(meanRSA_animacy_behavioral, 'FaceColor', [0.2 0.2 0.5]);
    hold on;
    errorbar(meanRSA_animacy_behavioral, semRSA_animacy_behavioral, 'k', 'linestyle', 'none', 'LineWidth', 2);
    set(gca, 'XTickLabel', {'Animacy Model'}, 'XTick', 1);
    ylabel('RSA Correlation');
    title('RSA between Behavioral Data and Animacy Model');
    ylim([0 1]);
    hold off;
end

function rsa_dnn_layers(lower_appearance_vec, lower_animacy_vec)
    for i = 1:8
        fileName = fullfile('/Volumes/Mac Online/final_project/models/', sprintf('alexnet_layer%d_vect.mat', i));
        load(fileName, 'dissimilarity');

        % Correlation with animacy model
        [rsaResults(i), p_value_animacy_DNN(i)] = partialcorri(dissimilarity, lower_animacy_vec, 'Type', 'Pearson', 'Rows', 'complete');
        p_values_animacy_DNN(i) = p_value_animacy_DNN(i);

        % Fisher transformation
        fisher_tempRSA_parcorr_animacy_DNN = atanh(rsaResults(i));
        RSA_fisher_parcorr_animacy_DNN(i) = fisher_tempRSA_parcorr_animacy_DNN;
    end

    meanRSA_animacy_DNN = mean(RSA_fisher_parcorr_animacy_DNN);
    semRSA_animacy_DNN = std(RSA_fisher_parcorr_animacy_DNN) / sqrt(8);

    % Plot results
    figure;
    bar(meanRSA_animacy_DNN, 'FaceColor', [0.2 0.2 0.5]);
    hold on;
    errorbar(meanRSA_animacy_DNN, semRSA_animacy_DNN, 'k', 'linestyle', 'none', 'LineWidth', 2);
    set(gca, 'XTickLabel', {'Animacy Model'}, 'XTick', 1);
    ylabel('RSA Correlation');
    title('RSA between DNN and Animacy Model');
    ylim([0 1]);
    hold off;
end