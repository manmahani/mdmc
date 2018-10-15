% CDFS and RTs are analyzed only for correct answers
% CAFs and errors are calculated based on all answer.

close all
clear
clc

rt_noise_remove_thr_down = 150;
rt_noise_remove_thr_up =1200;

trial_numbers_per_condition = 30;
data_feature_no = 12;
participant_numbers = 30;

% PLEASE SELECT THE EXPERIMENT HERE: 'VT' or 'VA'
exp_type = 'VA';
export_cdf_csv = true;
export_caf_csv = true;
cdf_export_type = 'agg'; % it can be 'agg' -> aggregated or 'ind' -> individual
caf_export_type = 'agg'; % it can be 'agg' or 'ind'
cdf_perc = [10  30  50  70  90]; % select this oneto generate files for modeling
% cdf_perc = [ 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95]; % for plotting

cdf_anova_file_path='C:\Users\user\Desktop\cross-modal simon effect\Simon_CDF';
caf_anova_file_path='C:\Users\user\Desktop\cross-modal simon effect\Simon_CAF';

for participant_itr =1:participant_numbers
    %     clear data* CAF* CDF* caf* cdf*
    file_name=sprintf('exp_data/raw/%s/%s_P%d.csv',exp_type, exp_type, participant_itr);
    data_raw_input = csvread(file_name);
    data_raw = data_raw_input(1:length(data_raw_input),:);
    target_esponse = mod(participant_itr-1,2)+1;
    
    if target_esponse==1
        
        %dataA is 6D array: VL(1 ->Left,2->Center,3->Left) x TL/AL(1,2,3) x RL(1->Left,2->Right) x PersonNo x TrialNo x FeaturesNo
        dataVLTLRL =data_raw((data_raw(:,1)==8),:);
        data_all_participants(1,1,1,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVLTLRL;
        dataVLTRRL =data_raw((data_raw(:,1)==7),:);
        data_all_participants(1,3,1,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVLTRRL;
        dataVLTCRL =data_raw((data_raw(:,1)==9),:);
        data_all_participants(1,2,1,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVLTCRL;
        
        dataVLTLRR =data_raw((data_raw(:,1)==11),:);
        data_all_participants(1,1,2,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVLTLRR;
        dataVLTRRR =data_raw((data_raw(:,1)==10),:);
        data_all_participants(1,3,2,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVLTRRR;
        dataVLTCRR =data_raw((data_raw(:,1)==12),:);
        data_all_participants(1,2,2,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVLTCRR;
        
        dataVCTLRL =data_raw((data_raw(:,1)==2),:);
        data_all_participants(2,1,1,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVCTLRL;
        dataVCTRRL =data_raw((data_raw(:,1)==1),:);
        data_all_participants(2,3,1,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVCTRRL;
        dataVCTCRL =data_raw((data_raw(:,1)==3),:);
        data_all_participants(2,2,1,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVCTCRL;
        
        dataVCTLRR =data_raw((data_raw(:,1)==5),:);
        data_all_participants(2,1,2,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVCTLRR;
        dataVCTRRR =data_raw((data_raw(:,1)==4),:);
        data_all_participants(2,3,2,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVCTRRR;
        dataVCTCRR =data_raw((data_raw(:,1)==6),:);
        data_all_participants(2,2,2,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVCTCRR;
        
        dataVRTLRL =data_raw((data_raw(:,1)==14),:);
        data_all_participants(3,1,1,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVRTLRL;
        dataVRTRRL =data_raw((data_raw(:,1)==13),:);
        data_all_participants(3,3,1,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVRTRRL;
        dataVRTCRL =data_raw((data_raw(:,1)==15),:);
        data_all_participants(3,2,1,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVRTCRL;
        
        
        dataVRTLRR =data_raw((data_raw(:,1)==17),:);
        data_all_participants(3,1,2,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVRTLRR;
        dataVRTRRR =data_raw((data_raw(:,1)==16),:);
        data_all_participants(3,3,2,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVRTRRR;
        dataVRTCRR =data_raw((data_raw(:,1)==18),:);
        data_all_participants(3,2,2,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVRTCRR;
    elseif target_esponse==2
        %dataA is 6D array: VL(1 ->Left,2->Center,3->Left) x TL(1,2,3) x RL(1->Left,2->Right) x PersonNo x TrialNo x FeaturesNo
        dataVLTLRR =data_raw((data_raw(:,1)==8),:);
        data_all_participants(1,1,2,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVLTLRR;
        dataVLTRRR =data_raw((data_raw(:,1)==7),:);
        data_all_participants(1,3,2,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVLTRRR;
        dataVLTCRR =data_raw((data_raw(:,1)==9),:);
        data_all_participants(1,2,2,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVLTCRR;
        
        dataVLTLRL =data_raw((data_raw(:,1)==11),:);
        data_all_participants(1,1,1,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVLTLRL;
        dataVLTRRL =data_raw((data_raw(:,1)==10),:);
        data_all_participants(1,3,1,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVLTRRL;
        dataVLTCRL =data_raw((data_raw(:,1)==12),:);
        data_all_participants(1,2,1,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVLTCRL;
        
        dataVCTLRR =data_raw((data_raw(:,1)==2),:);
        data_all_participants(2,1,2,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVCTLRR;
        dataVCTRRR =data_raw((data_raw(:,1)==1),:);
        data_all_participants(2,3,2,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVCTRRR;
        dataVCTCRR =data_raw((data_raw(:,1)==3),:);
        data_all_participants(2,2,2,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVCTCRR;
        
        dataVCTLRL =data_raw((data_raw(:,1)==5),:);
        data_all_participants(2,1,1,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVCTLRL;
        dataVCTRRL =data_raw((data_raw(:,1)==4),:);
        data_all_participants(2,3,1,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVCTRRL;
        dataVCTCRL =data_raw((data_raw(:,1)==6),:);
        data_all_participants(2,2,1,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVCTCRL;
        
        dataVRTLRR =data_raw((data_raw(:,1)==14),:);
        data_all_participants(3,1,2,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVRTLRR;
        dataVRTRRR =data_raw((data_raw(:,1)==13),:);
        data_all_participants(3,3,2,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVRTRRR;
        dataVRTCRR =data_raw((data_raw(:,1)==15),:);
        data_all_participants(3,2,2,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVRTCRR;
        
        
        dataVRTLRL =data_raw((data_raw(:,1)==17),:);
        data_all_participants(3,1,1,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVRTLRL;
        dataVRTRRL =data_raw((data_raw(:,1)==16),:);
        data_all_participants(3,3,1,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVRTRRL;
        dataVRTCRL =data_raw((data_raw(:,1)==18),:);
        data_all_participants(3,2,1,participant_itr,1:trial_numbers_per_condition,1:data_feature_no)  = dataVRTCRL;
    end
end
nan_cnt=0;
non_nan_cnt=0;
for participant_itr =1:participant_numbers
    for v=1:3
        for t=1:3
            for r=1:2
                clear corrects_answers ct all_valid_answers
                size_data_all = size(data_all_participants(v,t,r,participant_itr,:,:));
                all_valid_answers = data_all_participants(v,t,r,participant_itr,:,:);
                all_valid_answers = reshape(all_valid_answers,size_data_all(5),size_data_all(6));
                all_valid_answers(all_valid_answers(:,12)>rt_noise_remove_thr_up,:)=nan;
                all_valid_answers(all_valid_answers(:,12)<rt_noise_remove_thr_down,:)=nan;
                non_nan_cnt = non_nan_cnt+sum(isnan(all_valid_answers(:,12))==0);
                nan_cnt = nan_cnt+sum(isnan(all_valid_answers(:,12)));
                %                 corrects= dataA(v,t,r,p,dataA(v,t,r,p,:,9)==dataA(v,t,r,p,:,11),:);
                correct_answers = all_valid_answers(all_valid_answers(:,9)==all_valid_answers(:,11),:);
                ct = (correct_answers);
                %                 ct = reshape(corrects,sz(5),sz(6));
                %                 rt(v,t,r,p)=median(ct(:,12));
                %                 ct(ct(:,12)>rtThrUp,12)= nan;
                %                 ct(ct(:,12)<rtThrDown,12)= nan;
                rt(v,t,r,participant_itr)=nanmean(ct(:,12));
                %                 rt(v,t,r,p)=mean(ct(:,12));
                rta(v,t,r,participant_itr,1:length(ct(:,12))) = ct(:,12)';
                rt_bar(v,t,r,participant_itr) = std(ct(:,12))./sqrt(length(ct(:,12)));
                errs (v,t,r,participant_itr) = length(all_valid_answers)-length(ct);
                prcall= (quantile(all_valid_answers(:,12),4));
                
                selected = all_valid_answers( all_valid_answers(:,12)<=prcall(1),:);
                ccr= ( (selected(:,9)==selected(:,11)));
                CAF (v,t,r,participant_itr,1) = sum(ccr)./(length(ccr)+0.0000000001);
                for pr = 1:3
                    clear ccr;
                    allvalidans2 = all_valid_answers( all_valid_answers(:,12)<=prcall(pr+1),:);
                    selected = allvalidans2( allvalidans2(:,12)>prcall(pr),:);
                    ccr= ( (selected(:,9)==selected(:,11)));
                    CAF (v,t,r,participant_itr,pr+1) = sum(ccr)./(length(ccr)+0.000000000001);
                end
                clear ccr;
                selected = all_valid_answers( all_valid_answers(:,12)>prcall(4),:);
                ccr= ( (selected(:,9)==selected(:,11)));
                CAF (v,t,r,participant_itr,5) = sum(ccr)./(length(ccr)+0.00000000001);
            end
        end
    end
end

%%  CDF analysis

clear CDF
CDFdim = length(cdf_perc);

for p_itr=1:participant_numbers
    for v=1:3
        for t=1:3
            for r=1:2
                dttemp = rta(v,t,r,p_itr,:);
                dtp = dttemp(:);
                dtp = dtp(dtp>0);
                pp = prctile(dtp,cdf_perc);
                CDF(p_itr,v,t,r,:)=pp;
            end
        end
    end
end


for p_itr =1:participant_numbers
    CDF_TS_VS(p_itr,1:CDFdim)=reshape(mean([CDF(p_itr,3,3,2,:),CDF(p_itr,1,1,1,:)]),CDFdim,1);
    CDF_TS_VC(p_itr,1:CDFdim)=reshape(mean([CDF(p_itr,2,3,2,:),CDF(p_itr,2,1,1,:)]),CDFdim,1);
    CDF_TS_VO(p_itr,1:CDFdim)=reshape(mean([CDF(p_itr,1,3,2,:),CDF(p_itr,3,1,1,:)]),CDFdim,1);
    
    CDF_TC_VS(p_itr,1:CDFdim)=reshape(mean([CDF(p_itr,1,2,1,:),CDF(p_itr,3,2,2,:)]),CDFdim,1);
    CDF_TC_VC(p_itr,1:CDFdim)=reshape(mean([CDF(p_itr,2,2,1,:),CDF(p_itr,2,2,2,:)]),CDFdim,1);
    CDF_TC_VO(p_itr,1:CDFdim)=reshape(mean([CDF(p_itr,1,2,2,:),CDF(p_itr,3,2,1,:)]),CDFdim,1);
    
    CDF_TO_VS(p_itr,1:CDFdim)=reshape(mean([CDF(p_itr,1,3,1,:),CDF(p_itr,3,1,2,:)]),CDFdim,1);
    CDF_TO_VC(p_itr,1:CDFdim)=reshape(mean([CDF(p_itr,2,3,1,:),CDF(p_itr,2,1,2,:)]),CDFdim,1);
    CDF_TO_VO(p_itr,1:CDFdim)=reshape(mean([CDF(p_itr,1,1,2,:),CDF(p_itr,3,3,1,:)]),CDFdim,1);
end

figure;
hold on;
plot(mean([mean(CDF_TS_VS);mean(CDF_TO_VS);mean(CDF_TC_VS)]),cdf_perc,'r-*','LineWidth',2);
plot(mean([mean(CDF_TS_VO);mean(CDF_TO_VO);mean(CDF_TC_VO)]),cdf_perc,'b-*','LineWidth',2);
plot(mean([mean(CDF_TS_VC);mean(CDF_TO_VC);mean(CDF_TC_VC)]),cdf_perc,'k-*','LineWidth',2);
legend('Visual Congruent','Visual Incongruent','Visual Neutral')
%
figure;
delta =mean([mean(CDF_TS_VO);mean(CDF_TO_VO);mean(CDF_TC_VO)])-mean([mean(CDF_TS_VS);mean(CDF_TO_VS);mean(CDF_TC_VS)]);
plot(mean([mean(CDF_TS_VS);mean(CDF_TO_VS);mean(CDF_TC_VS)]),delta,'-k*','LineWidth',3)
% axis([300 550 24 36])
% plot_delta( mean(CDF_TS_VO), mean(CDF_TO_VO), mean(CDF_TC_VO), mean(CDF_TS_VS), mean(CDF_TO_VS), mean(CDF_TC_VS));
title('Visual Modality')

figure;
hold on;
plot(mean([mean(CDF_TS_VS);mean(CDF_TS_VO);mean(CDF_TS_VC)]),cdf_perc,'r-*','LineWidth',2);
plot(mean([mean(CDF_TO_VS);mean(CDF_TO_VO);mean(CDF_TO_VC)]),cdf_perc,'b-*','LineWidth',2);
plot(mean([mean(CDF_TC_VS);mean(CDF_TC_VO);mean(CDF_TC_VC)]),cdf_perc,'k-*','LineWidth',2);
if strcmp(exp_type, 'VT')
    legend('Tactile Congruent','Tactile Incongruent','Tactile Neutral')
elseif strcmp(exp_type, 'VA')
    legend('Auditory Congruent','Auditory Incongruent','Auditory Neutral')
end

figure;
delta =mean([mean(CDF_TO_VS);mean(CDF_TO_VO);mean(CDF_TO_VC)])-mean([mean(CDF_TS_VS);mean(CDF_TS_VO);mean(CDF_TS_VC)]);
plot(mean([mean(CDF_TS_VS);mean(CDF_TS_VO);mean(CDF_TS_VC)]),delta,'-k*','LineWidth',3)
% axis([300 550 4 16])

if strcmp(exp_type, 'VT')
    title('Tactile Modality')
elseif strcmp(exp_type, 'VA')
    title('Auditory Modality')
end



if export_cdf_csv ==true
    if strcmp(cdf_export_type,'agg')==1
        
        cdf_total= [mean(CDF_TS_VS);mean(CDF_TS_VC);mean(CDF_TS_VO); ...
            mean(CDF_TC_VS);mean(CDF_TC_VC);mean(CDF_TC_VO); ...
            mean(CDF_TO_VS);mean(CDF_TO_VC);mean(CDF_TO_VO)];
        
        cdf_file_name=sprintf('exp_data/cdf_agg_%s.csv',exp_type);
        
        delete(cdf_file_name);
        csvwrite(cdf_file_name, cdf_total);
        
    elseif strcmp(cdf_export_type,'ind')==1
        for itr=1:participant_numbers
            cdf_ind = [(CDF_TS_VS(itr,:));(CDF_TS_VC(itr,:));(CDF_TS_VO(itr,:)); ...
                (CDF_TC_VS(itr,:));(CDF_TC_VC(itr,:));(CDF_TC_VO(itr,:)); ...
                (CDF_TO_VS(itr,:));(CDF_TO_VC(itr,:));(CDF_TO_VO(itr,:))];
            
            cdf_file_name_ind = sprintf('exp_data/individual/exp_cdf/cdf_%s_%d.csv', exp_type, itr);
            
            delete( cdf_file_name_ind);
            csvwrite(cdf_file_name_ind,cdf_ind);
        end
    end
    
end

%{
%repeated ANOVA measurment on CDFs
t = table( CDF_TS_VS(:,1), CDF_TS_VC(:,1), CDF_TS_VO(:,1), ...
           CDF_TC_VS(:,1), CDF_TC_VC(:,1), CDF_TC_VO(:,1), ...
           CDF_TO_VS(:,1), CDF_TO_VC(:,1), CDF_TO_VO(:,1), ...
		   CDF_TS_VS(:,2), CDF_TS_VC(:,2), CDF_TS_VO(:,2), ...
           CDF_TC_VS(:,2), CDF_TC_VC(:,2), CDF_TC_VO(:,2), ...
           CDF_TO_VS(:,2), CDF_TO_VC(:,2), CDF_TO_VO(:,2), ...
		   CDF_TS_VS(:,3), CDF_TS_VC(:,3), CDF_TS_VO(:,3), ...
		   CDF_TC_VS(:,3), CDF_TC_VC(:,3), CDF_TC_VO(:,3), ...
		   CDF_TO_VS(:,3), CDF_TO_VC(:,3), CDF_TO_VO(:,3), ...
		   CDF_TS_VS(:,4), CDF_TS_VC(:,4), CDF_TS_VO(:,4), ...
		   CDF_TC_VS(:,4), CDF_TC_VC(:,4), CDF_TC_VO(:,4), ...
		   CDF_TO_VS(:,4), CDF_TO_VC(:,4), CDF_TO_VO(:,4), ...
		   CDF_TS_VS(:,5), CDF_TS_VC(:,5), CDF_TS_VO(:,5), ...
		   CDF_TC_VS(:,5), CDF_TC_VC(:,5), CDF_TC_VO(:,5), ...
		   CDF_TO_VS(:,5), CDF_TO_VC(:,5), CDF_TO_VO(:,5), ...
		   'VariableNames',{'Y1','Y2','Y3','Y4','Y5','Y6','Y7','Y8','Y9' ,...
		                    'Y10','Y11','Y12','Y13','Y14','Y15','Y16','Y17','Y18' ,...
		                    'Y19','Y20','Y21','Y22','Y23','Y24','Y25','Y26','Y27' ,...
							'Y28','Y29','Y30','Y31','Y32','Y33','Y34','Y35','Y36' ,...
							'Y37','Y38','Y39','Y40','Y41','Y42','Y43','Y44','Y45' ,...
		   });
       
       		   within = table({'TS';'TS';'TS';'TN';'TN';'TN';'TO';'TO';'TO'; ...
						   'TS';'TS';'TS';'TN';'TN';'TN';'TO';'TO';'TO'; ...
		                   'TS';'TS';'TS';'TN';'TN';'TN';'TO';'TO';'TO'; ...
		                   'TS';'TS';'TS';'TN';'TN';'TN';'TO';'TO';'TO'; ...
		                   'TS';'TS';'TS';'TN';'TN';'TN';'TO';'TO';'TO'}, ...
		                  {'VS';'VN';'VO';'VS';'VN';'VO';'VS';'VN';'VO'; ...
						   'VS';'VN';'VO';'VS';'VN';'VO';'VS';'VN';'VO'; ...
						   'VS';'VN';'VO';'VS';'VN';'VO';'VS';'VN';'VO'; ...
						   'VS';'VN';'VO';'VS';'VN';'VO';'VS';'VN';'VO'; ...
						   'VS';'VN';'VO';'VS';'VN';'VO';'VS';'VN';'VO'}, ...
						  {'C1';'C1';'C1';'C1';'C1';'C1';'C1';'C1';'C1'; ...
						   'C2';'C2';'C2';'C2';'C2';'C2';'C2';'C2';'C2'; ...
						   'C3';'C3';'C3';'C3';'C3';'C3';'C3';'C3';'C3'; ...
						   'C4';'C4';'C4';'C4';'C4';'C4';'C4';'C4';'C4'; ...
						   'C5';'C5';'C5';'C5';'C5';'C5';'C5';'C5';'C5'}, ...
						  'VariableNames',{'Tac','Vis','CDF'});

% within = table({'TS';'TS';'TS';'TN';'TN';'TN';'TO';'TO';'TO'},{'VS';'VN';'VO';'VS';'VN';'VO';'VS';'VN';'VO'},'VariableNames',{'Tac','Vis'});
rm = fitrm(t,'Y1-Y45~1','WithinDesign',within); % Here the code breaks.
ranovatbl = ranova(rm,'WithinModel','Tac*Vis*CDF')
% multcompare(rm,'Tac')
%}

RTs_dataT = [ CDF_TS_VS,  CDF_TS_VC, CDF_TS_VO, CDF_TC_VS,CDF_TC_VC, CDF_TC_VO,CDF_TO_VS, CDF_TO_VC, CDF_TO_VO];
RTs_data = reshape(RTs_dataT,participant_numbers*9*CDFdim,1);

temp1 = repmat([1:participant_numbers]',CDFdim,1);
sub_data=repmat (temp1,9,1);

v_dataT = [repmat([1],participant_numbers*CDFdim,1);repmat([2],participant_numbers*CDFdim,1)...
    ;repmat([3],participant_numbers*CDFdim,1)];
v_data = repmat(v_dataT,3,1);

t_data = [repmat([1],participant_numbers*CDFdim*3,1);repmat([2],participant_numbers*CDFdim*3,1)...
    ;repmat([3],participant_numbers*CDFdim*3,1)];

cdf_dataT = zeros(participant_numbers,CDFdim);
for i=1:CDFdim
    cdf_dataT(:,i)=i;
end
cdf_dataT2 = reshape(cdf_dataT,participant_numbers*CDFdim,1);
cdf_data = repmat(cdf_dataT2,9,1);
tbl = table(RTs_data,v_data,t_data,cdf_data,sub_data,'VariableNames',{'rts','vis','tac','cdf','sub'});
% CallMrf(tbl, 'rts', {}, {'cdf','vis','tac'}, 'sub',[cdf_anova_file_path '\CDFs']);

%% CAF Analysis

CAF_TS_VS=reshape(mean([CAF(3,3,2,:,:),CAF(1,1,1,:,:)]),30, 5);
CAF_TS_VC=reshape(mean([CAF(2,3,2,:,:),CAF(2,1,1,:,:)]),30, 5);
CAF_TS_VO=reshape(mean([CAF(1,3,2,:,:),CAF(3,1,1,:,:)]),30, 5);

CAF_TC_VS=reshape(mean([CAF(1,2,1,:,:),CAF(3,2,2,:,:)]),30, 5);
CAF_TC_VC=reshape(mean([CAF(2,2,1,:,:),CAF(2,2,2,:,:)]),30, 5);
CAF_TC_VO=reshape(mean([CAF(1,2,2,:,:),CAF(3,2,1,:,:)]),30, 5);

CAF_TO_VS=reshape(mean([CAF(1,3,1,:,:),CAF(3,1,2,:,:)]),30, 5);
CAF_TO_VC=reshape(mean([CAF(2,3,1,:,:),CAF(2,1,2,:,:)]),30, 5);
CAF_TO_VO=reshape(mean([CAF(1,1,2,:,:),CAF(3,3,1,:,:)]),30, 5);

if export_cdf_csv ==true
    if strcmp(cdf_export_type,'agg')==1
        
        caf_total= [mean(CAF_TS_VS); mean(CAF_TS_VC); mean(CAF_TS_VO); ...
            mean(CAF_TC_VS); mean(CAF_TC_VC); mean(CAF_TC_VO); ...
            mean(CAF_TO_VS); mean(CAF_TO_VC); mean(CAF_TO_VO)];
        
        caf_file_name=sprintf('exp_data/caf_agg_%s.csv',exp_type);
        
        delete(caf_file_name);
        csvwrite(caf_file_name, caf_total);
        
        
    elseif strcmp(cdf_export_type,'ind')==1
        for itr=1:participant_numbers
            caf_ind = [(CAF_TS_VS(itr,:)); (CAF_TS_VC(itr,:)); (CAF_TS_VO(itr,:)); ...
                (CAF_TC_VS(itr,:)); (CAF_TC_VC(itr,:)); (CAF_TC_VO(itr,:)); ...
                (CAF_TO_VS(itr,:)); (CAF_TO_VC(itr,:)); (CAF_TO_VO(itr,:))];
            
            caf_file_name_ind = sprintf('exp_data/individual/exp_caf/caf_%s_%d.csv', exp_type, itr);
            
            delete( caf_file_name_ind);
            csvwrite(caf_file_name_ind,caf_ind);
        end
    end
end
CAFdim=5;
CAF_dataT = [ CAF_TS_VS,  CAF_TS_VC, CAF_TS_VO, CAF_TC_VS,CAF_TC_VC, CAF_TC_VO,CAF_TO_VS, CAF_TO_VC, CAF_TO_VO];
CAF_data = reshape(CAF_dataT,participant_numbers*9*CAFdim,1);

temp1 = repmat([1:participant_numbers]',CAFdim,1);
sub_dataF=repmat (temp1,9,1);

v_dataT = [repmat([1],participant_numbers*CAFdim,1);repmat([2],participant_numbers*CAFdim,1)...
    ;repmat([3],participant_numbers*CAFdim,1)];
v_dataF = repmat(v_dataT,3,1);

t_dataF = [repmat([1],participant_numbers*CAFdim*3,1);repmat([2],participant_numbers*CAFdim*3,1)...
    ;repmat([3],participant_numbers*CAFdim*3,1)];

caf_dataT = zeros(participant_numbers,CAFdim);
for i=1:CAFdim
    caf_dataT(:,i)=i;
end
caf_dataT2 = reshape(caf_dataT,participant_numbers*CAFdim,1);
caf_data = repmat(caf_dataT2,9,1);
tbl = table(CAF_data,v_dataF,t_dataF,caf_data,sub_dataF,'VariableNames',{'rts','vis','tac','caf','sub'});
% CallMrf(tbl, 'rts', {}, {'caf','vis','tac'}, 'sub',[caf_anova_file_path '\CAFs']);

%% RT and Errors
for p_itr =1:participant_numbers
    TS_VS(p_itr)=mean([rt(3,3,2,p_itr),rt(1,1,1,p_itr)]);
    TS_VC(p_itr)=mean([rt(2,3,2,p_itr),rt(2,1,1,p_itr)]);
    TS_VO(p_itr)=mean([rt(1,3,2,p_itr),rt(3,1,1,p_itr)]);
    
    TC_VS(p_itr)=mean([rt(1,2,1,p_itr),rt(3,2,2,p_itr)]);
    TC_VC(p_itr)=mean([rt(2,2,1,p_itr),rt(2,2,2,p_itr)]);
    TC_VO(p_itr)=mean([rt(1,2,2,p_itr),rt(3,2,1,p_itr)]);
    
    TO_VS(p_itr)=mean([rt(1,3,1,p_itr),rt(3,1,2,p_itr)]);
    TO_VC(p_itr)=mean([rt(2,3,1,p_itr),rt(2,1,2,p_itr)]);
    TO_VO(p_itr)=mean([rt(1,1,2,p_itr),rt(3,3,1,p_itr)]);
    
    dt_mat(1,1,p_itr) =TS_VS(p_itr);
    dt_mat(1,2,p_itr) =TS_VC(p_itr);
    dt_mat(1,3,p_itr) =TS_VO(p_itr);
    
    dt_mat(2,1,p_itr) =TC_VS(p_itr);
    dt_mat(2,2,p_itr) =TC_VC(p_itr);
    dt_mat(2,3,p_itr) =TC_VO(p_itr);
    
    dt_mat(3,1,p_itr) =TO_VS(p_itr);
    dt_mat(3,2,p_itr) =TO_VC(p_itr);
    dt_mat(3,3,p_itr) =TO_VO(p_itr);
    
    
    dt(1,p_itr) =TS_VS(p_itr);
    dt(2,p_itr) =TS_VC(p_itr);
    dt(3,p_itr) =TS_VO(p_itr);
    
    dt(4,p_itr) =TC_VS(p_itr);
    dt(5,p_itr) =TC_VC(p_itr);
    dt(6,p_itr) =TC_VO(p_itr);
    
    dt(7,p_itr) =TO_VS(p_itr);
    dt(8,p_itr) =TO_VC(p_itr);
    dt(9,p_itr) =TO_VO(p_itr);
    
    dtVariations(:,p_itr) = dt(:,p_itr)-mean(dt(:,p_itr));
    dtmatVariations(:,:,p_itr) = dt_mat(:,:,p_itr)-mean(dt(:,p_itr));
    
    TS_VS_err(p_itr)=mean([errs(3,3,2,p_itr),errs(1,1,1,p_itr)]);
    TS_VC_err(p_itr)=mean([errs(2,3,2,p_itr),errs(2,1,1,p_itr)]);
    TS_VO_err(p_itr)=mean([errs(1,3,2,p_itr),errs(3,1,1,p_itr)]);
    
    TC_VS_err(p_itr)=mean([errs(1,2,1,p_itr),errs(3,2,2,p_itr)]);
    TC_VC_err(p_itr)=mean([errs(2,2,1,p_itr),errs(2,2,2,p_itr)]);
    TC_VO_err(p_itr)=mean([errs(1,2,2,p_itr),errs(3,2,1,p_itr)]);
    
    TO_VS_err(p_itr)=mean([errs(1,3,1,p_itr),errs(3,1,2,p_itr)]);
    TO_VC_err(p_itr)=mean([errs(2,3,1,p_itr),errs(2,1,2,p_itr)]);
    TO_VO_err(p_itr)=mean([errs(1,1,2,p_itr),errs(3,3,1,p_itr)]);
    
    dt_err(1,p_itr) =TS_VS_err(p_itr);
    dt_err(2,p_itr) =TS_VC_err(p_itr);
    dt_err(3,p_itr) =TS_VO_err(p_itr);
    
    dt_err(4,p_itr) =TC_VS_err(p_itr);
    dt_err(5,p_itr) =TC_VC_err(p_itr);
    dt_err(6,p_itr) =TC_VO_err(p_itr);
    
    dt_err(7,p_itr) =TO_VS_err(p_itr);
    dt_err(8,p_itr) =TO_VC_err(p_itr);
    dt_err(9,p_itr) =TO_VO_err(p_itr);
    dt_err2 = dt_err*100/60; % percentage of error, not absolute value
    dtErrVariations(:,p_itr) = dt_err2(:,p_itr)-mean(dt_err2(:,p_itr));
    
    dtmat_err(1,1,p_itr) =TS_VS_err(p_itr);
    dtmat_err(1,2,p_itr) =TS_VC_err(p_itr);
    dtmat_err(1,3,p_itr) =TS_VO_err(p_itr);
    
    dtmat_err(2,1,p_itr) =TC_VS_err(p_itr);
    dtmat_err(2,2,p_itr) =TC_VC_err(p_itr);
    dtmat_err(2,3,p_itr) =TC_VO_err(p_itr);
    
    dtmat_err(3,1,p_itr) =TO_VS_err(p_itr);
    dtmat_err(3,2,p_itr) =TO_VC_err(p_itr);
    dtmat_err(3,3,p_itr) =TO_VO_err(p_itr);
    
end


%repeated ANOVA measurment on ERR
t = table( dt_err(1,:)', dt_err(2,:)', dt_err(3,:)', dt_err(4,:)', dt_err(5,:)', dt_err(6,:)', ...
    dt_err(7,:)' , dt_err(8,:)', dt_err(9,:)','VariableNames',{'Y1','Y2','Y3','Y4','Y5','Y6','Y7','Y8','Y9'});
within = table({'TS';'TS';'TS';'TN';'TN';'TN';'TO';'TO';'TO'},{'VS';'VN';'VO';'VS';'VN';'VO';'VS';'VN';'VO'},'VariableNames',{'Tac_Aud','Vis'});
rm = fitrm(t,'Y1-Y9~1','WithinDesign',within); % Here the code breaks.
ranovatbl = ranova(rm,'WithinModel','Tac_Aud*Vis')
multcompare(rm,'Tac_Aud')

%repeated ANOVA measurment on RT
t = table( dt(1,:)', dt(2,:)', dt(3,:)', dt(4,:)', dt(5,:)', dt(6,:)', ...
    dt(7,:)' , dt(8,:)', dt(9,:)','VariableNames',{'Y1','Y2','Y3','Y4','Y5','Y6','Y7','Y8','Y9'});
within = table({'TS';'TS';'TS';'TN';'TN';'TN';'TO';'TO';'TO'},{'VS';'VN';'VO';'VS';'VN';'VO';'VS';'VN';'VO'},'VariableNames',{'Tac_Aud','Vis'});
rm = fitrm(t,'Y1-Y9~1','WithinDesign',within); % Here the code breaks.
ranovatbl = ranova(rm,'WithinModel','Tac_Aud*Vis')
multcompare(rm,'Vis')




%% rt and error plots


% rt plot
figure;
hold on;
% title('');
xlabel('Visual Congruency Condition');
ylabel('Reaction Time (ms)');
i = 1:3;
errorbar(i,mean(dt(i,:),2),(std(dtVariations(i,:)')*(9/8))./sqrt(participant_numbers) ,'-g','LineWidth',3);

i = 4:6;
errorbar(i-3,mean(dt(i,:),2),(std(dtVariations(i,:)')*(9/8))./sqrt(participant_numbers),'-b','LineWidth',3);

i = 7:9;
errorbar(i-6,mean(dt(i,:),2),std(dtVariations(i,:)')*(9/8)./sqrt(participant_numbers),'-r','LineWidth',3);

set(gca,'XTick',[1:3])
set(gca,'XTickLabel',{'Visual Congruent','Visual Neutral','Visual InCongruent'});

if strcmp(exp_type, 'VT')
    legend('Tactile Congruent','Tactile Neutral','Tactile InCongruent');
elseif strcmp(exp_type, 'VA')
    legend('Auditory Congruent','Auditory Neutral','Auditory InCongruent');
end

% error plot
figure;
hold on;

% title('Percentage error');
xlabel('Visual Congruency Condition');
ylabel('Percentage of error (average over all subjects)');
i = 1:3;
errorbar(i,mean(dt_err2(i,:),2),(std(dtErrVariations(i,:)').*(9/8))./sqrt(participant_numbers ),'-g','LineWidth',3);

i = 4:6;
errorbar(i-3,mean(dt_err2(i,:),2),(std(dtErrVariations(i,:)').*(9/8))./sqrt(participant_numbers ),'-b','LineWidth',3);

i = 7:9;
errorbar(i-6,mean(dt_err2(i,:),2),(std(dtErrVariations(i,:)').*(9/8))./sqrt(participant_numbers ),'-r','LineWidth',3);

set(gca,'XTick',[1:3])
set(gca,'XTickLabel',{'Visual Congruent','Visual Neutral','Visual InCongruent'});
if strcmp(exp_type, 'VT')
    legend('Tactile Congruent','Tactile Neutral','Tactile InCongruent');
elseif strcmp(exp_type, 'VA')
    legend('Auditory Congruent','Auditory Neutral','Auditory InCongruent');
end
