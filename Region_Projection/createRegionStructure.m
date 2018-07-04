% Creates a new structure called "cell_region_struct" found in workspace

clear cell_region_struct
field1 = 'Cell'; % All Objects, single and multi, labeled
field2 = 'Total_Spots';
field3 = 'Pole_Spots';
field4 = 'Membrane_Spots';
field5 = 'Middle_Spots';
field6 = 'Cytoplasm_Spots';

cell_region_struct = struct(field1,[],field2, [], field3, [], field4, [],field5, [],field6, []);

pole_definition = .05;

for ri = 1:length(cell_struct)
    cell_region_struct(ri).Cell = ri;
    cell_region_struct(ri).Total_Spots = cell_struct(ri).Num_Spots;
    pole = 0;
    membrane = 0;
    middle = 0;
    cytoplasm = 0;
    
    if size(cell_struct(ri).Spots) == [0,0];
        
        continue
    end
    
    for sri = 1:length(cell_struct(ri).Spots(:,1))
        from_pole = abs(cell_struct(ri).Spots(sri,3));
        if (.5*cell_struct(ri).Cell_Y_Axis-from_pole)/(.5*cell_struct(ri).Cell_Y_Axis) < pole_definition
            pole = pole+1;
            continue
        elseif cell_struct(ri).Spots(sri,5) == 1
            membrane = membrane + 1;
            continue
        elseif cell_struct(ri).Spots(sri,5) == 2 || cell_struct(ri).Spots(sri,5) == 3
            cytoplasm = cytoplasm + 1;
            continue
        elseif cell_struct(ri).Spots(sri,5) == 4
            middle = middle + 1;
            continue
        end
    end
         
    cell_region_struct(ri).Pole_Spots = pole;
    cell_region_struct(ri).Membrane_Spots = membrane;
    cell_region_struct(ri).Middle_Spots = middle;
    cell_region_struct(ri).Cytoplasm_Spots = cytoplasm;
    
end
    

