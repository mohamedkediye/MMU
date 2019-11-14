classdef mynb
    methods(Static)
        
        %The fit() function is responsible for executing all the steps involved in training.
        %Estimate a probability density for the distribution of each feature within each class
        %Estimate a prior probability for each class based on how many times the class label occurs in the training data 
        function m = fit(train_examples, train_labels)
            
            % the fit() function calls the unique() function in order finds each of the different possible class labels 
            % the fit() function calls the length() function in order to to find out how many classes there are in total
            m.unique_classes = unique(train_labels);
            m.n_classes = length(m.unique_classes);

            m.means = {};
            m.stds = {};
            
            %Start of the for loop
            for i = 1:m.n_classes
            
				this_class = m.unique_classes(i); % this_class variable
                examples_from_this_class = train_examples{train_labels==this_class,:}; % -----find all the examples from this same class
                m.means{end+1} = mean(examples_from_this_class);
                m.stds{end+1} = std(examples_from_this_class);
                
            %end of for loop
			end
            
            m.priors = [];
            %Start of the for loop
            for i = 1:m.n_classes
                
				this_class = m.unique_classes(i);
                examples_from_this_class = train_examples{train_labels==this_class,:};
                m.priors(end+1) = size(examples_from_this_class,1) / size(train_labels,1);
            %end of for loop
			end

        end
        
        %this function calculates the prediction/likelyhood this function,
        %will also loop over the possible class labels for test examples in
        %order to calculate the prediction.
        function predictions = predict(m, test_examples)

            predictions = categorical;
            
            for i=1:size(test_examples,1)%Start of the for loop

				fprintf('classifying example %i/%i\n', i, size(test_examples,1));
                this_test_example = test_examples{i,:};
                this_prediction = mynb.predict_one(m, this_test_example);
                predictions(end+1) = this_prediction;
             %end of for loop
			end
        end
        
        %prediction function loop through all of the test examples in the table and call the predict_one() function on each one.
        function prediction = predict_one(m, this_test_example)
            %Start of the for loop
            for i=1:m.n_classes

				this_likelihood = mynb.calculate_likelihood(m, this_test_example, i);
                this_prior = mynb.get_prior(m, i);
                posterior_(i) = this_likelihood * this_prior;
             %end of for loop
			end

            [winning_value_, winning_index] = max(posterior_);
            prediction = m.unique_classes(winning_index);

        end
        %he predict_one() function loops over all the possible class labels and, for each one, calculates a likelihood for the current test example given the class.
        %It does this by calling the calculate_likelihood() function to
        %find the likelyhood of the test examples.
        %The calculate_likelihood() function works by considering the value of every feature in the current test example, in isolation.
        function likelihood = calculate_likelihood(m, this_test_example, class)
            
			likelihood = 1;
            %Start of the for loop
			for i=1:length(this_test_example)
                likelihood = likelihood * mynb.calculate_pd(this_test_example(i), m.means{class}(i), m.stds{class}(i));
            %end of for loop
            end
        end
        
        %The function get_prior() is used to fetch the prior for the
        %current class. it's purpose is reading the probability from the model structure.
        %The prior for any class is calculated as the number of training examples belonging to that class divided by the total number of training examples.
        function prior = get_prior(m, class)
            
			prior = m.priors(class);
        
		end
        
        function pd = calculate_pd(x, mu, sigma)
        
			first_bit = 1 / sqrt(2*pi*sigma^2);
            second_bit = - ( ((x-mu)^2) / (2*sigma^2) );
            pd = first_bit * exp(second_bit);
        
		end
            
    end
end