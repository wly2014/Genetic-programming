function [ fitness ] = calculateFitness( currentImage,sourceImg )

fitness=sum(sum(sum((double(currentImage(:,:,1:3)-double(sourceImg))).^2)));

end