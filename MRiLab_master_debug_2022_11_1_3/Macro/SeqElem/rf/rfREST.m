
function [rfAmp,rfPhase,rfFreq,rfCoil,rfTime]=rfREST(p)

rest_shape = load('rest_shapes.mat');
tStart=p.tStart;
tEnd=p.tEnd;
dt=p.dt;
FA = p.FA;
WJGFM_scale = p.WJGFM_scale;
WJGFM_shift = p.WJGFM_shift;
AMP = p.WJGAMP;
eval(['AMP = rest_shape.',AMP,';']);
FM = p.WJGFM;
eval(['FM = rest_shape.',FM,';']);
rfCoil=p.CoilID;
Duplicates=max(1,p.Duplicates);
DupSpacing=max(0,p.DupSpacing);

rfTime=linspace(tStart,tEnd,ceil((tEnd-tStart)/dt)+1);
x = linspace(0,1,length(AMP));
xi = linspace(0,1,length((rfTime)));

rfAmp = AMP;
rfAmp= interp1(x,rfAmp,xi,'spline');  
rfFreq = FM*WJGFM_scale+WJGFM_shift;%1/(tEnd-tStart)*100;
rfFreq= interp1(x,rfFreq,xi,'spline');  
rfPhase = zeros(size(rfFreq));


rfAmp=DoB1Scaling(rfAmp,dt,FA)*rfAmp; %B1 Scaling

rfAmp(isnan(rfAmp))=max(rfAmp);
rfAmp(1)=0;
rfAmp(end)=0;


rfPhase=(rfPhase).*zeros(size(rfTime));
% rfPhase = mod(rfPhase,2*pi);
rfFreq=(rfFreq).*ones(size(rfTime));
rfCoil=(rfCoil).*ones(size(rfTime));
rfPhase(1)=0;
rfPhase(end)=0;
rfFreq(1)=0;
rfFreq(end)=0;

% Create Duplicates
if Duplicates~=1 & DupSpacing ~=0
    rfAmp=repmat(rfAmp,[1 Duplicates]);
    rfFreq=repmat(rfFreq,[1 Duplicates]);
    rfPhase=repmat(rfPhase,[1 Duplicates]);
    rfCoil=repmat(rfCoil,[1 Duplicates]);
    TimeOffset = repmat(0:DupSpacing:(Duplicates-1)*DupSpacing,[length(rfTime) 1]);
    rfTime=repmat(rfTime,[1 Duplicates]) + (TimeOffset(:))';
end

end