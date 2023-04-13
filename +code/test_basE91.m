
str_code = 'xD7ghoHB,R<x]xFl]Uh+H?B1r%6t7P_oGBX2@[oC710#zP`o~FZ2v)N1$FDvLm8j&2=C|/UC:Iiq9MAS`[;C4iuM8FGvC99j1af+q/RTgS2ua9jL,X_1/W"@s!WzqxjLxo>v6WueqU!0,mlLJS=Cq/UCHRK)<P2ii5=C/^_0rR1tL^;mIEZ2Q[fz7Ilx<PUouJ(gp@wCHRWz9McR)_=v6WfB?JE?lNVQ';
str_org = 'Base91 encoding splits data into 13-bit binary packets (ie 2 ^ 13 = 8192 values) which are then encoded in 2 letters of the alphabet (which contains 91 characters and 91 ^ 2 = 8281).';
%profile on
if isempty(o)
	o = basE91();
else
	if ~isa(o,"basE91")
		o = basE91();
	else
		if ~isvalid(o)
			o = basE91();
		end
	end
end
tic
data_code = o.encode(uint8(str_org));
toc
tic
data = char(o.decode(data_code));
toc
tic
data2 = char(o.decode(str_code));
toc
%profile off
%profile viewer
disp(str_org);
disp(data);
disp(data2);

