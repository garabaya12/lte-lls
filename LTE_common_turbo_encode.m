function [data_out] = LTE_common_turbo_encode(data_in)
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

[d1 terminate_bit] = LTE_constitutent_encode(data_in);
data_intl = LTE_turbo_interleave(data_in);
[d2 terminate_bit(3:4,:)] = LTE_constitutent_encode(data_intl);

d0 = [data_in terminate_bit(1,1) terminate_bit(2,2) terminate_bit(3,1) terminate_bit(4,2)];
d1 = [d1 terminate_bit(2,1) terminate_bit(1,3) terminate_bit(4,1) terminate_bit(3,3)];
d2 = [d2 terminate_bit(1,2) terminate_bit(2,3) terminate_bit(3,2) terminate_bit(4,3)];
data_out = [d0;d1;d2];