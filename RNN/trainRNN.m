function [nn, MSE, nodes] = trainRNN(dataset, nn)
% trainNN  train neural network
% IMPORTANT: input and output are actually transposed version of dataPer!!!!
MSE = zeros(1, nn.option.maxIter);
if nn.mode == 1 %Jordan-like RNN
    for ii = 1:nn.option.maxIter
        disp('Iteration: ')
        disp(ii)
        for jj = 1:length(dataset)
            % Fetch data
            input = dataset{jj}{1}';
            output = dataset{jj}{2}';
            
            % Feed-forward Through Time
            nodes = nnFFTT(input, nn);
            
            % Back-propagation Through Time
            nn = nnBPTT(output, nodes, nn);
            
            % Get an error in current iteration.
            result = zeros(size(output));
            for kk = 1:size(nodes,1)
                result(kk,:) = nodes{kk,end}(1:2);
            end
            
            MSE(ii) = MSE(ii) + sum((result(:)-output(:)).^2)/size(output,1);
        end
        
        MSE(ii) = MSE(ii)/length(dataset);
        disp('MSE: ')
        disp(MSE(ii))
    end
else if nn.mode == 2 %Jordan RNN
        
       % ���� ��Ʈ�p �����ſ���
        
    end
end