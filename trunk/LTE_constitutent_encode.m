function [data_out,terminate_bit] = LTE_constitutent_encode(data_in)
% LTE_common_cbsegmnt - Code block segmentation and code block CRC attachment.
% DEFINED IN PROTOCOL 3GPP TS 36.212
% [data_out,cbnum] = LTE_common_cbsegmnt(data_in)
% Author: Liang Ruan
% (c) 2009 by LTE-LLS
% http://lte-lls.googlecode.com
%
% input :   data_in       ... [1 x # coded bits]0/1 - coded bits from CRC
% output:   data_out      ... [1 x cbnum cell] 
%           cbnum         ... code block number
%
% date of creation: 20011/06/19
% last changes: 

state = zeros(1,3);
for k = 1:length(data_in)
    data_out(k) = mod(data_in(k)+state(1)+state(2)+2*state(3),2);
    temp = state(3);
    state(3) = state(2);
    state(2) = state(1);
    state(1) = mod(data_in(k)+state(2)+temp,2);
end

terminate_bit(1,:) = state;
for k = 1:3
    terminate_bit(2,:) = mod(state(1)+state(2)+2*state(3),2);
    temp = state(3);
    state(3) = state(2);
    state(2) = state(1);
    state(1) = mod(state(2)+temp,2);
end