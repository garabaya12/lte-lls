function [data_out] = LTE_turbo_interleave(data_in)
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

global LTE_turbo_intl_table;

K = length(data_in);
for ii = 1:188
    if (K==LTE_turbo_intl_table(ii,1)
        break;
    end
end
f1 = LTE_turbo_intl_table(ii,2);
f2 = LTE_turbo_intl_table(ii,3);

for ii = 1:K
    intl(ii) = mod(f1*(ii-1)+f2*(ii-1)^2,K)+1;
    data_out(ii) = data_in(intl(ii));
end
