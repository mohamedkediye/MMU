classdef myknn
    methods(Static)
        
        % the fit function creates a model structure specified as M.
        % The fit function takes a copy of the training example and passes
        % it through the function
        
        function m = fit(train_examples, train_labels, k)
             
            
            
            % start of standardisation process
            %the first step of traning is the standardisation 
            %the standarsation process rescales the features within the training data.
            %the M stores all the data of the classifier
			m.mean = mean(train_examples{:,:}); % classifier of the mean
			m.std = std(train_examples{:,:}); % this is the classifier of the standard
            for i=1:size(train_examples,1)
				train_examples{i,:} = train_examples{i,:} - m.mean;
                train_examples{i,:} = train_examples{i,:} ./ m.std;
            end
            % end of standardisation process
            
            
            % the fit function takes a copy of the training labels passes
            % it through 
            m.train_examples = train_examples;
            m.train_labels = train_labels;
            m.k = k;
        
        end
        
        
         % the prediction function executes the main stage involved in the prediction stage
        %the prediction function also calculates the distance between the
        %most recent example and the remaining examples within the training
        %data.
        % the predicition function also obtains numerous different testing
        % examples
        function predictions = predict(m, test_examples)

            predictions = categorical;
             %Start of the for loop
            for i=1:size(test_examples,1)
                
                fprintf('classifying example example %i/%i\n', i, size(test_examples,1));
                
                this_test_example = test_examples{i,:};
                
                % start of standardisation process
                this_test_example = this_test_example - m.mean;
                this_test_example = this_test_example ./ m.std;
                % end of standardisation process
                
                this_prediction = myknn.predict_one(m, this_test_example);
                predictions(end+1) = this_prediction;
            
            end
            % end of the for loop
        end
        
       
        function prediction = predict_one(m, this_test_example)
            
            distances = myknn.calculate_distances(m, this_test_example);
            neighbour_indices = myknn.find_nn_indices(m, distances);
            prediction = myknn.make_prediction(m, neighbour_indices);
        
        end %end of prediction stage
        
        
        %The calculate distances function loops through all of the training examples stored in the model.
        function distances = calculate_distances(m, this_test_example)
            
			distances = [];
            
			for i=1:size(m.train_examples,1)
                
				this_training_example = m.train_examples{i,:};
                this_distance = myknn.calculate_distance(this_training_example, this_test_example);
                distances(end+1) = this_distance;
            end
        
        end
        
       
        function distance = calculate_distance(p, q)
            
			differences = q - p;  % obtaining the diffrences between the q and p coordinates witha single subtraction
            squares = differences .^ 2;  % differnces are squared by using the caret(^) symbol
            total = sum(squares);  % all of the numbers within the array to find the total sum by calling the sum() function
            distance = sqrt(total);  %  this line is square rooting the final resulting value in total using the sqrt() function in order to find the final answer
        
		end %end of distance function

        function neighbour_indices = find_nn_indices(m, distances)
            
			[sorted, indices] = sort(distances);
            neighbour_indices = indices(1:m.k);
        
        end % end of neighbour indices
        
        % this will find the most common class label which are amongst the nearest neighbours 
        % and store it as our predicted class. 
        function prediction = make_prediction(m, neighbour_indices)

			neighbour_labels = m.train_labels(neighbour_indices);
            prediction = mode(neighbour_labels);
        
		end % end of prediction stage

    end
end

