%% bE91encode function
%
function ob = bE91encode(ib, enctab_in)
	% bE91decode Base91 encoding function
	% % input values:
	%   ib        - input data array; type: uint8
	%   enctab_in - encoder table; type 1x91 char array
	% output value:
	%   ob        - output encoded array; type: char
	ob = char(zeros(1,0,"uint8"));
	if ~isempty(ib) && ~isempty(enctab_in)
		co = int32(1);
		ci = int32(1);
		n = int32(length(ib));
		en = int32(0);
		ebq = int32(0);
		ob = char(zeros(1,2*n,'uint8'));
		for i = (0:n-1)
			val = int32(ib(i+1));
			ci=ci+1;
			vals = (bitshift(val,en));
			ebq = bitor(ebq,vals);
			en = en+8;
			if en > 13
				ev = int32(bitand(ebq, 8191));

				if ev > 88
					ebq = bitshift(ebq,-13);
					en = en -13;
				else
					ev = bitand(ebq, 16383);
					ebq = bitshift(ebq,-14);
					en = en -14;
				end
				ob(co) = enctab_in(mod(ev,91)+1);
				co=co+1;
				ob(co) = enctab_in(idivide(ev,91)+1);
				co=co+1;
			end
		end
		if en > 0
			ob(co) = enctab_in(mod(ebq,91)+1);
			co=co+1;
			if (en > 7 || ebq > 90)
				ob(co) = enctab_in(idivide(ebq,91)+1);
				co=co+1;
			end
		end
		ob = ob(1:co-1);
	end
end