function drawing = drawingMutate(oldDrawing)
%变异配置参数
AddPolygonMutationRate=70;
RemovePolygonMutationRate=150;
MovePolygonMutationRate = 70;
BrushMutationRate = 150;
MovePointMutationRate = 150;
%%
%cell元组
%变异
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
%drawing的内部细节变异：point，brush
for i=1:length(newDrawing)
    polygon=newDrawing{i};
    points=polygon{1};
    brush=polygon{2};
    points=polygonMutate(points);
    newDrawing{i}{1}=pointMutate(points);
    newDrawing{i}{2}=brushMutate(brush);
end
%%
%赋值
drawing=newDrawing;
end

%增加多边形
function addPolygon()
    global newDrawing;
    newPolygon=createPolygon();
    if isempty(newDrawing)
        newDrawing={newPolygon};
    else
        %可插入的位置数比多边形的个数多1
        number=getRandomNumber(length(newDrawing));
        newDrawing={newDrawing{1:number-1},newPolygon,newDrawing{number:length(newDrawing)}};
    end
end
%删除多边形
function removePolygon()
    global newDrawing;
    number=getRandomNumber(length(newDrawing));
    newDrawing={newDrawing{1:number-1},newDrawing{number+1:length(newDrawing)}};
end
%移动多边形
function movePolygon()
    removePolygon();
    addPolygon();
end
%创建多边形
function [newPolygon]=createPolygon()
    newPolygon=cell(1,1);
    newPolygon{1}=initPoint();
    newPolygon{2}=initBrush();
end
%多边形变异
function points = polygonMutate(old)
    points=old;
    %增加点
    if length(points)<10
        if willMutate(150)
            %p=addPoint();
            index=getRandomNumberBetween(2,length(points));
            %增加的点位于两点的中点
            pX=ceil((points(index-1,1)+points(index,1))/2);
            pY=ceil((points(index-1,2)+points(index,2))/2);
            points=[points(1:index-1,:);[pX,pY];points(index:end,:)];
        end
    end

    %减少点
    if length(points)>3
        if willMutate(150)
            index=getRandomNumber(length(points));
            points=[points(1:index-1,:);points(index+1:end,:)];
        end
    end

end
%创建Point
function [newPoint]=initPoint()
    %至少创建3个点Point
    newPoint=[addPoint();addPoint();addPoint()];
end
%增加Point
function [point] = addPoint()
    %单个Point是行向量
    point=[getRandomNumber(200),getRandomNumber(200)];
end
%画笔变异
function newPoint=pointMutate(old)
%     index=getRandomNumber(length(old));
%     newPoint=[old(1:index-1,:);addPoint();old(index+1:end,:)];
    newPoint=old;
    for i=1:length(newPoint)
        %大范围变动
        if willMutate(150)
            newPoint(i,:)=[getRandomNumber(200),getRandomNumber(200)];
        end
        %中等范围变动
        if willMutate(150)
            X=newPoint(i,1);
            Y=newPoint(i,2);
            X2=min(max(1,X+getRandomNumberBetween(-20,20)),200);
            Y2=min(max(1,Y+getRandomNumberBetween(-20,20)),200);
            newPoint(i,:)=[X2,Y2];
        end
        %小范围变动
        if willMutate(150)
            X=newPoint(i,1);
            Y=newPoint(i,2);
            X2=min(max(1,X+getRandomNumberBetween(-3,3)),200);
            Y2=min(max(1,Y+getRandomNumberBetween(-3,3)),200);
            newPoint(i,:)=[X2,Y2];
        end
    end
end
%创建画笔
function [newBrush]=initBrush()
    %行向量：RGBA
    newBrush=[getRandomNumber(255),getRandomNumber(255),getRandomNumber(255),rand()*0.2+0.76];
end
%画笔颜色发生变异
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

%是否发生变异
function [b] = willMutate(range)
    b=getRandomNumber(range)==1;
%     b=false;
%     if getRandomNumber(range)==1
%         b=true;
%     end
end
%产生1：range的随机整数
function [number]=getRandomNumber(range)
    number=ceil(rand()*range);
end
function [number]=getRandomNumberBetween(a,b)
    number=ceil(rand()*(b-a)+a);
end