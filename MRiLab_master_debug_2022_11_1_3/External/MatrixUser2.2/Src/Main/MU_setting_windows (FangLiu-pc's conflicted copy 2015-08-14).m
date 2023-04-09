% MatrixUser, a multi-dimensional matrix analysis software package
% https://sourceforge.net/projects/matrixuser/
% 
% The MatrixUser is a matrix analysis software package developed under Matlab
% Graphical User Interface Developing Environment (GUIDE). It features 
% functions that are designed and optimized for working with multi-dimensional
% matrix under Matlab. These functions typically includes functions for 
% multi-dimensional matrix display, matrix (image stack) analysis and matrix 
% processing.
%
% Author:
%   Fang Liu <leoliuf@gmail.com>
%   University of Wisconsin-Madison
%   Aug-30-2014



%windows for setting parameters
function MU_setting_windows(flag,h) 

Matrix_names = evalin('base', 'who');
TMatrix=h.TMatrix;
    
switch flag
    %% Voxel Stats Window
    case 1
        figure('Resize','off','position',[100 120 480 520],'Name','Voxel Statistics','MenuBar','none');
        Hist=axes('position',[.1  .5  .8  .40]);
        if isfield(h,'ROIData')
            TTMatrix=h.ROIData;
        else
            TTMatrix=TMatrix(:,:,h.V.Slice);
        end
        
        uicontrol('Style', 'text', 'String', 'Upper Bound','Position', [20  220  80  15]);
        uicontrol('Style', 'text', 'String', 'Lower Bound','Position', [20  190  80  15]); 
        B_upper_v=uicontrol('Style', 'text', 'String', '','Position', [360  220  80  15]);
        B_lower_v=uicontrol('Style', 'text', 'String', '','Position', [360  190  80  15]); 
        B_upper=uicontrol('Style', 'slider',...
                          'Position', [120  220  240  15],...
                          'Min',min(min(TTMatrix)),...
                          'Max',max(max(TTMatrix)),...
                          'Value',max(max(TTMatrix)));

        B_lower=uicontrol('Style', 'slider',...
                          'Position', [120  190  240  15],...
                          'Min',min(min(TTMatrix)),...
                          'Max',max(max(TTMatrix)),...
                          'Value',min(min(TTMatrix)));

        uicontrol('Style', 'text', 'String', 'Max value','Position', [20  160  80  15]);
        Max_v=uicontrol('Style', 'text', 'String', '','Position', [120  160  80  15]);
        uicontrol('Style', 'text', 'String', 'Min value','Position', [20  130  80  15]);
        Min_v=uicontrol('Style', 'text', 'String', '','Position', [120  130  80  15]);
        uicontrol('Style', 'text', 'String', 'Mean value','Position', [20  100  80  15]);
        Mean_v=uicontrol('Style', 'text', 'String', '','Position', [120  100  80  15],'ForegroundColor','g');
        uicontrol('Style', 'text', 'String', 'Median value','Position', [20  70  80  15]);
        Median_v=uicontrol('Style', 'text', 'String', '','Position', [120  70  80  15],'ForegroundColor','r');
        uicontrol('Style', 'text', 'String', 'Standard Dev.','Position', [20  40  80  15]);
        SD_v=uicontrol('Style', 'text', 'String', '','Position', [120  40  80  15]);
        uicontrol('Style', 'text', 'String', 'Skewness','Position', [260  160  80  15]); 
        Skewness_v=uicontrol('Style', 'text', 'String', '','Position', [360  160  80  15]);
        uicontrol('Style', 'text', 'String', 'Kurtosis','Position', [260  130  80  15]);
        Kurtosis_v=uicontrol('Style', 'text', 'String', '','Position', [360  130  80  15]);
        uicontrol('Style', 'text', 'String', '90th Perc.','Position', [260  100  80  15]); 
        Nin_v=uicontrol('Style', 'text', 'String', '','Position', [360  100  80  15],'ForegroundColor','c');
        uicontrol('Style', 'text', 'String', '10th Perc.','Position', [260  70  80  15]); 
        Ten_v=uicontrol('Style', 'text', 'String', '','Position', [360  70  80  15],'ForegroundColor','m');
        Include0_v=uicontrol('Style', 'text', 'String', '*Note: voxels with value of 0 are not included for statistical calculation!!!','Position', [100  9  350  15]); 
        Include0=uicontrol('Style', 'togglebutton', 'String', 'Include 0','Position', [20  5  80  25]); 
        Histfit_v=uicontrol('Style', 'text', 'String', 'Fit dist.','Position', [20  497  60  15]); 
        Histfit=uicontrol('Style', 'popup', 'String', {'NO',...
                                                       'beta',...
                                                       'birnbaumsaunders',...
                                                       'burr',...
                                                       'exponential',...
                                                       'extreme value',...
                                                       'gamma',...
                                                       'generalized extreme value',...
                                                       'generalized pareto',...
                                                       'inversegaussian',...
                                                       'logistic',...
                                                       'loglogistic',...
                                                       'lognormal',...
                                                       'nakagami',...
                                                       'negative binomial',...
                                                       'normal',...
                                                       'poisson',...
                                                       'rayleigh',...
                                                       'rician',...
                                                       'tlocationscale',...
                                                       'weibull',...
                                                       'kernel'}, 'Position', [80  500  120  15]); 
                                                   
        Bin_v=uicontrol('Style', 'text', 'String', 'Bin number (%)','Position', [220  497  80  15]); 
        Bin=uicontrol('Style', 'popup', 'String', {'10',...
                                                   '0.01',...
                                                   '0.1',...
                                                   '1',...
                                                   '50',...
                                                   '90'}, 'Position', [300  500  60  15]);
                                               
        Fittool=uicontrol('Style', 'pushbutton', 'String', 'FitTool','Position', [400  492  80  25]); 
        
        Hist_h=struct(...
                    'V',h.V,...
                    'Hist',Hist,...
                    'Histfit',Histfit,...
                    'Bin',Bin,...
                    'Fittool',Fittool,...
                    'B_upper',B_upper,...
                    'B_lower',B_lower,...
                    'Include0',Include0,...
                    'Include0_v',Include0_v,...
                    'B_upper_v',B_upper_v,...
                    'B_lower_v',B_lower_v,...
                    'Max_v',Max_v,...
                    'Min_v',Min_v,...
                    'Mean_v',Mean_v,...
                    'Median_v',Median_v,...
                    'SD_v',SD_v,...
                    'Skewness_v',Skewness_v,...
                    'Kurtosis_v',Kurtosis_v,...
                    'Nin_v',Nin_v,...
                    'Ten_v',Ten_v);

        set(B_upper,'Callback',{@MU_dispHist,TTMatrix,Hist_h});
        set(B_lower,'Callback',{@MU_dispHist,TTMatrix,Hist_h});
        set(Include0,'Callback',{@MU_dispHist,TTMatrix,Hist_h});
        set(Histfit,'Callback',{@MU_dispHist,TTMatrix,Hist_h});
        set(Bin,'Callback',{@MU_dispHist,TTMatrix,Hist_h});
        set(Fittool,'Callback',{@MU_dispHist,TTMatrix,Hist_h});
        MU_dispHist([],[],TTMatrix,Hist_h);
    %% Set Montage Window
    case 2
        Cre_Mont=figure('Resize','off','position',[100 120 280 200],'Name','Creating Montage','MenuBar','none');

        uicontrol('Style', 'text', 'String', 'Chosen Slices','Position', [20  160  100  15]);
        uicontrol('Style', 'text', 'String', 'Montage Layout','Position', [20  80  100  15]);

        uicontrol('Style', 'text', 'String', 'Slice starts from','Position', [60  140  120  15]);
        Sli_from=uicontrol('Style', 'edit', 'String', '1','Position', [180  140  70  15]);
        uicontrol('Style', 'text', 'String', 'Slice ends to','Position', [60  120  120  15]);
        Sli_to=uicontrol('Style', 'edit', 'String', num2str(h.V.Layer),'Position', [180  120  70  15]);

        uicontrol('Style', 'text', 'String', 'Number of row','Position', [60  60  120  15]);
        Mont_row=uicontrol('Style', 'edit', 'String', '3','Position', [180  60  70  15]);
        uicontrol('Style', 'text', 'String', 'Number of column','Position', [60  40  120  15]);
        Mont_col=uicontrol('Style', 'edit', 'String', '4','Position', [180  40  70  15]);

        Mont_h=struct(...
                    'V',h.V,...
                    'Cre_Mont',Cre_Mont,...
                    'Sli_from',Sli_from,...
                    'Sli_to',Sli_to,...
                    'Mont_row',Mont_row,...
                    'Mont_col',Mont_col...
                     );

        uicontrol('Style', 'Pushbutton', 'String', 'Create Montage',...
                  'Position', [40  10  120  25],... 
                  'Callback',{@MU_dispMontage,TMatrix,Mont_h});
    %% Set Resolution Window
    case 3
        Set_Res=figure('Resize','off','position',[100 120 280 160],'Name','Change Resolution','MenuBar','none');
        
        uicontrol('Style', 'text', 'String', 'X-Resolution Factor :','Position', [40  130  120  15]);
        uicontrol('Style', 'text', 'String', 'Y-Resolution Factor :','Position', [40  100  120  15]);
        uicontrol('Style', 'text', 'String', 'Z-Resolution Factor :','Position', [40  70  120  15]);
        uicontrol('Style', 'text', 'String', 'Interpolation Method :','Position', [40  42  120  15]);
        Method=uicontrol('Style', 'popupmenu', 'String', {'linear';'nearest';'cubic'},'Position', [160  45  80  15]);
        Xf_v=uicontrol('Style', 'edit', 'String', '1','Position', [160  130  80  15]);
        Yf_v=uicontrol('Style', 'edit', 'String', '1','Position', [160  100  80  15]);
        Zf_v=uicontrol('Style', 'edit', 'String', '1','Position', [160  70  80  15]);
        Res=uicontrol('Style', 'pushbutton', 'String', 'Change Resolution','Position', [40  10  120  25]);

        Res_h=struct(...
                     'Set_Res', Set_Res,...
                     'main_h', h, ...
                     'Method', Method,...
                     'Xf_v', Xf_v,...
                     'Yf_v', Yf_v,...
                     'Zf_v', Zf_v ...
                     );
        set(Res,'Callback',{@MU_changeRes,Res_h});
    %% Upload Temporary Matrix (old method)
    case 4
        Upload_Tmp=figure('Resize','off','position',[100 120 340 100],'Name','Append Current Temporary Matrix','MenuBar','none');
        uicontrol('Style', 'text', 'String', 'Matrix Name :','Position', [60  60  80  20]);
        Matrix_name=uicontrol('Style', 'edit', 'String', [h.V.Current_matrix '_2'],'Position', [150  60  160  20]);
        
        Upload_h=struct(...
                      'main_h',h,...
                      'Matrix_name',Matrix_name,...
                      'Upload_Tmp',Upload_Tmp ...
                      );
        
        uicontrol('Style', 'pushbutton', 'String', 'Append','Position', [60  20  80  25],...
                  'Callback',{@MU_uploadTmp,Upload_h});
    %% Manual Lesion Segmentation
    case 5
    %% Image fusion
    case 6
        Img_Fuse=figure('Resize','off','position',[100 120 300 380],'Name',['Image superimposed to ' h.V.Current_matrix],'MenuBar','none');
        uicontrol('Style', 'text', 'String', 'Back Fraction','Position', [10  100  80  15]);
        uicontrol('Style', 'text', 'String', 'Fore Fraction','Position', [10  70  80  15]); 
        uicontrol('Style', 'text', 'String', 'Fore Upper','Position', [10  40  80  15]); 
        uicontrol('Style', 'text', 'String', 'Fore Lower','Position', [10  10  80  15]); 
        uicontrol('Style', 'text', 'String', 'Fore Colormap','Position', [10  130  80  15]); 
        coloraxis=axes('Position', [0.85  0.43  0.4  0.5],'Visible','off'); 
        Matrix_list=uicontrol('Style', 'listbox', 'String', '','Position', [10  160  220  200]);
        [tr,tc,tl,tt]=size(TMatrix); % Foregound need to have the same dimension as that of backgroud;
        ind=1;
        for i=1:max(size(Matrix_names))
            [r,c,l]=evalin('base', ['size(' Matrix_names{i} ');']);
            if sum(([tr tc tl]-[r c l]).^2)==0 & evalin('base', ['isreal(' Matrix_names{i} ');'])
                Allowed_Foreground{ind}=Matrix_names{i};
                ind=ind+1;
            end
        end
        if ind==1
            close(Img_Fuse);
            errordlg('No matrix can be fused with current matrix!');
            return;
        end
        set(Matrix_list,'String',Allowed_Foreground);
        BF_v=uicontrol('Style', 'text', 'String', '','Position', [240  100  60  15]);
        FF_v=uicontrol('Style', 'text', 'String', '','Position', [240  70  60  15]); 
        F_u=uicontrol('Style', 'text', 'String', '','Position', [240  40  60  15]); 
        F_l=uicontrol('Style', 'text', 'String', '','Position', [240  10  60  15]); 
        BF=uicontrol('Style', 'slider','Position', [100  100  130  15]);
        FF=uicontrol('Style', 'slider','Position', [100  70  130  15]);
        Fu=uicontrol('Style', 'slider','Position', [100  40  130  15]);
        Fl=uicontrol('Style', 'slider','Position', [100  10  130  15]);
        Include0=uicontrol('Style', 'togglebutton', 'String', 'Exclude 0','Position', [210  122  80  25]);               
        Colormap=uicontrol('Style', 'popupmenu', 'String', {'Jet';...
                                                            'Hot';...
                                                            'HSV';...
                                                            'Cool';...
                                                            'Spring';...
                                                            'Summer';...
                                                            'Autumn';...
                                                            'Winter';...
                                                            'Bone';...
                                                            'Copper';...
                                                            'Pink';...
                                                            'Lines'},...
                                                            'Position', [100  130  100  15]);
        
        colorbar('location','WestOutside');
       
          Fuse_h=struct(...
                        'Img_Fuse',Img_Fuse,...
                        'main_h',h,...
                        'Matrix_list',Matrix_list,...
                        'BF',BF,...
                        'FF',FF,...
                        'Fu',Fu,...
                        'Fl',Fl,...
                        'BF_v',BF_v,...
                        'FF_v',FF_v,...
                        'F_u',F_u,...
                        'F_l',F_l,...
                        'Colormap',Colormap,...
                        'Include0',Include0,...
                        'coloraxis',coloraxis);

        set(BF,'Callback',{@MU_imgFuse,Fuse_h,Allowed_Foreground},'Enable','off');
        set(FF,'Callback',{@MU_imgFuse,Fuse_h,Allowed_Foreground},'Enable','off');
        set(Fu,'Callback',{@MU_imgFuse,Fuse_h,Allowed_Foreground},'Enable','off');
        set(Fl,'Callback',{@MU_imgFuse,Fuse_h,Allowed_Foreground},'Enable','off');
        set(Colormap,'Callback',{@MU_imgFuse,Fuse_h,Allowed_Foreground},'Enable','off');
        set(Include0,'Callback',{@MU_imgFuse,Fuse_h,Allowed_Foreground},'Enable','off');
        set(Matrix_list,'Callback',{@MU_selimgFuse,Fuse_h,Allowed_Foreground});
        
end


end