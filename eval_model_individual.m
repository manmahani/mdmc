clc
clear
close all


% PLEASE SELECT THE EXPERIMENT HERE: 'VT' or 'VA'
exp_type = 'VA';
model_type = 'fn_mdmc'; % 'mdmc' or 'fn_mdmc'


no_runs_per_itr = 50000;
participants_number = 30;

for p_itr=1:participants_number
    %saved_fname=sprintf('individual/saved/p%d.mat',hyper_p); %
    saved_fname=sprintf('modeling/individual/estimated_params_%s_%s/p%d.mat',exp_type, model_type, p_itr);  % for GA
    load(saved_fname)
    
    
    cdf_file_name_ind = sprintf('exp_data/individual/exp_cdf/cdf_%s_%d.csv', exp_type, p_itr);
    caf_file_name_ind = sprintf('exp_data/individual/exp_caf/caf_%s_%d.csv', exp_type, p_itr);
   
    exp_CDF_individual = csvread(cdf_file_name_ind);
    exp_CAF_individual = csvread(caf_file_name_ind);
    
    exp_CDF_total(p_itr,1:9,1:5) = exp_CDF_individual;
    exp_CAF_total(p_itr,:,:) = exp_CAF_individual;
    [vs,indices ] = sort(fvals);
    xss=indices(1);
    x = Xs(1,:);
    
    if strcmp(model_type, 'mdmc')
        [RTS, CTS, ICTS] = model_mdmc(x, no_runs_per_itr);
    elseif strcmp(model_type, 'fn_mdmc')
        [RTS, CTS, ICTS] = model_fn_mdmc(x, no_runs_per_itr);
    end
    [model_CDF, model_CAF] = extract_model_cdf_caf(RTS, CTS, ICTS);
    
    model_CDF_individual(p_itr, :, :) = model_CDF;
    model_CAF_individual(p_itr, :, :) = model_CAF;
    
end

%% plotting and postprocessing
clear exp_CAF exp_CAF model_CDF model_CAF
exp_CDF = reshape(nanmean(exp_CDF_total),9,5); % average over participants
exp_CAF = reshape(nanmean(exp_CAF_total),9,5); % average over participants

model_CDF = reshape(nanmean(model_CDF_individual),9,5); % average over participants
model_CAF = reshape(nanmean(model_CAF_individual),9,5); % average over participants

% expCDFTotal_new_vals = zeros(length(valid_persons),9,5);
for p_itr=1:participants_number
    for point_cnt = 1:5
        expCDFTotal_new_vals(p_itr, :, point_cnt) = exp_CDF_total(p_itr,:,point_cnt) - nanmean(exp_CDF_total(p_itr, :, point_cnt)) + nanmean(nanmean(exp_CDF_total(:,:,point_cnt)));
        expCAFTotal_new_vals(p_itr, :, point_cnt) = exp_CAF_total(p_itr,:,point_cnt) - nanmean(exp_CAF_total(p_itr, :, point_cnt)) + nanmean(nanmean(exp_CAF_total(:,:,point_cnt)));
        
        modelCDFIndividual_new_vals(p_itr, :, point_cnt) = model_CDF_individual(p_itr,:,point_cnt) - nanmean(model_CDF_individual(p_itr, :, point_cnt)) + nanmean(nanmean(model_CDF_individual(:,:,point_cnt)));
        modelCAFIndividual_new_vals(p_itr, :, point_cnt) = model_CAF_individual(p_itr,:,point_cnt) - nanmean(model_CAF_individual(p_itr, :, point_cnt)) + nanmean(nanmean(model_CAF_individual(:,:,point_cnt)));
        
    end
end
corr_factor = 1.96 .* (participants_number./(participants_number-1));
for con = 1:9
    for point_cnt = 1:5
        modelCDF_err(con, point_cnt)  = nanstd(modelCDFIndividual_new_vals(:,con,point_cnt))./sqrt(participants_number).*corr_factor;
        modelCAF_err(con, point_cnt)  = nanstd(modelCAFIndividual_new_vals(:,con,point_cnt))./sqrt(participants_number).*corr_factor;
        
        expCDF_err(con, point_cnt)  = nanstd(expCDFTotal_new_vals(:,con,point_cnt))./sqrt(participants_number).*corr_factor;
        expCAF_err(con, point_cnt)  = nanstd(expCAFTotal_new_vals(:,con,point_cnt))./sqrt(participants_number).*corr_factor;
        
    end
end


corr_factor = 1.96 .* (participants_number./(participants_number-1));


for p_itr=1:participants_number
    for point_cnt = 1:5
        delta_visual(p_itr,point_cnt) = mean([modelCDFIndividual_new_vals(p_itr,9,point_cnt), ...
            modelCDFIndividual_new_vals(p_itr,6,point_cnt), ...
            modelCDFIndividual_new_vals(p_itr,3,point_cnt)]) - ...
            mean([modelCDFIndividual_new_vals(p_itr,7,point_cnt), ...
            modelCDFIndividual_new_vals(p_itr,4,point_cnt), ...
            modelCDFIndividual_new_vals(p_itr,1,point_cnt)]);
        
        delta_tactile(p_itr,point_cnt) = mean([modelCDFIndividual_new_vals(p_itr,7,point_cnt), ...
            modelCDFIndividual_new_vals(p_itr,8,point_cnt), ...
            modelCDFIndividual_new_vals(p_itr,9,point_cnt)]) - ...
            mean([modelCDFIndividual_new_vals(p_itr,1,point_cnt), ...
            modelCDFIndividual_new_vals(p_itr,2,point_cnt), ...
            modelCDFIndividual_new_vals(p_itr,3,point_cnt)]);
        
    end
end


model_delta_x_vector_vis =  nanmean([reshape(nanmean(modelCDFIndividual_new_vals(:,7,:)),1,5); ...
    reshape(nanmean(modelCDFIndividual_new_vals(:,4,:)),1,5); ...
    reshape(nanmean(modelCDFIndividual_new_vals(:,1,:)),1,5)]);

model_delta_mean_vis = nanmean(delta_visual);
% TODO: check if it should be *3 or just the number of participants
model_delta_err_vis  = (nanstd(delta_visual)./sqrt(participants_number*3)).*corr_factor;

figure;
errorbar(model_delta_x_vector_vis, model_delta_mean_vis,model_delta_err_vis,'--ok','vertical','linewidth',2);
title ('Delta - Visual Modality')

model_delta_x_vector_tac =  nanmean([reshape(nanmean(modelCDFIndividual_new_vals(:,1,:)),1,5); ...
    reshape(nanmean(modelCDFIndividual_new_vals(:,2,:)),1,5); ...
    reshape(nanmean(modelCDFIndividual_new_vals(:,3,:)),1,5)]);


model_delta_mean_tac = nanmean(delta_tactile);
% TODO: check if it should be *3 or just the number of participants
model_delta_err_tac  = (nanstd(delta_tactile)./sqrt(participants_number*3)).*corr_factor;

figure;
errorbar(model_delta_x_vector_tac, model_delta_mean_tac,model_delta_err_tac,'--ok','vertical','linewidth',2);
if strcmp(exp_type, 'VT') ==1
    title ('Delta - Tactile Modality')
elseif strcmp(exp_type, 'VA') ==1
    title ('Delta - Auditory Modality')
end



if strcmp(exp_type, 'VT') ==1
    titleMap={'CVCT','NVCT','IVCT','CVNT','NVNT','IVNT','CVIT','NVIT','IVIT'};
elseif strcmp(exp_type, 'VA') ==1
    titleMap={'CVCA','NVCA','IVCA','CVNA','NVNA','IVNA','CVIA','NVIA','IVIA'};
end
figure;
hold on;
xv =[1 2 3 4 5];
for i=1:9
    subplot(3,3,i);
    hold on;
    errorbar(xv, exp_CAF(i,:), expCAF_err(i,:),'vertical','linewidth',2,'Color', 'b');
    errorbar(xv, model_CAF(i,:), modelCAF_err(i,:),'vertical','linewidth',2,'Color', 'r');
    
    title(titleMap{i});
    axis([0.8 5.2 .5 1])
    set(gca,'XTick',[1:5])
    set(gca,'XTickLabel',{'0-20','20-40','40-60',...
        '60-80','80-100'});
    ax = gca;
    ax.XTickLabelRotation = -90;
end

figure;
hold on;
[temp,xvlen]= size(exp_CDF);
xv=[.1 .3 .5 .7 .9];
for i=1:9
    subplot(3,3,i);
    hold on;
    errorbar(exp_CDF(i,:), xv, expCDF_err(i,:),'horizontal','linewidth',2,'Color', 'b');
    errorbar(model_CDF(i,:), xv, modelCDF_err(i,:),'horizontal','linewidth',2,'Color', 'r');
    
    title(titleMap{i});
    axis([250 600 0 1])
    
end




