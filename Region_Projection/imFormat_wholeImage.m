function stack_one = imFormat_wholeImage(filepath,slices)

file = dir([filepath '/*.tif']);


num = 1:slices;
I_temp = imread([filepath '/' file(1).name]);

stack_one = zeros(size(I_temp,1),size(I_temp,2),(slices));
for i = num
    I=imread([filepath '/' file(i).name]);
    stack_one(:,:,i) = I;
end

            
        
