function [ px,py ] = getLine( x1,y1,x2,y2 )
% -------------------------------------------------------------------------
% 返回画线的坐标
% -------------------------------------------------------------------------

dy=y2-y1;
dx=x2-x1;

if abs(dx)>abs(dy)
    k=dy/dx;
    if x1<x2
        px=x1:1:x2;
    else
        px=x1:-1:x2;
    end
    py=round((px-x1)*k+y1);
else
    k=dx/dy;
    if y1<y2
        py=y1:1:y2;
    else
        py=y1:-1:y2;
    end
    px=round((py-y1)*k+x1);
    %当两点重合时
    if dy==0&dx==0
        px=[];
        py=[];
        return;
    end
end

end

