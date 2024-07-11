% process_dnn_data.m

function process_dnn_data()
    % Load data
    image_filepath = fullfile('/Volumes/Mac Online/final_project/stim');
    results_path1 = fullfile('/Volumes/Mac Online/final_project/models/');

    images = imageDatastore(image_filepath, 'LabelSource', 'foldernames');
    numImages = numel(images.Labels);
    idx = 1:numImages;

    % Display images
    figure(1)
    for i = 1:size(idx, 2)
        subplot(9, 6, i)
        I = readimage(images, idx(i));
        imshow(I)
    end

    % DNN
    dnn = {alexnet};
    dnnName = {'alexnet'};
    ndnn = length(dnn);

    for i = 1:ndnn
        net = dnn{i};

        % Analyze network architecture
        inputSize = net.Layers(1).InputSize;
        analyzeNetwork(net);

        % Extract Image Features
        augimageds = augmentedImageDatastore(inputSize(1:2), images);

        inx = [2, 6, 10, 12, 14, 17, 20, 23]';
        nlayer = length(inx);

        % Loop over the layers
        for l = 1:nlayer
            layer = net.Layers(inx(l)).Name;
            features = activations(net, augimageds, layer, 'OutputAs', 'rows');
            deepnn.layerSamples{l} = features;
            deepnn.layerName{l} = layer;
            deepnn.networkName = dnnName{i};
            deepnn.numStim = numImages;

            % Prepare dataset structure for CoSMoMVPA
            ds = struct();
            ds.samples = features;
            ds.sa.targets = (1:size(features, 1))';
            ds.sa.chunks = ones(size(features, 1), 1);

            % Calculate RDM using CoSMoMVPA
            cosmo_measure = @cosmo_dissimilarity_matrix_measure;
            rdm_result = cosmo_measure(ds);

            % Store RDM in vector form
            rdm_vector = rdm_result.samples;
            deepnn.layerRDM{l} = rdm_vector;

            % Save RDM
            dissimilarity = rdm_vector;
            rdm_name_file = fullfile(results_path1, sprintf('%s_layer%d_vect.mat', dnnName{i}, l));
            save(rdm_name_file, 'dissimilarity');
        end

        % Save the entire structure
        name_file = fullfile(results_path1, [dnnName{i}, '_features']);
        save(name_file, 'deepnn');
    end
end