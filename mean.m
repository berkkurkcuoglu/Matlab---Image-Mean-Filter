I = imread('Cameraman.tif');
%figure('Name','Original','NumberTitle','off'),imshow(I);
fSize = 15; % filter size -> 3 5 9 15
padding = (fSize-1)/2; %padding size

iPad = zeros(size(I) + padding*2); % image with padding

%copying original image to the new image with padding

for x=1:size(I,1)
    for y=1:size(I,2)
        iPad(x+padding,y+padding) = I(x,y);
    end
end

%applying mean filter to the image
newI = zeros(size(I));

for k=1:size(I,1)
    for l=1:size(I,2)
        sum=0;
        for x=1:fSize
            for y=1:fSize                
                sum = sum + iPad(k+x-1,l+y-1);
            end
        end        
        newI(k,l) = sum/(fSize*fSize);
    end
end

newI = uint8(newI);
figure('Name','Blurred Image','NumberTitle','off'),imshow(newI);

%subtracting blurred image from the original
subI = zeros(size(I));

for x=1:size(I,1)
    for y=1:size(I,2)
        subI(x,y) = I(x,y) - newI(x,y);
    end
end

subI = uint8(subI);
figure('Name','Subtracted Image','NumberTitle','off'),imshow(subI);

%shifting image up by 1 pixel
shftI = zeros(size(I));

for x=1:size(I,1)-1
    for y=1:size(I,2)     
        shftI(x,y) = I(x+1,y);
    end
end

shftI = uint8(shftI);
figure('Name','Image Shifted Up by 1','NumberTitle','off'),imshow(shftI);

%shifting image up by 5 pixels
shftI5 = zeros(size(I));

for x=1:size(I,1)-5
    for y=1:size(I,2)      
        shftI5(x,y) = I(x+5,y);
    end
end

shftI5 = uint8(shftI5);
figure('Name','Image Shifted Up by 5','NumberTitle','off'),imshow(shftI5);

%sharpening the image

shrpI = zeros(size(I));

for x=1:size(I,1)
    for y=1:size(I,2)
        shrpI(x,y) = I(x,y) + subI(x,y);%adding image the subtracted values --> (Image + (Image - Filter))
    end
end


shrpI = uint8(shrpI);
figure('Name','Sharpened Image','NumberTitle','off'),imshow(shrpI)



