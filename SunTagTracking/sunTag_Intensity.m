parentDir = '/Users/reyer/Data/SunTag_Tracking/'; %This and line below define
newFile = 'May_31_2018_D6_P1_F10_RT';             % where you want to save the images. Create a new folder
graph_title = 'GFP Intensity for mRNA ';
sample = 'sample1_5by5/mRNA/'; % Will save images in defined folder, sub-folder called "/mRNA"

compareDir = strcat([parentDir,newFile]);
sampleDir = strcat([compareDir,'/',sample]);
if exist(compareDir,'dir')~=7
    mkdir(parentDir, newFile)
end

if exist(sampleDir,'dir')~=7
    mkdir(compareDir, sample)
end


    
for i = 1:num_mRNAs
    frames = mRNA_struct(i).Frames;
    gfp = mRNA_struct(i).GFP_Intensity;
    
    figure(1)
    plot(frames,gfp)
    title(strcat([graph_title,num2str(i)]),'FontSize',32)
    xlabel('Frame','FontSize',24)
    xt = get(gca, 'XTick');
    set(gca, 'FontSize', 18)
    ax = gca;
    ax.YLim = [0 517893];
    ylabel('GFP Intensity','FontSize',24)
    set(gcf,'position',[835,883,868,667])
    file1 = strcat([sampleDir,'/mRNA',num2str(i)]);
    set(gcf,'PaperPositionMode','auto')
    print(file1,'-painters','-depsc','-r0')
    set(gcf,'PaperPositionMode','auto')
    print(file1,'-dpng','-r0')
    file1_fig = strcat([sampleDir,'mRNA',num2str(i),'.fig']);
    savefig(gcf,file1_fig)
    close all
    
end
