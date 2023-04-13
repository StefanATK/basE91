classdef basE91 < handle
	%% basE91
	% basE91 class, encode or decode base91 text or data streams
	%   use the encode or decode methods

	properties (Access=private)
		enctab char
		dectab int8
		isMexFilE logical
	end
	
	methods
		%% basE91 constructor
		% create the internal encoding and decoding table
		function obj=basE91()
			% Create the internal encoding and decoding table.
			% output value:
			%   obj - this object
			if nargout==0
				delete(obj);
				nargoutchk(1,1);
			end
			ts = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,./:;<=>?@[]^_`{|}~""";
	
			obj.enctab = ts.char;
			obj.dectab = ones(1,256,"int8")*-1;
			
			for i = 0:90
				obj.dectab(uint8(obj.enctab(i+1))) = uint8(i);
			end

			obj.isMexFilE = isfile("bE91.mexw64");
		end
		%% encode data stream
		% ob = encode(obj, ib)
		function ob = encode(obj, ib)
			% ENCODE Encode data stream.
			% input values:
			%   obj - this object
			%   ib  - input data array; type: uint8, char, string
			% output value:
			%   ob  - output coded array; type: char

			if ~isa(ib,"uint8") && ~ischar(ib) && ~isstring(ib)
				error("Error input ib must be a uint8 data vector or a char array or a string!")
			end
			if ischar(ib)
				ib = uint8(ib);
			elseif isstring(ib)
				ib = uint8(char(ib));
			end
			if obj.isMexFilE
				ob = bE91('bE91encode',ib,obj.enctab);
			else
				ob = bE91encode(ib, obj.enctab);
			end
			
		end
		%% decode String and convert to "type"
		% ob = decode(obj,ib)
		function ob = decode(obj,ib,type)
			% DECODE Decode String and convert to a valid type.
			% input values:
			%   obj  - this object
			%   ib   - input data array; type: char, string
			%   type - output matlab datatype; type; char, string
			%          valid output types: uint8, char, string
			% output value:
			%   ob   - output coded array; type: valid type
			if ~isstring(ib)&& ~ischar(ib)
				error("Error input ib must be a string or a char array!")
			end
			if isstring(ib)
				ib = char(ib);
			end
			try
				if obj.isMexFilE
					ob = bE91('bE91decode',ib,obj.dectab);
				else
					ob = bE91decode(ib,obj.dectab);
				end
				if nargin >=3
					if isstring(type)
						switch type
							case "char"
								ob = char(ob);
							case "string"
								ob = string(char(ob));
							case "uint8"
							otherwise
								warning("Output must be uint8, char or string! Output will not converted!");
						end
					end
				end
			catch err
				rethrow(err);
			end
		end
	end
end