function data_out = LTE_cb_concatenation(data_in)
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