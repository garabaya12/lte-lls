function data_out = LTE_common_CRC(data_in, crc_type)
% LTE_common_CRC - CRC caculation.
% DEFINED IN PROTOCOL 3GPP TS 36.212
% [data_out] = LTE_common_scrambling(data_in)
% Author: Liang Ruan
% (c) 2009 by LTE-LLS
% http://lte-lls.googlecode.com
%
% input :   data_in       ... [1 x # coded bits]0/1 - coded bits from TB
%           crc_type      ... [1 x 1]string CRC type - 'crc16', 'crc24A' or 'crc_24B' 
% output:   s             ... [1 x # coded bits+crc_len]0/1 - coded bits + CRC
%
% date of creation: 20011/06/19
% last changes: 

switch crc_type
    case 'crc16'
        gen_poly = zeros(1,17);
        gen_poly([1 6 13 17]) = ones(1,4);
    case 'crc24A'
        gen_poly = zeros(1,25);
        gen_poly([1:2 4:8 11 12 15 18 19 24 25]) = ones(1,14);
    case 'crc24B'
        gen_poly = zeros(1,25);
        gen_poly([1:2 6:7 24:25]) = ones(1,6);
end

data_len = length(data_in);
crc_len = length(gen_poly)-1;
data_out = zeros(1,data_len+crc_len);
data_out(1:data_len) = data_in;
shft = data_in(1:crc_len+1);
for ii = crc_len+2:data_len+crc_len
    temp = shft(1).*gen_poly;
    temp = mod(temp+gen_poly,2);
    temp = [temp(2:end) data_out(ii)];
end
data_crc = mod(temp+gen_poly,2);
data_out = [data_in data_crc];
