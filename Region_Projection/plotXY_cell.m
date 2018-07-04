cell_id = 20; %Which cell to plot

cell_center_x = [];
cell_center_y = [];
percent_off_center = .1; % How Far off center axis (in percent of cell width) is allowed for spots

for si = 1:length(cell_struct(cell_id).Spots(:,1))
    off_center = abs(cell_struct(cell_id).Spots(si,2));
    if off_center/cell_struct(cell_id).Cell_X_Axis < percent_off_center*cell_struct(cell_id).Cell_X_Axis
        cell_center_x = [cell_center_x cell_struct(cell_id).Spots(si,2)];
        cell_center_y = [cell_center_y cell_struct(cell_id).Spots(si,3)];
    end
end

figure(2);scatter(cell_center_x,cell_center_y,100,'filled');grid on
title(strcat(['Cell ' num2str(cell_id) ' YX Spot Projection']),'FontSize',24)
ylabel('Long Axis (Y)','FontSize',24)
xlabel('Short Axis (X)','FontSize',24)
        