clc;
clear;
sourceImg=imread('ml.bmp');
currentFigure=[0,0,0];
currentDrawing={};
preFitness=double(8*10^9);
isRunning=true;

newDrawing={};
generation=0;
selected=0;

% 导入上次保存的状态
%load;

while isRunning
    newDrawing = drawingMutate(currentDrawing);
    %运行占时间的代码,开始大概为20-30ms,到后面越来越长，可以上百
    currentImage=drawImg(newDrawing);
    
    fitness = calculateFitness(currentImage,sourceImg);
    generation=generation+1;
    
    if fitness<preFitness
        currentDrawing=newDrawing;
        preFitness=fitness;
        selected=selected+1;
        disp(['generation:',int2str(generation),';selected:',int2str(selected)]);
    end

end


