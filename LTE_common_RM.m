function [data_out] = LTE_common_RM(data_in,code_type)
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
    5, 21, 13, 29, 3, 19, 11, 27, 7, 23, 15, 31]+1;

if (strcmp(code_type,'Turbo'))
    data_out = LTE_subblock_interleave(data_in); 
    data_out = rehsape(data_out.',1,[]); 
    if (1) %UL
        Ncb = length(data_out);
    else
        Ncb = min(floor(NIR/cbnum),length(data_out));
    end
    PhCH.Qm = PhCH.mod_size;
    if PhCH.layer_num == 1
        PhCH.NL = 1;
    else
        PhCH.NL = 2;
    end
    G1 = floor(PhCH.G/(PhCH.Qm*PhCH.NL));
    lamda = mod(G1,cbnum);
    for r = 1:cbnum
        if (r-1)<=(cb_num-lamda-1)
            E = PhCH.Qm*PhCH.NL*floor(G1/cbnum);
        else
            E = PhCH.Qm*PhCH.NL*ceil(G1/cbnum);
        end
        k0 = row_num*(2*ceil(Ncb/(8*row_num))*PhCH.rv_idx+2);
        for k = 1:E
            data_out(cb,k)=data_out(cb,mod(k0+j,Ncb)+1);
            j=j+1;
        end
    end
    data_out = reshape(data_out,1,[]);
end