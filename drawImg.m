function [ image ] = drawImg( currentDrawing )
% image=ones(200,200,3)*255;
% image(:,:,4)=0;
image=zeros(200,200,4);
for index=1:length(currentDrawing)
    polygon=currentDrawing{index};
    poly=drawPolygon(polygon);
    image=imageadd(image,poly);
end

end

