%Output structure has one entry for each mRNA. Each entry contains the
%frames, location, and corresponding GFP intensity of that mRNA. After
%running this, you can run "suntag_scatter.m" without changing anything to
%generate images of mRNA spots over GFP images. You can also run
%"sunTag_Intensity.m" without any changes to generate the intensity graphs
%for each mRNA

%Set filepath to folder containing .tif stack
filepath = '/Users/reyer/Documents/MATLAB/SOURCE_CODES/sample_images_matt/Matt_Microscope/May_31_2018_D6_P1_F10_RT';

% Don't Change any of these
channels = 1;
ref_channel = 1;
ref_slice = 16;
dim = 2;
slices2D = 15;
pixelscaling = .130;
window = 5; % Size of mRNA tracking window for GFP projection


% Direct to .txt file with mRNA tracking results
mRNA_file = '/Users/reyer/Documents/MATLAB/SOURCE_CODES/sample_images_matt/Matt_Microscope/May_31_2018_D6_P1_F10_RT/sample1.txt';
particles = textread(mRNA_file);

x=particles(:,1);                          % Select the column containing X coordinates in Pixel form
y=particles(:,2);                          % Select the column containing Y coordinates in Pixel form
spot_frame=particles(:,4);                 % Frame of mRNA Spot
SpotID=particles(:,5);                     % mRNA Spot ID

[~,~,stack_one,~,~,~,~,slices] = imFormat(filepath,ref_channel,dim,ref_slice,slices2D,channels);
[X,Y] = size(stack_one(:,:,ref_slice));

x_coord = int32(x);
y_coord = int32(y);
x_coord(x_coord<1) = 1;
y_coord(y_coord<1) = 1;
x_coord(x_coord>=X) = X;
y_coord(y_coord>=Y) = Y;

num_mRNAs = max(SpotID);

field1 = 'mRNA'; % All Objects, single and multi, labeled
field2 = 'Center';
field3 = 'Frames';
field4 = 'GFP_Intensity';

mRNA_struct = struct(field1,[],field2, [], field3, [], field4, []);

for i = 1:num_mRNAs
    mRNA_struct(i).mRNA = i;
    temp_mRNA = particles(particles(:,5)==i,:);
    mRNA_struct(i).Center = [temp_mRNA(:,1),temp_mRNA(:,2)];
    frames = temp_mRNA(:,4)+1;
    mRNA_struct(i).Frames = frames;
    gs = 10-window;
    gfp_int_array = zeros(gs^2,length(frames));
    final_gfp_int_array = zeros(1,length(frames));
    for j = 1:length(frames)
        temp_x = int32(temp_mRNA(j,1));
        temp_y = int32(temp_mRNA(j,2));
        center_x_array = temp_x-floor(gs/2):temp_x+floor(gs/2);
        center_y_array = temp_y-floor(gs/2):temp_y+floor(gs/2);
        q = 0;
        for m = 1:gs
            for n = 1:gs
                q = q + 1;
                center_x = center_x_array(m);
                center_y = center_y_array(n);
                temp_x_array = center_x-floor(window/2):center_x+floor(window/2);
                temp_y_array = center_y-floor(window/2):center_y+floor(window/2);
                gfp_int = zeros(25,5,5);
                for k = 1:window
                    for l = 1:window
                        gfp_int(k,l) = stack_one(temp_x_array(k),temp_y_array(l),frames(j));
                    end
                end
                gfp_int_array(q,j) = sum(gfp_int(:));
            end
        end
        final_gfp_int_array(j) = max(gfp_int_array(:,j));
    end
    mRNA_struct(i).GFP_Intensity = final_gfp_int_array';
end
                
    
    
    












