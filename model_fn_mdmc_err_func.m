function fiterror = model_fn_mdmc_err_func(x)
global exp_CDF exp_CAF no_runs_per_itr

[RTS, CTS, ICTS] = model_fn_mdmc(x, no_runs_per_itr);

[not_used, model_CAF] = extract_model_cdf_caf(RTS, CTS, ICTS);


CDFdim = 5;
probabs_cdf = repmat([.1 .3 .5 .7 .9], 9, 1);
for k = 1:9
    clear RTS_correct
    RTS_correct=RTS(CTS(:,k)==1,k);
    pp=invprctile(RTS_correct,exp_CDF(k,:));
    model_CDF(k,1:CDFdim) = pp;
end

E1=sum(sum(abs (exp_CAF.*log(exp_CAF./model_CAF) ) ));
E2=sum(sum(abs (probabs_cdf.*log(probabs_cdf./((model_CDF./100)+.00000001 )) ) ));
disp('oneRun!');

fiterror = (E1+E2);

return;

