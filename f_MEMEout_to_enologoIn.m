function [] = f_MEMEout_to_enologoIn(fin, path_out)
% Convert formatted MEME output motif file to enologo input files. 
% fin: input file name (MEME output file)
% path_out: target dir for enologo input files.

% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.
% Zhen Gao 2017 (c)

fid_in = fopen(fin, 'r');
%fid_out = fopen(fout, 'wt');
while ~feof(fid_in)
    l = fgetl(fid_in);
    % compare with the line 'MOTIF  2	width =   11   sites =  14   llr = 172   E-value = 2.1e-006'
    if length(l) >= 68
        if strcmp(l(1, 10:19), 'width =   ')
            fprintf('%s\n',l);
            %fprintf(fid_out, '%s\n', l(1:8));
            %fprintf(fid_out, '%s\n', l(10:end));
        end
    end
end
%fprintf(fid_out,'\n\n');

fclose(fid_in);

% search the motif PWMs
fid_in = fopen(fin, 'r');
j=1;
while ~feof(fid_in)
    
    
    l = fgetl(fid_in);
    % compare with the string '	Motif 2 position-specific probability matrix'
    %	Motif 10 position-specific probability matrix
    %	Motif 2 position-specific probability matrix
    if length(l) >= 45
        if ~isempty(strfind(l, 'position-specific probability matrix'))
        %if strcmp(l(1, 10:45), 'position-specific probability matrix')
            fprintf('%s\n',l);
            
            %fprintf(fid_out, '\n%s\n\n\n',l);
            fout = [path_out, int2str(j), '.txt'];
            fid_out = fopen(fout, 'wt');
            
            
            fprintf(fid_out, 'PO A C G T\n',l);
            
            fgetl(fid_in);
            l = fgetl(fid_in);
            % read the PWM length within this string
            % 'letter-probability matrix: alength= 4 w= 11 nsites= 14 E= 2.1e-006' 
            strw = l(1, 42:43);
            len = strread(strw, '%d');
            
            for i=1:len
                l = fgetl(fid_in);
                fprintf(fid_out, '%d %s\n',i, l);
            end
            fprintf(fid_out, '\n');

            
            fclose(fid_out);
            j=j+1;
        end
    end
end



fclose(fid_in);

end

%MOTIF  1	width =   12   sites =  29   llr = 303   E-value = 1.4e-012
%	Motif 1 position-specific probability matrix
%letter-probability matrix: alength= 4 w= 9 nsites= 141 E= 2.1e-032 
