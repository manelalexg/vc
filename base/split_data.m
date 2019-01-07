function [ train,test ] = split_data( eye, noneye )
%split_data Separate two classes data between train and test datasets

    all_data = [eye; noneye];
    %all_data %table 2000
    shuffled_data = all_data(randperm(height(all_data)),:); %tenemos combinados los ojos y los no ojos
    %shuffled_data
    
    train_proportion = 0.6;
    mid_idx = floor(train_proportion*height(all_data)); %1200 for train
    %mid_idx
    
    %split data
    train = shuffled_data(1:mid_idx, :);
    test = shuffled_data(mid_idx+1:end, :);
end

