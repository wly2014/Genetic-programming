function drawing = drawingMutate(oldDrawing)
%�������ò���
AddPolygonMutationRate=70;
RemovePolygonMutationRate=150;
MovePolygonMutationRate = 70;
BrushMutationRate = 150;
MovePointMutationRate = 150;
%%
%cellԪ��
%����
global newDrawing;
newDrawing=oldDrawing;

if willMutate(AddPolygonMutationRate)
    addPolygon();
end
if willMutate(RemovePolygonMutationRate)
    removePolygon();
end
if willMutate(MovePolygonMutationRate)
    movePolygon();
end
%drawing���ڲ�ϸ�ڱ��죺point��brush
for i=1:length(newDrawing)
    polygon=newDrawing{i};
    points=polygon{1};
    brush=polygon{2};
    points=polygonMutate(points);
    newDrawing{i}{1}=pointMutate(points);
    newDrawing{i}{2}=brushMutate(brush);
end
%%
%��ֵ
drawing=newDrawing;
end

%���Ӷ����
function addPolygon()
    global newDrawing;
    newPolygon=createPolygon();
    if isempty(newDrawing)
        newDrawing={newPolygon};
    else
        %�ɲ����λ�����ȶ���εĸ�����1
        number=getRandomNumber(length(newDrawing));
        newDrawing={newDrawing{1:number-1},newPolygon,newDrawing{number:length(newDrawing)}};
    end
end
%ɾ�������
function removePolygon()
    global newDrawing;
    number=getRandomNumber(length(newDrawing));
    newDrawing={newDrawing{1:number-1},newDrawing{number+1:length(newDrawing)}};
end
%�ƶ������
function movePolygon()
    removePolygon();
    addPolygon();
end
%���������
function [newPolygon]=createPolygon()
    newPolygon=cell(1,1);
    newPolygon{1}=initPoint();
    newPolygon{2}=initBrush();
end
%����α���
function points = polygonMutate(old)
    points=old;
    %���ӵ�
    if length(points)<10
        if willMutate(150)
            %p=addPoint();
            index=getRandomNumberBetween(2,length(points));
            %���ӵĵ�λ��������е�
            pX=ceil((points(index-1,1)+points(index,1))/2);
            pY=ceil((points(index-1,2)+points(index,2))/2);
            points=[points(1:index-1,:);[pX,pY];points(index:end,:)];
        end
    end

    %���ٵ�
    if length(points)>3
        if willMutate(150)
            index=getRandomNumber(length(points));
            points=[points(1:index-1,:);points(index+1:end,:)];
        end
    end

end
%����Point
function [newPoint]=initPoint()
    %���ٴ���3����Point
    newPoint=[addPoint();addPoint();addPoint()];
end
%����Point
function [point] = addPoint()
    %����Point��������
    point=[getRandomNumber(200),getRandomNumber(200)];
end
%���ʱ���
function newPoint=pointMutate(old)
%     index=getRandomNumber(length(old));
%     newPoint=[old(1:index-1,:);addPoint();old(index+1:end,:)];
    newPoint=old;
    for i=1:length(newPoint)
        %��Χ�䶯
        if willMutate(150)
            newPoint(i,:)=[getRandomNumber(200),getRandomNumber(200)];
        end
        %�еȷ�Χ�䶯
        if willMutate(150)
            X=newPoint(i,1);
            Y=newPoint(i,2);
            X2=min(max(1,X+getRandomNumberBetween(-20,20)),200);
            Y2=min(max(1,Y+getRandomNumberBetween(-20,20)),200);
            newPoint(i,:)=[X2,Y2];
        end
        %С��Χ�䶯
        if willMutate(150)
            X=newPoint(i,1);
            Y=newPoint(i,2);
            X2=min(max(1,X+getRandomNumberBetween(-3,3)),200);
            Y2=min(max(1,Y+getRandomNumberBetween(-3,3)),200);
            newPoint(i,:)=[X2,Y2];
        end
    end
end
%��������
function [newBrush]=initBrush()
    %��������RGBA
    newBrush=[getRandomNumber(255),getRandomNumber(255),getRandomNumber(255),rand()*0.2+0.76];
end
%������ɫ��������
function newBrush = brushMutate(old)
    R=old(1);
    G=old(2);
    B=old(3);
    A=old(4);
    if willMutate(150)
        R=getRandomNumber(255);
    end
    if willMutate(150)
        G=getRandomNumber(255);
    end
    if willMutate(150)
        B=getRandomNumber(255);
    end
    if willMutate(150)
        %[0.76 0.96]
        A=rand()*0.2+0.76;
    end
    newBrush=[R,G,B,A];
end

%�Ƿ�������
function [b] = willMutate(range)
    b=getRandomNumber(range)==1;
%     b=false;
%     if getRandomNumber(range)==1
%         b=true;
%     end
end
%����1��range���������
function [number]=getRandomNumber(range)
    number=ceil(rand()*range);
end
function [number]=getRandomNumberBetween(a,b)
    number=ceil(rand()*(b-a)+a);
end