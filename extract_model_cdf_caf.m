
function [model_CDF, model_CAF] = extract_model_cdf_caf(RTS, CTS, ICTS)



%CDF
pt = [.1 .3 .5 .7 .9];
CDFdim = length(pt);
for k = 1:9
    clear RTS_correct
    RTS_correct=RTS(CTS(:,k)==1,k);
    pp = quantile(RTS_correct,pt);
    model_CDF(k,1:CDFdim) = pp;
end


%CAF
for k = 1:9
    pp = quantile(RTS(:,k),4);
    
    %0-20
    ix1 = RTS(:,k)<=pp(1);
    corrects=sum(CTS(ix1,k));
    icorrects=sum(ICTS(ix1,k));
    model_CAF(k,1)=corrects./(corrects+icorrects);
    
    %20-40
    ix2 = (RTS(:,k)<=pp(2)) & (RTS(:,k)>pp(1)) ;
    corrects=sum(CTS(ix2,k));
    icorrects=sum(ICTS(ix2,k));
    model_CAF(k,2)=corrects./(corrects+icorrects);
    
    %40-60
    ix3 = (RTS(:,k)<=pp(3)) & (RTS(:,k)>pp(2)) ;
    corrects=sum(CTS(ix3,k));
    icorrects=sum(ICTS(ix3,k));
    model_CAF(k,3)=corrects./(corrects+icorrects);
    
    %60-80
    ix4 = (RTS(:,k)<=pp(4)) & (RTS(:,k)>pp(3)) ;
    corrects=sum(CTS(ix4,k));
    icorrects=sum(ICTS(ix4,k));
    model_CAF(k,4)=corrects./(corrects+icorrects);
    
    %80-100
    ix5 = (RTS(:,k)>pp(4)) ;
    corrects=sum(CTS(ix5,k));
    icorrects=sum(ICTS(ix5,k));
    model_CAF(k,5)=corrects./(corrects+icorrects);
end


end