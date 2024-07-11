% prepare_models.m

function prepare_models()
    % Load animacy and appearance models
    load('/Volumes/Mac Online/final_project/models/mod.mat');
    appearance = models.data_dissimilarity(:, :, 1);
    animacy = models.data_dissimilarity(:, :, 2);

    % Prepare the models
    lower_appearance_vec = prepare_model_vector(appearance);
    lower_animacy_vec = prepare_model_vector(animacy);

    % Save models
    save('/Volumes/Mac Online/final_project/models/lower_appearance_vector.mat', 'lower_appearance_vec');
    save('/Volumes/Mac Online/final_project/models/lower_animacy_vector.mat', 'lower_animacy_vec');
end

function lower_vec = prepare_model_vector(model)
    lower = NaN(size(model));
    for i = 1:size(model, 1)
        for j = 1:i-1
            lower(i, j) = model(i, j);
        end
    end
    lower_vec = lower(~isnan(lower));
end