function distance2edge = Distance2Edge(edge,point)

% INPUT : edge1 = edge pixels of interest (in cell array)
%         edge2 = edge pixels of test ellipse (also in cell array)
%
% OUTPUT : error = sum of squared distances between edge1 pixels and
%                  nearest edge2 pixel


pix = length(edge{1,1});
distances = zeros(pix,1);

for i = 1:pix
    
    distances(i) = distance(edge{1,1}(i,:),point);
    
end

distance2edge = min(distances);

end