%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MRiLab auto generated file: DO NOT EDIT!     %
% Generated by MRiLab "DoWriteXML2m" Generator %
% MRiLab Version 1.3                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [rfAmp,rfPhase,rfFreq,rfCoil,GzAmp,GyAmp,GxAmp,ADC,Ext,uts,ts,flags]=PSD_OLED_2_2
global VCtl
global VVar
CV1=75e-3;
CV10=0;
CV11=0;
CV12=0;
CV13=0;
CV14=0;
CV2=80e-3;
CV3=3e-3;
CV4=3e-3;
CV5=5/4*VCtl.EPI_ESP*VCtl.EPI_ETL+CV4*2;
CV6=0;
CV7=0;
CV8=0;
CV9=0;
rfAmpAll=[];
rfPhaseAll=[];
rfFreqAll=[];
rfCoilAll=[];
GzAmpAll=[];
GyAmpAll=[];
GxAmpAll=[];
ADCAll=[];
ExtAll=[];
rfTimeAll=[];
GzTimeAll=[];
GyTimeAll=[];
GxTimeAll=[];
ADCTimeAll=[];
ExtTimeAll=[];
SEtAll=[];
uts=[];
ts=[];
flags=[];
if VCtl.PlotSeq == 1
rfAmp=[];
rfPhase=[];
rfFreq=[];
rfCoil=[];
GzAmp=[];
GyAmp=[];
GxAmp=[];
ADC=[];
Ext=[];
Freq=1;
Notes='regular TR section';
AttributeOpt={'on','off'};
Switch=AttributeOpt{1};
TREnd=Inf;
TRStart=1;
tE=VCtl.TR;
tS=0;
if VVar.TRCount<TRStart | VVar.TRCount>TREnd | mod(VVar.TRCount-TRStart,Freq)~=0 | strcmp(Switch,'off')
% do nothing
else
ts = [ts tS tE];
end
ts = [0 max(ts)-min(ts)];
return;
end
%==============Pulses 1==============
rfAmp=[];
rfPhase=[];
rfFreq=[];
rfCoil=[];
GzAmp=[];
GyAmp=[];
GxAmp=[];
ADC=[];
Ext=[];
rfTime=[];
GzTime=[];
GyTime=[];
GxTime=[];
ADCTime=[];
ExtTime=[];
Freq=1;
Notes='regular TR section';
AttributeOpt={'on','off'};
Switch=AttributeOpt{1};
TREnd=Inf;
TRStart=1;
tE=VCtl.TR;
tS=0;
if isempty(tS) | isempty(tE) | (tS>=tE)
error('SE setting is incorrect for Pulses 1!');
end
if VVar.TRCount<TRStart | VVar.TRCount>TREnd | mod(VVar.TRCount-TRStart,Freq)~=0 | strcmp(Switch,'off')
% do nothing
else
%--------------------
AttributeOpt={'on','off'};
p.AnchorTE=AttributeOpt{1};
AttributeOpt={'Non','Hamming','Hanning'};
p.Apod=AttributeOpt{1};
p.CoilID=1;
p.DupSpacing=0;
p.Duplicates=1;
p.FA=VCtl.FlipAng;
p.Notes='excitation rf';
AttributeOpt={'on','off'};
p.Switch=AttributeOpt{1};
p.TBP=4;
p.dt=20e-6;
p.rfFreq=0;
p.rfPhase=0;
p.tEnd=CV3+1e-3;
p.tStart=CV3-1e-3;
if strcmp(p.Switch,'on')
if strcmp(p.AnchorTE,'on')
switch VCtl.TEAnchor
case 'Start'
VCtl.TEAnchorTime=p.tStart; 
case 'Middle'
VCtl.TEAnchorTime=(p.tStart+p.tEnd)/2; 
case 'End'
VCtl.TEAnchorTime=p.tEnd;
end
end
[rfAmp1,rfPhase1,rfFreq1,rfCoil1,rfTime1]=rfSinc(p);
if strcmp(VCtl.MultiTransmit,'off')
if VCtl.MasterTxCoil==rfCoil1(1)
rfAmp=[rfAmp rfAmp1];
rfPhase=[rfPhase rfPhase1];
rfFreq=[rfFreq rfFreq1];
rfCoil=[rfCoil rfCoil1];
rfTime=[rfTime rfTime1];
end
else
rfAmp=[rfAmp rfAmp1];
rfPhase=[rfPhase rfPhase1];
rfFreq=[rfFreq rfFreq1];
rfCoil=[rfCoil rfCoil1];
rfTime=[rfTime rfTime1];
end
end
p=[];
%--------------------
AttributeOpt={'on','off'};
p.AnchorTE=AttributeOpt{2};
AttributeOpt={'Non','Hamming','Hanning'};
p.Apod=AttributeOpt{1};
p.CoilID=1;
p.DupSpacing=0;
p.Duplicates=1;
p.FA=VCtl.FlipAng;
p.Notes='excitation rf';
AttributeOpt={'on','off'};
p.Switch=AttributeOpt{1};
p.TBP=4;
p.dt=20e-6;
p.rfFreq=0;
p.rfPhase=0;
p.tEnd=CV3+VCtl.delta_TE+1e-3;
p.tStart=CV3+VCtl.delta_TE-1e-3;
if strcmp(p.Switch,'on')
if strcmp(p.AnchorTE,'on')
switch VCtl.TEAnchor
case 'Start'
VCtl.TEAnchorTime=p.tStart; 
case 'Middle'
VCtl.TEAnchorTime=(p.tStart+p.tEnd)/2; 
case 'End'
VCtl.TEAnchorTime=p.tEnd;
end
end
[rfAmp2,rfPhase2,rfFreq2,rfCoil2,rfTime2]=rfSinc(p);
if strcmp(VCtl.MultiTransmit,'off')
if VCtl.MasterTxCoil==rfCoil2(1)
rfAmp=[rfAmp rfAmp2];
rfPhase=[rfPhase rfPhase2];
rfFreq=[rfFreq rfFreq2];
rfCoil=[rfCoil rfCoil2];
rfTime=[rfTime rfTime2];
end
else
rfAmp=[rfAmp rfAmp2];
rfPhase=[rfPhase rfPhase2];
rfFreq=[rfFreq rfFreq2];
rfCoil=[rfCoil rfCoil2];
rfTime=[rfTime rfTime2];
end
end
p=[];
%--------------------
AttributeOpt={'on','off'};
p.AnchorTE=AttributeOpt{2};
AttributeOpt={'Non','Hamming','Hanning'};
p.Apod=AttributeOpt{1};
p.CoilID=1;
p.DupSpacing=0;
p.Duplicates=1;
p.FA=180;
p.Notes='refocuse';
AttributeOpt={'on','off'};
p.Switch=AttributeOpt{1};
p.TBP=6;
p.dt=4e-6;
p.rfFreq=0;
p.rfPhase=0;
p.tEnd=CV3+VCtl.delta_TE*2+1e-3+CV4;
p.tStart=CV3+VCtl.delta_TE*2-1e-3+CV4;
if strcmp(p.Switch,'on')
if strcmp(p.AnchorTE,'on')
switch VCtl.TEAnchor
case 'Start'
VCtl.TEAnchorTime=p.tStart; 
case 'Middle'
VCtl.TEAnchorTime=(p.tStart+p.tEnd)/2; 
case 'End'
VCtl.TEAnchorTime=p.tEnd;
end
end
[rfAmp3,rfPhase3,rfFreq3,rfCoil3,rfTime3]=rfSinc(p);
if strcmp(VCtl.MultiTransmit,'off')
if VCtl.MasterTxCoil==rfCoil3(1)
rfAmp=[rfAmp rfAmp3];
rfPhase=[rfPhase rfPhase3];
rfFreq=[rfFreq rfFreq3];
rfCoil=[rfCoil rfCoil3];
rfTime=[rfTime rfTime3];
end
else
rfAmp=[rfAmp rfAmp3];
rfPhase=[rfPhase rfPhase3];
rfFreq=[rfFreq rfFreq3];
rfCoil=[rfCoil rfCoil3];
rfTime=[rfTime rfTime3];
end
end
p=[];
%--------------------
p.DupSpacing=0;
p.Duplicates=1;
p.Gz1Sign=1;
p.Gz2Sign=0;
p.Notes='cartesian phase';
AttributeOpt={'on','off'};
p.Switch=AttributeOpt{1};
p.t1End=CV2;
p.t1Start=CV1;
p.t2End=VCtl.TE+CV2;
p.t2Start=VCtl.TE+CV1;
p.tRamp=100e-6;
if strcmp(p.Switch,'on')
[GzAmp1,GzTime1]=GzCartesian(p);
GzAmp=[GzAmp GzAmp1];
GzTime=[GzTime GzTime1];
end
p=[];
%--------------------
p.Area=-1/1*VCtl.ResPhase/VCtl.EPI_ETL/VCtl.EPI_ShotNum/VCtl.RPhase;
p.DupSpacing=0;
p.Duplicates=1;
p.Notes=[];
AttributeOpt={'on','off'};
p.Switch=AttributeOpt{1};
p.grady_idx=1;
p.tStart=CV3+VCtl.delta_TE*0.5;
if strcmp(p.Switch,'on')
[GyAmp1,GyTime1]=GyAreaTrapezoid2_ran(p);
GyAmp=[GyAmp GyAmp1];
GyTime=[GyTime GyTime1];
end
p=[];
%--------------------
p.Area=-1/4*VCtl.ResPhase/VCtl.EPI_ETL/VCtl.EPI_ShotNum/VCtl.RPhase;
p.DupSpacing=0;
p.Duplicates=1;
p.Notes=[];
AttributeOpt={'on','off'};
p.Switch=AttributeOpt{1};
p.grady_idx=2;
p.tStart=CV3+VCtl.delta_TE*1.5;
if strcmp(p.Switch,'on')
[GyAmp2,GyTime2]=GyAreaTrapezoid2_ran(p);
GyAmp=[GyAmp GyAmp2];
GyTime=[GyTime GyTime2];
end
p=[];
%--------------------
p.Gy1Sign=0;
p.Gy2Sign=-1;
p.Notes=[];
AttributeOpt={'on','off'};
p.Switch=AttributeOpt{1};
p.t1Start=VCtl.TR;
p.t2Middle=CV5;
if strcmp(p.Switch,'on')
[GyAmp3,GyTime3]=GyEPI(p);
GyAmp=[GyAmp GyAmp3];
GyTime=[GyTime GyTime3];
end
p=[];
%--------------------
p.Area=-1.33*VCtl.ResPhase/VCtl.EPI_ETL/VCtl.EPI_ShotNum/VCtl.RPhase;
p.DupSpacing=0;
p.Duplicates=1;
p.Notes=[];
AttributeOpt={'on','off'};
p.Switch=AttributeOpt{2};
p.tEnd=CV3+VCtl.delta_TE*2-1e-3+CV4;
p.tStart=CV3+VCtl.delta_TE*2-1.8e-3+CV4;
if strcmp(p.Switch,'on')
[GyAmp4,GyTime4]=GyAreaTrapezoid(p);
GyAmp=[GyAmp GyAmp4];
GyTime=[GyTime GyTime4];
end
p=[];
%--------------------
p.Area=-1.33*VCtl.ResPhase/VCtl.EPI_ETL/VCtl.EPI_ShotNum/VCtl.RPhase;
p.DupSpacing=0;
p.Duplicates=1;
p.Notes=[];
AttributeOpt={'on','off'};
p.Switch=AttributeOpt{2};
p.tEnd=CV3+VCtl.delta_TE*2+1.8e-3+CV4;
p.tStart=CV3+VCtl.delta_TE*2+1e-3+CV4;
if strcmp(p.Switch,'on')
[GyAmp5,GyTime5]=GyAreaTrapezoid(p);
GyAmp=[GyAmp GyAmp5];
GyTime=[GyTime GyTime5];
end
p=[];
%--------------------
p.Area=-1/1*1/VCtl.RFreq;
p.DupSpacing=0;
p.Duplicates=1;
p.Notes=[];
AttributeOpt={'on','off'};
p.Switch=AttributeOpt{1};
p.gradx_idx=1;
p.tStart=CV3+VCtl.delta_TE*0.5;
if strcmp(p.Switch,'on')
[GxAmp1,GxTime1]=GxAreaTrapezoid2_ran(p);
GxAmp=[GxAmp GxAmp1];
GxTime=[GxTime GxTime1];
end
p=[];
%--------------------
p.Area=-1/4*1/VCtl.RFreq;
p.DupSpacing=0;
p.Duplicates=1;
p.Notes=[];
AttributeOpt={'on','off'};
p.Switch=AttributeOpt{1};
p.gradx_idx=2;
p.tStart=CV3+VCtl.delta_TE*1.5;
if strcmp(p.Switch,'on')
[GxAmp2,GxTime2]=GxAreaTrapezoid2_ran(p);
GxAmp=[GxAmp GxAmp2];
GxTime=[GxTime GxTime2];
end
p=[];
%--------------------
p.Gx1Sign=1;
p.Gx2Sign=-1;
p.Notes=[];
AttributeOpt={'on','off'};
p.Switch=AttributeOpt{1};
p.t1Start=VCtl.TR;
p.t2Middle=CV5;
if strcmp(p.Switch,'on')
[GxAmp3,GxTime3]=GxEPI(p);
GxAmp=[GxAmp GxAmp3];
GxTime=[GxTime GxTime3];
end
p=[];
%--------------------
p.Area=1.7*1/VCtl.RFreq;
p.DupSpacing=0;
p.Duplicates=1;
p.Notes=[];
AttributeOpt={'on','off'};
p.Switch=AttributeOpt{2};
p.tEnd=CV3+VCtl.delta_TE*2-1e-3+CV4;
p.tStart=CV3+VCtl.delta_TE*2-1.8e-3+CV4;
if strcmp(p.Switch,'on')
[GxAmp4,GxTime4]=GxAreaTrapezoid(p);
GxAmp=[GxAmp GxAmp4];
GxTime=[GxTime GxTime4];
end
p=[];
%--------------------
p.Area=1.7*1/VCtl.RFreq;
p.DupSpacing=0;
p.Duplicates=1;
p.Notes=[];
AttributeOpt={'on','off'};
p.Switch=AttributeOpt{2};
p.tEnd=CV3+VCtl.delta_TE*2+1.8e-3+CV4;
p.tStart=CV3+VCtl.delta_TE*2+1e-3+CV4;
if strcmp(p.Switch,'on')
[GxAmp5,GxTime5]=GxAreaTrapezoid(p);
GxAmp=[GxAmp GxAmp5];
GxTime=[GxTime GxTime5];
end
p=[];
%--------------------
p.Notes='EPI readout';
AttributeOpt={'on','off'};
p.Switch=AttributeOpt{1};
p.tMiddle=CV5;
if strcmp(p.Switch,'on')
[ADC1,ADCTime1]=ADCEPI(p);
ADC=[ADC ADC1];
ADCTime=[ADCTime ADCTime1];
end
p=[];
%--------------------
p.DupSpacing=0;
p.Duplicates=1;
p.Ext=1;
p.Notes='reset K space location';
AttributeOpt={'on','off'};
p.Switch=AttributeOpt{1};
p.tStart=CV1/3;
if strcmp(p.Switch,'on')
[Ext1,ExtTime1]=ExtBit(p);
Ext=[Ext Ext1];
ExtTime=[ExtTime ExtTime1];
end
p=[];
%--------------------
p.DupSpacing=0;
p.Duplicates=1;
p.Ext=5;
p.Notes='calculate remaining scan time';
AttributeOpt={'on','off'};
p.Switch=AttributeOpt{1};
p.tStart=0;
if strcmp(p.Switch,'on')
[Ext2,ExtTime2]=ExtBit(p);
Ext=[Ext Ext2];
ExtTime=[ExtTime ExtTime2];
end
p=[];
%--------------------
p.DupSpacing=7e-3;
p.Duplicates=12;
p.Ext=5;
p.Notes=[];
AttributeOpt={'on','off'};
p.Switch=AttributeOpt{1};
p.tStart=CV3+VCtl.delta_TE*2;
if strcmp(p.Switch,'on')
[Ext3,ExtTime3]=ExtBit(p);
Ext=[Ext Ext3];
ExtTime=[ExtTime ExtTime3];
end
p=[];
%--------------------
SEt=[tS tE];
rfAmp(rfTime<0 | rfTime>SEt(2)-SEt(1)) = [];
rfPhase(rfTime<0 | rfTime>SEt(2)-SEt(1)) = [];
rfFreq(rfTime<0 | rfTime>SEt(2)-SEt(1)) = [];
rfCoil(rfTime<0 | rfTime>SEt(2)-SEt(1)) = [];
GzAmp(GzTime<0 | GzTime>SEt(2)-SEt(1)) = [];
GyAmp(GyTime<0 | GyTime>SEt(2)-SEt(1)) = [];
GxAmp(GxTime<0 | GxTime>SEt(2)-SEt(1)) = [];
ADC(ADCTime<0 | ADCTime>SEt(2)-SEt(1)) = [];
Ext(ExtTime<0 | ExtTime>SEt(2)-SEt(1)) = [];
rfTime(rfTime<0 | rfTime>SEt(2)-SEt(1)) = [];
GzTime(GzTime<0 | GzTime>SEt(2)-SEt(1)) = [];
GyTime(GyTime<0 | GyTime>SEt(2)-SEt(1)) = [];
GxTime(GxTime<0 | GxTime>SEt(2)-SEt(1)) = [];
ADCTime(ADCTime<0 | ADCTime>SEt(2)-SEt(1)) = [];
ExtTime(ExtTime<0 | ExtTime>SEt(2)-SEt(1)) = [];
rfAmp(abs(rfAmp)<eps) = 0;
rfTime = rfTime + SEt(1);
GzTime = GzTime + SEt(1);
GyTime = GyTime + SEt(1);
GxTime = GxTime + SEt(1);
ADCTime = ADCTime + SEt(1);
ExtTime = ExtTime + SEt(1);
rfAmpAll=[rfAmpAll rfAmp];
rfPhaseAll=[rfPhaseAll rfPhase];
rfFreqAll=[rfFreqAll rfFreq];
rfCoilAll=[rfCoilAll rfCoil];
GzAmpAll=[GzAmpAll GzAmp];
GyAmpAll=[GyAmpAll GyAmp];
GxAmpAll=[GxAmpAll GxAmp];
ADCAll=[ADCAll ADC];
ExtAll=[ExtAll Ext];
rfTimeAll=[rfTimeAll rfTime];
GzTimeAll=[GzTimeAll GzTime];
GyTimeAll=[GyTimeAll GyTime];
GxTimeAll=[GxTimeAll GxTime];
ADCTimeAll=[ADCTimeAll ADCTime];
ExtTimeAll=[ExtTimeAll ExtTime];
SEtAll=[SEtAll SEt];
end
%====================================
if isempty(rfTimeAll)
error('rf sequence line can not be empty! Master Tx coil element must be used.');
end
if isempty(GzTimeAll)
error('GzSS sequence line can not be empty!');
end
if isempty(GyTimeAll)
error('GyPE sequence line can not be empty!');
end
if isempty(GxTimeAll)
error('GxR sequence line can not be empty!');
end
if isempty(ADCTimeAll)
error('ADC sequence line can not be empty!');
end
if isempty(ExtTimeAll)
error('Ext sequence line can not be empty!');
end
SEflag=repmat([0 0 0 0 0 0]',[1 2]);
rfflag=repmat([1 0 0 0 0 0]',[1 max(size(rfTimeAll))]);
Gzflag=repmat([0 1 0 0 0 0]',[1 max(size(GzTimeAll))]);
Gyflag=repmat([0 0 1 0 0 0]',[1 max(size(GyTimeAll))]);
Gxflag=repmat([0 0 0 1 0 0]',[1 max(size(GxTimeAll))]);
ADCflag=repmat([0 0 0 0 1 0]',[1 max(size(ADCTimeAll))]);
Extflag=repmat([0 0 0 0 0 1]',[1 max(size(ExtTimeAll))]);
ts=[[min(SEtAll) max(SEtAll)] rfTimeAll GzTimeAll GyTimeAll GxTimeAll ADCTimeAll ExtTimeAll]-min(SEtAll);
flags=[SEflag rfflag Gzflag Gyflag Gxflag ADCflag Extflag];
[ts,ind]=sort(ts);
uts=unique(ts);
flags=flags(:,ind);
[rfTime,ind]=sort(rfTimeAll-min(SEtAll));
rfAmp=rfAmpAll(:,ind);
rfPhase=rfPhaseAll(:,ind);
rfFreq=rfFreqAll(:,ind);
rfCoil=rfCoilAll(:,ind);
[GzTime,ind]=sort(GzTimeAll-min(SEtAll));
GzAmp=GzAmpAll(:,ind);
[GyTime,ind]=sort(GyTimeAll-min(SEtAll));
GyAmp=GyAmpAll(:,ind);
[GxTime,ind]=sort(GxTimeAll-min(SEtAll));
GxAmp=GxAmpAll(:,ind);
[ADCTime,ind]=sort(ADCTimeAll-min(SEtAll));
ADC=ADCAll(:,ind);
[ExtTime,ind]=sort(ExtTimeAll-min(SEtAll));
Ext=ExtAll(:,ind);
rfAmp(1) = 0;
rfPhase(1) = 0;
rfFreq(1) = 0;
GzAmp(1) = 0;
GyAmp(1) = 0;
GxAmp(1) = 0;
ADC(1) = 0;
Ext(1) = 0;
rfAmp(end) = 0;
rfPhase(end) = 0;
rfFreq(end) = 0;
GzAmp(end) = 0;
GyAmp(end) = 0;
GxAmp(end) = 0;
ADC(end) = 0;
Ext(end) = 0;
end
