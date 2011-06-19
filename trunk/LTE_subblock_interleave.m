function [data_out] = LTE_subblock_interleave(data_in,code_type)
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

global LTE_permut_pattern;
LTE_permut_pattern = [0, 16, 8, 24, 4, 20, 12, 28, 2, 18, 10, 26, 6, 22, 14, 30, 1, 17, 9, 25, 
    5, 21, 13, 29, 3, 19, 11, 27, 7, 23, 15, 31];

D = size(data_in,2);
column_num = 32;
row_num = ceil(D/column_num);
K = row_num*column_num;
for ii = 1:size(data_in,1)
    data_temp{ii} = zeros(1,K);
    data_temp{ii}(K-D:end) = data_in(ii,:);
    data_temp{ii} = reshape(data_temp,column_num,[]);
    data_temp{ii} = data_temp{ii}.';
    if ii == 3
        data_temp{ii} = reshape(data_temp.',1,[]);
        for k = 1:K
            tmp = mod(LTE_permut_pattern(floor((k-1)/row_num)+1)+column_num*mod(k-1,row_num)+1,K)+1;
            data_out(ii,k) = data_temp{ii}.(tmp);
        end
    else
        data_temp{ii} = data_temp{ii}(:,LTE_permut_pattern+1);
        data_out(ii,:) = reshape(data_temp{ii}.',1,[]);
    end
end