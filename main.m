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

% �����ϴα����״̬
%load;

while isRunning
    newDrawing = drawingMutate(currentDrawing);
    %����ռʱ��Ĵ���,��ʼ���Ϊ20-30ms,������Խ��Խ���������ϰ�
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


