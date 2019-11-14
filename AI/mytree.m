classdef mytree
    methods(Static)
        % the fit function will train the decision tree
        % the fit() function also clarifies a re-usable structure in order to
        % characteris individual nodes in the decision tree
        function m = fit(train_examples, train_labels)
            
			emptyNode.number = []; % this node represents the unique number of nodes within the decision tree format this is used to individualize the training data
            emptyNode.examples = []; % this node any training examples associated labels the node holds
            emptyNode.labels = []; % this node holds any associated labels 
            emptyNode.prediction = []; %this node makes a prediction based on any class labels that the node holds
            emptyNode.impurityMeasure = [];  %this node is a numeric measure of the impurity of any class labels held by a node which is used to decide whether to split it
            emptyNode.children = {}; % this node  is used to split a node if a decision has been made then it will store two child nodes and divide its training data between them
            %these nodes are used to define the split by name and number of
            %its column
            emptyNode.splitFeature = [];
            emptyNode.splitFeatureName = [];
            emptyNode.splitValue = [];

            m.emptyNode = emptyNode;
            
            % The fit() function copies the emptyNode structure in order to create a root node
            r = emptyNode; % node
            r.number = 1; % root number
            r.labels = train_labels; % root labels. this is used to copy over all the training labels
            r.examples = train_examples; %root examples. this is used to copy over all the training examples
            r.prediction = mode(r.labels); % root prediciton. this is used to generate a single class label predictionfor the node used to classify new data if it isn't possible to further split the root node.

            %the fit() function sets up model parameters
            m.min_parent_size = 10; % minimum parent size parameter for a branch node. this is used to to see if it containes the minimum amount of example nodes (10) before it is considered before splitting
            m.unique_classes = unique(r.labels); %list of the unique class labels froom the root label node to see the uniqueness of the training data 
            m.feature_names = train_examples.Properties.VariableNames; %the list of the names of the individual features within each example which materialises from copying the names of the table columns
			m.nodes = 1;  %current number of nodes in the tree starting from the number 1
            m.N = size(train_examples,1); %total number of training examples used to train the model

            m.tree = mytree.trySplit(m, r);

        end
        % fit() function generates the tree by passing the root node to the
        % trySplit() function.
        % the trySplit() function tests to see if a node can be split into two child nodes with a reduced overall impurity within their seperate class labels.
        function node = trySplit(m, node)
            %if loop. this node is used to make the function repeat and it
            %will call its self again passing through any child nodes that
            %it creates.
            % The function will only return once it's no longer possible to
            % split anymore nodes in the tree. the reason for this is
            % because they might not contain enough training examples to become a parent node. another reason is because no split is available which will reduce the overall impurity inside the class labels.
            if size(node.examples, 1) < m.min_parent_size
				return
            end %end of if.
            
            % trySplit() function calculates a measure of the current impurity within the node class labels by calling weightedImpurity(). 
            node.impurityMeasure = mytree.weightedImpurity(m, node.labels);
            %trySplit() function does is to look at each of the possible ways to split the training data in the current node. It considers splitting on every feature 
            for i=1:size(node.examples,2)
                %output
				fprintf('evaluating possible splits on feature %d/%d\n', i, size(node.examples,2));
                
				[ps,n] = sortrows(node.examples,i);
                ls = node.labels(n);
                biggest_reduction(i) = -Inf;
                biggest_reduction_index(i) = -1;
                biggest_reduction_value(i) = NaN;
                for j=1:(size(ps,1)-1) %nested loop
                    if ps{j,i} == ps{j+1,i}
                        continue;
                    end
                    
                    this_reduction = node.impurityMeasure - (mytree.weightedImpurity(m, ls(1:j)) + mytree.weightedImpurity(m, ls((j+1):end)));
                    
                    if this_reduction > biggest_reduction(i)
                        biggest_reduction(i) = this_reduction;
                        biggest_reduction_index(i) = j;
                    end
                end
				
            end

            [winning_reduction,winning_feature] = max(biggest_reduction);
            winning_index = biggest_reduction_index(winning_feature);

            if winning_reduction <= 0
                return
            else

                [ps,n] = sortrows(node.examples,winning_feature);
                ls = node.labels(n);

                node.splitFeature = winning_feature;
                node.splitFeatureName = m.feature_names{winning_feature};
                node.splitValue = (ps{winning_index,winning_feature} + ps{winning_index+1,winning_feature}) / 2;

                node.examples = [];
                node.labels = []; 
                node.prediction = [];
              
                node.children{1} = m.emptyNode;
                 %unique number for the node within the overall tree will
                %help keep track of all the nodes.
                m.nodes = m.nodes + 1; 
                node.children{1}.number = m.nodes;
                node.children{1}.examples = ps(1:winning_index,:); 
                node.children{1}.labels = ls(1:winning_index);
                node.children{1}.prediction = mode(node.children{1}.labels);
                
                %the second child will represent the remaining rows from
                %the parent training table
                node.children{2} = m.emptyNode;
                m.nodes = m.nodes + 1; 
                node.children{2}.number = m.nodes;
                node.children{2}.examples = ps((winning_index+1):end,:); 
                node.children{2}.labels = ls((winning_index+1):end);
                % the class labels that would be predicted from this node
                % during  future prediction stage based on the most common
                % class label
                node.children{2}.prediction = mode(node.children{2}.labels);
                
                %check to see if either the new children nodes could be
                %slip again to further reduce the overall impurity across
                %class labels.
                node.children{1} = mytree.trySplit(m, node.children{1});
                node.children{2} = mytree.trySplit(m, node.children{2});
            end

        end
        
        function e = weightedImpurity(m, labels)

            weight = length(labels) / m.N;

            summ = 0;
            obsInThisNode = length(labels);
            for i=1:length(m.unique_classes) %for loop
                
				pi = length(labels(labels==m.unique_classes(i))) / obsInThisNode;
                summ = summ + (pi*pi);
            
            end %end of loop
            g = 1 - summ;
            
            e = weight * g;

        end

        function predictions = predict(m, test_examples)

            predictions = categorical;
            
            for i=1:size(test_examples,1)
                
				fprintf('classifying example %i/%i\n', i, size(test_examples,1));
                this_test_example = test_examples{i,:};
                this_prediction = mytree.predict_one(m, this_test_example);
                predictions(end+1) = this_prediction;
            
			end
        end
        %The predict() function loops through all of the test examples in the table and call the predict_one() function on each one.
        %node's class prediction is returned
        function prediction = predict_one(m, this_test_example)
            
			node = mytree.descend_tree(m.tree, this_test_example);
            prediction = node.prediction;
        
		end
        
        function node = descend_tree(node, this_test_example)
            
			if isempty(node.children)
                return;
            else
                if this_test_example(node.splitFeature) < node.splitValue
                    node = mytree.descend_tree(node.children{1}, this_test_example);
                else
                    node = mytree.descend_tree(node.children{2}, this_test_example);
                end
            end
        
		end
        
        % describe a tree:
        function describeNode(node)
            %Once the "winning" leaf node has been returned to
            %predict_one() it extracts the contents of its prediction field and returns it.
            %prediction field comes from the mode (most common) class label in the data the node stores. 
			if isempty(node.children)
                fprintf('Node %d; %s\n', node.number, node.prediction);
            else
                fprintf('Node %d; if %s <= %f then node %d else node %d\n', node.number, node.splitFeatureName, node.splitValue, node.children{1}.number, node.children{2}.number);
                mytree.describeNode(node.children{1});
                mytree.describeNode(node.children{2});        
            end
        
		end
		
    end
end