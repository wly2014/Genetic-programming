function [ IMG3 ] = imageadd( old,add )
% -----------------------------------------------------------------------
% ALPHA_PARAM:0��ʾ��ȫ��͸����1��ʾ��ȫ͸��
% old,add����������Ϊdouble
% -----------------------------------------------------------------------

IMG2_4=add(:,:,4);
ALPHA=cat(3,IMG2_4,IMG2_4,IMG2_4);
IMG3=old(:,:,1:3).*ALPHA+add(:,:,1:3).*(1-ALPHA);
IMG3(:,:,4) = 0.0;

end