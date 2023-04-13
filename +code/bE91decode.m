%% bE91decode function
%
function ob = bE91decode(ib, dectab_in)
	% bE91decode Base91 decoding function
	% % input values:
	%   ib        - input data array; type: char
	%   dectab_in - decoder table; type 1x256 int8 array
	% output value:
	%   ob        - output decoded array; type: char
	ob = zeros(1,0,"uint8");
	if ~isempty(ib) && ~isempty(dectab_in)
		ob = zeros(1,length(ib),"uint8");
		co = uint64(1);
		n = length(ib);
		ldbq = int32(0);
		ldn = int32(0);
		ldv = int32(-1);
		for i = 0:n-1
			val = uint8(ib(i+1));
			tval = dectab_in(val);
			tval = int32(tval);
			if (tval == -1)
				continue;
			end
			if (ldv == -1)
				ldv = tval;
			else
				ldv = ldv + tval *91;
				ldbq = bitor(ldbq, bitshift(ldv,ldn));
				if bitand(ldv, 8191) > 88
					ldn = ldn + 13;
				else
					ldn = ldn + 14;
				end
				while true
					ob(co) = uint8(bitand(ldbq,255));
					co=co+1;
					ldbq = bitshift(ldbq, -8);
					ldn = ldn - 8;
					if ~(ldn > 7)
						break
					end
				end
				ldv = int32(-1);
				end
		end
		
		if (ldv ~= -1)
			ob(co) = uint8(bitor(ldbq, bitshift(ldv, ldn)));
			co=co+1;
		end
		ob = ob(1:co-1);
	end
end

