function [ poly3 ] = drawPolygon( polygon )
% -------------------------------------------------------------------------
% polygon:cell
% {[x,y;x,y;...];[R,G,B,A]}
% -------------------------------------------------------------------------
polyMat=zeros(200,200);

points=polygon{1};
brush=polygon{2};
indexed=[];
for x=1:length(points)
    if x == length(points)
        [px,py]=getLine(points(x,1),points(x,2),points(1,1),points(1,2));
    else
        [px,py]=getLine(points(x,1),points(x,2),points(x+1,1),points(x+1,2));
    end
    % ���Ż�
    indexed=[indexed,(py-1)*200+px];
%     polyMat=concat(polyMat,line);
end
%��������
polyMat(indexed)=1;
%���
polyMat = imfill(polyMat);
%onesĬ��Ϊdouble����,���ǵ�alpha�е�1Ϊȫ͸��
poly3=ones([size(polyMat),4]);
% �������
pIndex=find(polyMat==1);

poly3(pIndex)=brush(1);
poly3(pIndex+40000)=brush(2);
poly3(pIndex+40000*2)=brush(3);
poly3(pIndex+40000*3)=brush(4);

end