function [new_cell_mask,area,ellipticity,center] = post_track_mask(mask,dapi_mask)

pix_size = .130;
field2 = 'Objects'; % All Objects, single and multi, labeled
field3 = 'Center';
field4 = 'Area';
field5 = 'Ellipticity';
field6 = 'Cell_Labels';
field7 = 'Probability';
field8 = 'Mask'; % Single Cell Selections
field9 = 'All'; % All Objects, single and multi

part2 = struct(field2, [], field3, [], field4, [], field5, [], field6, [], field7, [], field8, [], field9, []); %Table for Part 2

objects2 = bwlabel(mask);

num = max(objects2(:));
clear centers area ellipticity



for i = 1:num
    
clear centers area ellipticity


area=zeros(num,1);

for i=1:num
    area(i) = cellArea(objects2,i,pix_size);
end

centers=zeros(max(objects2(:)),2);

for i=1:num
    centers(i,:) = cellCenter(objects2,i);
end

ellipticity = zeros(num,4);

% Re-done Ellipticity Calculation
for i=1:num
    ellipticity(i,:) = cellEllipseSPT(objects2,i);
end


new_cell_mask = objects2;
area = area;
ellipticity = ellipticity;
center = centers;
end