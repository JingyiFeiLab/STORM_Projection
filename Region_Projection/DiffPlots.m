% Which cell to plot
cell_plot = 32;
cell_width = 6;
cell_length = 10;


X = 256;
Y = 256;

for i = length(spot_struct):-1:1
    
    
    if isempty(spot_struct(i).Distance2Center)
        spot_struct(i) = [];
    end
    
end

x = [];
y = [];
diff = [];


for j = 1:length(spot_struct) 
    if spot_struct(j).Cell == cell_plot && spot_struct(j).DiffusionCoefficient > .01
        x(j) = spot_struct(j).Transform_3D_Coordinate(1);
        y(j) = spot_struct(j).Transform_3D_Coordinate(2);
        diff(j) = spot_struct(j).DiffusionCoefficient;
    end
end


x2 = 0:.01:2*pi;
x3 = cell_width*cos(x2);
y3 = cell_length*sin(x2);

figure(1)
scatter(y,x,100,log(diff),'filled');colormap jet; colorbar;
hold on
scatter(y3,x3,'k')