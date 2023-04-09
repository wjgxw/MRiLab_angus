%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MRiLab auto generated file: DO NOT EDIT!     %
% Generated by MRiLab "DoWriteXML2m" Generator %
% MRiLab Version 1.3                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [t, ind, Disp, Axis, Ang]=Mot_ShiftHead
%====================================
p.Direction=[1;1;0];
p.Displacement='1*t';
p.dt=5e-4;
p.tEnd=100e-3;
p.tStart=5e-3;
[tt, Dispt, Axist, Angt]=MotTranslate(p);
t=tt;
ind=ones(1,length(tt));
Disp=Dispt;
Axis=Axist;
Ang=Angt;
p=[];
%--------------------
p.Direction=[0;1;0];
p.Displacement='0*sin(0.1*(t-200))';
p.dt=1;
p.tEnd=400;
p.tStart=200;
[tt, Dispt, Axist, Angt]=MotTranslate(p);
if isempty(Dispt) & ~isempty(Disp);
Disp=[Disp, zeros(3,length(tt))];
elseif ~isempty(Dispt) & isempty(Disp);
Disp=[zeros(3,length(t)), Dispt];
else Disp=[Disp, Dispt]; end;
if isempty(Axist) & ~isempty(Axis);
Axis=[Axis, Axis(:,end)*ones(1,length(tt))];
elseif ~isempty(Axist) & isempty(Axis);
Axis=[Axist(:,1)*ones(1,length(t)), Axist];
else Axis=[Axis, Axist]; end;
if isempty(Angt) & ~isempty(Ang);
Ang=[Ang, Ang(:,end)*ones(1,length(tt))];
elseif ~isempty(Angt) & isempty(Ang);
Ang=[zeros(1,length(t)), Angt];
else Ang=[Ang, Angt]; end;
t=[t, tt];
ind=[ind, 2 * ones(1,length(tt))];
p=[];
%--------------------
end